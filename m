Return-Path: <stable+bounces-238043-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAD3LAkn32nmPQAAu9opvQ
	(envelope-from <stable+bounces-238043-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 07:50:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DDC400960
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 07:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C885A30A7CAB
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E4B372689;
	Wed, 15 Apr 2026 05:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XfD2deoI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F6B2F9998;
	Wed, 15 Apr 2026 05:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232167; cv=none; b=ViWXxRFM5D2A9zXDgZlk2zyg2FXk+y8wyXHVe/iDOmpFLZdFTO0LNSvbPKqLsEV7RmAKlOQht/qGh2QL9C/rtn3oRxuDFoTI4qKyAzv8FDwGr+MNtfK6lWmeHwoFYOL/OzomirXmpkUDQy4bWobiFW+3alPVztcfsZ//sZ4u8wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232167; c=relaxed/simple;
	bh=SToZHeiExoVmCVjlNNleco04kxxV7uv1KyLf6s8n+os=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p6wdWezgLViwrF5nxTwSRPPd8gM5S4frkRyXd2MTGdPp4u0uCvSBzKB+tIxirurmZ/sAvJfsuBe2M3MxGfxksIS2Mp0QfbPVslReEN4Xs5L9HuZuZBmSv9okrovV1oj7122FDjYVZxBVToMGke3Wwap0AaXSMXSRhOj+ZWNMB6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XfD2deoI; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776232165; x=1807768165;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=SToZHeiExoVmCVjlNNleco04kxxV7uv1KyLf6s8n+os=;
  b=XfD2deoIEWXoJmkNZ47jTb2PQCJtxJLTjckx6ucGEJbcV0gxfdspT5z/
   NusF+fWYBxLBysDon0QKwxFp5aVdMWgKotdh3Ei4uLS9jcRi4kmGeIMS6
   R5UsWlY/Sx93YDTdEphuHeUkYf9mRtZx1QXXNKHxVUecWIfZwJ4H5zaf1
   t7kFF94+DUTq5vNxoBkaLPbiSUI5mzYxfRJj96HZLR9FGLyO/kZbAhicJ
   EIHuqK3asS4RhzxLwnw827Kyb+e7A/Lo6u9NyjeihciH6D+Py0C38OmcS
   lFawldW4avEJYhGVo7CZueJslGR2H1fvMMGVl8/AWKewpooOatlUn5y4H
   w==;
X-CSE-ConnectionGUID: dU79un4HRZ6AKfoZvfyAJQ==
X-CSE-MsgGUID: Y8BgpUAZT2m7JKK4UpKh+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77105904"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77105904"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 22:49:24 -0700
X-CSE-ConnectionGUID: sUemhswkTjqfUHh6/YHxVQ==
X-CSE-MsgGUID: tBn3KHTBQlKh5PN6u2WVUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="253714784"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 22:49:23 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net 00/13] Intel Wired LAN Driver Updates 2026-04-14 (ice,
 i40e, iavf, idpf, e1000e)
Date: Tue, 14 Apr 2026 22:47:55 -0700
Message-Id: <20260414-iwl-net-submission-2026-04-14-v1-0-852f38e7da39@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM2wrCMAyGX2Xk2kDalSK+injhtkwj2o1mJxh7d
 1O9/P7Dt4NyFla4VDtkXkRlSAbuVEH7vKcHo3TG4MlHCi6grG9MPKHOzUe0zLF0SAGtjZ5qdud
 IXV+DOcbMvWw//xXsBrd/aO8Xt1Mxw3F8AVZp2KeGAAAA
X-Change-ID: 20260414-iwl-net-submission-2026-04-14-6203e1860df3
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Simon Horman <horms@kernel.org>, Rinitha S <sx.rinitha@intel.com>, 
 Zoltan Fodor <zoltan.fodor@intel.com>, 
 Sunitha Mekala <sunithax.d.mekala@intel.com>, 
 Guangshuo Li <lgs201920130244@gmail.com>, stable@vger.kernel.org, 
 Michal Schmidt <mschmidt@redhat.com>, 
 Paul Greenwalt <paul.greenwalt@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Keita Morisaki <kmta1236@gmail.com>, Kohei Enju <kohei@enjuk.jp>, 
 Petr Oros <poros@redhat.com>, Paul Menzel <pmenzel@molgen.mpg.de>, 
 Rafal Romanowski <rafal.romanowski@intel.com>, 
 Emil Tantilov <emil.s.tantilov@intel.com>, 
 Patryk Holda <patryk.holda@intel.com>, Matt Vollrath <tactii@gmail.com>, 
 Avigail Dahan <avigailx.dahan@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=4153;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=SToZHeiExoVmCVjlNNleco04kxxV7uv1KyLf6s8n+os=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsz7andmFZw9sWXCsm8x7csYLs0v2vFiT3PNuVnz5N7dY
 /pm1H3JpqOUhUGMi0FWTJFFwSFk5XXjCWFab5zlYOawMoEMYeDiFICJPCpiZNjftmzNTffp7ck/
 2eQmbOieJGbTzp7R6Sa/dnUx/9nVkrsZ/jvMfWXw9XW1XEz67oo9Hdek1bZw/Vs6xTx5qtjmNXf
 r/BkB
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238043-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,kernel.org,gmail.com,redhat.com,enjuk.jp,molgen.mpg.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 75DDC400960
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Grzegorz updates the logic for adjusting the PTP hardware clock on E830,
fixing a bug that prevented adjustments below S32_MAX/MIN nanoseconds.

