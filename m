Return-Path: <stable+bounces-225315-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OeMMV8YtGlkgwAAu9opvQ
	(envelope-from <stable+bounces-225315-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 14:59:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AD8284623
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 14:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 853D43070CCE
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 13:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B218838D012;
	Fri, 13 Mar 2026 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/qvAEqr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4E0390C95
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773409981; cv=none; b=YQji2qv7yo7fu78uNPYV6AwMkEPHy+IIay4Zna2ZoRYphgF44YW78pqQ3nwD1pDI+RPO2rS1IS7RBubZc43cBVMpkDYJvuA1WIA3KrtgHee4UEXJyg1/+W5Nz95p9+XswO4WrB7OFJupxhiTZSwfA2R3nQZjwVzcffAwiCrFojU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773409981; c=relaxed/simple;
	bh=l0zF3ej8aQms2XTunb0vRjXBt1VP0mDbI74gU5Fkie0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=arCFWWz1iWO113f4XUVtUknvaJYwlaZGmBV2ktT81NMR7OmHfHjqTZovSd20dZH77egLG/m7RfctOktlXFuN2d9SBscFVEZDDQRRLmWDSbpR16p+oxSw1qE0bFCIERSAa/NxuVIm9dKuyy3ScvyTNZdks5+ibYvd7jcbCK+Fa3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/qvAEqr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso19977285e9.3
        for <stable@vger.kernel.org>; Fri, 13 Mar 2026 06:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773409973; x=1774014773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dX48aVLfTgFvgth3UwNoAcH/+u5VTaLKWTUPbGKCPbY=;
        b=W/qvAEqrNLJfCc+Nn6Rmr7/Ar5Iq4HQ0V/tpYpizC+C3Z4Blr4Af38Um7UlKJTCUEV
         DBAL2Dg8wJXvqozJcLmXM6HlI3eSFCQVXwe5GXaSf/AtmIw720K83PxLjNdGkCM7a323
         YSyZUc2A95r1YON0pjCDEHOO5/kAikHZmpFX1zkw+fIAhJ8WGnOnPIbssjwpe32AmWcG
         O6WZ3UmTgAX+cyvYp0t0N6xAlAxEXWaeJCq7hBVxXca5isZ70jmSz5pKH3UzzrgV1OF2
         zLeeyJIqhtTaln8tbevWOc2d4ObQcmjumQ0CVGpF5YBLZtcKb/qatSWnwfvD16ugTRlN
         tfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773409973; x=1774014773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dX48aVLfTgFvgth3UwNoAcH/+u5VTaLKWTUPbGKCPbY=;
        b=i+qTLoXRwxmGUs/05Myi+Cq+VLS6cY4r9XUIe/lNWwjvP+BVrG8DGLhcfMpQto1mw4
         EYLIq0VyrSW60bs4p+1zlYIF6VKgbPYQb82XMCNwFdtD0VBrnd2VuJuFSth4wupur87j
         14+vzKJ9WFZbHLm1oMS+Q4JYA5CISF5+bg+Ng3nclVeOWUCepzwRhmpkPaxPCooXnz8x
         9LA8ze8rrM4GzArkEOmduHeg0D8rAVdo9+q8tNuL7gXf6WsDz7ANiNkUFdpUsuHRKBCi
         GoxYwB6sdhTHMDJZuE1AlhrJekGLr5Q0/Kqxaj8bE9cS+mDuNVHn2oL6M2rElev2TodC
         SKQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpb2SHQjUI6FTbQtilI15xsO6Nsa/hZuyByoH0V+XtrEC44aFulgemP7O09sPFNAEdqApxSl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcePGW7J76byTy6TJMxRAfrLY+Tt2KYXovw08oqfIINNAerc+u
	ZgyIrb/XqUkStqD+YkDoRY9fvuyDoE/sHydoap5ysplrhNU+YC8oa1Tf
X-Gm-Gg: ATEYQzzoau2HBa+ytm0BIH++yVVlufL1jPVvCXFqdcODN9o1fE3mBF93hXYyjLYRCtA
	u3L3xM+hELuJ8ht6kVcImBLOht/a8CBQ05znNjrCgchSeabgSE7UyzyDxj25btYWDpcP6eYebJK
	AuFW481wflbm1JK+z/hDTkMvj9oGZTBaIm0fBd3BqtrwZFjUgWQe3ovjGA1daExiOMJfLfP0AyK
	vZ3P3JtB9JyRTs5pYA3nhLRy+TbF3nRTARiQz24JPRrdmn1dSd9Bgo4bIUl3ps1IUHsSlsA7TPO
	XMlfYTK798r9pDIJMIPcredoDc3snz10sRcsL1RvOiXflRf64Ytub7DdlCJs1bdnQb8g0V8XQ6k
	bmb2XYAG3utVYTIftVs6ClV/gWuZzDVtCyVFX2IMkYDQEGKjeRnkEGxUX1tCfrxw+6094xWvbIY
	3KyIlliPJU8OyngPA7wbdY7P5p0nmKwrNk7/HvhGKR+G+Kgwl5YSVWBvjFVcCN0UJs73qV
X-Received: by 2002:a05:600c:1395:b0:485:2fc5:3a5 with SMTP id 5b1f17b1804b1-48556709d85mr52860705e9.26.1773409973305;
        Fri, 13 Mar 2026 06:52:53 -0700 (PDT)
Received: from emanueleg-nb.. (93-34-120-147.ip49.fastwebnet.it. [93.34.120.147])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48556414295sm39850805e9.3.2026.03.13.06.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:52:52 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com,
	a-dutta@ti.com,
	s-vadapalli@ti.com,
	mkorpershoek@kernel.org,
	khairul.anuar.romli@altera.com,
	stable@vger.kernel.org
Subject: [PATCH v1] spi: cadence-qspi: Fix exec_mem_op error handling
Date: Fri, 13 Mar 2026 14:52:31 +0100
Message-ID: <20260313135236.46642-1-ghidoliemanuele@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225315-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ghidoliemanuele@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75AD8284623
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

cqspi_exec_mem_op() increments the runtime PM usage counter before all
refcount checks are performed. If one of these checks fails, the function
returns without dropping the PM reference.

Move the pm_runtime_resume_and_get() call after the refcount checks so
that runtime PM is only acquired when the operation can proceed and
drop the inflight_ops refcount if the PM resume fails.

Cc: stable@vger.kernel.org
Fixes: 7446284023e8 ("spi: cadence-quadspi: Implement refcount to handle unbind during busy")
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 drivers/spi/spi-cadence-quadspi.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 5fb0cb07c110..2ead419e896e 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1483,14 +1483,6 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (refcount_read(&cqspi->inflight_ops) == 0)
 		return -ENODEV;
 
-	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
-		ret = pm_runtime_resume_and_get(dev);
-		if (ret) {
-			dev_err(&mem->spi->dev, "resume failed with %d\n", ret);
-			return ret;
-		}
-	}
-
 	if (!refcount_read(&cqspi->refcount))
 		return -EBUSY;
 
@@ -1502,6 +1494,14 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		return -EBUSY;
 	}
 
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret) {
+			dev_err(&mem->spi->dev, "resume failed with %d\n", ret);
+			goto dec_inflight_refcount;
+		}
+	}
+
 	ret = cqspi_mem_process(mem, op);
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
@@ -1510,6 +1510,7 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (ret)
 		dev_err(&mem->spi->dev, "operation failed with %d\n", ret);
 
+dec_inflight_refcount:
 	if (refcount_read(&cqspi->inflight_ops) > 1)
 		refcount_dec(&cqspi->inflight_ops);
 
-- 
2.43.0


