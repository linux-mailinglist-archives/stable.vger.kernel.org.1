Return-Path: <stable+bounces-270089-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rHMmMwF+RGoYvwoAu9opvQ
	(envelope-from <stable+bounces-270089-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 04:40:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5076E946C
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 04:40:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BywU73+j;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270089-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270089-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD8CC3036AF5
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 02:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B4A36167B;
	Wed,  1 Jul 2026 02:39:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCD521257F
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 02:39:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782873597; cv=none; b=lDMklOdrH1fQ4VAAkk1/O+kPOV9Wj/gsKQOHFiSxpTBCXb9flAhUf2bWYqSwbCapaa5eILcKMHDfhejAlHCX7pK+969lxuPKQ9U3andrOw/xkSN0it6LMpYbLcgfjEJzyjF51AbCCm/tHhmRkA9WWqsG9F5LD3TlpZQEoNH1WrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782873597; c=relaxed/simple;
	bh=kFfS/hYVH3xKgYiZ0ih52JyN+hH+Rh+N6BnADyg9gWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GPLg5yeCaA9J56tfi4LRlxZj8wDUPPA2v2xyoNqAj9dghRUOBBobrjSY/v7QYLiZKAyBB8abZ0vaeAuF+++XVQd4oGtc2iSmPYA8MysMwJY6kSH+7HXNnINxJRHs6QzEASQOhehhBB2ZODs67uQ+F6HxYiGPYte6PTAW1f+Dv1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BywU73+j; arc=none smtp.client-ip=209.85.215.174
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so45671a12.0
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 19:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782873596; x=1783478396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzkYV94Uqg4TuiFvMHYE6jMkVnd53YqhWYM0y0VZBIA=;
        b=BywU73+jRaTSfLK0rdPZPF+0+uPx/ZJ2+O53cQEQMVwwQAv5xTj75N+tj7KuMYHrcl
         qX17hQOZI0RKb3+yu7onB1n/1rjneRnCSu+vmuMadibYQBvr/vtxkiqiv3KHIBWxSWD0
         m6dVI995CcbQ1LV86IOI5WQ3MUehsCtM52ubGX7Ub/lwL8Kow/v7JR5q5bndq9ou8n6a
         Qv6Lc9dYUyycNOLm12SMhnjJt+722thyqGWDWuzg5GAMFa0QJTwHpSTONaencCfmP6BQ
         w406+o+vmXAg2VgzqntKGSIIGfwicRB2y/RIVD/tbeDArTBqicetRdI/WU1P5g0lWAp2
         Vgrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782873596; x=1783478396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DzkYV94Uqg4TuiFvMHYE6jMkVnd53YqhWYM0y0VZBIA=;
        b=kakqS389+M1n8CE5+okX0BvzR2YYBrWF95YCGiItpH0i4lCFE89U58zN4avDbAUD6i
         kZRL/9LT2k1LvuT9va9ytYS1efDP9o1WxoyAgA3+tXLTzud/TWCpCsV9ReRgEwLz+fsf
         i+1FtB+Pmr08VUBeiZ2Q5k8QCMU0j/q/0pFrX30ugw51kFhmdD0DTenCXGrA3kuxTO9O
         61sRdvyGYhTiAJaoM4bgL+NAS5EeRk+/5JL/hsXSR3r+UZHRcaCOa7Gt/2o706ZwKjuv
         astL7qaZai2962x7mRzTqZbNfAefXfhuf0kHdsGGptRiP37Vi1vivVs9yLzxa7bp64QQ
         WE1A==
X-Gm-Message-State: AOJu0Yw4FPRVeOS2kq2JeruZR8dbuRsVasUaflIAzwXhfiiGOuBQu52O
	Sw6/f1iZ9aUyL+Ur6Rb5SdLgaD+Y+/el8dm7PxpRbyd+aLunfAfIzaXa
X-Gm-Gg: AfdE7cnXw2wK2B+el6Q2Te9sj39kB2y9KMHhu7m9Q/G93boxDANLZbdCMXkoNuEOJTH
	Bzv0tXrK+OncqM5Ub7ifs13Wqxo+ah6ZjBiMwYxie2/r+OCvLtsU4Y4fczOvqAFuHwhYk1FuA6y
	/BGlUX+ddgWhz+zfdTGCb3BEUoM3yGFKwheiZvtPx3mOys1zPs/8by8QqJmKHQENwy0x5Bx879T
	N0H/OfXg4tHtGuoi10aztl1VBYtejZmEuBf3sLpShevzH6puMpjAHgvGjW2jXdxLTf4GR9HzCsK
	CzJJy4GL7dAYsbPSu6yUMeNVWD0sj0y/KtM6DJzofIILBPU+7T9d8oWAP7KfwE3nSNmFvZSpr4L
	/FHuz6gzBHt64YoBZ2LgxFdr7BN/9uW+72mrgUPKxOQJvRr62/nxzeYQL27p514XCTWuEs+EUaP
	RzuzWbsQfhXB+iBK6sYhInJH1aEqrqP3lZzaw=
X-Received: by 2002:aa7:8891:0:b0:847:9301:48e9 with SMTP id d2e1a72fcca58-847a81f41f8mr3385986b3a.15.1782873595657;
        Tue, 30 Jun 2026 19:39:55 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a02d41c0sm2988752b3a.33.2026.06.30.19.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 19:39:55 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (unknown [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id 7110E416A065;
	Wed,  1 Jul 2026 10:39:53 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: stable@vger.kernel.org
Cc: tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	alvinzhou@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH 6.6.y] mtd: spi-nor: macronix: add support for mx66{l2, u1}g45g
Date: Wed,  1 Jul 2026 10:36:19 +0800
Message-Id: <20260701023619.2730136-2-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260701023619.2730136-1-linchengming884@gmail.com>
References: <20260701023619.2730136-1-linchengming884@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270089-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:tudor.ambarus@linaro.org,m:pratyush@kernel.org,m:mwalle@kernel.org,m:miquel.raynal@bootlin.com,m:richard@nod.at,m:vigneshr@ti.com,m:linux-mtd@lists.infradead.org,m:alvinzhou@mxic.com.tw,m:chengminglin@mxic.com.tw,s:lists@lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[linchengming884@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[linchengming884@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mxic.com.tw:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F5076E946C

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

commit 797bbaa7531f75985b199e484451fa3f954382b3 upstream.

Due to incorrect values in the 4-BAIT table for these two flash IDs,
it is necessary to add these two flash IDs with fixups.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
Link: https://lore.kernel.org/r/20250211063028.382169-3-linchengming884@gmail.com
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mtd/spi-nor/macronix.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index b676a71822a3..b3ba7ad94711 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -116,10 +116,16 @@ static const struct flash_info macronix_nor_parts[] = {
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
 		FIXUP_FLAGS(SPI_NOR_4B_OPCODES)
 		.fixups = &macronix_qpp4b_fixups },
+	/* MX66U1G45G */
+	{ INFO(0xc2253b, 0, 0, 0)
+		.fixups = &macronix_qpp4b_fixups },
 	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ)
 		.fixups = &macronix_qpp4b_fixups },
+	/* MX66L2G45G */
+	{ INFO(0xc2201c, 0, 0, 0)
+		.fixups = &macronix_qpp4b_fixups },
 	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048)
 		NO_SFDP_FLAGS(SPI_NOR_QUAD_READ) },
 	{ "mx66u2g45g",	 INFO(0xc2253c, 0, 64 * 1024, 4096)
-- 
2.25.1


