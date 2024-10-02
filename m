Return-Path: <stable+bounces-78649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB49498D2FC
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC751F2334E
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 12:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625AE1D0154;
	Wed,  2 Oct 2024 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bNqwpn5U"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B511CFECD
	for <stable@vger.kernel.org>; Wed,  2 Oct 2024 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727871767; cv=none; b=aQaWCV3SgLO9h3rudfWKHziJxsNGrlW4n1Rg7xZPmY4iwbHS2xOXVRhU5+/wlArYHgKOjwX+JtZvd+b698Odm5vkvx2r4R2W+h6WBuUAaLzgBPKSOyuoTr75SCaHmxoxnAJYiSiZsdI+aVOROQ96SRHrNqw917gEw0JVbS7dYPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727871767; c=relaxed/simple;
	bh=bzcM5H+oeqTzoW0VCpVpOTPFzApwGE8O5mfZWirVFUw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WKE7kuR0tCMHI/QjYCwzA3h6DGovfNuMPm0WDT9gx8e6puujjk4+gMKnXyUgZ1B1+jotiTopEf3EBkO3TGZOEWHG09ReHkhPMI9H6ygoZ8SuNCrcDTfzivrQeKZ3wyI+hEBM+eoC18Io0ce2kNX5m0QFAPDmI2iT/nVM+6dmino=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bNqwpn5U; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5389fbb28f3so790960e87.1
        for <stable@vger.kernel.org>; Wed, 02 Oct 2024 05:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727871764; x=1728476564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnPQMJcE35HfZ9AP9Q+AP3/u7Io2rZuoy0lFJRDyvTQ=;
        b=bNqwpn5UC3ukEVpwcZ2gZGXBEg4mE9A3Izra5X0tMznDOu23o0D+bjMflFV+rSiRGZ
         2fT8jbvbswLr9mtxWRS9hfBZR+SGezcNfe/myc8IMm2vY9mOeBnM8OF5P4N+aCaKgZWP
         aUyU+FFQC0DHM41FfZjtCiw/ko8jYYesNDUbi8O0y1QXOIcpJe9tQef1mvRozgQpc96Z
         e7OYSkZTOc0eb2FfDa7+4/LTjBgKzWwlP6UT6LtBYnJbE2RPnKJw0Drxd90O6GvSv51A
         zalFiQpcJPBCzZH4jG99J7UkWSrLmC4utxAoNFpMtI3f0k5ZmvC45sknzcbVt2U8cbl7
         l4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727871764; x=1728476564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnPQMJcE35HfZ9AP9Q+AP3/u7Io2rZuoy0lFJRDyvTQ=;
        b=DLJYiNK+kE/lrXsQalFKurIC0+uwX7cMQx7hqfoWgVIeGmI9ktcf/gVQgOZ2kOxU5h
         Woe67d1cAqTUfc5obNDfQjta6dhBhEc9B/VPHckZ7H74Tc3za6eHMVw26St3NEsWha6C
         DU791TESGZGq3sHPZgLqbxFc6blvLFQvJbU7ZTw2wkpAj8WboFjEjFvBJIVmxJHK1+iw
         bCZS1EG7ANVxHQOJ0CscXd1sELSiHuDJzRVLovTnZbRXMHDcXKV2y4p3IcC8H3UVXPud
         M89ouxNV5RivaBmi2ZpSeQri482p2cbjBD65gdyIY4j9/m5X+0O93GQnRbumP/U8IQSH
         nZ+g==
X-Forwarded-Encrypted: i=1; AJvYcCXhq26F2FrdoJEWEmcwp72wQf5+Y39oJoxJUCNMPcedw+As8N8wriSjfrQHRLQeepbrXUuyej4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmvIk2BIz8XFon/XVFssBoc7RXkQdU8sbVPc5IS5OX9CtGw+7P
	SedqcNb8P/hTPP6zkdiEGr7CLeAPbQYMZ7JG/yA6gxefhk62JWBLGWumgSA7WBWQwK9eAUouzWc
	h
