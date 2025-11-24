Return-Path: <stable+bounces-196749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5CEC80F84
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 15:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BE8FA344CBB
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EED30EF92;
	Mon, 24 Nov 2025 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZRIFOMT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1093064B8
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763994052; cv=none; b=Un8Z8z2azWWkGVj7fDOYaC/rroU3o/U8KBv1aCFZFzqUeKCab5HOydMVfGoytlGH8yxV0VyydjVFMRnCL7uJyiFvi9OR8z2KqxJvghxE5ssKA4Q4zs7OLkTs/LMHzoFIpJQuXPMAiGvtW9usn6qd9WNH6TNveAAJUOKJwpNkCUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763994052; c=relaxed/simple;
	bh=P+9FhADf8s7MH3SOEQ+F8e6dBQaXJaNU6K1PdzBNyuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rbLLw0ic8asB0VwZleOyEiRXYr/P7mhUdk0sX7bPdEA+3NUxWEX12EAW/A4/z3MuGCRA64o8iqExDIQftsH9ZxnRpqJVB6yVSksufELq6LbsYlvRiokKgEAJjurfgZZOdtHIzH7Qj4i0DjQK3uo8j2vdGtbM0gQIRXZBXp2C+Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nZRIFOMT; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7aad4823079so3725307b3a.0
        for <stable@vger.kernel.org>; Mon, 24 Nov 2025 06:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763994050; x=1764598850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JtEIxqFt5ongtgO9jgnonwhyV1MXPDFiUsBTRRrXqIk=;
        b=nZRIFOMTPQ/XlTjLo0u+jmnqdgCgsTeHss8wXAfrIKwprazwgKscnByKbzlruDzWVr
         bFBsLqsRvRCOzcG08iIeyFmxgtVaK/BFtJz3iv+9KEtzbFEMcMxXvVFysNbMfUwYfa3t
         aSASg+l65kkaAaVNswUhm9Up9X6HmCZ4epTQrT2ct7Ic0OmnZZexdh7Y/C5l3/UHOwqz
         B7a7HWmfmTTVqOiFE5FN7rzWmuGzlREXA5f48+farPCYYc4IqoDzjpY3v3CNJemW1BoN
         BeHecHeWl40rIkdjaW7e/1P3Qk4BLbBLV2esMa7NDQw5X3a3BrTWY8ay8tRxDkFENP8w
         VU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763994050; x=1764598850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JtEIxqFt5ongtgO9jgnonwhyV1MXPDFiUsBTRRrXqIk=;
        b=pXerZHoB4vpU/rYigejJTaaEEQ0s+XyqA0s1VoLcNRoMGr3VEZMb3oZ6FchygCeTuE
         ZtrbGY8hvrixsSu95+5RyLgCzkEuNduovlaenSuUCBkeO+4ElUqIKooPzH07/LAFiRNc
         RAWfaAnB62sNVkmplxhoEMHKuNWSkR9oN9Q18v3UUivaWca7vsb6+OZeBOXBo6LO5YIx
         NFZOTPGSVjMDf2SGODkqWUIe5qJIFQtRGG6IKwbFOutVWeXFR2MFu1vX4uKknGl9RDH4
         s4svgyvkksR+rg6LPpRYUyafI0hlnx6NmbMcxIHSHwGgntky1llYHqfYsQmDj/+S0Lxa
         hkvA==
X-Forwarded-Encrypted: i=1; AJvYcCXXI89eTUdPCRYgfC5SWeF0N/DQ+JtGgy7MUfaeAXkMtFTOOoJYx36weXujc2IijCzT4mak9Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPo/dli1QTX1ZCZejJ+gBGcY9Fp8WDrmTsoJs3Sq2dqIzAq7Jq
	dANA3OLOT0xG1Lh5u9oi55cd94T0e5KbE7joRRnVEDjiabjC02QsmG6A
