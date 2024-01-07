Return-Path: <stable+bounces-9969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C6C8264DA
	for <lists+stable@lfdr.de>; Sun,  7 Jan 2024 16:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F71CB210F1
	for <lists+stable@lfdr.de>; Sun,  7 Jan 2024 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A44134D5;
	Sun,  7 Jan 2024 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p5u+Bq2r"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB71113AC0
	for <stable@vger.kernel.org>; Sun,  7 Jan 2024 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d9344f30caso672270b3a.1
        for <stable@vger.kernel.org>; Sun, 07 Jan 2024 07:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704643027; x=1705247827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8wGOsFTvZaO5wMPM2PGOt2oqM6jxiZ0EDOxDz3vnjlo=;
        b=p5u+Bq2ryGdgaxa0SBUPn1aoDCdLk5GL/OMk6taVBL1/C6useuA7wzwNYjVrd+M1Qs
         sbIDjJJ5R1zKSpyE4L8eBvDDMYtbMmhiftx1NX06W2RI995RGAXLZcBNcU6ZZ3IX5AAv
         dQ3tcMNYaH5b4UBzVl1BJDbiE7sVVazQMnG4oyaXv0pQoNdjPhfZ2xAQa/A3CpygvDBa
         6PEMRDi7MsPVeU/oI/SOrYqotfvsv39h1xCUk8YYC+JbSt1Xd9MJJ05xtjS7B3z1/QWD
         j7hvlv9N7VGfcirT+5zyiqWTr8NWMGHlahUVoqEKkNFNvIXtdo+mv3nT1PJescI0y/7Y
         seqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704643027; x=1705247827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wGOsFTvZaO5wMPM2PGOt2oqM6jxiZ0EDOxDz3vnjlo=;
        b=H8GIH0pYEinwI0vgpeH+uWveb9i0VzAz4GZrWdt6PMEQD6MrUFp4dzT0rRDRg0iOjw
         1bDt6SW+Banp/7NxINWWzliOpENSetNHEF9DjocClx5A0qLUAl+4QcJce5WxhRun9piY
         jNjTDpKelvrC1RMQ2bE7rwnaTAFnBl1dW2ZuGSyv67/QHjLmTbDGFG66iJ+dEEb9obbX
         6Z9Mcz4nAs67MNtckEkYtbRKh+T9LVVJ6xoP6/5XrSU2dG3SyPpb7PAptD1/XUJxqeri
         VMRzEbVk6HsKsiM8v4Co88V8xlV3m/v6LSnNIOw5gYCmqBpbGtJ005YN2bcCjVPPEs1N
         637Q==
X-Gm-Message-State: AOJu0Yy53hKrtmptZ2CCB/DuRz2SoD4oiLq4f3mOo4FhPk5UH1w+tVTk
	FnHQml01xjQfXbNUXx+FyB+v+cY2jpntWg==
X-Google-Smtp-Source: AGHT+IHh9wFhIFJqxp8oXML26YlHG6yglK79XlYLiTX8KXfRYmnsYLQ5+S8Ra8lQoG0hcSO6LgiMNA==
X-Received: by 2002:a05:6a00:4bab:b0:6d9:a856:eec2 with SMTP id kt11-20020a056a004bab00b006d9a856eec2mr2463342pfb.14.1704643027083;
        Sun, 07 Jan 2024 07:57:07 -0800 (PST)
Received: from x-wing.lan ([106.51.164.237])
        by smtp.gmail.com with ESMTPSA id t6-20020a63dd06000000b005b9083b81f0sm4362393pgg.36.2024.01.07.07.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 07:57:06 -0800 (PST)
From: Amit Pundir <amit.pundir@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Stable <stable@vger.kernel.org>
Subject: [PATCH for-6.1.y] Revert "interconnect: qcom: sm8250: Enable sync_state"
Date: Sun,  7 Jan 2024 21:27:02 +0530
Message-Id: <20240107155702.3395873-1-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 3637f6bdfe2ccd53c493836b6e43c9a73e4513b3 which is
commit bfc7db1cb94ad664546d70212699f8cc6c539e8c upstream.

This resulted in boot regression on RB5 (sm8250), causing the device
to hard crash into USB crash dump mode everytime.

Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 drivers/interconnect/qcom/sm8250.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/interconnect/qcom/sm8250.c b/drivers/interconnect/qcom/sm8250.c
index 9c2dd40d9a55..5cdb058fa095 100644
--- a/drivers/interconnect/qcom/sm8250.c
+++ b/drivers/interconnect/qcom/sm8250.c
@@ -551,7 +551,6 @@ static struct platform_driver qnoc_driver = {
 	.driver = {
 		.name = "qnoc-sm8250",
 		.of_match_table = qnoc_of_match,
-		.sync_state = icc_sync_state,
 	},
 };
 module_platform_driver(qnoc_driver);
-- 
2.25.1


