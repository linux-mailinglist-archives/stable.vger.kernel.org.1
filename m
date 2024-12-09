Return-Path: <stable+bounces-100120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F09519E8F9F
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 11:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C126188589A
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 10:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCA82165E2;
	Mon,  9 Dec 2024 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NeDTtaW9"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B29B21570C
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 10:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738670; cv=none; b=l1c5gA9fwFwJWxrk66szfaIf7lvhrKEkyePkVM+WO7AjHUxP/1Z0c/q6P6joXz6tUuy/ZA36YLXNMsmSe6XJQyLSmg+faVfFV0oKerFq0XuynDjTz1V4toupSmKJH8pnls+NTJhlXBRd8R72CWsmkeair8coqYGsvCyaeTWP+6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738670; c=relaxed/simple;
	bh=HvzRy8I7qIhgbnNkEXgHJ7c/6fH0498enq7qcWDIymM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d3dr1SLWz0AfEIbaCJ7YX/sEUB/fqGnR0Q62UfeoPJ2eo6Ih9qmwXbc8gqhD7xNGWrGgjP/SSDbRwYFY9DMDXmujLMe6aE3pUOyCCTO8iFv+i98rKV7kGwLscAxNnNZy5flHUS1Eu5FMN/juqBUS/ME8/rIE57XjmtuB5HiINEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NeDTtaW9; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30037784fceso23046231fa.2
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 02:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733738667; x=1734343467; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rmWxFsC0cXeaHocQ2mD5SsVuM9dd3gaFPe/qAhBEfRw=;
        b=NeDTtaW9iIBCm5oiYfpw5yUhl7Brd1hvtnqswhlyrho4y1S3C7nsCd1lzTm2vZq9j2
         40ePDyo21AjyYjsOBqA2z6GR4KZX6+fTwUxZ/cpYPbsOkQiaeGx+xPaFpg/Ean3CLYNx
         aGiLmb6Psmf8aBt5kql1/ZOFEQb9ggfE1Q9SY5wh2dD7f4fm2FdCtYwZzEVCMGoj/mlp
         9vDpvHHueurNOhotOd/VaUEz7qKlnzZRYiW/9P53P+b6xxM5sdE4Y6plII+9l7VQ6aFE
         9xlkLiwgzWMW+ma7WI9hdz2xKt5ozcQbTnqost7o9jMZf4lo+Tt04CRwL0/BvdhIlc5a
         RwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733738667; x=1734343467;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmWxFsC0cXeaHocQ2mD5SsVuM9dd3gaFPe/qAhBEfRw=;
        b=XNGHA+2IoDYUYTTUMohMUvZqGyflPllQ3MWTESazQ9GlV6AtNSiv35pGpOyB8tu68x
         TkWNJUazXPhRPX8wVF+cs4/GpVzTZkREsvlouqYIx7a/XshwW1McY/xsdld+7oksZczB
         gRH2M6YlvAJe24wUboZPGUmpvi6BYQkJxxjI2uzdtWRyp3Y9Xery0ia9tZiMmKuKpDsI
         BTYx8CzRApi5bhzuhsp2Ciog0CXTjZn2d2Y6mvc5Dz1WeHnVAwoBxAsWwnY72EosPqX0
         sMQ2kraVfJX510ireoLbEc9uzs9welX/Mtukz2JXgJMkVuhx1YPOK2Dwl4UAAEroXMLu
         nk5g==
X-Forwarded-Encrypted: i=1; AJvYcCW4bwz5P3kNN2KhEG8fTXLd5BtMRBIuThAZ1ir5V/g63bKv42c9ob7R4XHGUpep6t+9X8LeMQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH29ZX1yXoDfbiGSZvKHCrzGlMkiK5l+Ry3jm1qoOR/iEjhDq/
	PN/elr1D0pPy9I2BiubAUksgGXcNe1Ihf4IPFm3AhYM/lLqqFAz62mLMhK27g9LimkxR2L6QYOk
	tZXwVTw==
X-Gm-Gg: ASbGncuXqT813FBshjVcaRALjfvqlUkwkGczMre1FPv8tsJZzWXzOj8Lkvylnrr16bJ
	moavuol0nK5jVkdV4+nes5+xELjpvdXakITmLhn+9KCJ0YIpYX1FWzQBOr/o2HsbUdiSyCq/oyZ
	fUgzu6dGlr+ICu8pt9Qv10AW8YQGIGYpeQ9e42YAV+iENB9vdOefoRNtwNfdUgnvo/8E4Valxs5
	Zx3lQyN5cJlwUgN6y0hvtYv/ztiQjs9h6NAw4GBOaFw6ZE7d48LHonPvg==
X-Google-Smtp-Source: AGHT+IEA2GYxmDBoJ502nhZ16cRFkhfaqap2OWSHilCKRJ2N75D188EFfdgljBH1J1ODmQJpCG9YTA==
X-Received: by 2002:a2e:a9ab:0:b0:300:2d54:c2ae with SMTP id 38308e7fff4ca-3002fc97f7bmr61678071fa.27.1733738666847;
        Mon, 09 Dec 2024 02:04:26 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30226a67ea2sm1876041fa.67.2024.12.09.02.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 02:04:25 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 09 Dec 2024 12:04:24 +0200
