Return-Path: <stable+bounces-112545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEB0A28D57
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2209D1608FF
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ABB14F9FD;
	Wed,  5 Feb 2025 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EawQVdlZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249D614A4E9;
	Wed,  5 Feb 2025 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763928; cv=none; b=i0FMW6RaKFsMz24lgvwFfMJyDaKn8ovn+nuMefKPzskwyMtAgh43VXsXJq2ViXtTiFrLnHfVr6HhX/55ZagY9YFh1bmHKUHUdA9GtXAx9sCAqlH44pmc30XVDi1XAhHVaABYD48Jw5T6nU4F9PHlrVdwITiwn7mY9HHsnr7sfZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763928; c=relaxed/simple;
	bh=WOMRNF2y3fWhZSxiFchSRDFKAXdZikKmEFhU6wt+A44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDGLoRJ6yAApfdLpTFw0Xe8Ue05AMmgQI9vEdki+6mzBh8P80xGGzGL53dntTKLKjzLCDdQZmoeFu6of29w7+VhLPHHyC4WAAqvfxkpNX8t8p41lpbFYEzxEspr5MPKGfSM4c+MUTqoS2D4UD916kNvJ0IBx04y/5p0fVQ81B0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EawQVdlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857B3C4CEDD;
	Wed,  5 Feb 2025 13:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738763928;
	bh=WOMRNF2y3fWhZSxiFchSRDFKAXdZikKmEFhU6wt+A44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EawQVdlZp8JY7aldU7is7AmnP0kxEgzs+rK4Sshs3+Rnhx/qXotvG7KvgMV01zDrV
	 4O5rUhGmrIJp5p9JOsmg1zlv+cXnsvak/aYlk9ukQcui3NXveWdB8j02eXRBRc+nE8
	 Gdib1ZytfO5LDvXkYZgTsv7hUD8aDSGSS5wgDRm4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 120/393] wifi: mt76: mt7915: firmware restart on devices with a second pcie link
Date: Wed,  5 Feb 2025 14:40:39 +0100
Message-ID: <20250205134424.886770716@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 9b60e2ae511c959024ecf6578b3fbe85cd06d7cc ]

It seems that the firmware checks the register used for detecting matching
PCIe links in order to figure out if a secondary PCIe link is enabled.
Write the register again just before starting the firmware on hw reset,
in order to fix an issue that left the second band unusable after restart.

Fixes: 9093cfff72e3 ("mt76: mt7915: add support for using a secondary PCIe link for gen1")
Link: https://patch.msgid.link/20241230194202.95065-11-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c    | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h | 1 +
 drivers/net/wireless/mediatek/mt76/mt7915/pci.c    | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 38d27f8721733..675fbf40ecf75 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1383,6 +1383,8 @@ mt7915_mac_restart(struct mt7915_dev *dev)
 	if (dev_is_pci(mdev->dev)) {
 		mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
 		if (dev->hif2) {
+			mt76_wr(dev, MT_PCIE_RECOG_ID,
+				dev->hif2->index | MT_PCIE_RECOG_ID_SEM);
 			if (is_mt7915(mdev))
 				mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0xff);
 			else
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index e192211d4b23e..14d4bbeae9d63 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -191,6 +191,7 @@ struct mt7915_hif {
 	struct device *dev;
 	void __iomem *regs;
 	int irq;
+	u32 index;
 };
 
 struct mt7915_phy {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index 39132894e8ea2..07b0a5766eab7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -42,6 +42,7 @@ static struct mt7915_hif *mt7915_pci_get_hif2(u32 idx)
 			continue;
 
 		get_device(hif->dev);
+		hif->index = idx;
 		goto out;
 	}
 	hif = NULL;
-- 
2.39.5




