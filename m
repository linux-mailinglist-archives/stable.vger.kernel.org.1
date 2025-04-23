Return-Path: <stable+bounces-135935-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B02DAA99175
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E22718869D2
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C712228468D;
	Wed, 23 Apr 2025 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Arx3bqTt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865CA284692;
	Wed, 23 Apr 2025 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421225; cv=none; b=FxDtynv8Zj+K1eGxk+PEqp8qIMIvTsEl2Fxv8Wv4AtWksSgEw8jlO4LPLb3aLv/twn256ZE3vAiVvpmFdH+YuQekm3+odaWfddSvZ3Ndg+G57KlzgtnQGgA4EulkX+NNNDmJGjf4LaVQXr+ThQZRvabFzKaX415TNZRt6AfEGhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421225; c=relaxed/simple;
	bh=imQYqYu3jr5A8TbwHLJTQE4D9oAundoEQSpt5YIeY94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5Yko7alUZQf3N+Lhdzl8ioz0dbQLa+QSIt1PI08vpaAGYltdyhH5sIKViIPB4I+UJRiayHzYWl7AyZ8a5DZHGnBFxiyBaJ1xSZGQHkRijg4rxeV+Sioxdc8VNxpiBUEgSBZT+UVVmHVAp70MRN6VFwPi6nlzJynbnftOMHu7S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Arx3bqTt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BFDC4CEE2;
	Wed, 23 Apr 2025 15:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745421225;
	bh=imQYqYu3jr5A8TbwHLJTQE4D9oAundoEQSpt5YIeY94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Arx3bqTtT8YejrMI3s4mcrEjpiYFpdldIA1b+dK2lUvsNfMGOfh9+pgD/VCbok+yU
	 C5gp8TD9mk8SyumlG92TbBQ4nY0JwM1Xx51gGI0S4nMPIpvOGQ3dITdvdp7RdrhMgS
	 20oZKjUzd8BsdHdD4Yzsnst3kfYNR0D1mi+95pQg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.6 138/393] media: platform: stm32: Add check for clk_enable()
Date: Wed, 23 Apr 2025 16:40:34 +0200
Message-ID: <20250423142649.076862001@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -492,7 +492,8 @@ static void device_run(void *prv)
 	dst->sequence = frm_cap->sequence++;
 	v4l2_m2m_buf_copy_metadata(src, dst, true);
 
-	clk_enable(dev->gate);
+	if (clk_enable(dev->gate))
+		goto end;
 
 	dma2d_config_fg(dev, frm_out,
 			vb2_dma_contig_plane_dma_addr(&src->vb2_buf, 0));



