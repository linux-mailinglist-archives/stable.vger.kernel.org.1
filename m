Return-Path: <stable+bounces-10571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0C682C16C
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 15:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FCBC1C21D1F
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 14:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A036D1D6;
	Fri, 12 Jan 2024 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CXmZeny+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E2864AAA
	for <stable@vger.kernel.org>; Fri, 12 Jan 2024 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705069012; x=1736605012;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O4gZeW1x0r8K8oyjApCJamQDicc27VJFn/D1cwGWu6o=;
  b=CXmZeny+CEi+GKU1t3qzmG+xM7JvzhfGYmSLu7CeFcyzRPHWHk2m+CqH
   5hY3wqgCrckcpmqUc8GAmSzVfpmwJtzWKXH8z5ihuu+6dG19J81j1sylq
   Hg9vz70+6l5tkxCGjLylJkazotk1EiQj1KFRkrL7cqpx3i4F+UBtTYBNX
   nRq5Yc8RirW0VJUs0SAjb+2ibKAsbmb5KT2RtrXufekwSugfDU0sPL/VJ
   2z1kW0n1BDD0jHR2QXaXj57ES6wMSC/F/SQQa5LZtqOhsLKrNLczNXRmq
   tt7atf4DWdknLmdpe0Hj6JotYPu0LmVsm6WA0dLxR5DvCQpt2SWAvJPSb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="398864553"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="398864553"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 06:16:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="901985698"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="901985698"
Received: from bartoszp-dev.igk.intel.com ([10.91.3.51])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 06:16:49 -0800
From: Bartosz Pawlowski <bartosz.pawlowski@intel.com>
To: stable@vger.kernel.org,
	sashal@kernel.org
Cc: joel.a.gibson@intel.com,
	emil.s.tantilov@intel.com,
	gaurav.s.emmanuel@intel.com,
	sridhar.samudrala@intel.com,
	lihong.yang@intel.com,
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>
Subject: [PATCH 5.10 0/2] PCI: Disable ATS for specific Intel IPU E2000 devices
Date: Fri, 12 Jan 2024 14:15:43 +0000
Message-ID: <20240112141545.395067-1-bartosz.pawlowski@intel.com>
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


