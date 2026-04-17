Return-Path: <stable+bounces-238499-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPUFAsVQ4mlt4wAAu9opvQ
	(envelope-from <stable+bounces-238499-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 17:24:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D9F41C947
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 17:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76524302C1FC
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 15:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E044530E84B;
	Fri, 17 Apr 2026 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SaLAiSti"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AE930AAA9
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 15:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439485; cv=none; b=ZcQcjP1dC5/2aQVMyNxxNFlqc4GjD0jpo9Fo1PAZvvGtCW8yOrkwubYSS6aPN6ryR+s47zKds81f4ZrDaKEi3bvktowZ+Zga6cD51QC+5rnx8Hcv0BzUUVpEQa3Cm26cBzrtPgE/0coQ/vUHGDN0pLGYmwIXJgcWhN6nvo4gc+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439485; c=relaxed/simple;
	bh=tPwzxOzm9uakxuwTOcaC6u3ngixwWgQyrsHL71YIYTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GaZkgB1PFG7vC1Ix1C56v5QtHk9QZVGty/o6D+PmSkgab0j2Uk6Ji4Fyn0QIcAh6wROLDORnUA0+q01SWbioy88IDDtMmUazrrwvp9neDB6o7yJaAuBCAteZm9Cj4v++uOBMF8S54DGLS67viGreQ4XRBPLZzmioxNyaU9FYJYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SaLAiSti; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b8efed61so8900645e9.1
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 08:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776439482; x=1777044282; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q2bC6Hz2MAErwrJ8lu8pBzVTd3KLTohmvccUkPb3vXE=;
        b=SaLAiStiECNPVv7hzFxEBOqpcT1fiu+DRIIMCNwSpG3Z5wFFMg57jhEbP9poaD8K8i
         B7/GaVuSVDqdFrRbOj7EVgZ3aWEPB7T4g3L0A3mPc16QkXd1YfPxny8/rsUWDswmQRgP
         /vyldmqxhu8XMKjqwdboBN01kHSXBiiPUtk8cqucxXOZccCZja0Sw3dblmNNqgQ+xFT3
         3pRkihQNOsuIiWskdXbEH+Jwi7wt9zToo+uJkKnqSKm+mnLN7FM6x7G5AtcaWOvnQgPO
         PSuZZsbcJAQt3t16NDalu6tXmGjlJ+jnZ0gm1pe0axNM48814mhEYFvnJ56WtVEQQyC/
         bsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776439482; x=1777044282;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2bC6Hz2MAErwrJ8lu8pBzVTd3KLTohmvccUkPb3vXE=;
        b=V2VWw6DVOyWwLUuTG5DiP4+HjzOZRGJun0aoHWFyBUkKQjAEnbwb7Ck4nw/yUtgqHu
         hANVFSzZsRrj1iJzSFeT3o4vi35Qu/u7l4NESD2VYTbiyfGynTdXpN0lLDUqvzfCL40t
         xdGj11+AHZE2XNU8LM3EAjTep6xqOTIDuylACHTJsnzvagVkQ2Tjog2ruo+LU9zy8Vhj
         kD0eF4eKRk2g3W3FIpUJ9J2fAbyRLZ9+H3dEEgubxVKTi5mDU4ybWzm3CGb+adcNHBRZ
         x90frCgOTIfj2rtO25mFnepP1IxzrMGNa4cU9L7y/Egd/cOb+oTERVKpPPf5i7kktEHt
         2ipQ==
X-Forwarded-Encrypted: i=1; AFNElJ9UoOssyuj/ppNa8ZmV918KL0v+p9kHgkZn8CmIXMYAZDNKvydg0PozG5S7Ql6V1DhEdzO886E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhwH99w8MsaiF/piapc8/D42oxWLNgzWhMvjb1X+53MSjOoRdt
	IL0UxXHLIb97zwbZ0D1tNSbQ/M1PpSz2LvAA5dC46Qsz1TyZYtT93khSPfCu/4nl/K0=
X-Gm-Gg: AeBDievzB74YmIGl41AC7We4pdAVnNlyPVvhBv00SFVVt8ifv1a9uS54BG29cRuuxfz
	wOtiYZRGykYxLjPc97+IZmow/AGQXuZ6qYWqH11ChgQGyHIbpMNglQprLN8sgiUGafR05ihR/VX
	lVoALytrm1qoJVvHKlMe3rqMhWnnCome0fy1vlCN4YAxckqEc0l6z/PUsZbjhZgIOwt0lrtU0Qm
	sDP/mEd9gIPibJRifeSkdRm7rz/OcyKKdqiLUJCd/TokuqyGj2IvvufK/BbDI335yXFOSlWmn9R
	hqfWlI5HGWETgEhWULs151DBjuwduNXREHjWWXwRvHg3I3HRirL+8VoMzCoQfmfBdM/JV7ANRzY
	LXF5zNOOYWz9mOCoBEZM10KA/7dqs7dj0+XAKiWcm57fpHRiuWKrzZxnkNBtEVc9iuPZVS1Nez8
	3GmQf3FFhKfpN8GoxG3IDaS0iPqbFhl/sl3rNQVDrxnURQKPXFJNAqn20SD7waAsU4G4NE9ngt7
	HKpaUov1U72G7PlUw==
X-Received: by 2002:a05:600c:c0d8:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-488fb8838abmr31594955e9.1.1776439482480;
        Fri, 17 Apr 2026 08:24:42 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7aa593sm19318855e9.24.2026.04.17.08.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 08:24:42 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 17 Apr 2026 15:24:39 +0000
Subject: [PATCH] mtd: spi-nor: debugfs: fix out-of-bounds read in
 spi_nor_params_show()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-fix-oob-read-spi-nor-v1-1-2132e61a684a@linaro.org>
X-B4-Tracking: v=1; b=H4sIALZQ4mkC/x2MQQqAIBAAvxJ7bkHNivpKdNDcai8aK0QQ/j3pO
 DAzL2QSpgxz84LQzZlTrKDbBrbTxYOQQ2UwygzK6hF3fjAlj0IuYL4YYxI0vVWT73RQ2kFNL6H
 q/dtlLeUD/N0NFmYAAAA=
X-Change-ID: 20260417-fix-oob-read-spi-nor-25409b31d01a
To: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <p.yadav@ti.com>, Michael Walle <michael@walle.cc>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776439482; l=2246;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=tPwzxOzm9uakxuwTOcaC6u3ngixwWgQyrsHL71YIYTU=;
 b=YEZm7VO5nMzhEC2ZjHHkxyVPrh8RqY7QfAve2g2czKQlHG7IhQzXTiAzdiWNjmv/aHtJCgjXz
 J7wTQsy5Gv4BqCCXi8QEBKX9Rwd5fEhlGUpMBPbQHGmhGJ31U8ZID0B
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-238499-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:email,linaro.org:dkim,linaro.org:mid,sashiko.dev:url]
X-Rspamd-Queue-Id: 75D9F41C947
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko noticed an out-of-bounds read [1].

