Return-Path: <stable+bounces-165740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA63B18232
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 15:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EF7D1C247CB
	for <lists+stable@lfdr.de>; Fri,  1 Aug 2025 13:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F3F248F4D;
	Fri,  1 Aug 2025 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKzIlzyd"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CEC33D8
	for <stable@vger.kernel.org>; Fri,  1 Aug 2025 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754054007; cv=none; b=p7+gwWG+xJnCnnHGN64whMN18HKHPlvf1w6pBrIOmY3lh9O3fpz1SLPod8mSjvHZM4+v6ojqxWuTAtyZgx3f/y6L9WykasL0nTIdTbYV7UCfcu8r5kZnxsAcsMFxWkmmnLj6GVSC6dGqV5ioP9yx/k1NFq4ef3iCqBhwuHrCgi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754054007; c=relaxed/simple;
	bh=NDqaf9lbxEaRm64yxxyEsy03EPkdWuBKt9nEAdu2dVk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=myvDzW+lRWUXPweWVIZJMp0PAMpIusauF1iJmCe5ErqX/P03UK/oKUJxGQRULH924ONeKNaKCID6ouqEQT16jux8FHjVR6r70DMhi8sdhVWoozlNTl6RZztq8CP5A0+AlQaFDwuod2O8TN/vexnj494F3VXyur4o9ObeO58nmDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CKzIlzyd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754054005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=cw5+teQN0AMP87x3H2Uh+QGhf4VtRQnjJ3fqJ5dQbO0=;
	b=CKzIlzydDaqyGStAMOLNKWdg7Q3+r/Qgi557YRSG4edyDuZD7XWoj8n9kRUIqCXnVUq+k+
	+WoqporQN9E/WVUVkDCsxc+1aL9PVsKPRU1R8ROkZaC8EdLXR4zvAKuYwqHOFfN788EDgT
	VzroxEmqiuNp7O6tLpoI5z+/vwTAEFc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-mWvLRLAqOF-0osWF57kvtQ-1; Fri, 01 Aug 2025 09:13:23 -0400
X-MC-Unique: mWvLRLAqOF-0osWF57kvtQ-1
X-Mimecast-MFC-AGG-ID: mWvLRLAqOF-0osWF57kvtQ_1754054003
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b78329f007so912870f8f.1
        for <stable@vger.kernel.org>; Fri, 01 Aug 2025 06:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754054002; x=1754658802;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cw5+teQN0AMP87x3H2Uh+QGhf4VtRQnjJ3fqJ5dQbO0=;
        b=uSfp6kO2VF42wdIJvVcCbOfa74K62GnfcqhX8RSt+2npSyGkNldahO5kIopoq/LFLd
         5FzLKRRlOxNkWb+y9G294KYzp7FdfeSYq1GniH1uR0KwSWp+GvrhtY2Y0Mcx6PlpK3wx
         wMpPbGrDCAOfNn54rnmeGMOfMLJptpjLqGM5IGJ2HAoaeo5JcpFTAR1TVpd4HVmBa6yy
         pVs2W3LBnKtpaazUUngeEAsybwSnnhzvHSaqUd7k4KLsXU5FoZGOrnJ7/Ts4tOgWldJR
         X+bT6tkSFCXnuZk3X449uNdGcqg/j8M6n71jGbfdKHmuV2fabzALpMZAMCvK0oeF0jZl
         9tuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXO7SFsqqsu+WUfegDV3GQjjzwgbm/t0R/up330sXZmRuA5+m7in6kU1qdk88m/WdAx8zHV/0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2tEcJ/NcNmzHFczxgQ6WKucGsKb/urKKJfFdV5uHJQolSbHBv
	KrKAYgdn6ax1Trn0kQujCN4FZ7UtfmWNb1RVH2yoQeZowy4g68X7Og0vpyv6SuZMvaNpbGZGcCZ
	R9OyJ3qZian4hbYQ5seo1+oTJ312SjBcTn6ET3Fg68zHOQpfJTAZyFZdsDA==
