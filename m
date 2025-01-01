Return-Path: <stable+bounces-106634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B379FF4F4
	for <lists+stable@lfdr.de>; Wed,  1 Jan 2025 22:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F323318824E3
	for <lists+stable@lfdr.de>; Wed,  1 Jan 2025 21:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719017DA82;
	Wed,  1 Jan 2025 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QErVk5ov"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F502114
	for <stable@vger.kernel.org>; Wed,  1 Jan 2025 21:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735766537; cv=none; b=dolfHdGMTl7B5OJyYYLpzP1aVwQIH8tsSd98tWMQSEJg5coUVaZlSG/tdTLRKjkqbptC7asw0V8WOe+gFETyhkKynnLURedra+0XhRRUk3X0O0fZIfxUn/j9huVFpDkFzFpXcZwKEbkFr7CALUz1FhsdgCmATTDapttC972ZsJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735766537; c=relaxed/simple;
	bh=q8PZy0OLwHNafJiqpV45MhAmIayf0l49heNBXmnPlOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0rBwmjXx85ZPrNaMyNxXRUhc1UvVcKGV5ckDzOzGBpmAAHRCXJwOeRiEAQUHedUDyCJj71xbzLUwcQ95C9mOvBLZ/Fe40+NTaiYM5X/7xnwAt2rl/3k633zL1ceb1Lg70/nQ51Cd0fgY7t9E6m9s3RQxyp+muJy3r/jxwbvj4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QErVk5ov; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735766533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v2qYS4NDZTf6Vnz8Q7jkBwvtUek+QEkrIScYmX1jbP0=;
	b=QErVk5ovFFyk/Y0qptuzKyIy6XDVH5a6cQSpmszblz6uHjpvuk56undQjq/9ByNgn3QOAp
	Lmcxdd9Oryt3mnPXAexgtLHJJboIDeIYSh1dkObPYPAIqMGIfaysob+Hc5n0t77qVJUspf
	UzkdbzodSkVqPX1QWxvDpR+pp6E7sNc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-CUkmq3xJPuKMiZU4na4wuQ-1; Wed, 01 Jan 2025 16:22:12 -0500
X-MC-Unique: CUkmq3xJPuKMiZU4na4wuQ-1
X-Mimecast-MFC-AGG-ID: CUkmq3xJPuKMiZU4na4wuQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385df115300so4765723f8f.2
        for <stable@vger.kernel.org>; Wed, 01 Jan 2025 13:22:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735766531; x=1736371331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2qYS4NDZTf6Vnz8Q7jkBwvtUek+QEkrIScYmX1jbP0=;
        b=vGQj288Jnn8Ot0YfCIX8L0oBnoX0m8UxID8/DEDrnvndNvKhT1IIX55iRon722M6qr
         SpG4cOy6n9tPsOSv0rSm7JA4dStj7q0m7p9C6h/YeXNFCeAT/aE1/+GwbpY+oJD4Ov3J
         o8UfQ2KSiXVxVe9+C/M2PUTrjlFo59pNbrzPnEKYySrUYJU1MJZVk8htmOcwg/VLWPSz
         PYrVv8Vozl8FSZHvRlAwxIfsBLbz8vbvsKKcaiYgi6CNcIOsZrwK/pcDxJ+56tvdpRyb
         J//+onE4FmzZpop4FVp0SumiH37zeBLmDXcQaPmLGUOPPUHTgE6vAFttLNkCZHpPGWy5
         ZLNw==
X-Forwarded-Encrypted: i=1; AJvYcCXGemz/c0jBGE7MFDXxaCGajr7fyotiQyPlK7d+U2dNEKg8TpJk+cmq+Jj+/XOTypdHsJgvotE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7GoRZIrqDTGKZwVXxbxOcmSWnSG2V48iEhWtx566ykoxKOham
	7sdYYCpkf59fXVtCl4LtxXxUHYiVQ5zryVzMQKUlWEYzTkDJD9B0CFWmhQLqkuh29wdptIoIFZU
	ZdPP8lZiNllmIpCTfMN8USnlf+tNFeFKOu8oSuumbOO1JUZg2ePsHDg==
