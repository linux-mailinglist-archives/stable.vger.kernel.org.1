Return-Path: <stable+bounces-226715-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PpSDVONuWnkJwIAu9opvQ
	(envelope-from <stable+bounces-226715-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:20:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 919982AF578
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41E40300B3D9
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE082EF67A;
	Tue, 17 Mar 2026 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkzzg1sD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873F4225A38
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767930; cv=none; b=f1aOBHs9X88txOJmpAeyT8MFiESo+CMoeKwcbtI3JTj1dirOn3jf0XqfpIjxaSVeKYdnllW6v1z6K/+ELfzBM3IF30kVr7H7c6FxGcUpbySi6Cp5mF4KjZU0y8AnVMqEjkV2e8FaFuF4epzbRcFBz+XXmGnKgMh1fYd7g8NN/RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767930; c=relaxed/simple;
	bh=kX7K390Kjaem5bLOf92D3wE4xJDNY5+Fx3b9Q7pUlq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jSp6zI6YAn+sacoCmxXqtrksqIqxFSb1Fv2t9rqElJKpvHwqta3OjyWXNXWbmOuUrLFpfr/Ngevz8e7dvqZaPqV8SeGuDO1NvSVkvk2yhrXGjL/qXm1xWhHfU2e4QVVFKCflSyxhv/NQLk/9+N2KS9IVb6WIuNnFORY32kkXGHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sobrie.be; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkzzg1sD; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sobrie.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b97a9f4b4dcso353349366b.3
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773767927; x=1774372727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=x+NNnq7TQZcUH92fhtXl669qaHmWjEo80sBNFHMpXaQ=;
        b=dkzzg1sDO431Qf7QBVZj/TBfI48o5Wc3B8O2OPayLUJ7lgn3zki4oCwpDw39QHTVD2
         33M9iw2Bbos+dA/sM4u/9uCShWfDumSpZb+B81ZrWBC8IGanEvR/VKE8v4jt5HE5gRpf
         sMh0+riMINMrgrz9zZS6DG5oYA2/Gp4EPqz3CLLFI7TRFIpyBjqiHmTA5vHU6gSOkw5W
         KMHRnhLeOz3HBQbPYYDvlIzFqk1hXC9USaJwJww7IOY5uPD/QIeSWGPkErqjUjl7+4N9
         JfCP5QKKx2dYuTX+7VTIAbtBdx1z4VWUjDLzB+PU05tcFmxUnEspWigNDTck8uXJSs+u
         lh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773767927; x=1774372727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+NNnq7TQZcUH92fhtXl669qaHmWjEo80sBNFHMpXaQ=;
        b=NyXMcN3Hbj2tj+FSh2NzkoQA1m7HBxYR0buWIZ57hSXp3B2mFcEYhOlxph2tmOMoTu
         52h5kfp7thAqxdA5CIigu6B4SuqGUNy2ZdVf2y1IEO/6tEyfd013lfoN7MBu+pMSczIj
         PIsYoaNMso5mWwl/mT0f9OYbfwtHTx+GDvcrQ9oY+WwpLa3gpVtnh6MG0rmmIgDfTM2s
         Na+cU+9SLSiyZMmXH3/GxVwRTcpIBHFHBuhya+KhImTBj8H9iVyi/qlVtw3V3plqfszl
         3AmjKzsGsRPpTS7pS47gal+HIoBu2jnc1/AaP8LZk8ROeLb8c9pFumhLMryC+JBm4f00
         gjwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdMp6NDIbv0px1TvvBj4G5TOcHLTLW8AOqOFBxUUIsPW27oBww/1z7xX1YYZHT5uIBsO+00+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwykUmg+nV7k4+JscJ6S6k1Ix/ElKX4jy23cTKENj6JPJTfX5tz
	XVLgGym27w8wEib4KbnVMeQzt6cYy8uHBdOIsglqhMbAxR7V/AYW795V
X-Gm-Gg: ATEYQzwahodlHG3MvX60j5SOSB5YzNjg88nR+ALNfQEgar0YiDqo8nACDVETQF7yH1v
	o34rT/4NvTMhtmN0HGvW7c884CvTnKDVELYxnuAaIsob8HlabuSq6SFnq3mKde4hZXvv1LVGO5p
	U5mQ4lvaWwjQLTm8cdpRfum3k0wLbZgZ5v/TvAlrTCFYCY7yuOpoamSr1S6QOkLe8MxEDxAJm0a
	QFFDP6zxlVxUKkn/5g2k7WHj72xO8w/Aqy+wciCcopFerAl/8PDjvgAysNKXmvjMeGqDIxSHVzf
	lDozVNK5KYC8n48K5FZN6UcIdiE/FTkBrd7DilWod1d3tjW+qqGBK4xj2DJYchbm4B8RoRtXyn3
	Depd6cjgMNYqXsTGgtQx6UrqDoB2hp8x56cPOw6EgbRIJrKrbO0tis/AOG9lz+wqVRM3/+SN3zf
	gs4gIPeOG/MH563nxXaaq6d+xfwqGhlf/xWh3h7ER8
X-Received: by 2002:a17:906:7955:b0:b97:6a2a:405b with SMTP id a640c23a62f3a-b976a2a48dcmr951610866b.37.1773767926595;
        Tue, 17 Mar 2026 10:18:46 -0700 (PDT)
Received: from localhost ([2a02:a03f:b7dc:2b00:a97a:8551:7733:cb60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f13edad8sm23641566b.6.2026.03.17.10.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 10:18:46 -0700 (PDT)
Sender: Olivier Sobrie <olivier.sobrie@gmail.com>
From: Olivier Sobrie <olivier@sobrie.be>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Michal Simek <michal.simek@amd.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andrea Scian <andrea.scian@dave.eu>,
	stable@vger.kernel.org
Subject: [PATCH v2] mtd: rawnand: pl353: make sure optimal timings are applied
Date: Tue, 17 Mar 2026 18:18:07 +0100
Message-ID: <20260317171807.652642-1-olivier@sobrie.be>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226715-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[sobrie.be];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[olivier@sobrie.be,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sobrie.be:email,sobrie.be:mid]
X-Rspamd-Queue-Id: 919982AF578
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Timings of the nand are adjusted by pl35x_nfc_setup_interface() but
actually applied by the pl35x_nand_select_target() function.
If there is only one nand chip, the pl35x_nand_select_target() will only
apply the timings once since the test at its beginning will always be true
after the first call to this function. As a result, the hardware will
keep using the default timings set at boot to detect the nand chip, not
the optimal ones.

With this patch, we program directly the new timings when
pl35x_nfc_setup_interface() is called.

Fixes: 08d8c62164a3 ("mtd: rawnand: pl353: Add support for the ARM PL353 SMC NAND controller")
Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
Cc: stable@vger.kernel.org
---
Changes in v2:
  - added Fixes tag.
  - added stable in Cc.

 drivers/mtd/nand/raw/pl35x-nand-controller.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/raw/pl35x-nand-controller.c b/drivers/mtd/nand/raw/pl35x-nand-controller.c
index 947fd86ac5fa..f2c65eb7a8d9 100644
--- a/drivers/mtd/nand/raw/pl35x-nand-controller.c
+++ b/drivers/mtd/nand/raw/pl35x-nand-controller.c
@@ -862,6 +862,9 @@ static int pl35x_nfc_setup_interface(struct nand_chip *chip, int cs,
 			  PL35X_SMC_NAND_TAR_CYCLES(tmgs.t_ar) |
 			  PL35X_SMC_NAND_TRR_CYCLES(tmgs.t_rr);
 
+	writel(plnand->timings, nfc->conf_regs + PL35X_SMC_CYCLES);
+	pl35x_smc_update_regs(nfc);
+
 	return 0;
 }
 
-- 
2.53.0


