Return-Path: <stable+bounces-244462-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGrRFvC3+2kXDwAAu9opvQ
	(envelope-from <stable+bounces-244462-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:51:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 066214E0C51
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1528A3021717
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 21:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E13F3B27F7;
	Wed,  6 May 2026 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J3girCCN"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FB03B3C00;
	Wed,  6 May 2026 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104164; cv=none; b=K0ieGSgKC6PRduhqUw+w98u8v2OwvThWJRrYlXHPCHryPBhcsUrKyZTrlZW0NfL29Rz+2VuB7TMJi6YgXNQfQnHwTfxiCymewJBlceQyDjAMwR+oP4xfXNCQLgvftkfo2xNXCVySo4GPEGNkGPDvt0DGJ2LQ7PAzkn7UKHK7PQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104164; c=relaxed/simple;
	bh=HzqDHv5GyQ8YFNHCJeFh+A7LJbH3jo8Yz39EnQiyG8w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B8UxhF3nIiXXbAuw4EvAZgYbJ6s8cpbM7KGfOfs7hEbbegM9N3boV6C9lU0JNC+ctDgJaNudbmGUgnZUP7En0l2Z8p8F9/xjF02jW+4cRLxNEUsI611P8i5ax3SdEDq6gZODM/mg4fJvn/vVoqIdXMfadNyRCMIw3kpSYPZuL+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J3girCCN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778104163; x=1809640163;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=HzqDHv5GyQ8YFNHCJeFh+A7LJbH3jo8Yz39EnQiyG8w=;
  b=J3girCCN0hImcz6gmgQFk5s6AmatoBu5ZAlwW4pAtWSnI9Woq9IIi70C
   D0SNLdmgEK8h3otctKWOmRxtUXCe8ib0EnjgnHbzhE2j7SLnhYa7ZhmVB
   KnXxt22PmJY7qQQuKGOc0nuZCjWMy7gU6MmKSvnfjcVivSGPIshFy4Hvk
   sI6jk/aBnWS2jqvkFAoDrxzuMddzJs5yE41z6+f6t3Ha22cFdxerM6E9v
   oKDiobw3/E2KOcLzBsnjfrXHksUVziucsmhTqGyrsv1pjIFsNE6dwTtCS
   fNrZTuItaj7iQl0rn7r41pVcIv3ElW6vIfAN3uuYkmrBpSJMLRdqyK827
   g==;
X-CSE-ConnectionGUID: 9iEOYUC+SXiMcF4yDd8SWQ==
X-CSE-MsgGUID: 8oq88OY1RomErszJ15csHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78982520"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="78982520"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:49:20 -0700
X-CSE-ConnectionGUID: 94N/qIOHQz6Pi9rhxs2QSQ==
X-CSE-MsgGUID: 60dF3IrGQ0mL8WCU2luIYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="259698627"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:49:19 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 06 May 2026 14:48:14 -0700
Subject: [PATCH net v2 5/8] ice: fix setting RSS VSI hash for E830
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-jk-iwl-net-2026-05-04-v2-5-a5ea4dc837a9@intel.com>
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
 Jacob Keller <jacob.e.keller@intel.com>, 
 Marcin Szycik <marcin.szycik@linux.intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=85wzqrIhQBmJUfp5Rt3p1iNqMva3o4gr8YbSKJCOIfU=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhszf22Pa5NYcXHXhAKN4eNe32AJmZhP+Eia56vIKuT0fo
 5rXyNzpKGVhEONikBVTZFFwCFl53XhCmNYbZzmYOaxMIEMYuDgFYCL54Qz/dKvmrlUwVP53VvXe
 odZEeZaTTLcVb/pGvPaZcXbz/LtC8xn+VyYu+ViltCSPu0r1zEVWu3ff45yq/CckH4rPaOxo+aj
 JAgA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 066214E0C51
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244462-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

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


