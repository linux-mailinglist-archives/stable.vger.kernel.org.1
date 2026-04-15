Return-Path: <stable+bounces-238173-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGXQB/3N32maZAAAu9opvQ
	(envelope-from <stable+bounces-238173-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:42:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C25A406E06
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8618B30091DF
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 17:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2263E3DAC;
	Wed, 15 Apr 2026 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBHfCfzn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F20D3CAE95
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776274932; cv=none; b=K1QyOWZ0i9fcuREDTaAewrqepzIMAEq4G0GaLfQOYaghynpuIcx58KXSGDyRGXpXlDldOki0tJNy3qSbFJ/G0k+diLJadTJyIEUpjqX0DjjVfUnE6I4wnC6WD5pKozorNeGAn1jrh6NaZmkqaXxgpkrT+qpVsNsOp/aPzXEoJ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776274932; c=relaxed/simple;
	bh=OfEpoQQCvbruyEEiVw52qe009gbsqV/tWcOBBRa19tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8OR2EPVdf5ztvFRgD7lZbuvF+LgDz+bXP/U/jGFUgQ03JcSNLq75lzaWJYoChr4jbJQ3Ef91AIWOf1h95U04Xe5X7/d88SSKAqsAuQvxGvoTC+upN26R+h5ntFvOf4K/+FiJZHYwWSHSDV4G5bFysUzmlBLYGfjX+m6OCs3XSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBHfCfzn; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2addb31945aso43017575ad.1
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 10:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776274931; x=1776879731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NJ/g0M6nIzsGKbX6brZJSUwMyF1dOX6znsTMtk5A1OI=;
        b=XBHfCfznBWOBlNUya6LVCeZPr/6rGOAwcS75+nsMKFYDSdAYZDnjUx1U4ynNpNCSyZ
         RuZQfPgey20aBRklXxX8gZCb8gQ/6DdhqRfSl22ey92r3CSm9zoXPVZ2e+z3aphfyOAg
         o+kVCRkS6YjUwc3O1o2RE4c/D+VOhK6+mOsG8jFftQSuIyg03fcgc2Q8J3OZA4P7F2Nn
         Nhi66mrEYeqy9wI06141OJ5sibnhs89hw20cvawm7wE9d3/AN/ln/ggMpimewVZL20g1
         vVzNFHwcwvp2EmBwekNFetxPoQgL9hkOH9yeMPXA04eZKQnqFL1UlY1hDr10/L8FLDO2
         dNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776274931; x=1776879731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJ/g0M6nIzsGKbX6brZJSUwMyF1dOX6znsTMtk5A1OI=;
        b=rNYsIRjXBAT5Vau660rR2bk+IEOqgbA4e/ZCB9xpWdd3UVBuTL7ktWH6/v6NR/zD+x
         fEuRYQLcC3kzbGuZiMsVIRV4RkBpBUOfGE9cYO0oG6YuN29d7oLzhJY4NM2SBdvSlNGr
         8YH0Gd5Lw7NErER3FD54T2P2sQJt5KKzWfaCxNOiAuW6roV6kysN/BGIVtpvJ2Ff+4tP
         bpcXzYa2XFt0cfwfn1Qm/1BazgyIaC+V7EsZfnvjgp64Mhpv1o1p+jeG335yWwZuB2Sj
         p48iZC+Rq2zX+sk1L3nDWJiLzNtl4TosK9MZ3sO42/kYhrVqa7CQ948N74zceR8nDwFK
         aC1A==
X-Forwarded-Encrypted: i=1; AFNElJ+flhebUDyw/tI3dvqDp15oSPu9pEyII/Jt5mHRgtrIhc+YT9w/B9ZcROFGU02KRzqt/cInA0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOiUkcDeiAktUwOhd9SVDv9GrpKfza+4IEiVJ3RwYN7h7iI3Rt
	0/CqkE6Iqy5BGnapm7qSpXD0aUp56OjPHO8OJnkcZ0SSKRyZqGS9ic2n
X-Gm-Gg: AeBDieughIveam9OLhmn3yuzWCoOCoD9WVbhGQg65kDwyUJxxqbhAUo6A3jN6UeqWPa
	x7CMKmiLl91RD79kf/4YOl/nYuVTJ8IExPLwXkJMLrORQG26H6UmuUTdJzC8kWjZ02jsQMrHv+r
	y4a1CKoJlUuM9BOzrnXjLM1hdzgHhJMbmldnnQ5/M1ccoDaJ1LbE13kqSmJ0KQWUvPX83+ZgnYn
	6LMPAfWlIsFcF82T8lpfjYGdEFCM4pzFZfJo123PDubgi8bU8q3ghJfs+4zxZt/cLFak4OrHX8Z
	G0krvxvnCjgb2xcA1bRU0KhCXbTZSfeMb39EjvcrwheGld+2koCRMWZsWGnKz+Flpht+A+6eAbr
	z45hgBQ+xO8imQWNKlausHJPfhpsUITsIdYJYHD8BulWD2yE2OoZnau8kU4SW9UCdCF/zrtflv3
	jcI/eJIQ4R3q4Wc4+yJNnD6PuU9bCe/Fp7yJAC
X-Received: by 2002:a17:903:b0e:b0:2b4:5cea:f61c with SMTP id d9443c01a7336-2b45ceaf83emr139663995ad.4.1776274930985;
        Wed, 15 Apr 2026 10:42:10 -0700 (PDT)
Received: from lgs.. ([2409:893d:1171:10e2:48dd:8f21:beaa:cec8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b47829a4eesm33777805ad.60.2026.04.15.10.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 10:42:10 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] arm_pmu: acpi: fix reference leak on failed device registration
Date: Thu, 16 Apr 2026 01:41:59 +0800
Message-ID: <20260415174159.3625777-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-238173-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C25A406E06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When platform_device_register() fails in arm_acpi_register_pmu_device(),
the embedded struct device in pdev has already been initialized by
device_initialize(), but the failure path only unregisters the GSI and
does not drop the device reference for the current platform device:

  arm_acpi_register_pmu_device()
    -> platform_device_register(pdev)
       -> device_initialize(&pdev->dev)
       -> setup_pdev_dma_masks(pdev)
       -> platform_device_add(pdev)

This leads to a reference leak when platform_device_register() fails.
Fix this by calling platform_device_put() after unregistering the GSI.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 81e5ee4716098 ("arm_pmu: acpi: Refactor arm_spe_acpi_register_device()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/perf/arm_pmu_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index e80f76d95e68..5ce382661e34 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -119,8 +119,10 @@ arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
 
 	pdev->resource[0].start = irq;
 	ret = platform_device_register(pdev);
-	if (ret)
+	if (ret) {
 		acpi_unregister_gsi(gsi);
+		platform_device_put(pdev);
+	}
 
 	return ret;
 }
-- 
2.43.0


