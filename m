Return-Path: <stable+bounces-94476-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEEA9D447F
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 00:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F184C283351
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 23:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639A91BDA84;
	Wed, 20 Nov 2024 23:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dBoYJX1B"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E67146593
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 23:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732145490; cv=none; b=s+H3VxW1GX7AdTCwpxEAYrT6SrTAR/CU9Tp9jYVE5xzvnFuihkoqGJmXj31h/z3A8FeycujrJJ9c13cvFq/p5/O/Km7LQ1To48NQRhhzWWDrVle1wiz57ohn2Igx7x44m8Ex0zqT8+czPb3VYLi9hSdF16iNQ7yVRfD4p6HNi/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732145490; c=relaxed/simple;
	bh=zNNjCjHxAKV7W/tDatRt9BVWmQmRJtpdS1cMtjJM+Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gOXfepXCjJzQ9IeKbka+h1n+cMWaTgcpuGR99B4vdFbmbnevlAsr1ZiuLMariLg9EDI5GbQSC4zlnHXPVft9fUjaAztOejbnbHvUCKzIztifk63c/UUwxrLnJaHuex2qh0I1gu8yLMPwbRrfcT7UaiFopI+cDo5Le58+tXmP7yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=dBoYJX1B; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21260209c68so11021715ad.0
        for <stable@vger.kernel.org>; Wed, 20 Nov 2024 15:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1732145487; x=1732750287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fSqv89uy0nwc5dDPbI4XvXjKwme8rpzvHxwcukveaqQ=;
        b=dBoYJX1BqgAcE9tq1mdaPHv3XjX+F+kMjp/Afx1s86yBOsRONCza/2pBlyxvTtXF1h
         k1ZRDpcVn/M50UHOfWSB60Z0PKg+KlA/sdWobIJ3/0IM0C+uJYf00EEH3eURq8Z8gmv2
         gjXYK0Vd4LstOezz6SyTpHs1/jLDj8ICuzwiLTus754xs1StXKWYV5rWmhPOuU6dhcyk
         LYdDV+xmnA4VWL3nZi+fCFAyxe2TZ3EHmKI4tfmvN4TwnGBxkNHNiyP12OrR113OsWFe
         37yihpvjeR3EZxTrgSFC0rl3WFXEJK2T47a0mRorKmGIVCMUedeJTN8PQ8jE1jj3MlQe
         3wLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732145487; x=1732750287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSqv89uy0nwc5dDPbI4XvXjKwme8rpzvHxwcukveaqQ=;
        b=cl4PD8RTFbRooTC1XbjuZYByUfVRrgbhZkzO3F30YmLKvvZ3+437fMecbkxCkT/ytg
         D7yh9clrhTBhhOOAi0d97qhqTwKjqLDcB1Lk3lHTCAtiSZrkLY2H96NbbRu+RKma9Xut
         46db8k/p63RCVO0BoS7S97wT8EtXwk89/sQi993aio27wHSRYV0Fj2xlSbRZ4P6yS0Wn
         lvs/h6R/9KbpiBzMdr/rxsic9dyyRzykOY69LFqfCfqe6seHRrRAJgtZlSgbfZSDtD3o
         nfK1tlQpfjI5NyXFEFQkfBlMeISI7lh0sqUVGy/o5NMCmqMOU5VsVKNE5vFm5UNyzuGG
         ISaw==
X-Forwarded-Encrypted: i=1; AJvYcCXH10PucpDtXL/vUaUO7vumXb4lSJNkrCCBrJMjG1UHWM6jp+drgKi8ujRjg4HwtJz4t1dTSPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxylMM+Cv0w5SJGLMR5k5U4PT7WKa07nfwBG5ipsn0WHht2PcBI
	6hA6Zhu1I4tB6N550r+pauJlRJtuvlv17qOOviP2PnDIs59bGpm3x+EM36ANdgo=
X-Google-Smtp-Source: AGHT+IG8+Dhf9R1FFvZlRBlQQYlb3BPblu14O9UczA4OS58b9VvtlNwVw8oEoDe5/zYh/oqsLmntZQ==
X-Received: by 2002:a17:902:eccb:b0:205:8b84:d5e8 with SMTP id d9443c01a7336-21283ca84ebmr14588725ad.18.1732145487286;
        Wed, 20 Nov 2024 15:31:27 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-212880d0761sm1078525ad.132.2024.11.20.15.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 15:31:26 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: Anup Patel <apatel@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Marc Zyngier <maz@kernel.org>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] of: property: fw_devlink: Do not use interrupt-parent directly
Date: Wed, 20 Nov 2024 15:31:16 -0800
Message-ID: <20241120233124.3649382-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 7f00be96f125 ("of: property: Add device link support for
interrupt-parent, dmas and -gpio(s)") started adding device links for
the interrupt-parent property. commit 4104ca776ba3 ("of: property: Add
fw_devlink support for interrupts") and commit f265f06af194 ("of:
property: Fix fw_devlink handling of interrupts/interrupts-extended")
later added full support for parsing the interrupts and
interrupts-extended properties, which includes looking up the node of
the parent domain. This made the handler for the interrupt-parent
property redundant.

In fact, creating device links based solely on interrupt-parent is
problematic, because it can create spurious cycles. A node may have
this property without itself being an interrupt controller or consumer.
For example, this property is often present in the root node or a /soc
bus node to set the default interrupt parent for child nodes. However,
it is incorrect for the bus to depend on the interrupt controller, as
some of the bus's children may not be interrupt consumers at all or may
have a different interrupt parent.

Resolving these spurious dependency cycles can cause an incorrect probe
order for interrupt controller drivers. This was observed on a RISC-V
system with both an APLIC and IMSIC under /soc, where interrupt-parent
in /soc points to the APLIC, and the APLIC msi-parent points to the
IMSIC. fw_devlink found three dependency cycles and attempted to probe
the APLIC before the IMSIC. After applying this patch, there were no
dependency cycles and the probe order was correct.

Acked-by: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org
Fixes: 4104ca776ba3 ("of: property: Add fw_devlink support for interrupts")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v2:
 - Fix typo in commit message
 - Add Fixes: tag and CC stable

 drivers/of/property.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 11b922fde7af..7bd8390f2fba 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1213,7 +1213,6 @@ DEFINE_SIMPLE_PROP(iommus, "iommus", "#iommu-cells")
 DEFINE_SIMPLE_PROP(mboxes, "mboxes", "#mbox-cells")
 DEFINE_SIMPLE_PROP(io_channels, "io-channels", "#io-channel-cells")
 DEFINE_SIMPLE_PROP(io_backends, "io-backends", "#io-backend-cells")
-DEFINE_SIMPLE_PROP(interrupt_parent, "interrupt-parent", NULL)
 DEFINE_SIMPLE_PROP(dmas, "dmas", "#dma-cells")
 DEFINE_SIMPLE_PROP(power_domains, "power-domains", "#power-domain-cells")
 DEFINE_SIMPLE_PROP(hwlocks, "hwlocks", "#hwlock-cells")
@@ -1359,7 +1358,6 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_mboxes, },
 	{ .parse_prop = parse_io_channels, },
 	{ .parse_prop = parse_io_backends, },
-	{ .parse_prop = parse_interrupt_parent, },
 	{ .parse_prop = parse_dmas, .optional = true, },
 	{ .parse_prop = parse_power_domains, },
 	{ .parse_prop = parse_hwlocks, },
-- 
2.45.1


