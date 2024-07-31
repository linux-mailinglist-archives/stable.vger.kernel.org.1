Return-Path: <stable+bounces-64722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9516942860
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 09:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3435FB21A38
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 07:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CCF1A4B2F;
	Wed, 31 Jul 2024 07:51:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DC023BB;
	Wed, 31 Jul 2024 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722412298; cv=none; b=WV9QQcpeffrTj8FcVsa8RTZ+r8ofGWFWeagT1wOtNrch2T0NVI1jLPivlaKqFNdawvgrau325iqTTO00n3/EImbOhq7UGdWgcQ+Bl4Hcp/nno2CeTxsEqzBaXpINCm+fWMZz2guaAtb89g5MgkkJbQdvpvGoBJn7Whrp2G2jEzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722412298; c=relaxed/simple;
	bh=jiHU8OiHPKXJt0KPearOgl8ijnY3j+fQwSbmCOlTGjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J0NbpV9kd9ufNnDmlq8ghdL6j68BJ5G2f6/yyC7biXEgpDsPln2YuL/Wtix37d1kFoywJQ8QIlIgdiauiJbYEyRjJLshQcYHbX1lz4ModsKOtMhU07tvKUzB+tmZRBP1hWYe0Fpf6YGM63SVhxcZSBAhhrZ94UYFj/bVUV+TFZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp86t1722412278tv5jy79k
X-QQ-Originating-IP: /LoQ+eBEaan91O7qeNFgWqx3AXrtkGlcAZElbE97q+8=
Received: from uniontech.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 31 Jul 2024 15:51:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 133545180629308165
From: Erpeng Xu <xuerpeng@uniontech.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	shyjumon.n@intel.com
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	"linux-nvme@lists.infradead.orglinux-kernel"@vger.kernel.org,
	linux-kernel@vger.kernel.org, jonathan.derrick@intel.com,
	wangyuli@uniontech.com, Erpeng Xu <xuerpeng@uniontech.com>
Subject: [PATCH 4.19] nvme/pci: Add sleep quirk for Samsung and Toshiba drives
Date: Wed, 31 Jul 2024 15:50:46 +0800
Message-ID: <87182CEADE011558+20240731075113.51089-1-xuerpeng@uniontech.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1

From: Shyjumon N <shyjumon.n@intel.com>

commit 1fae37accfc5872af3905d4ba71dc6ab15829be7 upstream

The Samsung SSD SM981/PM981 and Toshiba SSD KBG40ZNT256G on the Lenovo
C640 platform experience runtime resume issues when the SSDs are kept in
sleep/suspend mode for long time.

This patch applies the 'Simple Suspend' quirk to these configurations.
With this patch, the issue had not been observed in a 1+ day test.

Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shyjumon N <shyjumon.n@intel.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Erpeng Xu <xuerpeng@uniontech.com>
---
 drivers/nvme/host/pci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9c80f9f08149..b0434b687b17 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2747,6 +2747,18 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		    (dmi_match(DMI_BOARD_NAME, "PRIME B350M-A") ||
 		     dmi_match(DMI_BOARD_NAME, "PRIME Z370-A")))
 			return NVME_QUIRK_NO_APST;
+	} else if ((pdev->vendor == 0x144d && (pdev->device == 0xa801 ||
+		    pdev->device == 0xa808 || pdev->device == 0xa809)) ||
+		   (pdev->vendor == 0x1e0f && pdev->device == 0x0001)) {
+		/*
+		 * Forcing to use host managed nvme power settings for
+		 * lowest idle power with quick resume latency on
+		 * Samsung and Toshiba SSDs based on suspend behavior
+		 * on Coffee Lake board for LENOVO C640
+		 */
+		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
+		     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
+			return NVME_QUIRK_SIMPLE_SUSPEND;
 	}
 
 	return 0;
-- 
2.45.2


