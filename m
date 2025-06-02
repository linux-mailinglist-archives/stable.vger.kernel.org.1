Return-Path: <stable+bounces-149576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAF4ACB3F7
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B692A4054EF
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A99622A4F1;
	Mon,  2 Jun 2025 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FZus6W3v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEA3221299;
	Mon,  2 Jun 2025 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874375; cv=none; b=EEnGutf8Ur7YBh1bA34ZStX/IPCUJiwIfHymzwYMnJaCx5/HhIuVJFL2BAzti1iDdDuLBF04wEusT+5Oe4LOF4x3P4SLirMsnwKLkeFuKp8RMH1QsQkNqFd9GsvfNIuIKiZfSWuxgSN8fXN7c+3MfueoPus2b/6bP2ATS/vCAwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874375; c=relaxed/simple;
	bh=Df47sWrmrk5M9d4vGenquA65Sz+ZBSWdfDPsPyVF25s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzEmYEhj4LTdX8dFnxpzrjKUmvyH+3RJPqPC0ZHLg29gOZJSqdrfE3fDGIl4kmn+H41/oTwWg/zqX1UtqvPZbvnQmLqsAi8ghZwkpbR4ak/ZqBHlvZGTIz2VfYtKZxlJVEmKf7m6CLGESb+fEBEh8KkVI6QGPRB2q1+95S3Z2VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FZus6W3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BEBC4CEEB;
	Mon,  2 Jun 2025 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748874374;
	bh=Df47sWrmrk5M9d4vGenquA65Sz+ZBSWdfDPsPyVF25s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FZus6W3v2o6+FLBo8zvG9D5qEim1FL9VLE6pWrsXL3DlXv/97fnmqGDThRk3t0lSW
	 LToDYw27srdCmLimfFeTQB7igZiW2yMw6rJhwQo9KhVx4S+LmwB8M/vau2G7vbvg1Z
	 YXFD/fcRcOw5p+5eHMyksqHHHKEBN/0Sgn/EplwQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilya Guterman <amfernusus@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 439/444] nvme-pci: add NVME_QUIRK_NO_DEEPEST_PS quirk for SOLIDIGM P44 Pro
Date: Mon,  2 Jun 2025 15:48:23 +0200
Message-ID: <20250602134358.755138992@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
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
index 1a33be577397f..97ab91a479d11 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3541,6 +3541,8 @@ static const struct pci_device_id nvme_id_table[] = {
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




