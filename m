Return-Path: <stable+bounces-134285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094ACA92A34
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0358C17A0B9
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5926F256C95;
	Thu, 17 Apr 2025 18:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TfyunCxZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E4B256C7B;
	Thu, 17 Apr 2025 18:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915662; cv=none; b=mcP1OMZjTcwjtvJDxOCMnDyh/30I8TPVi8GN3yJ6IVACjUdPz46ZyiRLbN427g3XYLYIs++haH/Ru4ixEEbZFr8Kisis4t6a1aiBqO6p6Kr4fF+Y9EtEgro9bgqcm0uSGaEzyTQ4GA8Ic/n2/pIXDKLbanXyfCdzMboAsKVOPPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915662; c=relaxed/simple;
	bh=SRHO5g19/Dp6ez5Pvn4NPf5npocqNpZ7DwdHV7+1SJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXCb0CmNbiRXOHAYnWaEIQCKVS5fQyekIoV7lpgMSsNETYTVUCv0gvfigFuVNKXXs7KQMR/PBV9UratTNU0V0ymu2uPyBjK/Y7/XvpSNCporAyLr4HSn/t34niPeEXFumXlfTekKgCy5WtlQGI0nC2cwxFoC7rSd5vYnxO5n2Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TfyunCxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7820AC4CEEA;
	Thu, 17 Apr 2025 18:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744915662;
	bh=SRHO5g19/Dp6ez5Pvn4NPf5npocqNpZ7DwdHV7+1SJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TfyunCxZOJZPPWI4LenftArdpXatG5v7fhzsHV1kbE+vu4wLcUwrjxt5ClGGJQyKW
	 DAO+nKmX/B/agYMNV/uNHqSZtvb0vApe3UIJFWNgWWRqsdl9LFF29Q98dXw1juujE2
	 HdmaG4WF+u1zaaSLwjAn/VdaQWkcXvGGWOrSo9kE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Keeping <jkeeping@inmusicbrands.com>,
	Michael Tretter <m.tretter@pengutronix.de>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 6.12 200/393] media: rockchip: rga: fix rga offset lookup
Date: Thu, 17 Apr 2025 19:50:09 +0200
Message-ID: <20250417175115.631918859@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Keeping <jkeeping@inmusicbrands.com>

commit 11de3582675cc0b7136e12f3971f1da3e5a05382 upstream.

The arguments to rga_lookup_draw_pos() are passed in the wrong order,
rotate mode should be before mirror mode.

Fixes: 558c248f930e6 ("media: rockchip: rga: split src and dst buffer setup")
Cc: stable@vger.kernel.org
Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
Reviewed-by: Michael Tretter <m.tretter@pengutronix.de>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/rockchip/rga/rga-hw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/platform/rockchip/rga/rga-hw.c
+++ b/drivers/media/platform/rockchip/rga/rga-hw.c
@@ -376,7 +376,7 @@ static void rga_cmd_set_dst_info(struct
 	 * Configure the dest framebuffer base address with pixel offset.
 	 */
 	offsets = rga_get_addr_offset(&ctx->out, offset, dst_x, dst_y, dst_w, dst_h);
-	dst_offset = rga_lookup_draw_pos(&offsets, mir_mode, rot_mode);
+	dst_offset = rga_lookup_draw_pos(&offsets, rot_mode, mir_mode);
 
 	dest[(RGA_DST_Y_RGB_BASE_ADDR - RGA_MODE_BASE_REG) >> 2] =
 		dst_offset->y_off;



