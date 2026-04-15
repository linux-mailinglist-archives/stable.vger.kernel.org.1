Return-Path: <stable+bounces-238164-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBAfOMnD32m9YgAAu9opvQ
	(envelope-from <stable+bounces-238164-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:58:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D69344068AF
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 18:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0095305C18D
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 16:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56243EAC6B;
	Wed, 15 Apr 2026 16:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMCLJe/p"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FF83E9F96
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776271934; cv=none; b=RJhrwpZdzX1osr6Si038OIs0lv4NwPuJBduLMGHFBUhohrumYqJsZ2CZpdWVht7eGjjis1qgJg4u7sxVohop61cmE9OXV9RR/2lOsTUrRPpY8U8UzKsJPXrZltvap9Q53j7lz5nlWnlyLLNbzeNQPaa8r43D1MiH+MvDrsn6toc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776271934; c=relaxed/simple;
	bh=rj5wLlup8qGQB7iNo7ZCtRiFyr1/9/lYD2XX1FA5veg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nrauScTgw5cth46BDPDE8E4q/90S8+cEh7qW2Pjwl5j87z6Tfap1YPYtGAWi2Anma7NQueLpS6eBhP5YurVNOzC3luzIZtlmtNtl5nly3bqEk9zvYh5vcZk9wbBOBJopDmJxmGpc/LJ2ns1Z4A+w1h7RNRGoF61XZlzt+j44q9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PMCLJe/p; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a9296b3926so39026675ad.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 09:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776271933; x=1776876733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YoIHp8GvLTuo5zMUl11z4KLw0EIw4APmXWOBDsv2hkQ=;
        b=PMCLJe/ph5FFe8WCCUqobYFNDH+I6rh9KHLeaWllg+ioPHlF0jz7c1VcTCsrFIjme5
         H1se78pxmCUnsCFceThYwRmjPaVYoDnyRBLw3pbMrZUvzRG990i1azzpRDqOyzWKEEP3
         qejoY7MEz+S2L882V9wjD9PzUY1dqiUqVNcbi/lYhMixW99ffwByiw1peuP9i2uWrdn+
         6qZ6HVbUteb3/n5R2NMrSszuhN2NgtNpwTdA+cVWVo9/BEZSN9nrWA/DcQPtWxT4hklz
         pho7NLSKbUlgXT6yPtNTMaYfBCRRE2xyMXe76uH+CK8U64/8VTe6REoPIXOet0kGBp1I
         4zjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776271933; x=1776876733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoIHp8GvLTuo5zMUl11z4KLw0EIw4APmXWOBDsv2hkQ=;
        b=QoSR/vDPYeVC9r6ljsdE7Gt3jeKOfJu2DenTyulYgcYeqFvAo52fhRm1632OQRrUJt
         /ctLaLsP6in7pZFKRly8I8Oyi3NqmxOUAVqFqXfUpthaHlZJhbO8cmisUkErXuMXYTGY
         XClySCOiutTbdJGRss5d55iNlFwGJdrXWs5sUeCFNt6nM3pII4gsagnt3sVbJslgeYzI
         t2ew8bhPBs0O+Ly7TOVLky8FIoHuu2zX/ZmQz0hkVy3yxjkD5R5Hl87S16qwEeVWRIRu
         hoxz+R9PHzBN5Y7bbPt2dKIfdQE3fsHopkNG9d/Cz6u2VNNnxR312tuhILFcbsrSxJRl
         WSxA==
X-Gm-Message-State: AOJu0Yz8enREaaRT9FSaCIo2I4KH2uaImCFPLM6kCWm7Qdn2FuU7NMgw
	YFjzRInXHs6DXQtXQxb2CxPsNAolTa8MXgbQUQ0HHN/qkL5ctWDvEi8r
X-Gm-Gg: AeBDietmTp+TQoXmbDrkepkjOrmykZYyO+Nzf8Zo0NWBKRjsz1ntDjis09/s6BJZTqt
	vsYKAZ0HqyHJ5DCETOopEjrbMJlL6360GpeajNrxQyMfD37DZk8Y/0dFdKXAA1OntlRBeiWFN6+
	Mz6agPjuJKl3k3mP8QZK79Yr7kgTafIE+z6TqxT4qJ2ZtiFi2A2+QwpHxnrG8T8kcYALmC5y+Jc
	NtMi+edtdnmw/b3ZGFWbbny6EXCZZlCDhNOdkgIU6OgijjHZynMmMEwxoCI8oTT/x448Iuw+E69
	Nx6YGWgASE9BfxIfp/IXX53ePWqbt5Eiy3tHXRTjullJ7gJKrh0vRFO+op9GbFppM8uZDJ78rNG
	rUgup5BMSJyorCrnl+7F63cU2uixuTnkY/B4HOLHe9dg8/efqYDxfQg98iJScXblrkU1RtBaMdW
	g/Gce7xmEqKDOE21TPvtMRYw/9qMtKgAp/sOUCcS3nJY3wwnQ=
X-Received: by 2002:a17:903:acb:b0:2b2:4eec:980b with SMTP id d9443c01a7336-2b2d5940ec9mr240710515ad.7.1776271932876;
        Wed, 15 Apr 2026 09:52:12 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:48dd:8f21:beaa:cec8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4782abd6csm25660635ad.63.2026.04.15.09.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 09:52:12 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] eeprom: digsy_mtc: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 00:52:02 +0800
Message-ID: <20260415165203.3584869-1-lgs201920130244@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-238164-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[arndb.de,linuxfoundation.org,gmail.com,linux.intel.com,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D69344068AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in digsy_mtc_eeprom_devices_init(),
the embedded struct device in digsy_mtc_eeprom has already been
initialized by device_initialize(), but the failure path only removes
the software node and does not drop the device reference for the current
platform device:

  digsy_mtc_eeprom_devices_init()
    -> platform_device_register(&digsy_mtc_eeprom)
       -> device_initialize(&digsy_mtc_eeprom.dev)
       -> setup_pdev_dma_masks(&digsy_mtc_eeprom)
       -> platform_device_add(&digsy_mtc_eeprom)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() after removing the software
node.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: c8ed97d8c3984 ("eeprom: digsy_mtc: Convert to use GPIO descriptors")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/misc/eeprom/digsy_mtc_eeprom.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/digsy_mtc_eeprom.c b/drivers/misc/eeprom/digsy_mtc_eeprom.c
index ee58f7ce5bfa..54fcbdc0412a 100644
--- a/drivers/misc/eeprom/digsy_mtc_eeprom.c
+++ b/drivers/misc/eeprom/digsy_mtc_eeprom.c
@@ -89,8 +89,10 @@ static int __init digsy_mtc_eeprom_devices_init(void)
 		return ret;
 
 	ret = platform_device_register(&digsy_mtc_eeprom);
-	if (ret)
+	if (ret) {
 		device_remove_software_node(&digsy_mtc_eeprom.dev);
+		platform_device_put(&digsy_mtc_eeprom);
+	}
 
 	return ret;
 }
-- 
2.43.0


