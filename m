Return-Path: <stable+bounces-242973-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WItpHKFw+GmxuwIAu9opvQ
	(envelope-from <stable+bounces-242973-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:10:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C676D4BB77B
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F4AE303A519
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 10:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1C13921D1;
	Mon,  4 May 2026 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWLBLAFT"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC47D390995
	for <stable@vger.kernel.org>; Mon,  4 May 2026 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889309; cv=none; b=DejMyPkmiiX2cT6DS2QNd7Ja/BzJMa/duPkbGBXrQzz8LjRTbUbSOjnzN6EatwqHe94+aEQvH4lroK4MWu0NRnRqECwvBqkAKzULt2W9J9DORemBmt9T87JPgr4uoOguhRNeytZQF4c81v8ZPhQDOul2iBeubyu2TKs7h/my/Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889309; c=relaxed/simple;
	bh=uzVYR2oxORfswsKO5073AqMtFJIBGpVKkfVCVIKVeRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrC9AVOTSN6LKlLmez0F7COex6ui0aaeHAwGRRhtzV+eA2YXeCk4ssyb58CEOFYmMZ0xwMzPLcJ6TpkEnel5AB9GlaBlg4D3mHH80aAI9MnVcPX7Xs+92kBnUeGaWHTSZZapob27JJtPGRGwDyXixiiu21327vb+nu6azibHTjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWLBLAFT; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a283c44478so5126430e87.3
        for <stable@vger.kernel.org>; Mon, 04 May 2026 03:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777889305; x=1778494105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ejlKc5ArUlrjZTG0qqBOiFFqj7qKQRkSb3mwVckWx0=;
        b=NWLBLAFTBsZWtvdQHJgyKrO+mlTfhhZlyOziFYhrC49DizZw8lfc1701XMqkOqBN9X
         XVgdMVFmJjgKngnVUdA3KOpwWa3f+7nw6hozXbDrvkBAwuxrcn2lr52zf8caoqqCt2pD
         7MqR+TPPirA9DQig5Tu9VeR7V8r3RQ/3tNa2jbh032XVzrAjVYjuVMlXYJipGde5B212
         fX4zUGgk4PNkhOGI+gkTdK0sykI48pxqipwuZf61a6cPDjDGAvOerC+qrAe+66WGK9Ww
         sexh0bs2zfdrRU6EywTdN/ycvVdZuiaON8U4DM44yYDglcoza/v5lABUlFZ3ZfuERLgx
         aWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889305; x=1778494105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ejlKc5ArUlrjZTG0qqBOiFFqj7qKQRkSb3mwVckWx0=;
        b=MT8pli2/6EZ9s9RqrGdeoh7QsI8k03kRkGjbf01NX1ZptA9wJWjtGvrKM4F22waW/s
         T007C4u4/YygJsGAosbZTaGQZiYRaQi62TjbCmaS+8UdXRm9P/fcaqusFzhkSbDR7GMz
         +Au1PvO2n268QBX+kITwayOYeOMp15O2V1EjnD/Qn0WAz5HpasW4agCgDRMx+gkDOZq5
         XeZI9pxI/bdLVFaeu9DVKw7C7h7U9DvmKlLwyDbMC0ii267P09CaPjCCZrhgSoTZcG6X
         yBXo7PA3mm3cgbnUV3afcAQv9kXRjfnXeMUTsjF3Dd7+5nGkoZmXZy0U/OE5H4WuZ7Ck
         PJvw==
X-Gm-Message-State: AOJu0YzBJtK+zw55drroZOg1V4XDhbybCSv/k7beeDBWk7Awc1TEmPi9
	cbT2srgQvmQ9oHHyIvGz2F6tJHGi5qRLESEJf4HHB6TygmuQHFoYSMkA
X-Gm-Gg: AeBDiesyk5+lUzAZPfwPrInw3rXHxGLajQ9/isx4cO5JDOVg3g9zu0YDjRxa7HazUpP
	FqEkD1eCTcDpxd7KEPifAGpuTguyslL0mgDr+i6MbPurvi5sAyQL5znhqsQrAWdpaqHe0xOHI2m
	lMZWled1KhEOpuY66xfuSNOA0hz9FJmLI9lVFF5n/Qvs8hSaHqn/LITPfRotjAKTbNXD5nQbrio
	RlRNUYBpqd8/dVifxHEv7OvTS8VFXKZ21gd3Gc8GHagmT//5ZIeO/dtuVn26z3Wx0dIC42B7/0V
	za05KZADECeukQldKsdmMzV7rBRfnksFpOHTiDmOH5mJA+fzuZmgIJM3jpu336G6smMGnioMe19
	OEjudoBlxItBuGF9KKv8fZ28DQ7oDBtbH7ttygp6w5fcghrMnDOpICqtr+mK0sVcJ8MmMOuA5jw
	mUAa1Ydfw3xhUJJ978g5tsWXNPMB/IS6zDsi0HakNEXctnAWvXYfLTf8XUm1qkMKf98dZ7rS4=
X-Received: by 2002:a05:6512:1395:b0:5a4:db:abce with SMTP id 2adb3069b0e04-5a862fbc019mr2488383e87.18.1777889304461;
        Mon, 04 May 2026 03:08:24 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c33c2ecsm2856217e87.42.2026.05.04.03.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:08:24 -0700 (PDT)
From: Vastargazing <vebohr@gmail.com>
To: vebohr@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 1/5] misc: eeprom: digsy_mtc: fix reference leak on failed device registration
Date: Mon,  4 May 2026 13:08:16 +0300
Message-ID: <a6778ce2d2e906e6f8a7c811e5faf4a8c56aff11.1777889235.git.vebohr@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1777889235.git.vebohr@gmail.com>
References: <cover.1777889235.git.vebohr@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C676D4BB77B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-242973-lists,stable=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

