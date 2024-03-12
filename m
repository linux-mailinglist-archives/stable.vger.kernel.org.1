Return-Path: <stable+bounces-27486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBD9879ADC
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 18:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3B11C22536
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 17:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB4B1386B1;
	Tue, 12 Mar 2024 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DoDk9Z9T"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7651386B5
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 17:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710266131; cv=none; b=BF02dIZbUxgM3hFcQecOeHWGQmwEu++y9rmBZYS6DpxY5Xmhz/12JcTacLF5F2/U0EmF35PLRkjtMjSV06Wydv8BpsEigcd4K8iO1AEYa+ka6ZU8+dUikunUSKaTQjInMH/vIfTe36BRg4iRD99bvohu51RhFwfULwg7cGKtnx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710266131; c=relaxed/simple;
	bh=XJjKSI0f6uv8S1DrFTLFjXSBJLOzRijfecjdEL3/ltA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ItZ1wUOiQqAeQ4J8dJWVkErU4iSYJjhTFqqFjKirzloCAba3AlCNrgL5SWoSNAvELPJqZrkfvgVGal5gA53UH1TacoUfzI+N5eJNYTXwp4xu0EzgVd2vTy3blz35zuoWXLMi5dWnksrj/c9bPsVdEHR0tfpdzjE82akFENJKMBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DoDk9Z9T; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710266130; x=1741802130;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XJjKSI0f6uv8S1DrFTLFjXSBJLOzRijfecjdEL3/ltA=;
  b=DoDk9Z9TP2u6R1Fms44LOGBoGqV+JYgeW+2K4TY0a4uJwIffwWBUeHcu
   PptvRGjBxfOojxfDZ+024nEOy2sFgHjXx7qkpE91/dIgt8ojKAwTxSPLk
   SO2DsfQM+aJM6w2/KHYFNFUYiYeXHudEr+/EmAUWWfGuwRhC6Mj0Cnsya
   SfqwA/yU089Zg8vCeysqGRVvsPI43hBoK5TzX1sR4COLYM/m+DzA8kcDo
   3mKGnNA12ZUGIxvixUZQH4MHh6GaMAVqwWx8OjHc2h/CeCKAQlrW4LP6m
   nBje0dv4BwQs3pZN7zZHr9y+tCk3KSXbkShrzwV34LYYZYEWA7lbyLzoO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="22444338"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="22444338"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 10:55:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16222860"
Received: from arnabkar-mobl1.amr.corp.intel.com (HELO desk) ([10.209.69.57])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 10:55:28 -0700
Date: Tue, 12 Mar 2024 10:55:27 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: [PATCH 0/4] RFDS backport 6.8.y
Message-ID: <20240312-rfds-backport-6-8-y-v1-0-d4ab515a4b4f@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIADKV8GUC/x3MSwqAMAwA0atI1gZs/eJVxIU2qQZBJRVRxLtbX
 L7FzAOBVThAmzygfEqQbY0waQJuHtaJUSgabGaLLDcW1VPAcXDLvumBFTZ4I1U1OfJccGkglru
 yl+u/dv37fhvTcIhlAAAA
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
has a dependency on "Delay VERW" series which is already present in
v6.8.

v6.8 just got released so the backport was very smooth.

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
base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
change-id: 20240312-rfds-backport-6-8-y-d67dcdfe4e51

Best regards,
-- 
Thanks,
Pawan



