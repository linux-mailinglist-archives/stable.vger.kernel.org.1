Return-Path: <stable+bounces-39585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AC08A536E
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 801401F207C2
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F4A7EEFF;
	Mon, 15 Apr 2024 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDMGhHjD"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f68.google.com (mail-oa1-f68.google.com [209.85.160.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7867E576;
	Mon, 15 Apr 2024 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191205; cv=none; b=soe/HuLFa7JjbOvkspPZEC578S1Xfd36cYQEMK9y7/VyfcasVcOcXdlaFXfRrdWZ60qbFw70ayYg8V87uaqK6eSFuLNNv1PGSmvFOrtXzz02fpdkhwlzKAo2tG+mIbXjphv+Czvzc3lfF0m1cg2NPbFVtIzBf2R6cPkG7tfBLj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191205; c=relaxed/simple;
	bh=r3eeg0tRuPV/h8aAd6D4ldP3XRPreq4TA3tAEs4iVdU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UUoGeTi/CjoZm2kq4mIlBJAAcyn9v88t9MI6Uxlp8wmKRjkCEhI3QvRI9t3tE6Hj0jJhWef3LoQtZtLTiAC0tRWIb3H2XzBu/cqSVULXQN/WtrtfcAR17yfrXfx3680lqHl6v8p4HnnDeW9yk2p5W2uz2IOD9qA4XXLUkT3fmZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDMGhHjD; arc=none smtp.client-ip=209.85.160.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f68.google.com with SMTP id 586e51a60fabf-23335730db1so1982601fac.2;
        Mon, 15 Apr 2024 07:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713191203; x=1713796003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qHlOC6Ow5eV/sTYTAeVpjV+5HwS0SfY4RsP3nOtgDzs=;
        b=VDMGhHjDGFyWPrbAddan1MiEoJjTk6/52EMRIMIRm8YONPNnDrxKtoe5/DME9HWzG6
         8KX0O2n+8a+4ly/MaFvjRk+/jpMmiewgSae5GsN0CJsTSgJJc5CNZhXzY8u3CXWPXoFd
         7pqagucqgEnNpj1kqOhF1Xj5iq7GTNiOQPV6HwEzOoQWYmgFSyJ6fzZH1PQe/Aofz7os
         uqpETgSwQs992Xo21iZthzgrK99+vrUIzDatOmfIeBX/5ImD6cnz+ojRh6aNHt7UykpV
         mThIzZ1K40VcMEo81QDZKkgHxKhpl1mkngprx8AKrDahxdVj3f8tuLAFYba+CwoZg3JV
         j+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713191203; x=1713796003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHlOC6Ow5eV/sTYTAeVpjV+5HwS0SfY4RsP3nOtgDzs=;
        b=mMA35IUVPFoSRa5EjWrmLf8drV8h3Xl7oFkpK/XwOstvVayGAh5lnHpSNgxf+/cE4U
         gZkLNpMOr1Cxk9JxV0nqi1FWdLS/kchsniqjM0yZy7e0KDV3e77+8UyF7QU6VrMEViGI
         SZ0o8klQrge255xgTMViGyqKjEUzlNLW+srvocy4KKNbkuzITFSzy3XitYxOPk+rkc6L
         2Qqdh9CY7lQzWw5H+oJhs7uiq4azRzpwK7kD5uzb4JIxY+hxEPv3tZD8G74dDk9Mu0N/
         6XtVE+VG2pGwwnIhryQx/R2Yvcy+bcmmSBOAvckTtroMpbqcNZCthF9IB3z14y5cYXH0
         J4bA==
X-Forwarded-Encrypted: i=1; AJvYcCWdFfqvHyJq+ZQRAZ8qZ7ojwqXBeXCA3Lgb7/jEVeO8CQ+7a1xdKNzZG2SPD68ZmReMK8Oqz4P4Y0WdOSXxOabSv4Jsac7F4VToi+fh6XG7n73xaIekf9CexHvJRoXVuxG/
X-Gm-Message-State: AOJu0Yxjn7pwPg+91bBYDPmIEIwK4LEkUy4RbQDqozcqjgYTHR0JUajJ
	/nK7IHjTEWYPZkP3UyNdhu1kHKr4G0vAxTTYFGtXgM6O7ovvVFFprS/o/R+KjEjP6g==
