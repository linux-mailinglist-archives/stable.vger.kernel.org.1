Return-Path: <stable+bounces-238203-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mlxLBHPo32kNaQAAu9opvQ
	(envelope-from <stable+bounces-238203-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:35:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 583D9407649
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 21:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6860F307C854
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DD6329C60;
	Wed, 15 Apr 2026 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoOVbzhf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0555D1DED40
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776281708; cv=none; b=SruSViGrXliWDXLLn0eDC0tsOK5sf0KuEi1rU9WKYkY1Vc41imvtyq/NV/fUmiuM49ft+VCErW9Ylw1fYPMk9wz30i01sOsRvfkrJjNnqfa5WaNISYkZtq+i4afNyk/aTW49OAl+HuFpuNSjC1rGzz7XXxL2LUUYS8F/B6NQOVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776281708; c=relaxed/simple;
	bh=QKiuHytyr5W0ReeO7ZYtKETgmvg/d8OewD1s8ol8EZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h1ZnNm/mYtxDenVyjE+WNH9h5iP8pyDsnv5OeQMGvfS6jW3xsQImvt0n5PC3TZxmwBjgUYaTFK40AbGoDzrfVS2ux0Icl5NxG2oS93tvzXorGasjJtntn+pwhYBdT01XaYke1H/eiEyUTEV0Z/550to0hXD/DYvgleK/IMMwQdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoOVbzhf; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35d99031e4eso4234287a91.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 12:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776281706; x=1776886506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hNsRiK7vCQLT5zngArE0NDO8in1o6VglpgtkmLZqYxY=;
        b=XoOVbzhf/2LDbyO954CyaHpuxuFUxioOLliKeV7lwE1uNZbESRtpZR5onuM6+VQEWl
         NGarltyb5QDtu106AIriTXDT93CWqRoep+SyXCeFu0wEcVYNmM+C/hqIj7s9HViQnbp0
         djIVW5wu/1hbBFlfUcRRVKsH3LN7SYMYYPwXN/sAQDsNsh+wcc0wfgi5TQ013Nr8mT+E
         OC1uTRWn6JyoYyf4uR2ju3Q3MXSud0aMHeoYK1J+7NvVHejPOUMOlVuqv+y0QQLxo14w
         bHjtHpPRT7mo1gL+kP/yN7m8RHSk2MyXfRiLztPYBoOAcr2TP0juurICjQobkzk6tAuH
         Xexw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776281706; x=1776886506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNsRiK7vCQLT5zngArE0NDO8in1o6VglpgtkmLZqYxY=;
        b=UDmtyGLxQGtm35bvZGKYrvNzN1RVlP7Ujc62hDjzPwzKurKf95gdNg0j/d2T0yHxMT
         N2oytIhIFs/pvuCxnaGKSuPlPK2ZMjyWkqTtYrGFx7afeLqnPrejvfwW8RYHnux02r6t
         XelvMP6x8s/jUH861kRWzwyeu4ShCDSK3al1VHP6qGXRXqoSuCMJHH8S5szhSi9bR5vQ
         bT/fpvo4XGEo5gYbx/dDPk7tPTO93rilXImbzUIoUKd7vYGq3G4M0KUXIAb8rhjkThKA
         33CK8gklNFhJW4ZjSZEOv+ECQt7zQtqsDHtZi3wraMarKR+h38YQYtEoLhK0erU/VoJz
         0rUQ==
X-Gm-Message-State: AOJu0Yxsu31wpXvqlTaJdb0wwWJvvPApCS5hpusGGZ6HzB6ug5sXD+sY
	Usn0pB8uWM9SUK0MGbhb8hAjzclfoLwnysLiAC92VpKkyKAA4yttpmim
X-Gm-Gg: AeBDieuzyxCmmQvc9oNv44J323wzHGnK5biI/ycPcf/GzonkeXjr1ZXi4lJ5WWhhtOt
	OTt/TTnswKJT7SQCoKEEvt+jOvXxDTdENlIAw2+MjnPVB2ZktzBorm1cn9Re0YxK2RCDUK/cDzR
	VflEvKRPZf4D47BQ7ro+iZoE4YxPK3+yKxeq0vnqnaWRic5Re20c5SN+aEi8keY0OKJYHzBjy+D
	Nt3j5tGdfl3a8aqd4wetZzUbXQKI5n5cULAH5cYIRdsSBUNSelCv1qVEaBGk1htSnKc8YgN8dW9
	0bacFO85KJIrXYZUPYgUQjB/X/+bOhrZttHNDsMUAmVIufishj0ONHBl2/PWCLXAIhHymwSEpPt
	XQoLwWOIei0Q3nsUQuzH/W1SF5mVx+lnMfe+2uU+j2ZQPEEKYNAkmG6Vh8bYg+M6/viwaL1Ptum
	gNKL4/K4xXilgqdCKIl85GnDIO0IyhjjbPEdE=
X-Received: by 2002:a17:90b:1a91:b0:35b:e4d8:e21d with SMTP id 98e67ed59e1d1-35e4250f263mr20794094a91.2.1776281706281;
        Wed, 15 Apr 2026 12:35:06 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:93ee:194:b07d:a9b2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fd1fe9fcesm3198430a91.2.2026.04.15.12.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 12:35:05 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stas Sergeev <stsp@aknet.ru>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] x86/rtc: fix failed fallback RTC device registration handling
Date: Thu, 16 Apr 2026 03:34:55 +0800
Message-ID: <20260415193455.3869807-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-238203-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,intel.com,gmail.com,linux-foundation.org,aknet.ru,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 583D9407649
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in add_rtc_cmos(), the embedded
struct device in rtc_device has already been initialized by
device_initialize(), but the failure path ignores the error without
dropping the device reference for the current platform device:

  add_rtc_cmos()
    -> platform_device_register(&rtc_device)
       -> device_initialize(&rtc_device.dev)
       -> setup_pdev_dma_masks(&rtc_device)
       -> platform_device_add(&rtc_device)

This leads to a reference leak when platform_device_register() fails.
It also causes add_rtc_cmos() to report success unconditionally and log
that the fallback platform RTC device was registered even when the
registration failed.

Fix this by checking the return value, calling platform_device_put() on
failure, and only printing the success message after successful
registration.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 1da2e3d679a8e ("provide rtc_cmos platform device")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 arch/x86/kernel/rtc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index 314b062a15de..4761c5b0234f 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -139,7 +139,11 @@ static __init int add_rtc_cmos(void)
 	if (!x86_platform.legacy.rtc)
 		return -ENODEV;
 
-	platform_device_register(&rtc_device);
+	ret = platform_device_register(&rtc_device);
+	if (ret) {
+		platform_device_put(&rtc_device);
+		return ret;
+	}
 	dev_info(&rtc_device.dev, "registered fallback platform RTC device\n");
 
 	return 0;
-- 
2.43.0


