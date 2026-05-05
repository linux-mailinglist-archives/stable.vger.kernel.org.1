Return-Path: <stable+bounces-243967-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rESMOQJ9+Wmd9AIAu9opvQ
	(envelope-from <stable+bounces-243967-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:15:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A05EC4C6BF8
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D48D6300B98E
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F0D3BE628;
	Tue,  5 May 2026 05:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bt008oxv"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C7D22083;
	Tue,  5 May 2026 05:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958139; cv=none; b=mMCgCUWhdBmHXkvwecDKlVvg3KpCYSZNqJ9U/5iU2XYfPi3rkRas0B2ERDK7xQRDdFZiFddbWVUA5N32etgGK6uU0Da76e1CvD8/mKSBk9sOjKvXGurAkIDZbhhwPAfIzWpoVfFqlS5r2rkcxJUgZcCQ1hu8ZCp6fOOwp7PzM7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958139; c=relaxed/simple;
	bh=A8dqybLGdBd9AeDi/XiA0DySjlsRjMMkQbqYXoc7gNM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ep+Yyuv4tCVir63bhPHaJzqtfeQafw4hqqYGOxEYlF0ii0bl4fsRgii5BuPTHQm24+0GpP7TswavMbzU5f2QEqtNH0BnK2Vn7MNaAII1v7a2WEbKgu/MUYT0AmmZXxvTl2MpNiAOUeUnt//KV2p4b9vZsQmDH3I3ndHpoXbp4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bt008oxv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777958138; x=1809494138;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=A8dqybLGdBd9AeDi/XiA0DySjlsRjMMkQbqYXoc7gNM=;
  b=Bt008oxvpM4EfGmtQz761ieqr4PcPlr8fexcatUaBHJNzYC/7ESiig/h
   3udm9g5v0Ytdz7DOLvbAkWi+tIGlcvSfPxaQftmawwdFj4u4AapxZq1vZ
   fFIbUPCl1nKiprAUDruCXO3JoIPy1ZF5TajtF0AGLJ9sGM0bIl220ggbP
   9RRQoYjgqFU0sVeW/tVvFP+EzUwfN5dZO9WZtRpGbaveRvf4CSULfDr90
   zm+v7ZBH0Bdz+HjAgHmGJ2jSKU1fhmw2wKJVeCaMI1n/4WfI9cE0PR1ou
   8cMynMhwBK9E/JrnW0c9RDW+2B6HPl6g5rTiFgAlc7udy5kCs4oqfO3Iu
   g==;
X-CSE-ConnectionGUID: m86HzcAbTbGd4TEgw09i9Q==
X-CSE-MsgGUID: sOE/JpI3SqGyyPu06zDgpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89126411"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="89126411"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:36 -0700
X-CSE-ConnectionGUID: gwAKZw3gSWaBXl0DMIOG5g==
X-CSE-MsgGUID: kyNdlXviR2ikO1/rB/o/9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="239683482"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:36 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net 00/13] Intel Wired LAN Driver Updates 2026-05-04 (i40e,
 ice, idpf)
Date: Mon, 04 May 2026 22:14:13 -0700
Message-Id: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMyw6CMBBFf4XcNZPUakH4FcJCcaqDppAWHwnh3
 x1geU7uPTMSR+GEOpsR+SNJhqBwyDN0j0u4M8lNGdbYwjhzov5J8n1R4IlWR8aRWl85W5zt0ZW
 lh37HyF5+W7eBbtHuMr2vPXfTWsSy/AE0Pb4bfgAAAA==
X-Change-ID: 20260504-jk-iwl-net-2026-05-04-f9526823577f
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Joshua Hay <joshua.a.hay@intel.com>, 
 Madhu Chittim <madhu.chittim@intel.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Dave Ertman <david.m.ertman@intel.com>, Ivan Vecera <ivecera@redhat.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>, Matt Vollrath <tactii@gmail.com>, 
 Sunitha Mekala <sunithax.d.mekala@intel.com>, Kohei Enju <kohei@enjuk.jp>, 
 Paul Menzel <pmenzel@molgen.mpg.de>, Simon Horman <horms@kernel.org>, 
 Emil Tantilov <emil.s.tantilov@intel.com>, 
 Samuel Salin <Samuel.salin@intel.com>, 
 Patryk Holda <patryk.holda@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, stable@kernel.org, 
 Marcin Szycik <marcin.szycik@linux.intel.com>, 
 Bart Van Assche <bvanassche@acm.org>, intel-wired-lan@lists.osuosl.org, 
 Arpana Arland <arpanax.arland@intel.com>, Rinitha S <sx.rinitha@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=4026;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=A8dqybLGdBd9AeDi/XiA0DySjlsRjMMkQbqYXoc7gNM=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsyfNR8nLNzxUcAoS0991pWfubHHE/jELkVIcd/QjPi/f
 tpstU8HOkpZGMS4GGTFFFkUHEJWXjeeEKb1xlkOZg4rE8gQBi5OAZhIogsjw2uj6ct6Fm33jPBN
 b48s/rNP7UL9nW/NL7W72b4fD0vX0WRkeBgyI9DvXq64zmQdtftqlgfKN3p4ir1W0MyX81n/WOo
 lDwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: A05EC4C6BF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[36];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243967-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,enjuk.jp,molgen.mpg.de,kernel.org,linuxfoundation.org,linux.intel.com,acm.org,lists.osuosl.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Matt Volrath fixes two issues with the i40e driver probe routine, ensuring
