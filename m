Return-Path: <stable+bounces-65815-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE88D94AC08
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 17:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D7B282347
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 15:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F118287E;
	Wed,  7 Aug 2024 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eXqOqFIT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6D3823A9;
	Wed,  7 Aug 2024 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043482; cv=none; b=r2k6zb6g0KB9EOdg8sH/GCdsX6BmxniHDnszjmCSKAa5dEpvP61kUsWoNeHcv+rNqf9zqnsrDIpo7Q45FLlleZ+BHWhHXo9nm+i3k+F/+PKBOEUHNhWz120qOg0Zvx1S1Unp1AOZUDRVIWbLvbyCnTk61AFi2THR0KROsu7NTAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043482; c=relaxed/simple;
	bh=3zl79XewRxpgWaezV1O+fqJQjjNzuP8NBT5OJNxPHmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgKBVFKZlMfzmOI8OswQU6vj7icARy+67Pjmw0us+vMSgHWyvaOU4ifWsMit/LdxtcpIYTNrpwH1tV7a65PorDYqYtk0LlXCv/EKgxsTGva/6NNrPRSL4ukZCavOx3g1JMC4R7aU+yTpPh1QA3OaY/kIUUgFFqv0wQ6aftyJPPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eXqOqFIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A22C32781;
	Wed,  7 Aug 2024 15:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723043482;
	bh=3zl79XewRxpgWaezV1O+fqJQjjNzuP8NBT5OJNxPHmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eXqOqFIT7cY/DkhYwkYfAZBNkNsGBZHwl/fZ0JMl3BG0uGPI3E7vgqXZHpES6o/ft
	 WfFEqE4jmcoyWmKqzTxGb3QAnnkXl45HgaMrYpwiI4IOX1pYKfmOTuoQz/bkED2jwg
	 C0ZNM49TTuWSXwA0n77QPk6tL3iH4Hu2lF9MZJLU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Rob Clark <robdclark@gmail.com>
Subject: [PATCH 6.6 107/121] drm/virtio: Fix type of dma-fence context variable
Date: Wed,  7 Aug 2024 17:00:39 +0200
Message-ID: <20240807150022.899735746@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240807150019.412911622@linuxfoundation.org>
References: <20240807150019.412911622@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/gpu/drm/virtio/virtgpu_submit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
index 1c7c7f61a222..7d34cf83f5f2 100644
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
-- 
2.46.0




