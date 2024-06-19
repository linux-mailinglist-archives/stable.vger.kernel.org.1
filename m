Return-Path: <stable+bounces-54634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7905D90EFB9
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 16:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262632845E3
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9833C1509B1;
	Wed, 19 Jun 2024 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aa9e9Z4q"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F3214C580
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806149; cv=none; b=PoRqqnBjYcGqo9KsZN5+46643UopjfIkHE2R+rpqJznFAZvP6CYWX5iyrPGUnCOxiLSxJUJCEaYCU0xssejgT/ymPhNvTtet9JON/zBiw7lDlrPNnb9iR1XeEY8kD9cCx8h0EbKH6d9f0uXu007iAE+ZBXzy+EfWBPdTCEB17f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806149; c=relaxed/simple;
	bh=O83FNAdgJkgnscldJT04vDrZcANIzWxDsUu1SHrFuVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U3N/U1CBA3YaxewE4rLVlShfLGrERGr39w92/rhTWdAmErBA2Xp03eay+itx//jNq5gZ87Jo0dNRD2Jdx7pTB9v4ZzJjtL1AhPLwAT+Mn+bwvH2vBM4FvBtSjCZq+ocfyCkFknV33hAKYbAEchW4TNQLxy4T4G4jqS/x/16Ii5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Aa9e9Z4q; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52c9034860dso8376141e87.2
        for <stable@vger.kernel.org>; Wed, 19 Jun 2024 07:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718806146; x=1719410946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0o2btwvxJuAvs23zoxm88cS8MnRzldpGlzftLOxRCk=;
        b=Aa9e9Z4qC+7FRcAJ1q2bo3powkg2C0Eji6uh/qT8BlN6pbygVtWXlC4Z1NUFWoY5Ov
         CWW9Kxr6kafVXafeZxEvTQgiJ1untXlvfuG2i8Ttd/NV+6kGhINmMTblQwWUd3tEKzLc
         vMkb/NuOjstnpFgVQa94K7Htzwmb7oE8xv4mUhHThgiyzrYrSBFZ8qqqDFeo3+Pscyvq
         QRzqfK7G8hbj/mZmBoqMYogESV50dA6KQ4sz04UNZM5g7NqtJDcwkHAviTLPJZbLcUsN
         oP6kr414Und5rnU1baOpQwzopZrD0jxCaiBcfHF1pAG8j3mLkWSh+NZeait5QzhY7xhN
         Y7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718806146; x=1719410946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0o2btwvxJuAvs23zoxm88cS8MnRzldpGlzftLOxRCk=;
        b=oSiZHgjC19434NXuFZlaY1gYdL5/UaPdpPQngwun+VDTcPMkXX2NQ0gYb1BzwN0dkK
         JGCDL3B/JRzYor1KejPaLj7ee0sWXFEjiDAx/8m9CQiGnVpSj76gqh5Ktv9wlEadkQWA
         0BuryU8J0plD2ZTQ3uk4/zvVb8aZX140OpdSCoF6fkAm81+xzya7Vyt3GjMK17D1aIdU
         75wmzRHkzFdWpy8tzC6ZJtI3Z9+qXKZ+ihpeZGb4JF4xCojdIrwhcdn/dMJApRBB9iD1
         rFjr/fhGPJabxHQ2Mj5K6ARiBOiiqXOhwMQF3bBoWdOebs3mHNey/BkRAiejDZNeOd5F
         s6qQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTeNw1rEdjmpt4R4OdfA3q7hntlk8PrhBBAFSruO0LJV8gDfSQ/wC0v6ZHRSHQ0iNAEHKPYhl8SxcPMZGYzxkDtBWOuM93
X-Gm-Message-State: AOJu0YwH2j1IdVC+lIojoENsrGZUFVDXjwUvIVB70y/FIfImRno16NfO
	vCtGSHhWmX+l7s86mayFvLMRKhLxGoP4MNzzIX/1uOyZbt4L5VCLI3pfk7xdbr8=
X-Google-Smtp-Source: AGHT+IGQ+IYY+K5JUtUrmVUaq99dM/Fd1SYa57uUXgyiboWmtgSst2pNGb8vCO3FJvkmSr34Pv77RQ==
X-Received: by 2002:ac2:5f93:0:b0:52b:e7ff:32b with SMTP id 2adb3069b0e04-52ccaa32fbdmr1920541e87.23.1718806145693;
        Wed, 19 Jun 2024 07:09:05 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2872241sm1787003e87.124.2024.06.19.07.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 07:09:05 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/7] OPP: Fix support for required OPPs for multiple PM domains
Date: Wed, 19 Jun 2024 16:08:43 +0200
Message-Id: <20240619140849.368580-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619140849.368580-1-ulf.hansson@linaro.org>
References: <20240619140849.368580-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In _set_opp() we are normally bailing out when trying to set an OPP that is
the current one. This make perfect sense, but becomes a problem when
_set_required_opps() calls it recursively.

More precisely, when a required OPP is being shared by multiple PM domains,
we end up skipping to request the corresponding performance-state for all
of the PM domains, but the first one. Let's fix the problem, by calling
_set_opp_level() from _set_required_opps() instead.

Fixes: e37440e7e2c2 ("OPP: Call dev_pm_opp_set_opp() for required OPPs")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/opp/core.c | 47 +++++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index cb4611fe1b5b..45eca65f27f9 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1061,6 +1061,28 @@ static int _set_opp_bw(const struct opp_table *opp_table,
 	return 0;
 }
 
+static int _set_opp_level(struct device *dev, struct opp_table *opp_table,
+			  struct dev_pm_opp *opp)
+{
+	unsigned int level = 0;
+	int ret = 0;
+
+	if (opp) {
+		if (opp->level == OPP_LEVEL_UNSET)
+			return 0;
+
+		level = opp->level;
+	}
+
+	/* Request a new performance state through the device's PM domain. */
+	ret = dev_pm_domain_set_performance_state(dev, level);
+	if (ret)
+		dev_err(dev, "Failed to set performance state %u (%d)\n", level,
+			ret);
+
+	return ret;
+}
+
 /* This is only called for PM domain for now */
 static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 			      struct dev_pm_opp *opp, bool up)
@@ -1091,7 +1113,8 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 		if (devs[index]) {
 			required_opp = opp ? opp->required_opps[index] : NULL;
 
-			ret = dev_pm_opp_set_opp(devs[index], required_opp);
+			ret = _set_opp_level(devs[index], opp_table,
+					     required_opp);
 			if (ret)
 				return ret;
 		}
@@ -1102,28 +1125,6 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 	return 0;
 }
 
-static int _set_opp_level(struct device *dev, struct opp_table *opp_table,
-			  struct dev_pm_opp *opp)
-{
-	unsigned int level = 0;
-	int ret = 0;
-
-	if (opp) {
-		if (opp->level == OPP_LEVEL_UNSET)
-			return 0;
-
-		level = opp->level;
-	}
-
-	/* Request a new performance state through the device's PM domain. */
-	ret = dev_pm_domain_set_performance_state(dev, level);
-	if (ret)
-		dev_err(dev, "Failed to set performance state %u (%d)\n", level,
-			ret);
-
-	return ret;
-}
-
 static void _find_current_opp(struct device *dev, struct opp_table *opp_table)
 {
 	struct dev_pm_opp *opp = ERR_PTR(-ENODEV);
-- 
2.34.1


