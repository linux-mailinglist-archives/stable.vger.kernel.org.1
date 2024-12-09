Return-Path: <stable+bounces-100160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F619E9307
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 12:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1081885D2F
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 11:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111CF223709;
	Mon,  9 Dec 2024 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/BQYd1b"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D1F2236E3
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745391; cv=none; b=sEYPneLH5lK8KtQX31JHQUMrqHtaZ4JVVkmm9XfT6+yrYJEf74OUqkXoEAMU7Y/ZeU3QSIYSQGeAfaxryyKwU+0mE+xxDY4P+kkpVQn8q/oQXqf+08OFLCNMqgjQdQuvLz5/gLecYAsUC3FDAD8yr2L+y2ig4LFTUzjo2PWDvDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745391; c=relaxed/simple;
	bh=njRJMFS53oVLlFPOfYmEgfNE0jHwMkDusGCNOuUeDQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dl+vIJQ/NXqUU54VDXXBtiCg4smjYLm9J8TTZNQ5C8ovmZhHdBneuuYqJ689ytX6XlmMPvwrmSIbkBd8KNOTHqm3QpU2USW2pgi7O+6msEI+mXC8e3igBTtYMqhnsYMkq3GLrq/mBVSrf40l5vyT60QX70M0VwdRrFqSOCsXda0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j/BQYd1b; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa6647a7556so35161266b.2
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 03:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733745388; x=1734350188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDkrPmX+rnC8j6/Av609kaQIfkDAMEkIyzULcEtJ5go=;
        b=j/BQYd1bNGzUkFsKBJ97waycncUj6HWilLt2nGPQr9Wp3LE/rBSW1qHpru2HWJoQlO
         MRqLdiQSGJv7ewJXBGrY+Vnei/L0QJhg/NJTVdrvKtKfO42H7jcyHCwntu3aJhUIl8UY
         t0qj9Qdmu9+E5A36Lxn1ee0Pauim0RJLtyfeSxmlYODjfher7O6LKzeAoNeftXWAqipG
         sCky3v+8JHnfUzd6e3nQ9ruQl/zpbIg5R2hazKrLL1o3fmO5r/8mXAyoFizp0zMadLv3
         VKUw9LeYn5RJiP27gE9ydGgFq4kRocg80kt1/oWxkSx2MEFDaq20LIuDU9A8cPZw06KE
         MneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733745388; x=1734350188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDkrPmX+rnC8j6/Av609kaQIfkDAMEkIyzULcEtJ5go=;
        b=cQUOuIhKuZU/8ugzBdcm2hBc+V5R2ML+1dTTHjBPm3NRH4NbRjwD/f5d+Nutoa0tcb
         iaTsa90Ycieu/Ubl+aBs3yCSDdsOZDFSMxxuElBD1rJYes8zD5r4aZe00eURqk4z7t+Z
         QHRJiMaW4+rIEMccFHKcHygDC2F7pAOgfhdMDiQ3y4athWjB94ceFJ1JC2UyGocj5JOs
         XXLeBUrAvj/ycNjOKyA2ERyZJHolwfuCMgKTJndJ+mZwTfflMX8bxTEGFKE8x2lRm+ma
         TnGS0aZ7MHYnZ6Hb4zswMlHVCEixix9JnW12XnA1G6J0pGN/PuAtamJDhWIxtqgeApPN
         mUTA==
X-Forwarded-Encrypted: i=1; AJvYcCXHCGHFfOWRK4F6h/EIwYjUyqzWb/x484xXmRoGkmS+aHr4gssgMeKSJTTyHCqzEzEyYXw4uvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQrD1zOGsZnrePm0IHWKqOESxHj313bWCw3hxw5Tf9k1mYk6xH
	N6LJGLUAH9NLqBECAl4S5B027KxaoPUGPKl9iPeWmA/BdqlL9eGbSFSsCL2VQoU=
X-Gm-Gg: ASbGncs1erP8QvFNdTEcyql+7PjUkpREgVnEyWPT0vqayRFcz3VIXy4VqGZbVcpPTwa
	h4WaGbsD/5ydKoOmkSaTGFkZQX6Be33ZMsKX/qHO96GxrbBJ996Zvptle0fgg5l8NHL5Y/0p1Nh
	x2i9R0luD9rd1cmsJttaU/9yPqtUk/Xonrv5IahVsFc3bqW/RsdOrNU7DXiepGW/Wxd/OCQgVgU
	C8CyKA7TmDpGBeRP1fCZS/3yUw+pj7g4HOgghZSIted5by35HE4+mSCpaoCOojw
X-Google-Smtp-Source: AGHT+IGaZyqKQzZD247wMomlUwBJH4NbdZftbTBnrY74rFdm2bKBbV7DjbALRQ98dOG8bxWswacXHw==
X-Received: by 2002:a17:907:3f1d:b0:aa6:2572:563a with SMTP id a640c23a62f3a-aa63a10f275mr510577066b.6.1733745387038;
        Mon, 09 Dec 2024 03:56:27 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6651c01c5sm343333766b.23.2024.12.09.03.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:56:26 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andy Gross <agross@codeaurora.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 3/4] soc: qcom: smem_state: fix missing of_node_put in error path
Date: Mon,  9 Dec 2024 12:56:12 +0100
Message-ID: <20241209115613.83675-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241209115613.83675-1-krzysztof.kozlowski@linaro.org>
References: <20241209115613.83675-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If of_parse_phandle_with_args() succeeds, the OF node reference should
be dropped, regardless of number of phandle arguments.

Cc: stable@vger.kernel.org
Fixes: 9460ae2ff308 ("soc: qcom: Introduce common SMEM state machine code")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
1. Add Rb tag, combine from other series.
I don't quite get why rest of other series was applied, but not this fix.
https://lore.kernel.org/all/20240822164853.231087-1-krzysztof.kozlowski@linaro.org/
---
 drivers/soc/qcom/smem_state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smem_state.c b/drivers/soc/qcom/smem_state.c
index d9bfac6c54fb..cc5be8019b6a 100644
--- a/drivers/soc/qcom/smem_state.c
+++ b/drivers/soc/qcom/smem_state.c
@@ -112,7 +112,8 @@ struct qcom_smem_state *qcom_smem_state_get(struct device *dev,
 
 	if (args.args_count != 1) {
 		dev_err(dev, "invalid #qcom,smem-state-cells\n");
-		return ERR_PTR(-EINVAL);
+		state = ERR_PTR(-EINVAL);
+		goto put;
 	}
 
 	state = of_node_to_state(args.np);
-- 
2.43.0


