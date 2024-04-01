Return-Path: <stable+bounces-34153-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ECB893E1C
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792D71F21875
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 15:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0C64778C;
	Mon,  1 Apr 2024 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OtkGKRO5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3DB4778B;
	Mon,  1 Apr 2024 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987171; cv=none; b=cYQtgoosmRbBUh092YoLdszGrnECvo03+1tyf1NgyeA4z1kE+NTEK1ZqUXAanxmOhaxDnotdSLg+4a4XAmGtdU3nJhbs06erdwo+I5++GF5TKZVUu4uDtmABU2J9hCsfu7oZJupkrBpDzTM40fThjKzPMjTfsI9Hm1TXO9BGQO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987171; c=relaxed/simple;
	bh=XDrXM6bTuwju/mgNhsBaFM0qeYxhYbVofr3UdVO8DG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HyN3eH4LnF5/Cm6wT14A3i/d3kH8P3cr81p2Y1yK6eIwT4LcwJImh6rtG9r/tP5AQvkfOcdYmAcugqCzt9goVyndVgWiFykFN8j3Wzl/wx8U7lHchL9MQQkPciWJhQuXFMM22uBwgwZTiBrIAyW2ERzyolMmPHQmpY/dYDv2veE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OtkGKRO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48202C433C7;
	Mon,  1 Apr 2024 15:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987171;
	bh=XDrXM6bTuwju/mgNhsBaFM0qeYxhYbVofr3UdVO8DG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OtkGKRO5qslRp6wyG8YMLXljUAL6fZBnP0qDv365ruAhNayFY8RF0ukJO/ogsIQLc
	 vOofAFIzQehKWFGvAfaKHsudpYbGPOGrpYye66IeXd1uCSi3yaj6sQDr5x9KyvXAvN
	 cYHrt9dCG09wrOnDYcOfzWcSDnZbT6onnLUhkesI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Philip Yang <Philip.Yang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 206/399] drm/amdgpu: amdgpu_ttm_gart_bind set gtt bound flag
Date: Mon,  1 Apr 2024 17:42:52 +0200
Message-ID: <20240401152555.332013662@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit 6c6064cbe58b43533e3451ad6a8ba9736c109ac3 ]

Otherwise after the GTT bo is released, the GTT and gart space is freed
but amdgpu_ttm_backend_unbind will not clear the gart page table entry
and leave valid mapping entry pointing to the stale system page. Then
if GPU access the gart address mistakely, it will read undefined value
instead page fault, harder to debug and reproduce the real issue.

Cc: stable@vger.kernel.org
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 75c9fd2c6c2a1..b0ed10f4de609 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -869,6 +869,7 @@ static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
 		amdgpu_gart_bind(adev, gtt->offset, ttm->num_pages,
 				 gtt->ttm.dma_address, flags);
 	}
+	gtt->bound = true;
 }
 
 /*
-- 
2.43.0




