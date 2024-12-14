Return-Path: <stable+bounces-104179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5CB9F1DC1
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 10:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 415151620EB
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 09:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC47149C64;
	Sat, 14 Dec 2024 09:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbK4LqJD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F4C653;
	Sat, 14 Dec 2024 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734167625; cv=none; b=I4rNXv8zrzD09KFq4Rdo5OatbLXQXvwhMzwfhZu4gGKJU6DFBU+pN63AtPNYQkfYOgVud2Z1mpv/Vr39BXoTZ+TgQnh8LMx5Ogp3XwJCOjVTMU266mNM129aBjfPMymPMJmz7F/j5c6ifw/CfJSWOD/Gjt/IHd6I+EZ+O/fzUOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734167625; c=relaxed/simple;
	bh=1tllsazc48/wvmX3msqseVCMNw/D1X0IE1LV/ujAb78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S2Xz2oL0DF9cffVGVey3CqqbeX2l9ppK7MNuM2KG4V6ZKPndJd158GaKJ/bbsPGaTsoKREjvSl/OI5bRsQ44L7tqWxB6MJWWjdRRS6o1zYrh8av/jBLz43fMv67HJzDlQZjIb8/BVrTA0m7Nl8TLEOAyKVLNAFou+oS0PmO2CeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbK4LqJD; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so3339068a12.1;
        Sat, 14 Dec 2024 01:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734167622; x=1734772422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWJTd+mkpnIyhgqJugaw5uScKdqJqGvg38Q5km3k6a4=;
        b=KbK4LqJDyM0VXJC+BxZzxd6GdE4JbF3y2gTtIAwr1rYwFXIE4klss4pC6ZBb+17+iR
         JogWXR9NUfAQMWfR5tw1qkC0YS2G//aCcUB1qrybcv9rslBdXaZFfW/thlrpS/13088g
         hX1K7moNUgbPyT07sBKvSC1CeFaNM9R4xrGzkH1mxyJhRwjy92pnaHoc6HUaDF4AGZPW
         KOLcM7PEFE1n2R/JteY18apLoUkE8Vze9Ulktm/41/xas/4cBQ1T+htd/rI7astV0a9L
         oSWuJUyD3cQvnwMr0fMdtiAixxhTgRXWbjW2PfRvHdyZf5qA1+pKTpjMh/78AseYi/mn
         NcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734167622; x=1734772422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWJTd+mkpnIyhgqJugaw5uScKdqJqGvg38Q5km3k6a4=;
        b=lnGb7q5q4Wz0Ewmyhb6jmk3CVzWG84fU8P6GwcS+mkb3nMMqJ8FnjUnwJR/1C7q8Ud
         B4a8e7PT5qes0N5pVqITK9E72dwSd83r6+1i9zvHkACfCl7FgJih6pkf68Kxyqjc5b2B
         8DUbEGv02OcRKcFm1TtMm49AwZpgowhv4tRJNy2QfO6JTFrUa+P2QWtOfFSl4PLtepw+
         aA9DHWA6MBOqH45Z/XDqyYGfOHAYqkIvEUDMOESTsP9uigaKcOeGSeA3+Me97ohFfPJ9
         IMBLZT5o0hyhKIMm+lAh4yJcNbE9a4Rtzrb78op3IKo1rYEe/Td3sI0TpYjiOrSCKmM/
         ufkw==
X-Forwarded-Encrypted: i=1; AJvYcCWhdoeDXH/vvBYCbg6UbqAANHP2AutdQCiSFUnJCexdYKjGMNNk4lZMh1pw05uGXYXZ0TBZS5n3@vger.kernel.org, AJvYcCXvPbrAXFH9HjO0RA/LZgcch+WKXaclFUKLONrkO92WeZkhDwQf1ZbXMgMxiW9wasuXSWGzdMMrN3rztFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhGdOSm2+2E62DWq24AL1x+41uNCNOxedMXbRiIQVPgjpM2axi
	k9xMiKZqpPq16mNYx68oMRhj6biabbcZUTkjy9PVKv0NgGfYXLZl42WdN/z9
X-Gm-Gg: ASbGnctAEbYTds8g5XcKBVR5UUI9tps0S3mLMSjmdzvvY1oXjNGOjsyG3kLyzmwtHdD
	IL1mgk5nRCWheKJi31zN9avCy3KleZsRDm9xbs1Xn+l9ozJa7xMesrSubuUYhiGNiAnUJc6iofr
	n6GGCkn1U2+cB6JmtBLgw/zTtGCVakRXvoRYhcbf4SQgbI7Ju6Z7IDVENUqEL4tL1+ky0GNJHTs
	iFR5kj8A9yGGVmK3xTI+F5BV3EI6OBzTaVAr59ggrv7VV9JB6jSj//osAa3BWjfTw==
X-Google-Smtp-Source: AGHT+IEsz44F13hbhBzowUfdoYK8xC8d6azdNR1NJs8oIeuPs5Sh+Lp9FpaYKm3Vu8QhX2PH6u/BGg==
X-Received: by 2002:a05:6402:2690:b0:5d0:cfad:f6b with SMTP id 4fb4d7f45d1cf-5d63c30684bmr4653744a12.11.1734167621703;
        Sat, 14 Dec 2024 01:13:41 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ae137bsm765770a12.51.2024.12.14.01.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 01:13:39 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	stable@vger.kernel.org,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Tanmay Shah <tanmay.shah@amd.com>
Subject: [PATCH v2] mailbox: zynqmp: Remove invalid __percpu annotation in zynqmp_ipi_probe()
Date: Sat, 14 Dec 2024 10:12:59 +0100
Message-ID: <20241214091327.4716-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct zynqmp_ipi_pdata __percpu *pdata is not a per-cpu variable,
so it should not be annotated with __percpu annotation.

Remove invalid __percpu annotation to fix several

zynqmp-ipi-mailbox.c:920:15: warning: incorrect type in assignment (different address spaces)
zynqmp-ipi-mailbox.c:920:15:    expected struct zynqmp_ipi_pdata [noderef] __percpu *pdata
zynqmp-ipi-mailbox.c:920:15:    got void *
zynqmp-ipi-mailbox.c:927:56: warning: incorrect type in argument 3 (different address spaces)
zynqmp-ipi-mailbox.c:927:56:    expected unsigned int [usertype] *out_value
zynqmp-ipi-mailbox.c:927:56:    got unsigned int [noderef] __percpu *
...

and several

drivers/mailbox/zynqmp-ipi-mailbox.c:924:9: warning: dereference of noderef expression
...

sparse warnings.

There were no changes in the resulting object file.

Cc: stable@vger.kernel.org
Fixes: 6ffb1635341b ("mailbox: zynqmp: handle SGI for shared IPI")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Tanmay Shah <tanmay.shah@amd.com>
---
v2: - Fix typo in commit message
    - Add Fixes and Cc: stable.
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index aa5249da59b2..0c143beaafda 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -905,7 +905,7 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *nc, *np = pdev->dev.of_node;
-	struct zynqmp_ipi_pdata __percpu *pdata;
+	struct zynqmp_ipi_pdata *pdata;
 	struct of_phandle_args out_irq;
 	struct zynqmp_ipi_mbox *mbox;
 	int num_mboxes, ret = -EINVAL;
-- 
2.42.0


