Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6A17353FE
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjFSKvI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjFSKu3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:50:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D45E1BEA
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:49:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E8CF6068B
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B69B2C433C0;
        Mon, 19 Jun 2023 10:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171798;
        bh=4hFPkMwLMS+CCfxOLCvle9E8immgMl2eTXItmkHxd6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t1B3Aum1s5jCRZGEdV7WnTfoSHr9hWnAvpMiHxuy/5Fb5mc2WM0mHNN9Rnu+6yYhe
         h3cRBg6uwxcUUya8Tt1SGdykkv54hrjRDGBVbg//MC4ltbnOxrt5f9sFlzALGrHr0s
         WyZ+s63EXNWy19HwXEVI2ANQUaI16O3GP/n2DrQs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hangbin Liu <liuhangbin@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 160/166] net/sched: act_api: add specific EXT_WARN_MSG for tc action
Date:   Mon, 19 Jun 2023 12:30:37 +0200
Message-ID: <20230619102202.450369193@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

commit 2f59823fe696caa844249a90bb3f9aeda69cfe5c upstream.

In my previous commit 0349b8779cc9 ("sched: add new attr TCA_EXT_WARN_MSG
to report tc extact message") I didn't notice the tc action use different
enum with filter. So we can't use TCA_EXT_WARN_MSG directly for tc action.
Let's add a TCA_ROOT_EXT_WARN_MSG for tc action specifically and put this
param before going to the TCA_ACT_TAB nest.

Fixes: 0349b8779cc9 ("sched: add new attr TCA_EXT_WARN_MSG to report tc extact message")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/rtnetlink.h |    1 +
 net/sched/act_api.c            |    8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -789,6 +789,7 @@ enum {
 	TCA_ROOT_FLAGS,
 	TCA_ROOT_COUNT,
 	TCA_ROOT_TIME_DELTA, /* in msecs */
+	TCA_ROOT_EXT_WARN_MSG,
 	__TCA_ROOT_MAX,
 #define	TCA_ROOT_MAX (__TCA_ROOT_MAX - 1)
 };
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1596,6 +1596,10 @@ static int tca_get_fill(struct sk_buff *
 	t->tca__pad1 = 0;
 	t->tca__pad2 = 0;
 
+	if (extack && extack->_msg &&
+	    nla_put_string(skb, TCA_ROOT_EXT_WARN_MSG, extack->_msg))
+		goto out_nlmsg_trim;
+
 	nest = nla_nest_start_noflag(skb, TCA_ACT_TAB);
 	if (!nest)
 		goto out_nlmsg_trim;
@@ -1605,10 +1609,6 @@ static int tca_get_fill(struct sk_buff *
 
 	nla_nest_end(skb, nest);
 
-	if (extack && extack->_msg &&
-	    nla_put_string(skb, TCA_EXT_WARN_MSG, extack->_msg))
-		goto out_nlmsg_trim;
-
 	nlh->nlmsg_len = skb_tail_pointer(skb) - b;
 
 	return skb->len;


