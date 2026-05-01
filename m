Return-Path: <stable+bounces-242494-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MRSKF/49GnkGQIAu9opvQ
	(envelope-from <stable+bounces-242494-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:00:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADEF4AF00B
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 21:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09E3B30193A6
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 19:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1F741C2FD;
	Fri,  1 May 2026 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XL1DKeSM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15683EC2D0
	for <stable@vger.kernel.org>; Fri,  1 May 2026 19:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777662034; cv=none; b=SrJg6KNe2pkhRnBzdiQEY7AhjdkPjy2j6BT0KxwJsGK8w/J0WnutA8uv/yEJm7ItXZjwYgC6fB3hIRdw/1k1hMT8Te46C+TL2EWDAJeMK0tU11ieKotLy1Zwpi5EjHQDIW9KXBFSA6CBXHz1bi2mjrWeNrTLwJwbWCQ0CfS1Vmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777662034; c=relaxed/simple;
	bh=J6D9KYDFjB2m0D4tZGtKNFNFDOx+6/Y/naS4pbb+Knw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DXLEUxl33anebeE0fo0Y5ezxSS+Jk+wkViSCsLZjozp8xPFey2cb1yrb0NDb1eoOWIrIfDSxafzTnQzZ93HcUrrVmz3HxvT9oGNtY9qikpq8wngzmKOGUNRC1z8k1idpeOcQerbdBF7WNI79miO9RHDaQx/nTa2SsunfsYvWSvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XL1DKeSM; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-834f1075805so1617486b3a.2
        for <stable@vger.kernel.org>; Fri, 01 May 2026 12:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777662032; x=1778266832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vqfXSrQ/LcVyuHZiK19DFrhGz1VJgx9L+sEeQ6hZEtk=;
        b=XL1DKeSMzJhnJgu+XAvs7NLlKAVPPUNpND8U+YTPf9fUT2esF2h9b5pHCtvzKUFm+M
         qeH2gpgqtAXCrC6cIX1qjKRvvTTaJcEG/DgHxhgfh3Os65piDOrP7LAEUfI+0YcDOiEQ
         h7BPMhn6F77ZuwYwEoqQQ3inHS6PX/F/36x7bXm3J2Tko8qRjRbkesZuOtdYa/DOdz1S
         YgNar2Us/nZODFQRovEv+asGsTfOx8NbIsWmRFxN8snLAL1Yq7qi6G8gr7BcSspnISlW
         lSakbrAJPw7+1jjhAHNuin3qzfAa5MwtwnBOQwVwENsTRC8sFrZwfjWbuBcFNTGkZ2vN
         zYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777662032; x=1778266832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqfXSrQ/LcVyuHZiK19DFrhGz1VJgx9L+sEeQ6hZEtk=;
        b=qMmrKO+7mErpl8WbuKgTA/az9+Y2zgBigA7gAy6zDeM3Pb6HDMiGWn8xLvNuGXVLlf
         YL3IZTVovUJmbQ6p2z9DhJZ86MJcdY7kXdPXY/hM/bkZgFwGwj1Sj94cYdeRNbc53UUq
         iTcNlOXNzqaLt9sD1SdP134nSe1xEvoBpmHqva6jB9f5SY2ncHROiTnnCZ1+nON5xeI9
         IXfUJm+Yyp+8Bh/asKJs8uL+eP2VUwsJ9AjTiJnYY7eCRvuJNwFz7P2uTEHqM22JFIDl
         4SHwdSc1kP2ejxElxlJKzgrF11N9LGdJVaYRBwxpfKdOgLI/3CAz6srlbJ1pi0s7+DZT
         SR6g==
X-Forwarded-Encrypted: i=1; AFNElJ82niwEmyvLHdJC895xe2XYvLvbmONeVPQJkTE1Np/6mRjT9b5r/gwwQNaXVpJZu7nTBLcoGos=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDth8yROA9N1qUBjiezpeJAPwAZyc/vxMWCPFReyh8QZcayN+9
	ETfZcyRG2RhSHAhPEbIqBWhJwwTm94mVsBjbaFyxBDcebR49Sd3BKRk4
X-Gm-Gg: AeBDiesVu0p7i40bwJ431arn/aT/T0phot18jkDScxji/AJ2aaYZLleW9xOry0CwB5J
	5owF0nC+DvKix7EeKsuOKDHy0VkDFczzlIFZd8+cVZtz9dAly6NT8wjnpJ6Vl93+cfuXzT1hJb0
	G8XG5nbQj9Zwmv0RQD3yE5un3lfpYUYRYRGHZhmvWym3/qaBniJaSt2JUoJn+gp2aaOq/fwHy7t
	NugyI+ABPkWJhBIO85+8HeVXMLVonsJePc2HdsvLshw461zOi9F7tH32vbuBMU2DEZqnu9FASDG
	oVdWMm7OpTFmQProaqEVRurSuV5qr4Rsvg8RDAg6Pn5UnKwef/tPFjVh13RN4zM+u3ayoaTZHU+
	sRP7Kp+s2nRJhGQv4Kzp9B/nuYRXH+FVVdXfmUh3oq6SawsOYL26R0Q5U5q8Y5LTTemMifq+x/6
	1yhpImDmyFN5+JL1a23tMqUsM=
X-Received: by 2002:a05:6a00:883:b0:82f:6dad:7b75 with SMTP id d2e1a72fcca58-8352d25e95fmr398194b3a.33.1777662032246;
        Fri, 01 May 2026 12:00:32 -0700 (PDT)
Received: from lgs.. ([118.193.39.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b87869sm3543691b3a.61.2026.05.01.12.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 12:00:31 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] cpufreq: qcom-cpufreq-hw: Fix possible double free
Date: Sat,  2 May 2026 03:00:05 +0800
Message-ID: <20260501190005.504962-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2ADEF4AF00B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-242494-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qcom_cpufreq.data:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

qcom_cpufreq.data is allocated with devm_kzalloc() in probe() as an
array of per-domain data. qcom_cpufreq_hw_cpu_init() stores a pointer to
one element of this array in policy->driver_data.

qcom_cpufreq_hw_cpu_exit() currently calls kfree() on policy->driver_data.
This is not valid because the memory is devm-managed. For the first
domain, this can free the devm-managed allocation while the devres entry
is still active, leading to a possible double free when the platform
device is later detached. For other domains, the pointer may refer to an
element inside the array rather than the allocation base.

Remove the kfree(data) call and let devres release qcom_cpufreq.data.

This issue was found by a static analysis tool I am developing.

Fixes: 054a3ef683a1 ("cpufreq: qcom-hw: Allocate qcom_cpufreq_data during probe")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index ea9a20d27b8f..ef19faedbfec 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -578,7 +578,6 @@ static void qcom_cpufreq_hw_cpu_exit(struct cpufreq_policy *policy)
 	dev_pm_opp_of_cpumask_remove_table(policy->related_cpus);
 	qcom_cpufreq_hw_lmh_exit(data);
 	kfree(policy->freq_table);
-	kfree(data);
 }
 
 static void qcom_cpufreq_ready(struct cpufreq_policy *policy)
-- 
2.43.0


