Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344BB73E7D0
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjFZSTP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjFZSTN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:19:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D008CC
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:19:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A63B560F39
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:19:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF03EC433C9;
        Mon, 26 Jun 2023 18:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803551;
        bh=lOfkq2W/1Zmj3DtxsmhBZI+VgxP3FTC27/ZfUqUclMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZmuMjZ5ee+JOe/penihsWc/tKecJxNj1rOfvFGp2h2RHoV3ryKmpxiB16S6eVpI08
         PTtt1HavoaQdKuT0YCnoD109cA3DoTIhzOG3u/fTkr954XgAHAbfPfC9L+l5P0VKIb
         vTdyqerWljV1dEWZMaR/ueyKMjVRj0i2/weuMYxo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benedict Wong <benedictwong@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 100/199] xfrm: Treat already-verified secpath entries as optional
Date:   Mon, 26 Jun 2023 20:10:06 +0200
Message-ID: <20230626180810.022111240@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
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

From: Benedict Wong <benedictwong@google.com>

[ Upstream commit 1f8b6df6a997a430b0c48b504638154b520781ad ]

This change allows inbound traffic through nested IPsec tunnels to
successfully match policies and templates, while retaining the secpath
stack trace as necessary for netfilter policies.

Specifically, this patch marks secpath entries that have already matched
against a relevant policy as having been verified, allowing it to be
treated as optional and skipped after a tunnel decapsulation (during
which the src/dst/proto/etc may have changed, and the correct policy
chain no long be resolvable).

This approach is taken as opposed to the iteration in b0355dbbf13c,
where the secpath was cleared, since that breaks subsequent validations
that rely on the existence of the secpath entries (netfilter policies, or
transport-in-tunnel mode, where policies remain resolvable).

Fixes: b0355dbbf13c ("Fix XFRM-I support for nested ESP tunnels")
Test: Tested against Android Kernel Unit Tests
Test: Tested against Android CTS
Signed-off-by: Benedict Wong <benedictwong@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/xfrm.h     |  1 +
 net/xfrm/xfrm_input.c  |  1 +
 net/xfrm/xfrm_policy.c | 12 ++++++++++++
 3 files changed, 14 insertions(+)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 3e1f70e8e4247..47ecf1d4719b0 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1049,6 +1049,7 @@ struct xfrm_offload {
 struct sec_path {
 	int			len;
 	int			olen;
+	int			verified_cnt;
 
 	struct xfrm_state	*xvec[XFRM_MAX_DEPTH];
 	struct xfrm_offload	ovec[XFRM_MAX_OFFLOAD_DEPTH];
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 436d29640ac2c..9f294a20dcece 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -131,6 +131,7 @@ struct sec_path *secpath_set(struct sk_buff *skb)
 	memset(sp->ovec, 0, sizeof(sp->ovec));
 	sp->olen = 0;
 	sp->len = 0;
+	sp->verified_cnt = 0;
 
 	return sp;
 }
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6d15788b51231..ff58ce6c030ca 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3349,6 +3349,13 @@ xfrm_policy_ok(const struct xfrm_tmpl *tmpl, const struct sec_path *sp, int star
 		if (xfrm_state_ok(tmpl, sp->xvec[idx], family, if_id))
 			return ++idx;
 		if (sp->xvec[idx]->props.mode != XFRM_MODE_TRANSPORT) {
+			if (idx < sp->verified_cnt) {
+				/* Secpath entry previously verified, consider optional and
+				 * continue searching
+				 */
+				continue;
+			}
+
 			if (start == -1)
 				start = -2-idx;
 			break;
@@ -3723,6 +3730,9 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		 * Order is _important_. Later we will implement
 		 * some barriers, but at the moment barriers
 		 * are implied between each two transformations.
+		 * Upon success, marks secpath entries as having been
+		 * verified to allow them to be skipped in future policy
+		 * checks (e.g. nested tunnels).
 		 */
 		for (i = xfrm_nr-1, k = 0; i >= 0; i--) {
 			k = xfrm_policy_ok(tpp[i], sp, k, family, if_id);
@@ -3741,6 +3751,8 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		}
 
 		xfrm_pols_put(pols, npols);
+		sp->verified_cnt = k;
+
 		return 1;
 	}
 	XFRM_INC_STATS(net, LINUX_MIB_XFRMINPOLBLOCK);
-- 
2.39.2



