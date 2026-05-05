Return-Path: <stable+bounces-243976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOArFTF9+Wmd9AIAu9opvQ
	(envelope-from <stable+bounces-243976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:16:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCDA4C6C4F
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 452AF3016CFD
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31453C942A;
	Tue,  5 May 2026 05:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FSBfMRGb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C973C3451;
	Tue,  5 May 2026 05:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958144; cv=none; b=fDon37VH14JeE1Ck6q4tm0lCbf+SDemutgAxdwUxjsUtjrszPI2twLy7xfR17jpN0fGrA12z47k+uITDutijHzs4ojLrHVyM5ROU0BiRHDGoe1vB+mc4+oDidekz/TYgjuclWEf9vtwjXqp1sFFj7ez5RbGnlanHDl2HdoyDM5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958144; c=relaxed/simple;
	bh=HzqDHv5GyQ8YFNHCJeFh+A7LJbH3jo8Yz39EnQiyG8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dUnf4J2ovsL6C4K4TZJjzN1sQUP8WX4rG/UAtXmo7YxnhiRW3J4KpsvbWrm2i6Ew6hI3wfHymQkyMGvBnuTbZedJ2b4qqD0WpoJcJguwqkBJwpg1RV/biRjLhIEDKoHfsonw+QoM4ft4TO/4pf0mBd6lgNlwRUtKbYugtgqftFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FSBfMRGb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777958143; x=1809494143;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=HzqDHv5GyQ8YFNHCJeFh+A7LJbH3jo8Yz39EnQiyG8w=;
  b=FSBfMRGb9OURtHDlbpAKH4joG1/vYHOsMQXjXak77WF/4lJVs0sMPbtp
   TAyMVJJYo4rjidboFc3qY7yjwoauWYATarDlHCCUlSfb+e9CLZR1ijm++
   xix6AIswABJ4dQ+kkyTzXmgtQ9smxO3MiU6XxeRWsNMXQIDgzN10TZDJV
   o+h+56ujVi5GocV5p5Jw75GiIVEl0Xbwicvdd9Q0064P0NGAmXyPmkkft
   XtFNPZDiL8DryxTJKezsQuLtgR+HUMptWYn5FEI+UY9U4avMmZ1ujIzld
   0EZjmJrHNxjjW/aspKjIHAI7Lrwu8r3/ttjou1G1d/HNJMsYnxiHQmLcR
   w==;
X-CSE-ConnectionGUID: sJF8RFLCRxWCw22iZbD8BQ==
X-CSE-MsgGUID: 3ohtvMhCR86Xs6NiBmIoOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89126477"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="89126477"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:37 -0700
X-CSE-ConnectionGUID: KyrvZNY6RP+HkNCskQOgDQ==
X-CSE-MsgGUID: fmZYR+hzS5SXj5M5BKEnkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="239683511"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:37 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 04 May 2026 22:14:22 -0700
Subject: [PATCH net 09/13] ice: fix setting RSS VSI hash for E830
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-jk-iwl-net-2026-05-04-v1-9-a222a88bd962@intel.com>
References: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
In-Reply-To: <20260504-jk-iwl-net-2026-05-04-v1-0-a222a88bd962@intel.com>
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
 Jacob Keller <jacob.e.keller@intel.com>, 
 Marcin Szycik <marcin.szycik@linux.intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=85wzqrIhQBmJUfp5Rt3p1iNqMva3o4gr8YbSKJCOIfU=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsyfNd+Tt7qe5l9xZJ+egZPksvPGxYe//1KJuLSPq2Cn7
 44fxscndpSyMIhxMciKKbIoOISsvG48IUzrjbMczBxWJpAhDFycAjCRX+8YGVbN53bbcqe4Nf+k
 5sX8PWtWMFR3C33JOn28U3mjzdvblacYGW60e9UcixCee7r5zTI21+Z1cd9mWjFLV+3MY511cd+
 /lxwA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 0BCDA4C6C4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243976-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]

From: Marcin Szycik <marcin.szycik@linux.intel.com>

ice_set_rss_hfunc() performs a VSI update, in which it sets hashing
function, leaving other VSI options unchanged. However, ::q_opt_flags is
mistakenly set to the value of another field, instead of its original
value, probably due to a typo. What happens next is hardware-dependent:

On E810, only the first bit is meaningful (see
ICE_AQ_VSI_Q_OPT_PE_FLTR_EN) and can potentially end up in a different
state than before VSI update.

On E830, some of the remaining bits are not reserved. Setting them
to some unrelated values can cause the firmware to reject the update
because of invalid settings, or worse - succeed.

Reproducer:
  sudo ethtool -X $PF1 equal 8

Output in dmesg:
  Failed to configure RSS hash for VSI 6, error -5

Fixes: 352e9bf23813 ("ice: enable symmetric-xor RSS for Toeplitz hash function")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 1d1947a7fe11..c52c465280f7 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -8046,7 +8046,7 @@ int ice_set_rss_hfunc(struct ice_vsi *vsi, u8 hfunc)
 	ctx->info.q_opt_rss |=
 		FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_HASH_M, hfunc);
 	ctx->info.q_opt_tc = vsi->info.q_opt_tc;
-	ctx->info.q_opt_flags = vsi->info.q_opt_rss;
+	ctx->info.q_opt_flags = vsi->info.q_opt_flags;
 
 	err = ice_update_vsi(hw, vsi->idx, ctx, NULL);
 	if (err) {

-- 
2.54.0.rc2.531.gaf818d63126a


