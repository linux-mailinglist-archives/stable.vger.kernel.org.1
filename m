Return-Path: <stable+bounces-83773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6171499C94C
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 13:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F0D293768
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 11:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BDF19B5B5;
	Mon, 14 Oct 2024 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Gr0Ifhnq"
X-Original-To: stable@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3671155C98;
	Mon, 14 Oct 2024 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728906441; cv=none; b=PZkYcP6bw5aNrqQ5ZwrTZ1WJtMywL7Ja7+ItDgYNA/ACXntQIp0uXHZdg49nGN0gHa5YcXKrWGx4rUZTzt/dYQQ8YC/OfEXMtaCI06BEUTQS2NAyEPeuHmAU4KOip4ktYMTphxUl7JXzlkSYZuDcuHQQ0ZEnNQoa+BgoAGhaJr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728906441; c=relaxed/simple;
	bh=AWJgrul1P5JuyTEwxIwQwFe9pB8DXf5Ro+M4hdQpkxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y6uZiXpzso09EZJltf5iDm+9zeMwWeybKIUxRBDEPTOiL6g84+FydozQ7+SeAlACfxvOCKDN8T3en4D3BLgsiBYQlvVzukmQz8KUgebYpdYx3DEj+j6ittfyPx9OeiOdlhxZ2RZsn6rGHkUOULoO7GYxJGUG2/W+TXt48WzhUL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Gr0Ifhnq; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728906438; x=1760442438;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AWJgrul1P5JuyTEwxIwQwFe9pB8DXf5Ro+M4hdQpkxo=;
  b=Gr0IfhnqPwWuqvol45Z3xOXvQUInaWFRDdJB/ZzD0NZyGXmVeB+Ta9AU
   Vmw45Sk7VsaOsWD93HAOTEFzB2udsiIM2HmfMvQpwl3gyQWQ9O88KaeXz
   /VtuNsxnmgnk3wUaXSlR2pEltdBW/pdgu69YWmdYfukCD+7e1CZnaHAS+
   c0daP/WV8CDbmBQh0r8HizPqRGNwSVaePvIuMYcRVPKvyWtr4QVAmwY3J
   ud9TiSKNg3K0m4IYPBrh0Hyc2udK8+VmXexGe0/qwf/dPlI8vD3y4JPVv
   R69GH4DpCUDgGOVmKGyhmZ4C8fVcN/jDHgXJZNTawnkuJ36r9tSl+/NIu
   w==;
X-CSE-ConnectionGUID: 5/oXlSzGSt+teTnQijKpIA==
X-CSE-MsgGUID: lpaEee2jQNOGIDwmcbAUyQ==
X-IronPort-AV: E=Sophos;i="6.11,202,1725292800"; 
   d="scan'208";a="28289455"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2024 19:47:11 +0800
IronPort-SDR: 670cf671_7+ubMzr/UmCSqEjL198X9ZS8iUg/NuoggPfDGp1EZf4X65D
 KXX9ZI5jvhCHSKIgluIWRU++ZRvUW2brmO76fDA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2024 03:46:10 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2024 04:47:11 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <avri.altman@wdc.com>,
	stable@vger.kernel.org
Subject: [PATCH] mmc: core: Use GFP_NOIO in ACMD22
Date: Mon, 14 Oct 2024 14:44:58 +0300
Message-Id: <20241014114458.360538-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While reviewing the SDUC series, Adrian made a comment concerning the
memory allocation code in mmc_sd_num_wr_blocks() - see [1].
Prevent memory allocations from triggering I/O operations while ACMD22
is in progress.

[1] https://www.spinics.net/lists/linux-mmc/msg82199.html

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Avri Altman <avri.altman@wdc.com>
Cc: stable@vger.kernel.org
---
 drivers/mmc/core/block.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 04f3165cf9ae..042b0147d47e 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -995,6 +995,8 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 	u32 result;
 	__be32 *blocks;
 	u8 resp_sz = mmc_card_ult_capacity(card) ? 8 : 4;
+	unsigned int noio_flag;
+
 	struct mmc_request mrq = {};
 	struct mmc_command cmd = {};
 	struct mmc_data data = {};
@@ -1018,9 +1020,13 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 	mrq.cmd = &cmd;
 	mrq.data = &data;
 
+	noio_flag = memalloc_noio_save();
+
 	blocks = kmalloc(resp_sz, GFP_KERNEL);
-	if (!blocks)
+	if (!blocks) {
+		memalloc_noio_restore(noio_flag);
 		return -ENOMEM;
+	}
 
 	sg_init_one(&sg, blocks, resp_sz);
 
@@ -1041,6 +1047,8 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 	}
 	kfree(blocks);
 
+	memalloc_noio_restore(noio_flag);
+
 	if (cmd.error || data.error)
 		return -EIO;
 
-- 
2.25.1


