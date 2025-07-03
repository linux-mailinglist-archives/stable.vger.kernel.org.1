Return-Path: <stable+bounces-160056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5B5AF7C10
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B734847AF
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B59F2EFD98;
	Thu,  3 Jul 2025 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D4ZphVrp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E3522069F;
	Thu,  3 Jul 2025 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556228; cv=none; b=ZNxFhVw7JTEm0pVDBeQeojsRlwKrUcrdpT7n6TcpNP5yI27lYZwP9/2D4AWXQR8ZEew8RdULv2U+jPQ1ucUou3Ptaz+2+DBMFGfb3t7P9WpRadggFxz05OdJdwCfrJRzNcMtoUZuXeKbhb7q2qqv5nXHuNK3KGBgG4Lic4PtQIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556228; c=relaxed/simple;
	bh=zRYXYeUAnpAr27w67NbMnuYJ+RoKKlPfMEirMchpDT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LnrDlXuVJDNZyIpKmt1mR3badmTc4iJRw4+I/qil5MbVGavhs9uX4Fi3F7qwYnmXomdv926++7A2g/u1sLLBc/729N3IrkSwljt9eCYzq+BvNhDX4oSmHsvOdr9KNj7w8r3DFDq4gxKk8bTqPS5jJgKx860p+NgFuhlN7rXFcpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D4ZphVrp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92358C4CEE3;
	Thu,  3 Jul 2025 15:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751556228;
	bh=zRYXYeUAnpAr27w67NbMnuYJ+RoKKlPfMEirMchpDT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D4ZphVrpVwAUpSUPCGx15X6Tg/VBN0/fzqVsxaEj7Sm/sq5F17/7i0m8L7DcipYTe
	 HTQC5V7LknpQF2F1aXXHO3xbvm8/bkHmzULYbIvGBWEmWcGcKZAf/oLg0YDCIEVZck
	 EM6PdCez2Oi9LNVIkRSU2xHOGFEoIdFace8jfwzE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Olender <john.olender@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH 6.1 114/132] drm/amdgpu: amdgpu_vram_mgr_new(): Clamp lpfn to total vram
Date: Thu,  3 Jul 2025 16:43:23 +0200
Message-ID: <20250703143943.865721127@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143939.370927276@linuxfoundation.org>
References: <20250703143939.370927276@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Olender <john.olender@gmail.com>

commit 4d2f6b4e4c7ed32e7fa39fcea37344a9eab99094 upstream.

The drm_mm allocator tolerated being passed end > mm->size, but the
drm_buddy allocator does not.

Restore the pre-buddy-allocator behavior of allowing such placements.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3448
Signed-off-by: John Olender <john.olender@gmail.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -396,7 +396,7 @@ static int amdgpu_vram_mgr_new(struct tt
 	int r;
 
 	lpfn = (u64)place->lpfn << PAGE_SHIFT;
-	if (!lpfn)
+	if (!lpfn || lpfn > man->size)
 		lpfn = man->size;
 
 	fpfn = (u64)place->fpfn << PAGE_SHIFT;



