Return-Path: <stable+bounces-244457-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJ/7Fma3+2njDgAAu9opvQ
	(envelope-from <stable+bounces-244457-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:49:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 601724E0BA2
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0CF523009E14
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 21:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429973B3BF7;
	Wed,  6 May 2026 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k3/UnXcf"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B4231F9B5;
	Wed,  6 May 2026 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104161; cv=none; b=ciM+EUCvF22a8ZbqmMfAhbUx5x901hpTXSMOcv4Lyfw1p6HPlGt/Qu/gnp3r6jbaBCpPCsd6L1f8XZ0YwMK9ZtyQDHSN0YbAwZt3Inzu/0rh7jPNVaC4yvKm5Q73RpZlZmYHE4uU3zdROuxv0d6Eok4vJNX4MtBXapOBix8K1lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104161; c=relaxed/simple;
	bh=ob1X8nCFLPRf4FRzN9Zz0NTmNZcu96QLzNaHHKGCjuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O5U+lciUBghvP4yg7wsaMCw1AXo2/Ztt89FMV1PLDDuZfJjeDxtjBk03Dxx7LkjHzr2bf6Tsv8PYQTgAzy5x9K4OG+hNCqSu4eKYBVszLZfsIZD0U9kupIKmxDH2v2zbRWiLiH5GEFU+tm2E+AOkaDuSMAax668Dyh7+AZsg8NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k3/UnXcf; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778104159; x=1809640159;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ob1X8nCFLPRf4FRzN9Zz0NTmNZcu96QLzNaHHKGCjuo=;
  b=k3/UnXcfkgQTFkLUujIaE6U7Qa37mLHi+fbG+oD3yFlLVEaqyTI7F3R3
   9V64tIq/71kmdVVtLnOcg+R94wTK0u4RDJC2c3xDG3fZQrx/mnWKbzCMx
   /3Y4Ex2HSiWK2rF0PSDB/H+JfO8MJw9n5kMycEei6oCNyRp1KUsDwaFSU
   LzPAMDWN6rQw2nvNz+TJTPzT1vMug/9m1GrROGxzyf4NooZpCYKxI/ffc
   SJeR6TL6/jQfAJ0dfIMvSJXt9GfUr1SMVGJhDCsV6OCCyqa4WtV9IsvsP
   PUN5T1CRJJbKmgLLkiy9me1uY4gibcpU0sN9fTX2IZmOw0CW0a4+eMa04
   A==;
X-CSE-ConnectionGUID: QlTVPpppRsO/I5uIV8r0zw==
X-CSE-MsgGUID: qdo4efxBR6y1CmWoncZb2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78982486"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="78982486"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:49:18 -0700
X-CSE-ConnectionGUID: t9IEsoQoRJa8/S2UgvTJ9A==
X-CSE-MsgGUID: WocflSasQFaaV7MsfOW+bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="259698609"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:49:18 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 06 May 2026 14:48:10 -0700
Subject: [PATCH net v2 1/8] i40e: Cleanup PTP registration on probe failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-jk-iwl-net-2026-05-04-v2-1-a5ea4dc837a9@intel.com>
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
 Sunitha Mekala <sunithax.d.mekala@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1398;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=6MleHBUaKVBJO4/IO4371Nsx8MRGX7ndbp+JiqdK0aw=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhszf26Nl/nz2XG4yQ54zf9aMiedbn/ZdnbT9iTzz263++
 fNfcdy82VHKwiDGxSArpsii4BCy8rrxhDCtN85yMHNYmUCGMHBxCsBEPkxh+MOzN61W7pi+wpnd
 HowpvMtfF7GvVmYrYQtJr7L9/ae8J4iR4e3jOfOzbjV5Oguyim/lnrV8RXT3gphbNXWOb/d31cU
 cYgUA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 601724E0BA2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244457-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Action: no action

From: Matt Vollrath <tactii@gmail.com>

Fix two conditions which would leak PTP registration on probe failure:

1. i40e_setup_pf_switch can encounter an error in
   i40e_setup_pf_filter_control, call i40e_ptp_init, then return
   non-zero, sending i40e_probe to err_vsis.

2. i40e_setup_misc_vector can return non-zero, sending i40e_probe to
   err_vsis.

Both of these conditions have been present since PTP was introduced in
this driver.

Found with coccinelle.

Fixes: beb0dff1251db ("i40e: enable PTP")
Signed-off-by: Matt Vollrath <tactii@gmail.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 028bd500603a..f06fcef644e5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -16108,6 +16108,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Unwind what we've done if something failed in the setup */
 err_vsis:
 	set_bit(__I40E_DOWN, pf->state);
+	i40e_ptp_stop(pf);
 	i40e_clear_interrupt_scheme(pf);
 	kfree(pf->vsi);
 err_switch_setup:

-- 
2.54.0.rc2.531.gaf818d63126a


