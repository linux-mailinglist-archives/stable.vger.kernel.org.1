Return-Path: <stable+bounces-58600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E002892B7CC
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69A51B21F2D
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9025156C73;
	Tue,  9 Jul 2024 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M4wv3bqh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979FF27713;
	Tue,  9 Jul 2024 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524430; cv=none; b=pFjw8usuwgRtmWI+TVk31lDmbYgJ8/ePHY6QQXg46K4mkfihFrNAKRdFXIm5TYVORehioxIcqNrLmvLf2gdy0azGMfVIamdz21P8LFhcUgIjZrg+JJIJVHJoSYylkHODMI8iTvA6xetmdm092iaUvN/ts6AzRBmj4HLr5oMnVMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524430; c=relaxed/simple;
	bh=cW+UjECEgX9c1nyEvZW+TcB2NGkFUCh3K8D6m95OY5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyEIeMD5A0FFwGaksBAp7DBTEsqK7HzO2/atURz5INX/gjM/IipBH2QyBr+WB0f7KBSkCK6K7Uh4IVrbb1mqeYaIIusSx9gepXBiBPjBxHI137oSIZUPInq97RuCixCYhWYMDwzdk7j6hAor+UBKV6yoeeIc/9bJTiaxJz/64MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M4wv3bqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A059C3277B;
	Tue,  9 Jul 2024 11:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720524430;
	bh=cW+UjECEgX9c1nyEvZW+TcB2NGkFUCh3K8D6m95OY5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M4wv3bqh2WuHL/n+tyB8RHdQLjDz8CcVBJmLdjeq5mSgqUDPUGirFJYLZLeBBRZHT
	 l+z0Ub+KT8XtzsqgHM+caT4an1hxGPoSjY0Q5IskOxb5+2/SxK/0+/KDPry9bpmHRc
	 h76C3Ud+sj6/djFqlF7ZlKd0RhSkrkPx9Ud32zc8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 180/197] drm/amdgpu: correct hbm field in boot status
Date: Tue,  9 Jul 2024 13:10:34 +0200
Message-ID: <20240709110715.910561207@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110708.903245467@linuxfoundation.org>
References: <20240709110708.903245467@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hawking Zhang <Hawking.Zhang@amd.com>

[ Upstream commit ec58991054e899c9d86f7e3c8a96cb602d4b5938 ]

hbm filed takes bit 13 and bit 14 in boot status.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index e0f8ce9d84406..db9cb2b4e9823 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -43,7 +43,7 @@ struct amdgpu_iv_entry;
 #define AMDGPU_RAS_GPU_ERR_HBM_BIST_TEST(x)		AMDGPU_GET_REG_FIELD(x, 7, 7)
 #define AMDGPU_RAS_GPU_ERR_SOCKET_ID(x)			AMDGPU_GET_REG_FIELD(x, 10, 8)
 #define AMDGPU_RAS_GPU_ERR_AID_ID(x)			AMDGPU_GET_REG_FIELD(x, 12, 11)
-#define AMDGPU_RAS_GPU_ERR_HBM_ID(x)			AMDGPU_GET_REG_FIELD(x, 13, 13)
+#define AMDGPU_RAS_GPU_ERR_HBM_ID(x)			AMDGPU_GET_REG_FIELD(x, 14, 13)
 #define AMDGPU_RAS_GPU_ERR_BOOT_STATUS(x)		AMDGPU_GET_REG_FIELD(x, 31, 31)
 
 #define AMDGPU_RAS_BOOT_STATUS_POLLING_LIMIT	1000
-- 
2.43.0




