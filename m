Return-Path: <stable+bounces-58180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 328849297E9
	for <lists+stable@lfdr.de>; Sun,  7 Jul 2024 14:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 508CC1C209A0
	for <lists+stable@lfdr.de>; Sun,  7 Jul 2024 12:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8A71E4A4;
	Sun,  7 Jul 2024 12:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jbjYVfUw"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B6A224DD;
	Sun,  7 Jul 2024 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720356946; cv=none; b=Yupb/ON1mGHlNMkzgEp3q0REWFUJiD6q7UBvbDIe0wPHr+qWunYcNJE32VPIAZfBlHtJtu+x9Xmtg/jJPJvjN1ewV+B5bPmQwJIOOCQcw+b+8AJCH5rfxDT8PV8mpTPcPflayKgcTD8DnM1LgDzzYtBAWZilz6aSeICh1wscmdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720356946; c=relaxed/simple;
	bh=8CQywXGpVZmoXAWi7aQtBVNWRM3RoZSfC5ilnp7epOE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m80t2bPh5G0eQA2k9tUqV356xnseEhr+EKcHAs+AULldSJbgysJ9nb82r2ROxavgjq5OKcuwAjzSWKqy4ItUDlSHCuxpWTfWoboqj7B3CfJSXdOpJWSxQR27cMx/Lt4V3dT/UI5aX1DnCr2wYPxFnDGAuQXHIJ1QPHpxFu4IoVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jbjYVfUw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720356945; x=1751892945;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8CQywXGpVZmoXAWi7aQtBVNWRM3RoZSfC5ilnp7epOE=;
  b=jbjYVfUwrgMuwy9S+4Ql9FzwL0iOmJCvpT5YDmWwzorAcEpzHWqIK2ZG
   dmRxuIzGD09vvykSoGWHfAv+ww6pyRmuy5BmDSMafNHLDN2dY7bh4Oa3D
   meY/cNbFXl0/prg4l0X65Pt3sxisaeeSXsIf8U6QGGV/COy6nWN/t8GJj
   h00FNw8NcDtFZS/q+Fse1MF5nBWiCw6cpl/B2ufan0wpFJAn8a+y+bpS7
   Kx4QO00YggelTp8T55S9qei7icTUlitkFpvm+2yF3OnnB3Jlk/dR89hVV
   G29IN3bRpPdrFBGCvCrqCHDeEsN2jnEX4eR+lfdjhEe1O+OJQmIfptC18
   w==;
X-CSE-ConnectionGUID: 6ImWUKwnTKibyeHgUI1Tjg==
X-CSE-MsgGUID: /SLo8p2uS8u3TnW8RWr5Vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11125"; a="28723343"
X-IronPort-AV: E=Sophos;i="6.09,190,1716274800"; 
   d="scan'208";a="28723343"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 05:55:44 -0700
X-CSE-ConnectionGUID: 29qQB5d0QByj+IG+noHX1w==
X-CSE-MsgGUID: tIxHmSCoRHKInGn757BvVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,190,1716274800"; 
   d="scan'208";a="51692250"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2024 05:55:42 -0700
Received: from mohdfai2-iLBPG12-1.png.intel.com (mohdfai2-iLBPG12-1.png.intel.com [10.88.227.73])
	by linux.intel.com (Postfix) with ESMTP id 2973D20738C7;
	Sun,  7 Jul 2024 05:55:38 -0700 (PDT)
From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Sasha Neftin <sasha.neftin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Subject: [PATCH iwl-net v2 0/3] igc bug fixes related to qbv_count usage
Date: Sun,  7 Jul 2024 08:53:15 -0400
Message-Id: <20240707125318.3425097-1-faizal.abdul.rahim@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These igc bug fixes are sent as a patch series because:

1.  The two patches below remove the reliance on using the qbv_count field.
   "igc: Fix qbv_config_change_errors logics"
   "igc: Fix reset adapter logics when tx mode change"

    qbv_count field will be removed in future patch via iwl-next.

2. The patch "igc: Fix qbv tx latency by setting gtxoffset" reuse the
   function igc_tsn_will_tx_mode_change() which was created in the patch:
   "igc: Fix reset adapter logics when tx mode change"

v1: https://patchwork.kernel.org/project/netdevbpf/cover/20240702040926.3327530-1-faizal.abdul.rahim@linux.intel.com/

Changelog:
v1 -> v2
- Instead of casting to bool, use !! (Simon)
- Simplify new functions created. Instead of if.. return true, else return false,
  use single return. (Simon)
- Remove patch "igc: Remove unused qbv_coun" from this series which is targeting
  to iwl-net. This patch will be sent to iwl-next. (Simon)

Faizal Rahim (3):
  igc: Fix qbv_config_change_errors logics
  igc: Fix reset adapter logics when tx mode change
  igc: Fix qbv tx latency by setting gtxoffset

 drivers/net/ethernet/intel/igc/igc_main.c |  8 +++--
 drivers/net/ethernet/intel/igc/igc_tsn.c  | 41 ++++++++++++++++-------
 drivers/net/ethernet/intel/igc/igc_tsn.h  |  1 +
 3 files changed, 36 insertions(+), 14 deletions(-)

--
2.25.1


