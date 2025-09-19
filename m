Return-Path: <stable+bounces-180688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C1AB8AFA1
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 20:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373A93A2295
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 18:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DE126E16E;
	Fri, 19 Sep 2025 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AE3rSKul"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87D323FC4C;
	Fri, 19 Sep 2025 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307806; cv=none; b=T7oUHfJcA4Fccv2EGSKJEN0BaUE6BJg6CPrjNknmu2nhHVdv4t2xm2xPTzIgf2ZBBh8H41SVlDvVTRFGUp4IR8ovK7rMv+/tmuJi4VsKkuae1VuihU1dBcJp7r2JyjabnP5Ea8xnweN4oPXAp+TeBy6oufPkDT3rznfYCgIfZys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307806; c=relaxed/simple;
	bh=P4zd9K+oidrIGpkBaBqqVFF3VZUOgOAqvczeZce1j7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WMORiS0DXNQNHRdYE0E6ehrVmsaAqDSdGMyTVHbaOwGs0VVPCkakOaT1Vd/TGtOrpaTxXSMRndP50K6U81n+fIyf+jdFXTej+18P2TgEub3y5FudPWG/2j+Z0ZCSanGt71klu4f54CIJCyWUNCSmNx+e6fXskNN/iwcYyXFhUo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AE3rSKul; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758307804; x=1789843804;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P4zd9K+oidrIGpkBaBqqVFF3VZUOgOAqvczeZce1j7U=;
  b=AE3rSKulMb5Q6ha6XKBqfaQ+JvCfhXbrgKmtwyu4Vu+DZKom/N6RpQ3p
   tDiYs1G6X7ip4+opKiLSBtNI7gxVDfdbu0yJxrvI2bezsM3ZFgw4VQ9VZ
   xJh4JVGRp18a5PHEHfSbkpWE14Z+euYb0Vqk2IbW4t4ZMc9tkgEat035p
   Y1oNnTlV4Gyak+NlgJF2DC4O2Ug5wRT+aSiEp8p69YfEube0SurkpxbWD
   ylBDCPLv3lTIX3qrmz1E3jkoSLhAbA14v8GsZ2DjJOSm6iYoQtJYiMJdT
   +XTj/O/UIj/bDPKL3lno6r+n5Xwcr9tSs2yeUS7JzxpI6dTzAn/WGBCOE
   Q==;
X-CSE-ConnectionGUID: /trtpYvqQ42yDTD+xwG3mA==
X-CSE-MsgGUID: v5PN/4VMSveAEOwH+mFNcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="60589719"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60589719"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 11:50:04 -0700
X-CSE-ConnectionGUID: uyKTlcsyRAWNV9tOWWSohg==
X-CSE-MsgGUID: ktwHADEdTY+fqPsNqLOgUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="175458760"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 19 Sep 2025 11:50:04 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	lukasz.czapnik@intel.com,
	przemyslaw.kitszel@intel.com,
	leszek.pepiak@intel.com,
	jeremiah.kyle@intel.com,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH net 0/8][pull request] i40e: virtchnl improvements
Date: Fri, 19 Sep 2025 11:49:50 -0700
Message-ID: <20250919184959.656681-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Przemek Kitszel says:

Improvements hardening PF-VF communication for i40e driver.
This patchset targets several issues that can cause undefined behavior
or be exploited in some other way.
---
IWL: https://lore.kernel.org/intel-wired-lan/20250813104552.61027-1-przemyslaw.kitszel@intel.com/

The following are changes since commit cbf658dd09419f1ef9de11b9604e950bdd5c170b:
  Merge tag 'net-6.17-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

Lukasz Czapnik (8):
  i40e: add validation for ring_len param
  i40e: fix idx validation in i40e_validate_queue_map
  i40e: fix idx validation in config queues msg
  i40e: fix input validation logic for action_meta
  i40e: fix validation of VF state in get resources
  i40e: add max boundary check for VF filters
  i40e: add mask to apply valid bits for itr_idx
  i40e: improve VF MAC filters accounting

 drivers/net/ethernet/intel/i40e/i40e.h        |   3 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  26 ++++-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 110 ++++++++++--------
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |   3 +-
 4 files changed, 90 insertions(+), 52 deletions(-)

-- 
2.47.1


