Return-Path: <stable+bounces-33765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F0589262F
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 22:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016431C20E98
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 21:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1042813B5AE;
	Fri, 29 Mar 2024 21:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMV8F5sC"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA1713AA5F
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748345; cv=none; b=oaXTnutR2GTIC4fSpP+VuDg5IJU9pwIdgX6xRZr8YsZuWrZXieOKDZYhu7TWcWpLCbnjU8qhW5r4z3afGMtFLqYhevGkbQxDkBwltF+UgLQzGQctpNpLsuYzYx9fgGBb+CZ92hTbij3lPFfaRMdNfYVeL9JRnLa7RwUiWVJK2ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748345; c=relaxed/simple;
	bh=qaCcfdVbSawjinsd4oLsmEuFXG508h/9yW+vJerGNaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SjDt38CP4v7LoO0UXh4GB5iC2VS1CbNSYS8BKk4wqOfuJZPTZiRTtD1LpKornwzCFfjeLQXyLymnzfMdTAZm9I+NPwTaMSxYnGEB40wRN4agWx+2Ejxce4Xj6bZfJdHvYrfmBwo3tKjqkALVv4W03Cift8hNJSWv3ZizeHgZAMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MMV8F5sC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711748342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tXGNxPog2D6F5J1acVZVzpc/LGpjiQUMm9i2777cfoI=;
	b=MMV8F5sCZ5EMBK0gp20AlwZI2Mzs5dNrV24jnmi1JfXAG7MlyvrEFJHnsGFLppfC8vpOCO
	P5wnzdWsrC9ZH+9rIidq1EiVMMpMOK4qdVQNclbH95qmWZ8wanRGUfLQ/LImEsxK7LS28F
	Fue+kUTOHUpBMyWsbmjRTzfJSBrHebY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-L9aLvFTePz2zAOglVQEROg-1; Fri,
 29 Mar 2024 17:38:59 -0400
X-MC-Unique: L9aLvFTePz2zAOglVQEROg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3D8429AC005;
	Fri, 29 Mar 2024 21:38:58 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.34.212])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 02EE4492BD0;
	Fri, 29 Mar 2024 21:38:57 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: stable@vger.kernel.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
	sashal@kernel.org,
	gregkh@linuxfoundation.org,
	eric.auger@redhat.com
Subject: [PATCH 6.1.y 0/7] vfio: Interrupt eventfd hardening for 6.6.y
Date: Fri, 29 Mar 2024 15:38:47 -0600
Message-ID: <20240329213856.2550762-1-alex.williamson@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

This corrects the backport of commit fe9a7082684e ("vfio/pci: Disable
auto-enable of exclusive INTx IRQ"), choosing to adapt the fix to the
current tree which uses an array of eventfd contexts rather than
include a base patch for the conversion to xarray, which is found to
be faulty in isolation.

I include the reverts here for completeness, but if the associated
commits are otherwise already dropped due to previous report[1], the
remainder of this series is still valid.

Largely this just adapts the mainline commits to the eventfd context
array from the current internal API where they're stored in an xarray.
Thanks,

Alex

[1]https://lore.kernel.org/all/20240329110433.156ff56c.alex.williamson@redhat.com/

Alex Williamson (7):
  Revert "vfio/pci: Disable auto-enable of exclusive INTx IRQ"
  Revert "vfio/pci: Prepare for dynamic interrupt context storage"
  vfio/pci: Disable auto-enable of exclusive INTx IRQ
  vfio: Introduce interface to flush virqfd inject workqueue
  vfio/pci: Create persistent INTx handler
  vfio/platform: Create persistent IRQ handlers
  vfio/fsl-mc: Block calling interrupt handler without trigger

 drivers/vfio/fsl-mc/vfio_fsl_mc_intr.c    |   7 +-
 drivers/vfio/pci/vfio_pci_intrs.c         | 318 +++++++++-------------
 drivers/vfio/platform/vfio_platform_irq.c | 101 ++++---
 drivers/vfio/virqfd.c                     |  21 ++
 include/linux/vfio.h                      |   2 +
 5 files changed, 220 insertions(+), 229 deletions(-)

-- 
2.44.0


