Return-Path: <stable+bounces-74010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0149716F2
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 13:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5703F1C225BA
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80591B533B;
	Mon,  9 Sep 2024 11:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MTZUuwf7"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136161B4C45
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 11:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725881564; cv=none; b=Y+iUIrmzrudQESq37jQEYoZn5Cm3jMku814IWxDgO+d6l5fCaiXnamb5q/NqrBlK9VSVY1l/WhQo13RQ7+G03F7E+0BAMaswk7t5/2cobJV1Ts11jBELXO7z2Zv7oDIRNHZfc7mBZW2HTklXDwi61KoSo1l3EO+CM1OyqN4Oqng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725881564; c=relaxed/simple;
	bh=Go2CbUCYhn/cFeiuUHVahmj4dcu56IBsT2kzzQ7VTnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dtjQ82YzZJNKbq87jNT/IJxMnqgNmW3OH73jj7XvW8v+LEp6+I012W4IARboCV9e6ehky6YdF6h3xI3Vw5lLEg2vJCdAQ1W3g74g8/eixBkLBQ9O9+gJ1WUW+914huV4oWhcEUBbY+70njnc2q8nEHiccZLlmD09YuE+j2iBZr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MTZUuwf7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725881562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sakEuDkSWdHDaZJJPUg7C/KUfmi3Vc/oxPnoXhGYojE=;
	b=MTZUuwf7bvlxvkszFBXiEPs0VDAeMzqgmWI1vFvFpJ1XsG2Nnj223irkvy5G5vb27FaZpy
	L+xD6PHwGnrU62KoTDNp/K0zlIp5NDVHKo8EChjdOaheJgnejct3T/N5RfspNGHm9DHIqi
	NOO+UBYlYPvluTTCwBQ2YIfxMZo+aYk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-HKO0u2o6MJ-YD2hM21Ec7Q-1; Mon,
 09 Sep 2024 07:32:37 -0400
X-MC-Unique: HKO0u2o6MJ-YD2hM21Ec7Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DED0C1955D4B;
	Mon,  9 Sep 2024 11:32:35 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.168])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3A00919560AA;
	Mon,  9 Sep 2024 11:32:32 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	James Harmison <jharmison@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] platform/x86: panasonic-laptop: Allocate 1 entry extra in the sinf array
Date: Mon,  9 Sep 2024 13:32:26 +0200
Message-ID: <20240909113227.254470-2-hdegoede@redhat.com>
In-Reply-To: <20240909113227.254470-1-hdegoede@redhat.com>
References: <20240909113227.254470-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Some DSDT-s have an off-by-one bug where the SINF package count is
one higher than the SQTY reported value, allocate 1 entry extra.

Also make the SQTY <-> SINF package count mismatch error more verbose
to help debugging similar issues in the future.

This fixes the panasonic-laptop driver failing to probe() on some
devices with the following errors:

[    3.958887] SQTY reports bad SINF length SQTY: 37 SINF-pkg-count: 38
[    3.958892] Couldn't retrieve BIOS data
[    3.983685] Panasonic Laptop Support - With Macros: probe of MAT0019:00 failed with error -5

Fixes: 709ee531c153 ("panasonic-laptop: add Panasonic Let's Note laptop extras driver v0.94")
Cc: stable@vger.kernel.org
Tested-by: James Harmison <jharmison@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Fix "off-by-one", "than" spelling
- Use %u to log unsigned numbers
---
 drivers/platform/x86/panasonic-laptop.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index 39044119d2a6..ebd81846e2d5 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -337,7 +337,8 @@ static int acpi_pcc_retrieve_biosdata(struct pcc_acpi *pcc)
 	}
 
 	if (pcc->num_sifr < hkey->package.count) {
-		pr_err("SQTY reports bad SINF length\n");
+		pr_err("SQTY reports bad SINF length SQTY: %lu SINF-pkg-count: %u\n",
+		       pcc->num_sifr, hkey->package.count);
 		status = AE_ERROR;
 		goto end;
 	}
@@ -994,6 +995,12 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 		return -ENODEV;
 	}
 
+	/*
+	 * Some DSDT-s have an off-by-one bug where the SINF package count is
+	 * one higher than the SQTY reported value, allocate 1 entry extra.
+	 */
+	num_sifr++;
+
 	pcc = kzalloc(sizeof(struct pcc_acpi), GFP_KERNEL);
 	if (!pcc) {
 		pr_err("Couldn't allocate mem for pcc");
-- 
2.46.0


