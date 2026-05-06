Return-Path: <stable+bounces-244464-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OxvKf23+2kXDwAAu9opvQ
	(envelope-from <stable+bounces-244464-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:51:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1D84E0C87
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4B2330214D0
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 21:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B054E3B4E84;
	Wed,  6 May 2026 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HHLan1oc"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2999C3B3C15;
	Wed,  6 May 2026 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104164; cv=none; b=iP4PdTYKm2DrVTgGVWyN3hVJ2zZ1ynHKFGK7XQlzIdtLBMPVWpQy96w8GclboGnnbQuN5dMpXyoXbt7Ve6dOPQB6svHulgy9SrrD6Lu2nXzGqID26HtCiDBTRSiBsx4Ei/G6PDouY2MTqviYdllFtGeAulFvtsujYd1mQrYJwys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104164; c=relaxed/simple;
	bh=Dph0JQ+anecb94Vp28WBMuX6Fyz0CvXzNpx9y7OL+5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ibruk1Sk/EiHRTZIntsVsd8ZedqtuzgsmUSWgBZ9GhsOyX1G6KbcylgWDDCFS+oSJyaxH34Vthx2ec1qGD5TYyaIHh0b93mW4XRTf4HPXgEK/b27GTeHjeh2rIYM1BnSKqSXKw8ItTjYBud6z9Bhl6dmTKQ6KS8SBeS+g9eges4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HHLan1oc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778104163; x=1809640163;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Dph0JQ+anecb94Vp28WBMuX6Fyz0CvXzNpx9y7OL+5s=;
  b=HHLan1ocNA8IvoBCm/3Uui/uZZAhMDQtHMMWXIRu/hpZT+A15/OZ3B1p
   HnetMYhE62YtYRN01T7wJ1eXyvwiCq4t0C4XZYDa6UmdKfLixQvp/WKRp
   kKsXMBOrIVWwzpr1808sT8EocxYn9cZY0SLsV3IbBLvZGgxY1WPA2POeK
   PTr1o1ES3c1GppXyfsMiGKkV6nsvCC5zwHNcl3TIJ08BmGNHQlOFrBMXT
   uJkw9cWORxl2gmTbV6RoykxP+Um+MCQy8mF+jGhDyOLXQTpvYWZaJ3ftA
   uPzPELZopMwNj1Ixtiypj41gR53faRJ74HtSRL+PFvauWLrOGGzb6UaAd
   A==;
X-CSE-ConnectionGUID: bmqAeMbsSXS59SFwwdfC2Q==
X-CSE-MsgGUID: 2SZ4P+YwSiKct3Muk+yRtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78982535"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="78982535"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:49:21 -0700
X-CSE-ConnectionGUID: 1QHCkcPNSeGXqn/E1sh7nA==
X-CSE-MsgGUID: AvxQitfnRnq5rDTrv9Lqdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="259698634"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:49:20 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 06 May 2026 14:48:16 -0700
Subject: [PATCH net v2 7/8] ice: dpll: fix rclk pin state get for E810
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-jk-iwl-net-2026-05-04-v2-7-a5ea4dc837a9@intel.com>
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
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2036;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=ms7PFgLEc+jny3dlilGgZtwU2AkyADtgLa4SrZzp5BA=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhszf22PvvswwuOmjrhC+4kizkpalpfyHspMZKTlLDxhdd
 9guud2oo5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgImYZDMy3H4Ys/tXkfGX/qUc
 i6qOh7etv7L3Qeeh/Ws+xxfsyDDU52Vk+GF/z2ivj9zUdfO+HNta923jc1Xusuv2cwL6Q4MXVp3
 R4AAA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 4A1D84E0C87
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244464-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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

From: Ivan Vecera <ivecera@redhat.com>

The refactoring of ice_dpll_rclk_state_on_pin_get() to use
ice_dpll_pin_get_parent_idx() omitted the base_rclk_idx adjustment that was
correctly added in the ice_dpll_rclk_state_on_pin_set() path. This breaks
E810 devices where base_rclk_idx is non-zero, causing the wrong hardware
index to be used for pin state lookup and incorrect recovered clock state
to be reported via the DPLL subsystem. E825C is unaffected as its
base_rclk_idx is 0.

While at it, add bounds check against ICE_DPLL_RCLK_NUM_MAX on hw_idx after
the base_rclk_idx subtraction in both ice_dpll_rclk_state_on_pin_{get,set}()
to prevent out-of-bounds access on the pin state array.

Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index 27b460926bac..892bc7c2e28b 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -2523,6 +2523,8 @@ ice_dpll_rclk_state_on_pin_set(const struct dpll_pin *pin, void *pin_priv,
 	if (hw_idx < 0)
 		goto unlock;
 	hw_idx -= pf->dplls.base_rclk_idx;
+	if (hw_idx >= ICE_DPLL_RCLK_NUM_MAX)
+		goto unlock;
 
 	if ((enable && p->state[hw_idx] == DPLL_PIN_STATE_CONNECTED) ||
 	    (!enable && p->state[hw_idx] == DPLL_PIN_STATE_DISCONNECTED)) {
@@ -2586,6 +2588,9 @@ ice_dpll_rclk_state_on_pin_get(const struct dpll_pin *pin, void *pin_priv,
 	hw_idx = ice_dpll_pin_get_parent_idx(p, parent_pin);
 	if (hw_idx < 0)
 		goto unlock;
+	hw_idx -= pf->dplls.base_rclk_idx;
+	if (hw_idx >= ICE_DPLL_RCLK_NUM_MAX)
+		goto unlock;
 
 	ret = ice_dpll_pin_state_update(pf, p, ICE_DPLL_PIN_TYPE_RCLK_INPUT,
 					extack);

-- 
2.54.0.rc2.531.gaf818d63126a


