Return-Path: <stable+bounces-165730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0386B1809A
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 13:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1011CA8440E
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 11:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F15242D66;
	Fri,  1 Aug 2025 11:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgqBk+K5"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777EA2405ED
	for <stable@vger.kernel.org>; Fri,  1 Aug 2025 11:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754046044; cv=none; b=mV+ARm0XS+t4gN7E33dqf3P5UNbnV8RwNRuu+5/1GY9hlz9tbaYU1Gx9cfYZj++s3eBYtZYRrRX3J6ttI+Nsr7ga+ehl9ByCwLVxXizaVcfAy0zSLWBZj4M/s7g0DCrprBvHcsPfDHCwOSKZtXGzyMkd7i47YkwMaDBhmiKGMdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754046044; c=relaxed/simple;
	bh=PF+7KTgtJOQe91aaQ4AfOOIWpw1FJ41ZDPQHlUzDbyg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dtBjA5SWu7zI9hdkH/9mDPgAJwu3dfpSWkNzEQpVWvIh5PPbFg6HG2EXR4SFBfMPPguh5cesecPyLcRuFrgN4WtCH0Vc2mMp267NVIJ95giUIGNc7ywL3o6XFj84gHlLy+XzFyPZcEXPJ8L48ApYP9AmUmXM4cfBntxp30JmvyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cgqBk+K5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754046041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Yy4oMG6QVFtodhwMcPtL7d4Z650yocP7F5ES6CSW5QU=;
	b=cgqBk+K5My+Ys6aMECZokStE8cPmpvdSZH21BK2GQ+sJfq4Hj8n63ZfxSOAgYJhpEqIYTR
	rl3dNJNRzupeIbElhbqWyo+nl2S+5YJIVBr4YQBMPtnAmU3frmpopMYbNjLIGMFSMrBpNG
	m4tPKhIF6nrftvYmX/GeqWHgphDH2Rg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-swfE5ckCPSekdCv3fAnP7w-1; Fri, 01 Aug 2025 07:00:38 -0400
X-MC-Unique: swfE5ckCPSekdCv3fAnP7w-1
X-Mimecast-MFC-AGG-ID: swfE5ckCPSekdCv3fAnP7w_1754046037
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b785aee904so837961f8f.2
        for <stable@vger.kernel.org>; Fri, 01 Aug 2025 04:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754046037; x=1754650837;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yy4oMG6QVFtodhwMcPtL7d4Z650yocP7F5ES6CSW5QU=;
        b=s11ECHxM7b3X78CwwgVvZE2n+rYmKY+V0BKGfDMGuKNRom75MiOSsu5Pbf4BPIgiWA
         JEI8U8jT2HE3gcQPfaYTykRqjBYPkqUQCFVZQ0eyG0hZRxRLqh5rOLKPiV9j77WPbBEC
         dHOgTo7PsIHzbgBKtrfM8OpScJSxFV0eaqAhfJN8n6keaBSD4RlyO4zyfH582C0J+f6y
         2kYGME3DcTnDNHPhlxdlKADYhneItYbKp1tcK7A1EGkz062ask0J2hk/559dOrgjfEj2
         XAfNEb24eQs/2EHxG+Jkpunz9xUs3kJ64AxppJLHvhwmhlre+nLrEpgwDrDMqFKvV99n
         zqSA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ2gRFUnGW0bHBtKdSgHALtW2HxKZEuCWXRozbf0CYOu963c6ZynW+B6w7bfI0ie4BoOdtcn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGAOdTioWl/TGsxg6a+n1K4Kmt7tT9xd/A6IxtUEo0BEm8pq4+
	N6F+j/26SSIkbjgczVjaGPcZZMEX/8o3CVc30CZjdPoCRhqMbRLbOJCxo8SW2RAOZtYPLlFAEzl
	4Qt42wDAwQb9CsmPSWhvYoEAdF/xP9qHOQtTk9kDQdZzYnkjO1/qZnOS0Mg==
