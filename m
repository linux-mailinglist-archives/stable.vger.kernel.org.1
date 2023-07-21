Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C491075D4D0
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjGUTZR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjGUTZQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:25:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A02930EA
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F226261D5C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E77C433C7;
        Fri, 21 Jul 2023 19:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689967509;
        bh=4paonCGlFmwAmcd2Gbw+B7Sh+9p1KSU3Dliwo25peEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y7LX+z2oZPBJD9LolWPWEaDYVRqOjDNH3obbKHCL7+UHRy/9CWLpUdWI5plwoaMs4
         VOLEJyEbw8h3IxmxcuDkId5NFjsH4G8b2eV0nm4Ar3wMslcdncmYPOr2IAexwrnjzK
         fccIDCeAypc2anf5OM6UJQfeJonQ4OEh2IzzAHAk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Viresh Kumar <viresh.kumar@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH 6.1 170/223] opp: Fix use-after-free in lazy_opp_tables after probe deferral
Date:   Fri, 21 Jul 2023 18:07:03 +0200
Message-ID: <20230721160528.128113251@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160520.865493356@linuxfoundation.org>
References: <20230721160520.865493356@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Stephan Gerhold <stephan.gerhold@kernkonzept.com>

commit b2a2ab039bd58f51355e33d7d3fc64605d7f870d upstream.

When dev_pm_opp_of_find_icc_paths() in _allocate_opp_table() returns
-EPROBE_DEFER, the opp_table is freed again, to wait until all the
interconnect paths are available.

However, if the OPP table is using required-opps then it may already
have been added to the global lazy_opp_tables list. The error path
does not remove the opp_table from the list again.

This can cause crashes later when the provider of the required-opps
is added, since we will iterate over OPP tables that have already been
freed. E.g.:

  Unable to handle kernel NULL pointer dereference when read
  CPU: 0 PID: 7 Comm: kworker/0:0 Not tainted 6.4.0-rc3
  PC is at _of_add_opp_table_v2 (include/linux/of.h:949
  drivers/opp/of.c:98 drivers/opp/of.c:344 drivers/opp/of.c:404
  drivers/opp/of.c:1032) -> lazy_link_required_opp_table()

Fix this by calling _of_clear_opp_table() to remove the opp_table from
the list and clear other allocated resources. While at it, also add the
missing mutex_destroy() calls in the error path.

Cc: stable@vger.kernel.org
Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
Fixes: 7eba0c7641b0 ("opp: Allow lazy-linking of required-opps")
Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/opp/core.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1348,7 +1348,10 @@ static struct opp_table *_allocate_opp_t
 	return opp_table;
 
 remove_opp_dev:
+	_of_clear_opp_table(opp_table);
 	_remove_opp_dev(opp_dev, opp_table);
+	mutex_destroy(&opp_table->genpd_virt_dev_lock);
+	mutex_destroy(&opp_table->lock);
 err:
 	kfree(opp_table);
 	return ERR_PTR(ret);


