Return-Path: <stable+bounces-100159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8823D9E9301
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 12:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B57287111
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 11:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF97522146A;
	Mon,  9 Dec 2024 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X6JsH1GL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96D61F931
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745387; cv=none; b=bhuq8plLIGv3LJI8FyTKKyLiEWPxqRfKng0VeLVnmVdM4OHqI0ldBv+FuLWwDwVAYeCzZDWZfX7SOZByCKKRyAJBxh3KFB2szw5Y3Ge/gM21xCr39QRcD37vfStLeqg9If2JkCT2Wbkw2sxrwWgvjp9bo2mDEpCfvW47J39doDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745387; c=relaxed/simple;
	bh=0LO2zPYAqi4rqcBhiJ1BLvPKoKw9ftNC08/t+0RUAyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VgLWrVrbbjQvly5cehyurokOON7idEZw40BoI42pswocEeFzFN5k2WW6+xrSKE2KO8mcP1cYKkpli0Y+ca5JX8BNOzJ9IfkuLCLSkXQ3KytQqIAepPIH1Q8+ZaYpYzHQCMkNUg2fY78iQRKakGBwKkw28A9g0++Rcq9Vb5RrL8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X6JsH1GL; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa551d5dd72so77725566b.3
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 03:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733745384; x=1734350184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Useh55TM0tjeQrnlgj6s0Ix5hvl08p6sYbXbXf2KJKQ=;
        b=X6JsH1GLHuoe6kfgGxVKIvfazeDh8iOL85QGHntNsMaBLMUmxlgyTpfb4mBQee9OUK
         JfO2SL7OxbgJDCbj5RwzwcfkJbwZjW/rNjO7fj7YNqfNBzwEy95ucNsPiDBCfdkgQq8H
         B2rEnuByrFrlaBqZRp+lJpl+FQEXp4Q4VGHIuYH5kgCrVszfHl980j69SNaVaxcQ4iO9
         P/lwNGSNuIEzAGR2SeSwmSNQHEdkqPjsqcmH8uIVJ3Rd3ZTRjTwdZGmpAN7oPjd6fFiO
         DbmIEL61/1AqKEUvXrr4075OWj/uFYvQXXk5EhJdNPhwcyVmRmG9LVTsfo0wpjNKiUZa
         gWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733745384; x=1734350184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Useh55TM0tjeQrnlgj6s0Ix5hvl08p6sYbXbXf2KJKQ=;
        b=bS99Yhc4wp0a2/ULxHJDnQHNCdKH7Sftywo23PliT25hiXcvVhOlQKMuR+re7suPaw
         129S8qxzOlhZygRGlmiixXSqd5oNlYg2B+zENkaL6YHO5v/hbbJSSYhQX9zYM9iZ62sW
         /lUr8aOrukwURtgLqHqsrerVLXtRkssk7CgVO9A+1w4udn77fG9u4FC6TBiTE1AcRCsJ
         dNOrls2N18PYTv7WvNfXcc6r6jVMEKZ6e1jRHpqtbT6E3sfwROl/Q+2mV+W+JRxgBe2S
         br3KbAuMx/9Uxx+p1sWUFDJ0dbnDgsrMTMazle/8FYA5oraJLaWbilP9nXOeYdqdvjz7
         YXGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTahJRA/HOi+UBx8wQq1cIrweS7UCEPWlyVyKQX7O0tnb6VDkN58kd5TxwJhxbIqEmRGTcD4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxugsH8QRqkluprMKLnfDYVRapmifsxdFikrQ69sKOczDYqJQon
	RvR8hEIArKfyNe5XT/n5kef1/gEuJ2n/+ZEecpwv4pyVzHWPHoizwUh+40IVYuc=
X-Gm-Gg: ASbGncvBtxf/e1xwPLk/qPskYQOjrhi23LWbV+n7aV/BADSuEAhtpk8e9FYxAVG0Z5E
	Yr/RpeBSO8eNeHiaQ24LM0+lmJV19IAKsd/G6/pAPhfHqhOYY0cQhFnMWXq+i/TftK5Kef1lhsr
	VcOvrUOvKWVlJhk9bLxDUF9Xz9yR2Mupb908M2ii/k+aznNpW02bgWfODHmND5tIW7oiBMs+R08
	Rz880v2j0EeypNXFVgG1vdBd1Ihd9LiE48NPcE/QBsz5mMOPUJqQNYgBQ17ZFHg
X-Google-Smtp-Source: AGHT+IFy0QEwd71L8F3WWzjmNnwcpld/A/VFpC2mWyELkqnYLuwFzGiop941yEx4OjXTcWiq0BYq5g==
X-Received: by 2002:a17:907:7d8c:b0:aa6:9b81:e7aa with SMTP id a640c23a62f3a-aa69b81e971mr17438066b.7.1733745384224;
        Mon, 09 Dec 2024 03:56:24 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6651c01c5sm343333766b.23.2024.12.09.03.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:56:23 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Andy Gross <agross@codeaurora.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/4] soc: qcom: pmic_glink: fix scope of __pmic_glink_lock in pmic_glink_rpmsg_probe()
Date: Mon,  9 Dec 2024 12:56:10 +0100
Message-ID: <20241209115613.83675-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

File-scope "__pmic_glink_lock" mutex protects the file-scope
"__pmic_glink", thus reference to it should be obtained under the lock,
just like pmic_glink_rpmsg_remove() is doing.  Otherwise we have a race
during if PMIC GLINK device removal: the pmic_glink_rpmsg_probe()
function could store local reference before mutex in driver removal is
acquired.

Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
1. None

Changes in v2:
1. None
---
 drivers/soc/qcom/pmic_glink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index caf3f63d940e..11e88053cc11 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -236,10 +236,11 @@ static void pmic_glink_pdr_callback(int state, char *svc_path, void *priv)
 
 static int pmic_glink_rpmsg_probe(struct rpmsg_device *rpdev)
 {
-	struct pmic_glink *pg = __pmic_glink;
+	struct pmic_glink *pg;
 	int ret = 0;
 
 	mutex_lock(&__pmic_glink_lock);
+	pg = __pmic_glink;
 	if (!pg) {
 		ret = dev_err_probe(&rpdev->dev, -ENODEV, "no pmic_glink device to attach to\n");
 		goto out_unlock;
-- 
2.43.0


