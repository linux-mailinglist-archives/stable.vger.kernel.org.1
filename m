Return-Path: <stable+bounces-176509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A30B384CE
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 16:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE9DD7B047F
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 14:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A3C303CB6;
	Wed, 27 Aug 2025 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdMNXlzc"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EA82777FD
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756304416; cv=none; b=eU5UI+Yh2SQRlswMypxbr6R+aIKJ6lkigF3CKZeaVPp9ZP+GhpxIYMnW+1wJPEvVN+GJ1vfyRpo7br9FkXICn+H/Z+kerVH4XfFg1ozPUezrxjurZ8gsKp/HbgZ9Ko1Jr+Xvcn5FyjPjnu5tsMpdG+s/n48Qshc6A6pi0tI73jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756304416; c=relaxed/simple;
	bh=HHk2BSgl9+A5isTV0Es7jKwwEf6+byROFUjgpG/p04U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=u/w5IeP+x4qIM7EQ1RRvucdh8NQH9bKor4g59JiH0SQt/K404VBkxMMy3lvkbIUj1W4Nx3Xd5fGA74k/uR2msCtv8vpEY2s8yEKcxdV6j3oWHnCnst2k8P09IDuTMTWcJZqnpWMClx+rzG8c3jsAsr9s5jD/vET5uVNoTEG47P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GdMNXlzc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756304414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=opDJ3bmxpJeKk5jilIGi+lkf0qL9GQCfD0EA1RSLjbc=;
	b=GdMNXlzc8HSPin13LZ9rhDc1ie7zm7Lxnpp0+JBN/LJdyxj6ytR0H9wON2xQfNW7iJ/vC8
	p/0+zlZ10kK3EcGrcaCffXQ7zaMM+xJ9X8qObgyDSCLlDORi80aRmabbdei3E0ZDS6+gti
	2pZ2WewKG6LVskk6WYHyBzbKeuAm1Uo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-h0F-gKFUMJWOUUqc3TDetw-1; Wed, 27 Aug 2025 10:20:11 -0400
X-MC-Unique: h0F-gKFUMJWOUUqc3TDetw-1
X-Mimecast-MFC-AGG-ID: h0F-gKFUMJWOUUqc3TDetw_1756304410
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0bd6a9so38283445e9.2
        for <stable@vger.kernel.org>; Wed, 27 Aug 2025 07:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756304410; x=1756909210;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opDJ3bmxpJeKk5jilIGi+lkf0qL9GQCfD0EA1RSLjbc=;
        b=Tne8hZddPiGAG/IVmoOA4eLKXSjvKnhr1NrfjtQ9oIZI5DBhhi1JJFKPwokMZ2oSbi
         TwLESC1KROUDPwnnDjQTCM+kqjLEe3h3rJCa2VEuDnUTeqT9RGDbewpaK4kGy0C++4vI
         ZPmdlZSsNx+an0WCufkJ2g5khlL33Up1GhiubLZik7vCTHG0INbGSMnNt6rzASDxSdyP
         Avyc78pJdstFQ33ML3Z4YBhJY++ApYndG+I9HqKvWyc6bCYbTGbPMEsj9QDb9dSCxCz0
         BdAu7VsMuIyrVpbBF7c5qZmF25BvL+5jbJPFAJhTa1dqVJwgXvOLzRdk/FiMOPVs5qCr
         UYQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVku1NQ1bF5HAf6lWty8Pdzg93NEI8Fa/+mqK9W2ZWwfXrJPsQem1DsREKvQYzK5lZAa2IQVQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJVyAo/YVR4Fh+3WP18rXRc3/S+QBlh+ThuQBnLCUWN2xWrDXJ
	OflgkGC+qwr6HzUQkj6x+Fm3hNBdeqykNoPM+yEei8MfOfFGGac2IqDPYi6kqBxL80ATVKOHRcW
	gTifZOWH9v/m8iOmopYVL3tqzy87IPl/sC2+r36z+7e0u7zBpyb/LU9k2hQ==
X-Gm-Gg: ASbGnctNDA28JpnrIh093i+bDIG6xNSgEQWiSgpR/UUR6f1ztWwiQfk7CXIx/8bzUtA
	X6ua9/6iujCbTno1dLiugshIqUmRaFOHNm55xStLrvy3rzi4E6fryTm6G8/2YYNcZ8Zt+zdK3Hx
	jBqjBacHIE06i+vkErYABUpumTfO8KoQPPd5hp1snZHxW7akVz5kYOQfHZ/dZIrNdJm+S8OUVgO
	26Qesh+OYvgzEcKlS+lbkDyYH3DSCj6oomRmTYMq41eDN5a/rGZnjrDxLr01zcib6PaGfP+qmY1
	QPLl8XgxlIVN3dldrb36n12BcTwCsqQ=
X-Received: by 2002:a05:600c:4746:b0:459:d494:faf9 with SMTP id 5b1f17b1804b1-45b517a0bacmr187068685e9.10.1756304409964;
        Wed, 27 Aug 2025 07:20:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFKNOtqoYfcFfl5BN6DYFKW7ddCHHcODDT/GXLs1RNGvAT7ubO6RW2Y1yIY5L1Dbp0HoJT5Q==
X-Received: by 2002:a05:600c:4746:b0:459:d494:faf9 with SMTP id 5b1f17b1804b1-45b517a0bacmr187068355e9.10.1756304409549;
        Wed, 27 Aug 2025 07:20:09 -0700 (PDT)
Received: from redhat.com ([185.137.39.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f3125ccsm32582585e9.19.2025.08.27.07.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 07:20:09 -0700 (PDT)
Date: Wed, 27 Aug 2025 10:20:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	arbn@yandex-team.com, igor.torrente@collabora.com,
	junnan01.wu@samsung.com, kniv@yandex-team.ru, leiyang@redhat.com,
	liming.wu@jaguarmicro.com, mst@redhat.com, namhyung@kernel.org,
	stable@vger.kernel.org, ying01.gao@samsung.com,
	ying123.xu@samsung.com
Subject: [GIT PULL] virtio,vhost: fixes
Message-ID: <20250827102004-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 45d8ef6322b8a828d3b1e2cfb8893e2ff882cb23:

  virtio_net: adjust the execution order of function `virtnet_close` during freeze (2025-08-26 03:38:20 -0400)

----------------------------------------------------------------
virtio,vhost: fixes

More small fixes. Most notably this fixes a messed up ioctl #,
and a regression in shmem affecting drm users.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Igor Torrente (1):
      Revert "virtio: reject shm region if length is zero"

Junnan Wu (1):
      virtio_net: adjust the execution order of function `virtnet_close` during freeze

Liming Wu (1):
      virtio_pci: Fix misleading comment for queue vector

Namhyung Kim (1):
      vhost: Fix ioctl # for VHOST_[GS]ET_FORK_FROM_OWNER

Nikolay Kuratov (1):
      vhost/net: Protect ubufs with rcu read lock in vhost_net_ubuf_put()

Ying Gao (1):
      virtio_input: Improve freeze handling

 drivers/net/virtio_net.c               | 7 ++++---
 drivers/vhost/net.c                    | 9 +++++++--
 drivers/virtio/virtio_input.c          | 4 ++++
 drivers/virtio/virtio_pci_legacy_dev.c | 4 ++--
 drivers/virtio/virtio_pci_modern_dev.c | 4 ++--
 include/linux/virtio_config.h          | 2 --
 include/uapi/linux/vhost.h             | 4 ++--
 7 files changed, 21 insertions(+), 13 deletions(-)


