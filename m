Return-Path: <stable+bounces-121189-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 964A4A544BF
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 09:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEFB0172432
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 08:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2B3206F0C;
	Thu,  6 Mar 2025 08:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iG479bV1"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AF4207E1A
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249408; cv=none; b=MjUCvP1ILSe8NQf7/bSw4j8/dXNG7AxYqIa1qPCaIxj6MTbqntgkvXW5p4pSCasormm+1QD+BmAL0NbwurZ3HPLkKejCpmEXnbWlJMA1QQT7hcaK89MyyC/qqzgMFLupS7t4ropFo3k7tgFoUcMMxKH2CUpRnAPxIw9ZGUAHfxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249408; c=relaxed/simple;
	bh=lAc7QZvJIebQnjnTgR83Rtb8SMGUbx1OPWh4AS20Mxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXSmsod27uxz6g1TD0YZvRX8YF0qn8jNpyMtsCZQGc5MF4hgxeuVM8KYOzVGwRIXlFhbNt6qAR+9QgXu8X9iYjeFOmco2koDYb08Fiqs2oYca1NVdxFNNwEEyfk3ASipm57SHpZ79N/tmLPV5EyNpxbsV0Z1ix30aKJ/ygoO5gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iG479bV1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741249406; x=1772785406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lAc7QZvJIebQnjnTgR83Rtb8SMGUbx1OPWh4AS20Mxw=;
  b=iG479bV1eZlHv6JvefeMv4ZTFpBWeDdfe06TbYgVTuU8AVlI/ugOBhtZ
   1X0c7frv29WFHdMfsAstjhp1jo9BbAUSsz4Qg5gQ9ZxptdQSAPIVNtVe6
   wY/DhrJ+Wp3KzkD4tbPUPv+SAHpeld7tF46HhPhFoLky97sdqzQwlNrgB
   ebsWSOX8cIIa8NyN0kQtgve0tvI7qjaxhXDTIUcSQEIbxmrw8i78tIbCz
   wPXRvvnBTUkc/i+usIzXhuabeChYfMPp2UdzIGZd3ac0R/759dBgFOtYc
   cTwZmYmqVCsOZfRqEqWGaEK5FAx26AOhhQ4q6qiFkYLK3rm31DMGUKzID
   A==;
X-CSE-ConnectionGUID: 7IdoxN4TQmSAX3e3vKUEiw==
X-CSE-MsgGUID: W9qKQcckQqahJwhMDfwAOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="46018717"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="46018717"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 00:23:26 -0800
X-CSE-ConnectionGUID: TVUGvwoWQCWGacwDVQj0pQ==
X-CSE-MsgGUID: d8Dlnl++QrWQsImNed7bkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="123901212"
Received: from sho10-mobl1.amr.corp.intel.com (HELO desk) ([10.125.145.178])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 00:23:26 -0800
Date: Thu, 6 Mar 2025 00:23:16 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Thomas Voegtle <tv@lio96.de>
Cc: stable <stable@vger.kernel.org>, Xi Ruoyao <xry111@xry111.site>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: Please apply f24f669d03f8 ("x86/mm: Don't disable PCID when
 INVLPG has been fixed by microcode")
Message-ID: <20250306082316.ca7ozay3yhrltfpp@desk>
References: <8ce15881-3a46-fc08-72e1-95047b844ec0@lio96.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ce15881-3a46-fc08-72e1-95047b844ec0@lio96.de>

On Wed, Mar 05, 2025 at 06:39:39PM +0100, Thomas Voegtle wrote:
> 
> Hi,
> 
> please apply f24f669d03f8 for 6.12.y.
> It is already in 6.13.y.
> 
> Backports of that patch would be needed for 6.6.y down to 5.4.y as it
> doesn't apply.
> 
> But I don't know how to backport that fix but I can test anything.

Could you please test the following patch on 6.6.y?

---
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH 6.6] x86/mm: Don't disable PCID when INVLPG has been fixed by
 microcode

From: Xi Ruoyao <xry111@xry111.site>

commit f24f669d03f884a6ef95cca84317d0f329e93961 upstream.

Per the "Processor Specification Update" documentations referred by
the intel-microcode-20240312 release note, this microcode release has
fixed the issue for all affected models.

So don't disable PCID if the microcode is new enough.  The precise
minimum microcode revision fixing the issue was provided by Pawan
Intel.

[ dhansen: comment and changelog tweaks ]
[ pawan: backported to 6.6 ]

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Link: https://lore.kernel.org/all/168436059559.404.13934972543631851306.tip-bot2@tip-bot2/
Link: https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files/releases/tag/microcode-20240312
Link: https://cdrdv2.intel.com/v1/dl/getContent/740518 # RPL042, rev. 13
Link: https://cdrdv2.intel.com/v1/dl/getContent/682436 # ADL063, rev. 24
Link: https://lore.kernel.org/all/20240325231300.qrltbzf6twm43ftb@desk/
Link: https://lore.kernel.org/all/20240522020625.69418-1-xry111%40xry111.site
---
 arch/x86/mm/init.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 6215dfa23578..71d29dd7ad76 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -262,28 +262,33 @@ static void __init probe_page_size_mask(void)
 }
 
 /*
- * INVLPG may not properly flush Global entries
- * on these CPUs when PCIDs are enabled.
+ * INVLPG may not properly flush Global entries on
+ * these CPUs.  New microcode fixes the issue.
  */
 static const struct x86_cpu_id invlpg_miss_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,      0),
-	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,    0),
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT, 0),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,     0),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,   0),
-	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,   0),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,      0x2e),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,    0x42c),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT, 0x11),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,     0x118),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,   0x4117),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,   0x2e),
 	{}
 };
 
 static void setup_pcid(void)
 {
+	const struct x86_cpu_id *invlpg_miss_match;
+
 	if (!IS_ENABLED(CONFIG_X86_64))
 		return;
 
 	if (!boot_cpu_has(X86_FEATURE_PCID))
 		return;
 
-	if (x86_match_cpu(invlpg_miss_ids)) {
+	invlpg_miss_match = x86_match_cpu(invlpg_miss_ids);
+
+	if (invlpg_miss_match &&
+	    boot_cpu_data.microcode < invlpg_miss_match->driver_data) {
 		pr_info("Incomplete global flushes, disabling PCID");
 		setup_clear_cpu_cap(X86_FEATURE_PCID);
 		return;
-- 
2.34.1


