Return-Path: <stable+bounces-71573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BA2965C59
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 11:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F943280D49
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 09:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DD3175D44;
	Fri, 30 Aug 2024 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AYkMPE5K"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F909172BD6
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008969; cv=none; b=scErw+T5at63XrjZ6G4BQHlUK7qazRZv6AYq3GYrmcGDRi4mOhgIF0uKQS33Ck9NO4HliQcX1zz1BYXTrh1Q00+y26SH1ySOyseS02bv/YHXwvAp9Yb40/X/hv7miCgCbOZDQdwzsgzde0d3SO78J/vhWBxDvAWUt6XZYURuSVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008969; c=relaxed/simple;
	bh=fFcbqZ/vIeJ4VTNjMGaw5nvoy7YsGVIv1hnF2lSSras=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o3bL8Mh+d1Kl7vas7X+gVSyTBylG1TlwRlIdNGySFdLvJH/qZRC3yi62ZqeJhp6jGfcLCMHtRSoUdtHFrma1gHl0I1XwzE0+D05Tr366me4/a69dj2xcxQ5hvkXYlThTOQyQJgC9+6YMf3Y7ePFxkqLdBb4xkKMkqDhUFg9KGFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AYkMPE5K; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a86abbd68ffso276618266b.0
        for <stable@vger.kernel.org>; Fri, 30 Aug 2024 02:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725008966; x=1725613766; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/jtniPcEEBTRKcAWG7MfiUPW0tfxRZJxn6QjSld5MsQ=;
        b=AYkMPE5KEaYvHGbHDi/8jLYKwyexfJvnA+FLmM32SNiu1p9SVTnxG8vHc8wbUiWXTQ
         F6ZQi6idVn3kz7jWa4hYbUsfmJwet+saW2FegsQ7pjEuB0K+2aitgD22TyvudrzQ4rmd
         ANU1qmd49vJ5CrVKJyqe2oOH3qaOq+O0+ueHptnMTeOL5iWCbWK7MhVo2E1Kf3a9giBE
         25llPWYcp0gTIAcdFdkuiab9O1j1ZsU7ojEH+x6szNSJQFWCO+zySL5Msd0fsx7FFy/e
         xvwUmk60gJDC1PeFkCz2yhh0mO9lVtvTb5dvK5g1pVOZni/APjxN8blTLeUvtC1sUwq4
         1amQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725008966; x=1725613766;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jtniPcEEBTRKcAWG7MfiUPW0tfxRZJxn6QjSld5MsQ=;
        b=A0yzoPh1IJ+bFE+GHLwrGw7jvvzByNuARdQapgeLVrD6FoYobDgddaqSHTFfsz8DXL
         gL5/MXzZ1+n8SPIeUtE2SLKyW8ASF3OeFoC0eKRg4H8sew14bPHq73gUlGgusfeB37a9
         PtoxXPW5jTDiYpiQ3U+kyS4cJUkN9wWnzQ4uZ8oVTNwFodtgsgbGxUSY09IeDe1qvjPG
         hEaaaKoLPS1vjhlh45ULsm8aVTtRyfB3xvkt0LeiYSUnKEndsLBjwmxDqIMjlvY8iRdu
         SNx3Nr3krMNbWx8YgXI9KvK+00aT1GmAD6x7q2qWN7roJKXIEh+pbGxTDqLz74WYHMxW
         PAhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjkp15jLY7xhb36202EsjlApa6UE0OKllSYW4Ck+oRKBuwFYWIFPQfjsFtRIHfYIOmNMCzgwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI85m1/sdyxdkIeI/OdQpGJIRq+2HLjUxTm1ewc8Y6cgV55+U9
	HzAtE7BNM0h16/qxqqGOgbk5ToDM+CSdpXsDP6WTbaxQL+mpawSNxIi2ngmaVao=
X-Google-Smtp-Source: AGHT+IHHiJzGies10GeD/T522u3rTjWbrbBrndvVaP8DwgXwoy/eAbJ2HNCrySNv/05wNTqDo8+X5A==
X-Received: by 2002:a17:907:2d21:b0:a72:7a71:7f4f with SMTP id a640c23a62f3a-a89a249ca36mr173053966b.7.1725008965594;
        Fri, 30 Aug 2024 02:09:25 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff1f:b240:c7ae:74d2:e4c4:8f14])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d698bsm194860366b.145.2024.08.30.02.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 02:09:25 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Fri, 30 Aug 2024 11:09:07 +0200
Subject: [PATCH] pinctrl: qcom: x1e80100: Bypass PDC wakeup parent for now
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-x1e80100-bypass-pdc-v1-1-d4c00be0c3e3@linaro.org>
X-B4-Tracking: v=1; b=H4sIADKM0WYC/x3MPQqAMAxA4atIZgOpP1C9ijjUNtUsWhoQRby7x
 fEb3ntAOQsrjNUDmU9ROfYCU1fgN7evjBKKoaGmI9sSXoYtGSJc7uRUMQWP7eCsN477oYtQypQ
 5yvVfp/l9Pz6rARdlAAAA
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Maulik Shah <quic_mkshah@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.13.0

On X1E80100, GPIO interrupts for wakeup-capable pins have been broken since
the introduction of the pinctrl driver. This prevents keyboard and touchpad
from working on most of the X1E laptops. So far we have worked around this
by manually building a kernel with the "wakeup-parent" removed from the
pinctrl node in the device tree, but we cannot expect all users to do that.

Implement a similar workaround in the driver by clearing the wakeirq_map
for X1E80100. This avoids using the PDC wakeup parent for all GPIOs
and handles the interrupts directly in the pinctrl driver instead.

The PDC driver needs additional changes to support X1E80100 properly.
Adding a workaround separately first allows to land the necessary PDC
changes through the normal release cycle, while still solving the more
critical problem with keyboard and touchpad on the current stable kernel
versions. Bypassing the PDC is enough for now, because we have not yet
enabled the deep idle states where using the PDC becomes necessary.

Cc: stable@vger.kernel.org
Fixes: 05e4941d97ef ("pinctrl: qcom: Add X1E80100 pinctrl driver")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Commenting out .wakeirq_map as well would give an unused declaration
warning for x1e80100_pdc_map. The map itself is correct, so I just "clear"
it by setting .nwakeirq_map to 0 for now. It's just temporary - this patch
will be reverted after we add X1E80100 support to the PDC driver.
---
 drivers/pinctrl/qcom/pinctrl-x1e80100.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-x1e80100.c b/drivers/pinctrl/qcom/pinctrl-x1e80100.c
index 65ed933f05ce..abfcdd3da9e8 100644
--- a/drivers/pinctrl/qcom/pinctrl-x1e80100.c
+++ b/drivers/pinctrl/qcom/pinctrl-x1e80100.c
@@ -1839,7 +1839,9 @@ static const struct msm_pinctrl_soc_data x1e80100_pinctrl = {
 	.ngroups = ARRAY_SIZE(x1e80100_groups),
 	.ngpios = 239,
 	.wakeirq_map = x1e80100_pdc_map,
-	.nwakeirq_map = ARRAY_SIZE(x1e80100_pdc_map),
+	/* TODO: Enabling PDC currently breaks GPIO interrupts */
+	.nwakeirq_map = 0,
+	/* .nwakeirq_map = ARRAY_SIZE(x1e80100_pdc_map), */
 	.egpio_func = 9,
 };
 

---
base-commit: 128f71fe014fc91efa1407ce549f94a9a9f1072c
change-id: 20240830-x1e80100-bypass-pdc-39a8c1ae594f

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


