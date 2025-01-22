Return-Path: <stable+bounces-110103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2630CA18BAD
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 07:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A23516BB57
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 06:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FD0190674;
	Wed, 22 Jan 2025 06:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rdkC43p3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E011537CB
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 06:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737525985; cv=none; b=THhQZ12At29TLDn5uTML5V5uAk2eKKrqAE860zuTHD160CpU1ys6AJYpvWuU126VFLHhZFlLKes5lmpkMyW8xqE4W8cr5wPiuGtf15RFwINux8KhAF1zJzVL4/185HOuTZ7zACHD6DQhNTfbP3GPdUVOZHYswA8MfQJmR6P0zWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737525985; c=relaxed/simple;
	bh=Ex439rGdFdfUdYHc9niaz10rACr4snOI2Q6IBNyOfDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jrwm22qQQEoMNXESQt3KCG2A16kQZvVFD+44UE7gidWBQiSVf3IOwuQB/W2VqZ1oJ6h7lMJrJAtUKEWsJYq3d6Lx2EDVOoZjf02J79v3blaqJR86JUR99EQjn+4xWG6eUYDBjoVP3Y2uFG1rEzK+gGfvp1mqwv7KvYAl2E1C1Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rdkC43p3; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee786b3277so8419980a91.1
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 22:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737525983; x=1738130783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0W20+yxBOW7S58mPqEOjxHOWXZCgIN0XLLUDfARBjDU=;
        b=rdkC43p3zZqu42eS4hh8xuJAWdf2ZKYPQ0PRxy58msDFeJF4hgHYqM8cEXwix4D1HY
         uZ7k2d/5YiDKoD8FB4w5gTVyclwnYHQv/NNpQWLt+JG8ikqbPTlfwdBUI8f1hoFNzk7y
         a8Fh+nKrp1yB0n53xVuV12uy/k8nNjDx3goH1sMG2B0QoriTb4e/ept+SGhxbnDvhPyn
         kG/TEE0Lp6Me5L5Q/qWuOuSupb93GSHySBBDSbCrdncoFNt0xFRz6466ZPFpkBIC67Sz
         7mTqFfnsjkrOnCCxkvEomyqfMVrLxfEBKaKvFIIjrfmiAJvUjZ12YYjJEsbhGJvm2csr
         8KhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737525983; x=1738130783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0W20+yxBOW7S58mPqEOjxHOWXZCgIN0XLLUDfARBjDU=;
        b=V44dAi9flRyCvoxuOtp2CdDhQcwMXNBzj8hQRmVVz3uLbwi2U0g+HSLy9JCSWIzZeF
         jpH2uHTuHazH3i/zbfcrQkBfbPvuUJKge0j3C4CLbneoUAVloluyGYIMCLVlfP2DtxMO
         ldcr4Ug8QR62lRr/f4f22rWnX06uWgIAu7eKsTTW31gTK1bHiR8Mn3SM7Pov+5Evvk29
         qEvrD1ZiwIz+spL1BRdoUVDDBCC6wwm73Gx6UgAx6VlObqqvd24H/vPUgBm81M7bwxtU
         P0KJnH6BgK/Q9tsTsSyooc87bCu5huBrZ4gvfg1KE/3MrJeXDcmUgcAk+c5PkZFJeVRu
         ix2w==
X-Forwarded-Encrypted: i=1; AJvYcCUtxvlrtyss/mQ6Iuy8LcE6yThUASpdyzxJ8vRqVKgmUJO7KSlBaAORXFNpLbp+LXgXPyqL5O4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnvBUhvB3Ms6f6EyYvHmg4QF7j5k+mmNpAzdm/T0dYglARd/YR
	Y1hLDx2H1VZ1pq686xNr1ph8Yo0rQT1Z7UijDXbMG0aFhujyq9GkqIx1cmqtdGs=
X-Gm-Gg: ASbGnctto3HWKLVlZ/SWc0e/YZfCdU1InZADW+3ntdGUpsl1odvURwKrD9AfD7zJVDW
	SF8Y9Idr3ZQ3cXsaU2eHfD7UuGRkfw1EfmsEBN+xUs8GhPOARzhl3KjZEurLGxgXmLFUEDOAEdJ
	zePaTIdzuh3qCpppxTVypYMPuPTEg41w/Knqttgvu29CApN2zuzV7VCFHnVH4wfwM1i32YHcfD6
	0gYE+1gZ33g6PDlb8N6RozPdvKGLBuzJIFXgHkD0WN5C85Dm/YWXt2/j+F6X9DorwmME4gh
X-Google-Smtp-Source: AGHT+IE4ag6j6hEEpyPWZk0VRFVk6mkVLAwHWJ2F4Qn9kdzng8UiejuaFtPP8B6RnjwiXV6/Vg4wEg==
X-Received: by 2002:a17:90b:2748:b0:2ea:59e3:2d2e with SMTP id 98e67ed59e1d1-2f782c73b7fmr31718132a91.10.1737525982910;
        Tue, 21 Jan 2025 22:06:22 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e6a65966sm648044a91.1.2025.01.21.22.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 22:06:22 -0800 (PST)
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
Subject: [PATCH V2] cpufreq: s3c64xx: Fix compilation warning
Date: Wed, 22 Jan 2025 11:36:16 +0530
Message-Id: <236b227e929e5adc04d1e9e7af6845a46c8e9432.1737525916.git.viresh.kumar@linaro.org>
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
V2: Move s3c64xx_dvfs_table too inside ifdef.

 drivers/cpufreq/s3c64xx-cpufreq.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
index c6bdfc308e99..9cef71528076 100644
--- a/drivers/cpufreq/s3c64xx-cpufreq.c
+++ b/drivers/cpufreq/s3c64xx-cpufreq.c
@@ -24,6 +24,7 @@ struct s3c64xx_dvfs {
 	unsigned int vddarm_max;
 };
 
+#ifdef CONFIG_REGULATOR
 static struct s3c64xx_dvfs s3c64xx_dvfs_table[] = {
 	[0] = { 1000000, 1150000 },
 	[1] = { 1050000, 1150000 },
@@ -31,6 +32,7 @@ static struct s3c64xx_dvfs s3c64xx_dvfs_table[] = {
 	[3] = { 1200000, 1350000 },
 	[4] = { 1300000, 1350000 },
 };
+#endif
 
 static struct cpufreq_frequency_table s3c64xx_freq_table[] = {
 	{ 0, 0,  66000 },
@@ -51,15 +53,16 @@ static struct cpufreq_frequency_table s3c64xx_freq_table[] = {
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


