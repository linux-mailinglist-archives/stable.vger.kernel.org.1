Return-Path: <stable+bounces-78184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C2C989054
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 18:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1630F1C21246
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 16:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1921657CBE;
	Sat, 28 Sep 2024 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JbgkVDlM"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C57E28DBC
	for <stable@vger.kernel.org>; Sat, 28 Sep 2024 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727540337; cv=none; b=NTwE0/g5/4bkDKUmcpHM7+IO78fdNXv8fKzMoUwvo0YzVYjf3tRaLXaNmVH6lF44jLSBHVlAhICwy7oRoTJ/xkYnhZCM2pUOOpJoALK0Cden5xxkA0cseqG0yr6a4t/di1C8QP+Kcj9NZXHufWEd5ND7Ye+U3ozNZdhUPitAJBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727540337; c=relaxed/simple;
	bh=ThuWmAtpwHJRCgbe5Nhtma53Fz98YAuugZdSVPxbpH0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CDRQSrVgNN18plzdTSMUikK8sFug8yjixMIoFe3pYBuKj9953Hejacfl5lmlQmqVwIJyOsvAs0yPee9GSCUUx+pFCophCZk2sPunUKWbKbXpa113F+fYvPXWv6bR2IZuGHCMKzAz6NlAB9Ponpi1KRH9t91JJgQWuH/gI/P86Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JbgkVDlM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727540336; x=1759076336;
  h=from:to:cc:subject:date:message-id;
  bh=ThuWmAtpwHJRCgbe5Nhtma53Fz98YAuugZdSVPxbpH0=;
  b=JbgkVDlMZpaEe1ukMFDAC6UybsmUclXMZF/K1TSf6fNPb/zR2U1R96At
   0VJ+BAk7WPFDgBuCCn7H/SZmdwvv6V3sni7IE/m97E5c6X/X56phd8GfM
   D5TzWRNlsHET/41OWBGoPVld2/CcpCI3NU7olIYye6qyoVRUemy4bbXOp
   /xfFqMzB8lbr2e5uYahkX3DQj7cCbJhZ8HnFr0o2dLBm3qU9MV4u3l/Bk
   eLHQtj9lb8+FoEI65czGY354uWuBqRilh7DyuX1Lh3wZCPJMO8mL4F3V/
   ZAPrJhdkoGBtfKlY7ttKLBSR2DQlzc+5Fc0Ql6SsCe5YlxgIy4AxG1gci
   w==;
X-CSE-ConnectionGUID: 7NlvYITARk2sj+PqJB5lRg==
X-CSE-MsgGUID: 1Xo2SdcCR7WnCOlROve96Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="26834075"
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="26834075"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 09:18:55 -0700
X-CSE-ConnectionGUID: XTOzd1wmTMu9MwlEwR9e+Q==
X-CSE-MsgGUID: CMr60KTCTQG7CYoEH1SL7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="73260280"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa007.jf.intel.com with ESMTP; 28 Sep 2024 09:18:55 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: stable@vger.kernel.org
Cc: x86@kernel.org,
	Tony Luck <tony.luck@intel.com>,
	"Pawan Kumar Gupta" <pawan.kumar.gupta@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
	Thomas Lindroth <thomas.lindroth@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Bastien Nocera <hadess@hadess.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH 5.10.y 0/3] x86: Complete backports for x86_match_cpu()
Date: Sat, 28 Sep 2024 09:24:28 -0700
Message-Id: <20240928162431.22129-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Hi,

Upstream commit 93022482b294 ("x86/cpu: Fix x86_match_cpu() to match just
X86_VENDOR_INTEL") introduced a flags member to struct x86_cpu_id. Bit 0
of x86_cpu.id.flags must be set to 1 for x86_match_cpu() to work correctly.
This upstream commit has been backported to 5.10.y.

Callers that use the X86_MATCH_*() family of macros to compose the argument
of x86_match_cpu() function correctly. Callers that use their own custom
mechanisms may not work if they fail to set x86_cpu_id.flags correctly.

There are three remaining callers in 5.10.y that use their own mechanisms:
a) setup_pcid(), b) rapl_msr_probe(), and c) goodix_add_acpi_gpio_
mappings(). a) caused a regression that Thomas Lindroth reported in [1]. b)
works by luck but it still populates its x86_cpu_id[] array incorrectly. I
am not aware of any reports on c), but inspecting the code reveals that it
will fail to identify INTEL_FAM6_ATOM_SILVERMONT for the reason described
above.

I backported three patches that fix these bugs in mainline. Hopefully the
authors and/or maintainers can ack the backports?

I tested patches 2/3 and 3/3 on Tiger Lake, Alder Lake, and Meteor Lake
systems as the two involved callers behave differently on these systems.
I wrote the testing details in each patch separately. I could not test
patch 1/3 because I do not have access to Bay Trail hardware.

Thanks and BR,
Ricardo
[1]. https://lore.kernel.org/all/eb709d67-2a8d-412f-905d-f3777d897bfa@gmail.com/

Hans de Goede (1):
  Input: goodix - use the new soc_intel_is_byt() helper

Sumeet Pawnikar (1):
  powercap: RAPL: fix invalid initialization for pl4_supported field

Tony Luck (1):
  x86/mm: Switch to new Intel CPU model defines

 arch/x86/mm/init.c                 | 16 ++++++----------
 drivers/input/touchscreen/goodix.c | 18 ++----------------
 drivers/powercap/intel_rapl_msr.c  |  2 +-
 3 files changed, 9 insertions(+), 27 deletions(-)

-- 
2.34.1


