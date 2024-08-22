Return-Path: <stable+bounces-69903-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DC995BC29
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 18:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF6C1F26D69
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 16:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C451CDFD1;
	Thu, 22 Aug 2024 16:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jgoU3StG"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D1D1CDFBC
	for <stable@vger.kernel.org>; Thu, 22 Aug 2024 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344990; cv=none; b=ungXLCl/Jo3SxV/yqqaTiszD49m1rZU3zMSDblsyvlNrhjzUYaMq+zaxR6IYNSYzCUAfB6lUqJLBWLKrMyKLVE6AeDPHIWO9jjNP77qAK81w9/tJF/lU55l1V26biSmMte1sWJ8tEoXUfTYlwp3JZts7CZy1ra5Gcmp1R+ZzlZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344990; c=relaxed/simple;
	bh=WORizGtRIG3wQEd5cKsiYTz4nE4FIsBA2fCtRinTt8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SS7SW75QYEyR/vgshqAE0hU5XHozoUrY/VSQd5+e7ztLWCK/ydNNW29DCdPFWKCNiop8mtfEUl2JmSmR+m+vSDrjFTnE9w/Qjnl476dC1sxSnFCwdmclMTMrAJPAIyxAQagjgz+T/ywMwe77B2JcvajYW3IxEQyFIzJIxIfEbhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jgoU3StG; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5beceb61e62so137352a12.3
        for <stable@vger.kernel.org>; Thu, 22 Aug 2024 09:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724344987; x=1724949787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2Jn92E/Ky5nVM/5+Oud+V0WsM8/cEIOvqMjdYQHvInY=;
        b=jgoU3StGDINJefkaofltccf/S+1Plw27anSoR1O3EoWYIGvT+xxlnNAvwsSodj6p83
         3cymQ5Z6Lfd7lvfvZhPeegdBZJaVsuI8rQePhwuhVOZuFo4omMqOiU8RmutK2q9Oc7v2
         8Cd3LDcwzoXlwPF21P3Vp/abChEcCwbt99Biz5ao7JoBNtCZJ/llSykNOgJtDQgOXQsQ
         XFsvpCNFV2KzV3yXBDPvJcmz+5XhaPulSTv/rer9IVRaf2WS6EaZDFjZyBIJRM5YhuP1
         /IQy9RjYANJUCEueyuSlJm1veRXqqXnsc4PF5KRsR5Fj1hjdGGt/A+mFtIGbuyGTQC6B
         QEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724344987; x=1724949787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Jn92E/Ky5nVM/5+Oud+V0WsM8/cEIOvqMjdYQHvInY=;
        b=kfGadv5wmGwBVNvhZjugYnfWu+xMud3Wo523eF5AXdxTpzNRuJ/r0ISqvNMSspY/m5
         WjgUJwffuresECpTZ3m24PTatbcjy7sNKplF99vIKKgXqRO87BqL4+KE7dikBnBzeTxd
         h9OerFmmuIh4S6NALWX+SG3VYFODGXJVXXW90Hudbam3C8O/BUgvbaxM0+yfLlNmucdH
         8hvrpOxe1QlWjY8UPuCwxGpDCLCupDlx6nuFHyycwwrACiTIxtElkraoBiq2OfQlcQxy
         GFPoqheq7Xz596ZR1NPX7adkYiHlI78jtmDB4RfRo/aQQJGclDQqTWZ/GciSj416dvFb
         tmNg==
X-Forwarded-Encrypted: i=1; AJvYcCU0Qn0eR9LlddRTbm4L7+lkzIqcgtJRUieJd+OaPV3XVQdk6Q8dQbQNxBj3YvScWX4a2Av/LZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWmHTF7UTHXBR26yQodiDOltN0tNg7Q4Dr5+NX3THOyAFRZtyO
	fj+yf0mpSin7Hzff8my6QxEXuVLfuX8UKah0za0EUDItT+mb9948wrvJI5NkhYU=
X-Google-Smtp-Source: AGHT+IFWHvOSWI8W904tEjwil9ah8KgnsIfJo4HPKhd1OzOwIfvV0E+wvnktUkdkVAXtJ+4ms/IStw==
X-Received: by 2002:a05:6402:34c6:b0:5aa:19b1:ffd6 with SMTP id 4fb4d7f45d1cf-5bf1f27b2camr2444941a12.4.1724344986388;
        Thu, 22 Aug 2024 09:43:06 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a4c59c5sm1103432a12.63.2024.08.22.09.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 09:43:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Andy Gross <agross@codeaurora.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] soc: qcom: smem_state: fix missing of_node_put in error path
Date: Thu, 22 Aug 2024 18:43:03 +0200
Message-ID: <20240822164303.227021-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If of_parse_phandle_with_args() succeeds, the OF node reference should
be dropped, regardless of number of phandle arguments.

Cc: <stable@vger.kernel.org>
Fixes: 9460ae2ff308 ("soc: qcom: Introduce common SMEM state machine code")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


