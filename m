Return-Path: <stable+bounces-242982-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGt0MOdw+GkYuwIAu9opvQ
	(envelope-from <stable+bounces-242982-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:11:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8964BB7EB
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 12:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CBC03048DD1
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 10:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A735B392820;
	Mon,  4 May 2026 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKW7JyjX"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C118390995
	for <stable@vger.kernel.org>; Mon,  4 May 2026 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889343; cv=none; b=Hcey5sYcm6jnAUE6IeL6BUPKNGFuHgOgNhD/cIfAqACmT2/RIdUzKGCbxRMj6TMb6pnc9ol+Z7mKLTohH1OQ/bUWNNMsXA40FRKRveUBTcEG8P83F5frEpgl3Dqc0qZOD8hSEb9cta8UbhhHg0iqqQGis1R5C1B7QC/pUW1lw4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889343; c=relaxed/simple;
	bh=pcbrlB3qHsPLc/y90rnx1LrG5b7iFx58tWFuf97lMZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAh9ABs0/qo+SucsvU6B597sdkGMtC4iNFFIPbDK1Udv3LC1lfsTNu6wHG1OEldYfOjYEzWAVIH8TYSqLx7//Ok66Hq6o6Gd+NftQvwhT1A7irWyrTrJhCqppzLx95eGhbqZKqZPlGLyKt5m5Zjri2LJUjSbUQ9y51sOkqUJaLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKW7JyjX; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a748d5ece4so4262510e87.2
        for <stable@vger.kernel.org>; Mon, 04 May 2026 03:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777889335; x=1778494135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUsuLRSeuIGkFfh6WNuAvk/R1MMvm5m1C1zWcRocwNE=;
        b=cKW7JyjXHGgh6mBa2l2a8jd40EAX5sw0SGAXxqQFYZFMqJLhudJJTojaBfnSJUqbOj
         w5BjRfybVM9L6dC7Jn/+Fkr4jsvL2/n2vqEB2P7MnRuuvnPtdWQzhptnWBVXuNYPbuap
         QOJY22o9bjxeYQ/k7Ftl21S5SQ1yv2kvkR9XDaWmQ+OhGLe/1p1jd9Cvc76vGcZa4TVq
         ZXdrTu0iXq7rlQK6IXjslucJviAi+WgrTlB31XjBOeAUXeJmsfXDuilGkZhliM4+ZHmW
         a/LNpYwKlfvwxDEX4MWlQRzxFzDLQPJ6R5LzP0Vjdc6prrrAnhzAaLdwOo1bmt5U1+0P
         STxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889335; x=1778494135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fUsuLRSeuIGkFfh6WNuAvk/R1MMvm5m1C1zWcRocwNE=;
        b=sGLCoB6rh4xWpmI9c58GVOjlkTo7yYl4YWUgiy6y5jH398umUn4IRPlb7to2jeB/Of
         +ZCWm2YXoA2MEzOMuPQQAeAg68XqSjrXiVPOjJO+xA0zQAGEvl9GOrEWPcvRdCKGHJXA
         DUthcSAEx6UIkyDpujpqjCwNmA+t2O469GvgUjWF/3H0ni3VhfMcE9G9r0ltGod0pKkz
         2Ry2sa9O22GG6mF3ilU5lnyGXZHYGlUKH35trHUglaGITaF6jEVrJfeX+W9E8+kUUNc3
         yXFuxigtUk4HmafCQIdnpUJcNEyBLsEgQuEHrL8oINc/enMnxPqg3ioxqGEN/TE1O3ec
         lptg==
X-Forwarded-Encrypted: i=1; AFNElJ+q8h2HE+B/6sHv+QmFubPDmwmQHuvgLHv9QCt1P+ssz5XharyTl5X4KSl8YasYvN8/o9vVqTI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2lMjDB3/087ZjZ2GbPDnArJRyDkrlhjrqeKlnPXhmWXKEQdLd
	xxqmLSWudhskb9miVb8gkTpzzG34JvizO1IMwgeBFjPv/n7tIEd7crtC
X-Gm-Gg: AeBDietqL8TYOlBfJ/wRoCGuZ+TqYCFtU8Kqw42JAUn73ImpS/SunuB8UJIuUnj0LqA
	puKFq8Kby2qaSIMkLtGuv3OTYO65k/p5y75jKnfVYUPZ2sAL10VpWI/4ZxtWF3QkCrXjFM2Bxs3
	mKjAzCkxa+IbDuJ79RecJQ5aDSHuU3eaEVB+nAgoF/CB9hQRgz9ktYGET8Sh+moJz2Kwj+dSF6h
	tod0b1y+2RPpQs4r/vUXOuqHRMlwRpIUmlG8aFjelA5veTf5za7ZvksjIC78eMhptN1X988KBbR
	dLHKmTWMDkrBWjc45Y7WQOv1IOFA/MfNgf3UQk9CWTSUlG49SiXgWbIRwibB/pxXlWzpObd51Tl
	eIQS79B7uNJgBYZRM0luJPl/Env2kIO0wQAKOd6i2wo5LxY0qVU8ucpa0KdLLXflOEiysUAsDH5
	bh3PHPzCLe6lxXy9h3TVx5g9L+4lA5ZP0R496CN/8cdd8lQVUYL7OjkjjGrXkoVpo2GNogUdA=
X-Received: by 2002:a05:6512:3c8a:b0:5a8:6ba2:225a with SMTP id 2adb3069b0e04-5a86ba22265mr1869874e87.39.1777889335210;
        Mon, 04 May 2026 03:08:55 -0700 (PDT)
Received: from va-HP-Pavilion-Desktop-595-p0xxx.mshome.net ([193.0.150.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a86645ae7csm1979099e87.79.2026.05.04.03.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:08:54 -0700 (PDT)
From: Vastargazing <vebohr@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Vastargazing <vebohr@gmail.com>,
	stable@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 4/5] perf: arm: pmu: fix reference leak on failed device registration
Date: Mon,  4 May 2026 13:08:46 +0300
Message-ID: <243cb3737b41fae32a09117c17809a210395e69f.1777889235.git.vebohr@gmail.com>
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
X-Rspamd-Queue-Id: 6F8964BB7EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,arm.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-242982-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vebohr@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

When platform_device_register() fails in arm_acpi_register_pmu_device(),
the embedded struct device has already been initialized by
device_initialize() inside platform_device_register(). The error path
unregisters the GSI interrupt but returns without dropping the device
reference:

  arm_acpi_register_pmu_device()
    -> platform_device_register(pdev)
       -> device_initialize(&pdev->dev)   /* kref = 1 */
       -> platform_device_add(pdev)       /* fails */
    <- acpi_unregister_gsi() called, but kref still 1

Per platform_device_register() kernel-doc:

  NOTE: _Never_ directly free @pdev after calling this function, even if
  it returned an error! Always use platform_device_put() to give up the
  reference initialised in this function instead.

Fix this by calling platform_device_put() in the error branch before
unregistering the GSI.

Fixes: d24a0c7099b3 ("arm_pmu: acpi: spe: Add initial MADT/SPE probing")
Cc: stable@vger.kernel.org
Assisted-by: GitHub Copilot (Claude Sonnet 4.5)
Signed-off-by: Vastargazing <vebohr@gmail.com>
---
 drivers/perf/arm_pmu_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index e80f76d95e68..c2defbc32ad9 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -119,8 +119,10 @@ arm_acpi_register_pmu_device(struct platform_device *pdev, u8 len,
 
 	pdev->resource[0].start = irq;
 	ret = platform_device_register(pdev);
-	if (ret)
+	if (ret) {
+		platform_device_put(pdev);
 		acpi_unregister_gsi(gsi);
+	}
 
 	return ret;
 }
-- 
2.51.0


