Return-Path: <stable+bounces-87586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F459A6E47
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 17:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2171C22814
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 15:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477CB1C3F2C;
	Mon, 21 Oct 2024 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZtGSkRg8"
X-Original-To: stable@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECCC1B59A;
	Mon, 21 Oct 2024 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524891; cv=none; b=K3okkNetpvFKyMkNKmjEy8AeECTV2mB3Da52n+tSpjMm9NSFc4cRTJL84+ju8l+Vl+lBaxE78fLmxCSM0OfzizzIGuqiH9KkUg4Ds9qWDsrVDdnOfgfG5/pJjEU9zrinb/9EAjQVf/S8MpfBsxzmb+KVj/gPh5kqTs0UE59u70o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524891; c=relaxed/simple;
	bh=7VRdMailOg7JOvYIF3nyLsPEfQw6Rkv6/TR7WiPjUbk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ifSanmpdid1jGydgZld7Ab8HYZJMiPrlq3WKpkqqStJHAPA8UBIDVXAUwEW7IgKeDCDQamz8/9+LaoeXz9B2wVZq4khB7rzhAC3IrPBaDttUcfjp3VtN+tjTN0ESUUYN/4Vz5FXdOcjVq8bWPSThekiAIQmotK1i25JHMQmTt/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZtGSkRg8; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729524889; x=1761060889;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7VRdMailOg7JOvYIF3nyLsPEfQw6Rkv6/TR7WiPjUbk=;
  b=ZtGSkRg85YdzQPmXYA+zBRzrKA93RksVccngVHnKBHyOpOXgLSiVlt4E
   wB14kg4tHMNHh6O/qFus/yILnpsck6H3vSw2psHUMj3LNn2H/7vAGDfZ2
   guGzvmSwblWzwaio+larlpQXqJmU32rZDyCmHK8frQKdG9YswACIhgmaW
   kTCYumfsGYXHzPTHsrYJIJbGHeo+vZsZbxG5rjN4KB8ZUdxsojVPM4XA5
   fQIqhgr2tQsPlB25IgZ/IvwTh6FEWgf/Sa9s0VY5Zxt+NmQ226nAVhoSz
   UhaWO2Dj0ss+3fVeI0HyWUxtL9APvc1xNfg2RKmS/IiS/ETaoF8MjLbfn
   Q==;
X-CSE-ConnectionGUID: 53wcg7pwRPiKy+EasypaDQ==
X-CSE-MsgGUID: d4DjXNTCRSK0J0U06U3dwQ==
X-IronPort-AV: E=Sophos;i="6.11,221,1725292800"; 
   d="scan'208";a="30473379"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2024 23:34:41 +0800
IronPort-SDR: 67166623_DfO5L39hsxxNOQ88/twn+EQalEa9WzD7Z2Crv2CZsHw+GP/
 L88LyHE+wIDvA3Qeil0xQFSKib3ymkHuzsvjM9A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2024 07:33:08 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Oct 2024 08:34:41 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <avri.altman@wdc.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] mmc: core: Use GFP_NOIO in ACMD22
Date: Mon, 21 Oct 2024 18:32:27 +0300
Message-Id: <20241021153227.493970-1-avri.altman@wdc.com>
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

[1] https://lore.kernel.org/linux-mmc/3016fd71-885b-4ef9-97ed-46b4b0cb0e35@intel.com/

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: 051913dada04 ("mmc_block: do not DMA to stack")
Signed-off-by: Avri Altman <avri.altman@wdc.com>
Cc: stable@vger.kernel.org

---
Changes since v2:
 - Fix checkpatch warnings (Adrian)

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


