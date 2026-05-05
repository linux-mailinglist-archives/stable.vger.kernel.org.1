Return-Path: <stable+bounces-243968-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIZjNQh9+WmZ9AIAu9opvQ
	(envelope-from <stable+bounces-243968-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:15:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D60EC4C6C05
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99269300B2A3
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5947F3BF66E;
	Tue,  5 May 2026 05:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Og7ch+CY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D677C7080D;
	Tue,  5 May 2026 05:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958140; cv=none; b=gJyo2xcXs1GOfyxLDrXG56m8M6p7OcnUvwArs72FSbBru3D7deGv5m3v4IDC+vqo9IBcZ2IDxTp3/oUIj6NOO2AmzDRCJKpyIRw/J8o+oHjFjnd67dkGpYf1A/q8iW10mzYj98n66B5/Agl45Oduy4DvXpXFuSKRBTzJNox09qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958140; c=relaxed/simple;
	bh=ob1X8nCFLPRf4FRzN9Zz0NTmNZcu96QLzNaHHKGCjuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iV51mfsUXkehx3REPCJs48pVm2MuDSG+sap2qb2Go++ijkfUe4s6JkaRyFfOFCccqquSTkM+X0guZH9kEIKfGPcAFHe+7o/hSwsJlLqazaNFqndhJo9yt/lF161e8t5s7pND3QbVtiWwq2CpW8pBeXCRVZa1G2AWn1eoFiZ2t/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Og7ch+CY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777958139; x=1809494139;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=ob1X8nCFLPRf4FRzN9Zz0NTmNZcu96QLzNaHHKGCjuo=;
  b=Og7ch+CYv80yI+tNMMXIVjFPkbg5ywiW3F0v5stLkEDKNyY94DxrC8n1
   zvXVOVvlGaG4oliAynAPdg+LJ8BmYD3k2belrUYLkYdrgfGzae3/O6h4A
   SyjgZbWLvy8zUpym9GstIsx5ybBCLGgQ6Y6ZPB3N9KWNseoktJiOUYnV3
   KD82HaV5U+LCGV6KSVWyXBc/k09naBcxB7zBXEOefXwA6qGjio+L4+mJ0
   azImVvu6poppSPnebbaqE4RcMAcE6GTwpKT0ZKwAoiFvFnFFQa8XjkKIl
   DmiMGAuNpZylQCwQAaqnhWq3sUSBK5TdqIxzHtJ6qknfmes6dgIoN7VsR
   Q==;
X-CSE-ConnectionGUID: z30FswiwRSm+4e/BRSEP+g==
X-CSE-MsgGUID: CXiTHywBSmGZq2vCrNf6Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89126424"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="89126424"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:36 -0700
X-CSE-ConnectionGUID: 2Ib9ludsRbea2IlPLy3aMA==
X-CSE-MsgGUID: y+k7G6h3SeeptZ2vFkiAFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="239683485"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:37 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 04 May 2026 22:14:14 -0700
Subject: [PATCH net 01/13] i40e: Cleanup PTP registration on probe failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-jk-iwl-net-2026-05-04-v1-1-a222a88bd962@intel.com>
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
 Jacob Keller <jacob.e.keller@intel.com>, Matt Vollrath <tactii@gmail.com>, 
 Sunitha Mekala <sunithax.d.mekala@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1398;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=6MleHBUaKVBJO4/IO4371Nsx8MRGX7ndbp+JiqdK0aw=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsyfNV+P7nsSfMBgS4iQZmW3UdD90/cWaS50st/43nH67
 K+LTmzS6ihlYRDjYpAVU2RRcAhZed14QpjWG2c5mDmsTCBDGLg4BWAiLNsZ/lnNZBZodrm/UMn5
 d3ufxcaF+1bPEVyYLyd6Y04jB+P5y3sZGR6XvTxj2W3I2XHhdfZrR4/wiQdzqicrF87VT9tx5XN
 AOysA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: D60EC4C6C05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243968-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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


