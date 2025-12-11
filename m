Return-Path: <stable+bounces-200756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB83CB4808
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 03:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F271A30014ED
	for <lists+stable@lfdr.de>; Thu, 11 Dec 2025 02:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93756296BBB;
	Thu, 11 Dec 2025 02:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWUJTTmA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A633221282
	for <stable@vger.kernel.org>; Thu, 11 Dec 2025 02:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765418497; cv=none; b=aC91nEz4uCcwxApuTNf/0fPHTOrtUBQQpqmoJ3Q9h24PMRL/43ox5nBsSuwDQ+Dz9LyLCWPKWYqdlSqEuMuh4G405k2ZvCpidXE0rp37W4nPfnRPL2I/EkR/VW87cVeUB7Xm0EZK7hdFUs0sUQmfVR7C37Nvx98ii5x9NHJ8SRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765418497; c=relaxed/simple;
	bh=jxlquEKWB4ovnxW0dPC9yXeJyMf7Zf/wpG/BjX1DAmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rFpSCRIBzvw6t053d/U8t8Adw8GOT/M/5qNmXaEZah2WK+8C4D2/+RINoUDYpygx1bNlx0V9QyNB1dZfM65sci+ulcZBJHZOuFcfrXYfZIarVAAw+U3dL/PN/qqa6i6uoJSXEy6r5BgXztg/rh53e4nc7Nyl7A8X3/hnDJsw3eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWUJTTmA; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-343806688c5so433654a91.0
        for <stable@vger.kernel.org>; Wed, 10 Dec 2025 18:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765418494; x=1766023294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oDLOUoseKDsXrqrK/vpzGFljddjHVxFQ23qh88EWC7A=;
        b=EWUJTTmAepSwW1MhkSr/1QvvhrV3KKvBa12aQBa1W0/92EPx71rACU9tFKTG5Gfcnf
         nYRAqJ5EtiWrqRYqdGOrZmoEMS9nFublNuULGUayRhoxkKnuydwrVDbWoLQuRa5I3THa
         ArRSDmwBoiqvpvU7SRDiGxbeGskPIK2o36+zgI178PlkNwB6o3+e4tS782FIfkyS4+Bn
         lUTFc1fcRSkEQcZqRDDYe8ix4EQpr1KnrsYnkyEDHxXeSeLW9SpLfbucptzDOSmI3FuB
         3zOBFJQveGexgmzjSztbW63+t5Tfn6NK3kU6to5mYyjoyfNfHJ10b4evxuDzWtLeZkT5
         e/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765418494; x=1766023294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDLOUoseKDsXrqrK/vpzGFljddjHVxFQ23qh88EWC7A=;
        b=HOYrWwCwHSyb4vXJ+IMQ0oE1bZmgxFJJrFXNkYXnCo01krTUIL7ZGRwp4rNtxBwiNP
         7CvFOl9jnJVIwKXQKoJ8JE2H8njhmZEcdWvB1O/dwEVU2vSaxC1u5AMUUi5izLjLbjdl
         7dDmGnzf+OtuNyInEY1gjZu0ossYbdlfSCZoU2Smk21sUzIoLt/eRKXcGSFhvLGNwXs5
         QeuBhhoYhxGGp520A5NySTSZCXs8E/Pk6WsnyTKUSMFFwXFxq8IFGvx8N7OW8xbOck4G
         AbQBvjS3K0dnPPCCUXhYBrFRbppLTc8muHmOdWmW2ii4VlL4NKNeZ+2VMUsI/tU7R5ku
         EVwA==
X-Forwarded-Encrypted: i=1; AJvYcCU1FqJeD6wp0hKvhzclFS4pVv/lLgtNi3+ZOtpDbO53HxsmeJIlPAtYdDBgyLQO7UsXAgQLloE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0M/4hi0HqScZ7fLDvajNbVA2DBDNfp+fuMx6mvWx2aTtG8Czs
	eyLTpKWPoaL57Jz1mrpQTif7n5Y8m2TvBd88rdtXA1BttrO3tTY88UlQ
