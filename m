Return-Path: <stable+bounces-152706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B48CFADB169
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 15:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3594170AF7
	for <lists+stable@lfdr.de>; Mon, 16 Jun 2025 13:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F17B2DBF6D;
	Mon, 16 Jun 2025 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="I6KwpY03"
X-Original-To: stable@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1395A285CBF;
	Mon, 16 Jun 2025 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750079647; cv=none; b=d4UTXKUC9ek14xEh0UZtxcOQ5rH9O57onW9UI2UTUeMNFT58X7Lzm5EiPqXyXZHFqc2d/AIi4cPoQE4sHLBi+qSO42jpeI5cMTsbWtlRu2moecacBEf8S4Ap5s5n96DNxmws7nW8Yt4msYbofJ8v9ehIcQD6ECKxoDbMHeSV0LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750079647; c=relaxed/simple;
	bh=wn1OkAAM2Ccd9UCgqxhQGWkH0mXDr7YIcyVSK3M2wtw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iVHKByKnhsWfdd6XOFPCwXY+ov/nH0IUio2MW2nxV0lXQHN4z1bz1M2R+rnP/Ml3aFSnfz2TzzCOZ2iKZ/akycKVO1zixj49LYsIV55QatWkBDORD/HxEHSaPSrnQpYKar0dhI/ueTKB/YzOmDJtXoSjjwgBBeSNJrRyQKJkv2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=I6KwpY03; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750079637;
	bh=uPBAGZy6R1PjnTGdxsiEYdDy+NUG1t2EFZNMiKI6egA=;
	h=From:Subject:Date:To:Cc;
	b=I6KwpY03w88PFgiWEf2PmautpWVe9dZGZTdWKrhOf0aHsSlZTZAcWf4qW3uPN/25n
	 pPIcnBuY49xhsixkLINKjlxQRU9emTcGcTKB+ORxw+4v7yICvZgcqwmXUeff9CrJ/o
	 HBC14x4EOgZKGbqKbDUcAEcL2Ia5l9A+bfaUlPeEjQPoEf7bH0a4ooFEU1UzH67QBF
	 1zAyoTG5MwgyQaXtziDa6DJcJmFigh+iatbuzLwU4fZjE6wIM31gdtcMS8oqa9ZCTG
	 sDGz57TESvcZBSMAGjGi6L6V8JVTCFO+kJKamaFVwDQpFU/XfbcP9zqCttLzLJWzB5
	 CUNdX8WNfOYLQ==
Received: from [127.0.1.1] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 596AA685DD;
	Mon, 16 Jun 2025 21:13:55 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PATCH v2 00/10] soc: aspeed: lpc-snoop: Miscellaneous fixes
Date: Mon, 16 Jun 2025 22:43:37 +0930
Message-Id: <20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd59c934d3@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIEYUGgC/3WNyw6CMBREf4V07SV9ACGu/A/Domkv0kTb2luIh
 vDvVjRx5fLMZOasjDA5JHasVpZwceSCLyAPFTOT9hcEZwszyWXLGy5AU0S0cI0GyIcQYXQPJMD
 Wyr5XViutWBnHhHtRtufhwwnvc/nPv3BylEN67vJFvNOvR/z1LAI4dM3YSolK2248mWDRBE85z
 SbXJtxqPbNh27YXhBDrSNwAAAA=
X-Change-ID: 20250401-aspeed-lpc-snoop-fixes-e5d2883da3a3
To: linux-aspeed@lists.ozlabs.org
Cc: Joel Stanley <joel@jms.id.au>, Henry Martin <bsdhenrymartin@gmail.com>, 
 Jean Delvare <jdelvare@suse.de>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Andrew Geissler <geissonator@yahoo.com>, 
 Ninad Palsule <ninad@linux.ibm.com>, Patrick Venture <venture@google.com>, 
 Robert Lippert <roblip@gmail.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

Henry's bug[1] and fix[2] prompted some further inspection by
Jean.

This series provides fixes for the remaining issues Jean identified, as
well as reworking the channel paths to reduce cleanup required in error
paths. It is based on v6.16-rc1.

Lightly tested under qemu and on an AST2600 EVB. Further testing on
platforms designed around the snoop device appreciated.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=219934
[2]: https://lore.kernel.org/all/20250401074647.21300-1-bsdhenrymartin@gmail.com/

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
Changes in v2:
- Address comments on v1 from Jean
- Implement channel indexing using enums to avoid unnecessary tests
- Switch to devm_clk_get_enabled()
- Use dev_err_probe() where possible
- Link to v1: https://patch.msgid.link/20250411-aspeed-lpc-snoop-fixes-v1-0-64f522e3ad6f@codeconstruct.com.au

---
Andrew Jeffery (10):
      soc: aspeed: lpc-snoop: Cleanup resources in stack-order
      soc: aspeed: lpc-snoop: Don't disable channels that aren't enabled
      soc: aspeed: lpc-snoop: Ensure model_data is valid
      soc: aspeed: lpc-snoop: Constrain parameters in channel paths
      soc: aspeed: lpc-snoop: Rename 'channel' to 'index' in channel paths
      soc: aspeed: lpc-snoop: Rearrange channel paths
      soc: aspeed: lpc-snoop: Switch to devm_clk_get_enabled()
      soc: aspeed: lpc-snoop: Use dev_err_probe() where possible
      soc: aspeed: lpc-snoop: Consolidate channel initialisation
      soc: aspeed: lpc-snoop: Lift channel config to const structs

 drivers/soc/aspeed/aspeed-lpc-snoop.c | 224 +++++++++++++++++-----------------
 1 file changed, 110 insertions(+), 114 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250401-aspeed-lpc-snoop-fixes-e5d2883da3a3

Best regards,
-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


