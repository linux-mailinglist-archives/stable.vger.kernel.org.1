Return-Path: <stable+bounces-124754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FE9A66402
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 01:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7D6C7A3E11
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 00:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E77F4594A;
	Tue, 18 Mar 2025 00:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HJMjpjZZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724352B9A4
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 00:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742258439; cv=none; b=pliss4mhIRaEl9s/j7wfg44AOZmgq9BZWOXZuEb2rR3OrIP1YAVRA+Jk72JBxW477ANgNdw6CRt2pX+wqF3hKn6RfcoiUFM7O4eOf1bPZZ2bY6TU65UJSl/aFG6TBuSCY8HCMW+cImKQcgzcinWEMC35DqhJM3oJ/WhCX1lsV9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742258439; c=relaxed/simple;
	bh=aF1eAkjgcCapdV4LaVeUeqIvJD+3wVpYt9I5HsPkM5o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r200bESO/pbMemjy2xJ70S/44ISvBfFt+/Jasr4MH0PmQ8/ui1PnSKWR2uKUnYCs7t2Vwc8TY1Uw9ZxmuyaRaV3fVhsBfZ2sN4w0/qMYfyRgg6iL6q8V/T4phXuQ/TnQB4+ffKQ5RftxnN3dGOjQKdG8tItDsN6ydSyI8lhqilQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HJMjpjZZ; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5fe8759153dso2140159eaf.1
        for <stable@vger.kernel.org>; Mon, 17 Mar 2025 17:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742258435; x=1742863235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9vQclP5cvHTI1P3oWqFAri9BqwPEN+gIHprekZKw4CY=;
        b=HJMjpjZZ4FE6tODfEa019mQeBfjY96cDWvitTUJ3JpH/Bn4AE4XjHzA/76aPW6UlTL
         Qomlw+Wr6oFj3JdPdSorri91vK86EIOjhZWSQqHi4paueT1POxdTWxQF49HvrhDrd2eK
         vF3REaOn/uQy8G7fO8jdsPIMLRoxlIHN3LrE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742258435; x=1742863235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vQclP5cvHTI1P3oWqFAri9BqwPEN+gIHprekZKw4CY=;
        b=brGzrfpadaPlRS4wp7AfXSgG7ktcPzpobMMaDIVTxvZTTQrlKHkZEy7C5v1VM6PytR
         K1KroBHEXg5o5ylqu+0eICIkzM0688/Cr2s2Yh2uMTxerF8cShpZT7s4oQ8o7/OcW9GQ
         2MH8FWyI6CXShXBqUDq1NN8O9PR8uwMYxMtSlyUwpwyGR+/5y4GT2XTMAhVH9LaKz2aC
         pzYwqwIHVIa7B1Aug2TS/2zIPfOiwpidLmIoZU67NZd9zC943T+fdCTWmGbAmh+PU1lQ
         QUgBCz0HyVjQ199nOkPSMPP/NjdWkGQAbECt9meFWqjqxEgfxNWj2JJLnyiqiOsC86+w
         Ah7w==
X-Forwarded-Encrypted: i=1; AJvYcCUMNzvu0WdSZRCdJlw1bDOYAdQq8AU+eNBtCPzLSLNV4Mj8K/BKr2MVNsrkBR998mchnNfHZoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0qDCFxLWf4rCc8+VjvZD1lIZnSIcSNl53Wejj/o9WUpZt3frc
	5rxHaVEYZqthr2jwTJr+P+UQ9i23hnaRqUKx8xEQVmJGz06tPQsxLLyEUpezHw==
X-Gm-Gg: ASbGncvEg1SHdbLoHuhztseT1xbvEFjMrY78Z8YfqaJCVa7XChXD/vHPoKz0+JeodWF
	piHK5UrcSBrqZxOvhCMsPQdLP05BZSFZsTMn/eETA3xhVW0O2jKd4U4ga2wGfntmb9bXxjC1I+V
	+4md4uDf+O9Wjp96pw7vOUHZ9i3hI9t/ItlncE7PfPrIULLKvIaOSlAjm5lFsL4vrv9uvVzEWXn
	yrEc19FRG+Iw5Yu3z4ik1FEaRQ4sJ3rXhgLXLYhztXE3/UaRt9tYI9uo2k0CRxK7UP6o9xrxc8+
	sdBviks27Su3PGZSyaAvqYT/S2G2iD1VDXItMcKpkgy/48GqZY+LSNkYbHtjo3ihtWozuJsOVbM
	+SHaCo5Ok6D51Q+IZ6az2OtkvuA==
X-Google-Smtp-Source: AGHT+IHIaAa69q2Z8ANXe30r/tizHQHT896S2VWLzIZ4VMEnQe4ojb43pU2xocXU645TgXl4SoKLuw==
X-Received: by 2002:a05:6808:38cf:b0:3f8:cf10:f113 with SMTP id 5614622812f47-3fdee36f68fmr8838131b6e.5.1742258435416;
        Mon, 17 Mar 2025 17:40:35 -0700 (PDT)
Received: from amakhalov-build-vm.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fcd5c0007esm1999044b6e.37.2025.03.17.17.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 17:40:34 -0700 (PDT)
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: gregkh@linuxfoundation.org,
	bp@alien8.de,
	ajay.kaher@broadcom.com,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: [PATCH] MAINTAINERS: update Alexey Makhalov's email address
Date: Tue, 18 Mar 2025 00:40:31 +0000
Message-Id: <20250318004031.2703923-1-alexey.makhalov@broadcom.com>
X-Mailer: git-send-email 2.39.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in an email address.

Cc: stable@vger.kernel.org
Reported-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Closes: https://lore.kernel.org/all/20240925-rational-succinct-vulture-cca9fb@lemur/T/
Signed-off-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c9763412a508..c2eb78c1ab75 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17945,7 +17945,7 @@ F:	include/uapi/linux/ppdev.h
 PARAVIRT_OPS INTERFACE
 M:	Juergen Gross <jgross@suse.com>
 R:	Ajay Kaher <ajay.kaher@broadcom.com>
-R:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+R:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
@@ -25341,7 +25341,7 @@ F:	drivers/misc/vmw_balloon.c
 
 VMWARE HYPERVISOR INTERFACE
 M:	Ajay Kaher <ajay.kaher@broadcom.com>
-M:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+M:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	virtualization@lists.linux.dev
 L:	x86@kernel.org
@@ -25369,7 +25369,7 @@ F:	drivers/scsi/vmw_pvscsi.h
 VMWARE VIRTUAL PTP CLOCK DRIVER
 M:	Nick Shi <nick.shi@broadcom.com>
 R:	Ajay Kaher <ajay.kaher@broadcom.com>
-R:	Alexey Makhalov <alexey.amakhalov@broadcom.com>
+R:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-- 
2.39.4


