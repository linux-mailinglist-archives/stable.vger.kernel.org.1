Return-Path: <stable+bounces-181377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBB8B9318B
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80CA63A754C
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BA72F3613;
	Mon, 22 Sep 2025 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sMyJBitx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67491C1ADB;
	Mon, 22 Sep 2025 19:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570390; cv=none; b=VDnFGqVCOS3QbS7sqWm5EY5BDO0CNn/679kJr8dhK4T4YiU+ILr4goG51GDV/1HJUxaAljs7r7pw8YTnfU2wxS36pNh/lYtGd386N9yZm0+XcRYFFfVvNCFx3IG60JgV9tQrMfSixHUJZO+e24hk9P/ZpYcWnn6b5cEDPec0mWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570390; c=relaxed/simple;
	bh=atOLcaiW517+Q2JbDjqCOg3N5i1Vc3HcFvpSI3YtXy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p88i+dGHqMNjw3E6mHx6A1daC82NOffokIcZT1LLXcCRHsR46ngu5sYSTybu0OuuDPf3LmtLKS6YAHKreXEbe+syF129UWcaRHGzY2UX9j54WE1/rroPWNxrOM4Ss721zUERZVuBITYp2mzKZRrAqGsSjkYE4HAB0BAHyJFZJFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sMyJBitx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFFFC4CEF0;
	Mon, 22 Sep 2025 19:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758570389;
	bh=atOLcaiW517+Q2JbDjqCOg3N5i1Vc3HcFvpSI3YtXy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sMyJBitxp1XSazyEohiSfKtfulr1U9w8AkhaW17DzDS2qUkjwrJry80F4bR1VM/9f
	 tB+Ee3IQdwsxEf3aeScqwEaHC1zycKgxgcgXgZx0/1ccHgChNjeLzEI1LGvIAReMNp
	 qQF+vvzPa+sIm1QoecvnJV7n9lTDCYqtaCps3SKg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	=?UTF-8?q?Piotr=20Pi=C3=B3rkowski?= <piotr.piorkowski@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 118/149] drm/xe/pf: Drop rounddown_pow_of_two fair LMEM limitation
Date: Mon, 22 Sep 2025 21:30:18 +0200
Message-ID: <20250922192415.851338941@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192412.885919229@linuxfoundation.org>
References: <20250922192412.885919229@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Wajdeczko <michal.wajdeczko@intel.com>

[ Upstream commit fef8b64e48e836344574b85132a1c317f4260022 ]

This effectively reverts commit 4c3fe5eae46b ("drm/xe/pf: Limit
fair VF LMEM provisioning") since we don't need it any more after
non-contig VRAM allocations were fixed. This allows larger LMEM
auto-provisioning for VFs, so instead:

 [ ] GT0: PF: LMEM available(14096M) fair(1 x 8192M)
 [ ] GT0: PF: VF1 provisioned with 8589934592 (8.00 GiB) LMEM
or
 [ ] GT0: PF: LMEM available(14096M) fair(2 x 4096M)
 [ ] GT0: PF: VF1..VF2 provisioned with 4294967296 (4.00 GiB) LMEM

we may get:

 [ ] GT0: PF: LMEM available(14096M) fair(1 x 14096M)
 [ ] GT0: PF: VF1 provisioned with 14780727296 (13.8 GiB) LMEM
and
 [ ] GT0: PF: LMEM available(14096M) fair(2 x 7048M)
 [ ] GT0: PF: VF1..VF2 provisioned with 7390363648 (6.88 GiB) LMEM

Fixes: 1e32ffbc9dc8 ("drm/xe/sriov: support non-contig VRAM provisioning")
Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Reviewed-by: Piotr Piórkowski <piotr.piorkowski@intel.com>
Link: https://lore.kernel.org/r/20250910222439.32869-1-michal.wajdeczko@intel.com
(cherry picked from commit 95c1cfa306087142989bff34ea0e05dcd95ddc58)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c b/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c
index 53a44702c04af..c15dc600dcae7 100644
--- a/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c
+++ b/drivers/gpu/drm/xe/xe_gt_sriov_pf_config.c
@@ -1600,7 +1600,6 @@ static u64 pf_estimate_fair_lmem(struct xe_gt *gt, unsigned int num_vfs)
 	u64 fair;
 
 	fair = div_u64(available, num_vfs);
-	fair = rounddown_pow_of_two(fair);	/* XXX: ttm_vram_mgr & drm_buddy limitation */
 	fair = ALIGN_DOWN(fair, alignment);
 #ifdef MAX_FAIR_LMEM
 	fair = min_t(u64, MAX_FAIR_LMEM, fair);
-- 
2.51.0




