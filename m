Return-Path: <stable+bounces-185624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2A8BD8A97
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 12:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4FD0E4ECBEC
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 10:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30B92EDD49;
	Tue, 14 Oct 2025 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7UV4+nR"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C262882CD
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436468; cv=none; b=NftRyZP5YGFLzEvma7SF3SirB/49R8tXLIgGlLOnyVwhcnJZMUhWEEWZcJN848Ler997GF8cUq4Mt/6BOigyaqfuS8wEoxKNK8pjqrPr8tr0kozDxYq5772PqQBs8OysX5P6ua6yYdjYtQ/fjJ+NmX25x0oRBmx1kOJvoJkD1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436468; c=relaxed/simple;
	bh=52B6KKCTmHzTmQ3h+uIgnxRU4z72GzjP6jDC3Lo/rJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kLwPQXlSI2bHuGctLECFi3x9wpG8j5Su1AXUtubEmqXKMxwtBOL7/n83kEU4IViIpK5RkvpesdbYNd160/MyaALHzWhpOdNGGzAJf+htWC7P8nTQmk+FiWkEzDDwEwto08UlNbRDb6SnMDzCPkb+nHoj4WlMIjBM0+NlWxact/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7UV4+nR; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-54bc6f33513so3417637e0c.2
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 03:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760436464; x=1761041264; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ny2xuE6ziFtYutlPkIB8e4ze32Zq/HpfNT+lnoibpAQ=;
        b=C7UV4+nRbbrfBBLFuu5GimvgPr6FdPVCGf/fSsUY/6FgNFRRyq9OItHPBNFgsuuRHV
         yFCKuNvEVSnnewDLiDqtvPJsdSnTDLOOV+g+XYMieeG+UCUEvOuwUoZDLrbgoVafm6mz
         P/0QJ7Kvh8Fn4JsldoxNBzyw+zcJx6nr33Tf7kAfVxLprmH+eJNY9jT1fKC+6LVUIMfI
         RvsJX1aTTq4dTgs5e43eomlZfSE0WLVMOXQkRpy7wdAJqZRAAiOVEyxndyuw/4zXT4lA
         uNhkey5gcnjGggwoj37MIGas1QCH/aO7bP2v0401nqnbhffdQKj2R1CUHvMcPClulQNd
         aX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436464; x=1761041264;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ny2xuE6ziFtYutlPkIB8e4ze32Zq/HpfNT+lnoibpAQ=;
        b=pGKnnecriIyo2I6yWLaRMtNTb+fXblwES+lryLA18wXhqg3d1zBRNM/lDKRk/5Pw8O
         pZ+8vwGnHfcoNeTEOM9EdCdHn5AKsRVdt1T9qkJSQZXeQ+OOOoFmVEvk9CN1sI+xHUS6
         iW7lt1dUMWzjCkQOnGojIU31qP4ryuXeDRiPX9hxMLxXHIlCvsOlwCkxdpPVbk/Dojg6
         vuDkoqOuMxoTQqSPF46RDAfeDm2EwD9gfb21diMiN+DWQnmrqXU9ne8Rw9+lxvkf7QhH
         OFfY84F07AANB83B3iEcOFWul2jLUzamddY+MiYYeJ+P+bnj66sSU95mleePetqHyGXz
         7oag==
X-Forwarded-Encrypted: i=1; AJvYcCU9l4sVuc5ouldwBtCbjCj4TvPDmcCYnfMXCoONf+RCxjVI+z9kDKiua3pm1+/SN0/4/QUSKJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLlsGfrmRttionv3nF1FQUVzwV06YiqSKEdNQTnmJ/jY2CcD4i
	TSZKjMmo7kqu4K1wZmJ99fcRLeiKVggBcUMS+jWOnapwCmHfL3X8br/e
X-Gm-Gg: ASbGncvZvfN9NboaNkb/wRweW77G5/ZOJgK1osbw5uqXUQ6lwPgQs+roQ5mFLh80Wib
	8kmBo6vhp8Bqd2UnSH4zcPEtvXoAmnGHIn5vSycNnwEuzAc4kEZJkBNPu4i8E1DOCMvOCKj+qrS
	bAQB0qJStywbD/iXL/e5kETaq9KqGTr09WnDm9Pkm4AJ76CG4YOHOva0omq1bw0wyTdP4fafKPa
	d5yflSjGtVTJvLpMWTbUcZfxvSwKbYwvDkWklwtiUnd19/De3+DKWpNu9ZeqsaHhX+WARfJl8/l
	LoX0Y+tAB1bzH/6IdwaaX5oHONbUKlNQGbtNTGK92ZF+rVmSG/Iz3kbnbqwvMPqvr0HmjY8J3B4
	lzBehspJBfnibodCwQQuUKTyvBuU4FZQV5TQxXb33wtF+4LIr9vgZgA==
