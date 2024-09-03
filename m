Return-Path: <stable+bounces-72781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8F696973E
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 10:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7166B1C23108
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 08:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082F02139B5;
	Tue,  3 Sep 2024 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGbgGxqy"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A769200116
	for <stable@vger.kernel.org>; Tue,  3 Sep 2024 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725352590; cv=none; b=mexJmWmhvM65JRDseJSWezzOSQnjF2NM0i78M6jLSYX3qACPCUUpGexCeoYXufMhwpCGTB41EI5tcHewpQBxlDOb9bSwl3uVVOVT+tFNPG7P7geTffxB8IrZaHCuVBv5qm8ZdE/2iyX3FcX3tC7wGYmi/wpTBcd7HRvGxr+F6mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725352590; c=relaxed/simple;
	bh=B96nrPrJ3UymOWx1erMliiY9Qfz6nxNgEcrD5Gbf74I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WX/xuTkOdc+h8G8lxKB3hlhEz+r+A1rG5tN7s4e4CcBtnMJecjZ7/lvu8GPjp9eo7fSFmHyAJxAyti5ZJ8IygJQuwqYZV8LI51TE652Cto0UC/BEjMYd1fMwOGcGp6eB1JMl6wINgB470kslkuN/6N/wEbLqmYi8yITFaTFxjUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bGbgGxqy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725352588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kz0l3l801CIquS+C9tcccCqk1x8Ol6UO6XryxHIY3hg=;
	b=bGbgGxqyDnNkOi38yI9ctOxjDkMlWUG4JQVboQMJDEgKwHcZ/eyYimOO3C30wjd/4/g+2z
	iQF7uiUmk3i5wP1QgevOb4PjrGhDNRv5ZVUGLkicTdZzCPOrCbAxYaFoSZocXeLnOhZ5UM
	L6tmNE9h0tqab2PZQ8YFYiW07Jz9ll0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-ax4uaVoFO_eLl22emilK8w-1; Tue,
 03 Sep 2024 04:35:45 -0400
X-MC-Unique: ax4uaVoFO_eLl22emilK8w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF6571955D47;
	Tue,  3 Sep 2024 08:35:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.239])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2F1101956048;
	Tue,  3 Sep 2024 08:35:41 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	James Harmison <jharmison@redhat.com>,
	platform-driver-x86@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/3] platform/x86: panasonic-laptop: Allocate 1 entry extra in the sinf array
Date: Tue,  3 Sep 2024 10:35:32 +0200
Message-ID: <20240903083533.9403-2-hdegoede@redhat.com>
In-Reply-To: <20240903083533.9403-1-hdegoede@redhat.com>
References: <20240903083533.9403-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Some DSDT-s have an of by one bug where the SINF package count is
one higher then the SQTY reported value, allocate 1 entry extra.

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
 drivers/platform/x86/panasonic-laptop.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/panasonic-laptop.c b/drivers/platform/x86/panasonic-laptop.c
index d7f9017a5a13..4c9e20e1afe8 100644
--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -337,7 +337,8 @@ static int acpi_pcc_retrieve_biosdata(struct pcc_acpi *pcc)
 	}
 
 	if (pcc->num_sifr < hkey->package.count) {
-		pr_err("SQTY reports bad SINF length\n");
+		pr_err("SQTY reports bad SINF length SQTY: %ld SINF-pkg-count: %d\n",
+		       pcc->num_sifr, hkey->package.count);
 		status = AE_ERROR;
 		goto end;
 	}
@@ -968,6 +969,12 @@ static int acpi_pcc_hotkey_add(struct acpi_device *device)
 		return -ENODEV;
 	}
 
+	/*
+	 * Some DSDT-s have an of by one bug where the SINF package count is
+	 * one higher then the SQTY reported value, allocate 1 entry extra.
+	 */
+	num_sifr++;
+
 	pcc = kzalloc(sizeof(struct pcc_acpi), GFP_KERNEL);
 	if (!pcc) {
 		pr_err("Couldn't allocate mem for pcc");
-- 
2.46.0


