Return-Path: <stable+bounces-27491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B620F879AF2
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 19:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D49B21FB1
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 18:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ABB1386C9;
	Tue, 12 Mar 2024 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDvIBrwm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0793853BE
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710266752; cv=none; b=aTcNMuCRNS6GERb7kocmwqnalr0hTlJx34VAro/sPhmyd3Y50Fgxey472C2BUBAab7gqwiD7+iLdp7Yp4NKUFrdE4mEA0ASnSInbNeDZvKtZ6kTr3SomHq9PJBkoUUbo2hyNpd1cq28tZPM3/Gdsh1uQNbUZZ6a8XBgqrMUlyZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710266752; c=relaxed/simple;
	bh=S8sEp8PiMXhjn4qPG+rsuFB/ddTYsTo8ULNAl/1Tg9g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fTKcEtvQLTHCGvsEOzxA1qS3wiSOCbkh0e2yicapr5mSQjG77G538tgGMsep6g3m/V0vWraCUfQvbYHBx0RL+EMIOwVqEHlV7BcSp1NTZXmYcQkYZHD/gOnnG9q/GefVLEMaVRhFnqxFmeo2eQ44TVWuSrOL1DXyVDNvFhR8XVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDvIBrwm; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710266751; x=1741802751;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=S8sEp8PiMXhjn4qPG+rsuFB/ddTYsTo8ULNAl/1Tg9g=;
  b=ZDvIBrwm8A7mhYpXv/RNxutPlNoYFwao0eeU4cY4UNphreKg9+WF5Ay6
   yAoIXF4hLi7nqp47khk3zWh6aDeWQYoV0siRtzyatMLzpwhXfXBnaBh/A
   jFRMdKTMY8s4hrjZAjAkSY5g2ZOygCUlM4DSds5P2KhSxCBBpPmK6EguF
   ydpbxTPDR/BAbbUebn21nl2c46oKoV0b/p2bhcmNuTjTvpSlw7kYGvNpE
   +Y39k+oPQJ1bqMlerXrQzTLJGzNBsl51xr1BWXcW7jFISoMFEXDkqtvy7
   xTpfjJDAgm+DYuSRlNanMbJv7D8DCm3kfFhhJ9qPhz8jzF9ws8TtzlLyr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="16134807"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16134807"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 11:05:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11715085"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 11:05:50 -0700
Date: Tue, 12 Mar 2024 11:05:49 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 0/4] RFDS backport 6.7.y
Message-ID: <20240312-rfds-backport-6-7-y-v1-0-d9aea75fb0df@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIANeY8GUC/x3MQQqAIBBA0avErBswLYOuEi3MxhoCizGiiO6et
 HyL/x9IJEwJuuIBoZMTbzGjKgvwi4szIU/ZoJWulak0SpgSjs6v+yYHWmzxxjqMZIJvjLUOcrk
 LBb7+az+87wfsVNZhZQAAAA==
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
merged in linux-6.7.y.

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
base-commit: 2e7cdd29fc42c410eab52fffe5710bf656619222
change-id: 20240312-rfds-backport-6-7-y-4fbe3fc5366a

Best regards,
-- 
Thanks,
Pawan



