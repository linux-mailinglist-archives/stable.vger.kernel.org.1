Return-Path: <stable+bounces-213003-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKndOGyGf2mKswIAu9opvQ
	(envelope-from <stable+bounces-213003-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 17:59:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF68C693D
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 17:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 758133008D07
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 16:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748322749E6;
	Sun,  1 Feb 2026 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A384mZOn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169C726738D
	for <stable@vger.kernel.org>; Sun,  1 Feb 2026 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769965130; cv=none; b=NEL6oNqsDl8YaSD6gEyIqKAbYrY3cOx7s4ptoHEXF7ur0BbXo4kWnXESMLFJTZbWBmDvnNEW5i6ygakrX68PIrCqI01qG2W2YwrEVwqyMJ0ODIf7PuW8xsvyiN5mrmxcPDSWQA42mM1oui8QNsaaoluNQ4yHUOf/qtlPWPizvCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769965130; c=relaxed/simple;
	bh=ddelZs4saclLRF6sch2rRSjldIrJ72w7jZXXb06+vSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIYd04pZGETF/ikP8uq4ikAdarQse0hq9RrvlAqcsC5Ro2dKbWhZ2q5Z5rDLJEdJhZ6KIrADpVbQtcHlXjCbaMtdJntmBqrD3Tg84/nve6lFmfdQs8PSnzuu20xBGrWfVrIqxn9a7QwuL4r6V6gW6vn7UIaotxpwzsJ/OmJSMcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A384mZOn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a78e381fc1so17246405ad.3
        for <stable@vger.kernel.org>; Sun, 01 Feb 2026 08:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769965128; x=1770569928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKlyXwPFG6GKEH0YaZ7/fSJxwTIFwYdtxia1Wrm6PzE=;
        b=A384mZOnKn4F2pysgtXG8oONp0sO+21Wp2hbTsCrDGW2UQ1XyYSauVsFxQ6HqjkT2x
         x+blqLZWJ2JvQIeltdA98TyE6CQVLWFezIeTa+X0hbyDgnFZVK1Fdal4gId4+kLUW2l3
         29oRVjV/KU2RI8stP82/ypMlM5azigmav9UhwMpyUpDv+8EcTcJzYIA8GmN+DPERfHCs
         BJbjdmVCTT1pre39bdehBeMS7kLBz9ZHMeyNjOV6kd9RvSbZPs/t5PuBRFZuvQ4eIThg
         t3+MWQo/51D+AuF6fNayZQSrNtNdZM8MPjUEDPdRALT1V6JJgvacxA9fxbpa1FCxJb4v
         Geig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769965128; x=1770569928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IKlyXwPFG6GKEH0YaZ7/fSJxwTIFwYdtxia1Wrm6PzE=;
        b=ZdrZx7eo8cAdDtoVtVWmCofvJpk9boVxg5QHBrDpAuG+ccUUp9Uyd4jj2x3HAVOZvo
         UoRBO8vuB9sCT7Mjomp3/8hHGx1cvNhGOUh8LpT4NA270U2xMUhKoq+LzhmCzdE8jsgj
         zci6XZakpl9Y9PAg8ax4SotTedAhJUF4AxkYKohfpt0TNiBD77t6dKUhr7WPP1ieU+0i
         97osZJ6EnZcBrXGGSS+v3WusE87ZN9r8FUQq5SLQr9eBi1kXjnCZPJWeGcwLQ7deROEr
         unZxlflqq6/bnNY8UOJ/VCUF38Fnnmp6HP2uI+/s+7GruSCQJqG5Utv1odFxmEtsGFz9
         025g==
X-Forwarded-Encrypted: i=1; AJvYcCXzMDluZo/gItAbkPgdMEYODakGWyLQ/O5tcBYGwrWKQquLX/QE673TQfYc+l1XQMUiqC6hy7M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3P93wo0nYzVa22uASRs7TRRS3+Vwm8UOzioh2IpNL3nzCOzHg
	jQ1k5hjE9pjnCH3df0pIMRak0g6Zpm6KxHQWFLo/w+qbxbeMFa6IrBY7
X-Gm-Gg: AZuq6aKw8ntOEHBjKV5UlOImKuL+8v9tHk4anSu44Yrzbe9VK5NtS6Xz33KjPXJzH9P
	h1OxLvolIQrMbeJt9VzCtRtSXMtN1dTOcksyDqx6lCI7Weh4mOFUG+XMjVNGQ8jhnrZxfLXjOLi
	JzFNrj36MPzWoPq6prGnLHd20ScHc0iN7JJ+YxBgdL0n8sUmyPuXPHCbtURFpw+Nv3z04M1NpvP
	Nd2JeVdyj6Boe5XFUCF1G8xd0Ob6w2feWOELWfRncrqojjp5UhPZf/1UvF1/pUIAdXXcWzhxjZM
	vY22QdIWqCwDv/ajq77s+Mz7sfr5v4VN3QeE9nJm+ZPsjQHN0c+9RnTjuiqPc8g24dLxj2j+oE4
	TWUPXi01HIY1m7p8EJOZb/TKPSl/HzN4heb45Bm//DTKq8ZfBrgWHydY60oedUklVrY/W2jnnDh
	WwhpFwGSTCIKJONHk9EyJcS+7CPLh2M3CeR5U=
X-Received: by 2002:a17:903:2bcb:b0:2a1:1074:4199 with SMTP id d9443c01a7336-2a8d9918dafmr92847555ad.32.1769965128369;
        Sun, 01 Feb 2026 08:58:48 -0800 (PST)
Received: from 4aee0dccb4bc ([115.245.213.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c3afdsm120222755ad.61.2026.02.01.08.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 08:58:46 -0800 (PST)
From: Sanjaikumar V S <sanjaikumarvs@gmail.com>
X-Google-Original-From: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
To: tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	michael.walle@kernel.org
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sanjaikumar V S <sanjaikumar.vs@dicortech.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] mtd: spi-nor: core: Fix AAI mode when dirmap is not available
Date: Sun,  1 Feb 2026 16:58:17 +0000
Message-ID: <20260201165817.53-3-sanjaikumar.vs@dicortech.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201165817.53-1-sanjaikumar.vs@dicortech.com>
References: <20260201165817.53-1-sanjaikumar.vs@dicortech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213003-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanjaikumarvs@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dicortech.com:mid,dicortech.com:email]
X-Rspamd-Queue-Id: 4EF68C693D
X-Rspamd-Action: no action

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


