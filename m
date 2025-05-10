Return-Path: <stable+bounces-143082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12102AB2517
	for <lists+stable@lfdr.de>; Sat, 10 May 2025 21:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F46117AE8B
	for <lists+stable@lfdr.de>; Sat, 10 May 2025 19:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CED1D63F5;
	Sat, 10 May 2025 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hY/LgUA1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781491C3C08
	for <stable@vger.kernel.org>; Sat, 10 May 2025 19:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746903743; cv=none; b=dQqMnBp2VWjj/9TuLXtUHa8U2lFALYobBebUMWjpJVmv2Eb0cfloIYEyWNrif5ijZbYvH/H92eNV1iJsbkSz/EzcegtkKpQBEjj59eV5F5oMrXcxXphfEeFXNf7M22BaU596stqxjDt6lNzjQKGOpMR60H2VePm4Xi+3piUW4Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746903743; c=relaxed/simple;
	bh=G45MZhKOVyBEzGgepP3wRSkj4iFRcUI/9Fv0xQct6gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQyF+4QdSIuZuySEzNggiFSnMWtHwxeWdvjzXKhKe3PxTQAWwIHuvx8Xa32YCnHkJR2LD8VvPzGLJuP/3bdvq0YxXXMUoQFIKhqNmMdzfjLXNhQRYcGH2vhNB8LluvjwA9rJ/7TFF4TPwobEA/h9BFOcmMdenSi6bAD7rtgXQDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hY/LgUA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66553C4CEE2;
	Sat, 10 May 2025 19:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746903742;
	bh=G45MZhKOVyBEzGgepP3wRSkj4iFRcUI/9Fv0xQct6gc=;
	h=From:To:Cc:Subject:Date:From;
	b=hY/LgUA1hCYNydAanU9mgF+9tAofnqWY1Bzt5DI6tGRGKMtQbzsbHxKscF1/XlI9z
	 3TcxUSzVM4DII1AVpad8oSV/uEUEtc+OQF19BTZftmdevvWiFsQaIufC56+5lY8sNK
	 dyWwdpvCdqZUKn+JiJZ07fh4BFqSPsKdcXSYBGSPkh6CfngoZpXYxLi7f1y83oa+Gs
	 YbzQRoYSVFS+2tTbXc4TiF96Q8utzJ7v6u94xmpG2onaB8KO8d6LGzYFL3D8zXxhYD
	 klKqaSERyUHwlOLdOSf71SPfVKP+Z6rQICvdBAEdByiNwuvhDCrNbLPGF5+5ZC71AO
	 5G28ZBhElqAOw==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	stable@vger.kernel.org,
	David.Wu3@amd.com
Subject: [PATCH] drm/amd: Turn off doorbell for vcn 4.0.5
Date: Sat, 10 May 2025 14:02:16 -0500
Message-ID: <20250510190216.3461208-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

On VCN 4.0.5 using a doorbell to notify VCN hardware for WPTR changes
while dynamic power gating is enabled introduces a timing dependency
that can sometimes cause WPTR to not be properly updated. This manifests
as a job timeout which will trigger a VCN reset and cause the application
that submitted the job to crash.

Writing directly to the WPTR register instead of using the doorbell changes
the timing enough that the issue doesn't happen. Turn off doorbell use for
now while the issue continues to be debugged.

Cc: stable@vger.kernel.org
Cc: David.Wu3@amd.com
Closes: https://gitlab.freedesktop.org/mesa/mesa/-/issues/12528
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3909
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index ba603b2246e2e..ea9513f65d7e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -181,7 +181,7 @@ static int vcn_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 
 		ring = &adev->vcn.inst[i].ring_enc[0];
-		ring->use_doorbell = true;
+		ring->use_doorbell = false;
 		if (amdgpu_sriov_vf(adev))
 			ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
 						i * (adev->vcn.inst[i].num_enc_rings + 1) + 1;
-- 
2.43.0


