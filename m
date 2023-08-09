Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F94775D17
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbjHILdo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbjHILdn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:33:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AD81BFA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:33:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCC8063465
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB09BC433C8;
        Wed,  9 Aug 2023 11:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580822;
        bh=UD0Kl1gOzaS+GIp1COMgsFqNPgGWy7Fcg5SXJTzNLu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l+1qbG1j4Hz/1CucjDnSB707QjioTI8KbdH22n7peCcIbdYEoDo79NrJzPMdH3p+a
         sSyxO23wn5rv8rwEPDvcKpkON75NPhpcbiH0dupkJy7OF7WHwN3nplMQDMoqmPRgem
         zJZPsVoujOsIQ26rvVU49XI41qL/elXZVI3w4ijA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 5.4 152/154] driver code: print symbolic error code
Date:   Wed,  9 Aug 2023 12:43:03 +0200
Message-ID: <20230809103641.868019930@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

commit 693a8e936590f93451e6f5a3d748616f5a59c80b upstream.

dev_err_probe() prepends the message with an error code. Let's make it
more readable by translating the code to a more recognisable symbol.

Fixes: a787e5400a1c ("driver core: add device probe log helper")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Link: https://lore.kernel.org/r/ea3f973e4708919573026fdce52c264db147626d.1598630856.git.mirq-linux@rere.qmqm.pl
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3431,9 +3431,9 @@ int dev_err_probe(const struct device *d
 	vaf.va = &args;
 
 	if (err != -EPROBE_DEFER)
-		dev_err(dev, "error %d: %pV", err, &vaf);
+		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
 	else
-		dev_dbg(dev, "error %d: %pV", err, &vaf);
+		dev_dbg(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
 
 	va_end(args);
 


