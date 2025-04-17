Return-Path: <stable+bounces-133466-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B88A925DF
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36ED21B62612
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CCA25C712;
	Thu, 17 Apr 2025 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pwGUsTzw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB81425B678;
	Thu, 17 Apr 2025 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913163; cv=none; b=bUdeOq53e49cfcBD9/ZU1BO0sX4XPZ1Qpo6AhB0EcX8eX1v4k/SZzegPpVPzhU7IuurhOI5TrKs3ddGPgP9KE8sq83roua3JpcpE1Ol0z98iyXelwem+Gk2UJ0SeUqWfptQhxLHWQDqMD8n/ohAUIKWph/QH0ak3NTZUjQzyjxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913163; c=relaxed/simple;
	bh=U46hZxOVGXYm5sWurr6GixRyKhqeLIb2RQ6vdI7D1kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWORddXdZXNSaggKv2hdQMNvvbcRH3DzjRWm9kq0/cW8IjognCmfblu+4eT6OkUTAlBAeBkZQWPJuJs1Db0RvQ5/sXkDQg7XUTb60WpcDb+q+8QMdPdTiQB59u4fSFIshFyB7rBLQ6sxeASpR0PpRXX99ZTO2ahL5pRyE7lhsKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pwGUsTzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326E9C4CEE4;
	Thu, 17 Apr 2025 18:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744913163;
	bh=U46hZxOVGXYm5sWurr6GixRyKhqeLIb2RQ6vdI7D1kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pwGUsTzwsFPB8zNqcZATLXPFb/UCbmn9mJ0qYndkGm4sTsrB7F9LibUvjkKApgJ8l
	 ZrlRUe3wzoVQkExsp9Hn18fnGhQkctnSBBDRnyHZZYab2mAhpjJNNzyRexZjAPqOV9
	 pY3km0PIlHKj2Q/XxXTU9UvNLOMEWwUZdupU7Z68=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.14 247/449] media: platform: stm32: Add check for clk_enable()
Date: Thu, 17 Apr 2025 19:48:55 +0200
Message-ID: <20250417175127.936381330@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
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

From: Jiasheng Jiang <jiashengjiangcool@gmail.com>

commit f883f34b6a46b1a09d44d7f94c3cd72fe0e8f93b upstream.

Add check for the return value of clk_enable() to gurantee the success.

Fixes: 002e8f0d5927 ("media: stm32-dma2d: STM32 DMA2D driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/st/stm32/dma2d/dma2d.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/media/platform/st/stm32/dma2d/dma2d.c
+++ b/drivers/media/platform/st/stm32/dma2d/dma2d.c
@@ -490,7 +490,8 @@ static void device_run(void *prv)
 	dst->sequence = frm_cap->sequence++;
 	v4l2_m2m_buf_copy_metadata(src, dst, true);
 
-	clk_enable(dev->gate);
+	if (clk_enable(dev->gate))
+		goto end;
 
 	dma2d_config_fg(dev, frm_out,
 			vb2_dma_contig_plane_dma_addr(&src->vb2_buf, 0));