X-Gm-Gg: ASbGncvVGJ3zg93qKberpkw3xmCDZliEtd0QB+TdygKRj6/m6xSEs4CgJOo7LWetsZ7
	MzxXXBKCgGke0GrFNO5UlNkSwRy5jh0fEqQQsZopYsJLfpg2BQOjSN1O77wfeIXc2AjP2Z/mUI5
	XeL1dGf7DiptOISr5yKUjEI/5EW5nX9L5gcjmycuPv5TpOc9AClMdwUIP1jhFfTbgNhdsFu6WkY
	9KfxfWJgl8xIkMJmtlu4BMqVxImPNMRFpOSXpYVLaNqSJqXKtxiGvtjE65mnJUBaf6ybLRS9lOo
	u+s1R46ZLt4pobabV1gceNC/EhiVZyXx
X-Received: by 2002:a05:6000:2311:b0:3b7:81a6:45c1 with SMTP id ffacd0b85a97d-3b794fc2b76mr8552806f8f.6.1754054002338;
        Fri, 01 Aug 2025 06:13:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ3kgk/LB9Em5/+L4oKnLTGpba8hhaIHh5AL+aBInP59wFrNOjQfBJh5ZGXhgf1vfWGUgM8w==
X-Received: by 2002:a05:6000:2311:b0:3b7:81a6:45c1 with SMTP id ffacd0b85a97d-3b794fc2b76mr8552779f8f.6.1754054001893;
        Fri, 01 Aug 2025 06:13:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48de68sm5859929f8f.67.2025.08.01.06.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:13:21 -0700 (PDT)
Date: Fri, 1 Aug 2025 09:13:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	alok.a.tiwari@oracle.com, anders.roxell@linaro.org,
	dtatulea@nvidia.com, eperezma@redhat.com, eric.auger@redhat.com,
	jasowang@redhat.com, jonah.palmer@oracle.com, kraxel@redhat.com,
	leiyang@redhat.com, linux@treblig.org, lulu@redhat.com,
	michael.christie@oracle.com, mst@redhat.com, parav@nvidia.com,
	si-wei.liu@oracle.com, stable@vger.kernel.org,
	viresh.kumar@linaro.org, wangyuli@uniontech.com, will@kernel.org,
	wquan@redhat.com, xiaopei01@kylinos.cn
Subject: [GIT PULL v2] virtio, vhost: features, fixes
Message-ID: <20250801091318-mutt-send-email-mst@kernel.org>
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

for you to fetch changes up to 6693731487a8145a9b039bc983d77edc47693855:

  vsock/virtio: Allocate nonlinear SKBs for handling large transmit buffers (2025-08-01 09:11:09 -0400)

Changes from v1:
	drop commits that I put in there by mistake. Sorry!

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

Michael S. Tsirkin (2):
      virtio: fix comments, readability
      virtio: document ENOSPC

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

 drivers/gpu/drm/virtio/virtgpu_drv.c    |   8 +-
 drivers/vdpa/mlx5/core/mr.c             |   3 +
 drivers/vdpa/mlx5/net/mlx5_vnet.c       |  12 +-
 drivers/vdpa/vdpa_user/vduse_dev.c      |   1 +
 drivers/vhost/Kconfig                   |  18 ++
 drivers/vhost/net.c                     |  88 +++++---
 drivers/vhost/scsi.c                    |  24 +-
 drivers/vhost/vhost.c                   | 377 ++++++++++++++++++++++++++++----
 drivers/vhost/vhost.h                   |  30 ++-
 drivers/vhost/vringh.c                  | 118 ----------
 drivers/vhost/vsock.c                   |  15 +-
 drivers/virtio/virtio.c                 |   7 +-
 drivers/virtio/virtio_dma_buf.c         |   2 +
 drivers/virtio/virtio_mmio.c            |  52 +----
 drivers/virtio/virtio_ring.c            |   4 +
 drivers/virtio/virtio_vdpa.c            |  44 +---
 include/linux/virtio.h                  |   2 +-
 include/linux/virtio_vsock.h            |  46 +++-
 include/linux/vringh.h                  |  12 -
 include/uapi/linux/vhost.h              |  29 +++
 kernel/vhost_task.c                     |   2 +-
 net/vmw_vsock/virtio_transport.c        |  20 +-
 net/vmw_vsock/virtio_transport_common.c |   3 +-
 23 files changed, 575 insertions(+), 342 deletions(-)