X-Google-Smtp-Source: AGHT+IH3lbHH/Ci/Lm2nPio+9vcLRk9yL/BoeI12+KlsgJmqos4Z7kBLLfAx4B214LknbA9lF9GWVw==
X-Received: by 2002:a05:6512:239c:b0:538:9d49:f740 with SMTP id 2adb3069b0e04-539a014dd0dmr1050179e87.15.1727871763458;
        Wed, 02 Oct 2024 05:22:43 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-538a043204fsm1912659e87.165.2024.10.02.05.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 05:22:42 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Vedang Nagar <quic_vnagar@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <quic_kdybcio@quicinc.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ilia Lin <ilia.lin@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 02/11] PM: domains: Fix alloc/free in dev_pm_domain_attach|detach_list()
Date: Wed,  2 Oct 2024 14:22:23 +0200
Message-Id: <20241002122232.194245-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241002122232.194245-1-ulf.hansson@linaro.org>
References: <20241002122232.194245-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dev_pm_domain_attach|detach_list() functions are not resource managed,
hence they should not use devm_* helpers to manage allocation/freeing of
data. Let's fix this by converting to the traditional alloc/free functions.

Fixes: 161e16a5e50a ("PM: domains: Add helper functions to attach/detach multiple PM domains")
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- New patch.
		
---
 drivers/base/power/common.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index 8c34ae1cd8d5..cca2fd0a1aed 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -195,6 +195,7 @@ int dev_pm_domain_attach_list(struct device *dev,
 	struct device *pd_dev = NULL;
 	int ret, i, num_pds = 0;
 	bool by_id = true;
+	size_t size;
 	u32 pd_flags = data ? data->pd_flags : 0;
 	u32 link_flags = pd_flags & PD_FLAG_NO_DEV_LINK ? 0 :
 			DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME;
@@ -217,19 +218,17 @@ int dev_pm_domain_attach_list(struct device *dev,
 	if (num_pds <= 0)
 		return 0;
 
-	pds = devm_kzalloc(dev, sizeof(*pds), GFP_KERNEL);
+	pds = kzalloc(sizeof(*pds), GFP_KERNEL);
 	if (!pds)
 		return -ENOMEM;
 
-	pds->pd_devs = devm_kcalloc(dev, num_pds, sizeof(*pds->pd_devs),
-				    GFP_KERNEL);
-	if (!pds->pd_devs)
-		return -ENOMEM;
-
-	pds->pd_links = devm_kcalloc(dev, num_pds, sizeof(*pds->pd_links),
-				     GFP_KERNEL);
-	if (!pds->pd_links)
-		return -ENOMEM;
+	size = sizeof(*pds->pd_devs) + sizeof(*pds->pd_links);
+	pds->pd_devs = kcalloc(num_pds, size, GFP_KERNEL);
+	if (!pds->pd_devs) {
+		ret = -ENOMEM;
+		goto free_pds;
+	}
+	pds->pd_links = (void *)(pds->pd_devs + num_pds);
 
 	if (link_flags && pd_flags & PD_FLAG_DEV_LINK_ON)
 		link_flags |= DL_FLAG_RPM_ACTIVE;
@@ -272,6 +271,9 @@ int dev_pm_domain_attach_list(struct device *dev,
 			device_link_del(pds->pd_links[i]);
 		dev_pm_domain_detach(pds->pd_devs[i], true);
 	}
+	kfree(pds->pd_devs);
+free_pds:
+	kfree(pds);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_attach_list);
@@ -363,6 +365,9 @@ void dev_pm_domain_detach_list(struct dev_pm_domain_list *list)
 			device_link_del(list->pd_links[i]);
 		dev_pm_domain_detach(list->pd_devs[i], true);
 	}
+
+	kfree(list->pd_devs);
+	kfree(list);
 }
 EXPORT_SYMBOL_GPL(dev_pm_domain_detach_list);
 
-- 
2.34.1


