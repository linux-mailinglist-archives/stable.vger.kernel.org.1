Return-Path: <stable+bounces-105424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 768D39F9498
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 15:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0014518899BC
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 14:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94097217F4C;
	Fri, 20 Dec 2024 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AogqKVjM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB52E217F3A;
	Fri, 20 Dec 2024 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705499; cv=none; b=Gncwm2HmxshjRp7oPqh7eR5CxMriNNLgxqEbj6CRto282GxgtWyFjESLU1xgpr21PUbNr32bjDfCkCjNiiOQ7A/3FogIMjaRZCLepZP5lcsxi1U2ccr1XvDE7BfEv0eA339VuoYcW+9XGUL27Y5KCxvr3P4sVWkQqd2KRMiWWDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705499; c=relaxed/simple;
	bh=+96AD/7nFuyd6WNFb2sMFtOVX/oBZtKO/mOF8ByRsGs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NIa0kAKUtfG8tvc7BC5Kgetn52661q37saevKix+KyYhGeNOgdJvMLpmocK/FXg1BZywaAEtTjem/BbDlfvIX4d1+5EVhPJV4ZUBGui5ulBWdXvOtnZBi73MG33OgM1QrmbkMX2hEbgg5GMe/zk7vZbWAtFP98Pl3pw0UrnWMqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AogqKVjM; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734705498; x=1766241498;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+96AD/7nFuyd6WNFb2sMFtOVX/oBZtKO/mOF8ByRsGs=;
  b=AogqKVjMUW3CmOWZ99NhpG+ICqDppSJuXgPnGiSJZV+nuzZM+f0nJjto
   RAyxhFueg76Gwy0wEFOhRxn/MOQx6YtrplqIoX9cnIPaXbjMR51ZrppDo
   qB3MYAMHHH+fjiOw5g5x+/hOzbRZfiZLE5pJCmOTnFrMQWLKqzJEw3hAn
   TV0AmpVPmxUXArgZ8iIV8peXw9n+iWEAguHKCDhMwG7iOh8iCL5+ygVfW
   Aob3y1TEMS9eR4Lk/pyx69mv/DLCsToVm7SKSKMdS6w3/EZ57nXg/rKXv
   FEy2kf8FCLEL+LTF1PTp9+padvBMl/udsENRB7Wvm58yx9AgLrQD8a/2A
   g==;
X-CSE-ConnectionGUID: 7bxAE/hhS9S1Dm/zjuUMYg==
X-CSE-MsgGUID: vwD/dkaVQmGBpQgB8O3qZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="38095656"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="38095656"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 06:38:17 -0800
X-CSE-ConnectionGUID: S2V+bIWiT4SfioG+grq7QQ==
X-CSE-MsgGUID: jIsFi6+cTEab53UlzhsXSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102650345"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa003.fm.intel.com with ESMTP; 20 Dec 2024 06:38:16 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	dapeng1.mi@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH V7 1/3] perf/x86/intel/ds: Add PEBS format 6
Date: Fri, 20 Dec 2024 06:38:53 -0800
Message-Id: <20241220143855.1082718-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The only difference between 5 and 6 is the new counters snapshotting
group, without the following counters snapshotting enabling patches,
it's impossible to utilize the feature in a PEBS record. It's safe to
share the same code path with format 5.

Add format 6, so the end user can at least utilize the legacy PEBS
features.

Fixes: a932aa0e868f ("perf/x86: Add Lunar Lake and Arrow Lake support")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org
---

No changes since V6

 arch/x86/events/intel/ds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8dcf90f6fb59..ba74e1198328 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2551,6 +2551,7 @@ void __init intel_ds_init(void)
 			x86_pmu.large_pebs_flags |= PERF_SAMPLE_TIME;
 			break;
 
+		case 6:
 		case 5:
 			x86_pmu.pebs_ept = 1;
 			fallthrough;
-- 
2.38.1


