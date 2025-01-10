Return-Path: <stable+bounces-108203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75713A095C3
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 16:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92193AC51B
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 15:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20FB212B1C;
	Fri, 10 Jan 2025 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K7MqnrxC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9CA211A3F
	for <stable@vger.kernel.org>; Fri, 10 Jan 2025 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523003; cv=none; b=DtQs2slsUr1U4fqUypgWVOYafF4SOPBd27oYnjIWut1bB3C/WTZYlv1YO6ALGWesSvPg7Ce8sZ5Bh0iKj2i7lMoq42JUMxyFhsU/jZp6yKKBIq8dIeADFiJ3M73Tp02NUqOCcGxmz9qN5NDEndPdm85R8Vc3W67wv/1XJOSSuis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523003; c=relaxed/simple;
	bh=KHO1sIoxGLbk9pJ5dGN+1vCRJX/sCnbYvmDNVHURYF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Zk3sJZLsuD+o23FwDqcPQ8Ou5ZsQ05vUnowY9R2QaBc5p6fBm7/mhAvuVsHxNbkVNbn5bkZcWR7+pk5OhYs7THGHhdQwtNsznwYNVhVfjt7A0JeQaXmim8Lsjp/LJfP1B276HP4es6I9cy2BfkhsMbNbHwJs4MT/D7XmEZFDq1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K7MqnrxC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361815b96cso16269265e9.1
        for <stable@vger.kernel.org>; Fri, 10 Jan 2025 07:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736523000; x=1737127800; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BiVkbH1IXXsmR1zWf2jdxqMv1sjSoGxEqsZIXAqt8no=;
        b=K7MqnrxCLQBctx/HVOxX8pi2SVVbBLa9/qduUOH6IXn/n40Sdh2j3KX4EGDAcKBNp8
         xs0BpcwZyR6DFub/Qgk5EXKGJCkfi7w012MlPuPjeXpN9/GuEsvKPqmaBPTxQoWLDPe+
         Xx2z8nQ7auSzGe1H5mL7LpE5AkofgyChgh4ykGg8AQlDrUYdhXWRGQlitKphetrHRkDi
         WKhMRiCnA8NdZylAURio04nb0gdbGqdCcrvrFNiaj9wcE+ko5J1VHoI3Xfj+17oOn92x
         elGYC3PsyDGtIrzBIUTV6pPx2W+sGhsQZgJj3gYdB2CGyFRLDI4MSoLqfallXxnUNKQz
         vFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736523000; x=1737127800;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BiVkbH1IXXsmR1zWf2jdxqMv1sjSoGxEqsZIXAqt8no=;
        b=pThV1/53W+x2nzYxYX+5naGJZBo6OG1YdGfMQTghaAJQ3a+eMCBZaR5mZAwYlB0sbl
         tEN8SFLsGPGvwMVWjEPsSbHFYC1EX3BbH8yA0JwlK1npK6bimp02kVfAosA0AchF0I53
         3mihV1VBgMpEx/GChuL0Xoj9m//vEek5dIBtuOhix0cymNep5wi1qJoDbN9uO/zeshIt
         A6EQO7j+pKWrHHrMQRpTmrFRsXtvbHjCBatxPYcax8GEpGP+IPSRLKn+z2pJdfYtY0MX
         Re9YNQDzCUuhXZKF2XKdzYuAffNDnUAINFmhTKLSqT9TKc3XGJBv00XwJIEXklIR8Tnc
         dbUA==
X-Forwarded-Encrypted: i=1; AJvYcCVPn+njrlOayMZ83w5aHxYV8dyj/wHQm85y+r5lPDCO6NsXaN+/XZMbe968dTSvDalNZpDcveY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqJma042uA1yog0y9E0PiibH0heBQ0boG8hKlQCTygNlbHDjOT
	dR+SvxL0EAy//PQLIiE7CmvNstHGxo9r99lnOCugn/Qvma9lTtZ4i+8Ku01fhuc=
