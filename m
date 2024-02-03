Return-Path: <stable+bounces-18634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25933848381
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8953CB2AC37
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D1953E2B;
	Sat,  3 Feb 2024 04:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="egbdLhuO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217CD11720;
	Sat,  3 Feb 2024 04:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933943; cv=none; b=G1YLNsgabYFUxzq3zpVyipHonwZAZyAZ5x/IZ7Fni8sG5rXpYvOQA9NUJAsFsvejfBoYP4RVW8xAgjZkYs4b9iJwxEU/HWqVWv+o0it/C0FpQqT31cxhHB0KAuhi5K+FUgxkYeQcDr4gyZcNBlnXFZWvpa8H15v11DQRSSlWyfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933943; c=relaxed/simple;
	bh=sEr3vj4BYWPkwbSTGMdOMdGZytZ3GtpKgvCj4UT6KfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9q9W/T1VQST1zpKGCRMOmjewdzsaKqPGR1uO5hjfjWkpXhqcR+VUjte+0QqCK1LVfAgsEQj7Gjy9HmELGh+sbiHK2J/TdJhPPfcjLxUx3w4vLKZHhthr7/DO+36zBQhpbD9khchEl5Z6m+UGqLqClSCzvnThYBUXSQ3Onxt8OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=egbdLhuO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE972C433F1;
	Sat,  3 Feb 2024 04:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933943;
	bh=sEr3vj4BYWPkwbSTGMdOMdGZytZ3GtpKgvCj4UT6KfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=egbdLhuOQcS5kQ62Idkt6t8AnzPmlTOujjJ5cdfs/ffgHrJjpWJVTZttjo7fx1EmB
	 3zt+bfuWBZDhaQmC5AYf5mr0zBBIZbJl6p6+U/GeOeAx73MMWLtXvtvFP6Z3u0vEFH
	 ZQ4jv3tphz8EL2XJIW30evBLWmWDQTFsSElxv/mc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Monk Liu <Monk.Liu@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 284/353] drm/amdgpu: Release adev->pm.fw before return in amdgpu_device_need_post()
Date: Fri,  2 Feb 2024 20:06:42 -0800
Message-ID: <20240203035412.755850675@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 8a44fdd3cf91debbd09b43bd2519ad2b2486ccf4 ]

In function 'amdgpu_device_need_post(struct amdgpu_device *adev)' -
'adev->pm.fw' may not be released before return.

Using the function release_firmware() to release adev->pm.fw.

Thus fixing the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:1571 amdgpu_device_need_post() warn: 'adev->pm.fw' from request_firmware() not released on lines: 1554.

Cc: Monk Liu <Monk.Liu@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3677d644183b..9257c9af3fee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1485,6 +1485,7 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 				return true;
 
 			fw_ver = *((uint32_t *)adev->pm.fw->data + 69);
+			release_firmware(adev->pm.fw);
 			if (fw_ver < 0x00160e00)
 				return true;
 		}
-- 
2.43.0




