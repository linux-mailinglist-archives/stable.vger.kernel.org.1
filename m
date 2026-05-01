Return-Path: <stable+bounces-242517-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAJfEIAN9WnIHwIAu9opvQ
	(envelope-from <stable+bounces-242517-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 22:30:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7964AF7C7
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 22:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEFA63015CB9
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 20:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1567F421F07;
	Fri,  1 May 2026 20:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGO+jCXH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC3D421895
	for <stable@vger.kernel.org>; Fri,  1 May 2026 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777667444; cv=none; b=jaR3zd5qjrtHKxmaR+OWnrZjQy74pjUPBPYtTijspbYH3E5rsPNmiaA6i3VSZdHj2GG60a/76uuIf7r6Gs8r0N6ORC331cz2IlHT5qZHYZ6rryPG4C+spFbo6bCY8J5YgbRCmvLnIMyQ+IqgZntGbj6nDgDgzV9zI1e4waL6Ihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777667444; c=relaxed/simple;
	bh=v5qF9oUjFKKNNHiaZ/cDzrCvSYhthuRxEl4ePROAuGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=etSHOdF3E7KTaR2+5Jx3aUBylv65ptgR0m7kQ5QSegZIfcvcxQN31RGOhF+PAe2Wgv1jf3eMA/jLeDE/yGP5Qo2hFBIZnG+3SxjiqTl6hZXEjBkQkRh0syeuMg26Wzj5FATNMNFD4WVnJYheyOns+FWtW1UwWZ2+UPqxm6sFvAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGO+jCXH; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so1029065b3a.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 13:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777667442; x=1778272242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVBnu6Q/tQcYvEy05j8zTeFYSonQvouDAQt7Xng1rGU=;
        b=FGO+jCXHSKDpIfZTzi+KqeQj1n2RE+xbiek+qNmJE4PdwTd714zf5EQvYG57oIi6Oi
         tZ9UxnPr/9Xbpud32rn/Z1BnaaZ/sKZELwdT2oRc/N8Ha/vE28DQfIsPHwy4xqyOguWT
         L3l7oGbbQukeSzast7sN4t8wVpyQrESwJStsqRuHp6NTwdZ+mXvFNE/SroyTjrI9QPjD
         y5NzCZAikmvok/G26FdM8VeGryxnBvexH065x/hW399eHtojC+sON90MlK5c4SmeOggK
         slhFI51+7FhLP68Yhn/L5Q+/YbC0OKAYGLLdmOt2T5TwR51z5Jtqu4MKAAf6/a34N2vS
         n6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777667442; x=1778272242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qVBnu6Q/tQcYvEy05j8zTeFYSonQvouDAQt7Xng1rGU=;
        b=ovrLTQm4B3Xww5jSB7uM7i7EEPUtjjob1pgYNFI8i8+SG5ZWWTd/Ninlmtdy+oy/Td
         xD4AJuhf4miNrrZ/i4Hb3rt+16nI5Xr74OcOxPXWYxTLF1dB0j1/ncINiJ70cfkN0P7k
         IoPlTyAXhaNn7VyOWiGjQUzpxV5MjPXE6bXHDvgO7sYsAx7J2/EN0ZFUYvKNu0G0yFfp
         F0WE/BKIPPumT9CNUoiLfPCMiGCiq3PN0VY8AFCOAYyDiAnoU2nGqqIlp+SHG6i9T07V
         CcLNqd49TVrO8g+d87qdzp04FifXhURoGUbvApngiSj52hNiI6OkRgreL5UaG70uW2Op
         stng==
X-Forwarded-Encrypted: i=1; AFNElJ8/FVwzw88881H1Q3cgE21Si1uARuMrHd0rEjncXTUleCbW6EGhjBNRHePGLqx1FiHjaETOoQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUKyLcPPYkaPBDiKqyJi0PKrepOFshVsesVu0CuKdn8sRSxJiq
	KztjOOLligirgOU0xrne+3uOkJS1wJK1NvpmdHuRfY9biQNObvaUWWtt
X-Gm-Gg: AeBDiet6HOQJ+fKB6Dq8YTMe3Dh91Gd/vglAKxIH9n1xy0nnXedSrcaMs5+cGnuwwBT
	/2LqVGPtL/fOikhqg9hAJOO4XsDlis0wNy6ar23j2epdcGpBddLtzDfT/w/GADjeuhgHeyFp42P
	92JRWf8SBcIvDN9utFH6/+CqYS5qco5lIoNekmVC7UkNn5hJXARVjx/Db/EEnC5HAhOX9T5FDv3
	Fbp8MORAwQeIIE7VKdodS/a2ZRXbR2Z8LG/1YqyJbu3kCau5R+NiF67kzQdUcNjCwo6m1lAQVME
	jYL8FM1iJc41O2RUsE91/CsTeNBLuw/rVTd49k29NtC6UFkY0HTiV7vfWL80JqxP1LCdD2GKpBY
	1B8rlDw4Y1gCizrw8DZcw5Faub6MPQzCJKYmtHf7URI2FuwLz0Qb/MjG+e2giy4aWvTBhteUQO6
	EfgLzQWINSXXQhA0WFc9gsACTaDRBT2yU5pi6yZ7F9m6TkFHy82VuCCfHFSzepJcUs1akOIU67
X-Received: by 2002:a05:6a00:330b:b0:827:4343:4c1 with SMTP id d2e1a72fcca58-8352d20b2a9mr661002b3a.29.1777667442262;
        Fri, 01 May 2026 13:30:42 -0700 (PDT)
Received: from localhost.localdomain ([115.110.225.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b84aedsm3230595b3a.57.2026.05.01.13.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 13:30:41 -0700 (PDT)
From: Shitalkumar Gandhi <shital.gandhi45@gmail.com>
X-Google-Original-From: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Wolfram Sang <wsa@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Felix Gu <ustc.gu@gmail.com>,
	linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
Subject: [PATCH v2] i2c: sun6i-p2wi: fix of_node reference leak in probe
Date: Sat,  2 May 2026 02:00:02 +0530
Message-Id: <20260501203002.3382428-1-shitalkumar.gandhi@cambiumnetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260201-p2wi-v1-1-e0ec9cda82b3@gmail.com>
References: <20260201-p2wi-v1-1-e0ec9cda82b3@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9B7964AF7C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-242517-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,sholland.org,vger.kernel.org,lists.infradead.org,lists.linux.dev,cambiumnetworks.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shitalgandhi45@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

of_get_next_available_child() returns a device_node pointer with an
incremented reference count.  The reference taken in p2wi_probe() for
the optional child node was dropped on neither the early return when
the "reg" property is missing/invalid nor on the success path, so a
reference is leaked once on every successful probe and twice on every
failed one.

Use the scoped __free(device_node) cleanup helper at the point of
acquisition so the reference is dropped automatically on every exit
path.

Suggested-by: Felix Gu <ustc.gu@gmail.com>
Link: https://lore.kernel.org/linux-i2c/20260201-p2wi-v1-1-e0ec9cda82b3@gmail.com/
Fixes: 3e833490fae5 ("i2c: sunxi: add P2WI (Push/Pull 2 Wire Interface) controller support")

Signed-off-by: Shitalkumar Gandhi <shitalkumar.gandhi@cambiumnetworks.com>
---
Changes since v1 (Felix Gu, https://lore.kernel.org/linux-i2c/20260201-p2wi-v1-1-e0ec9cda82b3@gmail.com/):
  - Reword the commit message to make explicit that the leak is of an
    of_node *reference*, not of an allocation.
  - checkpatch --strict --codespell: clean.
  - Build-tested: x86_64 allmodconfig (CONFIG_I2C_SUN6I_P2WI=m via
    COMPILE_TEST) and arm sunxi_defconfig.  No new warnings.
  - Runtime test: not performed; no Allwinner A31 hardware available.

 drivers/i2c/busses/i2c-sun6i-p2wi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
index fb5280b8cf7f..652b37b57159 100644
--- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
+++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
@@ -184,7 +184,6 @@ static int p2wi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct device_node *childnp;
 	unsigned long parent_clk_freq;
 	u32 clk_freq = I2C_MAX_STANDARD_MODE_FREQ;
 	struct p2wi *p2wi;
@@ -223,7 +222,8 @@ static int p2wi_probe(struct platform_device *pdev)
 	 * In this case the target_addr is set to -1 and won't be checked when
 	 * launching a P2WI transfer.
 	 */
-	childnp = of_get_next_available_child(np, NULL);
+	struct device_node *childnp __free(device_node) =
+		of_get_next_available_child(np, NULL);
 	if (childnp) {
 		ret = of_property_read_u32(childnp, "reg", &target_addr);
 		if (ret) {
-- 
2.25.1


