Return-Path: <stable+bounces-106282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E7B9FE675
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 14:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E625161D40
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 13:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFCC1A9B20;
	Mon, 30 Dec 2024 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQmLUI/h"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFC31A4F2B
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735565434; cv=none; b=Hrb7cMQRz53ykG8ADpq3DQ8OtAqDClQEBSFwgq7ef+MQSlrcfZ/ieEkH/exSgiJm7+DLOzNxNI3aZnSn+Q1CbSxgGzSrhqb8dzHlr10Xf5kxWmb/IeMFoJpQbqlz4NI6V3Y6gQd/evg4QB0r7QQkSChLYK9U303KMTW9TQJDxuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735565434; c=relaxed/simple;
	bh=95yOJU1VQIxVEl1re8QM5fh7nv37jOqHWqJP6VF+aZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iMIrVtSaOnX7PYms+FA+eKFwhYZfjggsmyqgyog0P0ZxjT/uwJIDDdgyOXGD/pxaej4ov9AXlN1NMDB/lsx0Y7ElrYSGIJn4AWVwcsOw5LbpH3gjcSsyooOousTl6zTgq9QlygGXdJV/UoU6vZ6ybUdbtby+/TG3BYUYeWhUMzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RQmLUI/h; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385deda28b3so6695257f8f.0
        for <stable@vger.kernel.org>; Mon, 30 Dec 2024 05:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735565431; x=1736170231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H+7xtqqtkp033OeyM7tyDLWsNcEaw2gaAkIZmZbhgBg=;
        b=RQmLUI/hv8UxLTUPl8LUTisIc0WB09ke4UtGnplYcLFXgaoM6WBnISi3iiFsD30p3J
         EaPbW2a0z4Z1D8eT9xnnE7uU2iF93+beGLsIjcRTKTSBE/gUG7Ox6woNsUDdvZcqAits
         p4jNtD472FJPjXUasjfXIiezwYaCwyPrLMl4Y2pRbIRlm11ot1gTSkn+DouM88zqdcPj
         oz+I3tysop2hBjZCIxeyaWHZi97l7Hc6IGyHFRyAjybwudQiUjq8c6AGiH90PRs86eN2
         PikHm+rPJuXCXonB3BgmpFCkzHeQOUn5sG2FmyNq4TaBT63s65H6oY2e0EP2vQLisJJv
         OEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735565431; x=1736170231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+7xtqqtkp033OeyM7tyDLWsNcEaw2gaAkIZmZbhgBg=;
        b=SvnYZNlr3Ip+Zt1qGnOTEdIhBYMTQqeQiOb9uyQic2vnO8dc6GG/du1r4jLeXCYTkK
         3FFDOHihgvTx6rDRgC49RsxMv2jfG5zcsxAEqB9O9wteOHMfoB95B6qHTpme3qRPFOHg
         vB+u47MOP10JOp426E6lmaNovCNwkSpUUsuQFMBzjKCaUwyVw4GF4/a57+dmzw+eCSL1
         diqW+OohszoGa+mDwg4AlEuzeonoUhr5Jx8YhGu7b1EWYlsgr2vQ7xhQvR9olLu7sZyv
         7T7OLxR6Wy8Y7RvFzYF/g8EZyOLDBqhQ8CndmtH5SEBOHmjacesN7n/9OQhrTPktOB2f
         +Q1w==
X-Forwarded-Encrypted: i=1; AJvYcCUxz8JUqam//NOkUEBmav6VsMnnurR5M/OER3ukNzQxM9pRg3MPiFICrZMCqZkwZDK+rFdQxA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd27s1DCc1penjBDqWwO0uTF9RQIfFndsGQcAcVjdtlgpNl18h
	p2XgDOcmQ5KF+/3iWEm96bQv3gnq9s+Rq+wPxaPMd2/aBwdeaAcHdo9QJOKGDPc=
X-Gm-Gg: ASbGncuQ3mmM6vfaStOu/Ur7q66RG57JuSGKp/RMxfxOiai5ab/jBGohkI2HU0XqvZ7
	PQ4ZAxZSXwx+AkV9KT2DtpANandomViuwCwgU3/Q3MMDMA6YC76dhMnRCGeT10dA14Zd+57qu5P
	6FWyz7zFzXSY70qyYoNNQ0aTTEWKvCuilPP139EYtZEzS5Mw+iGixPC0GFAoRJxFn8h8XobttCm
	NFMVBG/ef+yb067VjKihfkNKaC3s6fAdPHlUd7H2HwytBX24DX9aUuuOk022XyNPA==
X-Google-Smtp-Source: AGHT+IFmCgtOdjnwvghX/v1AS76frg41vQn9vshRFjLcdgo6QJdoBCPQr0LD+fyMTYsbsDCIjUPY5Q==
X-Received: by 2002:a05:6000:144b:b0:385:e37a:2a56 with SMTP id ffacd0b85a97d-38a223fd302mr28676119f8f.52.1735565431271;
        Mon, 30 Dec 2024 05:30:31 -0800 (PST)
Received: from [127.0.1.1] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828d39sm31079082f8f.9.2024.12.30.05.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 05:30:30 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Mon, 30 Dec 2024 13:30:18 +0000
Subject: [PATCH v9 1/4] clk: qcom: gdsc: Release pm subdomains in reverse
 add order
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-b4-linux-next-24-11-18-clock-multiple-power-domains-v9-1-f15fb405efa5@linaro.org>
References: <20241230-b4-linux-next-24-11-18-clock-multiple-power-domains-v9-0-f15fb405efa5@linaro.org>
In-Reply-To: <20241230-b4-linux-next-24-11-18-clock-multiple-power-domains-v9-0-f15fb405efa5@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-1b0d6

gdsc_unregister() should release subdomains in the reverse order to the
order in which those subdomains were added.

Fixes: 1b771839de05 ("clk: qcom: gdsc: enable optional power domain support")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/clk/qcom/gdsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gdsc.c b/drivers/clk/qcom/gdsc.c
index fa5fe4c2a2ee7786c2e8858f3e41301f639e5d59..bc1b1e37bf4222017c172b77603f8dedba961ed5 100644
--- a/drivers/clk/qcom/gdsc.c
+++ b/drivers/clk/qcom/gdsc.c
@@ -571,7 +571,7 @@ void gdsc_unregister(struct gdsc_desc *desc)
 	size_t num = desc->num;
 
 	/* Remove subdomains */
-	for (i = 0; i < num; i++) {
+	for (i = num - 1; i >= 0; i--) {
 		if (!scs[i])
 			continue;
 		if (scs[i]->parent)

-- 
2.45.2


