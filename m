Return-Path: <stable+bounces-128969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8525A7FD70
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95CFB1663A1
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 10:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0BE26981A;
	Tue,  8 Apr 2025 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AugwBjUc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76557266B4B;
	Tue,  8 Apr 2025 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744109765; cv=none; b=EL3TdC0+vgOp9BwjLcrIJL0BpnO8pwAT12JVwgQGCMsHFSV/1eESkitOcevMCSm1SC5xBOeeXtiErT0h5J7ELEIadO+ihwgJXLLNXhBKkynuzGcEqFJ3WoUM4b5vLwcLeUOFgb+2hSod9n+yTyhKU30iG99trTndMukPVoEssYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744109765; c=relaxed/simple;
	bh=RsrR7QSOShDvUonAHmtezU5k4A+nOk8XHb6GrCfFODY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9i/9nooR9vUu+6P9EVkyOEqBX+8vJGQ3/WJ/Y6FZLdluj9BAxrifNQtH4LBnedwOJSGU8CWRINWrBsn64dDTPyV2snol01VAejDxmEOouvUP1l3lia1KV1N5ontm13HuFo49PK3o4H9xWEw3ZQOUFasQG32bQ5x0a7PgBIrOL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AugwBjUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CDFC4CEE5;
	Tue,  8 Apr 2025 10:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744109765;
	bh=RsrR7QSOShDvUonAHmtezU5k4A+nOk8XHb6GrCfFODY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AugwBjUclzWTWiBMtaRocp+SpMBoJKdRbvfltVNTwgD0hXsV052XyJ86UdzRMqoha
	 qI32hL91PdLEv43llK8vSiVe5o9gVLUzklkoG066fP7Vj2pf7umsF2HtVJvGtg+o06
	 svmruBYfBOAKUBh3fuVX/d7COVCWeIVBQ1/IE4QY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Kelley <mhklinux@outlook.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 007/227] fbdev: hyperv_fb: iounmap() the correct memory when removing a device
Date: Tue,  8 Apr 2025 12:46:25 +0200
Message-ID: <20250408104820.597859488@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.353768086@linuxfoundation.org>
References: <20250408104820.353768086@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index f0a66a344d870..d523cd4de9d47 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1129,7 +1129,7 @@ static void hvfb_putmem(struct hv_device *hdev, struct fb_info *info)
 
 	if (par->need_docopy) {
 		vfree(par->dio_vp);
-		iounmap(info->screen_base);
+		iounmap(par->mmio_vp);
 		vmbus_free_mmio(par->mem->start, screen_fb_size);
 	} else {
 		hvfb_release_phymem(hdev, info->fix.smem_start,
-- 
2.39.5




