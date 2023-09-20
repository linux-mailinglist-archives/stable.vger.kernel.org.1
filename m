Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36F97A7E29
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235506AbjITMPx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbjITMPv (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:15:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B46D9
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:15:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DFCC433C7;
        Wed, 20 Sep 2023 12:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212144;
        bh=m6K0EzBgiSs/iTyzXO/L/xU59J0DaiiG9IzmcUEAu4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iOfLpvk4dRXn356WLG0wf7A/D8qAsdVGyyzfjh1q1Jni7IB9MKXyYLSq5Cb/2ufXl
         mKDvA1iBgLUO6iQAirJUrblMqKSUEXGsXlbZ8O8fJMURJZ5VWU++LIWRHbAuZvIs9M
         DFuOHCc/sIfFhejjQKkwzrurra+7ozZQ9Ins1L2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lucas Leong <wmliang@infosec.exchange>,
        Wander Lairson Costa <wander@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 168/273] netfilter: xt_sctp: validate the flag_info count
Date:   Wed, 20 Sep 2023 13:30:08 +0200
Message-ID: <20230920112851.713220716@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -149,6 +149,8 @@ static int sctp_mt_check(const struct xt
 {
 	const struct xt_sctp_info *info = par->matchinfo;
 
+	if (info->flag_count > ARRAY_SIZE(info->flag_info))
+		return -EINVAL;
 	if (info->flags & ~XT_SCTP_VALID_FLAGS)
 		return -EINVAL;
 	if (info->invflags & ~XT_SCTP_VALID_FLAGS)