X-Gm-Gg: ASbGncvOAjPhLm/uqYVJmDywmxU557tL2CAXH1wwJuRrt+8y48ebmgvfEHcexx9NdVh
	uzxywAYIhkGUZftK2DqpPbyA/0DfB1JueWMVc/myRhtxf/2qa3Y5tM1VEEQ9EC29Nr/kwyeyqKp
	dB2mEWTgdQnGmBamDbKcqyPVravRgi+Zv/JsPhU/euj+CtUUVh/OwlxlyIJTkZit1kepxfH4U0o
	o0dnIyj1fq8pvE5ndiUAj4uDuasvr/5kqxZPzjKFUGBLkAvxM8yXtmj58HWgDmj1PixKS0rpuRF
	LeqCeb5toOI8k1Hscr62QexToL/UykVn
X-Received: by 2002:adf:8b59:0:b0:3a6:d95e:f38c with SMTP id ffacd0b85a97d-3b79501e606mr6507424f8f.33.1754046036762;
        Fri, 01 Aug 2025 04:00:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSUPIJPkabuEQDBcH7GMaJaxabiVWOJ9YCOFkgGy6BbYI6a1t93zsxBqYtzSj23fHn5sb9Uw==
X-Received: by 2002:adf:8b59:0:b0:3a6:d95e:f38c with SMTP id ffacd0b85a97d-3b79501e606mr6507382f8f.33.1754046036194;
        Fri, 01 Aug 2025 04:00:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453ab0sm5624086f8f.44.2025.08.01.04.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 04:00:35 -0700 (PDT)
Date: Fri, 1 Aug 2025 07:00:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	acourbot@google.com, alok.a.tiwari@oracle.com,
	anders.roxell@linaro.org, dtatulea@nvidia.com, eperezma@redhat.com,
	eric.auger@redhat.com, gnurou@gmail.com, jasowang@redhat.com,
	jonah.palmer@oracle.com, kraxel@redhat.com, leiyang@redhat.com,
	linux@treblig.org, lulu@redhat.com, michael.christie@oracle.com,
	mst@redhat.com, parav@nvidia.com, si-wei.liu@oracle.com,
	stable@vger.kernel.org, viresh.kumar@linaro.org,
	wangyuli@uniontech.com, will@kernel.org, wquan@redhat.com,
	xiaopei01@kylinos.cn
Subject: [GIT PULL] virtio, vhost: features, fixes
Message-ID: <20250801070032-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf1911:

  Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to c7991b44d7b44f9270dec63acd0b2965d29aab43:

  vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers (2025-07-17 08:33:09 -0400)

----------------------------------------------------------------
virtio, vhost: features, fixes

vhost can now support legacy threading
	if enabled in Kconfig
vsock memory allocation strategies for
	large buffers have been improved,
	reducing pressure on kmalloc
vhost now supports the in-order feature
	guest bits missed the merge window

fixes, cleanups all over the place

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alexandre Courbot (1):
      media: add virtio-media driver

Alok Tiwari (4):
      virtio: Fix typo in register_virtio_device() doc comment
      vhost-scsi: Fix typos and formatting in comments and logs
      vhost: Fix typos
      vhost-scsi: Fix check for inline_sg_cnt exceeding preallocated limit

Anders Roxell (1):
      vdpa: Fix IDR memory leak in VDUSE module exit

Cindy Lu (1):
      vhost: Reintroduce kthread API and add mode selection

Dr. David Alan Gilbert (2):
      vhost: vringh: Remove unused iotlb functions
      vhost: vringh: Remove unused functions

Dragos Tatulea (2):
      vdpa/mlx5: Fix needs_teardown flag calculation
      vdpa/mlx5: Fix release of uninitialized resources on error path

Gerd Hoffmann (1):
      drm/virtio: implement virtio_gpu_shutdown

Jason Wang (3):
      vhost: fail early when __vhost_add_used() fails
      vhost: basic in order support
      vhost_net: basic in_order support

Michael S. Tsirkin (6):
      virtio: document ENOSPC
      pci: report surprise removal event
      virtio: fix comments, readability
      virtio: pack config changed flags
      virtio: allow transports to suppress config change
      virtio: support device disconnect

Mike Christie (1):
      vhost-scsi: Fix log flooding with target does not exist errors

