Return-Path: <stable+bounces-243978-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BWPCMt9+WmZ9AIAu9opvQ
	(envelope-from <stable+bounces-243978-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:19:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C28724C6CFC
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78BD53059782
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31BE3CB2D7;
	Tue,  5 May 2026 05:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m7/F84I+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E33C6A27;
	Tue,  5 May 2026 05:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958146; cv=none; b=DZRgc5XNf+hF611wdVVzHkTZ7g3b1btGHOJ7hkk7t57C1LRRV2AGEXW4nqqFk6OKJB/iMQjhbZIRAENc6MwcN7I8ikxY2q3gAxe/D6nGYFVvHZMkQtBXKpjnQNNC2x6DeyvUxt4kWTSw6Nr63thUsPRUlX3fx4/KEMlnFNQ+p48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958146; c=relaxed/simple;
	bh=Dph0JQ+anecb94Vp28WBMuX6Fyz0CvXzNpx9y7OL+5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j6Pzp3RRjvyNKfMjotAwQKSGp/cwbEB9ptvxrSolCHmg5YvztmbIYA4grTKYtI4XWjiSCqowGnP63lZq2M6psYWF2PAkls9bopFzZjWlS6Sb6Ra4yJshTMqCQUqBvzq8QRVLKQ4BBnDUiVAs3ipNBSXn5XJHs+v68p94nEcmUM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m7/F84I+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777958144; x=1809494144;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Dph0JQ+anecb94Vp28WBMuX6Fyz0CvXzNpx9y7OL+5s=;
  b=m7/F84I+qYa3HF99Rap3jbUtvx5XMryQ3sL32zXny2E+DyY2bQ2F0k/t
   QcrpjLXVLDA8kQXosT3qwNOyl1eQpws8BElU+FsrgsMWH1du0aSKzvAkn
   3SaFK6iPAgHjT+F/1iVTVBHX/i9gtwEE6MqILBNlzr4MRt3Ln7Xcr/XJk
   1eXjv2pg3m+kKQtxiOPaWrCnuvatxhS/ZCg/g8WoIUeqhIBMtbMaKaNaX
   3gj0UoH5Kj5b6c2mY+ZaicP6sXOyAGAuE2ul2tWtKnUDunFJZrMcx6zBM
   EdEhF0OUl+EVpiQTQvdPUXEOqbfV3mzJ+oc8550cQVN797O5itKd3I2hA
   g==;
X-CSE-ConnectionGUID: jtzHx5alSo6DTN0+VkaVMg==
X-CSE-MsgGUID: C8I13dHHQee4H5vlf3g6kQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89126494"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="89126494"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:38 -0700
X-CSE-ConnectionGUID: y1UgR6pmREWbDoKh2XFK7g==
X-CSE-MsgGUID: MzembMjaS3GrF4JlXAAPng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="239683523"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:38 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 04 May 2026 22:14:25 -0700
Subject: [PATCH net 12/13] ice: dpll: fix rclk pin state get for E810
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-jk-iwl-net-2026-05-04-v1-12-a222a88bd962@intel.com>
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
 Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2036;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=ms7PFgLEc+jny3dlilGgZtwU2AkyADtgLa4SrZzp5BA=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsyfNT/kzOYa1J1ru+nV6jl3CiPDMamwtetWTC9qWlL00
 Nls9jmXjlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACaS28PIcHSLT5Wx16b5eW7v
 qhZPqJHOMs9WfD/9/iZdo0cRMTGfBBj+x398KHP0YMXDly5B319lfZvXmW7m4Ww7V3CX3c2Er7f
 luAE=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: C28724C6CFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243978-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]

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


