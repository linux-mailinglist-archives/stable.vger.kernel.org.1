Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BAF7A3867
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbjIQTf2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239770AbjIQTfD (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:35:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75338D9
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:34:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD3BC433C9;
        Sun, 17 Sep 2023 19:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979298;
        bh=k106QJsspmkvP4FnuT2MhKjz5O5CzuZFs/mVoGkTpSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d0291dlyKvSpiPKVJhIix5eyREWIZ6GDnQIx26K/KcFTT5TluznilqJKDBclWMWFw
         jtzumFjM8A4VSPpl5SxfCaqnr1Mw+muSVBrynHeDtzpYDrVDohgOvu5Ef9Wb1Wdtye
         mtFCGCuKCHkxWcronoPVTyr22rx5NpDvkKPIt5D4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lucas Leong <wmliang@infosec.exchange>,
        Wander Lairson Costa <wander@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.10 271/406] netfilter: xt_sctp: validate the flag_info count
Date:   Sun, 17 Sep 2023 21:12:05 +0200
Message-ID: <20230917191108.406514963@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wander Lairson Costa <wander@redhat.com>

commit e99476497687ef9e850748fe6d232264f30bc8f9 upstream.

sctp_mt_check doesn't validate the flag_count field. An attacker can
take advantage of that to trigger a OOB read and leak memory
information.

Add the field validation in the checkentry function.

Fixes: 2e4e6a17af35 ("[NETFILTER] x_tables: Abstraction layer for {ip,ip6,arp}_tables")
Cc: stable@vger.kernel.org
Reported-by: Lucas Leong <wmliang@infosec.exchange>
Signed-off-by: Wander Lairson Costa <wander@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/xt_sctp.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/netfilter/xt_sctp.c
+++ b/net/netfilter/xt_sctp.c
@@ -150,6 +150,8 @@ static int sctp_mt_check(const struct xt
 {
 	const struct xt_sctp_info *info = par->matchinfo;
 
+	if (info->flag_count > ARRAY_SIZE(info->flag_info))
+		return -EINVAL;
 	if (info->flags & ~XT_SCTP_VALID_FLAGS)
 		return -EINVAL;
 	if (info->invflags & ~XT_SCTP_VALID_FLAGS)


