Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFCB7353FD
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjFSKvH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjFSKu3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:50:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2045B100
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:49:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0093660B42
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DF4C433C0;
        Mon, 19 Jun 2023 10:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171795;
        bh=mnzDoWwqmj6k4sThyiJG8xkxCbaWNdLgsP7OiDkgujQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HMYpLyhAXRd7a3Gyeh2z2Tcnvao27pY1irPf2l0hHEd+9UibcxdKROP4+lE87+J3R
         2hhmCdBZHqVmAXybPP+LjK7/gTEPa+gGvwDWAOF9nYILuz6uuC30PEU+iAZJNSIRcv
         p3xdOH8lpb3jHs58kcH/Kw1aucXAeAJjuB+aaJy8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hangbin Liu <liuhangbin@gmail.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 159/166] Revert "net/sched: act_api: move TCA_EXT_WARN_MSG to the correct hierarchy"
Date:   Mon, 19 Jun 2023 12:30:36 +0200
Message-ID: <20230619102202.408396181@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hangbin Liu <liuhangbin@gmail.com>

commit 8de2bd02439eb839a452a853c1004c2c45ff6fef upstream.

This reverts commit 923b2e30dc9cd05931da0f64e2e23d040865c035.

This is not a correct fix as TCA_EXT_WARN_MSG is not a hierarchy to
TCA_ACT_TAB. I didn't notice the TC actions use different enum when adding
TCA_EXT_WARN_MSG. To fix the difference I will add a new WARN enum in
TCA_ROOT_MAX as Jamal suggested.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/act_api.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1603,12 +1603,12 @@ static int tca_get_fill(struct sk_buff *
 	if (tcf_action_dump(skb, actions, bind, ref, false) < 0)
 		goto out_nlmsg_trim;
 
+	nla_nest_end(skb, nest);
+
 	if (extack && extack->_msg &&
 	    nla_put_string(skb, TCA_EXT_WARN_MSG, extack->_msg))
 		goto out_nlmsg_trim;
 
-	nla_nest_end(skb, nest);
-
 	nlh->nlmsg_len = skb_tail_pointer(skb) - b;
 
 	return skb->len;


