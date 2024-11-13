Return-Path: <stable+bounces-92960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A619C7D4E
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 22:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1078C1F2357D
	for <lists+stable@lfdr.de>; Wed, 13 Nov 2024 21:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1F52064E9;
	Wed, 13 Nov 2024 21:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JinBz2JC"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7983E18B481;
	Wed, 13 Nov 2024 21:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731532033; cv=none; b=Rc2JdIh2ZfiW3CkZbvBvESHn2R/af39csLqxlhO0m0trlayo9bcxag1rzqUoKf3rXDjLIphAlbL+4Oi2F1ED4EhVklusrjDNY2EUd8evk/dEzGmPGiYbzR50jp7qzk7lIuJV1IRTy8sa6IQG50JGkuDOu3CBFHHrukwjLlNOF6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731532033; c=relaxed/simple;
	bh=YO5AIO6rtnJ0wLQFmiH37xhlN8XJAq7x16ZhzZJKUE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qsjOdSFHNpTEyJNS4z0rrsuszHUUYBzz5pxcYJWBC/o8WrrZXF5fV5mq3+0ZQoP1ONIBuX/4SG//Y3tAT4TUxpaTarKbFkWHLdlfVF6O95M6rLVXdnlw0UXGVTcHsJK8J/gi0t4jd2qabpzXkYFwsehcf5Rg/EEEDqTOgT0Dey0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JinBz2JC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731532032; x=1763068032;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YO5AIO6rtnJ0wLQFmiH37xhlN8XJAq7x16ZhzZJKUE4=;
  b=JinBz2JCDv7c3ncdNdq41vATFDAjQKY1Q91jlGiVG84AYxUgeDqwiJ52
   BQRb1MxfOuNW0KIm96ai0ShcbWZ0Oi1TnvebEY0Ubme58VNWzxQ+JFcCp
   XFtIU3MiJv49GjwT7QuN8/6lC9z8QKvOFVjFVZkWrXSzAv1GTWH6FnUQ3
   vlc6BxrZKLqkEWPWQZ1wlPluyg9SEcXjaOQIWHB3lXc/HHSqaHfpP27BV
   i8kmUivhrNi5o82DJ1zuyeYCFFzDnfTNMQo1OrGZCfaOi+37oy58NSTlt
   GzSke34HWT1ozD4M2lZ0/jwN7YhsGsgMVAJMiFryE/4rNTu6zjo9IJOL0
   Q==;
X-CSE-ConnectionGUID: gL3glywEQBahnbW+Dz613w==
X-CSE-MsgGUID: frCNWcpoRCyE+MtJJ+lEtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31685321"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="31685321"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 13:07:10 -0800
X-CSE-ConnectionGUID: KcHDyYDzQ4qPASVZP4sLXg==
X-CSE-MsgGUID: p30YHL+OT1KsqpjJICX7Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="125500147"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 13 Nov 2024 13:07:09 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Peter=20Gro=C3=9Fe?= <pegro@friiks.de>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	ivecera@redhat.com,
	stable@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net] i40e: Fix handling changed priv flags
Date: Wed, 13 Nov 2024 13:07:04 -0800
Message-ID: <20241113210705.1296408-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Peter Große <pegro@friiks.de>

After assembling the new private flags on a PF, the operation to determine
the changed flags uses the wrong bitmaps. Instead of xor-ing orig_flags
with new_flags, it uses the still unchanged pf->flags, thus changed_flags
is always 0.

Fix it by using the correct bitmaps.

The issue was discovered while debugging why disabling source pruning
stopped working with release 6.7. Although the new flags will be copied to
pf->flags later on in that function, disabling source pruning requires
a reset of the PF, which was skipped due to this bug.

Disabling source pruning:
$ sudo ethtool --set-priv-flags eno1 disable-source-pruning on
$ sudo ethtool --show-priv-flags eno1
Private flags for eno1:
MFP                   : off
total-port-shutdown   : off
LinkPolling           : off
flow-director-atr     : on
veb-stats             : off
hw-atr-eviction       : off
link-down-on-close    : off
legacy-rx             : off
disable-source-pruning: on
disable-fw-lldp       : off
rs-fec                : off
base-r-fec            : off
vf-vlan-pruning       : off

Regarding reproducing:

I observed the issue with a rather complicated lab setup, where
 * two VLAN interfaces are created on eno1
 * each with a different MAC address assigned
 * each moved into a separate namespace
 * both VLANs are bridged externally, so they form a single layer 2 network

The external bridge is done via a channel emulator adding packet loss and
delay and the application in the namespaces tries to send/receive traffic
and measure the performance. Sender and receiver are separated by
namespaces, yet the network card "sees its own traffic" send back to it.
To make that work, source pruning has to be disabled.

Cc: stable@vger.kernel.org
Fixes: 70756d0a4727 ("i40e: Use DECLARE_BITMAP for flags and hw_features fields in i40e_pf")
Signed-off-by: Peter Große <pegro@friiks.de>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
iwl: https://lore.kernel.org/intel-wired-lan/20241030160643.9950-1-pegro@friiks.de/

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index f2506511bbff..bce5b76f1e7a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5299,7 +5299,7 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	}
 
 flags_complete:
-	bitmap_xor(changed_flags, pf->flags, orig_flags, I40E_PF_FLAGS_NBITS);
+	bitmap_xor(changed_flags, new_flags, orig_flags, I40E_PF_FLAGS_NBITS);
 
 	if (test_bit(I40E_FLAG_FW_LLDP_DIS, changed_flags))
 		reset_needed = I40E_PF_RESET_AND_REBUILD_FLAG;
-- 
2.42.0