When platform_device_register() fails in digsy_mtc_eeprom_devices_init(),
the embedded struct device has already been initialized by
device_initialize() inside platform_device_register(). The failure path
cleans up the software node but returns the error without dropping the
device reference:

  digsy_mtc_eeprom_devices_init()
    -> platform_device_register(&digsy_mtc_eeprom)
       -> device_initialize(&digsy_mtc_eeprom.dev)   /* kref = 1 */
       -> platform_device_add(&digsy_mtc_eeprom)     /* fails */
    <- returns error, kref still 1, reference leaked

Per platform_device_register() kernel-doc:

  NOTE: _Never_ directly free @pdev after calling this function, even if
  it returned an error! Always use platform_device_put() to give up the
  reference initialised in this function instead.

Fix this by calling platform_device_put() in the error branch before
removing the software node.

Fixes: 469dded18391 ("misc/eeprom: add eeprom access driver for digsy_mtc board")
Cc: stable@vger.kernel.org
Assisted-by: GitHub Copilot (Claude Sonnet 4.5)
Signed-off-by: Vastargazing <vebohr@gmail.com>
---
 drivers/misc/eeprom/digsy_mtc_eeprom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/digsy_mtc_eeprom.c b/drivers/misc/eeprom/digsy_mtc_eeprom.c
index ee58f7ce5bfa..4ca3e567c49d 100644
--- a/drivers/misc/eeprom/digsy_mtc_eeprom.c
+++ b/drivers/misc/eeprom/digsy_mtc_eeprom.c
@@ -89,8 +89,10 @@ static int __init digsy_mtc_eeprom_devices_init(void)
 		return ret;
 
 	ret = platform_device_register(&digsy_mtc_eeprom);
-	if (ret)
+	if (ret) {
+		platform_device_put(&digsy_mtc_eeprom);
 		device_remove_software_node(&digsy_mtc_eeprom.dev);
+	}
 
 	return ret;
 }
-- 
2.51.0


