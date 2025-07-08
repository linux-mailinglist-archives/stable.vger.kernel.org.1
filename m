Return-Path: <stable+bounces-160476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0A2AFC807
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 12:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A9E166275
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 10:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F0272610;
	Tue,  8 Jul 2025 10:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=innosonix.de header.i=@innosonix.de header.b="c8aOyglP"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B05522DFB8
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969560; cv=none; b=ahOtiwvvnnb1h87dxlafxxh1ZFeG8NtMsNzsogygDWX9nX9ocRViK6es+cvBSzp0IfnvlPgNK0+fztS/jMz5dbhKn7xKg0fHqrGX5QaqAy/BaiR9WD4sf1i1AzO2/+spHxKupilZv/+7aIiktIPtZTiGj/1hfZP2pa4ridkYDO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969560; c=relaxed/simple;
	bh=lIdIuh0O/t3n7LtVB2cUksJC30jNSXA/jpebYB6unRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mHTgzBd1bOpX0/8KFvEXWJNkowXPSriav/33kj5gPbwAIMu3KvM34GMO33UyIWELRvZLkXrqBPejMz2oZTgoT5Lo2oshmmNInSN1x0NbFENKtStTxUoi32RzhH7tPKeBe7fNpkYnMD1HP2kkowrfpl/np7Gy6nq9a5h/Y3uRvQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innosonix.de; spf=pass smtp.mailfrom=innosonix.de; dkim=pass (2048-bit key) header.d=innosonix.de header.i=@innosonix.de header.b=c8aOyglP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innosonix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innosonix.de
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a524caf77eso582060f8f.3
        for <stable@vger.kernel.org>; Tue, 08 Jul 2025 03:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=innosonix.de; s=google; t=1751969557; x=1752574357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gmX1zBN33lB4gzLUkNPqUBTAn0Dd9jMDbw1KtlNeu0A=;
        b=c8aOyglPhAN3DKMubS+9WQx54KbgiTKrwdmw8nHaXx52FM8pgsiVQ1UmP9WPPXInl4
         jcFdNP3pV6Sy8/MWJSBQznMMUk2WpiA6buMg5+kTgRiFyqLH4czVn1eRdS2bkCY2mTr6
         ZaGou8XAC6o/xiAWnOYIuu834v6yWbLdSyHLnT9HkgSOHRkyKnh5Dgw0qIoiOy+l1KcL
         4q/xI2oSc4D8+2WeJw80J9LN+UNTWmAV+AuQ4ZZqKBuliHIn4uheXP5N+aKaMPNHsgug
         qeoQMoQUG3Yrgkbui+H3sbcBw3KirpVZZJ4zccbXeh+PJhEI1n/1yz9qyxmxThGChJN+
         d2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751969557; x=1752574357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gmX1zBN33lB4gzLUkNPqUBTAn0Dd9jMDbw1KtlNeu0A=;
        b=AmhZc8a+Ov/sbfjYUOAFKVjtabcIO3JvlaWh/Rb8YdZGY5xlazmTy5xefK+EMDI6lN
         j1lbhm2C+rw76h42jNkvJaOZDZeVFJcKrdVHQs2yB8fUab2x349orhCxlMFZy1xH+fY/
         eYJQu1iDGLrcwcns5J1uy4KvQOduPlqMN6HX/s4f+hT25dLAA5Fpv1nc4rg27AW5UeY+
         P+i5PbHpA6Olrz2ZO9SVqcpIlVWpadhuvjBZvYgt44wMMk6soziinJ8OWvszpIMpBU8Q
         51/FvL31H3T4xViUCQ4uV1x8Nb/yIxfbMP3+6X++eOIjWFNCI8oxVXMMGUWN29Og8ONL
         5JGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw8Qf+Epczgpm/BBeBTe5rstcyBE9nELPXub29G13rc0EIDRN8r7lMBCAnuAgmQ9WeeIlg08Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSf5uTA178tNWJewzoqvO7Uzf5r8A8l8DezjLhJzhQY5YgUBbI
	QHfDne1mUq5F/7iVgFwSmyzagU0IWH4QVh4QVhAvOeTehjRoM3Cfby8ilheLE3uC5NY5aak0R5b
	UhiEaI7IrDzh56vQSWPS9NTiVEUNggrP/CiN9zj4K5mMnP9n7EDM=
X-Gm-Gg: ASbGncvHGQ/buU/kPdo3BqjrGGivLe03yLjijsmC4p0xrsoAnvTF+wWKajr9Ty3kKDa
	pzU8kUIrF75PHmZaTcXqys0xBE/4Ab4k/VUvDEOUseB+XWi3upk4Hkpih1HhJ5keHupj0/a3CzO
	rTvPQrtmAId7rArawESvbNBKCxHn9/D1clNB+BHpOLcwT2zmXGHdOnXM3OKPKsibYdUeZKGfl3A
	MICqqzr5MlBG3gE48VNMnObNAAkuxIviGViGVk8HLjiiuKxNc8rucCiVn6FZnOsUA2bqXSroVjU
	PHidWZMKhoq5tIEQp8RBue73jjeraBlW9UodD+GQjfHF3rzq0JOYdzFQVkRRMbkPKLjeUIa9Adl
	joNuWFPHuoUaCicEG66BFkg==
