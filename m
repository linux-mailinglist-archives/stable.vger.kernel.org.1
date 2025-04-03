Return-Path: <stable+bounces-128032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B8AA7AE37
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2E6F7A1F33
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA38207A2E;
	Thu,  3 Apr 2025 19:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrXShPuO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BF1207A1C;
	Thu,  3 Apr 2025 19:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707804; cv=none; b=u9f3agTPMjvlLHPAZz4BB9/OUJXthhnBzLWoXxuzvXBxzBFo5VjnmiZaXHjc2/ilocYLYx4dSg3x8b2wpUPwo3uVG4lDu2+lHhuaNoO1Cby/m94594gVK61an00b5R5Gox8MKuvqRBKA4047HkRHcZyr4j/EPh9iGcy/d6E0ckU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707804; c=relaxed/simple;
	bh=IG7F6U3gfOQMS8ntvj31o+mv8hA3t80Jqo5rURTTYQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nm5U3k71nAof2jbbN0T1mmhUt5Yz0ZOtbiwsR0Or2HflmmOVVlVBfsHxVqh3JyNdpkMTrCfpahbMrV65uDPA/6gNZ3FoF9HJZC6LyX3lkdqipKe3B/wFQk1A7VFCOZtWcoMFcNlrN3cEIc5pZISYvza73e+ej7ugmnMqV8SFk7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrXShPuO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02176C4CEEA;
	Thu,  3 Apr 2025 19:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707802;
	bh=IG7F6U3gfOQMS8ntvj31o+mv8hA3t80Jqo5rURTTYQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lrXShPuORcZ7JjT9yBx7Q5cSxPc9Ba27Lp3XPz408Im/p/8xmrWEI7f0mmtJJy0Tr
	 v1Lynf5BQRlilCwfY100km61u0WsNnnOmvZYTA4G0Q6gmDOtg1XulTwPF5t2sIGGn8
	 MiciIakgyI3EKq586LvFPjq3F1rMTL7rt+deKf6r93OP6V+uV2j8b3DNqZN8pKC98f
	 xmz4NFSF/Zvl3zAJiDqBFfatDc+AUZaJXbqAzva9qLGu+q8lH5cfMEl6zc600QaTgk
	 wzxoJTMGfkmCSADgZvzJetuEH9FszVvtUGuSR5otx3411b7WSIYCvverI9BaaeLWNG
	 fBNgFoTI1KQ9g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ryo Takakura <ryotkkr98@gmail.com>,
	"Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Sasha Levin <sashal@kernel.org>,
	nirmal.patel@linux.intel.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.13 31/37] PCI: vmd: Make vmd_dev::cfg_lock a raw_spinlock_t type
Date: Thu,  3 Apr 2025 15:15:07 -0400
Message-Id: <20250403191513.2680235-31-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191513.2680235-1-sashal@kernel.org>
References: <20250403191513.2680235-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

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


