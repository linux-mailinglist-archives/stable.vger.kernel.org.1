Return-Path: <stable+bounces-43557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1C58C30BA
	for <lists+stable@lfdr.de>; Sat, 11 May 2024 12:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27AA1C22501
	for <lists+stable@lfdr.de>; Sat, 11 May 2024 10:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2306C53390;
	Sat, 11 May 2024 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Og4bmphZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C884204F
	for <stable@vger.kernel.org>; Sat, 11 May 2024 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715424603; cv=none; b=g5E5Njdpv80EJoFjwrRPRJD6xMpI3Biw1VcPg/sy/QZ/LNSIixHnL3QWfdp8P/t/olQzpX3gt4vY7KyShOa3GEfoqomhC33AcTVguT3ewLEMVPgk+INnSUv5gKWuyJxUXBv1tOF9W8VYU2w/hMh8lM9/6yo6JvBT+ttPUch3ffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715424603; c=relaxed/simple;
	bh=4y7Qf+jN6LlUE0OdF/F/rEDDNHszeU8elr9PJ2tH+iE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k+p9QXqhK1/UhBOEJUP1lWvC0dslazDepueoRfPakr8emZzr++zVqJkt31xP2G1vDFoNtLn2QXNq3YUasOdHFsvgW7yvGIr7P4JtOGH4u/POEprCc/W7jbYvQphrxKIrSK0qe+9+oU93wqAtUQXYIOcu/Gb8K7djrosrazGJQ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Og4bmphZ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-522297f91bcso1419114e87.3
        for <stable@vger.kernel.org>; Sat, 11 May 2024 03:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715424600; x=1716029400; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x9tzUVfN0KhpYmc4a0OVLANN4g1WHLu0Epz797hO85s=;
        b=Og4bmphZI9rr20GWN+Xl33+7kr0bo1eHMhH8/WMLCX1m7yfQFoMvmrdVErqxZc6739
         k+c0rxYPTlo3mhs7dDcZM0bzrIrTY4PZvu1hmowPEV9JrWQvaUrFuOspqJVF8JqPoncu
         6u+3baLS5w/uaoFVWRThu0NuqREOkB36aCr8CrEDmom49J4fgzE5VJ4ztsCX1OMjBMf0
         Mo0UODSVunHYlhbFKxf3n7HjcmBTxT65+Vp4tJXxeXgq9g9cxXosMHUV7a2jeueEnJPh
         P/k3Ogn4fttby8MYzl8ymVbbXDlgz3PG+Shj3sucMiwfs0WS/JtZDXj0ejJTZ41DTOdi
         dW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715424600; x=1716029400;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9tzUVfN0KhpYmc4a0OVLANN4g1WHLu0Epz797hO85s=;
        b=pZMXJvPc+1cFcD6/iJSn4tpJ7yEnDpe6I0FOSh5iHs+z4dqv6a3aFjUxuAKO2EpSKJ
         qqfLEGWG3P5c41MQlZAXXS2V6xL/BLemX/PSh+4yN3ZJzJ0M66DDjhikBUFjNWmaYwFL
         KTv/eg9L2mDHFEyMdcJQo6YutNOP3XPLdXjM8rPDPBCDWGzkJXiGNfJkVy91mqr1qhcl
         DyWzW86P2xT/7CUa7cwJQVkp9uJ5WC5smNEq0yjsITmheZLGVI7EQmc3XMJSQ6OwpOYB
         DsU+xP5oLj9T48QCuRpOdzHST6gDdttwASWGT0XMGLooVHuW2VL8LuzGStrstMnnb3Ux
         5VXw==
X-Forwarded-Encrypted: i=1; AJvYcCVhariBxkG+Co1ePwBvjqI3A78+zElmZMncJbIfnkzjVyZNQjYsl75tN9vseRl3ZDFfN94LeBe54E+gHzUQIu7AOC3Z24im
X-Gm-Message-State: AOJu0YzdJvdlgTenSPMffkgMN+yJbY9Pjeis9+Pzf55PL7XBc36eTPL/
	Vv0R0E16gNEfMLz5x9CDa9xqBbvefzesmh9t2iMkk1zMjT4mGdqtg7HY0wQv1c8=
