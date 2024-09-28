Return-Path: <stable+bounces-78179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AB1989031
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 17:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1361C20C45
	for <lists+stable@lfdr.de>; Sat, 28 Sep 2024 15:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB7154673;
	Sat, 28 Sep 2024 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJbnBfhk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C552A1EB39
	for <stable@vger.kernel.org>; Sat, 28 Sep 2024 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727539178; cv=none; b=LJxYi2NfvukZLVJcRqZIBLBTYdN5/QbbNTrKUlmZYjAEibeck/OrShnDn+Lvy/JbXAsFv1M3DWrFddWjEIQ4iKPY5h9A9uqLHhurflTRUKJCcQsWg0JZQ6vkJVchBmUsiQldASa0kwx+zd9/qNT3LtLpEZi179W6SuHUsEKBh9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727539178; c=relaxed/simple;
	bh=sG1JmlTi3eoqBxSHQ67FnVV0AkhYxArgBpojKD5zX0A=;
	h=From:To:Cc:Subject:Date:Message-Id; b=XQ5rH/KNwix364nQf7U503JEBus0/U2afeNtSA0TpneYNhLhBZpxs8qGmrp1Itiww3khTJFDsXHUjgvDqATFU2mhASV4N8aZm9mkMG6UjgTxROV+9t39ZV18ynNMyMfxqQYXGUd9ZT+OTyWfzeShG/qYa/Nh9twhagU1dnEqN6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJbnBfhk; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727539177; x=1759075177;
  h=from:to:cc:subject:date:message-id;
  bh=sG1JmlTi3eoqBxSHQ67FnVV0AkhYxArgBpojKD5zX0A=;
  b=aJbnBfhkQ4KteC/BbUkGySJRowhqo3TCbreKRJ50qWgWsFx7IbRjwT28
   3sMmCPxPuiyQwXGuLsAf84YHB19++hSpwGRqzZ+W6gqpfoaJE60QqqvmQ
   nNEDyZvcpMxV/cfx5iwUsTs05Fe3vHhE+9iHG9JkCtsUky4Oq8ccXuCmE
   xGTA2Qxe4A2L2dBOFUwbbiSolj+uWMg/UjnC70gkBgkniNYPy5tGJhTDU
   OfIPoaVzX10+zhljZ3QA1uPoJP7qtVos3xiZMezZiMslLHrfu4vXTVmOH
   foaaZQAREf8Wk2tRtyjuLHrrN5ia+pEcaxXC2AHFSUDPjQLMWeNlacMPm
   g==;
X-CSE-ConnectionGUID: c6+ohI2dS2C4kX58F+LheQ==
X-CSE-MsgGUID: +RXizH+oT96slj2hbh3zWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="26470455"
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="26470455"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2024 08:59:36 -0700
X-CSE-ConnectionGUID: fpW4xRkmQY2S0CKqJGyVUw==
X-CSE-MsgGUID: NTpSATI+T72eJtVmi/t0WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,160,1725346800"; 
   d="scan'208";a="72994555"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa008.fm.intel.com with ESMTP; 28 Sep 2024 08:59:35 -0700
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
Subject: [PATCH 5.15.y 0/3] x86: Complete backports for x86_match_cpu()
Date: Sat, 28 Sep 2024 09:05:09 -0700
Message-Id: <20240928160512.21889-1-ricardo.neri-calderon@linux.intel.com>
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
This upstream commit has been backported to 5.15.y.

Callers that use the X86_MATCH_*() family of macros to compose the argument
of x86_match_cpu() function correctly. Callers that use their own custom
mechanisms may not work if they fail to set x86_cpu_id.flags correctly.

There are three remaining callers in 5.15.y that use their own mechanisms:
a) setup_pcid(), b) rapl_msr_probe(), and c) goodix_add_acpi_gpio_
mappings(). a) caused a regression that Thomas Lindroth reported in [1]. b)
works by luck but it still populates its x86_cpu_id[] array incorrectly. I
am not aware of any reports on c), but inspecting the code reveals that it
will fail to identify INTEL_FAM6_ATOM_SILVERMONT for the reason described
above.

I backported three patches that fix these bugs in mainline. Hopefully the
authors and/or maintainers can ack the backports?

I tested patches 2/3 and 3/3 on Alder Lake, and Meteor Lake systems as the
two involved callers behave differently on these two systems. I wrote the
testing details in each patch separately. I could not test patch 1/3
because I do not have access to Bay Trail hardware.

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
 drivers/powercap/intel_rapl_msr.c  |  6 +++---
 3 files changed, 11 insertions(+), 29 deletions(-)

-- 
2.34.1


