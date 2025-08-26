Return-Path: <stable+bounces-176433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 026BBB37354
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 21:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1BAA5E868E
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 19:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BE830CD9E;
	Tue, 26 Aug 2025 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A08G9NbD"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7896130CDA0
	for <stable@vger.kernel.org>; Tue, 26 Aug 2025 19:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756237366; cv=none; b=m4itDedl3tSkA+zq7xhGiB1ce9P6b5bAvj7jh4EIq3+oprzzLgQawNtCYr+RX6Zd2LJYNnXFvPSBxKPtI6G5NRAmbroOhEx1EVhtmjl2m4U1WAK53QXcHapnzhQtrkbaZmLHH0f3W/I1QfXwmShFni+rTVR9LMn2ddTgxo45gBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756237366; c=relaxed/simple;
	bh=DWC0xNhvo1wbHp0YAGGxmcP4jYljObEIj1RY/1idnDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JWaqxSD8hbcTRMmYbK/koXD+2jEAikB1vz1iFHiXEUxdLSUUNUA2XXRocn/UwvR84F4pPhWrAcYN1xmD1tRm1rnJtrZsyEKKgDDjWMnGJbCR4/0Vub6aEHKdIgiyDAcXHI1A/ibyjFIwNRlZYI2aA/WJFJn1vyzyAwXrNfM+fv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A08G9NbD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3c68ac7e238so2089006f8f.1
        for <stable@vger.kernel.org>; Tue, 26 Aug 2025 12:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756237363; x=1756842163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UbXHRbunt4OpyGsOWv5/YhmtCrW9GXbryUFavJQhLJo=;
        b=A08G9NbD6wJ5LfvPt+1UUw/M8z8TICOrPUL/9KqoDtEr1Ts1LKV1kZQAJ9ecFXQndP
         EtBWrN/1PuZ/V7kBX7Uf1tvbiNVwLfdVV53hn3oWCeUPZatStoLMJiQ2A6r1zzqyuhFb
         s7A9mwe6kHXb46lkdPE6mmZHA85PiCJewYLh8IWZ4wNTfHrWoYOW3fOBcaSLf9fZhxZN
         i+ksk/bDp05ssWEpN3PtWWL6x+IbAPXvG9NBb0Fo8kBbkJ+CJyTZPNGgWzzLhg0w6HPq
         GcFKCXDttaxgpWdMKhFIB57EQgCzfcOTPslfrBPs4YMZpHGnjtyKe8aCfOlBExaw/ZoQ
         DTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756237363; x=1756842163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbXHRbunt4OpyGsOWv5/YhmtCrW9GXbryUFavJQhLJo=;
        b=UgflD+8riT8LwqhhDPM0Oa8OwOn45H/m5mXwgm9+Z1KLCaSy3WoW3o8cxO3eUAnivv
         5JJLL6H/x3B0m4TQ2MB+S0j8XyawQE00FX79xQ+T48we4EOfljVvCnOUuD4a10lo8rpF
         lcXel8GYtGf4ESgFOOSPnj/BX3frsSwyxApmhUyXx2wCVy4bb6RdT4aQVvaGk9+blYBw
         lPaHq5tAGx+fcwjcgP1Ly4gUZec5Wm2O7vaTcDs0Ls/PV4IxH+87iOxZaE+JccR9si9e
         20ZJWWNOGBX3QhQRozW5PaxXeu/u84yNSJcyzbDhPi/CDd41LxAvWASlVhi6qGmLP8cp
         ZPdg==
X-Forwarded-Encrypted: i=1; AJvYcCXDip81FSNIQ+JB4ikmR4UoGB82zV0dMzvRC/cwqnxFwTdMq8erCCPqdUtUg52Z9YJDq3fC0r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaD86boazweSrUvhlmgmWE7Kx0AuHfHAFAyfVJ92wPaclNGuPF
	xg59ZLme+/c0vKDxl7HNOUkn26wo+FOv6Xdii2MIF91V6ZGcu1rc6NDq
X-Gm-Gg: ASbGnctq+tewJXLZFdErcf9i9WcjAWdXQ74VURjoFk3eRzMzy6jIx92C2U9fWtXzCz3
	3JkfJgQEePuNXDhsACWZMFIZYEIauBuUrIUPWSBRsmH56O6KhnpfbTiGZaXgd3drZ5g8UGdeXPX
	3n89hQ1zjaOolwxmKtE3pWNuitT0hcyOjImdljyp97YZQuIoajh6UCzP2QjribWfpbV2x9thb1h
	yTsKQN9TL9TEmabrq5EMZh6PwbiJ5R7UwpyzIzkBVO4zlmgkcI67q3UWCjuFy5XBb5K7cRlwHOl
	RmsHUfk8wsCgkVFVs65QHBTihd6bh5iJX/aq2D9TexwM0VpoiS/yMpT1ynW4xnJdpAri/AvuMP7
	dwa1UZXY/xlOoBJ34/lcaSHRmApsb0WLDZjS3NUemaR4WuH/nNRW6Jr6f62ADVR6mOKZRQFjV82
	o8gPdxcQMfoZlTlMENYkScbYoOt6ddgXXROFIWMagZ4EukWWUIzP6d0wOJkncbHGqqvevf+mU3a
	t9/PR+IAu8=
X-Google-Smtp-Source: AGHT+IFXxOulOgNi/+i4gHiTA+vPHCw+Ch6HVG4vl2YTMfA5uK6UFp4wPBoX2L/oU4DwTfMKtqhczA==
X-Received: by 2002:a05:6000:400e:b0:3b7:9c79:32ac with SMTP id ffacd0b85a97d-3c5ddd7f89amr12538440f8f.52.1756237362416;
        Tue, 26 Aug 2025 12:42:42 -0700 (PDT)
Received: from particle-cbe1-0604 (2a02-1810-950a-eb00-f9cf-2393-cb7f-6fd9.ip6.access.telenet.be. [2a02:1810:950a:eb00:f9cf:2393:cb7f:6fd9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6c4e8961sm5789865e9.7.2025.08.26.12.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 12:42:41 -0700 (PDT)
From: DaanDeMeyer <daan.j.demeyer@gmail.com>
To: daan.j.demeyer@gmail.com
Cc: Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
	stable@vger.kernel.org
Subject: [PATCH v5] Bluetooth: btintel: Correctly declare all module firmware files
Date: Tue, 26 Aug 2025 19:42:20 +0000
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


