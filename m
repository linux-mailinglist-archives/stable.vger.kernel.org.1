Return-Path: <stable+bounces-86735-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE6B9A3440
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 07:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FA07B22E52
	for <lists+stable@lfdr.de>; Fri, 18 Oct 2024 05:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D87317332C;
	Fri, 18 Oct 2024 05:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YoLVXKlg"
X-Original-To: stable@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE239170A13;
	Fri, 18 Oct 2024 05:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729229477; cv=none; b=OWP8bT0GrDPNZ5smuIlUGy0pOlFglfyOUooL7+7DwhuyIr1lVjrtz61kuIpnJ/HyhdSUReQDkxJo21AEVirSmBsUgXfs7vhue4+igfhKDBsEAj/5mNbkOKbQ9PE9TaVUEzRnxb5To70qHh2/X5BGgr11h7+WkBelfHYKP46ByDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729229477; c=relaxed/simple;
	bh=zahFCON/nEHsDnY5ZPS0ZAvV/Lw28OGPtnYv646hDhA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bWBmtbr+RVR031CbwuDiYVbbc4J+plBFP4f34FTdr+OXmXmuZkxMg0dnsgHNcjI6TG6Q5g8j2Dl0NpvAOQrhyuiiByXOHZ54W5n5rsstozYLr+hit6ivZx3FeHn+zlrTxd1RcKJ7GPaZFCE2oP6WqgGFhKr6UcSlPXK0+hYe9/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YoLVXKlg; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729229473; x=1760765473;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zahFCON/nEHsDnY5ZPS0ZAvV/Lw28OGPtnYv646hDhA=;
  b=YoLVXKlgDW+b7rzVdi8sL5ogvkAHfdQ+BbkBUVJoBFjOHVpu4mISRRlo
   1BpHJngS1MMmcalx/IJqmaNAoT0ZWRUYXkqtxRA6t85m8eOT2zAlfES6z
   1oU3jZ21TOGI0ONnUjVXfdNGV/QU4dPkKEeh9paSAi24/pE0o4VO6LR5C
   jGMJH7upLuQEB5C9r+WeAth023bfXlHNOzwk03ZeK8hoM7TdIHQaRoPNB
   mbH6vAEEWyVEBRHjJMp4kremMftaJCmT7QZpRtVHX60mbLgvHQKlpD2Dj
   lV15Hb3YsxvZXvqYv2hpsinf7pZUsf9WIZSF2/sBMYLWzYYlePqWqNoYp
   w==;
X-CSE-ConnectionGUID: hkq/DbvWS1y0+IOUVxIdig==
X-CSE-MsgGUID: XEqiY2mZSbq96C9kYP9VGg==
X-IronPort-AV: E=Sophos;i="6.11,212,1725292800"; 
   d="scan'208";a="28639438"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2024 13:31:07 +0800
IronPort-SDR: 6711e448_G+ZCLvpk2/PeVuPSnQxVg64ppZ+boCy71PTbxFQm/ll/lyA
 lyix21z/aoVYVUCacvr1woIgrmZEw4o2pMnT5Ow==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2024 21:30:00 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2024 22:31:06 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <avri.altman@wdc.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mmc: core: Use GFP_NOIO in ACMD22
Date: Fri, 18 Oct 2024 08:29:01 +0300
Message-Id: <20241018052901.446638-1-avri.altman@wdc.com>
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
Changes since v1:
 - Move memalloc_noio_restore around (Adrian)
---
 drivers/mmc/core/block.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 04f3165cf9ae..a813fd7f39cc 100644
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
@@ -1018,7 +1020,9 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
 	mrq.cmd = &cmd;
 	mrq.data = &data;
 
+	noio_flag = memalloc_noio_save();
 	blocks = kmalloc(resp_sz, GFP_KERNEL);
+	memalloc_noio_restore(noio_flag);
 	if (!blocks)
 		return -ENOMEM;
 
-- 
2.25.1


