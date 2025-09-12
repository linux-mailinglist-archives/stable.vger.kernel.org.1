Return-Path: <stable+bounces-179323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD317B54361
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 08:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E4023AEE60
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 06:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3F325A322;
	Fri, 12 Sep 2025 06:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaafTb8g"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11CF288C20
	for <stable@vger.kernel.org>; Fri, 12 Sep 2025 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757660315; cv=none; b=M7OJEZYXT9wrZMqeEovKYKqMu5u/SXdFfVGa/KNd0OLhHhBt97thVeXYZUQcPy4nQINSIr4Hss+ULnqjhETzRvgStpQvpadAoEppu2BUg51Z+gkPYmIFSokFhemY9CPxBFGQYo0zwa+70CpBIwxODWeOgrd7ZEb38tzpW1O2kpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757660315; c=relaxed/simple;
	bh=8TfzZUBqjm99Lv0DtKQGLxz8Dzj/5CdxPaQVEVowkqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tzq31QT7ZUBDxN8afIhcNhX2PW+hauqG65V/BsxBkJLe6JKk2LZ482RSBJLHc2Y4rAh57N+snIdboUcEurg2lGe46qSttEpxB3YSVun8+ibQKu7emrGbdbxfY8azQz52K5gKrS5EjgKQN47usvrCamqWXkbHekDpMp6wa25OHLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaafTb8g; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b49c1c130c9so1099732a12.0
        for <stable@vger.kernel.org>; Thu, 11 Sep 2025 23:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757660313; x=1758265113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXmcc2ewtpmmvTJU99Q6f9DbOB67NALzkUAGEjMJHk0=;
        b=LaafTb8guNeYCrQ95QJbtCPSD2SkHygFjyik6Z5ncLO1+SlzNEdmcHdqVVjHZsyoB+
         zqrj7wwONmQog/rsWdZ1eJDIlZdFVRkiv7DXTwZBVIKBZb2xwW5NxYzzeSxVdQ7jsjJU
         gCIDtambz3TdFgx/9wVH4UZE4EN85QgT/Bg9pNvMyuObqBNhFRL2VVA15imI42zBbEHU
         4N6kpNlhgMbUyaK/U0RYIIXvjXIki0BBL/A0zyD/Y+GiNsDwB0Dwv9Yf8v6U1E7XAy9W
         AccEcl7cTNTqp6R0kkpvFMfu1wMP1tYEH2sfYk8TCtHdIFrQKzPlX1FKNW/+3Z5fKYnV
         EPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757660313; x=1758265113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXmcc2ewtpmmvTJU99Q6f9DbOB67NALzkUAGEjMJHk0=;
        b=GPF4H3nzaml8IetQPV982QHfsGoo3Xw0QLcZkklDBLFWtOIAs3yfz6X7Q4ZhNArkZe
         Cfo6w59pOeLqGTXZuHJUWacSINQxhRrhPoczm6jkUbo/JmC+Ws9WI6PhEg5VWEqOG61p
         j3uArgWOTsJDxdiB/Aj5WA16Gq2SNI4O63odDaIL1Hx2xX3FX1TJFNYeQa53yJgOtd74
         vT8YuuBMCH8DoT/vvxmqNLtMDUFj2x/FDiLsHhUvtN4E2+b7+oyWVgU8fTfVy3zFHGgQ
         3thBpvRRnUVefXotJuaTh/mopLF6Iak6FBhKWVKP+A2lZc8OyVvDKHlYgu3AnHTQ4Bhv
         vjXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbZQ7T9RYxclioia9dh0Lf9+J5adHqMXgdi4UELPBilFmH7+7jXI9Ug6ScoNjOK7f/uCNfWVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNAGbkDqjGzKnmbr1SGrSEQjhW+I+sWMXzfam9bfJ/9us5m16W
	KQAFikxjgp65YV/u2xX8DLJSPKRUtTGrMVs23ns8Rfeyc8weikcASkK3mLYFy5wI
X-Gm-Gg: ASbGncsv0NHT5yE3h+MNyV5cgDzEfmAJtCXEN0cfFO+R5VnICOzilBH2f1EkSrwIceD
	7Q9y3EZxrepr32WPwj88C6LBqIZMkiGskEhaMjYG591d0307alUdOTznE53XT88Jxk+PjnrDvmG
	4ho7c0ZobsElbj7vvgrKIDlN7WdHvsknMJwmNNATnCkSBzi4cbQCKVlJRG2qR8w0qfYN8WT5mFi
	RepetRKRMnDilby2a2b3BrKOrj/2SWiCADRSt5M5/80uvnPxZY+0kJku2PFrXaZkNA7rZaj73q3
	H4pCspiADZY154GJy9MhznqGxs4AHYJSScMxpF1h0KpZsSC3SX0k/TeZrXBm43vBk7lg2D6fo+a
	N3RFt4a8o2Mel42pOT93hqYRX0qidwAEP+9cOWVFB+OdYPechGA7p2TQ=
X-Google-Smtp-Source: AGHT+IFdyNAuzOZ2zUjYhsBATyAu1glXdJuXPKDSepqTSV6YIh3T7sl2NU3wxdNKxLBK4SUu6Eq2+w==
X-Received: by 2002:a17:90b:53cc:b0:32d:dc3e:5575 with SMTP id 98e67ed59e1d1-32de4e710b1mr2279177a91.5.1757660313193;
        Thu, 11 Sep 2025 23:58:33 -0700 (PDT)
Received: from af623941f5e9 (ai200241.d.west.v6connect.net. [138.64.200.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd621c790sm5041597a91.11.2025.09.11.23.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 23:58:32 -0700 (PDT)
From: Tamura Dai <kirinode0@gmail.com>
To: kirinode@icloud.com
Cc: Tamura Dai <kirinode0@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sdm845-shift-axolotl: Fix typo of compatible
Date: Fri, 12 Sep 2025 06:58:19 +0000
Message-Id: <20250912065820.54215-1-kirinode0@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <38c24430-16ce-4d9a-8641-3340cc9364cf@kernel.org>
References: <38c24430-16ce-4d9a-8641-3340cc9364cf@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Merge a hibernation regression fix and an fix related to energy model

The bug is a typo in the compatible string for the touchscreen node.
According to Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml,
the correct compatible is "focaltech,ft8719", but the device tree used
"focaltech,fts8719".

Fixes: 45882459159de (arm64: dts: qcom: sdm845: add device tree for SHIFT6mq)
Cc: stable@vger.kernel.org
Signed-off-by: Tamura Dai <kirinode0@gmail.com>
---
 arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
index 2cf7b5e1243c..a0b288d6162f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dts
@@ -432,7 +432,7 @@ &i2c5 {
 	status = "okay";
 
 	touchscreen@38 {
-		compatible = "focaltech,fts8719";
+		compatible = "focaltech,ft8719";
 		reg = <0x38>;
 		wakeup-source;
 		interrupt-parent = <&tlmm>;
-- 
2.34.1


