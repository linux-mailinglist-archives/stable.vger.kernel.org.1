Return-Path: <stable+bounces-33774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD514892751
	for <lists+stable@lfdr.de>; Sat, 30 Mar 2024 00:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67AC0282C46
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 23:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A974C13D240;
	Fri, 29 Mar 2024 22:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XyzgY84i"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EABC13E889
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 22:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711753197; cv=none; b=sHBZjtCiwE7MWuyQcSPSyMwvY9pAE5MGDETd398zMn6HzIlxFrheO5F2UyyYxgDJT1sEq/09dfzjeRcNCuR0YF0MdEC9nlNku9SFmQ1OcV5QVUUcZBl9bu3oUloSTEc7bt29ZcETY1ZicTmNtlIr1Vndi9JrO89DzMJyoiYtID0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711753197; c=relaxed/simple;
	bh=T0vvFi3ITnuGjoB7eImhuXFjZvIUkOM08DErD5QrDuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ksD9ffxBWQ4cOaZPZOBoryOpgQQg51LE4MkH6XQl+mt6F8Q+TOw+CI3Oiz3V2xZa6ukRSj4GSE//+db7P3TexyFHBuxLu1hi330cg6pKX09Gg8qWmtmXfdUbO7lcxR4DS9YnT7qnKPqQVVeZU0j6d/M4PXEMgPvF8aEKVFMt3Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XyzgY84i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711753194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2FmSm8NIAzhwnfWBZRIHTmmzJ3j31z+9CFipNBSm4cU=;
	b=XyzgY84i1ZVD3GiD5ewrywjwISRVBYPC+TD65A9RXeiL/rPgw3qernt0kNsdHHMqofPC4t
	I0pWr+UAie6llsrR5WL7dK0ZoresSDG4X50u39D0VOtzAmefG+CD+0KEVj7C51SP57+A+o
	czrY/8w3CAh2umW5W7Ep1LuqiMMVViA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-Xs6G4OyFPAyOBk628xnlLQ-1; Fri, 29 Mar 2024 18:59:51 -0400
X-MC-Unique: Xs6G4OyFPAyOBk628xnlLQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71AFC101A552;
	Fri, 29 Mar 2024 22:59:51 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.34.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8C485C017A1;
	Fri, 29 Mar 2024 22:59:50 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	sashal@kernel.org,
	gregkh@linuxfoundation.org,
	eric.auger@redhat.com
Subject: [PATCH 5.15.y 0/6] vfio: Interrupt eventfd hardening for 5.15.y
Date: Fri, 29 Mar 2024 16:59:36 -0600
Message-ID: <20240329225944.3294388-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Largely the same as the 6.1.y backports, minor context conflict still
using externs in header file and still using GFP_KERNEL rather than
GFP_KERNEL_ACCOUNT.  Also picking up 810cd4bb5345 ("vfio/pci: Lock
external INTx masking ops") which was previously included in Sasha's
6.1.y backports but here the prototype of vfio_pci_intx_mask() is
different.  Thanks,

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


