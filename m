Return-Path: <stable+bounces-144313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EB1AB62B4
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 08:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849264637B8
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 06:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A81A1F8691;
	Wed, 14 May 2025 06:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YjOYleeg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C336A433A8
	for <stable@vger.kernel.org>; Wed, 14 May 2025 06:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747202804; cv=none; b=i6yVG7mRvQLNGAvnP0/Q71WlZHErd2Ypn5MFZdUkCqYiZztxrYx78NFXFOlM/okkn9AGPO0BVivUyh31yO5NNAR2d5cWbUL8qXS/f1zQeGGCWtW8+u0WY2d3Bv5S/Yt32DpaWfeKgY7t4lkI4HnpCw4iuzyBPYoqyr4A6zcaniY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747202804; c=relaxed/simple;
	bh=FSKcWM4AAKWDJYqC3QPs/nhjRI8jd2nlFr4JbAc2VkU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KlqCR7sXT3MXMpILWGdnqSp2Aqibj9XxyClhvxEbGcEtOlg5F/NzXUIiX/UYKvuvGil8VGvQckAXjcdnUInqkQba8KD8TVl9LS58SLU1fBgAKhZc3NY3g6n6cAwJIyoiefcCGdqpFHgDrHFt3HibZOT6fXwCrxo7uBMcBKUQvX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YjOYleeg; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747202802; x=1778738802;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FSKcWM4AAKWDJYqC3QPs/nhjRI8jd2nlFr4JbAc2VkU=;
  b=YjOYleeglklTo4pKVWXoqsCBOnWFXPLf5ZJO1h2zAjEUUlRDCTCEjVPY
   n/FxlrbqnYulGtp8fJPIODMzCrwI+Xpe2ZIne5h5nGYFqYJIt0BOpY7Jh
   CIxAdjWk5CrxKbHUwLae1ThwngG0JO+joR9Dyjbq8rjEM8052s+1hV2Zz
   OAfFam12XJ5SNPe3+1ZiPlhigaX+FnUB2aK8+SeKn5pMS2pqP94sPaqBF
   ZYmGDVdy6nmokjI8l1uiEYCTWe0BicKSyFGAzUgj5yDq61OfWG9LbAYnx
   YjVAHp16Txes4lCFa++qOlQL+qYyhQwijllseYKHRyedLkFecQH6a7Q52
   A==;
X-CSE-ConnectionGUID: xbSfRsEeRNugW5FwOTEMyg==
X-CSE-MsgGUID: LDfVcH3hR1CKd6GqxjwEyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="49198794"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="49198794"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:06:40 -0700
X-CSE-ConnectionGUID: R1LsWCQyQKav9SsDRqFXIA==
X-CSE-MsgGUID: +u2G1aAxTLKLsXeuczrWnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="138922223"
Received: from rshah-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.11])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 23:06:40 -0700
Date: Tue, 13 May 2025 23:06:39 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 5.15 v2 00/14] ITS mitigation
Message-ID: <20250513-its-5-15-v2-0-90690efdc7e0@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAMYvJGgC/x2MwQpAQBBAf0VzNtodTclNLo4ObnIQg7mgXUnJv
 1uO7/V6N3hxKh7y6AYnp3rd1gAURzAs/ToL6hgYyBAbtoR6eGS0jEZMmjGRlZQg5LuTSa9/1UJ
 dNGX1WU4sQ/c8L58Pwf9pAAAA
X-Change-ID: 20250512-its-5-15-0e0385221e32
X-Mailer: b4 0.14.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

v2:
- Added the missing "--from" during patch generation.
- Added missing patch to 6.1 backport.

This is a backport of mitigation for Indirect Target Selection (ITS).

ITS is a bug in some Intel CPUs that affects indirect branches including
RETs in the first half of a cacheline. Mitigation is to relocate the
affected branches to an ITS-safe thunk.

Below additional upstream commits are required to cover some of the special
cases like indirects in asm and returns in static calls:

cfceff8526a4 ("x86/speculation: Simplify and make CALL_NOSPEC consistent")
052040e34c08 ("x86/speculation: Add a conditional CS prefix to CALL_NOSPEC")
c8c81458863a ("x86/speculation: Remove the extra #ifdef around CALL_NOSPEC")
d2408e043e72 ("x86/alternative: Optimize returns patching")
4ba89dd6ddec ("x86/alternatives: Remove faulty optimization")

[1] https://github.com/torvalds/linux/commit/6f5bf947bab06f37ff931c359fd5770c4d9cbf87

---
Borislav Petkov (AMD) (1):
      x86/alternative: Optimize returns patching

Josh Poimboeuf (1):
      x86/alternatives: Remove faulty optimization

Pawan Gupta (10):
      x86/speculation: Simplify and make CALL_NOSPEC consistent
      x86/speculation: Add a conditional CS prefix to CALL_NOSPEC
      x86/speculation: Remove the extra #ifdef around CALL_NOSPEC
      Documentation: x86/bugs/its: Add ITS documentation
      x86/its: Enumerate Indirect Target Selection (ITS) bug
      x86/its: Add support for ITS-safe indirect thunk
      x86/its: Add support for ITS-safe return thunk
      x86/its: Enable Indirect Target Selection mitigation
      x86/its: Add "vmexit" option to skip mitigation on some CPUs
      x86/its: Align RETs in BHB clear sequence to avoid thunking

Peter Zijlstra (2):
      x86,nospec: Simplify {JMP,CALL}_NOSPEC
      x86/its: Use dynamic thunks for indirect branches

 Documentation/ABI/testing/sysfs-devices-system-cpu |   1 +
 Documentation/admin-guide/hw-vuln/index.rst        |   1 +
 .../hw-vuln/indirect-target-selection.rst          | 156 ++++++++++++++
 Documentation/admin-guide/kernel-parameters.txt    |  15 ++
 arch/x86/Kconfig                                   |  11 +
 arch/x86/entry/entry_64.S                          |  20 +-
 arch/x86/include/asm/alternative.h                 |  24 +++
 arch/x86/include/asm/cpufeatures.h                 |   3 +
 arch/x86/include/asm/msr-index.h                   |   8 +
 arch/x86/include/asm/nospec-branch.h               |  57 ++++--
 arch/x86/kernel/alternative.c                      | 226 ++++++++++++++++++++-
 arch/x86/kernel/cpu/bugs.c                         | 139 ++++++++++++-
 arch/x86/kernel/cpu/common.c                       |  63 ++++--
 arch/x86/kernel/ftrace.c                           |   2 +-
 arch/x86/kernel/module.c                           |   7 +
 arch/x86/kernel/static_call.c                      |   2 +-
 arch/x86/kernel/vmlinux.lds.S                      |  10 +
 arch/x86/kvm/x86.c                                 |   4 +-
 arch/x86/lib/retpoline.S                           |  39 ++++
 arch/x86/net/bpf_jit_comp.c                        |   8 +-
 drivers/base/cpu.c                                 |   8 +
 include/linux/cpu.h                                |   2 +
 include/linux/module.h                             |   5 +
 23 files changed, 768 insertions(+), 43 deletions(-)
---
change-id: 20250512-its-5-15-0e0385221e32


