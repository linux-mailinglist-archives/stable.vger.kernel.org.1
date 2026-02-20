Return-Path: <stable+bounces-217549-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBLEFPEsmGmzCAMAu9opvQ
	(envelope-from <stable+bounces-217549-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 10:44:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E325B16661C
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 10:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 68696300DF4E
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 09:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71144325738;
	Fri, 20 Feb 2026 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIP/ViHz"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9B8326935
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771580651; cv=none; b=lZ7Vr4LF1XMnvKkWjxfSJmkbhR1KayU9nz++T4yiEqb7qBScWygrFwC2ya32kGD0A9fpxixJRuLNKQIhzVXWj1VlySJwwZEusKwbPpI4aqg0zaRFb251yZ+YUESJ1ohWZgaquPmS8zLxmmrQ6uCN6A9MbwOrR2c7mpN5cUCjwLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771580651; c=relaxed/simple;
	bh=JDc/qo7rkUOcZGNhJ0Wl/HeJIKj7/AleosrYhzqya/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6EcptY4vzgXry/VftSs4UOKRsGTIBFnDnq6KjTVPff3kxQO+icpMembYJH3L1PNJ6EGdNkmpsCnOxaBrjsO7nN8FyAJZ2ou9Hnx8uS+ILcMLgivVhL7aCdcu3CmaqkyOyF0t5aiKHWL5Glhs6AKZ0J6wC4o5+WD1QEcFwBeJPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIP/ViHz; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c54f700b5b1so1222471a12.0
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 01:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771580649; x=1772185449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxR8y+DDVU/sD2lLySC6/WbxsSmg5U6pRubVnyPkrSo=;
        b=FIP/ViHzKEoySA+q9ItRCihNG31XGMY/uZaszr6PQIz4OnswHSy+vHOjeOSgy90ozF
         nZxg88YqluZfE6ftU5ZAthG/WW3p5jmYydV8ivmBgq+dHOw5xf1ny4LDsxQtDF175Xn6
         UFYpFy6MqJHaolf5xpElflM94V5+lH9imZ1+sNH7zRElDZU2L0a/9GrEHyfGhl+EIVJQ
         U5mipE5Lglq4mBC5sk53sUZhNpf/tesxQWAlHrfZQCJtYoTmVaaO+tn2cQmOSkOtGmte
         Z8IZb7E+WtnSLvRfKsvOWhD/YQNoX5j7O5RsHm8AuLN8E22RXa8LyUuRi3ygeaOU70cy
         6T0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771580649; x=1772185449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZxR8y+DDVU/sD2lLySC6/WbxsSmg5U6pRubVnyPkrSo=;
        b=LN5czMTs2QY/42wO+GC2z4O82+y9mRsmvsZTjPUzfAMmlPqInmAMaSPx3UjmjvSow1
         HYmuWpoT6Zokup6RnT02AwlVmK7iU6ULbiA0uP2m9EoaQbED9RwBx8CyuU/4xIz7E8Jl
         nPbfJLHnEb++s3tqnr9/Ww47I+/sNJnSG6erg0/uPpFh7RH+ewKZkuHPKFYp2U9aOMSD
         DxoidVi9d9e3m/pRUVfYzkvfCQ8MOjpVvThEyqT0mHIV3PRJ8wmO1Dp3c6u0l1nwS7kD
         pfkyw++vlLa9F0jIpFhiY2TzkamCsPdraRzsjS6vY/6t+RP8Ah7qUMTy5D1BMdRXrqed
         V+Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVqG1yto6x0dYlajEQUImusGhkwHpA+TBVBGaGTFdnA1zolDmNDStLRSI6J5b2iU1ZsAsYGps0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfI6B68njerR0N3QfX81DAX1EoEn8b4yueuL3+RgCinB7Zjx7F
	bYmp8cZSqFNo/79Qf/huV9u0ccgqxsqpLsP9djViy17p3LbOuXC0YbmY
X-Gm-Gg: AZuq6aJECBMHvt/FizKpgFz0cYDkZJmVQ+i5aJ2xnTguAAQuXx2yv/VASkQdbev7QTr
	Hmb9Rs4YOh4edLMg3805xwW/pfakFzyNCDXQIMw5ob8dOwcXoxs8fZu5NRvTxyku+ujhWxUMyta
	f3hWzShdOUG/EyOSGatoCAYvn/5jJe4OgUn4AvLQ8GEmaKUKU5H6MElMLFQgPhRbxgzAMYNREUN
	BWBvG/2mqdBM2ZGf7JosLhkXTC4O9wAuAVahIqzhgdwnmtQfyUM3AgFB3W6rqGzbBko85BxkV96
	daotykbD8CU1njd4wVVqwxtM+qh4lnn9fhQM+q/2t7xfp4u4vTkG90ApMSqU5i9kfhNlkMdExZ2
	b1CLJgveuF+WCusJbMOibHoA3cIhpAKlA7S6p/8kvFWGn5oJz5ltvLd4ITpScLs+27CAjRrGTGN
	+QzOife7ckseJYXY5xwFgyEZ4lNGLZsQ==
X-Received: by 2002:a17:903:228e:b0:2ab:2bc5:4365 with SMTP id d9443c01a7336-2ad1747b69fmr212269585ad.19.1771580648956;
        Fri, 20 Feb 2026 01:44:08 -0800 (PST)
Received: from f0d65881db18 ([115.245.213.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1ace5e25sm185309555ad.91.2026.02.20.01.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 01:44:08 -0800 (PST)
From: Sanjaikumar V S <sanjaikumarvs@gmail.com>
To: linux-mtd@lists.infradead.org
Cc: tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-kernel@vger.kernel.org,
	Sanjaikumar V S <sanjaikumar.vs@dicortech.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] mtd: spi-nor: core: Fix AAI mode when dirmap is not available
Date: Fri, 20 Feb 2026 09:42:36 +0000
Message-ID: <20260220094236.28-3-sanjaikumarvs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220094236.28-1-sanjaikumarvs@gmail.com>
References: <20260220094236.28-1-sanjaikumarvs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-217549-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanjaikumarvs@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,dicortech.com:email]
X-Rspamd-Queue-Id: E325B16661C
X-Rspamd-Action: no action

From: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>

When the SPI controller does not support direct mapping (nodirmap=true),
spi_nor_spimem_write_data() calls spi_mem_dirmap_write() which falls
back to spi_mem_no_dirmap_write(). This fallback uses the operation
template created at probe time with the standard page program opcode.

For SST flashes using AAI mode, this fails because the template cannot
handle the dynamic opcode and address byte changes required by AAI.

Fix by checking nodirmap and using spi_nor_spimem_exec_op() directly,
which uses the runtime-built operation with correct AAI configuration.

Cc: stable@vger.kernel.org
Signed-off-by: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
---
 drivers/mtd/spi-nor/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index d3f8a78efd3b..7caeb508d628 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -281,7 +281,7 @@ static ssize_t spi_nor_spimem_write_data(struct spi_nor *nor, loff_t to,
 	if (spi_nor_spimem_bounce(nor, &op))
 		memcpy(nor->bouncebuf, buf, op.data.nbytes);
 
-	if (nor->dirmap.wdesc) {
+	if (nor->dirmap.wdesc && !nor->dirmap.wdesc->nodirmap) {
 		nbytes = spi_mem_dirmap_write(nor->dirmap.wdesc, op.addr.val,
 					      op.data.nbytes, op.data.buf.out);
 	} else {
-- 
2.43.0


