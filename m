Return-Path: <stable+bounces-60582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B2A937131
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 01:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773F9281E82
	for <lists+stable@lfdr.de>; Thu, 18 Jul 2024 23:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75651474A6;
	Thu, 18 Jul 2024 23:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EQCRqAzo"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E10146586
	for <stable@vger.kernel.org>; Thu, 18 Jul 2024 23:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721346210; cv=none; b=KlAsf9coFkLQXCiB9umSHAPkT1n7hW3YKJRFVREr6ZFLRUimCX1tat/hKMg93QhVY6vcQD9aycFY9qBeKWSlMOsLgtPgeqzZyWdi/0/BCEildb06AmuPkNlcdWt30XU5TEy6emjrMhMNaKsNPF6MH8Ks8UWvs6qZEPl1LvL+RFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721346210; c=relaxed/simple;
	bh=HiN+rgq9gu0Chb+FnevRuAodoxjBWMVVAIsr/15wHVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U5MmOxKtmVpkmK4ZDubLVfYK/m/q6VpzOFz0AXSjANGWsMqR93WPCjPL2YjLcYtcYKXCVgtylMeDo/GPBO2Lvaz6IdQPV6miWjs71k4CEcoNtYJZXwUVs3rg64OJNHNDSprvMAIHbKGrOkoThh6c88g7KzRNO1r18/zvo70q61g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EQCRqAzo; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52e9fe05354so1210468e87.1
        for <stable@vger.kernel.org>; Thu, 18 Jul 2024 16:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721346206; x=1721951006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zb2TnLEPy/yYn4OHpN9GAbJBX2HlvGglgTvnLaEwow=;
        b=EQCRqAzolnnkPwLdlVvSsRG8JkC2j5iMhLAMg7/OI0XaN/Niyeg7J84DkhgJBACsSJ
         RBtlu/jSzOeyuVxRG4+4KA7pUNFgo4BGeCUfhJ8e/LcFbJHVaTqRuRTABYs5pkiE+POf
         nd99qRC7HyvhanQAPA+N4DkKMai7eR16Mc22EWHBC81V3yT+P3R36zHiqKjwsN5S8w+j
         enc5WsGEBpkTmpie028WIouV6JCbbKlzITRqHMNL07uToUsCRVqnsABYcShOQggcOG+a
         fPisKIyJw+g8/UfV5Aomds5HmA/cpY/VWIYbPCxxYkG5m5HwnL/I/rWthL/a8eAoQXsM
         CTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721346206; x=1721951006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+zb2TnLEPy/yYn4OHpN9GAbJBX2HlvGglgTvnLaEwow=;
        b=J6loL8wnjFv28Te/vMTiiV2O27R1X/CYh6X8r4wv+CPdK+jKsDlUSXxmFzltzHILm8
         106h8LiQxQ3pOHHCNA3qEsvsT8bXNHqp75pT1vRHEqyktAq2OnmW7U6sKACCMT5CQ6dI
         ySppsN8auxk+m5swQ2PioLVTF3F9dxSXfPdXNElBoZh2ZKu6SuwMKURkdL/mu97qxcL+
         TosN76JAwpIdBoCk9L5wtmrGIBLRztuwLWVn4MrP+oiHyPN36Lb+GiQwNSAxzGXwFpVh
         TIW5lzoT7V+0DWOmWuU1GhHD1mN7RUfLoJcWdr7gTpqtTZO0To/YqOcNNGIMPfQ+NIy1
         lsRA==
X-Forwarded-Encrypted: i=1; AJvYcCV1UcvaaHrGMScgg04fYK99E0vVHVFJexGEPY6Qe32kMcipO0YcS3AkyjywHugDpJG9+oQoQ1gGHa7OgLEzmvm2KrT8wjZk
X-Gm-Message-State: AOJu0YzU9GYR3WTIrkZNpM17Tc1HHf2XD5Xe9pY+9okxmfecJ37VEL+Q
	W5Tzj4PHeDsx32okzk1GIyT4W9FO0ynF6t1VETVJ/sXpStinq6F+APTmhY4d8Yg=
