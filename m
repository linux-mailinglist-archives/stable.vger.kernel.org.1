Return-Path: <stable+bounces-27497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4E0879B0A
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 19:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5971F22069
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 18:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15811386D1;
	Tue, 12 Mar 2024 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ng0k6iSY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0969153BE
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267207; cv=none; b=X5GZWLBmy1W6br4f0I5bi1xfVJz00s9+sOf/I0aT+bEEG0wIKUqj5QV/lvhkx4886arNaXRvUZ7dJi40Ie0nW2Lj7n71BrrqSZ1d9ZqPTDUUENs77vnjaoUW9iE7AyrhO6/hcffIOqgnT/06hp7m5vUIRLjVpTZYatHnipPiNFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267207; c=relaxed/simple;
	bh=hSrEy20qedgKsQA8cv6twFl5A5bMWHmJwJPoJehc8DI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uQtfmTofLsQX+JQU4iUjTR9NfjTSyfC1WM0cfO1lCeCXmkDN/Sn7dPAGpTJJSeV7AEF88/iJPO5Lf14P8uZdFisfgieEsLcLnRjrSJ2hF7anqWD2KHxAiBAt4gbCKJotbQxl+8DJO15Eguthtf/Lx1UhZjOI0kwbuFHC0NjXNy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ng0k6iSY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710267207; x=1741803207;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hSrEy20qedgKsQA8cv6twFl5A5bMWHmJwJPoJehc8DI=;
  b=ng0k6iSYBKrV+aOXZYTJRDKLJnct4X7GREmJjIGQyq5IJ3QvLIhV63FH
   menwYI6owEyJC7v5OjEMGOyyRR0GEWsbENydLA3DbN6Ngk9Hn3QoYmVYt
   ONaQmeozv9pVEc7tn79zou2UB9WraMGLtWQYqvsEHnDV5Zl0NmLVCyE6F
   ZjPoCioqYSJtCf93C8KjJud+SwE9zv4KCuovEvTcOfQLJz9hlb/2KkJjA
   8W6rSvZ7M19LsZxpvt/93jmLunkoL6+JkVU4GnSve15FmLGfINSYGJFfu
   kpr6DOYdN019doLlSS0YjA21MBewGfM4j+mRO4MVv+VZyKbb5RCZvqIdA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="15550029"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="15550029"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 11:13:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11525431"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 11:13:24 -0700
Date: Tue, 12 Mar 2024 11:13:23 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 0/4] RFDS backport 6.6.y
Message-ID: <20240312-rfds-backport-6-6-y-v1-0-8a47699f1e6c@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAO+a8GUC/x2MMQqAMAwAv1IyG7BRO/gVcWg1ahC0pCKK+HeL3
 HTD3QOJVThBax5QPiXJvmWxhYFh8dvMKGN2oJLqsrKEOo0Jgx/WuOuBLnMj25oaZ11oyEMuo/I
 k13/t+vf9APH1LsJlAAAA
X-Mailer: b4 0.12.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is a backport of recently upstreamed mitigation of a CPU
vulnerability Register File Data Sampling (RFDS) (CVE-2023-28746). It
has a dependency on "Delay VERW" series which is already backported and
merged in linux-6.6.y.

There were no hiccups in backporting this.

Cc: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
Pawan Gupta (4):
      x86/mmio: Disable KVM mitigation when X86_FEATURE_CLEAR_CPU_BUF is set
      Documentation/hw-vuln: Add documentation for RFDS
      x86/rfds: Mitigate Register File Data Sampling (RFDS)
      KVM/x86: Export RFDS_NO and RFDS_CLEAR to guests

 Documentation/ABI/testing/sysfs-devices-system-cpu |   1 +
 Documentation/admin-guide/hw-vuln/index.rst        |   1 +
 .../admin-guide/hw-vuln/reg-file-data-sampling.rst | 104 +++++++++++++++++++++
 Documentation/admin-guide/kernel-parameters.txt    |  21 +++++
 arch/x86/Kconfig                                   |  11 +++
 arch/x86/include/asm/cpufeatures.h                 |   1 +
 arch/x86/include/asm/msr-index.h                   |   8 ++
 arch/x86/kernel/cpu/bugs.c                         |  92 +++++++++++++++++-
 arch/x86/kernel/cpu/common.c                       |  38 +++++++-
 arch/x86/kvm/x86.c                                 |   5 +-
 drivers/base/cpu.c                                 |   3 +
 include/linux/cpu.h                                |   2 +
 12 files changed, 278 insertions(+), 9 deletions(-)
---
base-commit: 62e5ae5007ef14cf9b12da6520d50fe90079d8d4
change-id: 20240312-rfds-backport-6-6-y-e1425616b52a

Best regards,
-- 
Thanks,
Pawan



