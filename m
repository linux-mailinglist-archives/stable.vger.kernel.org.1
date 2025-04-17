Return-Path: <stable+bounces-134228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 075F7A929F6
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ACBF168ED5
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9802528FA;
	Thu, 17 Apr 2025 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vw5XBQES"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499B78462;
	Thu, 17 Apr 2025 18:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915488; cv=none; b=CoJ5u5OuEBkKztPpRAzmZ7Xd5q8AGGDZjuHh8uxvAJvmxZ+Oexr9RSDAT3FvsdQ8K85rYMSP8pTGt0PxDxmS7ANN6VWmXccTmMzA8CSZmT3Zkr2S5hOlJ0VUUbAdnGVTD3GvbUFQ+mU4m+OUG0TcZ9Eg8BaabgDaYNnnW8QhOV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915488; c=relaxed/simple;
	bh=N4+hZZd4TugklM3QatZpTSrnhhyYOXK/BFs+QkPFuXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5Ogq2JufZ+SZ573HY+7S3p6X1MD3CPPaWpJgmh3vkmOoI4VtDLoU3ee+xtjbi4zAVicPo841X1O74errqdcq3Fjol51N2cJ04FNVlFPFGuYc3MG9G+beooQqOgYtrlYB+QPTYbiQoiI4/GdpU9evLbR0mDvDrmiI8d6IbDuH+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vw5XBQES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5192C4CEE7;
	Thu, 17 Apr 2025 18:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744915488;
	bh=N4+hZZd4TugklM3QatZpTSrnhhyYOXK/BFs+QkPFuXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vw5XBQESil3x/EtzFHPQ5ujZ8s2t+zaCvlW3B37hngqpTVwEBqaHfyXjOSZpQQ+F/
	 NXczUujumdSgQNssucLU8okIANsStS1OHeF5MZ0DgQVg1xT/yLjep8HiQHzbegrLFT
	 1Y6/5v18MMrIDjuB0IT58QxyKWJMIviZaeML+WcU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philip Yang <Philip.Yang@amd.com>,
	Kent Russell <kent.russell@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 143/393] drm/amdkfd: debugfs hang_hws skip GPU with MES
Date: Thu, 17 Apr 2025 19:49:12 +0200
Message-ID: <20250417175113.337135082@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

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




