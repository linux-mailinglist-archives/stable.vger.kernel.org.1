Return-Path: <stable+bounces-200350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B7ACAD415
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 14:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2313A3064BD9
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 13:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75DA2EB5C6;
	Mon,  8 Dec 2025 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="ZJ4W4an2"
X-Original-To: stable@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0C03B8D7C;
	Mon,  8 Dec 2025 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765200257; cv=none; b=DeFXhn9SepSanMQKrC66y95GjNRUJCPM5pXea4tjm8oRdfdO8GCIbPlDFqZvqrxKvYaZykH2sjcxAkFuZNjFcgsafet48HbvvIHzJIe/2pQWKwQnFyiWt7YOLNBb1cg0vt13jYo5VsgLOVdxep19RKf0iFMuHt20L24zEIjdie0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765200257; c=relaxed/simple;
	bh=1eOsjkVyqljHHAUvFpsqS6srjVsOgv5YZkpVTLepo4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jwybrYtrgf1hSqfooAgK4iUGDJANFdcUVxsPcIPfA0zC6xUkt/TErKGBf9Hpv6WvIyvSu9I85MC4SS1DMgm0Nx/y1v3eCTO34/jpvLIEtxJCjF2p75dORNLeqGbKG97CcoZt6wVcZNoJWxB512Vijwh6ke6o5cyRJ/yk1qpOQ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=ZJ4W4an2; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [151.80.165.199])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id D73F82023A;
	Mon,  8 Dec 2025 13:24:13 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay2.mymailcheap.com (Postfix) with ESMTPS id AA8333E88F;
	Mon,  8 Dec 2025 13:24:05 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id D679A40085;
	Mon,  8 Dec 2025 13:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1765200244; bh=1eOsjkVyqljHHAUvFpsqS6srjVsOgv5YZkpVTLepo4g=;
	h=From:To:Cc:Subject:Date:From;
	b=ZJ4W4an23CnzAybbzVa1H/xtTGhIQWmIo1MRzNKq3tVe20Dgz6RxAgcGtF85vYh2a
	 Ik36MErxSiXoDV5+ZRKUzVGJ8UoTDJjeI1qFI8l/dnw10m2FOOj1eg2gaNCT26TNJd
	 LDFnz8KwypTnX+Vdhf31Y3i5BxJq3ej/KA1iV9vI=
Received: from DESKTOP-FDAJS95.localdomain (unknown [111.40.58.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 7211143C40;
	Mon,  8 Dec 2025 13:23:59 +0000 (UTC)
From: Ilikara Zheng <ilikara@aosc.io>
To: linux-kernel@vger.kernel.org
Cc: Wu Haotian <rigoligo03@gmail.com>,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Ilikara Zheng <ilikara@aosc.io>,
	stable@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER)
Subject: [PATCH] nvme-pci: add quirk for Wodposit WPBSNM8-256GTP to disable secondary temp thresholds
Date: Mon,  8 Dec 2025 21:23:40 +0800
Message-ID: <20251208132340.1317531-1-ilikara@aosc.io>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Queue-Id: D679A40085
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.40 / 10.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	BAYES_HAM(-0.00)[42.12%];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_SEVEN(0.00)[11];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[ilikara.aosc.io:server fail,stable.vger.kernel.org:server fail];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,aosc.io,vger.kernel.org,kernel.org,kernel.dk,lst.de,grimberg.me,lists.infradead.org];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]

Secondary temperature thresholds (temp2_{min,max}) were not reported
properly on this NVMe SSD. This resulted in an error while attempting to
read these values with sensors(1):

  ERROR: Can't get value of subfeature temp2_min: I/O error
  ERROR: Can't get value of subfeature temp2_max: I/O error

Add the device to the nvme_id_table with the
NVME_QUIRK_NO_SECONDARY_TEMP_THRESH flag to suppress access to all non-
composite temperature thresholds.

Cc: stable@vger.kernel.org
Signed-off-by: Ilikara Zheng <ilikara@aosc.io>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e5ca8301bb8b..31049f33f27d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3997,6 +3997,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x1e49, 0x0041),   /* ZHITAI TiPro7000 NVMe SSD */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0x1fa0, 0x2283),   /* Wodposit WPBSNM8-256GTP */
+		.driver_data = NVME_QUIRK_NO_SECONDARY_TEMP_THRESH, },
 	{ PCI_DEVICE(0x025e, 0xf1ac),   /* SOLIDIGM  P44 pro SSDPFKKW020X7  */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
-- 
2.52.0


