Return-Path: <stable+bounces-217719-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCPFHYwpnGl1AAQAu9opvQ
	(envelope-from <stable+bounces-217719-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 11:18:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4603174B92
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 11:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D710302DB72
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 10:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF9935B62E;
	Mon, 23 Feb 2026 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfAPOLYH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B436B34EF0C
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771841877; cv=none; b=NaJZvh04oaXYnG9edOYZQO5I6ZG21zz/kP7+megwmAnXTIJszW8SXKIBfZxJ1SgFFlSvtpnS+X5QGiYb34hIb+JI8ql7C2ICCREfbkqmoD+SDEvdxBRN+azanpdKlMFcoPA6onEhFbcSKwd17g/H+QOqxfgQjTvtQW6B6UWySq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771841877; c=relaxed/simple;
	bh=JDc/qo7rkUOcZGNhJ0Wl/HeJIKj7/AleosrYhzqya/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTzP+/Vx/oqhfxgcP9O20+ISJiwANX3OKovTK701nMw9UmdehUTvakgDBGGiWlJXXxvpzFDw8FS9mame4yKmhqh2NWG9aO0xxZRjFfO7Uox1stLMuKhi2DWgYbbu3uNTeaowcuTlX7tp8Ha58qnHdAuU3TNK6nyvb9DeoIlx8uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfAPOLYH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a7d98c1879so26689665ad.3
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 02:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771841876; x=1772446676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxR8y+DDVU/sD2lLySC6/WbxsSmg5U6pRubVnyPkrSo=;
        b=LfAPOLYH6/CYmyGD7y4Gx0nzk6YR60hu8x8bNhN9eHhmgHw8AKeWeSjbFYxfNGOF7y
         PSLRHi7NwZMGQNxMuzaeUQ3Bk5CtRIl9J/R2KUPpuksndQKe1+67t+jG16kpqYNnUYcM
         Vx+Mvx2zPXp7xSkGWtL121S0fuVWFkpWVJF5RBvVXbncaTyTV6EJreHK5eQpkChjKJjO
         E15Y7c41PukhNxqe4QThS9lsby/UeqSWovmDilGFYmJ+jhD3/n6asTMFJn8k5URXiBS4
         AMRMDX+2i8GocCiuRHrP54kNAz3UKQxG/OZK1GVSDj6hBuZFaY5prAxGvpAQZS77Kd5X
         /lUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771841876; x=1772446676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZxR8y+DDVU/sD2lLySC6/WbxsSmg5U6pRubVnyPkrSo=;
        b=eCP9OUe5m/gM8u/a9K9zXo2eEqBiMl1IntpXhJcyfyC7ea4E9kb9P5oqUczFPvETkx
         SI7Sb4oGog1Ll9XMV5zWpGQN+ZJCVVJDA6L9jF0vwv1DY17Blsa6lXuVniLsA9+tfHu+
         mdkwWmIwBvSgLvCx/Y6h4oYBM4fUO5eh8ViQYc6Kpfn2OjEB9zIzv8R/180UqhlKyd90
         F88bc9umQ+9DzJ9xQk0MbOvZ2gKtV2MtAF5FFnDLAxW2GicAp4WlQwek/kKE36Dn7e6M
         zDgSQHjt0SZGE7tvgW/N1RqvIGyf23BhwNdSygTegRNgYYuUBkAeRN2/g2OUxxlD2HY4
         dcJA==
X-Forwarded-Encrypted: i=1; AJvYcCUwpSaAl8tSrffoW4iDBXz9UFz3QsNpnLQDSr9fCoK13k8fGSbTo3eig7UPtRkVGpdbuSbgLjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhYPgg5Xk6TQqzfBN3keFVxSvkokLVm9/7Kspbq7ygWaN6gkut
	/gZPsueV7jldYbvzYpFyc60BBdPHwMmFCXx6sZen7FAgaYicureJOKYP
X-Gm-Gg: ATEYQzyp3zv8KN1LET90y4BourOoVK+f8hVxD1pImxBamcbenJJ7Eteq5ZYUknMzaK0
	aw12mCwfiIBsC2vdSUIEupoUT5+iLro/AkZD3HR4zUod9mGzOPSgH/V+9rrWEUWpZhJ383HOfpM
	bDIncIeC0BI2/K8f9Me8vhHgaY8dnjZN64FcRb26dVbyZva5OJ7/qmPaYunPjOrYXxSioML8ev0
	d4NUfbwfsbAYWL6idb37XO5c0LnKaFb5yE/DnrKeW1zekGF9uHMtqq7HQpDq55Ss0kgCoZiKmwp
	G/EjrKCLDeZB9fQW0gyVyI/SrlbgheRyeYF1+Y+ehslnZilSWw5AYTfeNvzRB6zCnW54ZPryl5O
	tNSfj9/zgfAX0ujYqaKMaD41Kpq7/nATUOcxOcw/ojWwe5NAGDng+ItzvhAT+HvLVnNmHeeuT2+
	VeO2KBiT1AZyF+X+VvuPBp76oFvLa/UQ==
X-Received: by 2002:a17:902:d4d2:b0:2a7:c2d5:bcd7 with SMTP id d9443c01a7336-2ad74464b22mr67997785ad.20.1771841876019;
        Mon, 23 Feb 2026 02:17:56 -0800 (PST)
Received: from c6dfb3cc7c9a ([115.245.213.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e3425dsm66574795ad.16.2026.02.23.02.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 02:17:55 -0800 (PST)
From: Sanjaikumar V S <sanjaikumarvs@gmail.com>
To: mwalle@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	miquel.raynal@bootlin.com,
	pratyush@kernel.org,
	richard@nod.at,
	sanjaikumarvs@gmail.com,
	sanjaikumar.vs@dicortech.com,
	tudor.ambarus@linaro.org,
	stable@vger.kernel.org,
	vigneshr@ti.com
Subject: [PATCH v3 2/2] mtd: spi-nor: core: Fix AAI mode when dirmap is not available
Date: Mon, 23 Feb 2026 10:17:18 +0000
Message-ID: <20260223101718.89-3-sanjaikumarvs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260223101718.89-1-sanjaikumarvs@gmail.com>
References: <20260220094236.28-1-sanjaikumarvs@gmail.com>
 <20260223101718.89-1-sanjaikumarvs@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-217719-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,bootlin.com,kernel.org,nod.at,gmail.com,dicortech.com,linaro.org,ti.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanjaikumarvs@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dicortech.com:email]
X-Rspamd-Queue-Id: C4603174B92
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


