Return-Path: <stable+bounces-109497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B0CA16630
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 05:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B252B7A4128
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 04:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B54C15575C;
	Mon, 20 Jan 2025 04:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbT5N4Ii"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641BF14D2BB
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 04:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737348636; cv=none; b=cg95HeUPaGxgmEvL6zMopLiJlQLe8rzULiZGhSxFdkVEBsns2ad5cz5fsPEZ+lcyUr5M2Yu6LFSNhbjP/rDrf2WVtG+xnf+/QO2veg6j8KHoHCD9tC+6oVIwrFJqHayIDTamnbS5wiYZzKs6QqREzjd6oVasYCbS2SpJSiBVyL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737348636; c=relaxed/simple;
	bh=e/iDzvTCC8bo1dFL2/v4kqgePEuwnjykIjQnI6TREos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i/qe2WKGi989RhY8RJ2T0xD+HaF9pQanVUAzF7gXUmjSsWQTOe6K5FWRz3jrQPSiG1ZzyuX4Llbu+su3voRZIOHVjTs/F+TygwEt9Ht/ogXd2zsOkEBPumX7rSdDGvC7P1khtio6NhaJxcC2XpQ/avcRLVuQjQTu/c2P7CDbWms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jbT5N4Ii; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21a7ed0155cso62285245ad.3
        for <stable@vger.kernel.org>; Sun, 19 Jan 2025 20:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737348633; x=1737953433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FW6GDAHddcOMPFKJEakNdIWoZuUyT1szsyK8VMgB8Uk=;
        b=jbT5N4IiRc67b3DRzhZw7kyJO8SML5ZJHdIv1I7VxTKrxYXxjswIhTLgaftIM9h+tJ
         +2vxh46mWo0kH5RJB9jzjdqJmC1DGmIJDy2EaR5XfKfYrjYiPa2C0d+MN4520u1fpTFy
         X2WyXM++aqGX/krCYfz71qMdA+c7+hqQSQoBID+73VgRtoQGM0fghbeNvCspdTAyn8ri
         z2ceVaDKRiuNtjnB7pUYCKHlKkoEuq20FihjzgsSOUHyO2b+N+umC0eFPLdsIc9hOlYp
         mtxODA+KGKQgvsPKv4B/DFxqylIOkBqhw2RNV/vJJ+blAgIrPRzkNC+JQLtAvlTD0sgt
         dvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737348633; x=1737953433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FW6GDAHddcOMPFKJEakNdIWoZuUyT1szsyK8VMgB8Uk=;
        b=huJdVQzO2sQa1aBF9AkVjdhoUUhKc9NoDTa8crK2ZxLCqOKnh9cEtvQhd/aKPNGu9G
         w9EiJajBd4N9YGYVqZ+TX7lqfkItzOdgu89EvYEBwBZqrByzX2LRoYoNFdNPG2oq1XMF
         X7zifo0lZOhwrTb9PZVx9eI1Ef4bfNDJmQ8aY196zNCeYcV4dvmc4tAhylUa17Ll46Ty
         Q6eKJSSbJbxnZ5jsILKk6491jOAQll8qq5FA9smWmmM7/sV6q0em8/cXkIcwZEu7S8gY
         /zH3VEPdeOh8dgyFF19r52cBeNBatBuIu3yQ72wmOR1FE4zZ3gxhL4xxpOgeF1dI3D1s
         UvXA==
X-Forwarded-Encrypted: i=1; AJvYcCU2CdErLGFqL0WhDavFyAmaKXX2Jgkoze4UkSx0l2gg1wnIY0Poc133HeRPE2OeMJONSkuETpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQr/Aw4FBNx3fP7GNqqOndtjj4M8io0s9gcEvDrv5Ph6sbVRy
	0GrF0aE6kj/DRpz8zVerB1bdb56qsj6DKy945TZb0kY1bkCor/gm2u9kjSJm0YM=
X-Gm-Gg: ASbGnctjUMPJFnImegkI/3233WZFsHqS/YqAXhRtbdY5HBE24q6ynl+j1pnLCGoG9g0
	WnhoqfJw/INq6Gz+PL+rX5jKrFHY7IK06yzHD2pVmmYWMabRS8Ydpq+YCIOoQsrpOSidO906b4M
	p1NVWCOgz7MlqB0+U5Fz5Wy4JTY3fz6J4sIbWpN6efZhQQX8sJTKN7yY2u9HwYA530ovXe+AmjB
	pE3KTKJFqXeLdcsRLxPKseL+19sX7VInWmvunvv+XY0ZuSavSSIi4AsTXhlyrYGyKZ7s5ra
X-Google-Smtp-Source: AGHT+IGFk0vEdymtZTj+lLuHlMGCHpVVSzOjAS6UfJXaYfWRkrCAng+HqZSDbAH8bdLeqj6n7JsTPA==
X-Received: by 2002:a17:902:ce8a:b0:216:32c4:f7f5 with SMTP id d9443c01a7336-21c3540c7a1mr174490975ad.19.1737348632564;
        Sun, 19 Jan 2025 20:50:32 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3a91cesm52428625ad.133.2025.01.19.20.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 20:50:32 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	kernel test robot <lkp@intel.com>,
	stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: s3c64xx: Fix compilation warning
Date: Mon, 20 Jan 2025 10:20:25 +0530
Message-Id: <76b218721e5fd5ac2fc03e1340595c9a56c1613d.1737348588.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver generates following warning when regulator support isn't
enabled in the kernel. Fix it.

   drivers/cpufreq/s3c64xx-cpufreq.c: In function 's3c64xx_cpufreq_set_target':
>> drivers/cpufreq/s3c64xx-cpufreq.c:55:22: warning: variable 'old_freq' set but not used [-Wunused-but-set-variable]
      55 |         unsigned int old_freq, new_freq;
         |                      ^~~~~~~~
>> drivers/cpufreq/s3c64xx-cpufreq.c:54:30: warning: variable 'dvfs' set but not used [-Wunused-but-set-variable]
      54 |         struct s3c64xx_dvfs *dvfs;
         |                              ^~~~

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501191803.CtfT7b2o-lkp@intel.com/
Cc: <stable@vger.kernel.org> # v5.4+
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/s3c64xx-cpufreq.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
index c6bdfc308e99..8fc43a74cefb 100644
--- a/drivers/cpufreq/s3c64xx-cpufreq.c
+++ b/drivers/cpufreq/s3c64xx-cpufreq.c
@@ -51,15 +51,16 @@ static struct cpufreq_frequency_table s3c64xx_freq_table[] = {
 static int s3c64xx_cpufreq_set_target(struct cpufreq_policy *policy,
 				      unsigned int index)
 {
-	struct s3c64xx_dvfs *dvfs;
-	unsigned int old_freq, new_freq;
+	unsigned int new_freq = s3c64xx_freq_table[index].frequency;
 	int ret;
 
+#ifdef CONFIG_REGULATOR
+	struct s3c64xx_dvfs *dvfs;
+	unsigned int old_freq;
+
 	old_freq = clk_get_rate(policy->clk) / 1000;
-	new_freq = s3c64xx_freq_table[index].frequency;
 	dvfs = &s3c64xx_dvfs_table[s3c64xx_freq_table[index].driver_data];
 
-#ifdef CONFIG_REGULATOR
 	if (vddarm && new_freq > old_freq) {
 		ret = regulator_set_voltage(vddarm,
 					    dvfs->vddarm_min,
-- 
2.31.1.272.g89b43f80a514


