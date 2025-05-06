Return-Path: <stable+bounces-141823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95347AAC7B3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 16:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02FE4C250D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 14:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5731280CD5;
	Tue,  6 May 2025 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ6es0rA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D54AA32
	for <stable@vger.kernel.org>; Tue,  6 May 2025 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541169; cv=none; b=r3UORQmu0cuNnfJ/RVgbbiTlkr9TTqbr6h5pNr7pSlXcZ6mmrb1fvhyg7We31cVav3FApanqQ+RflLScsPo1aXdG+7yYqXoEsrkGlwMO58R4TwIfD/rv8hFfV5COnzmaHilOJxm4Htww1F0XUqHwkiH6ueeA9qPQD2SvS3F8vjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541169; c=relaxed/simple;
	bh=P5cWlcqMe7sqwFBe093l1POkMV++OgREl9gU7mM1e/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnH5jHzMrHVOZGwFnP1VWcl/YnUmPV7crsODHiugd4yKATrQ9wVfLRyEXB0LaZ8u3GXV4H33Fu35XNPm6AXwDvQ7xARNsNbzAcjm6zl2pswWN2yg6N4VzhF6SViy3DvK90JnoD0hWPEerXOD+n3pOLKjYmYkqYtEBFUmPXstnaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ6es0rA; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so5161142a91.1
        for <stable@vger.kernel.org>; Tue, 06 May 2025 07:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746541167; x=1747145967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wpwk/YLvaNxDwtsILY3CxEERY5II1nagDQSEwVYT72g=;
        b=dJ6es0rA0brsesx+PQqZY55sMfkNEBY2CvNo9fBFUUP1J2VKOwdKNQNHRDbAPEbys5
         zgjy+64az5op+wYNpi2SyfeSj0jY3tPTqAg/ZSc/U1hzEBsR3ssULB+52E6scvvA+cHa
         S32vLFlDV2vVWFw8ECOd++GzJK0okXTwy5LE/vmLdGUh23kP/69YlX8+kZFFBPP3QjNX
         +oJQV+klmXcCYpKHksw2sh12+TGXJLFPnCqOH4qZKVqdFbV57jVxkDxRxpH1y4KEBzU4
         1ovMdCcXDbt1SVN/p5R10uqxi2f1HdFozeWwcB64NJhb8xoVpvf7GuMEJMu2L9oBdD3L
         iX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746541167; x=1747145967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wpwk/YLvaNxDwtsILY3CxEERY5II1nagDQSEwVYT72g=;
        b=JshaZnX5Ag+yQbnmaFU+BSGR2ZWvcjTwDiXSwF444+97/ZosjA/PAroAybq88BqgmU
         jarSCgE7QOumxxRMUfXMlK4szgbze+6Kxh00Mb+JeVIWDfEgB9C+1gtdWt9UXDDf+d28
         FKQVwVvEIL02mAnY+2/65JMryOA+LATWndFiNkliozP3YRrOuu5ele88zVGAESWNO4sF
         n+y3g7Xzq64fcqtk16HM0vVWdqBFHr4x6wXPI/17fU6+KB4tV+5v3TMuG9YBypEk6L2H
         Bg2XRzRuSuQUbLp0gisJmg4Z7d+cW+8V5zpcfAXEACYqN9tNHEEhN8sTcJBRJLE3l307
         NYiw==
X-Gm-Message-State: AOJu0YwJAHSBK880QEM5vIGFlpPfyFgPJakUCv6yDYTrrzxiaa5ADIPA
	b+fuywmI/Lf9aubCUNKtnUFV6upSrhskoko7DwckreQd4sCGKiUNZLQF8g==
X-Gm-Gg: ASbGncvNhVpcOxnJpdWYZXlkLmETZg3tq6AncrllXmgxOCYBICO8dNefAG0m84xg5Gu
	jGV/mFhVOqU+VjtdqbTJ+kdYof8hCwTO77gV2iUmt+1nG3Lu+QXIn6Tx4sgM5vYZj+LKxexUZAa
	XlviMxa8h+BqsrUjp4ldoXjV/7VOngtLzo7LkUfGeTRfoNGXfMcA8CXRN/OKs+zLmA9KceM/KXZ
	2AGY10jA1yayq7kydXgwnGFks0R3iycU0wbQCKkmk3Fmx3nZdJNx1KNWc3zXoQ1klPy8qOpbBCN
	kgfhO0NwkLzadaPyFymxFFr1QGvRdD+b4lhuuUdy6NVDL3bcyQ==
X-Google-Smtp-Source: AGHT+IGaE2D3hfr3dqRSADUvmJmrXHhYUhcFCuT0rtk4W2ZciVf31ps3aVj8dt+VWb6cykQAHNxh9A==
X-Received: by 2002:a17:90b:1e4b:b0:2ff:4a8d:74f8 with SMTP id 98e67ed59e1d1-30a7dabd631mr4010020a91.6.1746541166863;
        Tue, 06 May 2025 07:19:26 -0700 (PDT)
Received: from localhost.localdomain ([181.91.133.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a81015002sm1266750a91.0.2025.05.06.07.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 07:19:26 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
To: stable@vger.kernel.org
Cc: Kurt Borja <kuurtb@gmail.com>,
	Romain THERY <romain.thery@ik.me>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.14.y] platform/x86: alienware-wmi-wmax: Add support for Alienware m15 R7
Date: Tue,  6 May 2025 11:19:21 -0300
Message-ID: <20250506141921.19467-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025050557-trousers-boogeyman-3f93@gregkh>
References: <2025050557-trousers-boogeyman-3f93@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extend thermal control support to Alienware m15 R7.

Cc: stable@vger.kernel.org
Tested-by: Romain THERY <romain.thery@ik.me>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Link: https://lore.kernel.org/r/20250419-m15-r7-v1-1-18c6eaa27e25@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
(cherry picked from commit 246f9bb62016c423972ea7f2335a8e0ed3521cde)
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/platform/x86/dell/alienware-wmi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/dell/alienware-wmi.c b/drivers/platform/x86/dell/alienware-wmi.c
index 1426ea8e4f19..1a711d395d2d 100644
--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -250,6 +250,15 @@ static const struct dmi_system_id alienware_quirks[] __initconst = {
 		},
 		.driver_data = &quirk_asm201,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Alienware m15 R7",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m15 R7"),
+		},
+		.driver_data = &quirk_x_series,
+	},
 	{
 		.callback = dmi_matched,
 		.ident = "Alienware m16 R1",
-- 
2.49.0


