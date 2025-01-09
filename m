Return-Path: <stable+bounces-108046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42262A069D8
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 01:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7947E1665A3
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 00:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9563290F;
	Thu,  9 Jan 2025 00:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="0QVZAGxA"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B3736D
	for <stable@vger.kernel.org>; Thu,  9 Jan 2025 00:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736381816; cv=none; b=Xyx4cDlTrIvwwQvUkbpar77jyh0inBP175x553kVwpLvpyePUk3x60yOhBZCO191IwZNS4gNAjHCWkKlyHFl4VNlKAsCGnoBwk2zhX0DQLKzfkFADtoTvq4GYMK9uwhXNZPe/xuQiYnE07bGWwSGqIl+EAB0PQILml+gLm+1n8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736381816; c=relaxed/simple;
	bh=l8h45rmrtu5TvOosJ+jBSKrsJDAFrXBcjCm8awQi+3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iahVvrqZWyhd0wAJ+wdBhfCnJfUCIJNNJfen9IbQ6EOWs+K5b6PnI9CtyJ2QGEZ6cKQFzmZaOz1C9tWgB0yX4UnGTLda0VqDw/6Uv6SJFKPustu5aIZxR+BrFhe3MTm22pRhIjkA6YUlkFQBVvvDf0VG3qdyMZlClSwRqeWKhzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=0QVZAGxA; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso482810a91.2
        for <stable@vger.kernel.org>; Wed, 08 Jan 2025 16:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1736381812; x=1736986612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qwpegug0/ePQOD528Wsj7E18rEd/oQ+Z8n4jyxehuHw=;
        b=0QVZAGxAdWY9AfADKMWoRLFBhP/PKFXSaWZtl0NnhqqA0WQAAox7jFliilee2wbWPW
         PUVdFsbqhsJNXASiDmjW85FEGFDQ1ktcFiW5VitQo+6i0PQFs0Z71yld67e4F77XA/qt
         NXkOFnNOQ+Tk+RgnysEf1p1cuLJo8V1jOwNZwOng297IM0+yicSamvGXgufzAYTj0wro
         +WfmGXUVHy9HHDHgJMUg9qGJ1aDv8ikBogjb/CP5F1tTzPpP1sF1K8udRdWGJz5gfzjW
         9ftqq03ybGWffciUnFQpHAAc8Y0U2KPxJzj2v7dSBlqqj9eh6rVhVUmLHpou/nt3oNRo
         iaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736381812; x=1736986612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwpegug0/ePQOD528Wsj7E18rEd/oQ+Z8n4jyxehuHw=;
        b=LZMODRLe6Q+gmZuTDSRc6S12M0JhDh0ymsF6OTHuSLZJSLMGk3Ltu795a6XUKF2hbB
         /p5GgPZT6EPxGid79DyQZa3zeTenUEvnh6bwIgTm6voiUtQ0inAxtZYexWQl2mfsGanV
         hf3XtKfHzDktIK4lkpRVmtTCuzFjNDCdk21J3OQaDj6/WYqtjr185jqXPdzt+vUGQxDQ
         iFNli2e2xoG7mItp+jx8PDEJnWfS8ZLdz140foRs0bGE2EUQW/yQdakJbxAxDw/FEzj8
         KS89dth2yoDYGvceDZCHKVAKX5h29azu2q+72+QRetxMG/feeyCwBtb3tCJf7hBXNiuc
         Zk9g==
X-Forwarded-Encrypted: i=1; AJvYcCXGStXYkvDEACEHkeiAjvFPpFiK9TEBBilLDI8gwCsl+T0b7VSPenwD88bH4GLE03gV37NdyRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgQ8Os1nDY+jui7cu7Lve5U6kCupPUBzQuz1DzvxGwqcSqMLXi
	gaGClkcgrHIUv0Kj5CxmymkqLQpP/erHkKdHq5XVnbz9CIVCLLd7mEVlAQmNLL8=
X-Gm-Gg: ASbGnctfERHtJrD4APt4HhPOpjvbo70Wh3jo0F3bocc5uGubmGtsch0CMBwMfPNbPrF
	b213kFL8n1Pz3AyoVrtARSSal4LsXSoQhCyWFoWucj8LaHPLzs6AYJnCzVDdsHSP7RhU5KXOM+Z
	i4UIeFbaH4iQN1OuXQhPyI5ltFkLWKvfcWlXOsDxaMVowmnuK32zwSmRBu+r3Fi2A0jTbF9PlJx
	n74zQKECVFqzLjPM5RLlsWcn38UrZiys9uA7hwu2aTSWtroZ6ZSpuOTRs5U3DnRxQADu/b9Ek/I
	3kaQ6lCmZR8uuD7w2qCBAiOudzO5SMlMWttD0V9+JSI=
X-Google-Smtp-Source: AGHT+IGm+c4+1Rj8kwJa+sIZHZv9T8WSe92h8qrUfrK/Fnn/yEU9dRXJxodONZB6tsn6FYu1qYDM0Q==
X-Received: by 2002:a17:90b:2e0b:b0:2ee:7698:e565 with SMTP id 98e67ed59e1d1-2f548e9a4bemr7789748a91.8.1736381812500;
        Wed, 08 Jan 2025 16:16:52 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a2891e7sm2419859a91.21.2025.01.08.16.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 16:16:52 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: Thinh.Nguyen@synopsys.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: dwc3-am62: Fix an OF node leak in phy_syscon_pll_refclk()
Date: Thu,  9 Jan 2025 09:16:38 +0900
Message-Id: <20250109001638.70033-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phy_syscon_pll_refclk() leaks an OF node obtained by
of_parse_phandle_with_fixed_args(), thus add an of_node_put() call.

Cc: stable@vger.kernel.org
Fixes: e8784c0aec03 ("drivers: usb: dwc3: Add AM62 USB wrapper driver")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
Changes in v2:
- Add the stable tag.
---
 drivers/usb/dwc3/dwc3-am62.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 5e3d1741701f..0a33ed958ebb 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -166,6 +166,7 @@ static int phy_syscon_pll_refclk(struct dwc3_am62 *am62)
 	if (ret)
 		return ret;
 
+	of_node_put(args.np);
 	am62->offset = args.args[0];
 
 	/* Core voltage. PHY_CORE_VOLTAGE bit Recommended to be 0 always */
-- 
2.34.1


