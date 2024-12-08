Return-Path: <stable+bounces-100082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F609E870E
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 18:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC43163C1E
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 17:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CBC187862;
	Sun,  8 Dec 2024 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQC+WJCo"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C367145324
	for <stable@vger.kernel.org>; Sun,  8 Dec 2024 17:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733678958; cv=none; b=Fr5MKdJze60d7UG+igfXHTpMCOjaj8D+qP/icJTXlFz8Mv0HnXTFCt3LwOprMPUEhLiYMutEPCOulEhGP+MlEEUfsK69cCUGiVPd3WWs+2iDEswO5KJXS7CTN7ssdO08XQkOXw9B0kfcdSjfEWZYO5H1mfIrM/rU1S6Lb1svZ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733678958; c=relaxed/simple;
	bh=l0e+YjJJLUTTCME2U2RfwtoWLrRTp83OMNrgSpxIf3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IIe9mn4v4hABwQDJ1u8TijnG4ksY00MK82OlykFosz86h2wsNrcdnB3mgneZvd/zg315nrkEaVoararRPEU6UMft2SRGGBwLY1JXr5clwzFPIR/tE5jpOz6aZAKENIkTILSIm/9oRE9TlJfipklXCYL/KkfyYdjRPawLbXQQ36w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DQC+WJCo; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso29536341fa.0
        for <stable@vger.kernel.org>; Sun, 08 Dec 2024 09:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733678954; x=1734283754; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/tzoYaJ92Gqbh47fpsJMbKGuzwxMycmsQJXhBU4UoPU=;
        b=DQC+WJCo9cPS1F50ICY+x5OBxiGD3hFK6sBm5PFZvXDa5IbWUtsuJLm3C34sGT57Lj
         /IVCjnxSyUbP9WYWkkhmIbApFHNlauufJFloyxERpaToMsWBNmRF6tRANpZi/dV9mnpE
         h0mPfbe+UyJJZbdTcPpikwI9STxkc6Js3bJM1+B0pY8cFe4C39f0MqKf8TEHZgQNtQ9/
         ohLRevIV1u3T6ccwV4jNkS7GM13AzbgVQc+UwlTn5JuwyK5PD8hu2a5Q4nLNCoKsOQVa
         UBpOmvGf8LF24lnkg1MbNCJVn5gnvqr9yPM55NkOhFIUlZjYWl018PhvJxApsb+PDA9M
         7STg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733678954; x=1734283754;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/tzoYaJ92Gqbh47fpsJMbKGuzwxMycmsQJXhBU4UoPU=;
        b=UVHBE5wCwcWaFmrmzFf3hD4kIjL6oZW7EtvlMSulun9IeMuNl45q5cYd/RzfthwewU
         Iru5Lk3KGvFh3/7/qoQvT0CY/7UhZgO70lfGJ3FsHIOqv3ZGgqXghzsg2UEqi+jo+91T
         lVX8y1MhjLjJWIA/BQR+F8AgepJLHFIyWl7UaBV+JwZEriua8Pcq3WoG7OlTqKyUU/e4
         kUx6tv6kA8+/nLkFqZMUl4IAgnXZVlAimhuq7fgAk4DYRDTPcf7oKrKjs17r1nuLAIJ0
         mTESTdo6a72IW3nUJQQWE3phLu9d8ZmNHpSvuGYbgeVuKb7rDQUQaTjp1kMia58hz7hW
         0qvA==
X-Forwarded-Encrypted: i=1; AJvYcCXbTmLtrqSw0GSZqbyFMAZpSY6+zwIGb2O1WZeFs5dhCqXvUM5pjaBU9I7bvYYX4IPT7mFKsgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCKwNjCUv0i8QwYx4lMnfu+fD0UIGIh6/hypDp8KOM2IUA3qmm
	0t0yIUgit/zcN29bT70QYz3CVaR4LsDRksc6JSTmVAH0AwImTsCg/k13iCZb+nU=
