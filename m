Return-Path: <stable+bounces-73929-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63679970949
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 20:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB44AB2126B
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 18:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DF117624F;
	Sun,  8 Sep 2024 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBaExoqa"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341352B9CD
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725821636; cv=none; b=e8zPRycd8Nvs/4e/SIm5EEShegKnY+pSxtYbQyJ1WyohgqFGUw1VFypEPqSUvy5sBJAw3iaDF+qb4YMLiWFNLzB2opSh+s2Of0dOaSBGO7TSkm0A98Afw9uKOQDJ8t2IYNnccHETYEgWk/sib0jw2yIYA/E1WiWw1G7ygAgLzvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725821636; c=relaxed/simple;
	bh=7SpYGXF9gyUbbUabUKS1OqgAmgLVILOxvs5wPjxAeKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wq4G6wXKtD19VteVAWMHegeXeoVJY7ay9O0k5Jbj5ffs6mYeJenfQHvYkW2C44yzpsPXXvAyIckEs3yx16zEUow4oE6UdRDgqDfmsN5ezPgh5hnGcqocnYxgC3Y7eed5L7hrahBNg/jHyTCK2dhlt0Y+dz1pWat+94cQiMEAgXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZBaExoqa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725821632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EuHANs1y7PwP/ZmwVIIXiWluDY7ppr7zIuLMN7lCNv4=;
	b=ZBaExoqakhaSHVzU0aGAp3YhwFV69AQbCDSSQCViLqM392QzSRLPqfkhamuh0PFftceody
	wXwg332b2zI9jSK1fyiWdspS7EQZiOe4ITMW8WazB4JnIKBYWTkfZqvlZyRkCcMg7650t5
	LCK6dobiBfjVkumzioRgaVZpUe+6dY0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-_qSgKUQbMLKrpo-mKojy0A-1; Sun,
 08 Sep 2024 14:53:50 -0400
X-MC-Unique: _qSgKUQbMLKrpo-mKojy0A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BBA0619560B0;
	Sun,  8 Sep 2024 18:53:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.33])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D77CE1956054;
	Sun,  8 Sep 2024 18:53:45 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-pm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 6.11 regression fix 1/2] power: supply: Drop use_cnt check from power_supply_property_is_writeable()
Date: Sun,  8 Sep 2024 20:53:36 +0200
Message-ID: <20240908185337.103696-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

power_supply_property_is_writeable() gets called from the is_visible()
callback for the sysfs attributes of power_supply class devices and for
the sysfs attributes of power_supply core instantiated hwmon class devices.

These sysfs attributes get registered by the device_add() respectively
power_supply_add_hwmon_sysfs() calls in power_supply_register().

use_cnt gets initialized to 0 and is incremented only after these calls.
So when power_supply_property_is_writeable() gets called it always return
-ENODEV because of use_cnt == 0.

This causes all the attributes to have permissions of 444 even those which
should be writable. This used to be a problem only for hwmon sysfs
attributes but since commit be6299c6e55e ("power: supply: sysfs: use
power_supply_property_is_writeable()") this now also impacts power_supply
class sysfs attributes.

Fixes: be6299c6e55e ("power: supply: sysfs: use power_supply_property_is_writeable()")
Fixes: e67d4dfc9ff1 ("power: supply: Add HWMON compatibility layer")
Cc: stable@vger.kernel.org
Cc: Thomas Weißschuh <linux@weissschuh.net>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
The fixing of be6299c6e55e is a 6.11 regression fix, the fixing of
e67d4dfc9ff1 hwmon attr never being writable is a stable series fix.

This supersedes the "power: supply: sysfs: Revert use
power_supply_property_is_writeable()" patch.
---
 drivers/power/supply/power_supply_core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 0417fb34e846..49534458a9f7 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1231,11 +1231,7 @@ EXPORT_SYMBOL_GPL(power_supply_set_property);
 int power_supply_property_is_writeable(struct power_supply *psy,
 					enum power_supply_property psp)
 {
-	if (atomic_read(&psy->use_cnt) <= 0 ||
-			!psy->desc->property_is_writeable)
-		return -ENODEV;
-
-	return psy->desc->property_is_writeable(psy, psp);
+	return psy->desc->property_is_writeable && psy->desc->property_is_writeable(psy, psp);
 }
 EXPORT_SYMBOL_GPL(power_supply_property_is_writeable);
 
-- 
2.46.0


