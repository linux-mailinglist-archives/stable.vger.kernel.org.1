Return-Path: <stable+bounces-176439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A614B373E0
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 22:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8A43635E8
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 20:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEDE28980F;
	Tue, 26 Aug 2025 20:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbeiMtk/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673B7366;
	Tue, 26 Aug 2025 20:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756240266; cv=none; b=c9gVxgM6omg9LOYFQguhSCyczevEGRM5hCVuLyQlyj2NufrLEZPZN7mHJuJw/w3umcFpNyQg+atc/nsQnTEXSIHrhot7WtMWcgAG1ZfUC8/EcHkM4QpM94YLZ+LORgPwN3iF+mTmgCn+1I5998ydyO4h633uvBgi8R6QwSm36YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756240266; c=relaxed/simple;
	bh=DWC0xNhvo1wbHp0YAGGxmcP4jYljObEIj1RY/1idnDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=haNYHAFYrdob5BTfWkgc2cPm+PdgDBdlq000+AfVvS8sl5rff+TjfUBYzJHile4QAMHpItsVROr4S/TFmFJZbDWxDmgH9QR5YwCLxFdtrT0tjfLCDwXuJPwDgeqWlMvHfxEwaw3jP2pExQfPfDlNf8TqATbrse+lgm6i9kiQB6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbeiMtk/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b065d59so35227875e9.1;
        Tue, 26 Aug 2025 13:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756240262; x=1756845062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UbXHRbunt4OpyGsOWv5/YhmtCrW9GXbryUFavJQhLJo=;
        b=nbeiMtk/ENAsvPFTBfuC4+qPmgi8hy0dz+eqkfwuHrGU7vlQVyDpW492uh+M0R/lHP
         DH+sCkGuZClrJSaT5zpGj9o1d1rGCje7HtXyBEZsjQJM2pMIaT3zXt8/n/ut+pfTGxg1
         H2E0N9ksd4+TASsjYE0ph7JWycZPrEWhwVStNSX0M4NAq7C6dk8VRXxfsck0nprwST9A
         rFWli5RaHpgLKMPozY4q0osazg8TYzBGAvHX10WvXr7vVp+mEBi6v+PeXXrvzmIngx7w
         aGK5iVU+Ydt2lmU9eodH8/3xOxRZO/oTYiKt3Eml/t+R64FEisz/WneZ+lXQAIZ4d2vT
         z+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756240262; x=1756845062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbXHRbunt4OpyGsOWv5/YhmtCrW9GXbryUFavJQhLJo=;
        b=SiCHuJrJ0eYbeZLK/+yWFXXvScG5MButOZEGHBOlxZyow5Bfxwlwyro6gT9TiVIEep
         2MUo3JgAW5M4ZmTNwoqYHv/HT3Ad0FWvXUy0nYm5UeWmAmEPUesCcq0Anp0vA7rAOU+I
         1AMkqfzBpUcd/f5ESl0HKgjLKawr6wFFIAI56xrtJMTKl7uWNlVDJ1hCmmtvToe7+KFF
         3FATCgnsBw/q9m2N4yQLZWHxOWBeyhTsVh1nbQXNBSc54FIOSUnLeHP3gyKH+Cmvw1Zy
         XJ14LRaux9hre0++7A+K/GEqGn/YV/NEaFC5EyfO07ardpi1STDixTQ6mk9k+yAwVPc4
         tX4A==
X-Forwarded-Encrypted: i=1; AJvYcCWIiumwW5qOVZhAHbBb+YMX13Q8pqCcKl6AdPNpRsQuD4ecxWQPcqh8PfcaeqSB+fRwdaC57n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfDoKjtic9vcYKcOTGQXywZZw8cuHuhZrN4XE/3WcK0QiOUpVe
	/s6sblefD9EPuTofams3LicmWTGPsaTOz5smwOfdhpCzeWQACpOLpO/qydhkqg==
X-Gm-Gg: ASbGnctawXVKAlWJBaOdH8q0mCAYgSfbT7OOU2XnQn+M/M8Ifk7dQpO1vh2JTODEEae
	75HsrSg3cbnnixBn8d8zMWZKY5OxiP8eNSTwoFH3PYmUYsFoL52wdH71G1bIMEOCIhRNatRB4ZU
	SDD6fpf//naPIBXMW39ULyKdlhyHkxugPY81RYdGW4cq9u8j8wrsFKvsHidwZ5R2uifHBFAURzV
	uIx/zbpEGvmhckfr4nx1ID6RDef5IcHhi+31wVBKr+NCKza5GzpoHZDIf4/Lt3XnmA574BXMFMn
	9OVC3Sws6KxdU+1++KAjf+hsoNihX5iva5q46ldDBZpioWko5HNthYtTFwz7DcizNDg4+GY8SRT
	NHPsevL+2VXEY58k/Rdu7AgEiEnssTBo6JsQRn6Lf+7U2+DShf/QZ9hibudXEsOs9cxTM+9R67N
	pPuzmjJh8fsdBUvYiJ6kdbDoAUtXib/kc2wOnKTI13SQJ4znfNhY1ZqHv0hxJJ0loJD8kG3QJiW
	UuDdhFW23U=
