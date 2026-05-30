Return-Path: <stable+bounces-257470-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J33GBgcG2pk/QgAu9opvQ
	(envelope-from <stable+bounces-257470-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:19:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BC360F62F
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EA4931083EA
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B2734EF07;
	Sat, 30 May 2026 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D2thq6LT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2176EEEA8;
	Sat, 30 May 2026 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161108; cv=none; b=lGKMUqVQQFdrem857eioYC4PPBn1ohl6jRAfbkwM9igj8491/VS+qV14EK1PAPDlBDAow3nG8E8reto8Vg4TID1fJChsGAs0iehsxkXY9hy2hAyyftK3HhgkNi8NfjQ9hwmoiRP88Ok4yTXXb4Y1dokMbi/H64ozh6TwlusyF08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161108; c=relaxed/simple;
	bh=iNJ+2U8OCIPcXwqkJBpAPQIsP8f6ix0e3K4LjinvDPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipNQ66ObP9fDS5nhNntbIp+eUs0Eajh8lZSf1+Ey+2v9SeOtc4ND7Q8YRwy23XEaS8n5Icq8Sujz24oBMTiII9x4oVE0wkaAajra49ipQ8w8yA2VkLlhmK6SCwTOQRdCSimbW7poTV6gMzUJSCGOuOVK9HNFxhGhELxiTwFi4Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D2thq6LT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE611F00893;
	Sat, 30 May 2026 17:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161106;
	bh=IP2/ya7ENmHVtFCOU1CR0VX4La8Z2FaNroYFtGypeJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D2thq6LTTTb0boca0NDgf2UYkuhw9JTqqvTTXYfoxl5smWbySmKGgnBKoJftoS0dN
	 FRqOEMRdKdt0MD54BK/JVuim/NRqlAAA3wt4XR3xSUoO1hVDl4anbTiDNdQgW3+sXM
	 y5CYk3zQ4osNI4bV/dI/QmsdCKQLu0espSmp6VGs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 527/969] drm/msm/shrinker: Fix can_block() logic
Date: Sat, 30 May 2026 18:00:51 +0200
Message-ID: <20260530160314.911937705@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257470-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D0BC360F62F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rob Clark <robin.clark@oss.qualcomm.com>

[ Upstream commit df0f439e3926817cf577ca6272aad68468ff7624 ]

The intention here was to allow blocking if DIRECT_RECLAIM or if called
from kswapd and KSWAPD_RECLAIM is set.

Reported by Claude code review: https://lore.gitlab.freedesktop.org/drm-ai-reviews/review-patch9-20260309151119.290217-10-boris.brezillon@collabora.com/ on a panthor patch which had copied similar logic.

Reported-by: Boris Brezillon <boris.brezillon@collabora.com>
Fixes: 7860d720a84c ("drm/msm: Fix build break with recent mm tree")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Patchwork: https://patchwork.freedesktop.org/patch/714238/
Message-ID: <20260325184106.1259528-1-robin.clark@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_gem_shrinker.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index a35c98306f1e5..f1b330c272fb7 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -26,9 +26,8 @@ static bool can_swap(void)
 
 static bool can_block(struct shrink_control *sc)
 {
-	if (!(sc->gfp_mask & __GFP_DIRECT_RECLAIM))
-		return false;
-	return current_is_kswapd() || (sc->gfp_mask & __GFP_RECLAIM);
+	return (sc->gfp_mask & __GFP_DIRECT_RECLAIM) ||
+	       (current_is_kswapd() && (sc->gfp_mask & __GFP_KSWAPD_RECLAIM));
 }
 
 static unsigned long
-- 
2.53.0




