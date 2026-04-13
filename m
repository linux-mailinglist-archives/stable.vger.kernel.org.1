Return-Path: <stable+bounces-236090-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCU+EDfz3GkvYgkAu9opvQ
	(envelope-from <stable+bounces-236090-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:44:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A302B3ECAEB
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02CE8300C7CF
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72353CE499;
	Mon, 13 Apr 2026 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEV2kVg2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7B1382F1C
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087844; cv=none; b=XLA2K12Sfj5aIJAX4QelyTcGTRHDFmmAiY2S2SEaNVbVxSy4ixH+OT8JOAMqxmVnpL2d0n4xYPPUGSQXxCwhJXz7mWJR0/ERX9IGZX8dLf3L2qF+j5EBQIPW0BNcFg+ygOtnLmoHdTvCVNA+m8PsIgayVgRoq+JmYEQOZVb+NQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087844; c=relaxed/simple;
	bh=V14ZCWON2p63vUUtG28yyk5VGhtMVwJXrepp/6rwLYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MdztgLX1rGFP0tHIQOM/WP6eGemzIo14pwlV0z4O6nVEoq+9Fz9WfTCWFlTJnXtaUHFx+daJO2LYTsLcUlj3CR70iXL82Mq1ZjO9V6hCfdlNCroRY2tdIyhZOA6lGWa+pngMcUvK5DVPgRuuDKbUDrBDyxzkgBZSzkII/X2w9l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEV2kVg2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82f2766905fso735039b3a.3
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776087842; x=1776692642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7W9JynenGbsWsUxegkWWGHkXpA2s8st+nPT0ylLSYvw=;
        b=FEV2kVg20DSEaQukWY+U0KCTrl7TVyQSzVR4iCysQLs2MjS4f7VHQdVx+LgkbuYq2D
         26INZRPH8MoRk0thSJ3QYJsCI3e3IxAC23pp3jxZ0vH2mqi8b8v2kPn5gRV3DT0HUhDg
         zyyaPVYp2fkfcMunBaZasTiRWBQ6DWMiOpP4cpXCmbPyeeKAE1nNKLwsJA2tANzN3x8V
         iB+8UIEbKVww5P9RIcOfU78we6gkU6DNWAcg9Xg8xNdcBByVT2wsuVyBgIhHpitKmFQ1
         l+QRKaVzCFShfi1AavAc0my0Sl6byV18D+CZ4pte+ghNZmsJTid+cEbK95wozLDEC0ZV
         FLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776087842; x=1776692642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7W9JynenGbsWsUxegkWWGHkXpA2s8st+nPT0ylLSYvw=;
        b=g14TInYIWXUUdUmFMn8dGyO5iZn7eQv/cu5mdb71NClETMnmRbXkQiYKxufAc61h2G
         pbLbt4rOcF54Cd17xW5hzR2VNGOagDpkP1IWMAo8BgpDdCB+QlfVJ5Oq/Xf/8MYCd52s
         C2W3NJZMCsOGgNaYQ8utTwhCj9kDPMBc5Y5EMBNstHaXSMR6f5CSAoDLgCKGjAssEnOI
         MM9YzqdiCbP5OzneLgM+9BSQWDmsJ6EcESGY8VZVj89nXl/py7KqghTnpznEG7Kzj360
         lwn4dGmXVmYo+BdsT13LUScsWg/KxOht2+N5Du789m5oez7KJANCSzqNFOvigcoDuITl
         T9tw==
X-Forwarded-Encrypted: i=1; AFNElJ/yNgTp47ZSwuLl8eu2Mg6jVqMcg5vE/39Hi723rkRNNDgIbCzYCiCT+y1BCDKb7U6VsFXqC+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKrX99FqLnrnW3SME/5QwQU5p8K1U8SdR7KEmVdxrBwGPMiVAf
	A+OwHhhs1W+X+zJTZy+WXUqDu93U/gJZPLqWk10m6HLzPMRFcrNyKLKK
X-Gm-Gg: AeBDiev0aWQtFok0cpttdv3I2vw2C84pMKTE7vK8Cpotz07RUatQABa5kUGv/IAdlNP
	PvHp7IZbGfbRADtxNKneJiUoOhmEvseUJxQn7y+xpxARe+ZmZP0n6S/2x8ITCxCyfXdcvU024VJ
	dvCmQpjZ/EK+yUbQ5QjIf4ZPUmJLEM6fUunoR8mVNTqO5MHmaOA5yLMEQhnCows0Hq557jkfiFo
	OxqZhk310WoKDDPkAGP9pXv2svpWq8RcumwQiG9z2GJrSokrOxD1VRCNRm0m2CHxH2goF2mt3Jy
	VE9pdwz42oyMUYOW4mudpf6S0XHIyE4Y91jm8y6UgrypSYLLvjVZbbTr9XRyZa/p8DI6rK3Uuai
	F7JSs5iOk1BxHANZadvDZ7pDvdVRMDdJHGRJM5ey756sEELgwu3PfXlCrYnOOHJ1lnWVa9OEIvh
	cHRjh/QkNbKN2R1gOjxxdZVlntb5KP30I=
X-Received: by 2002:a05:6a00:aa09:b0:81e:d18a:489d with SMTP id d2e1a72fcca58-82f0c324ad0mr13936407b3a.42.1776087841672;
        Mon, 13 Apr 2026 06:44:01 -0700 (PDT)
Received: from lgs.. ([2409:893d:1188:142d:6c67:74e8:5200:1f39])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c33de57sm10951065b3a.21.2026.04.13.06.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:44:01 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Stuart Yoder <stuart.yoder@freescale.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Graf <agraf@suse.de>,
	"J. German Rivera" <German.Rivera@freescale.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] bus: fsl-mc: Fix refcount leak in fsl_mc_device_add() error path
Date: Mon, 13 Apr 2026 21:43:44 +0800
Message-ID: <20260413134345.2855417-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236090-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A302B3ECAEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_initialize(), the lifetime of the embedded struct device
is expected to be managed through the device core reference counting.

In fsl_mc_device_add(), all failures after device_initialize() jump to
error_cleanup_dev, where mc_dev and its associated resources are freed
directly instead of releasing the device reference with
put_device(&mc_dev->dev). This bypasses the normal device lifetime
rules and may leave the reference count of the embedded struct device
unbalanced, resulting in a refcount leak.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fix this by using put_device(&mc_dev->dev) in the error path and let
fsl_mc_device_release() handle the final cleanup.

Fixes: bbf9d17d9875 ("staging: fsl-mc: Freescale Management Complex (fsl-mc) bus driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - note that the issue was identified by my static analysis tool
  - and confirmed by manual review

 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 25845c04e562..6d132144ce25 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -905,11 +905,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 	return 0;
 
 error_cleanup_dev:
-	kfree(mc_dev->regions);
-	if (mc_bus)
-		kfree(mc_bus);
-	else
-		kfree(mc_dev);
+	put_device(&mc_dev->dev);
 
 	return error;
 }
-- 
2.43.0


