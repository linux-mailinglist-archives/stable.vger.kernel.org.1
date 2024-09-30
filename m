Return-Path: <stable+bounces-78284-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F19EC98A8FB
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 17:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DEF4B2AB2D
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 15:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68E8195F3A;
	Mon, 30 Sep 2024 15:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZVrJ0WiA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A378192D7F;
	Mon, 30 Sep 2024 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727711111; cv=none; b=iF+uqJLS5pZ3rglzX8pMwAjvth396TiuqvMsIWg2rGMz9Pr/Pk8uvAbQhD2lXz/euMHaCex2uOo0HUCWR/gYMisX1aBRQPQbr1owMc+hdJbQsWnNTP5OXw1eTZZ24Pf2Uw1vYTQMoK8j6s46u2q/pPcyyuv1VVLxz5qbilIJ3Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727711111; c=relaxed/simple;
	bh=IkZcH+dr/dc2FTVfUpgfG4mg44WAOh1K6ZY3C+oqHkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TDrq5FbwDvAoHrAOuS5WxbXO6OzUrN85D8KW/UiYXg7T6GFGywqVbu+EF5jT96N/pl4wide4k0ePG2/puLk24O8d9vLM3bfXG6KK1QyofcAuH2DXSN0U7eCaTD1/Ex8+uxRIlFdDi/g+0dT3e7JkPn7f2Fhhc5njNMyJ1GGCt/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZVrJ0WiA; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727711110; x=1759247110;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IkZcH+dr/dc2FTVfUpgfG4mg44WAOh1K6ZY3C+oqHkk=;
  b=ZVrJ0WiAvSlcl4tpiOsZ3k5tESSTUmfr/x7LD4smbAZl8T3k85NYvp6D
   an65fR8rzym0P4Z91HaArUKdH+ySej6zkki2ox3MSbyRk1s67VQcdY+nW
   xSS5HKIlVJ169KQL9nFBSBmNGq43A7D8y6CI7Lgll5LvTyqjsyvIGM1wa
   Wj57MP26HP+q57N/tokRkdCVtSwzsR4gDQTdUhg2Micm/X1rdsB0DFcnp
   UceiTZzLicAIHKsFTlMd+ERuXyOw8NrRTp/wqZD75KnFliyC5AIDupG0F
   IWUP9PNOv1rmVx/lyd0+1x+Rc/NrmtOGNphcjCWzaUh3+dSoT5+l6Cf5H
   g==;
X-CSE-ConnectionGUID: 1ngtR6tTTA6qZro9AJg37Q==
X-CSE-MsgGUID: /G4HQFIJRWWBThphSmM7ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="26934949"
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="26934949"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 08:45:04 -0700
X-CSE-ConnectionGUID: DTbva3IfT/SV4r9NTMr44w==
X-CSE-MsgGUID: hYPnjd9KQ6ieRBjSuZrFFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,166,1725346800"; 
   d="scan'208";a="78306550"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 30 Sep 2024 08:45:01 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	kernel test robot <lkp@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] firmware/psci: fix missing '%u' format literal in kthread_create_on_cpu()
Date: Mon, 30 Sep 2024 17:44:33 +0200
Message-ID: <20240930154433.521715-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kthread_create_on_cpu() always requires format string to contain one
'%u' at the end, as it automatically adds the CPU ID when passing it
to kthread_create_on_node(). The former isn't marked as __printf()
as it's not printf-like itself, which effectively hides this from
the compiler.
If you convert this function to printf-like, you'll see the following:

In file included from drivers/firmware/psci/psci_checker.c:15:
drivers/firmware/psci/psci_checker.c: In function 'suspend_tests':
drivers/firmware/psci/psci_checker.c:401:48: warning: too many arguments for format [-Wformat-extra-args]
     401 |                                                "psci_suspend_test");
         |                                                ^~~~~~~~~~~~~~~~~~~
drivers/firmware/psci/psci_checker.c:400:32: warning: data argument not used by format string [-Wformat-extra-args]
     400 |                                                (void *)(long)cpu, cpu,
         |                                                                   ^
     401 |                                                "psci_suspend_test");
         |                                                ~~~~~~~~~~~~~~~~~~~

Add the missing format literal to fix this. Now the corresponding
kthread will be named as "psci_suspend_test-<cpuid>", as it's meant by
kthread_create_on_cpu().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408141012.KhvKaxoh-lkp@intel.com
Closes: https://lore.kernel.org/oe-kbuild-all/202408141243.eQiEOQQe-lkp@intel.com
Fixes: ea8b1c4a6019 ("drivers: psci: PSCI checker module")
Cc: stable@vger.kernel.org # 4.10+
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/firmware/psci/psci_checker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
index 116eb465cdb4..ecc511c745ce 100644
--- a/drivers/firmware/psci/psci_checker.c
+++ b/drivers/firmware/psci/psci_checker.c
@@ -398,7 +398,7 @@ static int suspend_tests(void)
 
 		thread = kthread_create_on_cpu(suspend_test_thread,
 					       (void *)(long)cpu, cpu,
-					       "psci_suspend_test");
+					       "psci_suspend_test-%u");
 		if (IS_ERR(thread))
 			pr_err("Failed to create kthread on CPU %d\n", cpu);
 		else
-- 
2.46.2


