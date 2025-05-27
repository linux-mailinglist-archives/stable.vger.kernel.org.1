Return-Path: <stable+bounces-147543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B432AC5820
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BAE8A64DC
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1B71DC998;
	Tue, 27 May 2025 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EFu93gTf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB2542A9B;
	Tue, 27 May 2025 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367667; cv=none; b=bTwaM/VkLtivPVCXx77HBgIKoJE1mXJOnHQmDq4mTrkJwX8sGQ8kS5KIGGxCMkRDRdiAS+AlEOoWCgs9uSPSTMk7bes2AmS2N8LJkjZPrleaI51KBqEy++WsdSaBfGW9sxKfpucLjtcZBeo7MOKxiNPgOBVqNt4Vbcfj0YzCrzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367667; c=relaxed/simple;
	bh=NovsZaP5byCAaJMy9RMvr+FUJ4jg6CedExZheFL5//s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=go/Cjm0IjY+W8uTsiuj4s/I2lSLjCVap/jKHRfZ6vC+UfGxG3tCI0vxVTMARQPruQjveWFkIQazZw3/r4IXaXicuf/ZfPy8WeoB4zgZ+KkDEyR3LY91ww50T7yxlcjSjCKDxhxLx8XQcbGX4L7+hOK2uofvAAnKbplQPiawfE1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EFu93gTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5CFC4CEE9;
	Tue, 27 May 2025 17:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367667;
	bh=NovsZaP5byCAaJMy9RMvr+FUJ4jg6CedExZheFL5//s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EFu93gTfwwzBCTCP2RtH031fayI/NQz7sfqN7evgt2YFEb9tH8QvIhbUA/AVIyz67
	 RCb2J9ydhoFRQkvQXsSiw7jqGbL+zmkOXkGLg1p9d3EL/nwQ3M0LVvN5rvHiDX6IEm
	 esAMxr0R8wE5bkfCBGUaSqgovbcXYtuCxTFTdtBc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xin Wang <x.wang@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Fei Yang <fei.yang@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 461/783] drm/xe/debugfs: fixed the return value of wedged_mode_set
Date: Tue, 27 May 2025 18:24:18 +0200
Message-ID: <20250527162531.901982710@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Wang <x.wang@intel.com>

[ Upstream commit 6884d2051011f4db9e2f0b85709c79a8ced13bd6 ]

It is generally expected that the write() function should return a
positive value indicating the number of bytes written or a negative
error code if an error occurs. Returning 0 is unusual and can lead
to unexpected behavior.

When the user program writes the same value to wedged_mode twice in
a row, a lockup will occur, because the value expected to be
returned by the write() function inside the program should be equal
to the actual written value instead of 0.

To reproduce the issue:
echo 1 > /sys/kernel/debug/dri/0/wedged_mode
echo 1 > /sys/kernel/debug/dri/0/wedged_mode   <- lockup here

Signed-off-by: Xin Wang <x.wang@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Fei Yang <fei.yang@intel.com>
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250213223615.2327367-1-x.wang@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
index 492b4877433f1..6bfdd3a9913fd 100644
--- a/drivers/gpu/drm/xe/xe_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_debugfs.c
@@ -166,7 +166,7 @@ static ssize_t wedged_mode_set(struct file *f, const char __user *ubuf,
 		return -EINVAL;
 
 	if (xe->wedged.mode == wedged_mode)
-		return 0;
+		return size;
 
 	xe->wedged.mode = wedged_mode;
 
-- 
2.39.5




