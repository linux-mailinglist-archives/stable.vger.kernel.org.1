Return-Path: <stable+bounces-65680-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6F594AB6F
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 17:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E85E1C21030
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 15:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701D312BF24;
	Wed,  7 Aug 2024 15:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vp924JJ9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3CC82D66;
	Wed,  7 Aug 2024 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043119; cv=none; b=mfXEBKyVMyoc0x1pFUJpYhtHFbq0DP6V7qW77VVoYp6wwoXmEdiIBtoOPnYouqJjh89JjISoZ/HRGDm6PPiIZbLV0csFqCmLGdryintsMCmmC/hPpALIxcFvfTzY3i0/Krb2busjQdI4YjkzW1vXqr/gSsMVU4WoS8u8Wne3xJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043119; c=relaxed/simple;
	bh=Atw+c+YDH/tPH122ZS3QLnoV6LCdyyJPIwOxM3q5BGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlsbEzWOY/GBtOFr7pFurqHxO3rqOBs9C5v4wOUi9bxJAIXhx8aw4mxTmP3JGazcSg4ucgvIUZ6QC2nCxa2HEoGoGuWx3mOjTbsnbKE0n8477q8ISgDhEcWjjADBHUPEEW1jsOoy0tuJvu0eEc/kFo5KQBlVhkqPL0Cc77JVIV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vp924JJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C092C4AF0B;
	Wed,  7 Aug 2024 15:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723043118;
	bh=Atw+c+YDH/tPH122ZS3QLnoV6LCdyyJPIwOxM3q5BGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vp924JJ9c/YENh/OFi3ieQKc4Oxzw/CAZwW7h0yZGwX31Sz5RL3IunE/ebpx/TODa
	 B2b7XxbMDnFpRVpKZC63eikYuS3NMl39S0AX6E5UKWvJ9+Xm7TL9ZKXmpbZY7rmH9K
	 18OVD3Q8mKtTPY8uE/E2w71sVge1fDqLruysjebE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Rob Clark <robdclark@gmail.com>
Subject: [PATCH 6.10 096/123] drm/virtio: Fix type of dma-fence context variable
Date: Wed,  7 Aug 2024 17:00:15 +0200
Message-ID: <20240807150023.935781708@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807150020.790615758@linuxfoundation.org>
References: <20240807150020.790615758@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

commit 445d336cd15860f1efb441e6d694f829fbf679eb upstream.

Type of DMA fence context is u64. Fence-waiting code uses u32 for the
context variable, fix it.

Fixes: e4812ab8e6b1 ("drm/virtio: Refactor and optimize job submission code path")
Cc: <stable@vger.kernel.org> # v6.4+
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Reviewed-by: Rob Clark <robdclark@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240714205009.3408298-1-dmitry.osipenko@collabora.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/virtio/virtgpu_submit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/virtio/virtgpu_submit.c
+++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
@@ -48,7 +48,7 @@ struct virtio_gpu_submit {
 static int virtio_gpu_do_fence_wait(struct virtio_gpu_submit *submit,
 				    struct dma_fence *in_fence)
 {
-	u32 context = submit->fence_ctx + submit->ring_idx;
+	u64 context = submit->fence_ctx + submit->ring_idx;
 
 	if (dma_fence_match_context(in_fence, context))
 		return 0;



