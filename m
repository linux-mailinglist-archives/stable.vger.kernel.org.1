Return-Path: <stable+bounces-220527-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIV5Mx88o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220527-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:03:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 332E41C68EE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A01263326944
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314383CEAEF;
	Sat, 28 Feb 2026 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZctO02JV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AFA3CEAE5;
	Sat, 28 Feb 2026 17:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300411; cv=none; b=rKGL0lcgaNsP4VSNo8oomba78/6oalQeqjJ/OfRDygkY0tsiQe4tOP2M1WCgDA+J2i/HTybW90IV6DNJS7nmv+hO90K8UZwWpDvpyLbLMdvx6ZQ4fCNhx92cGt6aeRyrmbxCI6Esq8ePE5uf5hDCg30ZIemfMwfyQC6/J1U1zI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300411; c=relaxed/simple;
	bh=fQBx7ID8R19kwDXm1s3pbxKnmBmO0qJDPrYFYhjrKog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GknIFesxDQn2rKWKS3j8rYaAlyT9jKcHsQyGTkcbHx4a9wRS18EHj9/dSCQd9JrvRMVJBVQjXjQqhZfFcF7J6fTjL9rj6wXiDmFRiB/VkitVMQOZylcSA3dG6y/FVl/S1DFXzhSdoCzRFQv5kWKX++Sc9r7q79OiLB/faXsQkOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZctO02JV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96FCC116D0;
	Sat, 28 Feb 2026 17:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300410;
	bh=fQBx7ID8R19kwDXm1s3pbxKnmBmO0qJDPrYFYhjrKog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZctO02JVnkpfHA+ZKzJI1+QWKpcAdm9progQ5iz6WbhKJMmwFHhb7F1NeL1KqQeod
	 wsfviIcasfVkMbl9liBo4oe+xncuxgA1hif2QLronTme3Rq6TFgL/MAY/ymleb4sB2
	 KxUNdFHu9F2xJ3NJ5i5wcMFlbZbx/bIVakhjwiNjq7F15mYw06XKKDVmO2gIjg0G3d
	 78zQy+TuCwvr8Kcpz5a9i5/sg2lIqehvvmoSrlyCECgfPp6FthAcaNarKJG8566dco
	 +scrKndzpT+IzuUCnplc+PQx/P19tVQDCTCKZhSeMcrLhrNBFJaqjLHo1gtnC29kMB
	 Yec2nMdd98rdw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 448/844] xfrm: skip templates check for packet offload tunnel mode
Date: Sat, 28 Feb 2026 12:26:01 -0500
Message-ID: <20260228173244.1509663-449-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220527-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:email,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 332E41C68EE
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit 0a4524bc69882a4ddb235bb6b279597721bda197 ]

In packet offload, hardware is responsible to check templates. The
result of its operation is forwarded through secpath by relevant
drivers. That secpath is actually removed in __xfrm_policy_check2().

In case packet is forwarded, this secpath is reset in RX, but pushed
again to TX where policy is rechecked again against dummy secpath
in xfrm_policy_ok().

Such situation causes to unexpected XfrmInTmplMismatch increase.

As a solution, simply skip template mismatch check.

Fixes: 600258d555f0 ("xfrm: delete intermediate secpath entry in packet offload mode")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_policy.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 62486f8669752..5428185196a1f 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3801,8 +3801,8 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		struct xfrm_tmpl *tp[XFRM_MAX_DEPTH];
 		struct xfrm_tmpl *stp[XFRM_MAX_DEPTH];
 		struct xfrm_tmpl **tpp = tp;
+		int i, k = 0;
 		int ti = 0;
-		int i, k;
 
 		sp = skb_sec_path(skb);
 		if (!sp)
@@ -3828,6 +3828,12 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 			tpp = stp;
 		}
 
+		if (pol->xdo.type == XFRM_DEV_OFFLOAD_PACKET && sp == &dummy)
+			/* This policy template was already checked by HW
+			 * and secpath was removed in __xfrm_policy_check2.
+			 */
+			goto out;
+
 		/* For each tunnel xfrm, find the first matching tmpl.
 		 * For each tmpl before that, find corresponding xfrm.
 		 * Order is _important_. Later we will implement
@@ -3837,7 +3843,7 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		 * verified to allow them to be skipped in future policy
 		 * checks (e.g. nested tunnels).
 		 */
-		for (i = xfrm_nr-1, k = 0; i >= 0; i--) {
+		for (i = xfrm_nr - 1; i >= 0; i--) {
 			k = xfrm_policy_ok(tpp[i], sp, k, family, if_id);
 			if (k < 0) {
 				if (k < -1)
@@ -3853,6 +3859,7 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 			goto reject;
 		}
 
+out:
 		xfrm_pols_put(pols, npols);
 		sp->verified_cnt = k;
 
-- 
2.51.0