Pei Xiao (1):
      vhost: Use ERR_CAST inlined function instead of ERR_PTR(PTR_ERR(...))

Viresh Kumar (2):
      virtio-mmio: Remove virtqueue list from mmio device
      virtio-vdpa: Remove virtqueue list

WangYuli (1):
      virtio: virtio_dma_buf: fix missing parameter documentation

Will Deacon (9):
      vhost/vsock: Avoid allocating arbitrarily-sized SKBs
      vsock/virtio: Validate length in packet header before skb_put()
      vsock/virtio: Move length check to callers of virtio_vsock_skb_rx_put()
      vsock/virtio: Resize receive buffers so that each SKB fits in a 4K page
      vsock/virtio: Rename virtio_vsock_alloc_skb()
      vsock/virtio: Move SKB allocation lower-bound check to callers
      vhost/vsock: Allocate nonlinear SKBs for handling large receive buffers
      vsock/virtio: Rename virtio_vsock_skb_rx_put()
      vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers

 MAINTAINERS                                |    6 +
 drivers/gpu/drm/virtio/virtgpu_drv.c       |    8 +-
 drivers/media/Kconfig                      |   13 +
 drivers/media/Makefile                     |    2 +
 drivers/media/virtio/Makefile              |    9 +
 drivers/media/virtio/protocol.h            |  288 ++++++
 drivers/media/virtio/scatterlist_builder.c |  563 ++++++++++++
 drivers/media/virtio/scatterlist_builder.h |  111 +++
 drivers/media/virtio/session.h             |  109 +++
 drivers/media/virtio/virtio_media.h        |   93 ++
 drivers/media/virtio/virtio_media_driver.c |  959 ++++++++++++++++++++
 drivers/media/virtio/virtio_media_ioctls.c | 1297 ++++++++++++++++++++++++++++
 drivers/pci/pci.h                          |    6 +
 drivers/vdpa/mlx5/core/mr.c                |    3 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c          |   12 +-
 drivers/vdpa/vdpa_user/vduse_dev.c         |    1 +
 drivers/vhost/Kconfig                      |   18 +
 drivers/vhost/net.c                        |   88 +-
 drivers/vhost/scsi.c                       |   24 +-
 drivers/vhost/vhost.c                      |  377 +++++++-
 drivers/vhost/vhost.h                      |   30 +-
 drivers/vhost/vringh.c                     |  118 ---
 drivers/vhost/vsock.c                      |   15 +-
 drivers/virtio/virtio.c                    |   25 +-
 drivers/virtio/virtio_dma_buf.c            |    2 +
 drivers/virtio/virtio_mmio.c               |   52 +-
 drivers/virtio/virtio_pci_common.c         |   45 +
 drivers/virtio/virtio_pci_common.h         |    3 +
 drivers/virtio/virtio_pci_legacy.c         |    2 +
 drivers/virtio/virtio_pci_modern.c         |    2 +
 drivers/virtio/virtio_ring.c               |    4 +
 drivers/virtio/virtio_vdpa.c               |   44 +-
 include/linux/pci.h                        |   45 +
 include/linux/virtio.h                     |   13 +-
 include/linux/virtio_config.h              |   32 +
 include/linux/virtio_vsock.h               |   46 +-
 include/linux/vringh.h                     |   12 -
 include/uapi/linux/vhost.h                 |   29 +
 include/uapi/linux/virtio_ids.h            |    1 +
 kernel/vhost_task.c                        |    2 +-
 net/vmw_vsock/virtio_transport.c           |   20 +-
 net/vmw_vsock/virtio_transport_common.c    |    3 +-
 42 files changed, 4186 insertions(+), 346 deletions(-)
 create mode 100644 drivers/media/virtio/Makefile
 create mode 100644 drivers/media/virtio/protocol.h
 create mode 100644 drivers/media/virtio/scatterlist_builder.c
 create mode 100644 drivers/media/virtio/scatterlist_builder.h
 create mode 100644 drivers/media/virtio/session.h
 create mode 100644 drivers/media/virtio/virtio_media.h
 create mode 100644 drivers/media/virtio/virtio_media_driver.c
 create mode 100644 drivers/media/virtio/virtio_media_ioctls.c


