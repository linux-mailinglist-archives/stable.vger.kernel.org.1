Return-Path: <stable+bounces-179484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C93AB56157
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 16:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DCD13BC8E1
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 14:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108F92EBDFD;
	Sat, 13 Sep 2025 14:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1b2DSTM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42811E515
	for <stable@vger.kernel.org>; Sat, 13 Sep 2025 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757772620; cv=none; b=GRqB1Kf1D5Z5X4oGsxV0JlM3Um4i0Zo7+tvgKbGXqTRz0tajRZsVXx7Psh4YrZoQtt6QRSOeb4qBmjVmTRo4bk3tfrOULkvCxKIp2228nEG/+MsSR52TpSJJiHuglr2Ugj4xy34C85AWzRZlsFcgBO1nkSRo49rwBkR0pPLOEbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757772620; c=relaxed/simple;
	bh=ShTIfg/nWe9l1HFwk7FyIYML7NbBCFBs24+Xq3txdFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKjeTLxH9KTN3wDHfWFGN6HyvPRr4Olniz5jfcfY6wSU99Qlk2+myrptNz8zw88tLSXCbCzoCqxiqb2GSDvgGJSDRxTrLEwBVrpwoKEeEwVjdcwvYCYhvcNgc5+srr3+H/GK8l3f6VLD8ZbiIac+g32VtJGtj20/3o5U6g7qOJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1b2DSTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC94DC4CEEB;
	Sat, 13 Sep 2025 14:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757772620;
	bh=ShTIfg/nWe9l1HFwk7FyIYML7NbBCFBs24+Xq3txdFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q1b2DSTMnCDxM/IZaalAsHaXK4vCoAEmjX6CMbqEglo2z+slfBygR5l6mDvE0XuPU
	 t1wt7AcsJlnyK3JmzW64BT9/pTnA8u8Q4AqGXIXvCNAuoBT8q5HJJ0pqn3TfwRYkab
	 SKO7dQKWeV93G6e2B9gQbqyLeNmGiEQSqdHrbE8QQZGyjwiSY3d8O/RNFAusrMb1TF
	 EaWsw9K4iT013Hpf+WkW/7MIl1/qajWCX2LTXei85MaDdJbu9j7pWf51sKpCt6kbUy
	 eCmpM2Ru0bBrIw30d5UEtsIHX+WmvhJLWn9RYt8bpW9WTMcyKCVn3JxbndDC9Rdg+u
	 aQdSAXiaxrs0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Dahl <ada@thorsis.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] mtd: nand: raw: atmel: Fix comment in timings preparation
Date: Sat, 13 Sep 2025 10:10:16 -0400
Message-ID: <20250913141017.1361840-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025091345-disinfect-afterlife-38dd@gregkh>
References: <2025091345-disinfect-afterlife-38dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Dahl <ada@thorsis.com>

[ Upstream commit 1c60e027ffdebd36f4da766d9c9abbd1ea4dd8f9 ]

Looks like a copy'n'paste mistake introduced when initially adding the
dynamic timings feature with commit f9ce2eddf176 ("mtd: nand: atmel: Add
->setup_data_interface() hooks").  The context around this and
especially the code itself suggests 'read' is meant instead of write.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
Reviewed-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20240226122537.75097-1-ada@thorsis.com
Stable-dep-of: fd779eac2d65 ("mtd: nand: raw: atmel: Respect tAR, tCLR in read setup timing")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/atmel/nand-controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index d4fd1302008eb..6e4a0c6c7cb4d 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1378,7 +1378,7 @@ static int atmel_smc_nand_prepare_smcconf(struct atmel_nand *nand,
 		return ret;
 
 	/*
-	 * The write cycle timing is directly matching tWC, but is also
+	 * The read cycle timing is directly matching tRC, but is also
 	 * dependent on the setup and hold timings we calculated earlier,
 	 * which gives:
 	 *
-- 
2.51.0


