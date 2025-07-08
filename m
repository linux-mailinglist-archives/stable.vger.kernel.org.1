Return-Path: <stable+bounces-161301-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01362AFD4AA
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F1471889E6A
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8398C2E5B12;
	Tue,  8 Jul 2025 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dc/EtmxX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4240A202F70;
	Tue,  8 Jul 2025 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751994180; cv=none; b=Qan7EIPTqoNkDPkGIMT5r3IgdOEaEtpXeLMveSg2/pqqO2w9riuzBZfQkGmXOYITfNJN7y4iJObJsegSLluQov8UYcHbOQ7HBi/pmvemqa48M7D54yoTEcJd7HHyKD1JfAARx43sz3tOD4zHOwLD2ewP83tBQ5+X6HarVqDki5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751994180; c=relaxed/simple;
	bh=Pq+qYefXhzsr99rEpEjyiMTVtiCabrFB0T3fqE/iX+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cv+eKqUEZ7BeTyGkdiJRFVB44sNrkRGH6hqZTTrr9gHRzp6phdSKpdHHl98u3dmdAIaWXDNMmry1wOlGFvBjbY04LflBSmjEQMFAGUfUvtkPRzCNGIwZBptBuHjbABWI/x81fYP4oimA4e0w1gP1ifZkNs7dXCWaTfk13eR1fEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dc/EtmxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC91DC4CEED;
	Tue,  8 Jul 2025 17:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751994180;
	bh=Pq+qYefXhzsr99rEpEjyiMTVtiCabrFB0T3fqE/iX+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dc/EtmxX6t8xBUIDetGHo4oSH/+EmALQdT5EgPidq1rkXe4anv8rZq/Qr9oF4ZL1c
	 ORYP1aUnrbLeWyAhLT/yTQ5SAHUMGjb3i/EFVbvCDAc94OgaUWhuYN22Sp6bHLWwMU
	 4Ukq4ayW8ZomY812/spwriPxkMBJL0u6VF6HmQSU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pablo Martin-Gomez <pmartin-gomez@freebox.fr>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 135/160] mtd: spinand: fix memory leak of ECC engine conf
Date: Tue,  8 Jul 2025 18:22:52 +0200
Message-ID: <20250708162235.128230919@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162231.503362020@linuxfoundation.org>
References: <20250708162231.503362020@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>

[ Upstream commit 6463cbe08b0cbf9bba8763306764f5fd643023e1 ]

Memory allocated for the ECC engine conf is not released during spinand
cleanup. Below kmemleak trace is seen for this memory leak:

unreferenced object 0xffffff80064f00e0 (size 8):
  comm "swapper/0", pid 1, jiffies 4294937458
  hex dump (first 8 bytes):
    00 00 00 00 00 00 00 00                          ........
  backtrace (crc 0):
    kmemleak_alloc+0x30/0x40
    __kmalloc_cache_noprof+0x208/0x3c0
    spinand_ondie_ecc_init_ctx+0x114/0x200
    nand_ecc_init_ctx+0x70/0xa8
    nanddev_ecc_engine_init+0xec/0x27c
    spinand_probe+0xa2c/0x1620
    spi_mem_probe+0x130/0x21c
    spi_probe+0xf0/0x170
    really_probe+0x17c/0x6e8
    __driver_probe_device+0x17c/0x21c
    driver_probe_device+0x58/0x180
    __device_attach_driver+0x15c/0x1f8
    bus_for_each_drv+0xec/0x150
    __device_attach+0x188/0x24c
    device_initial_probe+0x10/0x20
    bus_probe_device+0x11c/0x160

Fix the leak by calling nanddev_ecc_engine_cleanup() inside
spinand_cleanup().

Signed-off-by: Pablo Martin-Gomez <pmartin-gomez@freebox.fr>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/spi/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 2c8685f1f2fa7..80d0112d18fa6 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1271,6 +1271,7 @@ static void spinand_cleanup(struct spinand_device *spinand)
 {
 	struct nand_device *nand = spinand_to_nand(spinand);
 
+	nanddev_ecc_engine_cleanup(nand);
 	nanddev_cleanup(nand);
 	spinand_manufacturer_cleanup(spinand);
 	kfree(spinand->databuf);
-- 
2.39.5




