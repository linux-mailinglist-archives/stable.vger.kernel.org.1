Return-Path: <stable+bounces-10574-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1167382C17A
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 15:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD801C21D56
	for <lists+stable@lfdr.de>; Fri, 12 Jan 2024 14:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00A76D1DF;
	Fri, 12 Jan 2024 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DqjwsFQd"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9786DCE7
	for <stable@vger.kernel.org>; Fri, 12 Jan 2024 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705069290; x=1736605290;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O4gZeW1x0r8K8oyjApCJamQDicc27VJFn/D1cwGWu6o=;
  b=DqjwsFQdJ0zZkXxlvdxws4EBhxn0FKA4vydv3OIizuezf08HaPkAe9wG
   di+C4G834zs/BzVb55qCVRKq1HErGVU+H7e82v2SKKB7KQ0gIIRTuUrE/
   mpoUVZflDlG1oZNpkGKczhZoxCR9Bjv16MYN0LFmlppyOKeYEbj4zoAWD
   q8lTRuPUNnMDFDYM9LZSpQtc6sLcX6Hva7+3iJYc441PfW+19mi3+W0lE
   e1aa09hxQtvcNH229NXi/mMy1cLaFHLyGDfxcifzhCMg4o3JArx1gjalL
   sQVM0aWBtZ12m5X6MUl5+o7c2Q07PWCtVL86wZkyncFLB06T8zgN7kPoh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="430357797"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="430357797"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 06:21:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="1114235346"
X-IronPort-AV: E=Sophos;i="6.04,189,1695711600"; 
   d="scan'208";a="1114235346"
Received: from bartoszp-dev.igk.intel.com ([10.91.3.51])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 06:21:17 -0800
From: Bartosz Pawlowski <bartosz.pawlowski@intel.com>
To: stable@vger.kernel.org,
	sashal@kernel.org
Cc: joel.a.gibson@intel.com,
	emil.s.tantilov@intel.com,
	gaurav.s.emmanuel@intel.com,
	sridhar.samudrala@intel.com,
	lihong.yang@intel.com,
	Bartosz Pawlowski <bartosz.pawlowski@intel.com>
Subject: [PATCH 4.19 0/2] PCI: Disable ATS for specific Intel IPU E2000 devices
Date: Fri, 12 Jan 2024 14:20:54 +0000
Message-ID: <20240112142056.395197-1-bartosz.pawlowski@intel.com>
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