X-Google-Smtp-Source: AGHT+IHw33scVYOySwVtnSvcdDIXpD6BlOFtpnrf0VXfn1mQpOqnS7Zrq9lXN02SmCfO9dAZnkEkwA==
X-Received: by 2002:a05:6870:d606:b0:22e:ce2e:4506 with SMTP id a6-20020a056870d60600b0022ece2e4506mr11880218oaq.37.1713191202668;
        Mon, 15 Apr 2024 07:26:42 -0700 (PDT)
Received: from localhost.localdomain ([2604:abc0:1234:22::2])
        by smtp.gmail.com with ESMTPSA id we2-20020a056871a60200b0022e0804def3sm2271091oab.22.2024.04.15.07.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 07:26:42 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: netdev@vger.kernel.org
Cc: Coia Prant <coiaprant@gmail.com>,
	stable@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH 2/2 v3] net: usb: qmi_wwan: add Lonsung U8300/U9300 product
Date: Mon, 15 Apr 2024 07:26:38 -0700
Message-Id: <20240415142638.1756966-1-coiaprant@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the net usb qmi_wwan driver to support Longsung U8300/U9300.
Enabling DTR on this modem was necessary to ensure stable operation.

For U8300

Interface 4 is used by for QMI interface in stock firmware of U8300, the
router which uses U8300 modem. Free the interface up, to rebind it to
qmi_wwan driver.
Interface 5 is used by for ADB interface in stock firmware of U8300, the
router which uses U8300 modem. Free the interface up.
The proper configuration is:

Interface mapping is:
0: unknown (Debug), 1: AT (Modem), 2: AT, 3: PPP (NDIS / Pipe), 4: QMI, 5: ADB

T:  Bus=05 Lev=01 Prnt=03 Port=02 Cnt=01 Dev#=  4 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1c9e ProdID=9b05 Rev=03.18
S:  Manufacturer=Android
S:  Product=Android
C:  #Ifs= 6 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=option
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=89(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
I:  If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=8a(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms

For U9300

Interface 1 is used by for ADB interface in stock firmware of U9300, the
router which uses U9300 modem. Free the interface up.
Interface 4 is used by for QMI interface in stock firmware of U9300, the
router which uses U9300 modem. Free the interface up, to rebind it to
qmi_wwan driver.
The proper configuration is:

Interface mapping is:
0: ADB, 1: AT (Modem), 2: AT, 3: PPP (NDIS / Pipe), 4: QMI

Note: Interface 3 of some models of the U9300 series can send AT commands.

T:  Bus=05 Lev=01 Prnt=05 Port=04 Cnt=01 Dev#=  6 Spd=480 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=1c9e ProdID=9b3c Rev=03.18
S:  Manufacturer=Android
S:  Product=Android
C:  #Ifs= 5 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=85(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=87(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
I:  If#= 4 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=ff Driver=qmi_wwan
E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=89(I) Atr=03(Int.) MxPS=   8 Ivl=32ms

Tested successfully using Modem Manager on U9300.
Tested successfully using qmicli on U9300.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
Cc: stable@vger.kernel.org
Cc: linux-usb@vger.kernel.org
---
 drivers/net/usb/qmi_wwan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index e2e181378f41..3dd8a2e24837 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1380,6 +1380,8 @@ static const struct usb_device_id products[] = {
 	{QMI_FIXED_INTF(0x1c9e, 0x9801, 3)},	/* Telewell TW-3G HSPA+ */
 	{QMI_FIXED_INTF(0x1c9e, 0x9803, 4)},	/* Telewell TW-3G HSPA+ */
 	{QMI_FIXED_INTF(0x1c9e, 0x9b01, 3)},	/* XS Stick W100-2 from 4G Systems */
+	{QMI_QUIRK_SET_DTR(0x1c9e, 0x9b05, 4)},	/* Longsung U8300 */
+	{QMI_QUIRK_SET_DTR(0x1c9e, 0x9b3c, 4)},	/* Longsung U9300 */
 	{QMI_FIXED_INTF(0x0b3c, 0xc000, 4)},	/* Olivetti Olicard 100 */
 	{QMI_FIXED_INTF(0x0b3c, 0xc001, 4)},	/* Olivetti Olicard 120 */
 	{QMI_FIXED_INTF(0x0b3c, 0xc002, 4)},	/* Olivetti Olicard 140 */
-- 
2.39.2