X-Google-Smtp-Source: AGHT+IExmsYWJHg2+pGCxumoucdqgjxFx7hCbcK5UNRPIfWAo9HCtoqYZf30Qr6yqTvXXyrnMiaJ8Q==
X-Received: by 2002:a05:600c:1d28:b0:459:d709:e5c9 with SMTP id 5b1f17b1804b1-45b517955a9mr175429615e9.6.1756240262145;
        Tue, 26 Aug 2025 13:31:02 -0700 (PDT)
Received: from particle-cbe1-0604 (2a02-1810-950a-eb00-f9cf-2393-cb7f-6fd9.ip6.access.telenet.be. [2a02:1810:950a:eb00:f9cf:2393:cb7f:6fd9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70ef566dcsm17401685f8f.24.2025.08.26.13.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 13:31:01 -0700 (PDT)
From: DaanDeMeyer <daan.j.demeyer@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 RESEND] Bluetooth: btintel: Correctly declare all module firmware files
Date: Tue, 26 Aug 2025 20:29:25 +0000
Message-ID: <20221122140222.1541731-1-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Dimitri John Ledkov <dimitri.ledkov@canonical.com>

Strictly encode patterns of supported hw_variants of firmware files
the kernel driver supports requesting. This now includes many missing
and previously undeclared module firmware files for 0x07, 0x08,
0x11-0x14, 0x17-0x1b hw_variants.

This especially affects environments that only install firmware files
declared and referenced by the kernel modules. In such environments,
only the declared firmware files are copied resulting in most Intel
Bluetooth devices not working. I.e. host-only dracut-install initrds,
or Ubuntu Core kernel snaps.

BugLink: https://bugs.launchpad.net/bugs/1970819
Cc: stable@vger.kernel.org # 4.15+
Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
Notes:
    Changes since v4:
    - Add missing "intel/" prefix for 0x17+ firmware
    - Add Cc stable for v4.15+ kernels
    
    Changes since v3:
    - Hopefully pacify trailing whitespace from GitLint in this optional
      portion of the commit.
    
    Changes since v2:
    - encode patterns for 0x17 0x18 0x19 0x1b hw_variants
    - rebase on top of latest rc tag
    
    Changes since v1:
    - encode strict patterns of supported firmware files for each of the
      supported hw_variant generations.

 drivers/bluetooth/btintel.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index a657e9a3e96a..d0e22fe09567 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2656,7 +2656,25 @@ MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
-MODULE_FIRMWARE("intel/ibt-11-5.sfi");
-MODULE_FIRMWARE("intel/ibt-11-5.ddc");
-MODULE_FIRMWARE("intel/ibt-12-16.sfi");
-MODULE_FIRMWARE("intel/ibt-12-16.ddc");
+/* hw_variant 0x07 0x08 */
+MODULE_FIRMWARE("intel/ibt-hw-37.7.*-fw-*.*.*.*.*.bseq");
+MODULE_FIRMWARE("intel/ibt-hw-37.7.bseq");
+MODULE_FIRMWARE("intel/ibt-hw-37.8.*-fw-*.*.*.*.*.bseq");
+MODULE_FIRMWARE("intel/ibt-hw-37.8.bseq");
+/* hw_variant 0x0b 0x0c */
+MODULE_FIRMWARE("intel/ibt-11-*.sfi");
+MODULE_FIRMWARE("intel/ibt-12-*.sfi");
+MODULE_FIRMWARE("intel/ibt-11-*.ddc");
+MODULE_FIRMWARE("intel/ibt-12-*.ddc");
+/* hw_variant 0x11 0x12 0x13 0x14 */
+MODULE_FIRMWARE("intel/ibt-17-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-18-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-19-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-20-*-*.sfi");
+MODULE_FIRMWARE("intel/ibt-17-*-*.ddc");
+MODULE_FIRMWARE("intel/ibt-18-*-*.ddc");
+MODULE_FIRMWARE("intel/ibt-19-*-*.ddc");
+MODULE_FIRMWARE("intel/ibt-20-*-*.ddc");
+/* hw_variant 0x17 0x18 0x19 0x1b, read and use cnvi/cnvr */
+MODULE_FIRMWARE("intel/ibt-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9].sfi");
+MODULE_FIRMWARE("intel/ibt-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9].ddc");
-- 
2.34.1


