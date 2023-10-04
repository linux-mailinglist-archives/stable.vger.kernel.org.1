Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B2E7B8982
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244200AbjJDS0z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244388AbjJDS0s (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:26:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08509E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:26:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2CFC433C7;
        Wed,  4 Oct 2023 18:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444004;
        bh=OS0D8zgQGFK5gZNGIJAbaHzrcFsNYKUMMuFuKHYqYQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jo4QQDoN5aJq4cgBIjBCBEHAZPohfib5OKgsGKYrD4EGAJFn/Yd2vpDSm6+kJDHJP
         +LCPfOPXamLF4/StcMlkFKM3SuernHyrSu6uInya0mg+3DslhHKMWLadPN61juUnW/
         vd+EYyA3AsHK4dNLQZAHsyasqGMbFepyFQVHOSTE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 097/321] drm/virtio: clean out_fence on complete_submit
Date:   Wed,  4 Oct 2023 19:54:02 +0200
Message-ID: <20231004175233.720238362@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: José Pekkarinen <jose.pekkarinen@foxhound.fi>

[ Upstream commit 4556b93f6c026c62c93e7acc22838224ac2e2eba ]

The removed line prevents the following cleanup function
to execute a dma_fence_put on the out_fence to free its
memory, producing the following output in kmemleak:

unreferenced object 0xffff888126d8ee00 (size 128):
  comm "kwin_wayland", pid 981, jiffies 4295380296 (age 390.060s)
  hex dump (first 32 bytes):
    c8 a1 c2 27 81 88 ff ff e0 14 a9 c0 ff ff ff ff  ...'............
    30 1a e1 2e a6 00 00 00 28 fc 5b 17 81 88 ff ff  0.......(.[.....
  backtrace:
    [<0000000011655661>] kmalloc_trace+0x26/0xa0
    [<0000000055f15b82>] virtio_gpu_fence_alloc+0x47/0xc0 [virtio_gpu]
    [<00000000fa6d96f9>] virtio_gpu_execbuffer_ioctl+0x1a8/0x800 [virtio_gpu]
    [<00000000e6cb5105>] drm_ioctl_kernel+0x169/0x240 [drm]
    [<000000005ad33e27>] drm_ioctl+0x399/0x6b0 [drm]
    [<00000000a19dbf65>] __x64_sys_ioctl+0xc5/0x100
    [<0000000011fa801e>] do_syscall_64+0x5b/0xc0
    [<0000000065c76d8a>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8
unreferenced object 0xffff888121930500 (size 128):
  comm "kwin_wayland", pid 981, jiffies 4295380313 (age 390.096s)
  hex dump (first 32 bytes):
    c8 a1 c2 27 81 88 ff ff e0 14 a9 c0 ff ff ff ff  ...'............
    f9 ec d7 2f a6 00 00 00 28 fc 5b 17 81 88 ff ff  .../....(.[.....
  backtrace:
    [<0000000011655661>] kmalloc_trace+0x26/0xa0
    [<0000000055f15b82>] virtio_gpu_fence_alloc+0x47/0xc0 [virtio_gpu]
    [<00000000fa6d96f9>] virtio_gpu_execbuffer_ioctl+0x1a8/0x800 [virtio_gpu]
    [<00000000e6cb5105>] drm_ioctl_kernel+0x169/0x240 [drm]
    [<000000005ad33e27>] drm_ioctl+0x399/0x6b0 [drm]
    [<00000000a19dbf65>] __x64_sys_ioctl+0xc5/0x100
    [<0000000011fa801e>] do_syscall_64+0x5b/0xc0
    [<0000000065c76d8a>] entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[...]

This memleak will grow quickly, being possible to see the
following line in dmesg after few minutes of life in the
virtual machine:

[  706.217388] kmemleak: 10731 new suspected memory leaks (see /sys/kernel/debug/kmemleak)

The patch will remove the line to allow the cleanup
function do its job.

Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
Fixes: e4812ab8e6b1 ("drm/virtio: Refactor and optimize job submission code path")
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230912060824.5210-1-jose.pekkarinen@foxhound.fi
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_submit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
index 1d010c66910d8..aa61e7993e21b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_submit.c
+++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
@@ -147,7 +147,6 @@ static void virtio_gpu_complete_submit(struct virtio_gpu_submit *submit)
 	submit->buf = NULL;
 	submit->buflist = NULL;
 	submit->sync_file = NULL;
-	submit->out_fence = NULL;
 	submit->out_fence_fd = -1;
 }
 
-- 
2.40.1



