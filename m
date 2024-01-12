Return-Path: <stable+bounces-10579-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1A582C1A8
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 15:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41B59281CA9
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 14:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C206DCFA;
	Fri, 12 Jan 2024 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cy3/BQpa"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C650A6DCF1
	for <stable@vger.kernel.org>; Fri, 12 Jan 2024 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705069502; x=1736605502;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O4gZeW1x0r8K8oyjApCJamQDicc27VJFn/D1cwGWu6o=;
  b=cy3/BQpa8YVtJRMB00dYsTxCrpXy/OLJOR/fNeX7DIYKKTbxJA6VbHl/
   bmUX0nU2JApQM/ZeUrFhtTOCszDqPIcjV/s/DMndsJZpb+leAqmCxJ7QE
   wJl7PHOLqx1qNnzEm0rtZT6z4Oe5MdUonmq5JL0ZVolUSVJoT9DYmE+Xy
   ZLIIiV1evonwwdzja84nnTP8OZR1VWuCIpy1Yj3BIsfA2Urh++8qch+XE
   hth1gToiR2FkV/iqSOe4hj2Xw+bEhrSWI1nf3zdYLVSMUfXq6/Yk3GM81
   HHCWm6lwhnAfavo8D2VKUdTvmQkwUksK/aagEvvy6IR0yXI9ylVVn29F5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="5948485"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="5948485"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 06:24:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="776015245"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="776015245"
Received: from bartoszp-dev.igk.intel.com ([10.91.3.51])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 06:24:54 -0800
From: Bartosz Pawlowski <bartosz.pawlowski@intel.com>
To: stable@vger.kernel.org,
	sashal@kernel.org
Cc: joel.a.gibson@intel.com,
	emil.s.tantilov@intel.com,
	gaurav.s.emmanuel@intel.com,
	sridhar.samudrala@intel.com,
	lihong.yang@intel.com,
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>
Subject: [PATCH 5.4 0/2] PCI: Disable ATS for specific Intel IPU E2000 devices
Date: Fri, 12 Jan 2024 14:24:37 +0000
Message-ID: <20240112142439.395502-1-bartosz.pawlowski@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series addresses the problem with A an B steppings of
Intel IPU E2000 which expects incorrect endianness in data field of ATS
invalidation request TLP by disabling ATS capability for vulnerable
devices.

Bartosz Pawlowski (2):
  PCI: Extract ATS disabling to a helper function
  PCI: Disable ATS for specific Intel IPU E2000 devices

 drivers/pci/quirks.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

-- 
2.43.0


