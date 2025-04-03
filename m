Return-Path: <stable+bounces-128056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF5DA7AED1
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F903A1779
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B513E222572;
	Thu,  3 Apr 2025 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tezC74hT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AE322256B;
	Thu,  3 Apr 2025 19:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707865; cv=none; b=skhhGGffIgtUmDovpPMk237Mi+KkMCDgymTSaBOMQNqXH0j8BmNHVLExFCH1NW5mKi8IVAdHEBFgCssiDSCc5GIwbXd+KiBHG/hzjinm3opCmHiAbKeBWLLTNr+UKtcW7gOmKesjvNKQmADgfkdGqtuWg4khgfitRay4yLMM578=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707865; c=relaxed/simple;
	bh=hQDyfFMU9Pbtux+HL4D0FkLhdH8YWQFnhYIoAVU0uAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jpmDMtneZ+qLtOE4Dd5eBvRxxItNMGT7T/t15L/cTXo4HMTpy9S0zOFhu03j8yO3PjKQ4HLYbPQsTdKrXoR7LmbgjEttJ2jRvNcvW2g+PItxKfgSeuZGGTcqBB7R0L5kSb1+/bGESneFsO2X9C3y6js6iqSm2f29jRXHj87i3Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tezC74hT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC48AC4CEE8;
	Thu,  3 Apr 2025 19:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707865;
	bh=hQDyfFMU9Pbtux+HL4D0FkLhdH8YWQFnhYIoAVU0uAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tezC74hTp5P381p6R9kI60U6lESKGmTiw0G4Wsg4yrqhYLybwd96X73gCysGEpQNW
	 6zzD2Ko0zwtAPnatCEx1rXti/qBIBlGnbI8JNbjfdwSG56/w7ybkYi+k58fbUQtpEa
	 8A9va5HK+2TXBKWmbp0DydYKqJhngkfMIH0dqmifb3W7Eg/nHqJg/mN5WfflcjneiD
	 b7rLK3vRAXzp8++Oaqu1AkipdxHlgEo0/kvm/5RBdNLBKDv29UhozRKDAIak6tPjVG
	 /9PZozfSammoB8/CrRQKHjX5nlpGvzlKIox3ytn1m5AQLn2iTXbs27U6XR2ez72BLT
	 4AaughFvmD40A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philip Yang <Philip.Yang@amd.com>,
	Kent Russell <kent.russell@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 18/33] drm/amdkfd: debugfs hang_hws skip GPU with MES
Date: Thu,  3 Apr 2025 15:16:41 -0400
Message-Id: <20250403191656.2680995-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191656.2680995-1-sashal@kernel.org>
References: <20250403191656.2680995-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit fe9d0061c413f8fb8c529b18b592b04170850ded ]

debugfs hang_hws is used by GPU reset test with HWS, for MES this crash
the kernel with NULL pointer access because dqm->packet_mgr is not setup
for MES path.

Skip GPU with MES for now, MES hang_hws debugfs interface will be
supported later.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Kent Russell <kent.russell@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index d350c7ce35b3d..9186ef0bd2a32 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1493,6 +1493,11 @@ int kfd_debugfs_hang_hws(struct kfd_node *dev)
 		return -EINVAL;
 	}
 
+	if (dev->kfd->shared_resources.enable_mes) {
+		dev_err(dev->adev->dev, "Inducing MES hang is not supported\n");
+		return -EINVAL;
+	}
+
 	return dqm_debugfs_hang_hws(dev->dqm);
 }
 
-- 
2.39.5


