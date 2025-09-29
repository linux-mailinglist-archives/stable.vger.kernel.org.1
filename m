Return-Path: <stable+bounces-181975-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1262DBAA50F
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 20:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10961C11AB
	for <lists+stable@lfdr.de>; Mon, 29 Sep 2025 18:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799D3238D3A;
	Mon, 29 Sep 2025 18:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="VFz4L0qu"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.72.182.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213CE23BF9F;
	Mon, 29 Sep 2025 18:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.72.182.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759170861; cv=none; b=tv9ULfNmot9DBDE1UZe4HlREv46nbSbH1Lo70NZOEZltUDhzhO5+NZmH9YervcFHVg8id77j/sQa95wFAxipaDFkf50IoHyUH8B8O9avdSfRZCCPlO/1yoqpg4Nh4Q0UVHj51lI/5qAPCdrRLpNbSXieW0X6t7XgbyEunw9ZzEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759170861; c=relaxed/simple;
	bh=GTZA3eLaraPt8XzhlsWnoxQ+AR+ONdijpuPZC+bwb7g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rQUWb26BEp4+T+dzqrTTn755zjg8Wv+KBkX9hc31TgR7erc1baSf6EwR2K6LGiT8G+8JePVLDcF2OZLsPXhl/i+PgDbxwQ3N/V3viN37jLAZNWjcbUarEvZmEFugRSQyj6Fsrs8JpyNYj/IPL06nxCdq7dRRqKej/UD4WOPUcKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=VFz4L0qu; arc=none smtp.client-ip=3.72.182.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1759170859; x=1790706859;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tLVsp7hj1xDOEIsTa7Fjxnad2bi5Mxv2/VLxPUTW038=;
  b=VFz4L0quueEt+4P3wOWTbK+bNkxyoZIUMmziWy1sHhip0IE7KZdGlLcs
   lwImvdoesS9SnkCDZTDhbBNMzSRZQt9AmJeJsdEnwkk4vQd/V0vfV6S9e
   hNWyc4XJsma/tSuZVU7natsO9WyIoOzfnLdst6Rwgij6LLaAMrFKzif1O
   8mlCy8mlyo2uORURyVWEOAsbnEbDu3aoxGp2wL9ebi/LSehg739QwRFAE
   G8YwIPC4AWKrAiv5x/GW0tQ3kWE3o2RZPNN38nsY3Zb2cnJv8fKB4AdM4
   QvkWfnEbCNVNEpyvE4pmtR7AH3d1UHzuqj+FcROHXbg+8HqNOfROJxYmf
   A==;
X-CSE-ConnectionGUID: oTFWYrITQmyzl0h3ReK9QQ==
X-CSE-MsgGUID: Gzj9fxMXT6299gl9p5+phg==
X-IronPort-AV: E=Sophos;i="6.18,302,1751241600"; 
   d="scan'208";a="2841821"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-003.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 18:34:09 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:28711]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.44.161:2525] with esmtp (Farcaster)
 id c42537fa-5bd2-4ddc-a214-f0a25696bce4; Mon, 29 Sep 2025 18:34:08 +0000 (UTC)
X-Farcaster-Flow-ID: c42537fa-5bd2-4ddc-a214-f0a25696bce4
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Mon, 29 Sep 2025 18:34:07 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Mon, 29 Sep 2025
 18:34:04 +0000
From: Eliav Farber <farbere@amazon.com>
To: <gregkh@linuxfoundation.org>, <sashal@kernel.org>,
	<mario.limonciello@amd.com>, <lijo.lazar@amd.com>, <David.Laight@ACULAB.COM>,
	<arnd@kernel.org>, <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<farbere@amazon.com>
Subject: [PATCH v2 00/13 6.1.y] Backport minmax.h updates from v6.17-rc7
Date: Mon, 29 Sep 2025 18:33:45 +0000
Message-ID: <20250929183358.18982-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

This series backports 13 patches to update minmax.h in the 6.1.y branch,
aligning it with v6.17-rc7.

The ultimate goal is to synchronize all longterm branches so that they
include the full set of minmax.h changes (6.12.y was already aligned and
6.6.y is in progress).

The key motivation is to bring in commit d03eba99f5bf ("minmax: allow
min()/max()/clamp() if the arguments have the same signedness"), which
is missing in older kernels.

In mainline, this change enables min()/max()/clamp() to accept mixed
argument types, provided both have the same signedness. Without it,
backported patches that use these forms may trigger compiler warnings,
which escalate to build failures when -Werror is enabled.

Changes between v1 and v2:
- v1 included 19 patches:
  https://lore.kernel.org/stable/20250924202320.32333-1-farbere@amazon.com/
- First 6 were pushed to the stable-tree.
- 7th cauded amd driver's build to fail.
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

Linus Torvalds (6):
  minmax: make generic MIN() and MAX() macros available everywhere
  minmax: add a few more MIN_T/MAX_T users
  minmax: simplify min()/max()/clamp() implementation
  minmax: don't use max() in situations that want a C constant
    expression
  minmax: improve macro expansion and type checking
  minmax: fix up min3() and max3() too

 arch/um/drivers/mconsole_user.c               |   2 +
 arch/x86/mm/pgtable.c                         |   2 +-
 drivers/edac/sb_edac.c                        |   4 +-
 drivers/edac/skx_common.h                     |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   |   2 +
 .../drm/amd/pm/powerplay/hwmgr/ppevvmath.h    |  14 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |   2 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |   3 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |   3 +
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |   2 +-
 drivers/gpu/drm/drm_color_mgmt.c              |   2 +-
 drivers/gpu/drm/radeon/evergreen_cs.c         |   2 +
 drivers/hwmon/adt7475.c                       |  24 +-
 drivers/input/touchscreen/cyttsp4_core.c      |   2 +-
 drivers/irqchip/irq-sun6i-r.c                 |   2 +-
 drivers/md/dm-integrity.c                     |   2 +-
 drivers/media/dvb-frontends/stv0367_priv.h    |   3 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   2 +-
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
 mm/zsmalloc.c                                 |   1 -
 net/ipv4/proc.c                               |   2 +-
 net/ipv6/proc.c                               |   2 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c |   2 +
 tools/testing/selftests/vm/mremap_test.c      |   2 +
 36 files changed, 199 insertions(+), 142 deletions(-)

-- 
2.47.3


