Return-Path: <stable+bounces-125834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35274A6D2CE
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 02:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA6216AAE1
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 01:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A5527442;
	Mon, 24 Mar 2025 01:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk8cTPbV"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2BD2E3386;
	Mon, 24 Mar 2025 01:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742779720; cv=none; b=WRlzA32mgBG2CNxfWzJvkfsto+Cw5PJsaVG5vTq9MvFsxHIMxVpDSRyM6EVNI8EdfYVBc158Tw+03+lZcrHMHPIf8+mdhXZTzpwGmhOngHVsPTMuf98sFu+XdPX6iuUbhg2k0Zg6NWWLDV2JZ2qfISm7gt/prqfOkaadZgsMEgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742779720; c=relaxed/simple;
	bh=zl1uo13BNwoUbqVeza6eeYjMNp9ZX9eFVZuNCiIEkJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iqxi9Tz0MIGNTnRzmhjdndM2blF3iPn3/SWcEzrS8YvUriOO95fGFBoz6rVY6Eq+/QWdEmefZX0st/O5GLgQ6z0neMb3bMXSuppjM1XcsWYVYsZogTT2uYSGMiZsWHvAAx+MYOf6QF2yUJV3jgRxrgxrqDDtDetiTeSHMYWzVJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kk8cTPbV; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c0e135e953so407699885a.2;
        Sun, 23 Mar 2025 18:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742779718; x=1743384518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAX3pOyUJIm0P+4HIZbRycp3jrlF0/5qEeunqKwtosk=;
        b=Kk8cTPbVI+YByFJtOfNj90vF+8XkUmTSl/96Fa+qeCoWLVj6YU2w9vdBlzer7M0Sgm
         Amzx7JtbnzPuG9Og0SB1PaPZjxhK3pZd4CQW5xWb0yoB67XlbxnnMC/qz1A6prD8/vVL
         y42eASFDIoavIDDwMCYf9D7ykHBudLnJIICNufJq5xFlvSQf12UCQtKWHKGI2pJRGU+4
         EKgA99wadf/MaVKSzZn7izrvq3DJ3TfA/zLHrew4VP5FKZcOGMobKMCGK7qs+ST22NmW
         I549QujCcN3vQyHR1OV0JoZBfsr5zTQWU9sgXv3Uto4j0sp3a6q+Po7ypjsFr6lzbdRH
         OnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742779718; x=1743384518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAX3pOyUJIm0P+4HIZbRycp3jrlF0/5qEeunqKwtosk=;
        b=pB0rrbTPV/IV6p+IUNtrWic3pZ4AeAkFIe0Qyv1LRbT0ZsOF+0XLFMfdH4kTxoPH4x
         DuWpBL/0twlD3adFdH51I21a59ng0m/YW3io9dxXc5g4PIL71sc+zVz+LDjWIq0ivviF
         qaqmiX/OwXDV9gh2g6igvJKefqcIxoBSeLotsonV4cA4XRpDNhsV+nq7Vuv9UkZDXie2
         TFLOsJKTDS+fc6+rDmZ76LLnERR9VlJNuAIGzxengAA7nkDhPIkp1Tk2wI2rL+bva8SE
         MhenM7gVSauFp6+qyjC1J+Y5R8hvJwhmyvRDx/9WicIv0fKa8lmaEJ8hpz+S0rWsbjnj
         3SgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/VzPb36qrz8dq2bUNd5HM7qm6Sw/enelIdH6lGIDN9tJkQFZJPmcd/pZ1D51ABX2NSrJTSV5HonKELqLSmJzsHtj5kg==@vger.kernel.org, AJvYcCXQqSsmI6hGDyflp5eIWlMeK0eg+p7/UscrOa96LUHtTu0z57SO7qLxv6WM5UfStGovU8hwMngZ@vger.kernel.org, AJvYcCXrHETMKhpkrIBwcuY2tE7UAsnYs/TwXn0PJS4wwJaoFizn8kHTvO9rOdYHjVlTgwOe35V8yGEEHl2LDws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK3y8dzCcRwknPpbpl74fgPXugF1HPhs5cRPcUmphnFUJQHVKs
	NmryVBQ/foYSxzI9daREuwX/pM5FoUzCxs27+a6/RZ81+Nni2dTw
X-Gm-Gg: ASbGnctxsEdGh8hjHMLNDrYU5HvdeTdwJRTEluPxIYvJ4IgtcNw5EkSyvF6sa485/7o
	7Osl4pWTp4xqLHyt2VDqs/78qmrS8zcfGMgBk6yu0ZyXXQFKNW/NJQ2rGWcJ8QF3dpBCvDPmEj7
	KwkaWztK51QScolKc7Q4gc6ukN2xQ2TC+fjJ8146jSYAWl+zjp+WmUQiy1YOia0CDJqluD1gr2w
	SdXfR3t8QC94MIN64C8ycpig148bDURxDNZk11QWPayNwMnLjCNqfCqovgbkI1u0OnBu7XqDSSz
	39cY1vKUFxMacaY5XkDdvZaZgG2DgeT43tL1tGLC7rv8GmpU0wEw3SGyUb1Kgk2rVweu/pV3uN7
	vKHePbfNMACr8wnBH
