Return-Path: <stable+bounces-238379-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Dc3JtGE4WkiuQAAu9opvQ
	(envelope-from <stable+bounces-238379-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 02:54:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 976C8415DED
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 02:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EDF08301F278
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 00:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6B8202C29;
	Fri, 17 Apr 2026 00:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APnz/Agm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810AD19995E;
	Fri, 17 Apr 2026 00:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776387271; cv=none; b=qjkjKEZp1l5dze8msAgk1Nxragvy4LjN+tEvQ/cz9UgQbYCeMOertkJXJh3Ipb6ddII179lBA2M3a6nAMCqfSVOnjrbO+bNwNdeGradKwIKf08a162GGOAnoX/2vVSuyAE2lnERbvewIKn0M75afvFZxhyCVvZjVu3AV4H5EprU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776387271; c=relaxed/simple;
	bh=Alf7f9YqU6Can43j8R6FU+mWu/rMC6w5d8rn646lQ6g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fd1KpfJ0ZVd1aZNgzernTyBMROJe50m/Mx4FytA6yJugbdB3kXoDHqLO+NAwAOW0AkHmk4ouytIhWF6m2E85fO46aaUDXg5azQabrG+uhZ816kmXIK2Oh+nl+iU/+4GJPT4G09Jr4mLeuWW1JhSglRl5JQiORqhS8QX41ESF1jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APnz/Agm; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776387270; x=1807923270;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=Alf7f9YqU6Can43j8R6FU+mWu/rMC6w5d8rn646lQ6g=;
  b=APnz/AgmM7fJkE+669AqINj2Ai+TXTohDUiKFhPDBuQ8MtJAQqsP1tij
   R34ct8rheo59AsDyQlw2v73A3sVQNbpEe16Ti0wKZW8BO0lc2CjvhdX5y
   QFs4NuyRQ7PkuHiMVWz5co+qp5aA1bEIXmxAdEAt6h86v5o7MonZ5oqI2
   XLJ35b+qGch5LO5ejqS8hazrRvDaiNnY2QQ4f/qXbGRt2sxRXX8XCK7Nu
   9173DRxYaoqYUEkM4R+JVhderthaKWHouafjIlLivahMeSlT7ID/9uRmr
   cV6OtOTyNUVqK4sDd9Au+malELtcJxaKkMZ46AG+Mf7jRs8EuUO19+uQE
   w==;
X-CSE-ConnectionGUID: ivkoeKEJT8aW0friOHxJWg==
X-CSE-MsgGUID: 0rwdFTKJSSSbYX4XSSwPnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="81000507"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="81000507"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 17:54:29 -0700
X-CSE-ConnectionGUID: Kt6Nt0u4QvqyOFxWoOTMvQ==
X-CSE-MsgGUID: busBHbVIR1W1gnq9LVsqKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226539853"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 17:54:28 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net v2 00/12] Intel Wired LAN Driver Updates 2026-04-14
 (ice, i40e, iavf, idpf, e1000e)
Date: Thu, 16 Apr 2026 17:53:24 -0700
Message-Id: <20260416-iwl-net-submission-2026-04-14-v2-0-686c33c9828d@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OzQ6CMBCEX4Xs2TX9QUROvofhgLDIGmhNW1FDe
 HdbfAGPs/PN7CzgyTF5qLIFHM3s2Zoo1C6DdmjMjZC7qEEJVYhc5sivEQ0F9M/rxD7hmDwUOUa
 3UEKTLAvR9Rpix8NRz++t/wIxBvXvGNN3akNqTtjAPlj32VbMcoP/fDhLFFgeVK9LOnaNPp3ZB
 Br3rZ2gXtf1C8mUA2jhAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4124;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=Alf7f9YqU6Can43j8R6FU+mWu/rMC6w5d8rn646lQ6g=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsyHLXvTsrJsj2rcWyByMnmZ8ywGt+AnkktZBHf+/Lv72
 8b0iU5CHaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAExkBwfDT8ZJl1sU3mrLSP23
 XLR+aw9b/oFS40Ju7/1/1r0MyXyzSoThf/6cnd33XCQP+AW/2ndw6949hnXiP2uudVq9+KoY0Ft
 +iwEA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238379-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,kernel.org,gmail.com,redhat.com,enjuk.jp,molgen.mpg.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 976C8415DED
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

Petr fixes the VLAN L2TAG2 mask when the iAVF VF and a PF negotiate use of
the legacy Rx descriptor format.

Emil fixes a NULL pointer dereference that can happen in the soft reset if
a particular error path is taken.

Matt fixes the unrolling logic for PTP when the e1000e probe fails after
the PTP clock has been registered.

 **A note to stable backports**

  The patches [7/12] ("ice: fix race condition in TX timestamp ring
  cleanup") and [8/12] ("ice: fix potential NULL pointer deref in error
  path of ice_set_ringparam()") must be backported together. Otherwise the
  fix in patch 8 will not work properly.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v2:
- Drop patch 10/13 ("i40e: fix napi_enable/disable skipping ringless
  q_vector").
- Link to v1: https://patch.msgid.link/20260414-iwl-net-submission-2026-04-14-v1-0-852f38e7da39@intel.com

---
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
 drivers/net/ethernet/intel/i40e/i40e_main.c     |   1 -
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c    |   2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c    |   1 +
 drivers/net/ethernet/intel/ice/ice_lib.c        |   4 +-
 drivers/net/ethernet/intel/ice/ice_main.c       | 121 ++++++------------------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c     |   6 +-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c     |   2 +
 drivers/net/ethernet/intel/ice/ice_txrx.c       |  29 ++++--
 drivers/net/ethernet/intel/idpf/xdp.c           |   1 +
 drivers/net/ethernet/intel/idpf/xsk.c           |   4 +-
 16 files changed, 81 insertions(+), 127 deletions(-)
---
base-commit: 52bcb57a4e8a0865a76c587c2451906342ae1b2d
change-id: 20260414-iwl-net-submission-2026-04-14-6203e1860df3

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


