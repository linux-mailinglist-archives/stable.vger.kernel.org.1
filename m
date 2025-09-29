Return-Path: <stable+bounces-181957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74328BAA1D6
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 19:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066CA179142
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 17:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD198302170;
	Mon, 29 Sep 2025 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="NArTvE7M"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com [35.158.23.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F76426ACC;
	Mon, 29 Sep 2025 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.158.23.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759166276; cv=none; b=HwhRkmzGeX+05WrQ+1x3aCkjkL5vlMH4p44xfQqbotjTwMYrz754LJdfD4qGMSfCUBDL7l3VTN6CV4aTQj6UvGBgZPJ0eyXGfSOB9tkC3FK/VNVtY33aC6DaCwUVkfbH4LQ7kMBiHLED7Rn82a/Avdt9ZDKLzZbTyqYiM9HnLJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759166276; c=relaxed/simple;
	bh=Py68cKQPDjoL070nresffEsM3rBgwgwbbvf9fVGXDmU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NtTquNcogpkAaFB8rRA2tdRV8Y5XWl6W6ipNFzPHU6rwryjYCpiTJPRqPG1Zq+ey7DwQl3u5SQvzSkib0gJD0IMEVnqeyIx5zROyGaYRSK35fvmm9YcIEaGRXkYdx9MOAyWfgZGHJO2aHfm+RnLjjrWQy6q7kFSY6DqVsc8X0aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=NArTvE7M; arc=none smtp.client-ip=35.158.23.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1759166274; x=1790702274;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3hjTN+s944ExExkW+cNJ78tZTTxafT9UBCcKVhVaKrg=;
  b=NArTvE7MMAiGrktvaI1OLvYlN5cV7zzSPVZBvMMCgltk9G1nknA6OGUP
   7hnWQhxOFjHggGMWfyZB54Az+9YdoorGKgjhkK9u73wgjUCuPdiQtWLre
   FTwLgLxgFMKz/Le/wRslwh04Xt2XOG+2ABHu9kowzDmbDkpZb3Y2sgKSs
   /0rcIw993iQRviAxJapXNafxW3Wb06nLFHEzbeyhDmOlgsLqE0hHduP3/
   ZmGsLbwn7dWPT858Jh/6QJ+TnTGIYAJBCMqYg2wk0Ju+pQYaELvclVWCr
   bJLoFCoCNo5DZ5Z8CQJkYwhCL37OJXh2EPT/KtD4wdkAE34kdIzVgCWXr
   g==;
X-CSE-ConnectionGUID: CimZq+qPS/OieK5pySC42A==
X-CSE-MsgGUID: QoHRSNmUTAKRca9BWoMCfA==
X-IronPort-AV: E=Sophos;i="6.18,302,1751241600"; 
   d="scan'208";a="2842336"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 17:17:44 +0000
Received: from EX19MTAEUC002.ant.amazon.com [54.240.197.228:30665]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.19.222:2525] with esmtp (Farcaster)
 id d6c178d4-55b9-4bbf-988e-c3a53dda959d; Mon, 29 Sep 2025 17:17:44 +0000 (UTC)
X-Farcaster-Flow-ID: d6c178d4-55b9-4bbf-988e-c3a53dda959d
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 29 Sep 2025 17:17:43 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Mon, 29 Sep 2025
 17:17:40 +0000
From: Eliav Farber <farbere@amazon.com>
To: <gregkh@linuxfoundation.org>, <sashal@kernel.org>,
	<mario.limonciello@amd.com>, <lijo.lazar@amd.com>, <David.Laight@ACULAB.COM>,
	<arnd@kernel.org>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<farbere@amazon.com>
Subject: [PATCH v2 00/12 6.6.y] Backport minmax.h updates from v6.17-rc7
Date: Mon, 29 Sep 2025 17:17:21 +0000
Message-ID: <20250929171733.20671-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

This series backports 15 patches to update minmax.h in the 6.6.y branch,
aligning it with v6.17-rc7.

The ultimate goal is to synchronize all longterm branches so that they
include the full set of minmax.h changes.

The key motivation is to bring in commit d03eba99f5bf ("minmax: allow
min()/max()/clamp() if the arguments have the same signedness"), which
is missing in older kernels.

In mainline, this change enables min()/max()/clamp() to accept mixed
argument types, provided both have the same signedness. Without it,
backported patches that use these forms may trigger compiler warnings,
which escalate to build failures when -Werror is enabled.

Changes between v1 and v2:
- v1 included 15 patches:
  https://lore.kernel.org/stable/20250922103241.16213-1-farbere@amazon.com/T/#t
- First 3 were pushed to the stable-tree.
- 4th cauded amd driver's build to fail.
- This change fixes it.
- Modified files:
   drivers/gpu/drm/amd/amdgpu/amdgpu.h
   drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
   drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c

David Laight (7):
  minmax.h: add whitespace around operators and after commas
  minmax.h: update some comments
  minmax.h: reduce the #define expansion of min(), max() and clamp()
  minmax.h: use BUILD_BUG_ON_MSG() for the lo < hi test in clamp()
  minmax.h: move all the clamp() definitions after the min/max() ones
  minmax.h: simplify the variants of clamp()
  minmax.h: remove some #defines that are only expanded once

Linus Torvalds (5):
  minmax: make generic MIN() and MAX() macros available everywhere
  minmax: simplify min()/max()/clamp() implementation
  minmax: don't use max() in situations that want a C constant
    expression
  minmax: improve macro expansion and type checking
  minmax: fix up min3() and max3() too

 arch/um/drivers/mconsole_user.c               |   2 +
 drivers/edac/skx_common.h                     |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   |   2 +
 .../drm/amd/pm/powerplay/hwmgr/ppevvmath.h    |  14 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |   2 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |   3 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |   3 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   2 +-
 drivers/gpu/drm/radeon/evergreen_cs.c         |   2 +
 drivers/hwmon/adt7475.c                       |  24 +-
 drivers/input/touchscreen/cyttsp4_core.c      |   2 +-
 drivers/irqchip/irq-sun6i-r.c                 |   2 +-
 drivers/media/dvb-frontends/stv0367_priv.h    |   3 +
 .../net/can/usb/etas_es58x/es58x_devlink.c    |   2 +-
 drivers/net/fjes/fjes_main.c                  |   4 +-
 drivers/nfc/pn544/i2c.c                       |   2 -
 drivers/platform/x86/sony-laptop.c            |   1 -
 drivers/scsi/isci/init.c                      |   6 +-
 .../pci/hive_isp_css_include/math_support.h   |   5 -
 fs/btrfs/tree-checker.c                       |   2 +-
 include/linux/compiler.h                      |   9 +
 include/linux/minmax.h                        | 220 ++++++++++--------
 kernel/trace/preemptirq_delay_test.c          |   2 -
 lib/btree.c                                   |   1 -
 lib/decompress_unlzma.c                       |   2 +
 lib/vsprintf.c                                |   2 +-
 mm/zsmalloc.c                                 |   2 -
 tools/testing/selftests/mm/mremap_test.c      |   2 +
 tools/testing/selftests/seccomp/seccomp_bpf.c |   2 +
 30 files changed, 192 insertions(+), 136 deletions(-)

-- 
2.47.3


