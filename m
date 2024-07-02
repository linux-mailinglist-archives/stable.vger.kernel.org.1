Return-Path: <stable+bounces-56306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E6391EDA9
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 06:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BA751F225E8
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 04:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19DA3B1AB;
	Tue,  2 Jul 2024 04:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JoTatE/O"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14842E62B;
	Tue,  2 Jul 2024 04:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719893509; cv=none; b=BHZxgasQAb34VewAigdIYJjmHTfbCOTeThrCt7kWIUnW8JOPItLAhP0IjT7IlByWihARBJqK1DzW1tklRGHyTELDhLe5+Ey73X8ofOgUIMWfB0A+CIlRgGqNNi00SF07J0Q2hgb5k2Fvptd94SsPUPX9rruxoMAfJ6HNwCmIJXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719893509; c=relaxed/simple;
	bh=mc4Zha+28ecEgqhpnzlYk/P3mGB1eaGefj2BgbUSpPo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oKHeA8WguKGwLt00VIGwYeSyM0zOR/wI5p+du5OB9mMlzrfVAn+5SG9p+wGPdpwy3ssZ8KHtQgYvliHhsB18A8KP6UpngE5L6JPi+xJtPwL8BGd52IPkQ/L+SNwoLv3xI4gflI0Ty1e6xKBM3klJPyj3R9wTQdOdjuEz4Z/Ggq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JoTatE/O; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719893508; x=1751429508;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mc4Zha+28ecEgqhpnzlYk/P3mGB1eaGefj2BgbUSpPo=;
  b=JoTatE/O6gfGEJXSMrEt6a+GwmFptWzeaL1FL7+4FZJcNpe+JjMou8qT
   pCbLP+0nGIueX8vWzXn9hdI9sgsncoLMjA0/gtp5NQ/edg7/FW2Y9BsTL
   8e1sDN3Nlm0AU74Dsa1AyeV68jZ11iltUHng4DJMzLwOl0YrWxw9Iw+gE
   FhBbsA/X/nsnBCjWOE2HBCrH2liqC0PVpRhKm6sopwPDYbugWme0Yy7tl
   immfZMBqkhTvQ7mOovRIPOSCdai3Jbffq6nMMuVRSzYHD4aTRs0ILGdvA
   HkSHqU43SYLapV3xgBwKNcOhLW941yZoSjl1HFrxtnlRelAf2+tECLuTk
   Q==;
X-CSE-ConnectionGUID: TnjWIhqVSSO8cX7upgybCw==
X-CSE-MsgGUID: ujGJbTfKTNmw1mNOZ8cfag==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="27669419"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="27669419"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 21:11:47 -0700
X-CSE-ConnectionGUID: qywdC6m6RkKYtYu1bUTvkg==
X-CSE-MsgGUID: 7B6Wink2Sd+W4YcsEk8E0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="76927270"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 21:11:46 -0700
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
	by linux.intel.com (Postfix) with ESMTP id DF0BF201A797;
	Mon,  1 Jul 2024 21:11:43 -0700 (PDT)
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Subject: [PATCH iwl-net v1 0/4] igc bug fixes related to qbv_count usage
Date: Tue,  2 Jul 2024 00:09:22 -0400
Message-Id: <20240702040926.3327530-1-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These igc bug fixes are sent as a patch series because:

1. The patch "igc: Remove unused qbv_count" has dependency on:
   "igc: Fix qbv_config_change_errors logics" 
   "igc: Fix reset adapter logics when tx mode change"

   These two patches remove the reliance on using the qbv_count field.
 
2. The patch "igc: Fix qbv tx latency by setting gtxoffset" reuse the
   function igc_tsn_will_tx_mode_change() created in the patch: 
   "igc: Fix reset adapter logics when tx mode change"

Faizal Rahim (4):
  igc: Fix qbv_config_change_errors logics
  igc: Fix reset adapter logics when tx mode change
  igc: Remove unused qbv_count
  igc: Fix qbv tx latency by setting gtxoffset

 drivers/net/ethernet/intel/igc/igc.h      |  1 -
 drivers/net/ethernet/intel/igc/igc_main.c |  9 +++--
 drivers/net/ethernet/intel/igc/igc_tsn.c  | 49 ++++++++++++++++-------
 drivers/net/ethernet/intel/igc/igc_tsn.h  |  1 +
 4 files changed, 42 insertions(+), 18 deletions(-)

-- 
2.25.1


