Return-Path: <stable+bounces-134238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F6BA92A01
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20664A4754
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5792566CF;
	Thu, 17 Apr 2025 18:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YUWLxwfk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED86A2517AF;
	Thu, 17 Apr 2025 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915521; cv=none; b=t9MuajNsNlKBUjzrImuLQh+5IkeowZi2S3gucq218imecrdiQu1EuzF3nfDgoN6pc0uh0JC9MKpVHTNswHcvMYoH8W0Zfbton461DX/4Qmew6hgeW0AtnGyGaHxAWxTfuTnBnqM+0FBMMfeXa9DNXYhYwJUDt++q2IsUFDMazoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915521; c=relaxed/simple;
	bh=JJOMei2MTf9FlBWC9ilo3zhiqBM5M1+JsUztcquvGi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dNzZ98IuirrTfqNjBAUA24uA6IRdzNSZ74MVw40SLX3r83aMKeDnsPntcVHEmVjUFHqkpV1EigUjGHXnsy2Qqpr9ZxY6zpDjDs6TBZ16JoUsCm36Lldf7lP1Jofyc3t9V5SRwmkTjdGZKkDc+wFq6seVEr2CNvccXs6XI+NYOzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YUWLxwfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BB5C4CEE4;
	Thu, 17 Apr 2025 18:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744915520;
	bh=JJOMei2MTf9FlBWC9ilo3zhiqBM5M1+JsUztcquvGi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YUWLxwfkNuJPY1uOnPUQ51hzhtY8k6UTRj9Kp61LpLiLULICpbzUM3peAuK5DZ52J
	 6jJImtKYc6Nm6WGoK0dvW2PNojGDPMzddTK86eXPZWNWdXl3shEcot6dMvb254eglw
	 PBTqSpZo/WMTnpOliZFyrytrXeEg3OnaB/VxPnFk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryo Takakura <ryotkkr98@gmail.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 152/393] PCI: vmd: Make vmd_dev::cfg_lock a raw_spinlock_t type
Date: Thu, 17 Apr 2025 19:49:21 +0200
Message-ID: <20250417175113.702397015@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175107.546547190@linuxfoundation.org>
References: <20250417175107.546547190@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryo Takakura <ryotkkr98@gmail.com>

[ Upstream commit 18056a48669a040bef491e63b25896561ee14d90 ]

The access to the PCI config space via pci_ops::read and pci_ops::write is
a low-level hardware access. The functions can be accessed with disabled
interrupts even on PREEMPT_RT. The pci_lock is a raw_spinlock_t for this
purpose.

A spinlock_t becomes a sleeping lock on PREEMPT_RT, so it cannot be
acquired with disabled interrupts. The vmd_dev::cfg_lock is accessed in
the same context as the pci_lock.

Make vmd_dev::cfg_lock a raw_spinlock_t type so it can be used with
interrupts disabled.

This was reported as:

  BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
  Call Trace:
   rt_spin_lock+0x4e/0x130
   vmd_pci_read+0x8d/0x100 [vmd]
   pci_user_read_config_byte+0x6f/0xe0
   pci_read_config+0xfe/0x290
   sysfs_kf_bin_read+0x68/0x90

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Acked-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
[bigeasy: reword commit message]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Link: https://lore.kernel.org/r/20250218080830.ufw3IgyX@linutronix.de
[kwilczynski: commit log]
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
[bhelgaas: add back report info from
https://lore.kernel.org/lkml/20241218115951.83062-1-ryotkkr98@gmail.com/]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/vmd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 9d9596947350f..94ceec50a2b94 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -125,7 +125,7 @@ struct vmd_irq_list {
 struct vmd_dev {
 	struct pci_dev		*dev;
 
-	spinlock_t		cfg_lock;
+	raw_spinlock_t		cfg_lock;
 	void __iomem		*cfgbar;
 
 	int msix_count;
@@ -391,7 +391,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
 	if (!addr)
 		return -EFAULT;
 
-	spin_lock_irqsave(&vmd->cfg_lock, flags);
+	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
 	switch (len) {
 	case 1:
 		*value = readb(addr);
@@ -406,7 +406,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
 		ret = -EINVAL;
 		break;
 	}
-	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
+	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
 	return ret;
 }
 
@@ -426,7 +426,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 	if (!addr)
 		return -EFAULT;
 
-	spin_lock_irqsave(&vmd->cfg_lock, flags);
+	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
 	switch (len) {
 	case 1:
 		writeb(value, addr);
@@ -444,7 +444,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 		ret = -EINVAL;
 		break;
 	}
-	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
+	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
 	return ret;
 }
 
@@ -1009,7 +1009,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
 		vmd->first_vec = 1;
 
-	spin_lock_init(&vmd->cfg_lock);
+	raw_spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
 	err = vmd_enable_domain(vmd, features);
 	if (err)
-- 
2.39.5




