Return-Path: <stable+bounces-45514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73CE8CAF97
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 15:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23DDB1C21581
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 13:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBB37EEF8;
	Tue, 21 May 2024 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kayoway.com header.i=@kayoway.com header.b="KZqp588N"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8177EEED
	for <stable@vger.kernel.org>; Tue, 21 May 2024 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716299074; cv=none; b=XWrlT+/XuSeD/jS/4H0zsBR3iPrzNPZGC9o2xrBHYlW35v1vm4ea0GS6El+t6Mf/Aoy5juZXe/L1W4ZlezbNSj6h+N31n8gol0QfMPcaH81io9dQC2mQw1hHXy8U9Xn4pVQc9aPFkmkYDIcrhTuxRA7vxvrRLsgaRbVrqpYPBSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716299074; c=relaxed/simple;
	bh=ZZ7hZq4Gpo4WIoLu6dtwuUkYl2UN7NRX2iSQlP1W0iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSuXdQhrZjA0e7/I0Vz3nNAFSMOEZPh7rl96+W5LeHX6JwZOBpUUz/So3Iyzapt8h1fXZg126UbXeKhHKa13dqjqKtO8a272454BTV5JSStnftZSb6vQhUULeD8g7qvG9rXVkGZz135fFbBgH/XadWaAZTrhbuKflodeoF2APeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kayoway.com; spf=pass smtp.mailfrom=kayoway.com; dkim=pass (1024-bit key) header.d=kayoway.com header.i=@kayoway.com header.b=KZqp588N; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kayoway.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kayoway.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1ee954e0aa6so1462315ad.3
        for <stable@vger.kernel.org>; Tue, 21 May 2024 06:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kayoway.com; s=google; t=1716299072; x=1716903872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g53LGidiqlLV0XFSPhCxAXaK1s2/Eo4cee72313a33w=;
        b=KZqp588NCgh5INJqvkLshSFIa8N66w6dEdxWVh0ZpC4++QHFZuKT7UL29sICvSiZMB
         ltiM9UcV6rJVcdS9yGg8fs7rD9xviwZXgwSTy7qvUOO75oBmZbVatXi2yyolcxIfpJjF
         5IDawKNI5q8aAW/s2mhaI7aBgyOUViCl55Kqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716299072; x=1716903872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g53LGidiqlLV0XFSPhCxAXaK1s2/Eo4cee72313a33w=;
        b=NpRB3kMbQfG0pTp4cw/N+406JNyJMfhcHhdr+exkgUHOL6rYa06hf+fmW1Npmxbk5A
         hwoaGhQ6sDctpdf8gwfLWURGI7KWoiVIGsBZC6j2uqwla5Qz0xcV7+DuOcc0HNPRC7bv
         42nc2atw+cG4bVQa5MOx2EfK6pQZzHT0Fp0VGI0h89vS1SfRtF31ydBupQrxuCuahm+y
         39zvlZxkv/r5mAIQbsehBxju61RfbzZqLLHhlGD2n2ElR9AMoFNRDNUk1q/7JnKE9A60
         w3pzsIAcSKadKfmsIDJ13+krOFf9nWDLeWPpjGgVunKeUiM+mPLYrPotNp8XUf0hSHca
         T2Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXLzsU/Pj7WTV/q2+PWwzJaNgLqqnhGrpl0IFpoMAOdjZK9Mfnr5lJtKzfeYSNXlcebZgRTdlXzqLA/QJjteHQcLPAxLuIr
X-Gm-Message-State: AOJu0YzV/iSp0ff5/XJJsXlKFCteyPlNjYe7giniVKLZOCcTylv/dZsv
	KyAhMrRkRYDyqtfkh9fhVDvOus5wfu4ohy+qNo4lY3V5Yuag8KNeCwMRnPtB/Iw=
X-Google-Smtp-Source: AGHT+IESMasNcm1TOGhtqsez1BvA6Zz/XknDRTVGoc/vDgT46BRLjviWAEu6jWcCyw7J3mATCmVYAQ==
X-Received: by 2002:a17:902:728c:b0:1ec:31f5:16d5 with SMTP id d9443c01a7336-1ef43f2c758mr247514905ad.33.1716299072225;
        Tue, 21 May 2024 06:44:32 -0700 (PDT)
Received: from minidesk.. (101-142-33-202f1.hyg2.eonet.ne.jp. [101.142.33.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2e064049fsm79809385ad.24.2024.05.21.06.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 06:44:32 -0700 (PDT)
From: Jason Nader <dev@kayoway.com>
To: dlemoal@kernel.org,
	cassel@kernel.org
Cc: linux-ide@vger.kernel.org,
	Jason Nader <dev@kayoway.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] ata: ahci: Do not apply Intel PCS quirk on Intel Alder Lake
Date: Tue, 21 May 2024 22:36:24 +0900
Message-ID: <20240521133624.1103100-1-dev@kayoway.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240513135302.1869084-1-dev@kayoway.com>
References: <20240513135302.1869084-1-dev@kayoway.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b8b8b4e0c052 ("ata: ahci: Add Intel Alder Lake-P AHCI controller
to low power chipsets list") added Intel Alder Lake to the ahci_pci_tbl.

Because of the way that the Intel PCS quirk was implemented, having
an explicit entry in the ahci_pci_tbl caused the Intel PCS quirk to
be applied. (The quirk was not being applied if there was no explict
entry.)

Thus, entries that were added to the ahci_pci_tbl also got the Intel
PCS quirk applied.

The quirk was cleaned up in commit 7edbb6059274 ("ahci: clean up
intel_pcs_quirk"), such that it is clear which entries that actually
applies the Intel PCS quirk.

Newer Intel AHCI controllers do not need the Intel PCS quirk,
and applying it when not needed actually breaks some platforms.

Do not apply the Intel PCS quirk for Intel Alder Lake.
This is in line with how things worked before commit b8b8b4e0c052 ("ata:
ahci: Add Intel Alder Lake-P AHCI controller to low power chipsets list"),
such that certain platforms using Intel Alder Lake will work once again.

Cc: stable@vger.kernel.org # 6.7
Fixes: b8b8b4e0c052 ("ata: ahci: Add Intel Alder Lake-P AHCI controller to low power chipsets list")
Signed-off-by: Jason Nader <dev@kayoway.com>
---
 drivers/ata/ahci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 6548f10e61d9..07d66d2c5f0d 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -429,7 +429,6 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_pcs_quirk }, /* Comet Lake PCH RAID */
 	/* Elkhart Lake IDs 0x4b60 & 0x4b62 https://sata-io.org/product/8803 not tested yet */
 	{ PCI_VDEVICE(INTEL, 0x4b63), board_ahci_pcs_quirk }, /* Elkhart Lake AHCI */
-	{ PCI_VDEVICE(INTEL, 0x7ae2), board_ahci_pcs_quirk }, /* Alder Lake-P AHCI */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
-- 
2.45.1


