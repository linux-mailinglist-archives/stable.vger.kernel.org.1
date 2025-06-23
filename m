Return-Path: <stable+bounces-156149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FCFAE4BA1
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 19:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D7A53A332E
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 17:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9933025BF13;
	Mon, 23 Jun 2025 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=innosonix.de header.i=@innosonix.de header.b="XlbTvCNW"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E6218B0F
	for <stable@vger.kernel.org>; Mon, 23 Jun 2025 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750698787; cv=none; b=Ho4mhdA50cgQVKI6G8fJHoFfqGJE+FjGjwd+YmVHwSYNTNugG6zDw6Ztwo9WC0k7gUB8bUpXrwZU8lSAiPNDh/l1ClHtkvuRNcuCFB51SKtzh1BIzP1v/UPdI2n9PJQBQiHC/L1zkyJUddv32kvV2npMmq+xqU5CJMhb5nx3A9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750698787; c=relaxed/simple;
	bh=wv9r1Nau37bZDlcKTni8vX3dpCtckh8QUn8ksWrvjzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kJkS8QvsDk7ckjsEBOBttbt0z/jrZXaJHFJWss60HN5AAI4jMIMoO/rxPfwiKdWH7V3JKRzIeaFAXsij2F6We77pWmjLBAMEZfNuHortKzr4DOwgvruLTKYyK05C63RwKh5J6TbeOaHB2BCIDawyIjT2DEELrn/HY2m9kQWNyJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innosonix.de; spf=pass smtp.mailfrom=innosonix.de; dkim=pass (2048-bit key) header.d=innosonix.de header.i=@innosonix.de header.b=XlbTvCNW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innosonix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innosonix.de
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4eb4dfd8eso630978f8f.2
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 10:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=innosonix.de; s=google; t=1750698783; x=1751303583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fFVerlv1rup6mF5IH5Ew1KKnD+3iU06ke4X3UNXN3IU=;
        b=XlbTvCNWP9sxrhEyqZdkwkzBAJ5IfMr2HDAC6vLqUiJhCOq6/ggza35dZU8AadHb1M
         O25xSG6UoxE8uHXQhQgPje7q3AyKGrM/F8gZeR3fHIciwXctD7d1xXL3HJGSDTImaxEM
         tJ5Hu1T3mGkeAdvxeUQn3os3VaP402tNrHtBPnz8VpA5ebMlmt+aaCwXvGXrHTvFT1hq
         tQ4wT5bLImPntWE4LTAcVbRZlcGeAC6on6kPEFigEhWpgVHUwtn8CSMYqYM3wg2N1qgz
         Di/V8qzu4CJsHllODDOayJAzzccR8Zr+Cj7ulL842b8L1kmMYvJR1Af3wlitTSl1rC7g
         NoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750698783; x=1751303583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFVerlv1rup6mF5IH5Ew1KKnD+3iU06ke4X3UNXN3IU=;
        b=OMFKPCK4IXRWPmY9azz6FDccTwxVE8trZU/tXkYxYF6StzRvXFCA8vgBiwbnc7cLDJ
         PtfoTqu4nLfIKcm/VYh1NUjRT3jQCKJxExS/AUE41DPpwKT66hoyKoUZNl8htq5l+8eY
         dfvfqe/PQJIM8bcsXGIGFBWDLQZRf9tN8jQFl2PUsg/2Gz8UPAkZXtShjkq7c/FDzViT
         3Rs3PjdzyGY0DsCrDjOFNcuxS+NPxq7SbNdd+byU96B9CgpzW3RhOSM3y6yHDZBvyMlK
         OEN9KWjEo3RwKsP90lO+Da9dA7FHm70/B9KpekuUgjAyYy97XW9YFkcokNxPqghBeQT5
         3/wg==
X-Forwarded-Encrypted: i=1; AJvYcCUU4inKF43MqubnMQsJe59aceUQqZQWljRDO3wR4op956UmqQ2Ue1l1VG9vI/uJ3M1aT+ovcTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbHccAss5bL2w02YaHFRE2smAQYjrHK8vvoXBzaF2esesfsSZi
	1sLDJBlQedRyhT/CZx5zSmg8KVK2qslwKS3iA1k2QgnXJR/aTVfu5MjYJB3Lbvqa7UFygDB0AXN
	7Ku13KoKjTRuwU/wH+UUIUPqzxJn2r6FPNnLQi+Wm6X5AZwTyk8o=
