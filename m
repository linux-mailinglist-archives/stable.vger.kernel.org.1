Return-Path: <stable+bounces-230587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJFdF0AVxmkGGQUAu9opvQ
	(envelope-from <stable+bounces-230587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 06:27:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9F733F3E9
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 06:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91E143042BD1
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 05:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344F034EEE7;
	Fri, 27 Mar 2026 05:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="df0jetoL"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8077E377011;
	Fri, 27 Mar 2026 05:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774589227; cv=none; b=sS8p065FVrP1GJR8LIMAq8sfHHPHqZY0x4lS+zjiDV3l88DrPOKAK1ty2wdA5BK5CcdWTtdZYa6sjdueK4NrVrep+rAARCtmWwFy77qMo67Sw36GlN/dS6ovxZBlj9C1MMRPvAZ4o7vK5IBEkCtp7pzWqq8rhiixFGM+I+y1tq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774589227; c=relaxed/simple;
	bh=f9Xf6tdaZ96lQgjsJYC5iF4VfFM4kQZoLgE2yVIIS8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=paZww72EAtNz/ZaaDQB5YoKi5hpdg9A7Cw+Rg6GY4m8yHqfftzeIL0nFZepN/ieHVZzk1ESIu5ab4GhKMHjIS/fE+k4YqlKBMy66Jtns6p8AJqUZScXqKQn2mscH81D2qALK5KlauSbOWzVQR4oFNHemb/QlwCjhLSnmU//LV2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=df0jetoL; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774589226; x=1806125226;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f9Xf6tdaZ96lQgjsJYC5iF4VfFM4kQZoLgE2yVIIS8U=;
  b=df0jetoLeH9t/bXGanVRvN5kI/6mb4n9cPEQC00X8z2FRgQCDQ4rbAum
   X8oQaqtfU932WZiO3Uuy/3aTVA1g7QzMif7UtRld0Kiwm9H5nMUTn2OCp
   x+NJPdwTKtA4hjFw7cTY8Uj4lsl+DHcxCkfHqKjCDw0L502oTzn983kjA
   DPy4xPgvgVPtF9G5YYOp/UyYwd8GUaAmu9SlTH9sP4+54H7N03ulVKikh
   nRV9maMbAYxj8+ExvEZ+BHe+d+4l85e4zm97qPP4H4/314/b1Kocke3hi
   GXgk2p+3pVUEB9xZNhqiPtnYr6T6CMcjnnyF6obBvEvd3zDkv8HQJxWyl
   Q==;
X-CSE-ConnectionGUID: ISPx74mUTxqx9YnOqFpWlA==
X-CSE-MsgGUID: /mvrnDu5TbmLGO4yBd1/bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="101117936"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="101117936"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 22:27:05 -0700
X-CSE-ConnectionGUID: VfLHvpFUR0G+pDPJnFMCbw==
X-CSE-MsgGUID: T+Mm7pNUSneAaYO/4LiPcw==
X-ExtLoop1: 1
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa003.fm.intel.com with ESMTP; 26 Mar 2026 22:27:04 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com
Cc: patches@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	alison.schofield@intel.com,
	Smita.KoralahalliChannabasappa@amd.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	stable@vger.kernel.org
Subject: [PATCH 0/9] dax/hmem: Add tests for the dax_hmem takeover capability
Date: Thu, 26 Mar 2026 22:28:12 -0700
Message-ID: <20260327052821.440749-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230587-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.j.williams@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 8A9F733F3E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Given all the cross subsystem dependencies needed to make this solution
work, it needs to have a unit test to keep it functional.

On the path to writing that, several fixes fell out, but not to Smita's
code, to mine. One use-after-free has been there since the original
automatic region assembly code.

Here is a preview of the core of the test I will submit to the cxl-cli project:

---
modprobe cxl_mock_mem && modprobe cxl_test hmem_test=1

dax=$(find_dax_cxl)
[[ "$dax" == "" ]] && err $LINENO
dax=$(find_dax_hmem)
[[ "$dax" != "" ]] && err $LINENO

unload

modprobe cxl_mock_mem && modprobe cxl_test fail_autoassemble hmem_test=1

dax=$(find_dax_cxl)
[[ "$dax" != "" ]] && err $LINENO
dax=$(find_dax_hmem)
[[ "$dax" == "" ]] && err $LINENO

unload
---

This builds on Smita's series [1] pushed out to for-7.1/dax-hmem in
cxl.git [2].

[1]: http://lore.kernel.org/20260322195343.206900-1-Smita.KoralahalliChannabasappa@amd.com
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-7.1/dax-hmem

Dan Williams (9):
  cxl/region: Fix use-after-free from auto assembly failure
  dax/cxl: Fix HMEM dependencies
  cxl/region: Limit visibility of cxl_region_contains_resource()
  cxl/region: Constify cxl_region_resource_contains()
  dax/hmem: Reduce visibility of dax_cxl coordination symbols
  dax/hmem: Fix singleton confusion between dax_hmem_work and hmem
    devices
  dax/hmem: Parent dax_hmem devices
  tools/testing/cxl: Simulate auto-assembly failure
  tools/testing/cxl: Test dax_hmem takeover of CXL regions

 drivers/dax/Kconfig                |   6 +-
 drivers/cxl/cxl.h                  |  11 ++-
 drivers/dax/bus.h                  |  15 +++-
 include/cxl/cxl.h                  |  15 ----
 tools/testing/cxl/test/mock.h      |   8 ++
 drivers/cxl/core/region.c          |  68 +++++++++++++++--
 drivers/dax/hmem/device.c          |  28 ++++---
 drivers/dax/hmem/hmem.c            | 115 +++++++++++++++--------------
 tools/testing/cxl/test/cxl.c       |  66 +++++++++++++++++
 tools/testing/cxl/test/hmem_test.c |  47 ++++++++++++
 tools/testing/cxl/test/mem.c       |   3 +
 tools/testing/cxl/test/mock.c      |  50 +++++++++++++
 tools/testing/cxl/Kbuild           |   7 ++
 tools/testing/cxl/test/Kbuild      |   1 +
 14 files changed, 344 insertions(+), 96 deletions(-)
 delete mode 100644 include/cxl/cxl.h
 create mode 100644 tools/testing/cxl/test/hmem_test.c


base-commit: 51d2fa02c0e4b3b23c4484f2af9b6d65c35471e8
-- 
2.53.0


