Return-Path: <stable+bounces-33034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDF688F230
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 23:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7418B250BE
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 22:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F36615442A;
	Wed, 27 Mar 2024 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0AUoq4z"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A942EB04
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 22:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711580110; cv=none; b=UO8Y2Sx6m1QYI64+lghPcRby61IZNnC0k/6yxNyCrCqGiMKck7+M/pExA8hTFR9um/WjNR9nAbFs0SBCmMXOfIF0aBLISTKxY7Cxy0F6cvhBdkef2AQwS+wbyFU7/WK2RG1J4YcvibO2VJ+pCzcS+gTS/yRnrhF/l4areBq7hLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711580110; c=relaxed/simple;
	bh=1ExXU/JLWyrzaSxjoaxnZ0od/a2l36wHR2B+Pi8duOA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ah6kVBImJQMAkC7Xli53NSewydzargTnbFzoQ/dn7b3V96LU7ElvnYuILbDHk8DZE2pLlGO/2D4/FZiwY3WCAvKhHzXHFeyoFax6xIF7EpNO6FcczY5Q2vzctEWqO82x1UkquulpnShN68e9RDf4qC11oJc7ta8GTVn+b7EUV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0AUoq4z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711580108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=97YQK5nP4Gl2ykBSD8luIYmucpg3my1M0xNIy7P24UM=;
	b=h0AUoq4zEHFZwmxkazx8mGbigD8L06JNrjlOrb22hqBFkwhHJgCaaeja/s5B0THrTxBXlT
	C/adbLOg8THUN1H6LwTnmaIgq1t+2yNbrGRBiS3VIpJEx/silbgLasjVBmWged8UWDQJ3w
	j1W+QUHQq1UdIZdWbWLb1vkRE92O1sY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-ETSuowZWP_C6HXZEpkiQ1A-1; Wed, 27 Mar 2024 18:55:04 -0400
X-MC-Unique: ETSuowZWP_C6HXZEpkiQ1A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 485D4101A523;
	Wed, 27 Mar 2024 22:55:04 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.34.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 761281121312;
	Wed, 27 Mar 2024 22:55:03 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	eric.auger@redhat.com,
	sashal@kernel.org
Subject: [PATCH 6.6.y 0/4] vfio: Interrupt eventfd hardening for 6.6.y
Date: Wed, 27 Mar 2024 16:54:26 -0600
Message-ID: <20240327225444.909882-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

These backports only require reverting to the older eventfd_signal()
API with two parameters, prior to commit 3652117f8548
("eventfd: simplify eventfd_signal()").  Thanks,

Alex

Alex Williamson (4):
  vfio: Introduce interface to flush virqfd inject workqueue
  vfio/pci: Create persistent INTx handler
  vfio/platform: Create persistent IRQ handlers
  vfio/fsl-mc: Block calling interrupt handler without trigger

 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c    |   7 +-
 drivers/vfio/pci/vfio_pci_intrs.c         | 145 ++++++++++++----------
 drivers/vfio/platform/vfio_platform_irq.c | 100 ++++++++++-----
 drivers/vfio/virqfd.c                     |  21 ++++
 include/linux/vfio.h                      |   2 +
 5 files changed, 173 insertions(+), 102 deletions(-)

-- 
2.44.0


