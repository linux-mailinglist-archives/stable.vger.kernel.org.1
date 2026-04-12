Return-Path: <stable+bounces-235821-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG3FHr2f22keEQkAu9opvQ
	(envelope-from <stable+bounces-235821-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 15:35:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 142BA3E406B
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 15:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2B0F3022FA2
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 13:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D73D37C93A;
	Sun, 12 Apr 2026 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lF/2lcur"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D69237BE8C
	for <stable@vger.kernel.org>; Sun, 12 Apr 2026 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776000850; cv=none; b=QGzTEv1h+KIlvIStjfCLUAoFxHaQwZNzDpWS78vz4H9DfVIVlijJ3z1yPAS1rryhDfcnvHkgAlxvUEUbDXFDihjZuuONdzA3o4fSK0+/rPsZpKpiqqp9S04PqI2YYqAHo8lbAp+NRmb+4qF0O2IQvhSp6D1v+tsbP4uif0tfBPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776000850; c=relaxed/simple;
	bh=xbRuVz0HFLpaBJ4CfsXpXS0+01wpREeXceTWJkuRtHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VwzZhjjjEAiLOOiZ7R+B4gOpLs8WhL+LpYv5BANIbzasWJrdlYe98y3NYkBKVSKe2FoB641cMUoGMmPEIMSoSaeMpJHxiPMxUjSX0SuckpsWwei0bYP7P2Pw67p5DXqnKRrZ5uRuWY6K35oev2gKdnhBQb/wzheuddIg01Zy2+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lF/2lcur; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c76c60c7502so1329266a12.0
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 06:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776000848; x=1776605648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WMBdYVQUfN8Fv6N90jj5d+G39EYg75+iy6wVTIf08KY=;
        b=lF/2lcurA2UY54pcoIwEJxmp74JWzZAWmAmYJMlabcAGYvrsV+o41ea24aNL+Q1T2q
         0O1YASTqTIEFRyRcv92QjpS4BcbB0zuuk+CbV6ZjRsJP40hGVm60Uczt1u3ithuikKSR
         n3Dr9HkClbcjyCb8ic9cnHKK6FG2ShTqwCIgi2dFaf5Z8BdrfOB1lf9Ena9IhvjdD1M4
         RtRGp8nxTRst8UfYOulkE50tB2vgaIG81ctBB+eUCUOrWDCF6S3cBO/+lcGN1gFNR/6/
         buuP/iOZIgAwOGmmcK4h9tlXE5TQSeejZy0AE51zT5dP0jR8pSu5GMiw9nndYKQTOBOx
         IiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776000848; x=1776605648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMBdYVQUfN8Fv6N90jj5d+G39EYg75+iy6wVTIf08KY=;
        b=Ad4Qr7OdSLvLcfDI9/jGiNlYcS98ja+SvIirYRE6YykPdGxJ8LeNTu2xdcX4baOF9k
         kJO4LUFVFeN/zjizDC+fLa1G6cC5mH4FMPeQzxoaoR3kCP7MHUZ2Y3v88smrtPF9Fph/
         6cQDZVmhgr09Ij4MO0vj+MYxY1jp+xVd9qbGemrilatNrVRL8L3oFAe8oiiATPsRCNCE
         rHVX92HSTn3bdY0CaBjh/a49nZyWh2IonVfi3LSXCTlvygR6i+Qp56/EzBjWB7zX7efO
         f2OH/sh0m0RxR6C4Hmt9PdY1x5JKXCM1j9Dy7Qg+e0VFA4iInF8dp3dobN76NzJKrkF3
         RhWg==
X-Forwarded-Encrypted: i=1; AFNElJ+2CJih3V+ApIVkK7tCzysluPuonYY+5ZTeD8N1xd80cNyco+yqEZKWkOZiR95zZUszHBKFMS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWvJEhF1eEdugZkJ9evCzZgRYikiOP8n4zX/m1HXHJdTtIdQgq
	KY8oZUove4mkOZfqntN8Z0WT9R++OUTkmzKUSios+3uDAvh6ooEjg4XI
X-Gm-Gg: AeBDiet0IS//vHJb7IQwfRVmo1SE1u9FJHUlLfweQrNDMfPxa6xe3QMY9TPXKKFNqpe
	dTLc+Ihkxsu8Xa0alB2s0Ao2lXheqgbgznGIN8cPDJi/nX+3uUtDHH9E9w2t5k7kRfzCIT0NiTl
	ZQgt1ZRcHBFy7tWMD6o5KvbUMQUyM5lppdzPBSdgp9nG4Yo+L/QnncbXbK+VXNLlvDPMU25ZpxZ
	4noN6tr7IraOeMP0So7qPNHZqvq3/Q4NMorSqcOfnWmETHlft2eenViObOPuFbtmDjIqgoLKh9Q
	3TeD8taPcwwHFFjBWItLxE68HKOpN9F/LFeNaUuhgqkeogiYrPqtucyuA5Nyoty6lC1khCBtlh5
	ldf3KSaOTLFWhxWfLG5j1kxnHCgIOvoJs/WlgaXNw0RnPT2oaUeF5I4b0FuQZFBalWg+puFTrmf
	FKhe497Ss043j3eN4=
X-Received: by 2002:a17:903:22c6:b0:2b0:4fb3:c771 with SMTP id d9443c01a7336-2b2c722effamr137776865ad.6.1776000847708;
        Sun, 12 Apr 2026 06:34:07 -0700 (PDT)
Received: from lgs.. ([199.182.234.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f27048sm82475495ad.62.2026.04.12.06.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 06:34:07 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>,
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] misc: microchip: pci1xxxx: fix IRQ vector leak in gp_aux_bus_probe()
Date: Sun, 12 Apr 2026 21:33:55 +0800
Message-ID: <20260412133356.2536585-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235821-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 142BA3E406B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

gp_aux_bus_probe() allocates IRQ vectors with pci_alloc_irq_vectors()
before initializing and adding the second auxiliary device.

When pci_irq_vector(), auxiliary_device_init() or auxiliary_device_add()
for the second auxiliary device fails, the function unwinds the auxiliary
devices and ida allocations, but leaves the allocated IRQ vectors behind.

Add a dedicated error path to call pci_free_irq_vectors() after IRQ
vectors have been allocated successfully.

Fixes: 393fc2f5948f ("misc: microchip: pci1xxxx: load auxiliary bus driver for the PIO function in the multi-function endpoint of pci1xxxx device.")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
index 34c9be437432..5e1f99a35100 100644
--- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
@@ -93,14 +93,14 @@ static int gp_aux_bus_probe(struct pci_dev *pdev, const struct pci_device_id *id
 
 	retval = pci_irq_vector(pdev, 0);
 	if (retval < 0)
-		goto err_aux_dev_init_1;
+		goto err_irq_vectors;
 
 	pdev->irq = retval;
 	aux_bus->aux_device_wrapper[1]->gp_aux_data.irq_num = pdev->irq;
 
 	retval = auxiliary_device_init(&aux_bus->aux_device_wrapper[1]->aux_dev);
 	if (retval < 0)
-		goto err_aux_dev_init_1;
+		goto err_irq_vectors;
 
 	retval = auxiliary_device_add(&aux_bus->aux_device_wrapper[1]->aux_dev);
 	if (retval)
@@ -113,6 +113,9 @@ static int gp_aux_bus_probe(struct pci_dev *pdev, const struct pci_device_id *id
 
 err_aux_dev_add_1:
 	auxiliary_device_uninit(&aux_bus->aux_device_wrapper[1]->aux_dev);
+
+err_irq_vectors:
+	pci_free_irq_vectors(pdev);
 	goto err_aux_dev_add_0;
 
 err_aux_dev_init_1:
-- 
2.43.0


