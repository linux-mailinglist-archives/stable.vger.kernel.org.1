Return-Path: <stable+bounces-236092-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHC7HJ723GlaYgkAu9opvQ
	(envelope-from <stable+bounces-236092-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:58:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA62C3ECD01
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B745301BC2A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D10B3CE49E;
	Mon, 13 Apr 2026 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEs6WYMN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACF833D6DD
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776088439; cv=none; b=EINxBlYyJHOwiBiyY+O6cYE7uDq+ynuB5svHjWFynHOYZn/fqB4qysug2qeXQDysY8QVISFNIGqJ53/TIIBzH+pmMJnD0RxtxOcXAPvgJFIFZoXzqecw2clcTn08afIjzfBOSgUdhulfVQd8inD2fDdxSEXJMM/2jtwzxzpk3zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776088439; c=relaxed/simple;
	bh=tF5k1wSfQV9qRpEm/c2ecKsgNZoxB0cUfLMGDbVIRvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQT4ZqXXICQ/6xH7stW/QYJzPsI6Vd7qGeqLker6CI7m3MOAS0io+IMGgygQGkHa0tU+DDIe4m4UvnYegevB6oSfcrtVyPaHFNyw3uTJTOdPivNh9ol5sJ/1gA4al7woRwZtdcJNkuiCv2oa9BnavmztlOP7Lfr0CQn4qwfaAig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEs6WYMN; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2adff872068so22422795ad.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776088438; x=1776693238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9OD3lGF5l5459705Ws9WBdEwFaekZ5NwpESLmPDJ+v0=;
        b=KEs6WYMNmOy2PUhRSA1obOPNCt6UdxRxqQNU5ZOkT72KH66tJ0XntdyzV/Z8V7Zi5z
         gU8K0XqQeUFsWWdFrzMTJWDTLEGSiUcZ40fmJN8yL+LfbFLpD13amcoXJQ8FAq07daP7
         D3P2o9BVlAcryokQ0wdJ7K87dhMCdENFV8JflCsI9og0yye1wq1NpYt46UF9Nw1dofMG
         zSB8OMpWlKxA4XDR6iDaG6VUcSW1IcMTsiy7iqEdLG1MWxXJgCNfI38OiO+KgeMeSTtt
         mDwFbuaHJo4TkcsZ8dEgWVY/Og2XDMCdgDrApDnfdKZgbwCaEhA2+Py/aYsZVRIH02Tf
         fywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776088438; x=1776693238;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OD3lGF5l5459705Ws9WBdEwFaekZ5NwpESLmPDJ+v0=;
        b=g70v4NgndfYP/Dka266ZdqhrFNYtvqSpK6eEVkEY2xvwr5jXV3bA2IblPFFyp6QeSr
         UtnDPhk/v9r3womHijclp3FDUeV64vy/z6NlFDrBrhCkTuXjnalnS/oyzlE8TrJiGoMc
         W8arkcvqo8k1UpIUnHBbyMozmGK2kM5dURafjXUsdiTwSNw/1zMFxQUlUYmyiAhZ8sem
         IoNNYLf7uYriAfDd1epy2TWARWMgg94XgKqU34e+IGyzspEOBRkcV16kWz8hNCRoGiDx
         QZDYsi0EdbyHntb7c2f+SBwBT5P5CS/6PQM5X+XjpfOjaG215/hNcoWWxUuYnueY3HMk
         ypnA==
X-Forwarded-Encrypted: i=1; AFNElJ/Wyys0z20J8lcKjYMrz9IR84Ypz/I9RYJPbfGpEx4Z7g+/2+nAWSes7UeUbMc6JgW990nyOls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzdXDzK7MJNS6vX0ArpIlMt5fXXdnJVzSyKPjte/GAfeliLfFE
	QQIUy3V/DTtwTFOXHQcmPHt1eIVWycye7qCyV2K6vNEtf9bi9JVX6OcU
X-Gm-Gg: AeBDietDrOG1siFtJ8MhDB3tlIR75BgpHQzQOMcgfZCiJi1swe2xKrGr+1wRheEQpLg
	VmKGRn933oKPDZygi7zg0KD7g8FpDP1y0TE357mbW7YFF3OG6zE8KSkIxRMDlLR+bDZnG2GoL+C
	kwQKOMrrMwFxtFvX6z7BH6LUfyc7aOtZJYQVLPrMDyxCfb6bLOtAM1Aihgt3r4v4N7hwSRDtJAs
	lXca9ivR37aBXfLc5GCtnO8KbSCarWa1npMjQgUV6AHoiZUQkwQ43tDbgU4N6C6ZJYC/Qgidztf
	dcBAkc94Wdh6cFT1SCuYG49MPBUB9KF8G4VXtBXv7C+s11+ZcoVcDs19m51h7yRZbCbZ6UwQkEv
	wzaH/GlXEzp0xBizhREyBFjsRHIH98t3fQnoSsABMwjy4xpkerYtfbNkdGiXlfdjrTR6WL+dJ2L
	2klwgoi5niW8q5undCdM+xLwyKnczfY/w=
X-Received: by 2002:a17:903:2286:b0:2b2:dca5:101b with SMTP id d9443c01a7336-2b2dca51487mr114332635ad.12.1776088438092;
        Mon, 13 Apr 2026 06:53:58 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:6c67:74e8:5200:1f39])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f3a8f7sm119174855ad.71.2026.04.13.06.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:53:57 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Lin Ming <ming.m.lin@intel.com>,
	Hugh Dickins <hugh.dickins@tiscali.co.uk>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] ACPI: scan: Use acpi_dev_put() in object add error paths
Date: Mon, 13 Apr 2026 21:53:43 +0800
Message-ID: <20260413135343.2884481-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236092-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,intel.com,tiscali.co.uk,vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA62C3ECD01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After acpi_init_device_object(), the lifetime of struct acpi_device is
managed by the driver core through reference counting.

Both acpi_add_power_resource() and acpi_add_single_object() call
acpi_init_device_object() and then invoke acpi_device_add(). If that
fails, their error paths call the release callback directly instead of
dropping the device reference through acpi_dev_put().

This bypasses the normal device lifetime rules and frees the object
without releasing the reference acquired by device_initialize(), which
may lead to a refcount leak.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix both error paths by using acpi_dev_put() and let the release
callback handle the final cleanup.

Fixes: 781d737c7466 ("ACPI: Drop power resources driver")
Fixes: 718fb0de8ff88 ("ACPI: fix NULL bug for HID/UID string")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v3:
  - Note that the issue was identified by my static analysis tool
  - and confirmed by manual review

v2:
  - Use acpi_dev_put() instead of put_device()
  - Fix acpi_add_single_object() together with acpi_add_power_resource()
  - Update the subject and commit message accordingly

 drivers/acpi/power.c | 2 +-
 drivers/acpi/scan.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 361a7721a6a8..542e182f94f1 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -991,7 +991,7 @@ struct acpi_device *acpi_add_power_resource(acpi_handle handle)
 	return device;
 
  err:
-	acpi_release_power_resource(&device->dev);
+	acpi_dev_put(device);
 	return NULL;
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 416d87f9bd10..5124ed02debc 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1910,7 +1910,7 @@ static int acpi_add_single_object(struct acpi_device **child,
 		result = acpi_device_add(device);
 
 	if (result) {
-		acpi_device_release(&device->dev);
+		acpi_dev_put(device);
 		return result;
 	}
 
-- 
2.43.0


