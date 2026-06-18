Return-Path: <stable+bounces-267205-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id khc+CrVMNGroUAYAu9opvQ
	(envelope-from <stable+bounces-267205-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 21:53:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9606A268C
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 21:53:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PgTf9jMP;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267205-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267205-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29F523038A54
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 19:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF3130DD30;
	Thu, 18 Jun 2026 19:53:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B8F768EA
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 19:53:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781812400; cv=none; b=cikLc7sHGQf/95DXohf3qjGkeCKSRmWQ4aM/GfZbul0xeOFINAnDH5HfPXTQQnCW52ohKFTQeRgislPuVYUMRFt9zh9+uFicU4QhciWFEZkLRBrlQlz76vOTLxdJYz2pUDGtGLl5Dzr5e+Xwc91J1VN3ctze1eqszX/r0T8xr+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781812400; c=relaxed/simple;
	bh=3qqsyfjpM9/WRyC3/l/UxcDv8AfMx+TXJz4tBulEa8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dh2aAVS0huiMI6n0djjlpbTsyxaLbpOI6y7Nu7iMMXn35sLJXHsmuWo3fTs12xqica/wYwrNoBN0xHrSa6EObwOO+rmKrF58EGGGkJf3jW9e1QzoE3OZ13bACTNW6UEsCqAh3yKmF094c9kaoKuf+LYVJBIjizAcue12YmehYK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgTf9jMP; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-462342ac290so1573952f8f.2
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 12:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781812397; x=1782417197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o29q2K6kb6pkDLTzz1pOhi24t9YwzsE4xSo339SCl4A=;
        b=PgTf9jMPOXf98+euj6zr4ePCk6+EyYtuI8DxeEwZOAVnW3wjIGNNDdcA40DtbWC7Uc
         LDMKXMrnhftBvFw91zjs/BdhAenvIlhEWZr0KpCALMMFkV/pZ8UUQJ3ShsaO/LQbU6I2
         GUmM8Iml4k3YqyF0eKXzWbParN+tU8F/75n6x78wp/TsiHG1z7U7NVCZeeWqfpXXd8ZS
         9JNBnbUzYzPZZstzl5eGyW9CDseEx39Zb88lCOMlPXWMfXOSh4mB/+qV12HqZEX4rSbk
         QYC8kEcUCGFnJwy0dFyCo6Nkm/fNE5S2g47CSM1Pam/5DLGdT6k1avTDd82WbQvokup8
         uBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781812397; x=1782417197;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o29q2K6kb6pkDLTzz1pOhi24t9YwzsE4xSo339SCl4A=;
        b=cTP5314T8uRtyekJgF4iWbzcWdDcflcQjw6a8L6IsXzu8q2S5VATF2J4GApAeC16Qa
         gJgPAN5FLLIIGMghR11EtNZ0ZZMezNcq70/voGm3CpLwt4LKmRZlsFiNOL94ad3rwSIV
         T22HkGJvHULxGy/R5Si81FFvGcbYIy+hnJ5CezFUCPghQL0OXg2aei+B28ffYUbkVIxu
         ODPZIWAJT7XNSXk8lgmW+zUOw71H4rjR835RHgRgWZ2QVJipTaworywkTq6Jjp0DM1lP
         YzyleBNRmaWC6/K4UISqUuhJ0iGvRRmBqRX05XvE3t9gFLtffRCB28cZaxFOVzUVflM4
         vndA==
X-Forwarded-Encrypted: i=1; AFNElJ+P44i7w3s64unaaslUBZzjYo/DteK8dY31KD4wpVUgM/+Ds1zP6frNegZjZPTBjaYHkOFI9SA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0dEWXJV/sBoLBntZOy+7s9r4cBZbA1S9mRLWfoezRPRtgAxqS
	CSOM5aWpxtVJ3gtT2/rfiDCiOr4UPNJB6/a1lpIlx0Iq4FfMSX59DPGv
X-Gm-Gg: AfdE7ckJAHnyWYwMq/gzyjcrXdvhuwJUyEIwV/ne6YuyX8BB5rFmZMTqE/2q/Km9u8u
	Oy0o07Iz1oMjhSKuY8irc3oSJ7d1ugq00wJadbnWLWsHaO0ead1QU+zAbVnMjf5E+v+dBB/Dh73
	sFE9XRv7IJlIcMiOMrU9Bb6unpuy8EGp5uy7LYkGA76KUxnll9HV6UfD1aQtu31xIGWanIIJyX2
	4YWBl+qqkoKBlZugu6K/1M8ucih6XPRVBa76685U8H2yhAF/AXMRHDwOXWaylzMolA8yl+YCX1m
	CN6mgJfWjB2IFEeKxUJm53PCYxLcmREDRUlZnRAGgonuh2g5hKBoidQ5CwiuhQ+PUJXIflWhBd+
	sYxSUOhs6ixMuQaPt8sblg51aRFisngwwZH3kfFK4lSoQH1i7U1ELJ0Z9G+AARci4zqQu/70tij
	f//gp8yptMITEOVp1SGNwZPDr9Gq0FKB0esh3fSOkaxVgQQnX05vCV74ENK0oMRB5IwE9mzbQu
X-Received: by 2002:a05:6000:18a3:b0:45e:ec27:b4b0 with SMTP id ffacd0b85a97d-4650043991amr1665603f8f.18.1781812396929;
        Thu, 18 Jun 2026 12:53:16 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4650bc41d01sm1288198f8f.25.2026.06.18.12.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 12:53:16 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Daniel Scally <dan.scally@ideasonboard.com>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] media: mali-c55: Fix scaler factor overflow for large crop sizes
Date: Thu, 18 Jun 2026 20:52:54 +0100
Message-ID: <20260618195254.139712-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-267205-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dan.scally@ideasonboard.com,m:jacopo.mondi@ideasonboard.com,m:mchehab@kernel.org,m:linux-media@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devnexen@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C9606A268C

The horizontal and vertical scaling factors multiply the crop dimensions
by MALI_C55_RSZ_SCALER_FACTOR, a Q4.20 factor of (1 << 20). Both operands
are 32-bit, so the multiplication wraps before the result is stored in
the u64 scale variables. For any crop dimension of 4096 or more (the
maximum is 8192) the value overflows; an 8192 to 4096 downscale yields a
TINC of zero, so the scaler never advances and the output is corrupted.

Define MALI_C55_RSZ_SCALER_FACTOR as a 64-bit constant so the
multiplication is performed in 64-bit.

Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---

Notes:
    v2: Define the macro as a 64-bit constant (BIT_ULL) instead of casting
        each multiplication, per Dan's review.

 drivers/media/platform/arm/mali-c55/mali-c55-resizer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c b/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c
index c4f46651d..6706939b4 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c
@@ -15,7 +15,7 @@
 #include "mali-c55-registers.h"
 
 /* Scaling factor in Q4.20 format. */
-#define MALI_C55_RSZ_SCALER_FACTOR	(1U << 20)
+#define MALI_C55_RSZ_SCALER_FACTOR	BIT_ULL(20)
 
 #define MALI_C55_RSZ_COEFS_BANKS	8
 #define MALI_C55_RSZ_COEFS_ENTRIES	64
-- 
2.53.0


