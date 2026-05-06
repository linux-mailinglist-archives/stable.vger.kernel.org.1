Return-Path: <stable+bounces-244458-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDM+A4G3+2njDgAAu9opvQ
	(envelope-from <stable+bounces-244458-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:49:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2DC4E0BE9
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DA7D3029AC4
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 21:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C0A346ADC;
	Wed,  6 May 2026 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/brE9vW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DA6239085;
	Wed,  6 May 2026 21:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104161; cv=none; b=TYiBn3O+02jazcVLABQlviH77FZ9kWThYzVMLzvTniJL5LYLRlEwPX+nYv339pOqO/gZQpc7i9v0mMx9c5F4wNezKNue0f2ZSsfn21t64jDu8+4z6x0fntAxSTgi52pRE71sSgdHMEQ+uYJBfsX6mWyU2KluZ/8wMZDgXKO0gtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104161; c=relaxed/simple;
	bh=UCMx9KGLx0pU5Z3g8AUDAOyv1zy/CnZ5A9pStdcQe+Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kZ9IOizQNIJxIJ1n9NzezbFHjCMya99Ecvc7w9A/Q1ziaCSwPYHI0XM2pF9/9IK94eZn6x+cs3HgdAfd2/SrSKOI/3cf6L3DfCzGJZMqpRXnuagj3rj3sGzT14B2x3fmGRNmiS+DfIalb08djGGlaAuCt/9hePxfKClEKE4utgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/brE9vW; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778104159; x=1809640159;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=UCMx9KGLx0pU5Z3g8AUDAOyv1zy/CnZ5A9pStdcQe+Y=;
  b=H/brE9vWsKYsrph1pzFrIuYBJbBEYF5HVGq/Vm6vmP0aXwgjc7OSuGS+
   sCAOIe31tHhNpyWvgUDp3sFn6ETbrH5kzg7oMvxeqvLSWoh2Dbx6FhOEM
   btst9GTFNqPt27wWA9tTg+sp12RIvJrvrHfcCVanf1xAoEe7dq7yyMGYB
   MitAvCyuvEU7ls4ywS33VlEbliSL/QzNveL3SAK+4/U+uxZnWcNj8Uf95
   hm5GquuWRjBYiGMandoVk88wOcBYuednyxZGVluEXY02XYl6PfgZ2vzOG
   XAKWosp+PNd9a3+K3frF5bo/qsJHHCQLSRgZTg3L5jUcnhH2AFoY8hQcV
   w==;
X-CSE-ConnectionGUID: Vg+aIy8NTRiJq+nSGCbatg==
X-CSE-MsgGUID: P9robEFAQTOJixfNUeEFnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78982482"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="78982482"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:49:18 -0700
X-CSE-ConnectionGUID: fFM+kkj7QVmpDoQdPxdvHQ==
X-CSE-MsgGUID: P6bq3gwlQLO5BZSe8Wzjlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="259698605"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:49:17 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net v2 0/8] Intel Wired LAN Driver Updates 2026-05-04
 (i40e, ice, idpf)
Date: Wed, 06 May 2026 14:48:09 -0700
Message-Id: <20260506-jk-iwl-net-2026-05-04-v2-0-a5ea4dc837a9@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNSw6CQBBEr0J6bZuhdfi48h6GBZ9GGnEwMyNqC
 Hd3wAO4rJdXVTM4tsIOTtEMlidxMpoQaBdB3ZXmyihNyECKEqXVEfsbymtAwx5XhkpjoG2uKcn
 ooNO0hdB9WG7lve1eILhQ/KB7Vj3Xfl1ctU6cH+1ne5/iTf5zNMWosCSiMsuqJk/oLMbzsK/HO
 xTLsnwBrLXYs9EAAAA=