X-Gm-Gg: ASbGncu3jPEp/JPuWCYuWs10vM0VfcJtgVZap6NLvwPOFoNyC/ugz7/fXVTw/IcsLY2
	IIf5mYOy6Mlw0Pgbe1g4DnGeO4FEYSPa/NWRUBcDGii87EtT2Xl55KgMzSpoAXZRut0Bnn/takq
	ii6TVZtYtYWYAd/Jl6on3PIpfV/vjXKh11HgGOrc5fSYkwCq4cGmJ13EnBLvAkqFfY7X8XrZflc
	lCsEN2kd5FZlyye87tI/0DJlrWTOPA3hU2WriaZBN7igJ4dIY9HzfALh9fRNMu6LYGNrkWX+8ty
	XfXemnHv6FpqiFfBSze9nm/3ihKasUrGlKRo/X+8jc92uFVAvkyb7oP9e6b9PECC/yqBmJLKbEq
	seJzhbAMrnKY5coWJIN8My0dOJ8psuwlqTxvevCOPVY7B2WQkaSYkNhHALdfEk/EEPzHa3Kglyn
	Nw0Q==
X-Google-Smtp-Source: AGHT+IEd80b9KHBlizAkoV7O6dqpDGYe9T7PBqWTaUJkMAkhRKB/WBdPJczUkKhbO4okXnPj9GexWQ==
X-Received: by 2002:a05:6a20:3d07:b0:35d:a9b2:63f2 with SMTP id adf61e73a8af0-36150bb0435mr11876497637.0.1763994049808;
        Mon, 24 Nov 2025 06:20:49 -0800 (PST)
Received: from lgs.. ([36.255.193.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd7604de68bsm13640640a12.21.2025.11.24.06.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 06:20:49 -0800 (PST)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: HighPoint Linux Team <linux@highpoint-tech.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] [SCSI] hptiop: Add inbound queue offset bounds check in iop_get_config_itl
Date: Mon, 24 Nov 2025 22:20:36 +0800
Message-ID: <20251124142036.41231-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The function iop_get_config_itl() reads a 32‑bit offset (req32) from the
inbound queue register (hba->u.itl.iop->inbound_queue) and then uses it
without validation to compute:
    req = (base + req32)
followed by memcpy_fromio(config, req, sizeof(*config)).

Without verifying that req32 is within the valid I/O region and that
req32 + sizeof(*config) does not overflow the mapped I/O region, a
malicious or faulty device/firmware could cause the driver to read memory
outside the intended request structure — leading to an out‑of‑bounds I/O read.

According to kernel documentation:
  "The value returned from the inbound queue port is an offset relative
  to the IOP BAR0." ([docs.kernel.org](https://docs.kernel.org/scsi/hptiop.html))
However, the documentation does *not* specify a maximum offset, nor a bound
such as “offset + size ≤ IOP memory region size”.

In the driver code, hptiop_map_pci_bar_itl() does:
    hba->u.itl.iop = hptiop_map_pci_bar(hba, 0);
and uses pci_resource_len(hba->pcidev, 0) to obtain the mapped region size
for BAR0. Therefore we can use that size at runtime to bound req32 safely.

To implement the fix in iop_get_config_itl():
  - Retrieve the BAR0 region size via:
        struct pci_dev *pcidev = hba->pcidev;
        u32 length = pci_resource_len(pcidev, 0);
  - Then check:
        if (req32 == IOPMU_QUEUE_EMPTY || req32 + sizeof(*config) > length)
            return -EINVAL;
  - This ensures we do not rely on a hard‑coded maximum, but use the actual
    mapped region size for the bound.

Fixes: ede1e6f8b4324 ("[SCSI] hptiop: HighPoint RocketRAID 3xxx controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/scsi/hptiop.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/hptiop.c b/drivers/scsi/hptiop.c
index f18b770626e6..c01370893a81 100644
--- a/drivers/scsi/hptiop.c
+++ b/drivers/scsi/hptiop.c
@@ -404,7 +404,10 @@ static int iop_get_config_itl(struct hptiop_hba *hba,
 	struct hpt_iop_request_get_config __iomem *req;
 
 	req32 = readl(&hba->u.itl.iop->inbound_queue);
-	if (req32 == IOPMU_QUEUE_EMPTY)
+
+	struct pci_dev *pcidev = hba->pcidev;
+	u32 length = pci_resource_len(pcidev, 0);
+	if (req32 == IOPMU_QUEUE_EMPTY || req32 + sizeof(*config) > length)
 		return -1;
 
 	req = (struct hpt_iop_request_get_config __iomem *)
-- 
2.43.0