Subject: [PATCH v4] drm/msm/dpu1: don't choke on disabling the writeback
 connector
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241209-dpu-fix-wb-v4-1-7fe93059f9e0@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKfAVmcC/23NTQ7CIBCG4asY1o4BSltw5T2MC36mLYkpDWjVN
 L27tAtNo8tvyPMykYTRYyLH3UQijj750Och9jtiO923CN7lTTjlgtZUgRvu0PgnPAxU1pU1Fmi
 Y5CSDIWJ+WWPnS96dT7cQX2t7ZMv1b2ZkQEEIWQhpGiesOV19r2M4hNiSpTPyr5WUbyzPtkZtF
 RqJUpU/tvhYxqnc2AIYaOawUhaFZtt/53l+A/DSKt0dAQAA
X-Change-ID: 20240709-dpu-fix-wb-6cd57e3eb182
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Leonard Lausen <leonard@lausen.nl>, 
 =?utf-8?q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>, 
 Johan Hovold <johan+linaro@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3165;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=HvzRy8I7qIhgbnNkEXgHJ7c/6fH0498enq7qcWDIymM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnVsCo1otrThiFKBxfGVywT0U/P8lNlp0sgAoFs
 yvoXA7m952JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1bAqAAKCRCLPIo+Aiko
 1fcZCAChAoJdoT7F0d/6QTsPBk8IT5e4HF/Ss5EzzMJGjqh/+L6zSIQnULAogk2+TkwvekhIV5W
 pR2UR0IPmorIPSzHVDKpbxh5Duc9Yc20M6fP9LwFpxgn6x8YVCYx5iStNgeRFrUnpIwtduXMdb7
 yUwJpQVZ4K2Tu6uKP2gr06E8ORewHdnRUR5Q6Tkkr7MiGO58/fTed41/aVxqYyvwoVELNlkpXk9
 gnf02UyCqCnBu6TMiOZSk014nuA6kheL01F1HsBZCtQyaHcys3eksBFtsWZjUFEw9DMYC3vdHsH
 N1B+Z6memFX0PiCkiSXGNUnhMfY2iQENm329sbPT3o0JXlDW
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

During suspend/resume process all connectors are explicitly disabled and
then reenabled. However resume fails because of the connector_status check:

[dpu error]connector not connected 3
[drm:drm_mode_config_helper_resume [drm_kms_helper]] *ERROR* Failed to resume (-22)

It doesn't make sense to check for the Writeback connected status (and
other drivers don't perform such check), so drop the check.

It wasn't a problem before the commit 71174f362d67 ("drm/msm/dpu: move
writeback's atomic_check to dpu_writeback.c"), since encoder's
atomic_check() is called under a different conditions that the
connector's atomic_check() (e.g. it is not called if there is no
connected CRTC or if the corresponding connector is not a part of the
new state).

Fixes: 71174f362d67 ("drm/msm/dpu: move writeback's atomic_check to dpu_writeback.c")
Cc: stable@vger.kernel.org
Reported-by: Leonard Lausen <leonard@lausen.nl>
Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/57
Tested-by: Leonard Lausen <leonard@lausen.nl> # on sc7180 lazor
Reported-by: György Kurucz <me@kuruczgy.com>
Link: https://lore.kernel.org/all/b70a4d1d-f98f-4169-942c-cb9006a42b40@kuruczgy.com/
Reported-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/all/ZzyYI8KkWK36FfXf@hovoldconsulting.com/
Tested-by: György Kurucz <me@kuruczgy.com>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Leonard Lausen reported an issue with suspend/resume of the sc7180
devices. Fix the WB atomic check, which caused the issue.
---
Changes in v4:
- Epanded commit message (Johan)
- Link to v3: https://lore.kernel.org/r/20241208-dpu-fix-wb-v3-1-a1de69ce4a1b@linaro.org

Changes in v3:
- Rebased on top of msm-fixes
- Link to v2: https://lore.kernel.org/r/20240802-dpu-fix-wb-v2-0-7eac9eb8e895@linaro.org

Changes in v2:
- Reworked the writeback to just drop the connector->status check.
- Expanded commit message for the debugging patch.
- Link to v1: https://lore.kernel.org/r/20240709-dpu-fix-wb-v1-0-448348bfd4cb@linaro.org
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
index 16f144cbc0c986ee266412223d9e605b01f9fb8c..8ff496082902b1ee713e806140f39b4730ed256a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
@@ -42,9 +42,6 @@ static int dpu_wb_conn_atomic_check(struct drm_connector *connector,
 	if (!conn_state || !conn_state->connector) {
 		DPU_ERROR("invalid connector state\n");
 		return -EINVAL;
-	} else if (conn_state->connector->status != connector_status_connected) {
-		DPU_ERROR("connector not connected %d\n", conn_state->connector->status);
-		return -EINVAL;
 	}
 
 	crtc = conn_state->crtc;

---
base-commit: 86313a9cd152330c634b25d826a281c6a002eb77
change-id: 20240709-dpu-fix-wb-6cd57e3eb182

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