X-Google-Smtp-Source: AGHT+IFF8smI3aMAQT3AbKX1NQGZpHaJaCkvum5gaxbfN2nJOzdqHbIsk7af5xBZTpN9HOnmw05rOw==
X-Received: by 2002:a05:6512:ac7:b0:52b:9c8a:734f with SMTP id 2adb3069b0e04-52ee5411e3dmr5098927e87.50.1721346205884;
        Thu, 18 Jul 2024 16:43:25 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef556b4fbsm22491e87.139.2024.07.18.16.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 16:43:25 -0700 (PDT)
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
Subject: [PATCH v2 1/6] OPP: Fix support for required OPPs for multiple PM domains
Date: Fri, 19 Jul 2024 01:43:14 +0200
Message-Id: <20240718234319.356451-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718234319.356451-1-ulf.hansson@linaro.org>
References: <20240718234319.356451-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It has turned out that having _set_required_opps() to recursively call
dev_pm_opp_set_opp() to set the required OPPs, doesn't really work as well
as we expected.

More precisely, at each recursive call to dev_pm_opp_set_opp() we are
changing the OPP for a genpd's OPP table for a device that has been
attached to it. The problem with this, is that we may have several devices
being attached to the same genpd, thus sharing the same OPP-table that is
being used for their required OPPs. So, typically we may have several
active requests simultaneously for different OPPs for a genpd's OPP table.
This may lead to that the per device vote for a performance-state
(opp-level) for a genpd doesn't get requested accordingly.

Moreover, dev_pm_opp_set_opp() doesn't get called for a required OPP when a
device has been attached to a single PM domain. Even if a consumer driver
would attempt to assign the required-devs, via _opp_attach_genpd() or
_opp_set_required_devs() it would not be possible, as there is no separate
virtual device at hand to use in this case.

The above said, let's fix the problem by replacing the call to
dev_pm_opp_set_opp() in _set_required_opps() by a call to _set_opp_level().
At the moment there's no drawback doing this, as there is no need to manage
anything but the performance-state of the genpd. If it later turns out that
another resource needs to be managed for a required-OPP, it can still be
extended without having to call dev_pm_opp_set_opp().

Fixes: e37440e7e2c2 ("OPP: Call dev_pm_opp_set_opp() for required OPPs")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Clarified the commitmsg.
	- Addressed some comments from Viresh.
	- Drop calls to _add_opp_dev() for required_devs.

---
 drivers/opp/core.c | 56 ++++++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 5f4598246a87..494f8860220d 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1061,6 +1061,27 @@ static int _set_opp_bw(const struct opp_table *opp_table,
 	return 0;
 }
 
+static int _set_opp_level(struct device *dev, struct dev_pm_opp *opp)
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
@@ -1091,7 +1112,7 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 		if (devs[index]) {
 			required_opp = opp ? opp->required_opps[index] : NULL;
 
-			ret = dev_pm_opp_set_opp(devs[index], required_opp);
+			ret = _set_opp_level(devs[index], required_opp);
 			if (ret)
 				return ret;
 		}
@@ -1102,27 +1123,6 @@ static int _set_required_opps(struct device *dev, struct opp_table *opp_table,
 	return 0;
 }
 
-static int _set_opp_level(struct device *dev, struct dev_pm_opp *opp)
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
@@ -2457,18 +2457,6 @@ static int _opp_attach_genpd(struct opp_table *opp_table, struct device *dev,
 			}
 		}
 
-		/*
-		 * Add the virtual genpd device as a user of the OPP table, so
-		 * we can call dev_pm_opp_set_opp() on it directly.
-		 *
-		 * This will be automatically removed when the OPP table is
-		 * removed, don't need to handle that here.
-		 */
-		if (!_add_opp_dev(virt_dev, opp_table->required_opp_tables[index])) {
-			ret = -ENOMEM;
-			goto err;
-		}
-
 		opp_table->required_devs[index] = virt_dev;
 		index++;
 		name++;
-- 
2.34.1


