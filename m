Return-Path: <stable+bounces-132893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE44FA911FE
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 05:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E9A3B8224
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 03:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722981BEF7D;
	Thu, 17 Apr 2025 03:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDHiRckF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF689366;
	Thu, 17 Apr 2025 03:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744860300; cv=none; b=bLhtHs77sXY47dcmsLxXMbRORWn58sGemDgEtWVaxv/ls4ER7SLVfe5Dm3R/l0Acx4u+C2DB5R5lQg07NEEIaQk7AM3/JAc7J3dB6JJqrw/Dmyj1HBVqTDtTc3KAqHSkqSTOV+c/XcSYjOQ4RqXufrZmSR6Oi4vc/KCXdIPD5Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744860300; c=relaxed/simple;
	bh=fb3d8VX6ohYfanNtyOhFEEPPWcIA2WkivXA2C8+k5iU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lEA9HHB2UYqIh5dxuq/diNjC+W2cWvzW4RngbQ+II3hTX6S60F1PG7J0meTfNjemXwbR+f5B/MdFc667AkL9lt06RyqRmv8RpTm01i7QkxtsbrrC09zDZID/q+LvwFqarPLExSpiNfOlDdJzvj/5RB7+u65g4B3BrWWx6WknizM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDHiRckF; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff64550991so162913a91.0;
        Wed, 16 Apr 2025 20:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744860298; x=1745465098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R52UzM/+K9VKmjAtqNDjFGDJ0Wy7+MuhwjxN+bw4A+g=;
        b=MDHiRckFaW+018fY/3VOP0lnQbW81qUcVL7w+bDo13lsz+tvfzhGbW1BAQxkTj5rq6
         ieqcNeifHAxCuzuliZiKl7RtOIk6MV1xqmpDjGUvR/1Wf+cDpYwSdYd9MKZKa1jSkcsl
         eMEjX0XeqtH2R3XeNOM3OZD8hQ30nn+qcQmCYk6MzYKycj4FeH2cO2UMwnB6kHp/oKAN
         jaQ7RkhqV0Ves/LrHAV6zu9GguRtZ+0bcnxipVFV7GfAHat9LCKknnH1nVXa1szUgTjG
         K2zdS8crluLsOa4rixwaOwoe/cTGhJLrO1t3O8ZyVsjDevk7OcYPBVjDIW/wVCf+ded8
         UZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744860298; x=1745465098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R52UzM/+K9VKmjAtqNDjFGDJ0Wy7+MuhwjxN+bw4A+g=;
        b=HhKfCdfec7J62V1gKPIA1xYfcr7hrdBP9JD0ZlD6LKNzDUsR1touyq5RoyeksAn2Us
         UZJfD+m0vn40lItnsew9DpT3D08JXHoLyvzvU0dfIAJMLy9L0nufZl200pC7zJXchjPP
         DxlDyRtS31WwGE/8SN+XCR8fW9HZTBl8jGTaI7fh4GEjnlp1N7pOGlolE5aLcCBZ8HPf
         cY7GptYZepYgLIqCzBYPL+4eaJCLa1S+IkUBg2OgUKT+rXj70DbzRaJatCw4PXu0cIp4
         gYNFTXqswLDjUA740/pdxPxjA9I+pvPyPJx5uem+BzdiW6Bt9yTg/SAgy5f+trBOlXaO
         r+Uw==
X-Forwarded-Encrypted: i=1; AJvYcCW9ksYU00fcT7U8ma2X0uDAYD9nR2U+jKQHmU1fc68qbiQJ/nVWYriMtxk7maToglUuO2SsWFK6lUuIYtM=@vger.kernel.org, AJvYcCXt7HSL29fizAJ08gUIKKSFN9D4qIET11GCvSodwaZMxVhkWUMUgvV+/yXR5l22girc6AdPBod9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9WfZ14bSgctGFtGpa/QTNiT4NB3Yd9ZIsrfAv4V1qgedfhjih
	dQNN5LV4LxGI86u6mWnvrX+MSJ3+Z4lkV7fAbgElAeALvGGBgZXwcl75uGFKmf3W+XXf
