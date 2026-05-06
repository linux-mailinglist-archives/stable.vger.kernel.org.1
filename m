Return-Path: <stable+bounces-244460-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENnbHLK3+2njDgAAu9opvQ
	(envelope-from <stable+bounces-244460-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:50:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E0A4E0BFF
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5B0F301FFAA
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 21:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2296F3B47CF;
	Wed,  6 May 2026 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ITiipXyx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542E53B3C08;
	Wed,  6 May 2026 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104162; cv=none; b=GQkDK2IaxFuPXGhIdzd+lFHkCslzGm6ZN75vs1+WlkejGLCp1eU6r3n47YMP8kXLiaa+OvxkeWczIf0JubXpHdTLEp5sPmjnfa2qhcKdDWGYJnlG5XzyHQgdYPN013wcZYgEEXrVib/oP9zdhcH+6fUer7sBkB4tTtroDoreRkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104162; c=relaxed/simple;
	bh=wY+GZStVgveeM4dDJUttYbOKSr5LYkYnE1B29ZaMNt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ey6R+uDVM90kc4LCFjXDOe+ZsNTqms+V6UtK/EQdfWIgfTjJmWuZJi1CIwhcMWBdPrnIMg3ElKgXriOISu7rE2PGioJwhhRbg9WggFz1IUo6FJmRtON2I7Mhyom0D5T494s1NEYDLy227tGmUqZssL5F8q7cN7LWM6tzw9qyd4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ITiipXyx; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778104161; x=1809640161;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wY+GZStVgveeM4dDJUttYbOKSr5LYkYnE1B29ZaMNt0=;
  b=ITiipXyx0hM7LvPwIGF67wzcylvtWNBBLT6ANY2wZAGGCPF+6flqi9Yr
   aoyNSFGM7e8m1mEurfmPSt6bfcTDJ92GXPO9nmrlpNxkMPjxcmUeGf7Uj
   HkdU0+7fhQsgqYM0VZoYS7RvySVVlcQbpsXUYB3hGLqKOBotNQ7UySRhj
   GlaCfI0ikg+wFwa5WnzAfsETAJt9Oby4WHQOuFNqmC9RwjYX148rAuA79
   P4pohdVYr6aTN4mEup4pZcF5oFk9mDqPsSqWduFTQkZMlgPQi4hII9cM8
   6rwyKzy5WjhtDpNLqjzlu8In7KRoSomMK6ky2nF4wYPHR7ZTbu4DDiE7F
   Q==;
X-CSE-ConnectionGUID: i+zugux+Tq+PLJnw3DGDnA==
X-CSE-MsgGUID: /SCCh/FjSmiMDUs13Iaebw==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78982494"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="78982494"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:49:19 -0700
X-CSE-ConnectionGUID: sthBe0vFTo+osdqAbOzg3A==
X-CSE-MsgGUID: B4GnvSXCRBiOlCmE7f9BTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="259698612"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:49:18 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 06 May 2026 14:48:11 -0700
Subject: [PATCH net v2 2/8] i40e: Cleanup PTP pins on probe failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-jk-iwl-net-2026-05-04-v2-2-a5ea4dc837a9@intel.com>
References: <20260506-jk-iwl-net-2026-05-04-v2-0-a5ea4dc837a9@intel.com>
In-Reply-To: <20260506-jk-iwl-net-2026-05-04-v2-0-a5ea4dc837a9@intel.com>
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
 Kohei Enju <kohei@enjuk.jp>, Paul Menzel <pmenzel@molgen.mpg.de>, 
 Sunitha Mekala <sunithax.d.mekala@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2912;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=QNjr6uUakcnLHlPppRVsn2hnfyH4eY5JOQgkwstJsQg=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhszf26MdIv/u+RWdt2qV5cFrD2+WaJY6r5m0s6Fg1slXV
 w1/3f2t1VHKwiDGxSArpsii4BCy8rrxhDCtN85yMHNYmUCGMHBxCsBE/qQzMhzt9jj+sLJDNe/U
 nY0XJ0xhMeTsitjYZMc2Qa1/gjKL7HtGht5ni1+3BLTccgz95vo9QqnqsObaHfmrtzXty2w0n6x
 rzAYA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 13E0A4E0BFF
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
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244460-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,enjuk.jp,molgen.mpg.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim,enjuk.jp:email]
X-Rspamd-Action: no action

From: Matt Vollrath <tactii@gmail.com>

PTP pin structs are allocated early in probe, but never cleaned up.

Fix this by calling i40e_ptp_free_pins in the error path.

To support this, i40e_ptp_free_pins is added to the header and
pin_config is correctly nullified after being freed.

This has been an issue since i40e_ptp_alloc_pins was introduced.

Fixes: 1050713026a08 ("i40e: add support for PTP external synchronization clock")
Reported-by: Kohei Enju <kohei@enjuk.jp>
Cc: stable@vger.kernel.org
Signed-off-by: Matt Vollrath <tactii@gmail.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Kohei Enju <kohei@enjuk.jp>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 1 +
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
 drivers/net/ethernet/intel/i40e/i40e_ptp.c  | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index dcb50c2e1aa2..83e780919ac9 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1318,6 +1318,7 @@ void i40e_ptp_restore_hw_time(struct i40e_pf *pf);
 void i40e_ptp_init(struct i40e_pf *pf);
 void i40e_ptp_stop(struct i40e_pf *pf);
 int i40e_ptp_alloc_pins(struct i40e_pf *pf);
+void i40e_ptp_free_pins(struct i40e_pf *pf);
 int i40e_update_adq_vsi_queues(struct i40e_vsi *vsi, int vsi_offset);
 int i40e_is_vsi_uplink_mode_veb(struct i40e_vsi *vsi);
 int i40e_get_partition_bw_setting(struct i40e_pf *pf);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index f06fcef644e5..6d4f9218dc68 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16112,6 +16112,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	i40e_clear_interrupt_scheme(pf);
 	kfree(pf->vsi);
 err_switch_setup:
+	i40e_ptp_free_pins(pf);
 	i40e_reset_interrupt_capability(pf);
 	timer_shutdown_sync(&pf->service_timer);
 err_mac_addr:
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index 404a716db8da..7d07c389bb23 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -940,12 +940,13 @@ int i40e_ptp_hwtstamp_get(struct net_device *netdev,
  *
  * Release memory allocated for PTP pins.
  **/
-static void i40e_ptp_free_pins(struct i40e_pf *pf)
+void i40e_ptp_free_pins(struct i40e_pf *pf)
 {
 	if (i40e_is_ptp_pin_dev(&pf->hw)) {
 		kfree(pf->ptp_pins);
 		kfree(pf->ptp_caps.pin_config);
 		pf->ptp_pins = NULL;
+		pf->ptp_caps.pin_config = NULL;
 	}
 }
 

-- 
2.54.0.rc2.531.gaf818d63126a