Grzegorz and Zoli update the PCS latency settings for E825 devices at 10GbE
and 25GbE, improving the accuracy of timestamps based on data from
production hardware.

Michal Schmidt fixes a double-free that could happen if a particular error
path is taken in ice_xmit_frame_ring().

Guangshuo fixes a double-free that could happen during error paths in the
ice_sf_eth_activate() function.

Paul Greenwalt fixes the PHY link configuration when the link-down-on-close
driver parameter is enabled and new media is inserted.

Paul Greenwalt fixes the ICE_AQ_LINK_SPEED_M macro for 200G, enabling 200G
link speed advertisement.

Keita Morisaki fixes a race condition in the ice Tx timestamp ring cleanup,
preventing a possible NULL pointer dereference.

Kohei Enju fixes a potential NULL pointer dereference in ice_set_ring_param().

Kohei Enju fixes i40e to stop advertising IFF_SUPP_NOFCS, when the driver
does not actually support the feature.

Aleksandr fixes i40e napi_enable/disable for q_vectors that no longer have
rings.

Petr fixes the VLAN L2TAG2 mask when the iAVF VF and a PF negotiate use of
the legacy Rx descriptor format.

Emil fixes a NULL pointer dereference that can happen in the soft reset if
a particular error path is taken.

Matt fixes the unrolling logic for PTP when the e1000e probe fails after
the PTP clock has been registered.

 **A note to stable backports**

  The patches [7/13] ("ice: fix race condition in TX timestamp ring
  cleanup") and [8/13] ("ice: fix potential NULL pointer deref in error
  path of ice_set_ringparam()") must be backported together. Otherwise the
  fix in patch 8 will not work properly.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Aleksandr Loktionov (1):
      i40e: fix napi_enable/disable skipping ringless q_vectors

Emil Tantilov (1):
      idpf: fix xdp crash in soft reset error path

Grzegorz Nitka (2):
      ice: fix 'adjust' timer programming for E830 devices
      ice: update PCS latency settings for E825 10G/25Gb modes

Guangshuo Li (1):
      ice: fix double free in ice_sf_eth_activate() error path

Keita Morisaki (1):
      ice: fix race condition in TX timestamp ring cleanup

Kohei Enju (2):
      ice: fix potential NULL pointer deref in error path of ice_set_ringparam()
      i40e: don't advertise IFF_SUPP_NOFCS

Matt Vollrath (1):
      e1000e: Unroll PTP in probe error handling

Michal Schmidt (1):
      ice: fix double-free of tx_buf skb

Paul Greenwalt (2):
      ice: fix PHY config on media change with link-down-on-close
      ice: fix ICE_AQ_LINK_SPEED_M for 200G

Petr Oros (1):
      iavf: fix wrong VLAN mask for legacy Rx descriptors L2TAG2

 drivers/net/ethernet/intel/iavf/iavf_type.h     |   2 +-
 drivers/net/ethernet/intel/ice/ice.h            |   4 +-
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h |  12 +--
 drivers/net/ethernet/intel/ice/ice_txrx.h       |  16 ++--
 drivers/net/ethernet/intel/e1000e/netdev.c      |   1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c     |  29 +++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c     |  10 ++
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c    |   2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c    |   1 +
 drivers/net/ethernet/intel/ice/ice_lib.c        |   4 +-
 drivers/net/ethernet/intel/ice/ice_main.c       | 121 ++++++------------------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c     |   6 +-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c     |   2 +
 drivers/net/ethernet/intel/ice/ice_txrx.c       |  29 ++++--
 drivers/net/ethernet/intel/idpf/xdp.c           |   1 +
 drivers/net/ethernet/intel/idpf/xsk.c           |   4 +-
 17 files changed, 107 insertions(+), 139 deletions(-)
---
base-commit: b9d8b856689d2b968495d79fe653d87fcb8ad98c
change-id: 20260414-iwl-net-submission-2026-04-14-6203e1860df3

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


