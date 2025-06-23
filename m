Return-Path: <stable+bounces-157909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EA2AE562C
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6C081BC76AD
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938B122422F;
	Mon, 23 Jun 2025 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ddt+sxwM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5230E1F7580;
	Mon, 23 Jun 2025 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717016; cv=none; b=RzZfE7LIuR9Wq+AVfe5sp8IxdkmwKPijVfqV+rtZeCikAMi1XekBPBXcxCTWiCYvgM112/a979lmqVEHm6yswzQkZ6/oowcJFUiRvRpOHbtdic7CpdtNBx6RYP1XKq599XYJQlkmspMLOHl9w0mopzzw08IxZBO5bs2ItsPPXB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717016; c=relaxed/simple;
	bh=og+tfn45YeGxOAKIMepS2uQakd7qJN8vJVvXn1yEZ9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y63G2sf5NhFhjPKc2hxN/9r6GKdtABN82Rt/55svib9Ix5MrgnBb9GxyX6+TVOJcSFlGMENbRt+QN83xdfCljoLM8Dot1hKW64mfiaRUC49BjWkyfc2A9xHrlaE9JBSA5DwuQepvbV7gRugnP4c3+Ppe4FgTiQCJ+2nHlhbktDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ddt+sxwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF36CC4CEEA;
	Mon, 23 Jun 2025 22:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717016;
	bh=og+tfn45YeGxOAKIMepS2uQakd7qJN8vJVvXn1yEZ9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ddt+sxwMEaNMp3r1iCMFA8ZUbAG7fBaFlH5LRCrzrLH0iMC7HVKKnbsva8oowZhYy
	 Sj1r5fXNzjPpRsJ0ylj6x8iOemAkRD1xBeGoHpO1OD4IilACr+BK5cmFNFnmaoNBj/
	 4PgbTyHJ4o+PSO5CzxGFKb44AaDeIJicuFge8K/c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wentao Liang <vulab@iscas.ac.cn>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 6.1 354/508] mtd: nand: sunxi: Add randomizer configuration before randomizer enable
Date: Mon, 23 Jun 2025 15:06:39 +0200
Message-ID: <20250623130654.068741397@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
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

From: Wentao Liang <vulab@iscas.ac.cn>

commit 4a5a99bc79cdc4be63933653682b0261a67a0c9f upstream.

In sunxi_nfc_hw_ecc_read_chunk(), the sunxi_nfc_randomizer_enable() is
called without the config of randomizer. A proper implementation can be
found in sunxi_nfc_hw_ecc_read_chunks_dma().

Add sunxi_nfc_randomizer_config() before the start of randomization.

Fixes: 4be4e03efc7f ("mtd: nand: sunxi: add randomizer support")
Cc: stable@vger.kernel.org # v4.6
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/nand/raw/sunxi_nand.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -829,6 +829,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(s
 	if (ret)
 		return ret;
 
+	sunxi_nfc_randomizer_config(nand, page, false);
 	sunxi_nfc_randomizer_enable(nand);
 	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
 	       nfc->regs + NFC_REG_CMD);



