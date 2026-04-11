Return-Path: <stable+bounces-235733-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMACGt1Z2mmB0ggAu9opvQ
	(envelope-from <stable+bounces-235733-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 16:25:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A979D3E04E8
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 16:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CE61303C015
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 14:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F8C385520;
	Sat, 11 Apr 2026 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VypOYZ06"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1973633B6F8
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775917421; cv=none; b=Gne9y/4ZSSO/fQ8h4tCRZM4CdjcICUC6h8gChoB/cp0tOVrpR+IVoG4D9dA0V1RmZCf0ZZOdM7TM4VAVahIwtwitWiz6PpPKQ6in/jgOcd9vnnHsXZf+nbseSMwhwF6YPDZRJx4TtsJzBgxjK2BomTtbFuBQvmnFega880Lpa1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775917421; c=relaxed/simple;
	bh=zjdX+fDP4DZujxewV7f8h2w2dNgyoukQyBkWuCBGgX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QDBuR/BYqWD/mJ2M6EZTRoq0n4sUZLpixSDuhPxLtmViBVyJa/BhT2/pzGDkoDydGgKMtAYvY2ABGs9voCaLulhWxYnuxFuCB5VKNb4u3oAMmSavw89LD/fvLqCCUhgRwY92GM/WzCVYDK2dZEBut5fQePL9EThLwJEd+jfaYIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VypOYZ06; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82735a41920so1043612b3a.2
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 07:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775917419; x=1776522219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TremzrygKXcYa02v0/L5LdhZrn3TlivFlrGomrxLn3A=;
        b=VypOYZ06m0rP896JPbDzy7IU5MwemGaESPkzI5g4u63yHjL9wjGkGyLFow9+J/t+6A
         /AQm/5bTAk74LWTxe0hxZJFuq7GQm6kXwBq0uNFjcwykkUROu/ieLhv/8gd2/tPfgNc+
         kVWkbjOh863yWJMjOAsYugTe1iUY8N9tqtDaG1gcVDJ6lpZRReFXu8s0N4Q+hBI54luj
         zfzxjXqIoiosKk9PERbmE58CDO1wYu2/CAKK3tSBfffqWpohxAqr3o6oktjEkJS9uDeb
         90yr0NoO73TD4WpobfbhZztm5bKKuNF4Ha70lTtgELJCXuypHv2RN9INianbcS0n3tgu
         mJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775917419; x=1776522219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TremzrygKXcYa02v0/L5LdhZrn3TlivFlrGomrxLn3A=;
        b=DtwUo/LHI5Hr6JFPhJE10gRGAu8ke2jxpAu+s7oo13dcf4HSJlJ8+Zm4wC4GG3K33B
         UXQQ3vlyBLiEiHAkymrvvbAzFUmDKqHJdgItLEdovNwyU0jPlyLwa79cyGr7mK4wBA/2
         6AmU+FquAhTj7WLJu3qmmjDu13uM/ia2PURozQvtZejn8IVZmScHfo6i/yO7XjqvgYu3
         QqhWGX6184saxcWbYbeuI4JRZaroCKC6WYQm2olDXGOCJW5Bd28qGp0lUcn+B5aSERCI
         v+VDhPn7nc3/WDrPAlqHbgHnj8EI3cWoCvHcooAKAYnjR1TUtQsdeV4p3smfTmIhMZX+
         tyAg==
X-Forwarded-Encrypted: i=1; AJvYcCXb0aY+yd0xQfM6itSHkYOP06bFLq3YagR9kGRr+zK0tIfHj3onDTlhqQ/LZZxqy6nOg6eh3OM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRpEn8aFVzodYPa+B56T6NRQTw5NsWm//lFZ67SFFY0MEppZFA
	+Rj4Acc+9kNZdlrsE6hPHShXv3Gz/Aau19cff9e//bf2fLVbcUygXz/5
X-Gm-Gg: AeBDieti/Keu0BzgcLZpAQmUOWpnk3tAwsomMC1Twa4Fai/Etx+3SRryEfgH1xJJeHc
	csmHZbqPuirvFBWU7E525UJsDoRlo0RIDwFPcYNhFbjYBtv6jJYBKx5jTzHns/bbDC866HgaU9q
	NjHWLAJn2fhpyIXQ2leDI1h3xa21nVNVloQ4ogOkeY7YewuPyH2yuRwvvpomd1x+JkrZe4tN8J9
	Z2nPz4CvK7q5KmQS5EtHv0aLJ6GT5fpqSEwX4Rfyxnm/TVOT6ZdlP74ndhbSY2ZkXOwKZ9KW7DV
	Z/st8B9gEEIXjZerXi8EuWb0PVRo0YbCFvZENERJPkmlDBf9NUaDimxkIDLV4ox9OgBL6i1G8Mx
	LtDvCGmO+votlvTvG8/tt2Pcbf/5RSDFVQh1Rudt0Y7xIEVnjyt19TSZCRTouiWWaNq1UsQDPaI
	WOC4O2sozf+PMWiA==
X-Received: by 2002:a05:6a00:aa85:b0:829:8942:2c93 with SMTP id d2e1a72fcca58-82f0c1cc16emr6636314b3a.9.1775917419425;
        Sat, 11 Apr 2026 07:23:39 -0700 (PDT)
Received: from lgs.. ([101.32.189.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b6d43sm5250995b3a.31.2026.04.11.07.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 07:23:39 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Lin Ming <ming.m.lin@intel.com>,
	Hugh Dickins <hugh.dickins@tiscali.co.uk>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ACPI: scan: Use acpi_dev_put() in object add error paths
Date: Sat, 11 Apr 2026 22:23:30 +0800
Message-ID: <20260411142330.2273618-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235733-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: A979D3E04E8
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
may lead to a refcount leak and potentially a use-after-free.

Fix both error paths by using acpi_dev_put() and let the release
callback handle the final cleanup.

Fixes: 781d737c7466 ("ACPI: Drop power resources driver")
Fixes: 718fb0de8ff88 ("ACPI: fix NULL bug for HID/UID string")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
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