X-Gm-Gg: ASbGnctrsUQISZlnbTWFLALI5R4fy0oibbmkZcsI3sx11nz+pGbjqKDnq8nEL65QjAI
	o1JKPnbFrqu4+oSBjvWLRrkfrErrZ5gzs1gjkCMrF+ZcJaaps/Hq/r+3NtC/bVe4C5rS26MapyZ
	JOvBWGkBmHpuqYgFuae22RQVFlzacTWKXE0KAnq39qhjIDeeVUsYlpB4j0osLdCp2l2so52WIRF
	XHgRNUdLEtUY7uHDfHJhSbSaogflTsmFDr5HrPb4vpWmpovGNCVopM/
X-Google-Smtp-Source: AGHT+IHoq5z1V6L8jPONAVR1GSrjVEuAk2110HtXLuzoZnf/vLEC9yauCrnNjaNhR/Pde2D5/tnQfw==
X-Received: by 2002:a05:600c:511a:b0:434:a239:d2fe with SMTP id 5b1f17b1804b1-436e26ffdd6mr84112825e9.28.1736522999783;
        Fri, 10 Jan 2025 07:29:59 -0800 (PST)
Received: from [127.0.1.1] ([86.121.162.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e37bd0sm54740075e9.26.2025.01.10.07.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 07:29:59 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 10 Jan 2025 17:29:51 +0200
Subject: [PATCH RFC] soc: qcom: pmic_glink: Fix device access from worker
 during suspend
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-soc-qcom-pmic-glink-fix-device-access-on-worker-while-suspended-v1-1-e32fd6bf322e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAO48gWcC/x2OsQ6CQBAFf4Vs7UsAOQtbEz/A1liQvQU2wB3cR
 jEh/LsXyykmMzuZJBWja7FTko+axpChOhXEQxt6gfrMVJe1K6uqhEXGynHGMiujnzSM6PQLn2U
 WtMxihhiwxTRKwjboJLC3LRK8eLSda9hJcxZ/oVxZkmT9f/Ckx/1Gr+P4Aeh+TAiWAAAA
X-Change-ID: 20250110-soc-qcom-pmic-glink-fix-device-access-on-worker-while-suspended-af54c5e43ed6
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Johan Hovold <johan@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3483; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=KHO1sIoxGLbk9pJ5dGN+1vCRJX/sCnbYvmDNVHURYF8=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBngTzxY/3H7TTlLUSFA43ep0oY49mGE/mDEgy4+
 SM1J4fB0rOJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ4E88QAKCRAbX0TJAJUV
 Vrg5EACS530DhPoX1TBozFcjTuWL4ujXXnZIPxl2EF+SCTI8DiCK4WVBkzrLYxm0kmfNyiQIiGr
 2j+DuAcqidoQncE5ErkwffdSidqg/97/vfS0ydJnajoJJ5rNNfE6nkcZMTZa7FldYaPaqQVMI4l
 FHLkjhGWyEHKUAf5iPfnX/Ny2J/gPYPDVplqeDV79e60RoTd/ujvzsz2kKe7wdSKhhRtVLvGzJE
 HXgC/iWtz+8bciuV3VrJuYZabGEKcg+sxcF2mnlVIHdosIJtjTtMti4zXdndyqfiAi3GY6HGnJf
 FccMzLJzwpUjxlkg4r7wlqaqyxmo8eqCKDUkVxQrS7gXZOMbizI+EX91kHI/nO2DdcqsFI7YZ57
 vvspgr5C48sYU5rTcjCIHpjptFwXtrYprX1RKLwhmB7x+XAd8ycJskuGknAeXDrONw2tPdxN5uk
 c39y0jf9YQhI25LdU+lmwWH+pbFY5CCBcB4JcTYKaGXcCun7UOI1HpBYeIT5aaPBY3AwBORIBLY
 kVDBsopaYqQND8zHB6evPZIH9DlLXPYnMV70Q3sFb0eXcdO+a+6Ax3dD8wvhtst2/fk6ioUA7FS
 dboEchY3lLnUkSC5W2ZOi0yW7GoFgWkl9FfKoLWisjlnnvRehUUXXRvNNHmOZmGCUA4bfOGr/wB
 9cOYDpU0dcs4ung==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The pmic_glink_altmode_worker() currently gets scheduled on the system_wq.
When the system is suspended (s2idle), the fact that the worker can be
scheduled to run while devices are still suspended provesto be a problem
when a Type-C retimer, switch or mux that is controlled over a bus like
I2C, because the I2C controller is suspended.

This has been proven to be the case on the X Elite boards where such
retimers (ParadeTech PS8830) are used in order to handle Type-C
orientation and altmode configuration. The following warning is thrown:

[   35.134876] i2c i2c-4: Transfer while suspended
[   35.143865] WARNING: CPU: 0 PID: 99 at drivers/i2c/i2c-core.h:56 __i2c_transfer+0xb4/0x57c [i2c_core]
[   35.352879] Workqueue: events pmic_glink_altmode_worker [pmic_glink_altmode]
[   35.360179] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[   35.455242] Call trace:
[   35.457826]  __i2c_transfer+0xb4/0x57c [i2c_core] (P)
[   35.463086]  i2c_transfer+0x98/0xf0 [i2c_core]
[   35.467713]  i2c_transfer_buffer_flags+0x54/0x88 [i2c_core]
[   35.473502]  regmap_i2c_write+0x20/0x48 [regmap_i2c]
[   35.478659]  _regmap_raw_write_impl+0x780/0x944
[   35.483401]  _regmap_bus_raw_write+0x60/0x7c
[   35.487848]  _regmap_write+0x134/0x184
[   35.491773]  regmap_write+0x54/0x78
[   35.495418]  ps883x_set+0x58/0xec [ps883x]
[   35.499688]  ps883x_sw_set+0x60/0x84 [ps883x]
[   35.504223]  typec_switch_set+0x48/0x74 [typec]
[   35.508952]  pmic_glink_altmode_worker+0x44/0x1fc [pmic_glink_altmode]
[   35.515712]  process_scheduled_works+0x1a0/0x2d0
[   35.520525]  worker_thread+0x2a8/0x3c8
[   35.524449]  kthread+0xfc/0x184
[   35.527749]  ret_from_fork+0x10/0x20

The solution here is to schedule the altmode worker on the system_freezable_wq
instead of the system_wq. This will result in the altmode worker not being
scheduled to run until the devices are resumed first, which will give the
controllers like I2C a chance to resume before the transfer is requested.

Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
Cc: stable@vger.kernel.org    # 6.3
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/soc/qcom/pmic_glink_altmode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
index bd06ce16180411059e9efb14d9aeccda27744280..bde129aa7d90a39becaa720376c0539bcaa492fb 100644
--- a/drivers/soc/qcom/pmic_glink_altmode.c
+++ b/drivers/soc/qcom/pmic_glink_altmode.c
@@ -295,7 +295,7 @@ static void pmic_glink_altmode_sc8180xp_notify(struct pmic_glink_altmode *altmod
 	alt_port->mode = mode;
 	alt_port->hpd_state = hpd_state;
 	alt_port->hpd_irq = hpd_irq;
-	schedule_work(&alt_port->work);
+	queue_work(system_freezable_wq, &alt_port->work);
 }
 
 #define SC8280XP_DPAM_MASK	0x3f
@@ -338,7 +338,7 @@ static void pmic_glink_altmode_sc8280xp_notify(struct pmic_glink_altmode *altmod
 	alt_port->mode = mode;
 	alt_port->hpd_state = hpd_state;
 	alt_port->hpd_irq = hpd_irq;
-	schedule_work(&alt_port->work);
+	queue_work(system_freezable_wq, &alt_port->work);
 }
 
 static void pmic_glink_altmode_callback(const void *data, size_t len, void *priv)

---
base-commit: 2b88851f583d3c4e40bcd40cfe1965241ec229dd
change-id: 20250110-soc-qcom-pmic-glink-fix-device-access-on-worker-while-suspended-af54c5e43ed6

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