X-Gm-Gg: ASbGnctL4PBfv5xFrrArJGoSuisYivhXg8HY90BdcddTpMFBot/EShFsp63DcKSKYLa
	KulrU1l3PPmLHMhlJLCu9Lv4tILe9xlz1PgnkSO8JSKOiwKcwKPyA8rMkztt6wZGgOgVtv8Leob
	csDJug0C7wKzng3wjO3fP00r+JykgfYKAuW9XmC+EChQxJax3mIh/o13AuiEiId4ncw4R94ltlZ
	xcsvB08pHPwJ/Gdyi3RMu05iVC2qwKLexq+Eyou+/iU7p2vkJz5Pzu04TztU2fLYnPKauNE0NMm
	Q3DnBuYhCYJNLWChk6RTPaIq5Udu5PJ+kFAZi0OAJx8XaqMdLCt+yu4xsf+ZQSF/du8=
X-Google-Smtp-Source: AGHT+IErer93kOXokwq6+DGSfC4ugUszBo78NJco3EFwM9G1wiRi3El8E+vg0RKm5OXQE67tFwgtNQ==
X-Received: by 2002:a05:600c:5494:b0:453:590b:d392 with SMTP id 5b1f17b1804b1-453657bf79cmr45941935e9.2.1750698783204;
        Mon, 23 Jun 2025 10:13:03 -0700 (PDT)
Received: from steffen-linux.. ([24.134.20.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646cb57fsm118001245e9.1.2025.06.23.10.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 10:13:02 -0700 (PDT)
From: =?UTF-8?q?Steffen=20B=C3=A4tz?= <steffen@innosonix.de>
To: 
Cc: =?UTF-8?q?Steffen=20B=C3=A4tz?= <steffen@innosonix.de>,
	stable@vger.kernel.org,
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
Subject: [PATCH v3] nvmem: imx-ocotp: fix MAC address byte length
Date: Mon, 23 Jun 2025 19:09:55 +0200
Message-ID: <20250623171003.1875027-1-steffen@innosonix.de>
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
of 4 bytes.

Thus, the required byte swap for the mac-address of the full buffer length,
caused an trucation of the read mac-address.
From the original address 70:B3:D5:14:E9:0E to 00:00:70:B3:D5:14

After swapping only the first 6 bytes, the mac-address is correctly passed
to the upper layers.

Fixes: 13bcd440f2ff ("nvmem: core: verify cell's raw_len")
Cc: stable@vger.kernel.org
Signed-off-by: Steffen B=C3=A4tz <steffen@innosonix.de>
---
v3:
- replace magic number 6 with ETH_ALEN
- Fix misleading indentation and properly group 'mac-address' statements
v2:
- Add Cc: stable@vger.kernel.org as requested by Greg KH's patch bot
 drivers/nvmem/imx-ocotp-ele.c | 6 +++++-
 drivers/nvmem/imx-ocotp.c     | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp-ele.c b/drivers/nvmem/imx-ocotp-ele.c
index ca6dd71d8a2e..9ef01c91dfa6 100644
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
@@ -118,9 +119,12 @@ static int imx_ocotp_cell_pp(void *context, const char=
 *id, int index,
 	int i;
=20
 	/* Deal with some post processing of nvmem cell data */
-	if (id && !strcmp(id, "mac-address"))
+	if (id && !strcmp(id, "mac-address")) {
+		if (bytes > ETH_ALEN)
+			bytes =3D ETH_ALEN;
 		for (i =3D 0; i < bytes / 2; i++)
 			swap(buf[i], buf[bytes - i - 1]);
+	}
=20
 	return 0;
 }
diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 79dd4fda0329..1343cafc37cc 100644
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
@@ -227,9 +228,12 @@ static int imx_ocotp_cell_pp(void *context, const char=
 *id, int index,
 	int i;
=20
 	/* Deal with some post processing of nvmem cell data */
-	if (id && !strcmp(id, "mac-address"))
+	if (id && !strcmp(id, "mac-address")) {
+		if (bytes > ETH_ALEN)
+			bytes =3D ETH_ALEN;
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

