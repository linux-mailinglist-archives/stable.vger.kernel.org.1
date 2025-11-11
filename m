Return-Path: <stable+bounces-193707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2107EC4AA21
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC83D3BA1F0
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1EB34B41C;
	Tue, 11 Nov 2025 01:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xzLXP4jg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC1A2FD7CA;
	Tue, 11 Nov 2025 01:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823818; cv=none; b=VheZsvzcurj3eYhIbIVYbQeXAk6x/LoKyyWblThdtDMo5/sbdjfE/lq34rvaORs7BD6Zh5IDjxCka0X/TK2tE7JC3s4RqXCOKtuDn/SNmROXftGoJaOikNkOjHipUNBOXzsYI+Jovg9MBRwDwOFRPUhKg8tCkmk44Ox4Uot6Fis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823818; c=relaxed/simple;
	bh=tlBkSAMKx+g8d+ejllrr4WhH2IKJq95cd48RJxc6ZJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGw0JMWUszCL1Y0wVYeqcx0W0S7cVSqZFHPFH82ODpnXGhergl99SLilGsnSOrNLELYdncfISMUaXseEXmTG0kJLdgRMd4sm6zUCJXa1gd7Tsye+3D4Crr1HjL9upqL5WEp0nl8Xv8PAOzqFINYexIBYVHcBtXZuLXB1HG7WIlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xzLXP4jg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4156CC4CEFB;
	Tue, 11 Nov 2025 01:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762823818;
	bh=tlBkSAMKx+g8d+ejllrr4WhH2IKJq95cd48RJxc6ZJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xzLXP4jgUkSMA4s5bnUxn8rwAog2hSOSLyxZGAIEX1XFX3RAoQifTdXzyX8eyxo0Q
	 pFwLR348casr9BTB8HB4WOzWJO/doc/zbVsLZzXfyijALFU/vftLE0WirvXpjtwKNG
	 e5j4WWas4P6JpARJZBbwqI8bPMamv+eHQXMSu76c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"David (Ming Qiang) Wu" <David.Wu3@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 378/849] drm/amdgpu/vpe: cancel delayed work in hw_fini
Date: Tue, 11 Nov 2025 09:39:08 +0900
Message-ID: <20251111004545.571281700@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit ec813f384b1a9df332e86ff46c422e5d2d00217f ]

We need to cancel any outstanding work at both suspend
and driver teardown. Move the cancel to hw_fini which
gets called in both cases.

Reviewed-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 7538c4738af34..118fbe38b33ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -461,6 +461,8 @@ static int vpe_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_vpe *vpe = &adev->vpe;
 
+	cancel_delayed_work_sync(&adev->vpe.idle_work);
+
 	vpe_ring_stop(vpe);
 
 	/* Power off VPE */
@@ -471,10 +473,6 @@ static int vpe_hw_fini(struct amdgpu_ip_block *ip_block)
 
 static int vpe_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-
-	cancel_delayed_work_sync(&adev->vpe.idle_work);
-
 	return vpe_hw_fini(ip_block);
 }
 
-- 
2.51.0




