Return-Path: <stable+bounces-77707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC36B986264
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 17:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CEFB2885A5
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE7C178364;
	Wed, 25 Sep 2024 15:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gpNkHAMj"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA79318990B
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276527; cv=none; b=i8DiCpUcYOZZ5hVu4cSbaTxki7V9LYPcytGo5VQSKf/Svyf7aiJwRX86O0GEf0sjlx6WxTB/UQY2f1R8aOvPs1DJMv/oLH4VZLL8AtSwHZxnWbgGhQkDnT8ADiyBw6OZagA4L4bNHCbOobrfq6F+2CZFgZszna1yut7nWfm+qSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276527; c=relaxed/simple;
	bh=cfsaHYVmMR7Cf1CKVGZ37iUniOWxb/XlzErNhCkIecI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=n34s68deqWw0djEab0rlK1jhGJCr8c2k1NBRSaVAFx8BUzbrwlaQt5ZjCUmW3APjuOtZ1s7NdqKbe2PlOU4k4a3CQw4zJAB+XpFfhv7F9cx6QLFGaePDUalaOIp6r0l3yzp5lXXhU/1W9vqRR4VSo6fZv9fRijiZuA72Vw9dIOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gpNkHAMj; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727276525; x=1758812525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=cfsaHYVmMR7Cf1CKVGZ37iUniOWxb/XlzErNhCkIecI=;
  b=gpNkHAMjyuCqMXn097gQeeOkbq38YkLNMQR+Bg5gvK/VirZrRIU+SXd1
   Zntv19EaGMefrWq0XlyY8tPZ0X5dihcwaOq6/EfehXN+UWD6L+kFXuvPX
   rV6kJ4Zk369AdHxBujuqW87QZ3CMlmUY/rTeXRIFbtzbSnzPL3XocJwxw
   4azLpiQ1QSHLP1ZyKSqAp328n6lMRcP3aS0r6e0YtoWZzKaQN5KtMju63
   +snInz3Q7mCVlK11tADpwVcaXzzDPdZWXfDeVujTYg3Qbd0Hj20D+o4uH
   WjEjfods3A2k3KuU0IQ69+P2QUNzibZL49rGsqdliYtBMqu0720tWyfAp
   w==;
X-CSE-ConnectionGUID: sddO2NC0R3+noP8jNd5uaw==
X-CSE-MsgGUID: mI6NPANYSb6zoVeVBlHkkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26194387"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="26194387"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 08:01:59 -0700
X-CSE-ConnectionGUID: IM5mMKGJSD6rLXIWIOQbYw==
X-CSE-MsgGUID: IzQ34whfQBKwkUNGE+Z3qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="72256161"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa007.jf.intel.com with ESMTP; 25 Sep 2024 08:01:59 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: stable@vger.kernel.org
Cc: x86@kernel.org,
	Tony Luck <tony.luck@intel.com>,
	"Pawan Kumar Gupta" <pawan.kumar.gupta@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
	Thomas Lindroth <thomas.lindroth@gmail.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH 6.1.y 2/2] x86/mm: Switch to new Intel CPU model defines
Date: Wed, 25 Sep 2024 08:07:37 -0700
Message-Id: <20240925150737.16882-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240925150737.16882-1-ricardo.neri-calderon@linux.intel.com>
References: <20240925150737.16882-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Tony Luck <tony.luck@intel.com>

[ Upstream commit 2eda374e883ad297bd9fe575a16c1dc850346075 ]

New CPU #defines encode vendor and family as well as model.

[ dhansen: vertically align 0's in invlpg_miss_ids[] ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/all/20240424181518.41946-1-tony.luck%40intel.com
[ Ricardo: I used the old match macro X86_MATCH_INTEL_FAM6_MODEL()
  instead of X86_MATCH_VFM() as in the upstream commit.
  I also kept the ALDERLAKE_N name instead of ATOM_GRACEMONT. Both refer
  to the same CPU model. ]
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
I tested this backport on an Alder Lake system. Now pr_info("Incomplete
global flushes, disabling PCID") is back in dmesg. I also tested on a
Meteor Lake system, which unaffected by the INVLPG issue. The message in
question is not there before and after the backport, as expected.
---
 arch/x86/mm/init.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 913287b9340c..ed861ef33f80 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -262,21 +262,17 @@ static void __init probe_page_size_mask(void)
 	}
 }
 
-#define INTEL_MATCH(_model) { .vendor  = X86_VENDOR_INTEL,	\
-			      .family  = 6,			\
-			      .model = _model,			\
-			    }
 /*
  * INVLPG may not properly flush Global entries
  * on these CPUs when PCIDs are enabled.
  */
 static const struct x86_cpu_id invlpg_miss_ids[] = {
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
-	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_N ),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
-	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,      0),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,    0),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,    0),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,     0),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,   0),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,   0),
 	{}
 };
 
-- 
2.34.1