that PTP is properly cleaned up if the probe fails.

Maciej fixes the i40e driver logic to keep the q_vectors array in sync with
changes to the channel count via ethtool.

Emil corrects the initialization of the read_dev_clk_lock spinlock in
idpf_ptp_init, ensuring it is initialized prior to when the
ptp_schedule_worker() is called.

Josh fixes the idpf driver to prevent enabling XDP if the queue based
scheduling is not supported by the firmware.

Josh fixes the idpf skb data path for handling queue based scheduling.

Josh fixes an XDP crash in the soft reset error path, restoring the
original configuration if idpf_xdp_setup_prog() fails.

Greg KH fixes a double free and use-after free in the idpf auxiliary device
error paths.

Marcin fixes ice_set_rss_hfunc() to use the correct q_opt_flags field,
correcting the assignment and preventing submission of invalid data to the
firmware.

Bart corrects the locking in ice_dcb_rebuild(), ensuring that the tc_mutex
is held over the entire operation.

Grzegorz fixes the ordering of ice_ptp_link_change() in ice_up_complete()
ensuring that the PTP timestamps will not be enabled before the PTP timer
is actually re-initialized.

Ivan fixes the rclk pin state get for E810 devices, ensuring the index is
properly offset by the base_rclk_idx value. This ensures that the correct
pin index is used to look up recovered clock state. He additionally adds
bounds checking to prevent attempting to access pins outside of the pin
state array.

Ivan also moves the CGU register macros to the top of ice_dpll.h, inside
the header guard to avoid duplicate macro definitions should the ice_dpll.h
header is included multiple times.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Bart Van Assche (1):
      ice: fix locking in ice_dcb_rebuild()

Emil Tantilov (2):
      idpf: fix read_dev_clk_lock spinlock init in idpf_ptp_init()
      idpf: fix xdp crash in soft reset error path

Greg Kroah-Hartman (1):
      idpf: fix double free and use-after-free in aux device error paths

Grzegorz Nitka (1):
      ice: fix PTP hang for E825C devices

Ivan Vecera (2):
      ice: dpll: fix rclk pin state get for E810
      ice: dpll: fix misplaced header macros

Joshua Hay (2):
      idpf: do not enable XDP if queue based scheduling is not supported
      idpf: fix skb datapath queue based scheduling crashes and timeouts

Maciej Fijalkowski (1):
      i40e: keep q_vectors array in sync with channel count changes

Marcin Szycik (1):
      ice: fix setting RSS VSI hash for E830

Matt Vollrath (2):
      i40e: Cleanup PTP registration on probe failure
      i40e: Cleanup PTP pins on probe failure

 drivers/net/ethernet/intel/i40e/i40e.h          |  1 +
 drivers/net/ethernet/intel/ice/ice_dpll.h       | 32 ++++++-------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h     | 12 +++--
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.h |  4 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c     | 36 ++++++++++++---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c      |  3 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c    |  4 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c       |  5 ++
 drivers/net/ethernet/intel/ice/ice_main.c       |  6 +--
 drivers/net/ethernet/intel/idpf/idpf_idc.c      |  6 +++
 drivers/net/ethernet/intel/idpf/idpf_lib.c      |  4 +-
 drivers/net/ethernet/intel/idpf/idpf_ptp.c      |  4 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c     | 61 ++++++++++++++-----------
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 19 ++------
 drivers/net/ethernet/intel/idpf/xdp.c           | 15 ++++--
 drivers/net/ethernet/intel/idpf/xsk.c           |  4 +-
 16 files changed, 132 insertions(+), 84 deletions(-)
---
base-commit: bd3a4795d5744f59a1f485379f1303e5e606f377
change-id: 20260504-jk-iwl-net-2026-05-04-f9526823577f

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


