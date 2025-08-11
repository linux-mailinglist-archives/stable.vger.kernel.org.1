Return-Path: <stable+bounces-166983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0B5B1FE9B
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 07:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48BE7169186
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 05:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9997726B0AE;
	Mon, 11 Aug 2025 05:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YVgafQ9d"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03521FF61E
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 05:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754890442; cv=none; b=vFf4CQ1VPzFW+FnZWneomGgkhkDjrDhTZ/qEnVI95jfEF8+l0CbgrCwD/0UvPH7DZwaOOZ7VgYVro5kK26K7GSCApf95HV0/B/i3R1+OjjQOa7xG6jWWT6G+qWZOTF6fTgOc/X3jNr7mE31SSaJWT2GqZLuZqwBoAbzPJUKMULE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754890442; c=relaxed/simple;
	bh=5sIIX3QUuzaegHNd+6NUT4Vvb6PsIrXVllYiGJIz/tE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OCKLDjrg4qQ/62vtVUidLuP/hr1Ifc6k54Mh/1xNt3Spj055XTqK3JUa9EFWUnTIVmuJV5arXBzCXsh/13oBi8ls3gvIGFYWy3UyHYNEpZF3UmseUh2kZYEF7Wn323/zMLR4oCkMZiOQxNMdpibrLiAZuazJn+Xs2gIsDjlSbxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=YVgafQ9d; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-321265ae417so4478474a91.2
        for <stable@vger.kernel.org>; Sun, 10 Aug 2025 22:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754890440; x=1755495240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHnkr22dY5CgwiPLBWthXGPdFU+dhhWu46oxcV2g8cY=;
        b=tJEE/6Xx9Il8ULfimzx+ISsO7ZqaDkV2x2yoWMAASObCs2iyLiWQMg8UsQ3xhueZU1
         iNN3PqOzS14YlgbfOikJeR51bJ6TJrAwZssgultu0iDnKV7AAPS+gyvysIW/pUfkjvAf
         HYP9caJBL7VxqK52vmm/uGzwyXVDh/mU9M18F2DEg9mJEsqN/WG8C0q569qvUHK2G6g1
         4o91myFI8FLRtuezg+iS9uwrVpNt1jifBsBQiiaf9TeAkDeq2np05mV6umSF+9J7TByf
         P9Wlh8k99n+3Im/oMFzridWetjohLXo2ibnYQObRNoW6dW0+0N7pWR+guTYm/Qu3nCAh
         1ttw==
X-Gm-Message-State: AOJu0YyykvUVq7iWmZgqa6qleNq4BaNKjnZxBrNEqkkDeSA8LVJV7c9o
	2e7HmhcICiez63fuPZis7DjutRpcwNgoOySFIb7KbZ9S10vPJQcbd52NOQQxppaNRisaBaVPYlv
	V805iIZNDf+xPHGZiEm6BsS55ePW2WZrfXhFY+IenKqTgsMpjIkJ3je+zYhPd7g+/VFfN1Re3fU
	9dR2uba2YzzqEdMTcYRDhIxHc4tFhZbreRKV1zQRmVl/xa+wMd5BRyQWuqwWXioING857TkDru/
	rZvSwMkiidjwPqbnA==
X-Gm-Gg: ASbGnctMZYv3FRVvIojGNfoiogZ3LGClcU0UhXca1e/LknfSRkDCHK91XCXtQiNv52n
	sHEqN/zLMzWRtjtcdxai5G06Hk/I3GlllatkJA9BMOEUVUE9XS4t+nCGv2YjJcknShIcfwI1fS6
	YL09YZ+lD2PKk7I2aFgL64jULHrMv1V1ANBXMkWKWbAKdLX/VeFj8uBXFTFZgTTHUaiJG1C4Ffo
	rVezhFTSxYr2pmWm8nJdoSsTpXrYr/pyBf3+vQkCL+sGtrIs2jzU/cxf9B4JahQQp3CUIn+LxpP
	RXm4exLSLcIwQv4m1gh4muga6nbol53Km3AIllvs2AEcLYAVDus5Z8RnjuV36MluV5eI0DTDygM
	5JxHz3q0U/Uepe2+wObfX6CtLCMVI/NojV76asnN93lofgUGKG3ct6DkyMF4xxEzKCfH+i38OLn
	sQEXU=
