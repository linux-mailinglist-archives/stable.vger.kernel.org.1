Return-Path: <stable+bounces-94694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 918239D6D82
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 11:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C9C5B20F8B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 10:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BC318A6DF;
	Sun, 24 Nov 2024 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A0CZfEhQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC6018870B
	for <stable@vger.kernel.org>; Sun, 24 Nov 2024 10:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732442716; cv=none; b=ePZzDjeQCD3nbP1x17MIogLt6JVUoTSgPhdXuujKmKtVk8p8/N+CKMHOFlpMlm1VbIGyeeKZzDB46RoNQjXWvsC9XJw0xVjUSaNtQYBHZc2dTJ8g2lUOnvTi17ePV/UCGUzLbSSiYQ5RSLduoRTWV/9YVBNvSM6NfBts0P42jdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732442716; c=relaxed/simple;
	bh=00GKzIkIov7sWC7YYf/fsmzjuTtHwftcYafHQRVNIQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFD+92sC8ibiVed1LSNEzTEZLlG1z5J6dwgJQLjOOX+cusnJWebVw1GSwYdCMUov9U5dCypqbRr/SJpXTPODAq7zHkdzgcFBY3deIAeyUW/RJXGx0mOdbCjsUPrTU3YV//p5pAqqjsDufLl7SMZv+jFJua1ea87xZNqvyKRD1fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A0CZfEhQ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa543c4db92so73574966b.0
        for <stable@vger.kernel.org>; Sun, 24 Nov 2024 02:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732442712; x=1733047512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lk2GE1arbul51a1ynLU7Q9xhqGMt1ZdTPnPwO47t9KY=;
        b=A0CZfEhQgZuNQ8XUXPzjnRT3zv6xBUgrbIEApsB8YDOs+8YIt6aLdgPxacHdQ6fGrE
         4rbfMu2q8qqYnuLIAR1xVGQ9TpkMSD0a2KZh3sQp6U8s85NT1p6PzRiDkCkcxacIPULI
         PpyvC6I2LjBos1zcw2mVC3LUUUKHC7J65nGvJZfOsfIeULRJyQyWZxMRcDKWVhB8hCG3
         jyJM+Ee0ouYLEjtxx49p3j3PxwwUv75dSK0CSD725e4iBtgnBuarA8bLlmM/ZWv+uNTR
         FiJGb/+P4PLKzu9MD7zgH900QuuWIWC04chcWChMeq5TUNYpN6x14sCDQiQf1UNgirm2
         JSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732442712; x=1733047512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lk2GE1arbul51a1ynLU7Q9xhqGMt1ZdTPnPwO47t9KY=;
        b=kZTzKJH9+lgWtFgzW2MzSWX1ZE/jlun3yafCrtq8Vcbup4rhEGRQUcaamRL/QOZ2MV
         2lRz0VZWf1Am9JDZlurwfhSZ0xTcYatGbpDXka/AgYRo/Vzd4SR8TDTWdoMWPTCAef8F
         ZtXVMrNos5U8h4RQipwlxOurVdwDicBPG1msJ7jXoGHBRBSolFCYl6KxdmwyHne8WzSh
         Hv5VyUghFe7hwqo8DHtBcJlSoEZRleT37GI3m1PmTsTBalRbKMqxPFL75GKJmMiHt6Fv
         b5CRmJmBlTcCUBMGKe5VHtSEKASI/alZWJcAr08s/x2IOObE0G4G5GP/KP9A6W7kW+A2
         uRoA==
X-Gm-Message-State: AOJu0YwTmd7umn3DT5aG50eDhgK8Ct/m5blX1T1f5MIGVi2P8P9OozTP
	P+pHJf5wLjkhxht9IE143DFkgwbth5QErJi9rkGN4x9sJl4bTs6FrUlS4iaChVw=
X-Gm-Gg: ASbGncvaXSdLPeHdqOt+AvesSpZSYW6xZcDJ6h5gzqLfGvZfaN8s5lm3/W1Q/ykyCm8
	whkFcfgc2CTo1hDRX6Il1IsfwDrxkGMuUc45HQF879gFQtjb/opK4bKCWuB4aKNuWNBoSH9Yjgg
	FfnGgN1yKYtDr6VyYDSzRCkNOsmxmEcAigBDY+Zv7L7cYyrYuRH/Lknl90/JXjRCzIh1Okt6K+x
	D9MRJnD630n28RFyZ8lvmU5QX2hTql4pzxIOHUwHh6p6WJro9fLH1kIVi+VlsBXWCo+wnuRpfoy
	9W91eEr8n+S38LCfXirM
X-Google-Smtp-Source: AGHT+IHzhjRJgC4zyn46rADf4coPj01YWTVyf6AHNKqiCSQA366o1m7GZGOpC6OvPXD6QZ4IdkHEbQ==
X-Received: by 2002:a17:907:770d:b0:aa5:29ef:3aa6 with SMTP id a640c23a62f3a-aa529ef3b9fmr468828366b.23.1732442711875;
        Sun, 24 Nov 2024 02:05:11 -0800 (PST)
Received: from localhost (host-79-49-220-127.retail.telecomitalia.it. [79.49.220.127])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b57bda2sm325822466b.146.2024.11.24.02.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 02:05:11 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: stable@vger.kernel.org
Subject: [PATCH v2 2/2] of: address: Preserve the flags portion on 1:1 dma-ranges mapping
Date: Sun, 24 Nov 2024 11:05:37 +0100
Message-ID: <e51ae57874e58a9b349c35e2e877425ebc075d7a.1732441813.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1732441813.git.andrea.porta@suse.com>
References: <cover.1732441813.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A missing or empty dma-ranges in a DT node implies a 1:1 mapping for dma
translations. In this specific case, the current behaviour is to zero out
the entire specifier so that the translation could be carried on as an
offset from zero. This includes address specifier that has flags (e.g.
PCI ranges).

Once the flags portion has been zeroed, the translation chain is broken
since the mapping functions will check the upcoming address specifier
against mismatching flags, always failing the 1:1 mapping and its entire
purpose of always succeeding.

Set to zero only the address portion while passing the flags through.

Fixes: dbbdee94734b ("of/address: Merge all of the bus translation code")
Cc: stable@vger.kernel.org
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Tested-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/of/address.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 286f0c161e33..b3479586bd4d 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -455,7 +455,8 @@ static int of_translate_one(struct device_node *parent, struct of_bus *bus,
 	}
 	if (ranges == NULL || rlen == 0) {
 		offset = of_read_number(addr, na);
-		memset(addr, 0, pna * 4);
+		/* set address to zero, pass flags through */
+		memset(addr + pbus->flag_cells, 0, (pna - pbus->flag_cells) * 4);
 		pr_debug("empty ranges; 1:1 translation\n");
 		goto finish;
 	}
-- 
2.35.3