X-Gm-Gg: ASbGncvp5lAI+tVLDouKmka7cnN/d+XCUOVU+yUL+tpm0kBOjWC2FsJdMX97AZUR06p
	iiYANaKqBXgvnsYWpztYVA0RMaJSvvh8NTeQwPyM8XEPrBR2cRP+VMRYqebV5RWR9RKSWGbpAUO
	ManSZfuzUCRsBdAh6Gbd2w9WmPBkGqJvP7dDdtRd4EVJUKN8blR1I/BwJHTW7xAnSGA4j53PC4L
	4sJyE/5TWQzHZnPWu2EEfVW24i5FF/CJg6BUSNFA70/aPno47A4b/9bwClN73kSAnomrBnX6q3z
	JiuIA3b6KNqnyPTRJnXSppLVK2rMRR+tYNSRtiZkGirO55HoyRiwW78Fwo5n5IyAUWEg/MqdSQC
	BEmsYie5+jryQtmvdlVzkVvRv3yCFGJ7+o5F3M3ijMMvETHRVyr/EEpdpnxzrjVQfCG+VWUjyfq
	9pDZ8cZKB1Q2WHL6/r1VvKMMEUc8hKaiUHYuX4KgG6pDw92Xp1Ajno2PPkg3ALRmmql+A47M4UC
	INttclRNqle6lc=
X-Google-Smtp-Source: AGHT+IGQ7/gXmCOul/U9YXhnOAApYUABB4NLMUfjzK8VZdz8cwFkkhz18hi9+oy2iOuh5RZ7UzTfnw==
X-Received: by 2002:a05:7022:78f:b0:119:e55a:9c06 with SMTP id a92af1059eb24-11f296d74cbmr3701500c88.34.1765418493417;
        Wed, 10 Dec 2025 18:01:33 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e1bb45csm3572116c88.1.2025.12.10.18.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 18:01:33 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-usb@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] USB: serial: ftdi_sio: add support for PICAXE AXE027 cable
Date: Wed, 10 Dec 2025 18:01:17 -0800
Message-ID: <20251211020117.45520-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vendor provides instructions to write "0403 bd90" to
/sys/bus/usb-serial/drivers/ftdi_sio/new_id; see:
https://picaxe.com/docs/picaxe_linux_instructions.pdf

Cc: stable@vger.kernel.org
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/usb/serial/ftdi_sio.c     | 1 +
 drivers/usb/serial/ftdi_sio_ids.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index fe2f21d85737..acb48b1c83f7 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -848,6 +848,7 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, LMI_LM3S_DEVEL_BOARD_PID, 1) },
 	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, LMI_LM3S_EVAL_BOARD_PID, 1) },
 	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, LMI_LM3S_ICDI_BOARD_PID, 1) },
+	{ USB_DEVICE(FTDI_VID, FTDI_AXE027_PID) },
 	{ USB_DEVICE_INTERFACE_NUMBER(FTDI_VID, FTDI_TURTELIZER_PID, 1) },
 	{ USB_DEVICE(RATOC_VENDOR_ID, RATOC_PRODUCT_ID_USB60F) },
 	{ USB_DEVICE(RATOC_VENDOR_ID, RATOC_PRODUCT_ID_SCU18) },
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 2539b9e2f712..6c76cfebfd0e 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -96,6 +96,8 @@
 #define LMI_LM3S_EVAL_BOARD_PID		0xbcd9
 #define LMI_LM3S_ICDI_BOARD_PID		0xbcda
 
+#define FTDI_AXE027_PID		0xBD90 /* PICAXE AXE027 USB download cable */
+
 #define FTDI_TURTELIZER_PID	0xBDC8 /* JTAG/RS-232 adapter by egnite GmbH */
 
 /* OpenDCC (www.opendcc.de) product id */
-- 
2.43.0