In spi_nor_params_show(), the snor_f_names array is passed to
spi_nor_print_flags() using sizeof(snor_f_names).

Since snor_f_names is an array of pointers, sizeof() returns the total
number of bytes occupied by the pointers
	(element_count * sizeof(void *))
rather than the element count itself. On 64-bit systems, this makes the
passed length 8x larger than intended.

Inside spi_nor_print_flags(), the 'names_len' argument is used to
bounds-check the 'names' array access. An out-of-bounds read occurs
if a flag bit is set that exceeds the array's actual element count
but is within the inflated byte-size count.

Correct this by using ARRAY_SIZE() to pass the actual number of
string pointers in the array.

Cc: stable@vger.kernel.org
Fixes: 0257be79fc4a ("mtd: spi-nor: expose internal parameters via debugfs")
Closes: https://sashiko.dev/#/patchset/20260417-die-erase-fix-v2-1-73bb7004ebad%40infineon.com [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
We shall assign a CVE to this. I'll look into how next week.

Link: https://lore.kernel.org/linux-mtd/20260417-die-erase-fix-v2-1-73bb7004ebad@infineon.com/
---
 drivers/mtd/spi-nor/debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/debugfs.c b/drivers/mtd/spi-nor/debugfs.c
index fa6956144d2e..14ba1680c315 100644
--- a/drivers/mtd/spi-nor/debugfs.c
+++ b/drivers/mtd/spi-nor/debugfs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/array_size.h>
 #include <linux/debugfs.h>
 #include <linux/mtd/spi-nor.h>
 #include <linux/spi/spi.h>
@@ -92,7 +93,8 @@ static int spi_nor_params_show(struct seq_file *s, void *data)
 	seq_printf(s, "address nbytes\t%u\n", nor->addr_nbytes);
 
 	seq_puts(s, "flags\t\t");
-	spi_nor_print_flags(s, nor->flags, snor_f_names, sizeof(snor_f_names));
+	spi_nor_print_flags(s, nor->flags, snor_f_names,
+			    ARRAY_SIZE(snor_f_names));
 	seq_puts(s, "\n");
 
 	seq_puts(s, "\nopcodes\n");

---
base-commit: 43cfbdda5af60ffc6272a7b8c5c37d1d0a181ca9
change-id: 20260417-fix-oob-read-spi-nor-25409b31d01a

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


