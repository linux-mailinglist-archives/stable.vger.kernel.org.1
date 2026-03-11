Return-Path: <stable+bounces-224666-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBfYNPxIsWlCtAIAu9opvQ
	(envelope-from <stable+bounces-224666-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 11:50:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4662A2628D4
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 11:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51F0F302C901
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 10:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0323CEBA6;
	Wed, 11 Mar 2026 10:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boAL0uv8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633663CCFB2
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225085; cv=none; b=dY9xktjZtPikomA1deqq5CfLM23nvnt87SsZNT4vTf6qjC8B83BQTOP/BtcolA6QFUZC3CWsc8Xp9IjLO5PNWbJj+ZClZtCvddcljj1zk9lgU3S/AEOBdPkz5FePB1EGIBqoHFm0XTjWw6pND9e5nqIj93vBfxHQpg856UC+qT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225085; c=relaxed/simple;
	bh=kPoRVNxNpO3Z50WxHXMMyqAvSb7QbpFQJukqGhW/z/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzy7mC0tUSsJbGKT2M3mRnbtcnWJgZ4I3enhtsttzbFYT5M8bMymJQKz3Zvq5WNSMk/9wBQxhW02OEgbLKQfOkr2qQjjcuaJMnODvuwRgNzWOepXV4fG4dQEy6Pf8TPM5A/qqypeB5EeZdBwXIaMs2Ch/KC+qbe2KJbG0jHbn10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boAL0uv8; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-829b8b6c4d0so3788493b3a.0
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 03:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773225084; x=1773829884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68kFT9M+v1YFr8fLxiUdg7OyCK95BGAep7GJPhPQZJ0=;
        b=boAL0uv8SImXFMa/i5N5ON7QmtBzqz60ocH16rgrE01H7d947Chhzzo89axedinyzX
         R8FjAh9pxeTN/pkD87I495kK2kmslyIlrsuz7epCm52mRofHvr5rJU+mUEZT4nvJbbu3
         dcXX1inZ1RU3nEs1HxFEkvO7VNEpOVrzQJqv5Sm4XxnMV0HyVELLmjbWs5l08KwO4ZQ0
         hoJxEnz3kYT/sA5vCoQwnDti3XiLxOWMPf7nzcp/1kRwi8hnzG8rh4zQa9PcTWa2q1dv
         VuoZeOIJT+BBPksNTJk26r8YFQNZvUSe7GqIvxJa9HV23yx3CnKEt+NkCUPxXEx7lx9o
         UeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773225084; x=1773829884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=68kFT9M+v1YFr8fLxiUdg7OyCK95BGAep7GJPhPQZJ0=;
        b=AxfrjFSbMnmGkERXBejthi5bxTZRUk1j+2kCnHR++uvL7y+JcCs04DNAB3/IlCz1Hx
         c58q1e9ba6aUQKNdTdhKTYqrESrClXW17Dungy7y55JL2lDGyovRCcmLO9TO+GPTXGZj
         F8x2yL1Cj2vnFVEUfS/oeu+H/+X8algfyhm0KCVIyXTpnLRlYjxT4tj24PgCy57EK2k5
         6u5w6II0Uccs0Qi7/3yyibH+IRkldMdp+KawUXIyA/WvGci7zG/uakiLCY3oym0MKCQN
         bRfqxVIS3rbcguI/77A9OuEYoLlWkx5hNtIsHigTF0WNjU4pEEJT3vdOj/neme7roVy1
         oceA==
X-Forwarded-Encrypted: i=1; AJvYcCWXOHtcxcHbDrBQ1X/HftbiGePmknGXkRLD8qm2jgKRGappMugKK/IR5RNiAl7yN9CpQj1c5yM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhbe/kjPydIdTtlxrPWqlVW0mRSjvZf1tfokJx+daWEBPdsj1P
	i3JVqHgK6Hzejf5UzM6XtNljrtIU5BY+Zq3M4B+KUrWWMcaNpFWRXJ0V
X-Gm-Gg: ATEYQzxghZijh/xSF5nYcLIOCMdwAQ6LtFbMh0xXNQRkZtKdiDQKdjWDiVzEFurFi/u
	yXFarlegF/MYGe9pvzfQRFeJ85BDTXXue7LpR7icW3Us9ELhW354XYSzE4MTK90pO4azkGwufaU
	TA+uvTXiMrAW83SLRBf5t9DgMVusTH33JCtRV+XI3OLxQVvTIbb5IhhNBgFI0O9MNHuh9zR8tk+
	V+w21aDb66kiEqnybzInPUOnBGY7RztUz7jAoqkNqHhBSpyksrjdY7OGzBNQiD3uutex2RJnEsJ
	Bjt+blKEG+kgBiI42nTZhDIWBbAhBIhn4QgY8OCRJ3/5duht/QbanisIHzwO1GB5C5OVGxL7Oqz
	9rwZ21tK0l07wm8rYAYyoFfzrB7AhYXCrF0NJj7um/x4nkG0WNOhmXYNoacdtkPRX84I9rHgARo
	qg/2HqSCMCYAU7ammL+Q3iDShSLsJhy45wC3ZnmsAT
X-Received: by 2002:a05:6a00:2b88:b0:829:924c:3482 with SMTP id d2e1a72fcca58-829f7148a9emr1655467b3a.53.1773225083833;
        Wed, 11 Mar 2026 03:31:23 -0700 (PDT)
Received: from 1f3ae71dd79f ([115.245.213.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6eebf57sm2052558b3a.38.2026.03.11.03.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:31:23 -0700 (PDT)
From: Sanjaikumar V S <sanjaikumarvs@gmail.com>
To: mwalle@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	miquel.raynal@bootlin.com,
	pratyush@kernel.org,
	richard@nod.at,
	sanjaikumar.vs@dicortech.com,
	sanjaikumarvs@gmail.com,
	stable@vger.kernel.org,
	tudor.ambarus@linaro.org,
	vigneshr@ti.com
Subject: [PATCH v4 1/2] mtd: spi-nor: sst: Fix write enable before AAI sequence
Date: Wed, 11 Mar 2026 10:30:56 +0000
Message-ID: <20260311103057.29-2-sanjaikumarvs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260311103057.29-1-sanjaikumarvs@gmail.com>
References: <20260311103057.29-1-sanjaikumarvs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4662A2628D4
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
	TAGGED_FROM(0.00)[bounces-224666-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,bootlin.com,kernel.org,nod.at,dicortech.com,gmail.com,linaro.org,ti.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dicortech.com:email]
X-Rspamd-Action: no action

From: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>

When writing to SST flash starting at an odd address, a single byte is
first programmed using the byte program (BP) command. After this
operation completes, the flash hardware automatically clears the Write
Enable Latch (WEL) bit.

If an AAI (Auto Address Increment) word program sequence follows, it
requires WEL to be set. Without re-enabling writes, the AAI sequence
fails.

Add spi_nor_write_enable() after the odd-address byte program when more
data needs to be written. Use a local boolean for clarity.

Fixes: b199489d37b2 ("mtd: spi-nor: add the framework for SPI NOR")
Cc: stable@vger.kernel.org
Signed-off-by: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
---
 drivers/mtd/spi-nor/sst.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 175211fe6a5e..db02c14ba16f 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -203,6 +203,8 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 	/* Start write from odd address. */
 	if (to % 2) {
+		bool needs_write_enable = (len > 1);
+
 		/* write one byte. */
 		ret = sst_nor_write_data(nor, to, 1, buf);
 		if (ret < 0)
@@ -210,6 +212,17 @@ static int sst_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 		to++;
 		actual++;
+
+		/*
+		 * Byte program clears the write enable latch. If more
+		 * data needs to be written using the AAI sequence,
+		 * re-enable writes.
+		 */
+		if (needs_write_enable) {
+			ret = spi_nor_write_enable(nor);
+			if (ret)
+				goto out;
+		}
 	}
 
 	/* Write out most of the data here. */
-- 
2.43.0


