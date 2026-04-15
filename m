Return-Path: <stable+bounces-238169-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHkuBgjG32kmYwAAu9opvQ
	(envelope-from <stable+bounces-238169-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:08:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D388C406A39
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CF2333065974
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 17:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A260311C2F;
	Wed, 15 Apr 2026 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW1ohQd2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFB421D3E4
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272440; cv=none; b=B6dZGaZJ0g1GQDJm/m/MOB0MWVQRAPWwJjmZ2J/USubLTBYl2d1MNIBU/zBOPSXxvYBTRyHPdpLneb2ybsZ176WOgt7S01O1ImUbg1IVD4snzzvbsMgz5ATnNUw28XpuLVi7A+dZ6PSMpz5RAzwoeAxdJWSQQzrHawHMGNwbsL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272440; c=relaxed/simple;
	bh=6ft0aSJC2lfyC9/Em4SF3ThsHmszq4J/nmlcR9fRkS0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mzt2dY9fsQhqRfx3IeZvu/UbRsccfwGoznsxXBuG0S32TU6wKKCv5y7eEO33wpoTIdI+M0MtUmLtvghozcMlIqKJXFlpghQsxspX9lfgTXnB676F3b1+es2AjC8RqkhzoYM0+P8X+/2s5T5YZg0Op4GgQzfk5CcapvpuqSVDtbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SW1ohQd2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b299b3c739so30679925ad.3
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 10:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776272439; x=1776877239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tJqWM7Qg/yxY9S66GjsuTrsJ7EEWVnPgKW5QeWWEd6M=;
        b=SW1ohQd29YXD5Nr2LJUOZwwEyCnBjjVmiYHEKkW7KChygQT/GoAv6oYmPHaDQkAaVK
         hBzzpKbLzOtukYx9RZZ/QiD/VrYPm1p01lBFxesGzUog9xGTGP6zT8i8uuZsiSoIZVHG
         p24STMIqw47tlubtkMPpB7FomVzmtBXbeLvwI/kEDL4zfkLdVvB5VK+Esv+ubf3LPiST
         6il4mCTbqya8PqlOLkIjnpY3rwV5MOVl9A8z/XKNksskhFuusLjnAAkLNiaPyuP0y8+z
         wQXoi/SZIK5GAmE+yofLk4Kd1As/LBFZb3cdKA59bxiqsfipC/+WWn1jtQU0lU0ifiYA
         hVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776272439; x=1776877239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJqWM7Qg/yxY9S66GjsuTrsJ7EEWVnPgKW5QeWWEd6M=;
        b=XzViPuk0JNTK/DMqzajkNrXS+zQYDgooxjN2LUh6yxoSAnt+/jHT51oCdDESeU9dRh
         B/zoMo+zaCEY+2vwxV1eln+5hs1R3g9L+yKVoi+nfl3hzg5B0eh81r+xrBoM5A3uxLWI
         e4pJvi0ezNR3J+w3e85uz/Wspfx6WBZ306mtGudY77ey8fgqAMdRYCqaSJLUrbC0/0aw
         zxeTDOxYA4jfNZS0nnvL0ILjTZQXRWH7KMvnWGuZKpxXgFXMvVEFqd6Kjg4usHOKyxNd
         UJxQSCjYt2jDX9NANcGTRI3VcPKhDw1yRY+Uc3AZlreXTNCvYe1L3KgffYwYJZlTsstM
         vxKg==
X-Gm-Message-State: AOJu0YwTbCIkplTmDgeQwiCKOIKtya8nJtF5LRq/2RCcMZ+mG4+GMldo
	9iw7lBgcKr3wY0V4qr7icfwb7TAXv29bkam7MSYQO9ChT+UpCJKU7l4B
X-Gm-Gg: AeBDiet6dmPbH+vQQMHylLIEv9FPag/aa80eOPFeySehJkPUQtYMT4zdESJWRvu1XOO
	sVlyYgCc3c3U9yXJiQY4yxsTeXbivPBIebMKGFsF0HIP5q2P1PV53+c22O36RDZ/JAv8PtBZzyA
	MboqU3cDk/VDBbELt3Hs8LYjzxNT/rAeTFFgT07my1IE814ghKrdAYEPYqxekDi9qHjL+fwQK+w
	4uQKN3fGizCjG7zL7U3Al80M0PylPjRX18ndzuA+fEax7V24NLW6/kdmFovXxcUnO8Zt/Kp8E8A
	5ZqwOehlm7TbnJOBWzA/cE7AwX2PV6tyuYNY4K31Sg7l9gq3fjG8kc/BxxLblfIgwSorXBkLHtB
	t0arYuCJpd+aV6XHDtEQNtfF9RD9L0AZcFHj3eVQFziFkAb21j5w6a3tHDg5iXnyAJIBcjpFNYF
	qLmET3yUqNcepc08ZcYRvOfxsSY2jpxXe068uBZTuOQJmn9XI=
X-Received: by 2002:a17:903:284:b0:2b2:5822:7a70 with SMTP id d9443c01a7336-2b2d5a63d4dmr223583195ad.38.1776272439043;
        Wed, 15 Apr 2026 10:00:39 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:48dd:8f21:beaa:cec8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4780ef365sm25319625ad.1.2026.04.15.10.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 10:00:38 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Linus Walleij <linusw@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	David Woodhouse <David.Woodhouse@intel.com>,
	H Hartley Sweeten <hartleys@visionengravers.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] mtd: maps: physmap: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 01:00:27 +0800
Message-ID: <20260415170027.3593563-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-238169-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[bootlin.com,nod.at,ti.com,kernel.org,gmail.com,intel.com,visionengravers.com,lists.infradead.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D388C406A39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in physmap_init(), the embedded
struct device in physmap_flash has already been initialized by
device_initialize(), but the failure path only unregisters the platform
driver and does not drop the device reference for the current platform
device:

  physmap_init()
    -> platform_device_register(&physmap_flash)
       -> device_initialize(&physmap_flash.dev)
       -> setup_pdev_dma_masks(&physmap_flash)
       -> platform_device_add(&physmap_flash)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() before unregistering the
platform driver.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 1ca5d2f0196cf ("mtd/maps/physmap: catch failure to register MTD_PHYSMAP_COMPAT device")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/mtd/maps/physmap-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/physmap-core.c b/drivers/mtd/maps/physmap-core.c
index 0dcc25b7ff98..6299a741e65b 100644
--- a/drivers/mtd/maps/physmap-core.c
+++ b/drivers/mtd/maps/physmap-core.c
@@ -659,8 +659,10 @@ static int __init physmap_init(void)
 #ifdef CONFIG_MTD_PHYSMAP_COMPAT
 	if (err == 0) {
 		err = platform_device_register(&physmap_flash);
-		if (err)
+		if (err) {
+			platform_device_put(&physmap_flash);
 			platform_driver_unregister(&physmap_flash_driver);
+		}
 	}
 #endif
 
-- 
2.43.0


