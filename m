Return-Path: <stable+bounces-77705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D3A986257
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 17:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CE628CDDC
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5978C188CC9;
	Wed, 25 Sep 2024 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cqsPT8qn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9E285C47
	for <stable@vger.kernel.org>; Wed, 25 Sep 2024 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276523; cv=none; b=HWIwvAgNR3+jIGcVbzlGIhHDG5h/a0x5EPIyrXMbklP1gtVJ4QT7D3g0ghD2UHMp9I4nHfs/6rB24vB0pV7hnXkyTI1bV8sQjS0KMTGa+8XeX6QJVHhx0Cvu/LX1e5qzh5h7bUlGyPZNsqvj3gFnLp0KDJLrbjZT1XNNq01mwF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276523; c=relaxed/simple;
	bh=63owhRaM4EO7jTdAAYW9wBirmb4wkAuibvO0yBr0+1g=;
	h=From:To:Cc:Subject:Date:Message-Id; b=X96LYq3pWyBIPV4Boa0Fumtx5rNTqrGkZOr/E9dbcnEUI4vKwHzTzjKE1MQ0vbrnPvW/tzDVQs7TvY6phMXhO/q+EBxhKobkMQ7c7bUykF+BRnEAF3CJVGRsi3ed09OB7aIQfgu4n3c5Wrubll9rsfzCgy9AdIeRmAAWyBwLxJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cqsPT8qn; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727276520; x=1758812520;
  h=from:to:cc:subject:date:message-id;
  bh=63owhRaM4EO7jTdAAYW9wBirmb4wkAuibvO0yBr0+1g=;
  b=cqsPT8qnSgqGfBWUPAqo+SOSjEipPCO+HFo5h9gKbWw2CKQnc0Y7xdvb
   Ay1IGrdT7oO+x3dnbguO1iZ4RP0K/db7LQU8zCWTigpGprEuwUFRd6F1Y
   ZqyvkRfKzfeodldYQQZVgeG6gUILixgCa2qxNmScNAwICDrL4Y3kAsxKs
   f76Vr/b/TZffhCubKw21MXMXIJc5wIZwI51Hdwh57ERrznM/msDzycIgH
   3BOTbpoVMKMLDcIt/UDUimx5ZNUcSV8DEo2ZYt0Umc88M4DUdxvWE1ihC
   O4rSr0FtiaOlgzW7222dvDKTdjk0QvFcp9xvhcVu3rxEH7TICptmOX90k
   Q==;
X-CSE-ConnectionGUID: 9sbRNYeeQ1Kt56QfjBwTAQ==
X-CSE-MsgGUID: egRRiNTxTzG5W1pqxYIExw==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26194380"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="26194380"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 08:01:59 -0700
X-CSE-ConnectionGUID: AAPtfhutQOa6GTeLNMKWJw==
X-CSE-MsgGUID: 4Lo3MY6sSAOjI9baMuL5iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="72256151"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa007.jf.intel.com with ESMTP; 25 Sep 2024 08:01:58 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: stable@vger.kernel.org
Cc: x86@kernel.org,
	Tony Luck <tony.luck@intel.com>,
	"Pawan Kumar Gupta" <pawan.kumar.gupta@intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
	Thomas Lindroth <thomas.lindroth@gmail.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH 6.1.y 0/2] x86: Complete backports for x86_match_cpu()
Date: Wed, 25 Sep 2024 08:07:35 -0700
Message-Id: <20240925150737.16882-1-ricardo.neri-calderon@linux.intel.com>
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
This upstream commit has been backported to 6.1.y.

Callers that use the X86_MATCH_*() family of macros to compose the argument
of x86_match_cpu() function correctly. Callers that use their own custom
mechanisms may not work if they fail to set x86_cpu_id.flags correctly.

There are two remaining callers in 6.1.y that use their own mechanisms:
setup_pcid() and rapl_msr_probe(). The former caused a regression that
Thomas Lindroth reported in [1]. The latter works by luck but it still
populates its x86_cpu_id[] array incorrectly.

I backported two patches that fix these bugs in mainline. Hopefully the
authors and/or maintainers can ack the backports?

I tested these patches in Alder Lake and Meteor Lake systems as the two
involved callers behave differently on these two systems. I wrote the
testing details in each patch separately.

Thanks and BR,
Ricardo
[1]. https://lore.kernel.org/all/eb709d67-2a8d-412f-905d-f3777d897bfa@gmail.com/

Sumeet Pawnikar (1):
  powercap: RAPL: fix invalid initialization for pl4_supported field

Tony Luck (1):
  x86/mm: Switch to new Intel CPU model defines

 arch/x86/mm/init.c                | 16 ++++++----------
 drivers/powercap/intel_rapl_msr.c | 12 ++++++------
 2 files changed, 12 insertions(+), 16 deletions(-)

-- 
2.34.1


