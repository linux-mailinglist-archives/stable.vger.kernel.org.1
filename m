Return-Path: <stable+bounces-150581-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929D6ACB861
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681EC941B1A
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 15:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EED22DA1F;
	Mon,  2 Jun 2025 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yHmkK1l4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB0D21325D;
	Mon,  2 Jun 2025 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748877576; cv=none; b=UQIx8+Ow5q6qSW+c4dmenZwaQ1LG5FF7TnE7n+JSJRm6PmRIXXosszx10OfJuAIklANhvN7AZkNL+L9/sdsdRjVRYOdaPNByh1YjSxnqevXUYozpOBds5MR1A2muiQz4rzyC4KPe8GLTD7lC/PXFLnAnJ/gCryCBgOpkasuHETQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748877576; c=relaxed/simple;
	bh=n7gajtPfHTFPJzhr0calICwkEpdgro9jagDHXy7ZwZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siOEwWrOylebJEvJP7eTn+U6SwJoXpAp2z7sVSGJ2VhiRqH/QDcT9gKsha1e1YsNQJmyj/AQNb2O6Ejf8wygaDItjexaETjFOfIUiyg8kOxpSuqG/2PbozE1cFgdPlaZnzyyeN4GulpyjzGcRp+YH/4RhpJy2CBUyFIbg5Ym8Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yHmkK1l4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B120DC4CEEE;
	Mon,  2 Jun 2025 15:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748877576;
	bh=n7gajtPfHTFPJzhr0calICwkEpdgro9jagDHXy7ZwZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yHmkK1l4LbWBAI8ePfPw/WPw66jAIyztQzWnfy/1pmIJ6dyzgLGC/fz/VgtYDQHVV
	 wLxvHGMszVaVfe4EZRKgelZu3cCJRFsWTGOJq0bu6DY1NGjuxQesI7OEnpi7puczGU
	 DL0SCQHTLipC4HEF5aHMqezGmRMepR0DHZoqMwNU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilya Guterman <amfernusus@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 321/325] nvme-pci: add NVME_QUIRK_NO_DEEPEST_PS quirk for SOLIDIGM P44 Pro
Date: Mon,  2 Jun 2025 15:49:57 +0200
Message-ID: <20250602134332.970857087@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134319.723650984@linuxfoundation.org>
References: <20250602134319.723650984@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Guterman <amfernusus@gmail.com>

[ Upstream commit e765bf89f42b5c82132a556b630affeb82b2a21f ]

This commit adds the NVME_QUIRK_NO_DEEPEST_PS quirk for device
[126f:2262], which belongs to device SOLIDIGM P44 Pro SSDPFKKW020X7

The device frequently have trouble exiting the deepest power state (5),
resulting in the entire disk being unresponsive.

Verified by setting nvme_core.default_ps_max_latency_us=10000 and
observing the expected behavior.

Signed-off-by: Ilya Guterman <amfernusus@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 49a3cb8f1f105..218c1d69090ec 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3592,6 +3592,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x1e49, 0x0041),   /* ZHITAI TiPro7000 NVMe SSD */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0x025e, 0xf1ac),   /* SOLIDIGM  P44 pro SSDPFKKW020X7  */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1d97, 0x2263), /* Lexar NM610 */
-- 
2.39.5




