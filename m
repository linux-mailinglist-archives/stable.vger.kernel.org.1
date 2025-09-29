Return-Path: <stable+bounces-181856-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 493D1BA7E38
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 05:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1421891BEE
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 03:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ACC21257F;
	Mon, 29 Sep 2025 03:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SM7X5uKa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88131F099C
	for <stable@vger.kernel.org>; Mon, 29 Sep 2025 03:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759118267; cv=none; b=YnIo3HIFiQfSZN5AgVkm4u+Kka5CBVRnjn5opxyzh/Mq/L36o2dIScpbwQZbG53j7I7V2AKIIwLHxgTHiwdKB5CLfluVwlOeNh3XnVTfSO5TFxC2YhDFuh5g4Pc78pskLkL55ia6qfbE24VTwpqLpk0/6FHLCQqwOTo1yl4ehqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759118267; c=relaxed/simple;
	bh=K/Pl+tK/9RVYKl9QiM9HvOaE/bG7qwSALUnnOc1sFdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ozDVq4h9TV5JH8M3FuwkpCNQisHdSsT0oqNc/Yi5K5Nz2tmvKrutlu5sp7Ru6vOlH6uJD9DgQob9njpzjQc3AuXX8s+u2CxbeFiv7Q0+hor14ZKEf+nFXUhAzqRcx9M+4fKsx6xQVjQp52uhnyDDqQ5r7sIib4R+wh8zYWOckOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SM7X5uKa; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7835321bc98so1009985b3a.2
        for <stable@vger.kernel.org>; Sun, 28 Sep 2025 20:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759118265; x=1759723065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KY+9zguX6lGoEncTOl0DSp96NMy0r2UmgtlvC+CDQgA=;
        b=SM7X5uKajH/xNewyl6CANYhopE91owVb92MnnJjf59b1NBC3heC/W2X4A1vaN6efrc
         +hYICPaq48k6Szs3i9pr9sxoFgohKMt42e2nbSC0sz6WAdibqjOShdMbgtU2VlQHcjhd
         1xUGe7sD1ao+HwO32GEqstm+uey0oUvjalCpbDh7njLtX3M4iE81ZCOcnBOgrOqBj9FP
         KBXXe39FS3N6XZ+zD40EyENKXeRAx+6xJeZ86itGaIyKfylLl92x3qt6/GL7c0/ePovw
         7rWVOA+YXqQFvzXXV7uUa860OWrkbmrbQLjY/IxKHkVx0jDDC73/wdBYcIAMTu0O0Qyr
         90vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759118265; x=1759723065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KY+9zguX6lGoEncTOl0DSp96NMy0r2UmgtlvC+CDQgA=;
        b=E6+11N++qOwqgcLTV4MNGVQxihNiJYzl5g6m3YvjEOxFQChTEfo5ZBpTDg+gqRuU8m
         WcUXQi49EDHbFQBLpOKy14KGn3vQ0hImbU1yOZ6AmlasHq+teplDxgrO/bKaTgrfj5WL
         kEPWELNLnapKL134dW5m5aDlsL6nNDiXbeARjPpnOoOGLd44tP4nYJNgUKRr9JYGNnKo
         +nCGwPkNVT6Q678+wsew6fySlrlHUTRO6d+IoAysSZpVP9gzo0K5BKcrsGpnqc16MNK8
         M/iCuI1/ajx7RwWEepB7YsCI5WixONlt+6obWlzw3WQLdEUpNASquitUVg8fgnsCTv0P
         iEJw==
X-Gm-Message-State: AOJu0YzASb0lb+RkDOF2UoTz+CNDp2wan/cSyGfIJUHxQkyUBdXLV+GF
	5QexXKSQwXRPUxVD/JiiqXSQHOpFvx6CrtaoEm1DiOePYX0Ue84MAypI
X-Gm-Gg: ASbGncshFc9TZTDP5q1RaXYmhe4tVr/FRGOq2ijIGUgBKUBzTJgteGT8+ZaZXGhro6B
	2XxnRm3rG4xws373o4WRiAiwsjpY3r8BeUYzyqe+vZXBGYZwyVsH+nXVVdNcE817Kz20CpZDjKQ
	SH64htAFaL8l98qLhAkSXpDKXygpFwA/8NQveMqkIc4Af1DmMJgpXgNwdx6+9sjdQ+D9q6Rea73
	RKLoALaIovUgw0hhxXXv28nB3zwN8vAODlqMqE6yy44NOaKf1B8v50Lz5mPfLuf5LvOxo0fyHJm
	gXzBNMMuZULKYKr7SsaDEZf0dWvrjC9ledxmnf1s9E5LIwQcZLG5cr/k7J5WV4/t3ZkcUPdBHgy
	qBjZOyzFQ7CHpdj0BIO9LyqDbbG22URlkmYHKqNQ+1PbWlAnOvE1AfQ6MV+eLCxk=
X-Google-Smtp-Source: AGHT+IH8M2m2wIqYUOH48Y+569jmRLFCO3ShVnF+4fArYJKjS6gSHepva1IF8wVu3hr/zYrbnPy0cQ==
X-Received: by 2002:a05:6a20:958e:b0:311:99:7524 with SMTP id adf61e73a8af0-31100997c20mr1722119637.18.1759118264865;
        Sun, 28 Sep 2025 20:57:44 -0700 (PDT)
Received: from BM5220 (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-27ed66d43b8sm116411945ad.9.2025.09.28.20.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 20:57:44 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Cc: stable@vger.kernel.org,
	zenmchen@gmail.com
Subject: [PATCH rtw-next] wifi: rtl8xxxu: Add USB ID 2001:3328 for D-Link AN3U rev. A1
Date: Mon, 29 Sep 2025 11:57:18 +0800
Message-ID: <20250929035719.6172-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add USB ID 2001:3328 for D-Link AN3U rev. A1 which is a RTL8192FU-based
Wi-Fi adapter.

Compile tested only.

Cc: stable@vger.kernel.org # 6.6.x
Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
Link to the Windows driver for D-Link AN3U rev. A1

https://www.dlinktw.com.tw/techsupport/ProductInfo.aspx?m=AN3U
---
 drivers/net/wireless/realtek/rtl8xxxu/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index 3ded59527..be39463bd 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -8136,6 +8136,9 @@ static const struct usb_device_id dev_table[] = {
 /* TP-Link TL-WN823N V2 */
 {USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0135, 0xff, 0xff, 0xff),
 	.driver_info = (unsigned long)&rtl8192fu_fops},
+/* D-Link AN3U rev. A1 */
+{USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3328, 0xff, 0xff, 0xff),
+	.driver_info = (unsigned long)&rtl8192fu_fops},
 #ifdef CONFIG_RTL8XXXU_UNTESTED
 /* Still supported by rtlwifi */
 {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x8176, 0xff, 0xff, 0xff),
-- 
2.51.0


