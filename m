Return-Path: <stable+bounces-69904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD18795BC62
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 18:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5588C284C47
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 16:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615131CDA2F;
	Thu, 22 Aug 2024 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t7KJNCXw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016A63BBC5
	for <stable@vger.kernel.org>; Thu, 22 Aug 2024 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724345303; cv=none; b=HxCTZuXewwxkEFwjVO0L6CbTn9baEkbs11o28lyYHNBazt0GdBWyYLepV/e/fadXezAIvAhN13eX3ixbUXy/1VU4bVN4kpC/jFoE6VBHcZrwl3euBafs+AEvhXVMQ2+YPMMsY5q5Gx6FSI3ZH2XnJy7yxAU5v389qj4vyFSEXWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724345303; c=relaxed/simple;
	bh=W+yhKt0K2YnsfpUxEhT3jP48r1wVmHPtyOlbX9EDfcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gaqb32hxvONvccRI7wfTKxC9NgMlcaxF2yPw08xN3iMG0DUabAztvQGK8VFeZxrpWFxHy82fNaMTYbF+vlYvfAoeN4833oT9BXvvFd4mSdPpICeH6fSpMiclXKbBupOJeasjt2At9bdcsmx8gs/aj0GjKXXZR51CsE3/xtWomY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t7KJNCXw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4280ef642fbso1416635e9.1
        for <stable@vger.kernel.org>; Thu, 22 Aug 2024 09:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724345299; x=1724950099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+oILSwqOlp1bdPHfMP4vxny2FOaT2vijwwCTJAp5jg0=;
        b=t7KJNCXwolIMgk1n1Jr+xkmDttEGeV0CIDpKRpJNDnC4qlFKRA7NTxAPC4+zXuHlaK
         qoucLEHiXa5ma0oMNJXjzwLEznrXclTtLSIZo525BtITU3OiEiEGuV9EeQKFoSqtA/G5
         pRE/BNMQGSH5cMrgHVhJBvfWndCy+vFNA28zs+fxnVXjy1Rboz657Nm82HTbV+bwmA9d
         5kspDj2Yj+3Qp2/26lwTvc9UfM4OiCc2RlizeUY0sudxXUSTUPstp+9mM//9p1dQGjPD
         lIfUWirY/cAqNn6Rcg7jYhMNhYB72m3YlxEbPeiND9dbpFdWTwjDZlUDyomFbiWTGyjc
         sXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724345299; x=1724950099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+oILSwqOlp1bdPHfMP4vxny2FOaT2vijwwCTJAp5jg0=;
        b=sn66ZAhwCbRhplNJBPFbFN3NixmG6uyiH/YPWFJWQRbn6fwbd82hJwEt1gxhZ9gL9R
         z1904j6Y/MKoJ9e5fCEKkQFlhSksI8ObcAJ6ziWGOK2azM2Pl5kbjhBb+ZBcJt+DCKqh
         w+RPzHCpJp/S+ZNyb6hMGoZE/qcxlSB52lzUBhdYs+aZCSZTZcXPhe/19t1uD6fP9Nac
         qONe6hQbMTIzX3PG+PFVIw3ez5I8O+GdqT9CZeGrZAAx5SKcDGJDaZW3vPgIhHQrfSmz
         kTSl3TvBq+sqU3wHc19DL4P0TAQ90xBaf0DldUMDusKzEiXN3XhUomPdlTe40MVjM0ML
         0yUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq8zVxBs7ukl8aIO+EoFpBON840OAwEqQlUaA0owDHYIBtL9r8h30KYONveuUKHzNICR9Lsbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkIuBdt5aFKeBn4CoZqZnoUvv2yB/X+B0Wflu61XPLArnKGIlX
	PS/vPBINdK9yEX8aTxcugDP4MeXXOE5CvnuaHPUY+98f0BeHY90vcXbTMO+djV8=
X-Google-Smtp-Source: AGHT+IFQK9BFp8WZQ2dHiYAJunbO3nUd6mwUMRCTPG+YPkZQ6xmuIam6FqpLPHkNWB94UH9ETgCd4w==
X-Received: by 2002:a05:600c:1c8b:b0:425:65b1:abb4 with SMTP id 5b1f17b1804b1-42abee8bcb6mr26258155e9.0.1724345299173;
        Thu, 22 Aug 2024 09:48:19 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730814602asm2073890f8f.44.2024.08.22.09.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 09:48:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] soc: qcom: pmic_glink: fix scope of __pmic_glink_lock in pmic_glink_rpmsg_probe()
Date: Thu, 22 Aug 2024 18:48:14 +0200
Message-ID: <20240822164815.230167-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

File-scope "__pmic_glink_lock" mutex protects the filke-scope
"__pmic_glink", thus reference to it should be obtained under the lock,
just like pmic_glink_rpmsg_remove() is doing.  Otherwise we have a race
during if PMIC GLINK device removal: the pmic_glink_rpmsg_probe()
function could store local reference before mutex in driver removal is
acquired.

Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. None
---
 drivers/soc/qcom/pmic_glink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/pmic_glink.c b/drivers/soc/qcom/pmic_glink.c
index 9606222993fd..452f30a9354d 100644
--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -217,10 +217,11 @@ static void pmic_glink_pdr_callback(int state, char *svc_path, void *priv)
 
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


