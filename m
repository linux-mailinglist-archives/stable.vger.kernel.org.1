Return-Path: <stable+bounces-77734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8BB986922
	for <lists+stable@lfdr.de>; Thu, 26 Sep 2024 00:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BF52833EB
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 22:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C81153BC1;
	Wed, 25 Sep 2024 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i9A+zoGL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA16148838;
	Wed, 25 Sep 2024 22:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727303136; cv=none; b=gVu4ZkJXHku3RPxguwVfTGCmWj240ocEDeCJm78nDOFF8CsMdgZHAenwzQuAZ4IdjlsjlomI6m+G8xsg183r1fAwuw6v8VPm9PygpZs+h1K7p4UJFxjX0wrhbqvk0JCg5+7bRqoy1mezo8wHZN/GY0f4ZDrlJmhNPjqTmYLux0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727303136; c=relaxed/simple;
	bh=s+d5tzTq2/uNJTbtFPGmn8xGq3ZqqzokQz0Xy/mYJAI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UA3aw6tOrug10P9yTR66PtPGHFU9b7gnL5TmMxaRAT8eYQLm//wMmxwSrp9nEuvLxv4eCGe8jQhNZNpszFoG+dkBJ70maDR7Hrike+4Wehd0wVbTYYrZzXtqKOAV8iI4jKswL5/W5zFrnQ7HHc86+0WtXMRJnYNLh6/DtjbBMCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i9A+zoGL; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727303134; x=1758839134;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=s+d5tzTq2/uNJTbtFPGmn8xGq3ZqqzokQz0Xy/mYJAI=;
  b=i9A+zoGLu2BZs5x3FXCsxrY1T3/h+3eD3Ng0u5yI+kpMBTotVVsP3mNd
   eu6PkX8HQqQqauzOeYp1/pS/D03QWIkvewx7TvfVff+/5QWhQ07vvsXNx
   pxw7jEv8L716V+OOfYWz+ZrCkPaIlZc0wmTunDW/MhmWtvtFBNm+FUXGN
   ujEi+M99ucIaH+FCcrtZGmDk9NWURTTnJSJuQN2X8lHjw9tc4280mMBi4
   69SqBi1xZnFu0NK7zOtdZ3jSFSfx6QyXE7l07y6XFk3ft5CZEiP2Xoa/P
   ME+KdZRB4RVn0RneMPbL8FwCH2LorA92KtPt1c8v2GruvWoN6YG9wy0fP
   w==;
X-CSE-ConnectionGUID: HhQhVkS9Qda4xG3A7qnFMw==
X-CSE-MsgGUID: cdlUSrhrSqKAJNfz0M4PvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26531598"
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="26531598"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 15:25:33 -0700
X-CSE-ConnectionGUID: hZF2F4axQCenpcFtUhjuCA==
X-CSE-MsgGUID: lPfvyIHQQfKb+p7haIhZYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,258,1719903600"; 
   d="scan'208";a="102750695"
Received: from fecarpio-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.229])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 15:25:33 -0700
Date: Wed, 25 Sep 2024 15:25:32 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	Jari Ruusu <jariruusu@protonmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	antonio.gomez.iglesias@linux.intel.com,
	daniel.sneddon@linux.intel.com, stable@vger.kernel.org
Subject: [PATCH v7 0/3] Fix dosemu vm86() fault
Message-ID: <20240925-fix-dosemu-vm86-v7-0-1de0daca2d42@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIABSN9GYC/3XOz27CMAwG8FdBOS8ozh873WnvMe2QJs6IBC1qo
 WJCffcFLkVqOX6W/fN3FyMPhUfxubuLgacylr6rgT52Ih5C98uypJqFVtoqq1HmcpOpH/l0ldP
 Jo0wJAIICMsSiXp0HritP8fun5kMZL/3w93wwwWP63ppAgvQ+eo3BZEP+61i6621fugsf97E/i
 Yc46UVBTWtFVyU5R03GxjPRtmIWhRSsFVOVFhpsnNGRXNhW7IsCaq3YqoSAFi1DYszbintVNrq
 4qrCnFBMZ9OFNF1yURrm1glJJCjl7dia27UaXeZ7/AXDXBYwSAgAA
X-Mailer: b4 0.14.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Changes in v7:
- Using %ss for verw fails kselftest ldt_gdt.c in 32-bit mode, use safer %cs instead (Dave).

v6: https://lore.kernel.org/r/20240905-fix-dosemu-vm86-v6-0-7aff8e53cbbf@linux.intel.com
- Use %ss in 64-bit mode as well for all VERW calls. This avoids any having
  a separate macro for 32-bit (Dave).
- Split 32-bit mode fixes into separate patches.

v5: https://lore.kernel.org/r/20240711-fix-dosemu-vm86-v5-1-e87dcd7368aa@linux.intel.com
- Simplify the use of ALTERNATIVE construct (Uros/Jiri/Peter).

v4: https://lore.kernel.org/r/20240710-fix-dosemu-vm86-v4-1-aa6464e1de6f@linux.intel.com
- Further simplify the patch by using %ss for all VERW calls in 32-bit mode (Brian).
- In NMI exit path move VERW after RESTORE_ALL_NMI that touches GPRs (Dave).

v3: https://lore.kernel.org/r/20240701-fix-dosemu-vm86-v3-1-b1969532c75a@linux.intel.com
- Simplify CLEAR_CPU_BUFFERS_SAFE by using %ss instead of %ds (Brian).
- Do verw before popf in SYSEXIT path (Jari).

v2: https://lore.kernel.org/r/20240627-fix-dosemu-vm86-v2-1-d5579f698e77@linux.intel.com
- Safe guard against any other system calls like vm86() that might change %ds (Dave).

v1: https://lore.kernel.org/r/20240426-fix-dosemu-vm86-v1-1-88c826a3f378@linux.intel.com

Hi,

This series fixes a #GP in 32-bit kernels when executing vm86() system call
in dosemu software. In 32-bit mode, their are cases when user can set an
arbitrary %ds that can cause a #GP when executing VERW instruction. The
fix is to use %ss for referencing the VERW operand.

Patch 1-2: Fixes the VERW callsites in 32-bit entry path.
Patch   3: Uses %ss for VERW in 32-bit and 64-bit mode.

The fix is tested with below kselftest on 32-bit kernel:

	./tools/testing/selftests/x86/entry_from_vm86.c

64-bit kernel was boot tested. On a Rocket Lake, measuring the CPU cycles
for VERW with and without the %ss shows no significant difference. This
indicates that the scrubbing behavior of VERW is intact.

Thanks,
Pawan

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
Pawan Gupta (3):
      x86/entry_32: Do not clobber user EFLAGS.ZF
      x86/entry_32: Clear CPU buffers after register restore in NMI return
      x86/bugs: Use code segment selector for VERW operand

 arch/x86/entry/entry_32.S            | 6 ++++--
 arch/x86/include/asm/nospec-branch.h | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)
---
base-commit: 431c1646e1f86b949fa3685efc50b660a364c2b6
change-id: 20240426-fix-dosemu-vm86-dd111a01737e

Best regards,
-- 
Thanks,
Pawan



