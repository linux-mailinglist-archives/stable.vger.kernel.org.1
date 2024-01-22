Return-Path: <stable+bounces-15125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C94188383FF
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 03:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090751C29F0D
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412B3664C6;
	Tue, 23 Jan 2024 01:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QbCHQQpi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004ED629F8;
	Tue, 23 Jan 2024 01:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705975113; cv=none; b=dEdRcEtXEYxI+RXTyId85gNUDPe4JKP4s1c7HCBbmtqpeLSVLnJIi/ivtmK/0R6BQuhgaYa3N23TgdlPCVp2Zms8+fN6STOvRTYc3chAm1h0skT96AAmGlf/AX53Ev3bNv4fS+tHsNNfLUVCFi9w+mw7cdMJc4dViJvpyWWc2gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705975113; c=relaxed/simple;
	bh=rKRcNzFyMmWIHEc43uT/Shly7ssqisWuojPS1frUIEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uC7eiqnRidZxz5gwCjhDSePBpK1MdA128ecuo2jecx1oscnrSPaBD1h68PdGr43kLp99bHD8Blm7bet539HnQmq4gFRI9RvNzxqjQ85YIjGayorNTkO13q+TAFMmFWdyGmOkZadQqVHpcGUUKljGjX5lETmFBJe8goYen99Lhy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QbCHQQpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA040C433B1;
	Tue, 23 Jan 2024 01:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705975112;
	bh=rKRcNzFyMmWIHEc43uT/Shly7ssqisWuojPS1frUIEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QbCHQQpizoCAbQXiJqq9e+opBAi11xtmQcMcs6GFq95Tg/91s+2sZBwQ1qFaJ/F1+
	 X2AEpek+QwK9JDV64fs60A/lIW9JxtmnGR8b27SW+jC2qv1wQJsHHaGRfAtKuA1n64
	 dksjmV6+PbwmTzxXLZTm0glPS1zzz8QS9bBjMU8k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 243/583] drm/radeon: check return value of radeon_ring_lock()
Date: Mon, 22 Jan 2024 15:54:54 -0800
Message-ID: <20240122235819.430966760@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
References: <20240122235812.238724226@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

[ Upstream commit 71225e1c930942cb1e042fc08c5cc0c4ef30e95e ]

In the unlikely event of radeon_ring_lock() failing, its errno return
value should be processed. This patch checks said return value and
prints a debug message in case of an error.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 48c0c902e2e6 ("drm/radeon/kms: add support for CP setup on SI")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/si.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index a91012447b56..85e9cba49cec 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -3611,6 +3611,10 @@ static int si_cp_start(struct radeon_device *rdev)
 	for (i = RADEON_RING_TYPE_GFX_INDEX; i <= CAYMAN_RING_TYPE_CP2_INDEX; ++i) {
 		ring = &rdev->ring[i];
 		r = radeon_ring_lock(rdev, ring, 2);
+		if (r) {
+			DRM_ERROR("radeon: cp failed to lock ring (%d).\n", r);
+			return r;
+		}
 
 		/* clear the compute context state */
 		radeon_ring_write(ring, PACKET3_COMPUTE(PACKET3_CLEAR_STATE, 0));
-- 
2.43.0




