Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738F170C775
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbjEVT34 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbjEVT3v (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:29:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89471A4
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:29:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9899628EB
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BC2C433EF;
        Mon, 22 May 2023 19:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783782;
        bh=e3DlYdMN5nOnkMxi/UlFn0nyDlahxCLf6yyQE3Zp/gE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=knU6K7+LXfnJm0NBx+zvZTSsHoLvVzkTm6HsCN3/4Lnl1F2vLlqhB8XlDp6tBYZKN
         tvOrIXQKvCZ5rFrXDyn51wp5FJGcS2BUhuGb0XW0ZPp2O/YNVLUj8yQCTuLDXWWU8H
         esT1GwhyQuaNw0lCSkOcw9f/lEhIoInuCtQfsuzU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tobias Brunner <tobias@strongswan.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 161/292] xfrm: Reject optional tunnel/BEET mode templates in outbound policies
Date:   Mon, 22 May 2023 20:08:38 +0100
Message-Id: <20230522190409.990216052@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Tobias Brunner <tobias@strongswan.org>

[ Upstream commit 3d776e31c841ba2f69895d2255a49320bec7cea6 ]

xfrm_state_find() uses `encap_family` of the current template with
the passed local and remote addresses to find a matching state.
If an optional tunnel or BEET mode template is skipped in a mixed-family
scenario, there could be a mismatch causing an out-of-bounds read as
the addresses were not replaced to match the family of the next template.

While there are theoretical use cases for optional templates in outbound
policies, the only practical one is to skip IPComp states in inbound
policies if uncompressed packets are received that are handled by an
implicitly created IPIP state instead.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Tobias Brunner <tobias@strongswan.org>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_user.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 83f35ecacf24f..2d68a173b2273 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1743,7 +1743,7 @@ static void copy_templates(struct xfrm_policy *xp, struct xfrm_user_tmpl *ut,
 }
 
 static int validate_tmpl(int nr, struct xfrm_user_tmpl *ut, u16 family,
-			 struct netlink_ext_ack *extack)
+			 int dir, struct netlink_ext_ack *extack)
 {
 	u16 prev_family;
 	int i;
@@ -1769,6 +1769,10 @@ static int validate_tmpl(int nr, struct xfrm_user_tmpl *ut, u16 family,
 		switch (ut[i].mode) {
 		case XFRM_MODE_TUNNEL:
 		case XFRM_MODE_BEET:
+			if (ut[i].optional && dir == XFRM_POLICY_OUT) {
+				NL_SET_ERR_MSG(extack, "Mode in optional template not allowed in outbound policy");
+				return -EINVAL;
+			}
 			break;
 		default:
 			if (ut[i].family != prev_family) {
@@ -1806,7 +1810,7 @@ static int validate_tmpl(int nr, struct xfrm_user_tmpl *ut, u16 family,
 }
 
 static int copy_from_user_tmpl(struct xfrm_policy *pol, struct nlattr **attrs,
-			       struct netlink_ext_ack *extack)
+			       int dir, struct netlink_ext_ack *extack)
 {
 	struct nlattr *rt = attrs[XFRMA_TMPL];
 
@@ -1817,7 +1821,7 @@ static int copy_from_user_tmpl(struct xfrm_policy *pol, struct nlattr **attrs,
 		int nr = nla_len(rt) / sizeof(*utmpl);
 		int err;
 
-		err = validate_tmpl(nr, utmpl, pol->family, extack);
+		err = validate_tmpl(nr, utmpl, pol->family, dir, extack);
 		if (err)
 			return err;
 
@@ -1894,7 +1898,7 @@ static struct xfrm_policy *xfrm_policy_construct(struct net *net,
 	if (err)
 		goto error;
 
-	if (!(err = copy_from_user_tmpl(xp, attrs, extack)))
+	if (!(err = copy_from_user_tmpl(xp, attrs, p->dir, extack)))
 		err = copy_from_user_sec_ctx(xp, attrs);
 	if (err)
 		goto error;
@@ -3443,7 +3447,7 @@ static struct xfrm_policy *xfrm_compile_policy(struct sock *sk, int opt,
 		return NULL;
 
 	nr = ((len - sizeof(*p)) / sizeof(*ut));
-	if (validate_tmpl(nr, ut, p->sel.family, NULL))
+	if (validate_tmpl(nr, ut, p->sel.family, p->dir, NULL))
 		return NULL;
 
 	if (p->dir > XFRM_POLICY_OUT)
-- 
2.39.2



