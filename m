Return-Path: <stable+bounces-147000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 548DDAC55B0
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D451BA64E0
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6ABF280A56;
	Tue, 27 May 2025 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o4dvpx+a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6470B27FD43;
	Tue, 27 May 2025 17:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748365965; cv=none; b=ux0DITkv08y8asnL5Jv0O34Qw7k4oiwwkYuhU6W+1p+wBOivgyYwzMbsJSvprOoSXh9TYMdpCev24FH6K5XoZqKyn0VoAOVGxHZNYM7DF51q5b5ypmPB3K1nSGvhENmjXGnywzsRPzAI/KxxlTTb/AVAH4a4FsT0JuSD0CFRR78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748365965; c=relaxed/simple;
	bh=e16RIU9roRIG5zfM+/2fsPABPZ9kGwx4tQPT5idwYvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMFFN/BoQJ8sUmK5A4RtxPr+cdZAjBTcLmVExAhheJiYd9xD2KWTV0HTTVWWxQ12yt83WEeJqiorWZPcYVsC7WkmofzT/6Y8VkvViwN3kD2/rSWtwg+S3qi4HoVYY1GHATejwOw1FC4s07LTawzo1qAVlfbnIzcDj1bsUdLszeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o4dvpx+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84875C4CEE9;
	Tue, 27 May 2025 17:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748365962;
	bh=e16RIU9roRIG5zfM+/2fsPABPZ9kGwx4tQPT5idwYvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o4dvpx+a09WwvHO0BsO2nqu3LIW2x0647cv8wJxanwB3f9TWtg8frrXWeyPKwEL8b
	 IsjA85onS1fsK+T8J0nOWRrWbHaTyPCguggFHtDX0Tmt7rX4tybM9PcbuunXqLYg/I
	 Uuh9y0VGdQ148r21JdGFsMX8Xr6CmQXUkiIR0YTI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	liaozw <hedgehog-002@163.com>,
	rugk <rugk+github@posteo.de>,
	Wentao Guan <guanwentao@uniontech.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 516/626] nvme-pci: add quirks for WDC Blue SN550 15b7:5009
Date: Tue, 27 May 2025 18:26:49 +0200
Message-ID: <20250527162505.925771577@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wentao Guan <guanwentao@uniontech.com>

[ Upstream commit ab35ad950d439ec3409509835d229b3d93d3c7f9 ]

Add two quirks for the WDC Blue SN550 (PCI ID 15b7:5009) based on user
reports and hardware analysis:

 - NVME_QUIRK_NO_DEEPEST_PS:
	liaozw talked to me the problem and solved with
	nvme_core.default_ps_max_latency_us=0, so add the quirk.
	I also found some reports in the following link.

 - NVME_QUIRK_BROKEN_MSI:
	after get the lspci from Jack Rio.
	I think that the disk also have NVME_QUIRK_BROKEN_MSI.
	described in commit d5887dc6b6c0 ("nvme-pci: Add quirk for broken MSIs")
	as sean said in link which match the MSI 1/32 and MSI-X 17.

Log:
lspci -nn | grep -i memory
03:00.0 Non-Volatile memory controller [0108]: Sandisk Corp SanDisk Ultra 3D / WD PC SN530, IX SN530, Blue SN550 NVMe SSD (DRAM-less) [15b7:5009] (rev 01)
lspci -v -d 15b7:5009
03:00.0 Non-Volatile memory controller: Sandisk Corp SanDisk Ultra 3D / WD PC SN530, IX SN530, Blue SN550 NVMe SSD (DRAM-less) (rev 01) (prog-if 02 [NVM Express])
        Subsystem: Sandisk Corp WD Blue SN550 NVMe SSD
        Flags: bus master, fast devsel, latency 0, IRQ 35, IOMMU group 10
        Memory at fe800000 (64-bit, non-prefetchable) [size=16K]
        Memory at fe804000 (64-bit, non-prefetchable) [size=256]
        Capabilities: [80] Power Management version 3
        Capabilities: [90] MSI: Enable- Count=1/32 Maskable- 64bit+
        Capabilities: [b0] MSI-X: Enable+ Count=17 Masked-
        Capabilities: [c0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [150] Device Serial Number 00-00-00-00-00-00-00-00
        Capabilities: [1b8] Latency Tolerance Reporting
        Capabilities: [300] Secondary PCI Express
        Capabilities: [900] L1 PM Substates
        Kernel driver in use: nvme
dmesg | grep nvme
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-6.12.20-amd64-desktop-rolling root=UUID= ro splash quiet nvme_core.default_ps_max_latency_us=0 DEEPIN_GFXMODE=
[    0.059301] Kernel command line: BOOT_IMAGE=/vmlinuz-6.12.20-amd64-desktop-rolling root=UUID= ro splash quiet nvme_core.default_ps_max_latency_us=0 DEEPIN_GFXMODE=
[    0.542430] nvme nvme0: pci function 0000:03:00.0
[    0.560426] nvme nvme0: allocated 32 MiB host memory buffer.
[    0.562491] nvme nvme0: 16/0/0 default/read/poll queues
[    0.567764]  nvme0n1: p1 p2 p3 p4 p5 p6 p7 p8 p9
[    6.388726] EXT4-fs (nvme0n1p7): mounted filesystem ro with ordered data mode. Quota mode: none.
[    6.893421] EXT4-fs (nvme0n1p7): re-mounted r/w. Quota mode: none.
[    7.125419] Adding 16777212k swap on /dev/nvme0n1p8.  Priority:-2 extents:1 across:16777212k SS
[    7.157588] EXT4-fs (nvme0n1p6): mounted filesystem r/w with ordered data mode. Quota mode: none.
[    7.165021] EXT4-fs (nvme0n1p9): mounted filesystem r/w with ordered data mode. Quota mode: none.
[    8.036932] nvme nvme0: using unchecked data buffer
[    8.096023] block nvme0n1: No UUID available providing old NGUID

Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5887dc6b6c054d0da3cd053afc15b7be1f45ff6
Link: https://lore.kernel.org/all/20240422162822.3539156-1-sean.anderson@linux.dev/
Reported-by: liaozw <hedgehog-002@163.com>
Closes: https://bbs.deepin.org.cn/post/286300
Reported-by: rugk <rugk+github@posteo.de>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=208123
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f2c06bb96c8d2..cd8a10f6accff 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3613,6 +3613,9 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x15b7, 0x5008),   /* Sandisk SN530 */
 		.driver_data = NVME_QUIRK_BROKEN_MSI },
+	{ PCI_DEVICE(0x15b7, 0x5009),   /* Sandisk SN550 */
+		.driver_data = NVME_QUIRK_BROKEN_MSI |
+				NVME_QUIRK_NO_DEEPEST_PS },
 	{ PCI_DEVICE(0x1987, 0x5012),	/* Phison E12 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 */
-- 
2.39.5




