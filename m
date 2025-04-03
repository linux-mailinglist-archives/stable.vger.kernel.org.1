Return-Path: <stable+bounces-128020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E281DA7AE06
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2F317A4A05
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A220F1FECAE;
	Thu,  3 Apr 2025 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckzRDsPK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECC21FECA4;
	Thu,  3 Apr 2025 19:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707779; cv=none; b=Q4sfPe0jUaB5+lolERhIO93zdF5oCf7ry0KxbtC8EQBJjS0cmzfOyFJmOTrNrTr6qFuA4a95i6US6+2ePMnAehBC/woErqBw9bp23jJQOzdMaDHE1Mgvtq9jtVSAE1peaJe/bpXY8vYJuzeB5A3x4KEW9mSDeXhofCUGTt4wc2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707779; c=relaxed/simple;
	bh=kyj/9npGKcCiu0gq2WV58Ak38lvTBV8yF72OMCXZyJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BLpwRR48jHR3Ofy3Hjs3r/qOwT9U0HjEVLUc8Tj393z6pWX0JEecSY/l17kdX7zYcb8UDf6xqmewUfGSqTN/XMWeW/djjstY9o4UTArO2I6NQJjxLXifecRwwVqU6MMAGpPt2TLfxSKEoalDKp1/BGxoRzu2+nvFMYl5G/w5u9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckzRDsPK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D3DC4CEE8;
	Thu,  3 Apr 2025 19:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707777;
	bh=kyj/9npGKcCiu0gq2WV58Ak38lvTBV8yF72OMCXZyJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ckzRDsPKPhW2byGhPemANzy/sW+UX0aWGN3/SjzmzABtC04j+qwPjyfTwECaFZ3OU
	 LnH7nTr4avtUTCPBbmPIqkAsgMDel2BMkf7IebRXVNHXkzNNRUXHeDqaKOAV8hhbE9
	 HS+qSjld3YVtut9c6ONz09iUKqAvL/ZsiiAO+N9VeQW9Mpf/Y23Hbf2eY+yHbzpsLx
	 y9HGJlQ+VfAbF8ea8neYcb8X8M7/L4//qRYAdzV3OXm+pdvWMOJ7XIWpSpCOT06wjc
	 AVaDv2x4K0XyH03tgqhrwn4bsCLmRdFBovQTSVraGxRBBA+pA3A8uDqJ6JvNeoWafD
	 SjLOT0uSg9xEQ==
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
Subject: [PATCH AUTOSEL 6.13 21/37] drm/amdkfd: debugfs hang_hws skip GPU with MES
Date: Thu,  3 Apr 2025 15:14:57 -0400
Message-Id: <20250403191513.2680235-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191513.2680235-1-sashal@kernel.org>
References: <20250403191513.2680235-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
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
index 35caa71f317dc..463771b7dd4a7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1519,6 +1519,11 @@ int kfd_debugfs_hang_hws(struct kfd_node *dev)
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