X-Gm-Gg: ASbGncsJzhnY7uCx3f23vo8nEe06Wk28/SasCNmnm0YyKqht3M8ugv9VBY0QM9ZQYQ0
	aTSYCCuPB1NmS9BsMW0R9OuVev60s4kaV1iGCl3s642aZfYy2HCH55NGP9YWXEqipfWdL+8VGPR
	1LOv7T14vJ9xlq3LvTBuUqvvjt2vZDMh88/2FvJg5GySsL7BBHiPyL5uomDlAwmY8/Sh43sTN6e
	dZlIf9L9FxkhRVjkXPjlywXGpbMKvrVheAkcUP/d9A/kQFpNCdR9Um+Gg==
X-Google-Smtp-Source: AGHT+IGpl4LZsuCLYc4o6t6jeFwINzov0q8HwajESXX2p2xRlg9YhxiyKZwpcpZtqT6qPbhArxAsDg==
X-Received: by 2002:a05:6512:39d1:b0:53e:27d5:85db with SMTP id 2adb3069b0e04-53e2c2b1ab8mr3133570e87.12.1733678954527;
        Sun, 08 Dec 2024 09:29:14 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3160ebe8sm783253e87.180.2024.12.08.09.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 09:29:13 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 08 Dec 2024 19:29:11 +0200
Subject: [PATCH v3] drm/msm/dpu1: don't choke on disabling the writeback
 connector
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241208-dpu-fix-wb-v3-1-a1de69ce4a1b@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGbXVWcC/22MwQ6CMBAFf4Xs2ZrSFime/A/jgbYLbGIoabVqC
 P9u4WJIPM57mZkhYiCMcC5mCJgokh8zyEMBdmjHHhm5zCC4ULzmDXPTk3X0Zi/DTtZVNUo0pRa
 QhSlgfrbY9ZZ5oPjw4bO1U7mufzOpZJwppaXSpnPKmsudxjb4ow89rJ0kfq7mYueK7NbY2gaNR
 t1UO3dZli/ruPa24QAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2341;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=l0e+YjJJLUTTCME2U2RfwtoWLrRTp83OMNrgSpxIf3U=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnVddoeaOWxNJOEBGnhGweCcRBMxR3mJut6WFda
 BRnKILovEqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ1XXaAAKCRCLPIo+Aiko
 1c1SCACznZ0DjA+m7Xyt+NmXA+EGu7YA91e/a5pV0heywojgc9cKCkh4DnloshzjCdKmzf+Y6r5
 3dMN62m79U+sfGHXhZ9YKSB/7lZOL8lR15ewqPtxcbiyiqG3gC/xBPnIXJfD66fXZGqlUSkrs87
 QLHEPRb8cjqR2Y3Mw4ktwFlFoLLz0ZqCoQ50S+kMRLLZJPsT2qtiTli42NG+9l0hLN7iIIGYpuU
 yBErwWqTg3wON4+gRHEV4wdcjcs+GZ95SzsYvFBKVfaCkisiiDfVfHoxn5gDK1+qFB24fgF663u
 D1BLlaBUdwTfdgtRLOj27qHXQnwSYPaW+n+Np5C9UXzVKEiP
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

During suspend/resume process all connectors are explicitly disabled and
then reenabled. However resume fails because of the connector_status check:

[ 1185.831970] [dpu error]connector not connected 3

It doesn't make sense to check for the Writeback connected status (and
other drivers don't perform such check), so drop the check.

Fixes: 71174f362d67 ("drm/msm/dpu: move writeback's atomic_check to dpu_writeback.c")
Cc: stable@vger.kernel.org
Reported-by: Leonard Lausen <leonard@lausen.nl>
Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/57
Tested-by: Leonard Lausen <leonard@lausen.nl> # on sc7180 lazor
Tested-by: György Kurucz <me@kuruczgy.com>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Leonard Lausen reported an issue with suspend/resume of the sc7180
devices. Fix the WB atomic check, which caused the issue.
---
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