X-Google-Smtp-Source: AGHT+IGwG5eh3S+TrFNbHnxQrv5/7+azus75LhM16CP2UKvOVeh8+DlJYDdvd+W55eF7BLAjJ3mgZQ==
X-Received: by 2002:a05:620a:4496:b0:7c5:a536:91e5 with SMTP id af79cd13be357-7c5ba166b0cmr1613207185a.20.1742779718011;
        Sun, 23 Mar 2025 18:28:38 -0700 (PDT)
Received: from localhost.localdomain (pat-199-212-65-32.resnet.yorku.ca. [199.212.65.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b92ec648sm431841685a.61.2025.03.23.18.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 18:28:37 -0700 (PDT)
From: Seyediman Seyedarab <imandevel@gmail.com>
X-Google-Original-From: Seyediman Seyedarab <ImanDevel@gmail.com>
To: hmh@hmh.eng.br,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Seyediman Seyedarab <ImanDevel@gmail.com>,
	stable@vger.kernel.org,
	Vlastimil Holer <vlastimil.holer@gmail.com>,
	crok <crok.bic@gmail.com>,
	Alireza Elikahi <scr0lll0ck1s4b0v3h0m3k3y@gmail.com>,
	Eduard Christian Dumitrescu <eduard.c.dumitrescu@gmail.com>
Subject: [PATCH v2] platform/x86: thinkpad_acpi: disable ACPI fan access for T495* and E560
Date: Sun, 23 Mar 2025 21:29:11 -0400
Message-ID: <20250324012911.68343-1-ImanDevel@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Christian Dumitrescu <eduard.c.dumitrescu@gmail.com>

The bug was introduced in commit 57d0557dfa49 ("platform/x86:
thinkpad_acpi: Add Thinkpad Edge E531 fan support") which adds a new
fan control method via the FANG and FANW ACPI methods.

T945, T495s, and E560 laptops have the FANG+FANW ACPI methods (therefore
fang_handle and fanw_handle are not NULL) but they do not actually work,
which results in the dreaded "No such device or address" error. Fan access
and control is restored after forcing the legacy non-ACPI fan control
method by setting both fang_handle and fanw_handle to NULL.

The DSDT table code for the FANG+FANW methods doesn't seem to do anything
special regarding the fan being secondary.

This patch adds a quirk for T495, T495s, and E560 to make them avoid the
FANG/FANW methods.

Cc: stable@vger.kernel.org
Fixes: 57d0557dfa49 ("platform/x86: thinkpad_acpi: Add Thinkpad Edge E531 fan support")
Reported-by: Vlastimil Holer <vlastimil.holer@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219643
Tested-by: crok <crok.bic@gmail.com>
Tested-by: Alireza Elikahi <scr0lll0ck1s4b0v3h0m3k3y@gmail.com>
Signed-off-by: Eduard Christian Dumitrescu <eduard.c.dumitrescu@gmail.com>
Co-developed-by: Seyediman Seyedarab <ImanDevel@gmail.com>
Signed-off-by: Seyediman Seyedarab <ImanDevel@gmail.com>
---
Changes in v2:
- Added the From: tag for the original author
- Replaced the Co-authored-by tag with Co-developed-by
- Cc'd stable@vger.kernel.org
- Removed the extra space inside the comment
- Dropped nullification of sfan/gfan_handle, as it's unrelated to
  the current fix

Kindest Regards,
Seyediman

 drivers/platform/x86/thinkpad_acpi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index d8df1405edfa..27fd67a2f2d1 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -8793,6 +8793,7 @@ static const struct attribute_group fan_driver_attr_group = {
 #define TPACPI_FAN_NS		0x0010		/* For EC with non-Standard register addresses */
 #define TPACPI_FAN_DECRPM	0x0020		/* For ECFW's with RPM in register as decimal */
 #define TPACPI_FAN_TPR		0x0040		/* Fan speed is in Ticks Per Revolution */
+#define TPACPI_FAN_NOACPI	0x0080		/* Don't use ACPI methods even if detected */
 
 static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_QEC_IBM('1', 'Y', TPACPI_FAN_Q1),
@@ -8823,6 +8824,9 @@ static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
 	TPACPI_Q_LNV3('N', '1', 'O', TPACPI_FAN_NOFAN),	/* X1 Tablet (2nd gen) */
 	TPACPI_Q_LNV3('R', '0', 'Q', TPACPI_FAN_DECRPM),/* L480 */
 	TPACPI_Q_LNV('8', 'F', TPACPI_FAN_TPR),		/* ThinkPad x120e */
+	TPACPI_Q_LNV3('R', '0', '0', TPACPI_FAN_NOACPI),/* E560 */
+	TPACPI_Q_LNV3('R', '1', '2', TPACPI_FAN_NOACPI),/* T495 */
+	TPACPI_Q_LNV3('R', '1', '3', TPACPI_FAN_NOACPI),/* T495s */
 };
 
 static int __init fan_init(struct ibm_init_struct *iibm)
@@ -8874,6 +8878,13 @@ static int __init fan_init(struct ibm_init_struct *iibm)
 		tp_features.fan_ctrl_status_undef = 1;
 	}
 
+	if (quirks & TPACPI_FAN_NOACPI) {
+		/* E560, T495, T495s */
+		pr_info("Ignoring buggy ACPI fan access method\n");
+		fang_handle = NULL;
+		fanw_handle = NULL;
+	}
+
 	if (gfan_handle) {
 		/* 570, 600e/x, 770e, 770x */
 		fan_status_access_mode = TPACPI_FAN_RD_ACPI_GFAN;
-- 
2.48.1