X-Gm-Gg: ASbGncuhi89cElMpICPNCRkSBalEWCHfP4tvKXsZFQyzXBCKHxVa8hcwSENws7bxk5M
	ued0QPwLYU8f0iXEOaQWL0nnN/9KcMYiUfFwLMxFOQI+SMHWObFQR8cgh7cClNOUxm6XqNwvJRF
	//dRrFZNTyguyZ1fC12Yky3bf4WlMLa7EsGppWvrUQzsns17a41cEpjpLZcWugxISaA5DgFJazh
	xkI1fhAPfZDgKLMDy+F6rMQ9NiKrQaN7hpDVFAkb4IGBHAjE96E75uNYiSGg4BR+uEAt4zPhREh
X-Received: by 2002:adf:a341:0:b0:38a:4b8b:c57a with SMTP id ffacd0b85a97d-38a4b8bc5d9mr14053199f8f.44.1735766531561;
        Wed, 01 Jan 2025 13:22:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHT4nD1z7gy61VRAZS2kqMEi+O3r3YOUa2o6oASumVr0TX0ZHuRDLFyzmBf6vocqpniYQTA7A==
X-Received: by 2002:adf:a341:0:b0:38a:4b8b:c57a with SMTP id ffacd0b85a97d-38a4b8bc5d9mr14053188f8f.44.1735766531139;
        Wed, 01 Jan 2025 13:22:11 -0800 (PST)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c848a47sm35893449f8f.62.2025.01.01.13.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jan 2025 13:22:10 -0800 (PST)
From: Lubomir Rintel <lrintel@redhat.com>
X-Google-Original-From: Lubomir Rintel <lkundrak@v3.sk>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	Lubomir Rintel <lkundrak@v3.sk>,
	stable@vger.kernel.org
Subject: [PATCH] usb-storage: Add max sectors quirk for Nokia 208
Date: Wed,  1 Jan 2025 22:22:06 +0100
Message-ID: <20250101212206.2386207-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fixes data corruption when accessing the internal SD card in mass
storage mode.

I am actually not too sure why. I didn't figure a straightforward way to
reproduce the issue, but i seem to get garbage when issuing a lot (over 50)
of large reads (over 120 sectors) are done in a quick succession. That is,
time seems to matter here -- larger reads are fine if they are done with
some delay between them.

But I'm not great at understanding this sort of things, so I'll assume
the issue other, smarter, folks were seeing with similar phones is the
same problem and I'll just put my quirk next to theirs.

The "Software details" screen on the phone is as follows:

  V 04.06
  07-08-13
  RM-849
  (c) Nokia

TL;DR version of the device descriptor:

  idVendor           0x0421 Nokia Mobile Phones
  idProduct          0x06c2
  bcdDevice            4.06
  iManufacturer           1 Nokia
  iProduct                2 Nokia 208

The patch assumes older firmwares are broken too (I'm unable to test, but
no biggie if they aren't I guess), and I have no idea if newer firmware
exists.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Cc: <stable@vger.kernel.org>
---
 drivers/usb/storage/unusual_devs.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index e5ad23d86833..54f0b1c83317 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -255,6 +255,13 @@ UNUSUAL_DEV(  0x0421, 0x06aa, 0x1110, 0x1110,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_MAX_SECTORS_64 ),
 
+/* Added by Lubomir Rintel <lkundrak@v3.sk>, a very fine chap */
+UNUSUAL_DEV(  0x0421, 0x06c2, 0x0000, 0x0406,
+		"Nokia",
+		"Nokia 208",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_MAX_SECTORS_64 ),
+
 #ifdef NO_SDDR09
 UNUSUAL_DEV(  0x0436, 0x0005, 0x0100, 0x0100,
 		"Microtech",
-- 
2.47.1


