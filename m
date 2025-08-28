Return-Path: <stable+bounces-176583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED3CB39931
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 12:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E95E1C28062
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 10:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989C230BB91;
	Thu, 28 Aug 2025 10:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X5TjdRKG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6693130AD1E;
	Thu, 28 Aug 2025 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756375766; cv=none; b=pwzv3uoSKgApHaFVCZ6f2AzerarPpeQzXD1R0GqC/n+EBz6vQ/dZGVl+44nDg5NlLj9elSqF2gDgidl/tJOiaF9VUjF89Vhh8Sr1g7Z6OrVQLQ37kkRdzZMxfRfsoalpxGCzUHGwad6qzlAbGE3yyYE7HINLIGE18BZeFenw/eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756375766; c=relaxed/simple;
	bh=e3yOIyDahb1llweZF2UcsJlKDVQO7dwhmABbcAIJDTg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KWmdnynXy2lxTPVc5b+taD1PiXsGyVSrY3U9fXmMX4Xiwho2Ynw3xEkxc8EMqPYZPrZrNy8RQZq6p2L2AYzCqO8krq6mGmuwNVKYhxHq+5fwLo+WJobfwKeoGN9FVSr3Z+1WsvkG1ooWLG1rBO4VoCVnCpK1ns9QwLwls5UEJ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X5TjdRKG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756375765; x=1787911765;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e3yOIyDahb1llweZF2UcsJlKDVQO7dwhmABbcAIJDTg=;
  b=X5TjdRKGKP0QUpE/OoGguP51jonKs8VB9pi/DuRVyfS/2WLRLRNTvVF0
   8Kcxo1cnleTQas04Q6zEBmQrNEZFgIptXX/0pssovk7rJs6bDBFJJEW1m
   n3eP8Yk741PRKN1Ax1YxZrS0+36S5lOhbEuHDewUsmWD8kTZfr6r3nzmZ
   0eTcoBADPUXD671MQiQgiCNuo7vOKZEgQPtrwJtznAZJfS8hZh6CVbPez
   2mXQt7XQSwT1IE78DIxcE2+w1jrWaOeznqwztPIvUtmQGiFXitqmfuTYB
   B7CVrLMXR9jeQtTvbQGpDiW0ekHoTf0fnOuPDeFlsv1dTVjqZ4qIGBHxZ
   w==;
X-CSE-ConnectionGUID: PJVqKR6+QwCJQkDYU1KIPQ==
X-CSE-MsgGUID: MwGc5RGJQcSbHveDZFiYbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="61274904"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="61274904"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 03:09:24 -0700
X-CSE-ConnectionGUID: XSCp3FLQRiCXHf9sSmWthA==
X-CSE-MsgGUID: wLti3rxyRZe/vFsR5mB8IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="169972336"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa007.jf.intel.com with ESMTP; 28 Aug 2025 03:09:22 -0700
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-net v1 0/4] ixgbe/ixgbevf: fix PF/VF communication issues
Date: Thu, 28 Aug 2025 11:52:23 +0200
Message-Id: <20250828095227.1857066-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Within two-step API update let's provide 2 new MBX operations:
1) request PF's link state (speed & up/down) - as legacy approach became
   obsolete for new E610 adapter and link state data can't be correctly
   provided - increasing API to 1.6
2) ask PF about supported features - for some time there is quite a mess in
   negotiating API versions caused by too loose approach in adding new
   specific (not supported by all of the drivers capable of linking with
   ixgbevf) feature and corresponding API versions. Now list of supported
   features is provided by MBX operation - increasing API to 1.7

Jedrzej Jagielski (4):
  ixgbevf: fix getting link speed data for E610 devices
  ixgbe: handle IXGBE_VF_GET_PF_LINK_STATE mailbox operation
  ixgbevf: fix mailbox API compatibility by negotiating supported
    features
  ixgbe: handle IXGBE_VF_FEATURES_NEGOTIATE mbox cmd

 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h  |  15 ++
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |  79 ++++++++
 drivers/net/ethernet/intel/ixgbevf/defines.h  |   1 +
 drivers/net/ethernet/intel/ixgbevf/ipsec.c    |  10 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h  |   7 +
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  34 +++-
 drivers/net/ethernet/intel/ixgbevf/mbx.h      |   8 +
 drivers/net/ethernet/intel/ixgbevf/vf.c       | 182 +++++++++++++++---
 drivers/net/ethernet/intel/ixgbevf/vf.h       |   1 +
 9 files changed, 304 insertions(+), 33 deletions(-)

-- 
2.31.1