X-Google-Smtp-Source: AGHT+IGg+LWGczogLtLGUqJNhxQs6r274MI2gwKo2vyNt3nMaj1fq1HgKXfUA3uoPSWXwMPjRHzuzQ==
X-Received: by 2002:ac2:4d84:0:b0:517:87ba:aff3 with SMTP id 2adb3069b0e04-5221016e7f3mr3060938e87.43.1715424600467;
        Sat, 11 May 2024 03:50:00 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ad59asm996021e87.45.2024.05.11.03.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 03:49:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 11 May 2024 13:49:59 +0300
Subject: [PATCH] wifi: ath10k: fix QCOM_RPROC_COMMON dependency
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240511-ath10k-snoc-dep-v1-1-9666e3af5c27@linaro.org>
X-B4-Tracking: v=1; b=H4sIAFZNP2YC/x3MTQqAIBBA4avErBtQqaiuEi38mXIINDQiCO+et
 PwW772QKTFlmJsXEt2cOYYK2TZgvQ47IbtqUEJ1opcS9eWlODCHaNHRieOg9OS0osEYqNWZaOP
 nPy5rKR8f52+UYQAAAA==
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>, 
 Stephen Boyd <swboyd@chromium.org>, 
 Rakesh Pillai <quic_pillair@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1558;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=4y7Qf+jN6LlUE0OdF/F/rEDDNHszeU8elr9PJ2tH+iE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmP01XglM6PDpJ5FKRfpGy+Q6xENazUhdYgRoDQ
 //KWcLhheaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZj9NVwAKCRCLPIo+Aiko
 1UIQB/49CRde93czh84lwUe7x1+pSFX90yrLwvtSOJXkI28HtFMfoiuu1exAppUo1eypZPewm0V
 MbiceretlnNrsNuh2ac19xj2SWWJjhxLwGVsUzP7BPuqk+u1o5Dg9nTGIBD9gMqt8VrYJodpFBf
 3TjBdR/HjcZRPAXteOsDXzLNU3DWZC3w3blS3jlXOIJ9tihUQq29OHqIDlrTYhkx6DE04Jaavm2
 bOLwrClPDvn3VTK/Yh7DZnQBFRtnNQQ8F/czV+oTxF8EO03m1/QgJSOjRTBP8XJtNmSurL4SlcF
 LHCnykEkypVGalLOetMDKiKiQNom/6J2fWakD55YJc86mMAO
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

If ath10k_snoc is built-in, while Qualcomm remoteprocs are built as
modules, compilation fails with:

/usr/bin/aarch64-linux-gnu-ld: drivers/net/wireless/ath/ath10k/snoc.o: in function `ath10k_modem_init':
drivers/net/wireless/ath/ath10k/snoc.c:1534: undefined reference to `qcom_register_ssr_notifier'
/usr/bin/aarch64-linux-gnu-ld: drivers/net/wireless/ath/ath10k/snoc.o: in function `ath10k_modem_deinit':
drivers/net/wireless/ath/ath10k/snoc.c:1551: undefined reference to `qcom_unregister_ssr_notifier'

Add corresponding dependency to ATH10K_SNOC Kconfig entry so that it's
built as module if QCOM_RPROC_COMMON is built as module too.

Fixes: 747ff7d3d742 ("ath10k: Don't always treat modem stop events as crashes")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/net/wireless/ath/ath10k/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wireless/ath/ath10k/Kconfig
index e6ea884cafc1..4f385f4a8cef 100644
--- a/drivers/net/wireless/ath/ath10k/Kconfig
+++ b/drivers/net/wireless/ath/ath10k/Kconfig
@@ -45,6 +45,7 @@ config ATH10K_SNOC
 	depends on ATH10K
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on QCOM_SMEM
+	depends on QCOM_RPROC_COMMON || QCOM_RPROC_COMMON=n
 	select QCOM_SCM
 	select QCOM_QMI_HELPERS
 	help

---
base-commit: 75fa778d74b786a1608d55d655d42b480a6fa8bd
change-id: 20240511-ath10k-snoc-dep-862a9da2e6bb

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


