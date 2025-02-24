Return-Path: <stable+bounces-118872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF08A41D38
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 483993ABAC3
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E127274265;
	Mon, 24 Feb 2025 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzXNusKq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1D9272929;
	Mon, 24 Feb 2025 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396025; cv=none; b=iCGazag0nW1c6uLQX6AkygRYmov3VEUNG8S0V0bbcGsuQUi/mHVBQpK3mMQjuah37mWaOsRxgK+LAkQ9FlbtRwqFIe3ySYpWZyHUivWhu1QYF6SrLPDE2i9c+DMMBX5XxaGpz2d3YjogrVodRaenWUhzOm2gbk61J/1iJcwCm4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396025; c=relaxed/simple;
	bh=3sHaBKWQ2yCoErFH6IfkO5EWzHEJ9aJpRGtriWhlfUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fkozwrTkOBnsVWcxGaGa5thud+/HpRMEr4IJ+qGzPZTwYR1Bxvup7mOzYyVo35axT8AZ4N330VlitWDPdXOWiKuguCBNHvzvY30lkwcU7hQJmBjrvadQikZVZwp19lWC1EM5vgPWLzJ/MjobjIwegloUmSCyNg0QTX4pi2Z6SkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzXNusKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994F4C4CED6;
	Mon, 24 Feb 2025 11:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396024;
	bh=3sHaBKWQ2yCoErFH6IfkO5EWzHEJ9aJpRGtriWhlfUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VzXNusKqGIFGpzPoM3n9VJjR1QG7E/f7qnbO5R8QZYyYZ/sH3tKzOMy8td+rCEsZ8
	 XLzGTJhEG8ljYGZh5KDhT2N+5e1omBxvR5PYKiYPN68z875PtxOlIkrvJ9kpYWIuBt
	 xCODcr8Gsh1lVA9+q2ZizEPhr2acn0Flgo40a6dFCIAbmpHNQV8VB6a+3Jm6GfYsFM
	 suCcCa4Fz5NA0SzWJ7uXemkkOBQPvb3hUTTdxf6eOJlg9LsREfOvdu1aVoGk8vG6C0
	 KxbfaWtpz8joWk9OkIl78d7cigsYFC0JIYJRdIl3dOTIdpwYtxZ6fIVVlT6UNKzxVI
	 cDFd0b0FPgKNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christopher Lentocha <christopherericlentocha@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 08/12] nvme-pci: quirk Acer FA100 for non-uniqueue identifiers
Date: Mon, 24 Feb 2025 06:19:56 -0500
Message-Id: <20250224112002.2214613-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224112002.2214613-1-sashal@kernel.org>
References: <20250224112002.2214613-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.129
Content-Transfer-Encoding: 8bit

From: Christopher Lentocha <christopherericlentocha@gmail.com>

[ Upstream commit fcd875445866a5219cf2be3101e276b21fc843f3 ]

In order for two Acer FA100 SSDs to work in one PC (in the case of
myself, a Lenovo Legion T5 28IMB05), and not show one drive and not
the other, and sometimes mix up what drive shows up (randomly), these
two lines of code need to be added, and then both of the SSDs will
show up and not conflict when booting off of one of them. If you boot
up your computer with both SSDs installed without this patch, you may
also randomly get into a kernel panic (if the initrd is not set up) or
stuck in the initrd "/init" process, it is set up, however, if you do
apply this patch, there should not be problems with booting or seeing
both contents of the drive. Tested with the btrfs filesystem with a
RAID configuration of having the root drive '/' combined to make two
256GB Acer FA100 SSDs become 512GB in total storage.

Kernel Logs with patch applied (`dmesg -t | grep -i nvm`):

```
...
nvme 0000:04:00.0: platform quirk: setting simple suspend
nvme nvme0: pci function 0000:04:00.0
nvme 0000:05:00.0: platform quirk: setting simple suspend
nvme nvme1: pci function 0000:05:00.0
nvme nvme1: missing or invalid SUBNQN field.
nvme nvme1: allocated 64 MiB host memory buffer.
nvme nvme0: missing or invalid SUBNQN field.
nvme nvme0: allocated 64 MiB host memory buffer.
nvme nvme1: 8/0/0 default/read/poll queues
nvme nvme1: Ignoring bogus Namespace Identifiers
nvme nvme0: 8/0/0 default/read/poll queues
nvme nvme0: Ignoring bogus Namespace Identifiers
nvme0n1: p1 p2
...
```

Kernel Logs with patch not applied (`dmesg -t | grep -i nvm`):

```
...
nvme 0000:04:00.0: platform quirk: setting simple suspend
nvme nvme0: pci function 0000:04:00.0
nvme 0000:05:00.0: platform quirk: setting simple suspend
nvme nvme1: pci function 0000:05:00.0
nvme nvme0: missing or invalid SUBNQN field.
nvme nvme1: missing or invalid SUBNQN field.
nvme nvme0: allocated 64 MiB host memory buffer.
nvme nvme1: allocated 64 MiB host memory buffer.
nvme nvme0: 8/0/0 default/read/poll queues
nvme nvme1: 8/0/0 default/read/poll queues
nvme nvme1: globally duplicate IDs for nsid 1
nvme nvme1: VID:DID 1dbe:5216 model:Acer SSD FA100 256GB firmware:1.Z.J.2X
nvme0n1: p1 p2
...
```

Signed-off-by: Christopher Lentocha <christopherericlentocha@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f939b6dc295e6..afcb9668dad98 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3577,6 +3577,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1dbe, 0x5216),   /* Acer/INNOGRIT FA100/5216 NVMe SSD */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1dbe, 0x5236),   /* ADATA XPG GAMMIX S70 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e49, 0x0021),   /* ZHITAI TiPro5000 NVMe SSD */
-- 
2.39.5


