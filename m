Return-Path: <stable+bounces-251476-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBLzIVT1DWoz5AUAu9opvQ
	(envelope-from <stable+bounces-251476-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:54:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B31C594E5C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F16030874D4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598D03F1AB8;
	Wed, 20 May 2026 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BwL6JgTj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B2C39B975;
	Wed, 20 May 2026 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298082; cv=none; b=LQcAP8pVG4PHg/L99Zj5XWBu5kxmZr3qA+Jik5Sa33QCcczoiYcbqa9zEFXWlKbH2g19za+MojAx3zkwuVp4tIzR2MrVOiqa4iBd7XDbIUITiy6jFOQvYanx/uMRNOAn6OfiJS+/na5FYtB0ZIpvWNGklZwmBfX10XNDDojfIZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298082; c=relaxed/simple;
	bh=7Hem0lp9bGdk82r2MoqPU9HPfgmGa7XQoTR0xHFgFpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OWKQOwwmh3rvnTPoFAVco7H0+kdVmCgJbEZSUXZltWm6daG0TnzwixR1aqiDxhL8jNK6TyfaD4R1O0vCMJivBv523E2yYxGu52U/N8+lDUt3vLJzllWv6DBE/DccJRJgwRnQJJ8QbvtO9NagvDSNPz7Fb1FZeAXWWDHOxUyYyvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BwL6JgTj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F6E1F00893;
	Wed, 20 May 2026 17:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298081;
	bh=7Uo5I+itP9A68KcHtDULO5MBCa3oEn6O6YfxSH6vDm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BwL6JgTjrqxi4IEGJG9gLXdixDsZ6dtJzZwqDyKhflmQ+JgJRv5/pXiCP0Eah6x3P
	 hLd7ryDxQ46QGPsVdmfxJksWqDOpOCJv4lTZbGIJ22KXaF/NgxvvxUK0YMcTv5b6uS
	 yF/7+muA5aOr5e3OJO6G8jFb/TI0eBWRSZ2uleo8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 276/957] drm/msm/shrinker: Fix can_block() logic
Date: Wed, 20 May 2026 18:12:39 +0200
Message-ID: <20260520162140.527573125@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251476-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,collabora.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,qualcomm.com:email,patchwork.freedesktop.org:url,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 2B31C594E5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index 1039e3c0a47bf..31fa51a44f86e 100644
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




