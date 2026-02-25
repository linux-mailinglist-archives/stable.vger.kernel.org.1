Return-Path: <stable+bounces-219618-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CI95OvP4nmm+YAQAu9opvQ
	(envelope-from <stable+bounces-219618-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:28:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F5A198119
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AD8130312F4
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF3F3B8D5C;
	Wed, 25 Feb 2026 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZRRRZp2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC5E3B8D40
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 13:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026095; cv=none; b=cZEH/oFdX84p5Ud0UZf/FKHiGkgaCWT7KliPfBPv0+avmLzvH7K9KF6UoLQDSpAZo316kYnjPzg9WdaCsgcK+TuDi70COYYN8ry7ghG8i9G0/t0sbfjKM+tOYr3QmfLWUCZDnB5kWxEQsHyJI1v5HB47faKvOEUSx+MqacQHuzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026095; c=relaxed/simple;
	bh=xRRjy3veOaCbWL+KPQCuz6nqQMwyYwm747YQfaGDlEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fFbyYkah6lDbAyATVdOdzdhGNnt41GqrRXpCTIdg1g/Z1Zr+bpikn95noCTN4V1ELb55fMZLUgSczKVuwF1WMJ2WUOdLpTlKARkZuMhPQlhmyBdn8f+bAE9YCgiqesbrVN7c+mzyQPv6fgkmJSv6yA5+a32t4T8mKsNo39Oii/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZRRRZp2; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ad21f437eeso6934645ad.0
        for <stable@vger.kernel.org>; Wed, 25 Feb 2026 05:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772026094; x=1772630894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X4gY9ENXOOQCpnDpsjGMdFNmPdFyocZAizDByCQ4qGg=;
        b=OZRRRZp2gFfzT7yi/jgdGgT4gJXmqsHJfdzQ/QqCXhvup5f/XYROVpVWfZWUfSJFPh
         3f1I3ZFIt1aW7GY+eaWIw2tUUe3CG1+OJIMA+Iewp5NuaIBf69cES+fNv7CnNIpy1jYl
         EpYRXW1XIP1PRTUpi2YCSa3kaxyAuyL40OaNld8kY4ao2oe1KG3maDQbVrw85eDcVZCk
         uQTTG5vjXBq0vLCHxslz6vi5oLQqp4Rya7X3zrEnx52wMKbs1iKepM9UY4ad093II50Q
         I0D95KJg/eIModQZwDhgnD+LenZwrUe+35XnDzTgabaDYQgO6bfFNwP2dPHOnEEXhNMK
         8VsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026094; x=1772630894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4gY9ENXOOQCpnDpsjGMdFNmPdFyocZAizDByCQ4qGg=;
        b=Y7dCENvltIWIJWF3f74iniTOEBQ4Eof13oJOZ5/JUDda/XsdbdN2jz2Jgrdn7Gbt3M
         q01s6GS5msH3Mez7eYwjuTSFfqp0uZBwRaMQMv1FTBtWldpAWHs3w1htI3fRDD47qa9h
         hteE6bLGoq1ZB6biD8V+fNsiyVB3p+0lIECQsBWkKWX+AqU+EJYopUkUgFHUiwepw/DR
         8EFwsIlbcYUFDEJf8eVAWRHkqSmcxjV+ZHaSmCgQF0TSqB9IiQm0/EWqbZ35hL1+zzM3
         +UuwwaaDSCYkyejph4L63J9Y8n1E4b3ICgvzh+uzm/R9HZYR1aHUiGvpXsaZA6iW8to+
         LmhA==
X-Forwarded-Encrypted: i=1; AJvYcCV7pFggq7Dl6QOCjfBqZXUz8AV7NHG7A2Hydo62O/1EtI0qHnAROIDiZNfzV6q1f9tR1k169p8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztwbsm0JorwtSMhkPu8dx2dzsywLTbyNoAAxYfiaRJhT0fPa+S
	EQbDZxlWIPGS5KH2m5VeamMKDS2K65Cm9YZ1Q6YehIALt74ZOQL4alFR
X-Gm-Gg: ATEYQzx/iYnuiIz8Zp5l8NH4X9ViPorXB3pmifRV6VGNwaqBfl0YBTU2/AigcDQWDPR
	cJn4u7AG++HhGoj0wCJ3tQ6sD4qWAyieINPFTI0c73GbWRTUKiuH4k4CYaPQEFCWz3KVwyUd+EP
	t3bHzIDRpv7iPtU+eTu5SOQq73XB9kXdtAQjtJuHR/J2pPhuaIHRBLY7XIMpTR0p7fqRC1R0p4I
	hL7zDVjrB9EC2rfd8UIVsDQbuYO0AMG0DEsyAxB0KJWhVyS1n2lTJpuiG4wHN78xUTiPvas64aO
	pa92eDI8dH9+3ojVbiK6ef4W3/VHC18IdkYVSJTDZMJ2MbcOrH7i5hZTTu0wh66amprvt5I4CdI
	7QzrYgzrJLAt7AHTFpkEXM44l249lQnBlmMzSBusbeYoeUJH7+sLCO/CcKTLUlWUndNthyh7yLH
	lM/6+xNCgkStoG5wDecPeRf3kt
X-Received: by 2002:a17:902:e5c8:b0:2a0:c92e:a378 with SMTP id d9443c01a7336-2adbdc6b962mr38059985ad.7.1772026093769;
        Wed, 25 Feb 2026 05:28:13 -0800 (PST)
Received: from lgs.. ([36.255.193.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad75052e9asm142759875ad.88.2026.02.25.05.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:28:13 -0800 (PST)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yaxing Guo <guoyaxing@bosc.ac.cn>,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] uio: uio_pci_generic_sva: fix double free of devm_kzalloc() memory
Date: Wed, 25 Feb 2026 21:27:36 +0800
Message-ID: <20260225132737.4176605-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-219618-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 66F5A198119
X-Rspamd-Action: no action

uio_pci_sva allocates struct uio_pci_sva_dev with devm_kzalloc() in probe(), but then calls kfree(udev) both on the probe() error path (label out_free) and again in remove().
Because devm_kzalloc() allocations are devres-managed and are freed automatically when the device is detached, which also happens after a failing probe() and during driver unbind, the explicit kfree() can result in a double free. If probe() fails after devm_kzalloc(), the error path kfree(udev) frees the object, and devres cleanup will free it again when the core unwinds the partially bound device. On normal driver removal, remove() explicitly frees udev, and devres will free it again when the device is detached.

Fix by removing the manual kfree() calls and dropping the now-unused label.

Fixes: 3397c3cd859a2 ("uio: Add SVA support for PCI devices via uio_pci_generic_sva.c")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/uio/uio_pci_generic_sva.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/uio/uio_pci_generic_sva.c b/drivers/uio/uio_pci_generic_sva.c
index 4a46acd994a8..152201047334 100644
--- a/drivers/uio/uio_pci_generic_sva.c
+++ b/drivers/uio/uio_pci_generic_sva.c
@@ -129,15 +129,13 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	ret = devm_uio_register_device(&pdev->dev, &udev->info);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register uio device\n");
-		goto out_free;
+		goto out_disable;
 	}
 
 	pci_set_drvdata(pdev, udev);
 
 	return 0;
 
-out_free:
-	kfree(udev);
 out_disable:
 	pci_disable_device(pdev);
 
@@ -150,7 +148,6 @@ static void remove(struct pci_dev *pdev)
 
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-	kfree(udev);
 }
 
 static ssize_t pasid_show(struct device *dev,
-- 
2.43.0


