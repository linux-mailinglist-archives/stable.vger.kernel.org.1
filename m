Return-Path: <stable+bounces-118837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0FBA41CD7
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE2216BF75
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A22267730;
	Mon, 24 Feb 2025 11:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTZ8D1Wf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42425267729;
	Mon, 24 Feb 2025 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395943; cv=none; b=aMtlTZojEZ/azGfL7h0TGdEJVLwAhTquuxgIG+Ut/rNbCCt6k3u2OnIjOYseFY8SAa5/n911Od8qRIwsBq4ZB3ML1Vz9RDu37nm3/OO4ebEW4NHBC1WDTP0pNSfDoOc1E5oDjGtKMNeR88DtoM3lVb4ASCj7y2qaOUJ8y4zM+Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395943; c=relaxed/simple;
	bh=zraEquyJhemma6Y1FrjGBct/7XVCMgKv34LQmNYE9is=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=elfvzteRv3YR0Rv7tHDr7MBT5e3ZFZe+k4YyBsEN0i0CPBZf7X3nKbKUVpsOasl56MuL85jPJJ7ihN35MDNsVqgrVdM3F5aJ5bUo2xUbnnP3oI4XkNO1khtHpjmNZ/+/w3gDybIdd1KwBj9VWcMzXLUymcNrIq5Hwp+wdr09g5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTZ8D1Wf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9677C4CEE6;
	Mon, 24 Feb 2025 11:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395942;
	bh=zraEquyJhemma6Y1FrjGBct/7XVCMgKv34LQmNYE9is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UTZ8D1WfzVfEuIcm5DoSxM8lGgUQw/heMIzyRX/SdAV8/8Tv4l5NbjDz4Pb3WmIQi
	 DVWRSUx+pAknjIJT6Imj15DCUDVBMMxiJVkwsZFjdDowRL8rrFRIzNWZlBjlzqFdOv
	 8fdYLuE2A9brWGDQG9l0rRMS7cft9IODxAiafbAIotGlTMWQ3Blto3ZtATYb8bn3za
	 EPnXnZI7Fn+xcOr4fg+FlEauw3662EdINWpeLHyEPpaWFi2ydKtBrtVm42fOB8ZG9T
	 CQMpLW70xu8wURcqf30yawVzWaWLa+0AKrZCjWLTDdGa1wGRY8V/h7A4xLxFAXzOZD
	 kGGEnSReNq/kg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christopher Lentocha <christopherericlentocha@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 21/28] nvme-pci: quirk Acer FA100 for non-uniqueue identifiers
Date: Mon, 24 Feb 2025 06:17:52 -0500
Message-Id: <20250224111759.2213772-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111759.2213772-1-sashal@kernel.org>
References: <20250224111759.2213772-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.16
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
index cc74682dc0d4e..6d4ac1becce3f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3554,6 +3554,8 @@ static const struct pci_device_id nvme_id_table[] = {
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


