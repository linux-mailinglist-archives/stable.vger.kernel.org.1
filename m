Return-Path: <stable+bounces-235617-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODXnI4HS2GngiQgAu9opvQ
	(envelope-from <stable+bounces-235617-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 12:35:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B532E3D5BA1
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 12:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10B06300863D
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 10:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F363838736A;
	Fri, 10 Apr 2026 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsHiNQCa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDA237F755
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775817307; cv=none; b=SedmwVoIpX6u7v3SUgOPKWk45lx2J7/IUqYmbTU7ZNQNZBrzsdbYJlvKs2siTLsX85PA8wE02xfEn1cGYZLYMwUHoqUiKsHJKQvbjVukY2OFW0YI7ZKDoWrw2YgMyoYbJZ8+wE5WwV0hF94p3/P7SHFAuEnZkwHdxKjM24WLLGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775817307; c=relaxed/simple;
	bh=/2nU6DwGYrB+jeV22Tu6KgLsWFcZFrLNZ+WCDr3H/Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R5jYXwTxU05eNsRkaSHHoHv/PxRDIUn7NuMi2fY0IHAa77B1WnIvH9mxV6KDpDk86XhGbvjQEm5YHqUwU3QFQtWgls2+OVQLteG5Am8Zn4eai3CfLkZv7YiFZU96b51AnVIYhsT7kkx6cNStBpiHtzc8nfZVAhelq2kqNtFp/as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsHiNQCa; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82d029fd52eso1237491b3a.2
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 03:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775817305; x=1776422105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m9CrhvcxM7cDtB9lpTmog91+MN/asbSvWwrp/YtXbmI=;
        b=UsHiNQCapg8iULk7EptHrHrvd+IhlwCXSh4mG+eK4okgDR0B+jJ3i4UJpvG1Kz6UBk
         egn5vkgJoQjv4S5LuMZS63+oO1qkvr+fO62IpfUgwggbShefWCMg5y6QIxXQ735o7Rw1
         s75J365nL9bqC9GoatK7uAV7zzsbNXaF0f2rnL5oAJ9NMtYnh1953+booqbHvZ+wLzyZ
         jLEGZ3+8hCyeQN6l4BNaf5abwt8SljLvs2QEHTN6dDYZIa4nIF/wJ72FZiRK1Y6g6NtQ
         WxFDz0UlXDSn9JgzYG+wH6A3bRcD5bH06iPnjJEB8knoq3Xw1nyP8iqLGo7Hg5AiKnHL
         tHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775817305; x=1776422105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9CrhvcxM7cDtB9lpTmog91+MN/asbSvWwrp/YtXbmI=;
        b=cIOQ3zvtS58KhPxULhqyWA1EC8RL0ulgJIas2i2ioe9WSboG+fZ0Ebc0olfz+yS2of
         me1OPmvVGKXLSr3BgyVLgM0f5/Trj+oi2CnFt6vlTQhs1eIbcCiYynt4hmj074eIfwNe
         RXNdtVLz4cuygz+6RMjYcMzawyEj2b/rqw+QGdh7KzsOsNQW5yOKewkvOdtOPQo9SnTD
         qU1zmcXEo9xjeZE/YRmrnqqqAuwWEatyxTF7wVB/tg7J2cKGBNSCgrnviyjKeZ9G+huO
         wkhTUv+H+FcrIuUWLZq+EUYqmU34SbJs8wIJBnve9+xD6g72bR5XucxjEQVWNUzj3fwW
         OLGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX1t7PnZTOcjZAzisRBSf6Yu9ITHCxEvipzwlZpPfWKsAcYlB5SyF8Jkvp4qtyDwZdRRK/egE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/gmP6hAcPbxYgV3wK9daeKdW29BxjsBeFbBXH4OP/KiihakC8
	8jkKoqJbL8MEtNUu0+u4fn1tt04buVgnSRV41MgEMUJGk3c3tRURihB+
X-Gm-Gg: AeBDies16LslOuz/TXpDPnd1tBoWYYqlRvcabxB3WjwuQTp8TJnIrkLMzsRAD3iHZm+
	QmWKR3LLGubgBZ+zDv2AyW6UIjHM5697VVCAEttg73vhuuh9cgpVmjrd+Vlo9u4TvchyZ7oeM++
	IzsgY4/iunyh05oPrC4MLDYbwrRtkiDppwrxtw2OrnlxG/rcnDectnlSG6VUgABhbk0BGaUci39
	O1wb1gzC1FfRSXXOYxcHs+IRiOnSTqrjilsGJcAocPrDqrWUFivzGu2JhVHWMWrzjkoFHYmpDko
	z9jI3WCCQKIE3Zlslre1dyLqU6TLwbB9fyyyGgzoJDi7biCPYy6DuhbS4U5Q8xf/Z30kIQZswmx
	9M5VaeVGg/cWXx8qKKqB0PzcBaB2bqzIUASp38+QCpb0B8ktg7eGEJhYFaM46mNs+euerMKICqq
	GpsWihuhlm3VFgVRU=
X-Received: by 2002:a05:6a00:32ce:b0:82d:24f:2510 with SMTP id d2e1a72fcca58-82f0c384a66mr3113052b3a.50.1775817305356;
        Fri, 10 Apr 2026 03:35:05 -0700 (PDT)
Received: from lgs.. ([199.182.234.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4e182csm2503600b3a.45.2026.04.10.03.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:35:04 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ACPI: power: Use put_device() in power resource add error path
Date: Fri, 10 Apr 2026 18:34:51 +0800
Message-ID: <20260410103451.2014607-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235617-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B532E3D5BA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_initialize(), the lifetime of struct device is managed by
the driver core through reference counting.

acpi_add_power_resource() initializes device->dev via
acpi_init_device_object(), which installs acpi_release_power_resource()
as the release callback. If acpi_device_add() fails, however, the error
path calls acpi_release_power_resource() directly instead of dropping
the device reference with put_device().

This bypasses the normal device lifetime rules and frees the object
without releasing the reference acquired by device_initialize(), which
may lead to a refcount leak and potentially a use-after-free. Fix it by
calling put_device(&device->dev) and let the release callback handle
the final cleanup.

Fixes: 781d737c7466 ("ACPI: Drop power resources driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/acpi/power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 361a7721a6a8..f96f954876a7 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -991,7 +991,7 @@ struct acpi_device *acpi_add_power_resource(acpi_handle handle)
 	return device;
 
  err:
-	acpi_release_power_resource(&device->dev);
+	put_device(&device->dev);
 	return NULL;
 }
 
-- 
2.43.0