X-Google-Smtp-Source: AGHT+IFHmk9H+o0M18+P+FqU0IZbfnWXxDvDwxciPXKm/+nrLvsqNqmJl7xfYRQe2zBSrY8m/1+RsA==
X-Received: by 2002:a05:6102:1622:b0:529:fc9e:84ae with SMTP id ada2fe7eead31-5d5e2357b3bmr9241852137.24.1760436464398;
        Tue, 14 Oct 2025 03:07:44 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5fc8b5e06sm4223171137.11.2025.10.14.03.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:07:44 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Tue, 14 Oct 2025 05:07:27 -0500
Subject: [PATCH v3] platform/x86: alienware-wmi-wmax: Fix null pointer
 dereference in sleep handlers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-sleep-fix-v3-1-b5cb58da4638@gmail.com>
X-B4-Tracking: v=1; b=H4sIAN4g7mgC/3WMywrCMBBFf6XM2kgnJbVx5X+IizzGdqAvEglK6
 b+bFoRuXJ7LPWeBSIEpwrVYIFDiyNOYoToV4DoztiTYZwZZSoUlShF7olk8+S2UL5WuvdfSVJD
 /c6A87637I3PH8TWFz55OuK2/SnWoJBQotLQO0dbkDN3awXB/dtMAWyXJv6bMJhrfWG8vWjXqa
 K7r+gUUpzkC3AAAAA==
X-Change-ID: 20251012-sleep-fix-5d0596dd92a3
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Gal Hammer <galhammer@gmail.com>, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1736; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=52B6KKCTmHzTmQ3h+uIgnxRU4z72GzjP6jDC3Lo/rJ0=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBnvFJ5WCu949E1z0caTm/kcs7jvFdzYol4XeuPI13ijE
 /Xe7/hSOkpZGMS4GGTFFFnaExZ9exSV99bvQOh9mDmsTCBDGLg4BWAiR20ZGT7IimiGRjVPvHb7
 Rtml/v9rtB467lAX2J718b16/reHE3MZ/idmFNj3Vbiwf3tlsWG94cGcf0WHHQT2WN/m3/alWM9
 cjhkA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Devices without the AWCC interface don't initialize `awcc`. Add a check
before dereferencing it in sleep handlers.

Cc: stable@vger.kernel.org
Reported-by: Gal Hammer <galhammer@gmail.com>
Tested-by: Gal Hammer <galhammer@gmail.com>
Fixes: 07ac275981b1 ("platform/x86: alienware-wmi-wmax: Add support for manual fan control")
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Changes in v3:
- Fix typo in title
- Go for a simpler approach because the last one prevented the old
  driver interface from loading
- Link to v2: https://lore.kernel.org/r/20251013-sleep-fix-v2-1-1ad8bdb79585@gmail.com

Changes in v2:
- Little logic mistake in the `force_gmode` path... (oops)
- Link to v1: https://lore.kernel.org/r/20251013-sleep-fix-v1-1-92bc11b6ecae@gmail.com
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 31f9643a6a3b..b106e8e407b3 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -1639,7 +1639,7 @@ static int wmax_wmi_probe(struct wmi_device *wdev, const void *context)
 
 static int wmax_wmi_suspend(struct device *dev)
 {
-	if (awcc->hwmon)
+	if (awcc && awcc->hwmon)
 		awcc_hwmon_suspend(dev);
 
 	return 0;
@@ -1647,7 +1647,7 @@ static int wmax_wmi_suspend(struct device *dev)
 
 static int wmax_wmi_resume(struct device *dev)
 {
-	if (awcc->hwmon)
+	if (awcc && awcc->hwmon)
 		awcc_hwmon_resume(dev);
 
 	return 0;

---
base-commit: 3ed17349f18774c24505b0c21dfbd3cc4f126518
change-id: 20251012-sleep-fix-5d0596dd92a3

-- 
 ~ Kurt