X-Gm-Gg: ASbGncvl6cL7pAAqiwwUmiuQgEK5+KN5FuLGtZeLxRrbrZtx84pKC9tmSsEUL3X/Wlm
	55bQ9w7fJtADmEx0zWTtmKrO12cU5HfOXA/RB68+zU6N3GDE8myerjFAuuqAcuYdivdTQ5jftEM
	9RxLTEnwUIKeAFbUIBOiEHmABjiFmX42I9blpW1IaZSdEI+1F/fNlwZjKsLFroDitxiRz7YD+0t
	zS5LTzBxjBTpE8uHeiOLn3ME5w5dxerDdAW5phtv/jAnMfzLzw8vsQufuqnWZwnwd3oUpMBZh7G
	4eQnahwhyK8OQ8JjTFbNbc/ZE+oJrb4UANFuJ/JNxD1RV2hH4tfjFDCupCcTyk/H1ONyKbMhMKh
	2Bqc=
X-Google-Smtp-Source: AGHT+IG4y8rKinLRtHLpPT6GEZmsIefCooQtcwjx3m0C6SxkQFiEk5lsiFMoBinpNlRHPxXuAzqo3A==
X-Received: by 2002:a17:90b:2b4b:b0:2fe:dd2c:f8e7 with SMTP id 98e67ed59e1d1-30863f19154mr6673105a91.10.1744860297962;
        Wed, 16 Apr 2025 20:24:57 -0700 (PDT)
Received: from SHOUYELIU-MC0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30861212fa6sm2495710a91.27.2025.04.16.20.24.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Apr 2025 20:24:57 -0700 (PDT)
From: shouyeliu <shouyeliu@gmail.com>
To: srinivas.pandruvada@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shouye Liu <shouyeliu@tencent.com>
Subject: [PATCH v3] platform/x86/intel-uncore-freq: Fix missing uncore sysfs during CPU hotplug
Date: Thu, 17 Apr 2025 11:23:21 +0800
Message-Id: <20250417032321.75580-1-shouyeliu@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shouye Liu <shouyeliu@tencent.com>

In certain situations, the sysfs for uncore may not be present when all
CPUs in a package are offlined and then brought back online after boot.

This issue can occur if there is an error in adding the sysfs entry due
to a memory allocation failure. Retrying to bring the CPUs online will
not resolve the issue, as the uncore_cpu_mask is already set for the
package before the failure condition occurs.

This issue does not occur if the failure happens during module
initialization, as the module will fail to load in the event of any
error.

To address this, ensure that the uncore_cpu_mask is not set until the
successful return of uncore_freq_add_entry().

Fixes: dbce412a7733 ("platform/x86/intel-uncore-freq: Split common and enumeration part")
Signed-off-by: Shouye Liu <shouyeliu@tencent.com>
Cc: stable@vger.kernel.org
---
 .../x86/intel/uncore-frequency/uncore-frequency.c   | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
index 40bbf8e45fa4..bdee5d00f30b 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
@@ -146,15 +146,13 @@ static int uncore_event_cpu_online(unsigned int cpu)
 {
 	struct uncore_data *data;
 	int target;
+	int ret;
 
 	/* Check if there is an online cpu in the package for uncore MSR */
 	target = cpumask_any_and(&uncore_cpu_mask, topology_die_cpumask(cpu));
 	if (target < nr_cpu_ids)
 		return 0;
 
-	/* Use this CPU on this die as a control CPU */
-	cpumask_set_cpu(cpu, &uncore_cpu_mask);
-
 	data = uncore_get_instance(cpu);
 	if (!data)
 		return 0;
@@ -163,7 +161,14 @@ static int uncore_event_cpu_online(unsigned int cpu)
 	data->die_id = topology_die_id(cpu);
 	data->domain_id = UNCORE_DOMAIN_ID_INVALID;
 
-	return uncore_freq_add_entry(data, cpu);
+	ret = uncore_freq_add_entry(data, cpu);
+	if (ret)
+		return ret;
+
+	/* Use this CPU on this die as a control CPU */
+	cpumask_set_cpu(cpu, &uncore_cpu_mask);
+
+	return 0;
 }
 
 static int uncore_event_cpu_offline(unsigned int cpu)
-- 
2.19.1


