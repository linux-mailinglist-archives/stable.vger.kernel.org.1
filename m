Return-Path: <stable+bounces-129928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4BDA80268
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143A4173010
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0E2263C90;
	Tue,  8 Apr 2025 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="la4eEWDg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD02224AEB;
	Tue,  8 Apr 2025 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112353; cv=none; b=r4bVnBtIcMvQqIPXvkqfWR2IOyS+VoVivjbHdiVgXXq1YkuLEllKGiTRZuO70TudjUB9lN4mHKCAlIDCUxU0gp58SBMtM4nzkY1fpJIiHBoOtJ46XdafFDidwnIHEauMMomNHBiMGLVcVfQVDQlWyy/xI+jMvVKF/IByAHy2TcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112353; c=relaxed/simple;
	bh=o+cP/HU412XmaGVi3FEQZZovcMRU/O4hKUif3rcJt6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWqqiP9OGccEIgUC6xUFkMmIUtNlPEfk07N+UaSRB/e3V4mx4GdAhykQHyAN6QY+JH/gPiRh0vEwaVdoKbgzMS7yj9nNCPGPz4NpruyXr3EICxNwTtn1d1ur7l7aaotZyddn9vo4FPQjBIYKZBpGoNYaA1rYn9JQlE3AT4dzekM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=la4eEWDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5933AC4CEE5;
	Tue,  8 Apr 2025 11:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112353;
	bh=o+cP/HU412XmaGVi3FEQZZovcMRU/O4hKUif3rcJt6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=la4eEWDgv3vvlGkw8uGX7eOjWYS+GIVwhMiwXsdpP/7rHmjsB1oSUiW6Mdq+Ceb7W
	 qGg1A3KhoM3o5HVh6MHoPkNSmt+46L7I4yaEtTtjtdGzJFU5W0ZtJroMfdVQVjRzXk
	 02VBByTIkqqUGAX0jdHPCykeywF8TboSlfSOL/SY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Kelley <mhklinux@outlook.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 005/279] fbdev: hyperv_fb: iounmap() the correct memory when removing a device
Date: Tue,  8 Apr 2025 12:46:28 +0200
Message-ID: <20250408104826.497012446@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104826.319283234@linuxfoundation.org>
References: <20250408104826.319283234@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Kelley <mhklinux@outlook.com>

[ Upstream commit 7241c886a71797cc51efc6fadec7076fcf6435c2 ]

When a Hyper-V framebuffer device is removed, or the driver is unbound
from a device, any allocated and/or mapped memory must be released. In
particular, MMIO address space that was mapped to the framebuffer must
be unmapped. Current code unmaps the wrong address, resulting in an
error like:

[ 4093.980597] iounmap: bad address 00000000c936c05c

followed by a stack dump.

Commit d21987d709e8 ("video: hyperv: hyperv_fb: Support deferred IO for
Hyper-V frame buffer driver") changed the kind of address stored in
info->screen_base, and the iounmap() call in hvfb_putmem() was not
updated accordingly.

Fix this by updating hvfb_putmem() to unmap the correct address.

Fixes: d21987d709e8 ("video: hyperv: hyperv_fb: Support deferred IO for Hyper-V frame buffer driver")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250209235252.2987-1-mhklinux@outlook.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <20250209235252.2987-1-mhklinux@outlook.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/hyperv_fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 6a881cfd7f5c0..5fd1b33d11238 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1130,7 +1130,7 @@ static void hvfb_putmem(struct hv_device *hdev, struct fb_info *info)
 
 	if (par->need_docopy) {
 		vfree(par->dio_vp);
-		iounmap(info->screen_base);
+		iounmap(par->mmio_vp);
 		vmbus_free_mmio(par->mem->start, screen_fb_size);
 	} else {
 		hvfb_release_phymem(hdev, info->fix.smem_start,
-- 
2.39.5