X-Google-Smtp-Source: AGHT+IED26y+n9j+5pBqdocpELjkLG6eOq39ZrvJ+qRhatVN4TQ5wRzgtBzDH16tDXGPwRZX5wMJRA==
X-Received: by 2002:a05:6000:310a:b0:3a6:d30e:6fd3 with SMTP id ffacd0b85a97d-3b4965ffca6mr4118923f8f.10.1751969556510;
        Tue, 08 Jul 2025 03:12:36 -0700 (PDT)
Received: from steffen-linux.. (p57b79c3d.dip0.t-ipconnect.de. [87.183.156.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47225a2e8sm12558121f8f.75.2025.07.08.03.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 03:12:35 -0700 (PDT)
From: =?UTF-8?q?Steffen=20B=C3=A4tz?= <steffen@innosonix.de>
To: 
Cc: =?UTF-8?q?Steffen=20B=C3=A4tz?= <steffen@innosonix.de>,
	stable@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] nvmem: imx-ocotp: fix MAC address byte length
Date: Tue,  8 Jul 2025 12:12:00 +0200
Message-ID: <20250708101206.70793-1-steffen@innosonix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The commit "13bcd440f2ff nvmem: core: verify cell's raw_len" caused an
extension of the "mac-address" cell from 6 to 8 bytes due to word_size
of 4 bytes. This led to a required byte swap of the full buffer length,
which caused truncation of the mac-address when read.

Previously, the mac-address was incorrectly truncated from=20
70:B3:D5:14:E9:0E to 00:00:70:B3:D5:14.

Fix the issue by swapping only the first 6 bytes to correctly pass the
mac-address to the upper layers.

Fixes: 13bcd440f2ff ("nvmem: core: verify cell's raw_len")
Cc: stable@vger.kernel.org
Signed-off-by: Steffen B=C3=A4tz <steffen@innosonix.de>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
v4:
- Adopted the commit message wording recommended by=20
Frank.li@nxp.com to improve clarity.
- Simplified byte count determination by using min() instead of an=20
explicit conditional statement.
- Kept the Tested-by tag from the previous patch as the change=20
remains trivial but tested.
v3:
- replace magic number 6 with ETH_ALEN
- Fix misleading indentation and properly group 'mac-address' statements
v2:
- Add Cc: stable@vger.kernel.org as requested by Greg KH's patch bot
 drivers/nvmem/imx-ocotp-ele.c | 5 ++++-
 drivers/nvmem/imx-ocotp.c     | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
index ca6dd71d8a2e..7807ec0e2d18 100644
--- a/drivers/nvmem/imx-ocotp-ele.c
+++ b/drivers/nvmem/imx-ocotp-ele.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/if_ether.h>	/* ETH_ALEN */
=20
 enum fuse_type {
 	FUSE_FSB =3D BIT(0),
@@ -118,9 +119,11 @@ static int imx_ocotp_cell_pp(void *context, const char=
 *id, int index,
 	int i;
=20
 	/* Deal with some post processing of nvmem cell data */
-	if (id && !strcmp(id, "mac-address"))
+	if (id && !strcmp(id, "mac-address")) {
+		bytes =3D min(bytes, ETH_ALEN);
 		for (i =3D 0; i < bytes / 2; i++)
 			swap(buf[i], buf[bytes - i - 1]);
+	}
=20
 	return 0;
 }
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 79dd4fda0329..7bf7656d4f96 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/if_ether.h>	/* ETH_ALEN */
=20
 #define IMX_OCOTP_OFFSET_B0W0		0x400 /* Offset from base address of the
 					       * OTP Bank0 Word0
@@ -227,9 +228,11 @@ static int imx_ocotp_cell_pp(void *context, const char=
 *id, int index,
 	int i;
=20
 	/* Deal with some post processing of nvmem cell data */
-	if (id && !strcmp(id, "mac-address"))
+	if (id && !strcmp(id, "mac-address")) {
+		bytes =3D min(bytes, ETH_ALEN);
 		for (i =3D 0; i < bytes / 2; i++)
 			swap(buf[i], buf[bytes - i - 1]);
+	}
=20
 	return 0;
 }
--=20
2.43.0


--=20


*innosonix GmbH*
Hauptstr. 35
96482 Ahorn
central: +49 9561 7459980
www.innosonix.de <http://www.innosonix.de>

innosonix GmbH
Gesch=C3=A4ftsf=C3=BChrer:=20
Markus B=C3=A4tz, Steffen B=C3=A4tz
USt.-IdNr / VAT-Nr.: DE266020313
EORI-Nr.:=20
DE240121536680271
HRB 5192 Coburg
WEEE-Reg.-Nr. DE88021242

