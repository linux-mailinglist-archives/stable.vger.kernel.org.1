Return-Path: <stable+bounces-35121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69800894284
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F289F28112E
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920B74D59F;
	Mon,  1 Apr 2024 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/BClTW8"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC4C481D7
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990396; cv=none; b=lRZ9/+/jcM23h+2sqyxx4f9vVLrmtaBBqn6WanyDvS5TlsOkygkL2iHvDq+YTX5vyjMhjJ7N8lCpD8vSeEB8+EwDZuixiO2Vy9AtPtUe6N7d+8AiEidw76nNpI4QaHtXNQd0nq6NxFVgkqclvSNRVPyoR6gdK3tcZBLCSHmzTWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990396; c=relaxed/simple;
	bh=yMMnIkxpp1VsuJAMFNiKmwJv1x2qtHD6B5/Nwbyjxu0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BqkTo+/uK1k/OqOu3wnJy9F6SUaBus+grkbbBgerweUjipAYkknNX7C5xcU1LA47fOg8fDcVtSiQ23y3zSOXAoJYOVlFpTp7HsE/nQI2J6ohZUJeScg7SN87fF34zZGNnXKpb7MImzmMvdzSM1JSj0FIxdy4IoJmsioYIw/pYpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T/BClTW8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711990393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GSuqvpGhWw2nG0uvDHi91yEk6nUixxpJsArBwLMNL3k=;
	b=T/BClTW8jEfpCItdFkJt7WObzz+EeSfPUEEj4GG1MBt2Sa5l9BlaONwj7G5A0Bzn34ZGmO
	bJwJjggJaNcnC6oouH73fJvlx4H1Qi04UmIikb7xAeCzCpWSToE/DjlFMqExKrsBWR62/H
	9K9H84NyyeVj1NC0SROLxVsldPJ1I6k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-5fTmoKCtM0izEha5O9Pq3g-1; Mon,
 01 Apr 2024 12:53:10 -0400
X-MC-Unique: 5fTmoKCtM0izEha5O9Pq3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 840232800E8F;
	Mon,  1 Apr 2024 16:53:09 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.34.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AA7693C21;
	Mon,  1 Apr 2024 16:53:08 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	sashal@kernel.org,
	gregkh@linuxfoundation.org,
	eric.auger@redhat.com
Subject: [PATCH 5.10.y 5.4.y 0/6] vfio: Interrupt eventfd hardening for 5.10.y, 5.4.y
Date: Mon,  1 Apr 2024 10:52:54 -0600
Message-ID: <20240401165302.3699643-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

This is nearly identical to the v5.15 backport, the only difference is
the split to struct vfio_pci_core_device hasn't occurred yet, so we need
to use the original vfio_pci_device object instead.

NB. The fsl-mc driver doesn't exist on v5.4.y, therefore the last patch
in the series should be dropped against v5.4.

v4.19.y does not include IRQF_NO_AUTOEN, so this is as far as I intend
to go with these.  Thanks,

Alex

Alex Williamson (6):
  vfio/pci: Disable auto-enable of exclusive INTx IRQ
  vfio/pci: Lock external INTx masking ops
  vfio: Introduce interface to flush virqfd inject workqueue
  vfio/pci: Create persistent INTx handler
  vfio/platform: Create persistent IRQ handlers
  vfio/fsl-mc: Block calling interrupt handler without trigger

 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c    |   7 +-
 drivers/vfio/pci/vfio_pci_intrs.c         | 176 +++++++++++++---------
 drivers/vfio/platform/vfio_platform_irq.c | 101 +++++++++----
 drivers/vfio/virqfd.c                     |  21 +++
 include/linux/vfio.h                      |   2 +
 5 files changed, 201 insertions(+), 106 deletions(-)

-- 
2.44.0


