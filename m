Return-Path: <stable+bounces-144077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A36AB49C2
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 04:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E04819E801A
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 02:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CF01C2437;
	Tue, 13 May 2025 02:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PdRkG38c"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BF513AD1C
	for <stable@vger.kernel.org>; Tue, 13 May 2025 02:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747105061; cv=none; b=LKYgVuNSaJarxZ33gZCiOpVglMlqGY8UJMHDUWdxLar+R16NXQnGx3kJEX3dVa8drSa3wmoMuB9U4eofAwPMqwyn05U24u0oI/GcSRL9h1ttiSmCs6Yu9iAYzNnU2BuA4nshfY1BqMu8WkKbH3Pzvc2q6v10rmIPxJRTaOG9ZNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747105061; c=relaxed/simple;
	bh=QgCLyYq1dxiLiS2OJQoJovA523jFPw/1//tHnB2GxRM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vp3Rf5QVZ2Bc67MJ5NsydCHa6UwTlr7657u7gCNsB8jf0DjlGFO2YO+ykrNPObVXBlxG/irIMSvTCHc5TdyVDHesYltUXE/5OrolSeLbCnQQzr6p6RJcdC128mPHiZ2enX5KaIqOJC9tmezQhNSuNUEn75Gbh9syOdh5SzDROlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PdRkG38c; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747105060; x=1778641060;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QgCLyYq1dxiLiS2OJQoJovA523jFPw/1//tHnB2GxRM=;
  b=PdRkG38c+lTI/gW8DHp8nPHn5chi03lpO40zF/JHaukkvHZt/489vdjn
   nsTbJ5k/YihGTAdzmeDu4UFOhJxB2EBleP4EYrg0WYBbl/Y2cAs8Qops4
   YJeHEvzs3F+qivjQCdklkXnFxtG6Y42h1198+xQ/XCdjeGpLCvbPG+eEq
   yWh35kqImkcdEXuYU+NrkLg8y1l3MHM+UfBGoTBbOcz6rQzq9QinZvfQw
   XJ41UvoP4lp01zJe8Wq8OcFq7tSK0Znt82CT572ugXjzJvRDw5nFcFKGd
   0FJKRQEkFh4IOmuoKZzbonT4CRt9S7E6tYLg7ENagxe+1x0LyFyPe1jcw
   w==;
X-CSE-ConnectionGUID: fasTR02MSRec+TF4VO8ZdA==
X-CSE-MsgGUID: 0ABME0ttS+SqDqBf4eMc8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59567305"
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="59567305"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 19:57:39 -0700
X-CSE-ConnectionGUID: /eWO2i8YQRWVBOD2482+kQ==
X-CSE-MsgGUID: hGbAINDcT3mkdn+xWBexyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,284,1739865600"; 
   d="scan'208";a="138082340"
Received: from lvelazqu-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.9])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 19:57:39 -0700
Date: Mon, 12 May 2025 19:57:38 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 5.15 00/14] ITS mitigation
Message-ID: <20250512-its-5-15-v1-0-6a536223434d@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAP+yImgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDU0Mj3cySYl1TXUNTXYNUA2MLUyMjw1RjIyWg8oKi1LTMCrBR0UoBjiH
 OHiBRUz1DU6XY2loACkqDSWkAAAA=
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

This is a 5.15 backport of Indirect Target Selection (ITS) mitigation.

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
base-commit: 3b8db0e4f2631c030ab86f78d199ec0b198578f3
change-id: 20250512-its-5-15-0e0385221e32

Best regards,
-- 
Pawan