X-Google-Smtp-Source: AGHT+IFunrvo3cYsYMPQs34d9o7FYmc5/zl+SRQXMalDPINi3ob3LPaJZQmToS5GYRClfeML0znf1beJeysl
X-Received: by 2002:a17:902:ec86:b0:235:ed01:18cd with SMTP id d9443c01a7336-242c222abfbmr177896055ad.44.1754890439985;
        Sun, 10 Aug 2025 22:33:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-241d1ef6c06sm16207355ad.8.2025.08.10.22.33.59
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Aug 2025 22:33:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e7ffe84278so850182585a.2
        for <stable@vger.kernel.org>; Sun, 10 Aug 2025 22:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754890438; x=1755495238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RHnkr22dY5CgwiPLBWthXGPdFU+dhhWu46oxcV2g8cY=;
        b=YVgafQ9dJy24TVE3kDw0J/6CbufH16fDtt4Wa489IIVtriWxrR1R3FSIok7L6am0HN
         WQ2Zvlb9+MkoIlYY4Th2VJ7HfWIW1Pt9eFQQFE0uJ6HjDkAOiiSFjOhZSQDog7ve84lZ
         bkdqvkULAREXFAN4FuMm3BXpJ5OF0Z4bEEYOU=
X-Received: by 2002:a05:620a:190e:b0:7e6:38ab:fd8d with SMTP id af79cd13be357-7e82c79fc28mr1849182085a.50.1754890438377;
        Sun, 10 Aug 2025 22:33:58 -0700 (PDT)
X-Received: by 2002:a05:620a:190e:b0:7e6:38ab:fd8d with SMTP id af79cd13be357-7e82c79fc28mr1849178685a.50.1754890437784;
        Sun, 10 Aug 2025 22:33:57 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e816a9a3cdsm769870885a.23.2025.08.10.22.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 22:33:57 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com,
	James.Bottomley@HansenPartnership.com,
	jinpu.wang@cloud.ionos.com,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	Ajish Koshy <Ajish.Koshy@microchip.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Viswas G <Viswas.G@microchip.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10] scsi: pm80xx: Fix memory leak during rmmod
Date: Sun, 10 Aug 2025 22:20:35 -0700
Message-Id: <20250811052035.145021-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Ajish Koshy <Ajish.Koshy@microchip.com>

[ Upstream commit 51e6ed83bb4ade7c360551fa4ae55c4eacea354b ]

Driver failed to release all memory allocated. This would lead to memory
leak during driver removal.

Properly free memory when the module is removed.

Link: https://lore.kernel.org/r/20210906170404.5682-5-Ajish.Koshy@microchip.com
Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Ajish Koshy <Ajish.Koshy@microchip.com>
Signed-off-by: Viswas G <Viswas.G@microchip.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/scsi/pm8001/pm8001_init.c | 11 +++++++++++
 drivers/scsi/pm8001/pm8001_sas.h  |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index f40db6f40b1d..45bffa49f876 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -1166,6 +1166,7 @@ pm8001_init_ccb_tag(struct pm8001_hba_info *pm8001_ha, struct Scsi_Host *shost,
 		goto err_out;
 
 	/* Memory region for ccb_info*/
+	pm8001_ha->ccb_count = ccb_count;
 	pm8001_ha->ccb_info = (struct pm8001_ccb_info *)
 		kcalloc(ccb_count, sizeof(struct pm8001_ccb_info), GFP_KERNEL);
 	if (!pm8001_ha->ccb_info) {
@@ -1226,6 +1227,16 @@ static void pm8001_pci_remove(struct pci_dev *pdev)
 			tasklet_kill(&pm8001_ha->tasklet[j]);
 #endif
 	scsi_host_put(pm8001_ha->shost);
+
+	for (i = 0; i < pm8001_ha->ccb_count; i++) {
+		dma_free_coherent(&pm8001_ha->pdev->dev,
+			sizeof(struct pm8001_prd) * PM8001_MAX_DMA_SG,
+			pm8001_ha->ccb_info[i].buf_prd,
+			pm8001_ha->ccb_info[i].ccb_dma_handle);
+	}
+	kfree(pm8001_ha->ccb_info);
+	kfree(pm8001_ha->devices);
+
 	pm8001_free(pm8001_ha);
 	kfree(sha->sas_phy);
 	kfree(sha->sas_port);
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index 5cd6fe6a7d2d..74099d82e436 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -515,6 +515,7 @@ struct pm8001_hba_info {
 	u32			iomb_size; /* SPC and SPCV IOMB size */
 	struct pm8001_device	*devices;
 	struct pm8001_ccb_info	*ccb_info;
+	u32			ccb_count;
 #ifdef PM8001_USE_MSIX
 	int			number_of_intr;/*will be used in remove()*/
 	char			intr_drvname[PM8001_MAX_MSIX_VEC]
-- 
2.40.4