X-Change-ID: 20260504-jk-iwl-net-2026-05-04-f9526823577f
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Joshua Hay <joshua.a.hay@intel.com>, 
 Madhu Chittim <madhu.chittim@intel.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Dave Ertman <david.m.ertman@intel.com>, Ivan Vecera <ivecera@redhat.com>, 
 Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>, Matt Vollrath <tactii@gmail.com>, 
 Sunitha Mekala <sunithax.d.mekala@intel.com>, Kohei Enju <kohei@enjuk.jp>, 
 Paul Menzel <pmenzel@molgen.mpg.de>, 
 Emil Tantilov <emil.s.tantilov@intel.com>, Simon Horman <horms@kernel.org>, 
 Samuel Salin <Samuel.salin@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, stable@kernel.org, 
 Marcin Szycik <marcin.szycik@linux.intel.com>, 
 Bart Van Assche <bvanassche@acm.org>, intel-wired-lan@lists.osuosl.org, 
 Arpana Arland <arpanax.arland@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2786;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=UCMx9KGLx0pU5Z3g8AUDAOyv1zy/CnZ5A9pStdcQe+Y=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhszf28O54v7FL5kj9ypx8TX/KxzfZz1apm6z7dk6lpYjP
 /m6rhz631HKwiDGxSArpsii4BCy8rrxhDCtN85yMHNYmUCGMHBxCsBEntkxMjzvZ9D727bk54qN
 q+UaZgtcnZbx0j6rNHrupVNuBu62z0IYGf7N+JzG5PW5biIvk/L2mx5Wz5e0R3n6ln688Mnm2I0
 HFqwA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 5D2DC4E0BE9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244458-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,enjuk.jp,molgen.mpg.de,kernel.org,linuxfoundation.org,linux.intel.com,acm.org,lists.osuosl.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

Matt Volrath fixes two issues with the i40e driver probe routine, ensuring
that PTP is properly cleaned up if the probe fails.

Emil corrects the initialization of the read_dev_clk_lock spinlock in
idpf_ptp_init, ensuring it is initialized prior to when the
ptp_schedule_worker() is called.

Greg KH fixes a double free and use-after free in the idpf auxiliary device
error paths.

Marcin fixes ice_set_rss_hfunc() to use the correct q_opt_flags field,
correcting the assignment and preventing submission of invalid data to the
firmware.

Bart corrects the locking in ice_dcb_rebuild(), ensuring that the tc_mutex
is held over the entire operation.

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
Changes in v2:
- Dropped patches which had comments from Sashiko pointing out issues that
  need to be addressed.
- Link to v1: https://patch.msgid.link/20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com

---
Bart Van Assche (1):
      ice: fix locking in ice_dcb_rebuild()

Emil Tantilov (1):
      idpf: fix read_dev_clk_lock spinlock init in idpf_ptp_init()

Greg Kroah-Hartman (1):
      idpf: fix double free and use-after-free in aux device error paths

Ivan Vecera (2):
      ice: dpll: fix rclk pin state get for E810
      ice: dpll: fix misplaced header macros

Marcin Szycik (1):
      ice: fix setting RSS VSI hash for E830

Matt Vollrath (2):
      i40e: Cleanup PTP registration on probe failure
      i40e: Cleanup PTP pins on probe failure

 drivers/net/ethernet/intel/i40e/i40e.h       |  1 +
 drivers/net/ethernet/intel/ice/ice_dpll.h    | 32 ++++++++++++++--------------
 drivers/net/ethernet/intel/i40e/i40e_main.c  |  2 ++
 drivers/net/ethernet/intel/i40e/i40e_ptp.c   |  3 ++-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  4 ++--
 drivers/net/ethernet/intel/ice/ice_dpll.c    |  5 +++++
 drivers/net/ethernet/intel/ice/ice_main.c    |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_idc.c   |  6 ++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.c   |  4 ++--
 9 files changed, 37 insertions(+), 22 deletions(-)
---
base-commit: bd3a4795d5744f59a1f485379f1303e5e606f377
change-id: 20260504-jk-iwl-net-2026-05-04-f9526823577f

Best regards,
--  
Jacob Keller <jacob.e.keller@intel.com>


