Return-Path: <stable+bounces-3931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E204803F9B
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 21:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8191C20AF6
	for <lists+stable@lfdr.de>; Mon,  4 Dec 2023 20:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E64630F92;
	Mon,  4 Dec 2023 20:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiYRLuG0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99BA35F04
	for <stable@vger.kernel.org>; Mon,  4 Dec 2023 20:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D512C433C7;
	Mon,  4 Dec 2023 20:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701722070;
	bh=8SAQFhl1WNO7lMXy+iuBPzv3y+k5QbJiqIb5Kk4ciFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HiYRLuG0XWKtDOmjvp8BMXSXHLWIy+l6cgr+tErZ6pUZ2Z/j9aiKc4CRC9hlmK4xL
	 ruTkYS5YwDnuJzmxza9gQgUK++OBhtUayCIoLp5mjnAabNpmJXdO7tRN1W5Ct0LYC/
	 wH6pU/J1jLutRyZsm0X4Wh9gpEQWyhJmtfZH+mduEkLFDeSl2P83E33Io80L61T8Rm
	 vvIof37LsWCYmquW0OF/czic/apwVdOyjR6kYiqTGUDSIMAKMxVDsp/Q9A8OxyB1G1
	 kYi+RLN5Gn9N7apFkbrkkSnc/2G0UlglKiusLhcW8aCiyVUjuY7bx1BP2x7yUH6xiC
	 Nw+26H5NQs7LA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mukul Joshi <mukul.joshi@amd.com>,
	Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 24/32] drm/amdkfd: Use common function for IP version check
Date: Mon,  4 Dec 2023 15:32:44 -0500
Message-ID: <20231204203317.2092321-24-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203317.2092321-1-sashal@kernel.org>
References: <20231204203317.2092321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.4
Content-Transfer-Encoding: 8bit

From: Mukul Joshi <mukul.joshi@amd.com>

[ Upstream commit 2f86bf79b63dbe6963ebc647b77a5f576a906b40 ]

KFD_GC_VERSION was recently updated to use a new function
for IP version checks. As a result, use KFD_GC_VERSION as
the common function for all IP version checks in KFD.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index fa24e1852493d..df7a5cdb8693f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1128,7 +1128,7 @@ static inline struct kfd_node *kfd_node_by_irq_ids(struct amdgpu_device *adev,
 	struct kfd_dev *dev = adev->kfd.dev;
 	uint32_t i;
 
-	if (adev->ip_versions[GC_HWIP][0] != IP_VERSION(9, 4, 3))
+	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3))
 		return dev->nodes[0];
 
 	for (i = 0; i < dev->num_nodes; i++)
-- 
2.42.0


