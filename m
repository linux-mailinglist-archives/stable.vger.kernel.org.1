Return-Path: <stable+bounces-248894-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCvUJmhlB2qE1gIAu9opvQ
	(envelope-from <stable+bounces-248894-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:26:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6C65562C8
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4B7D330117E9
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89C63EEACD;
	Fri, 15 May 2026 18:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZIBoUWx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144D73E16A2;
	Fri, 15 May 2026 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869474; cv=none; b=ZyD+vVL9aMEZUymyEBp+DZSTj738HVlly7V+TfHh4X6ebqdeKfPhdiwHY1EOJD0cH5cDOVlfHnUmRSO3ehxzdBzdVl0XDu4LM9Iitgm/ykPiqMwvir0N02l0YeGs4p7fGT01TWBQymsqPGYZaKYHjDRsMum40I1cLz80bgN1AfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869474; c=relaxed/simple;
	bh=BqF3ekoFBJIxN9w40qQQ+V8dAt8jGYkSVHl6tfrrPM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRDY3ziiBm4AoFU2pmB/Iow7nXY8n21wtJMvMEZLURXID3kD5CqkjSuLgpSEmV+O7G8qbHPzRhwdKvOt3H/xA3D+AjoAwB+sRZIivdN2y24raD0rWm25saPjt1iDBygJ7ShXDLMTi6ibGdUszyrTx4KGSFII+qrRl2XaMCRhK0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PZIBoUWx; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778869473; x=1810405473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BqF3ekoFBJIxN9w40qQQ+V8dAt8jGYkSVHl6tfrrPM8=;
  b=PZIBoUWx8tKBpJo6Db7ogVzGyKQXaiWPfPx4drlZ3XhINTdw6q4sp10l
   MqmLwd7dZfHrrRG0vMJWTDZGghmqlj+ycAnpM4cG2zLKj6N2bly4RoWfG
   QEYblDLxyMNWJlYkpVjfY3bsytwnKyKodGrbmZPpE2n1qPAaK366KU/Gk
   rbTTZsAUTIJuYLUNhtAwCClUGBjYF4TmmDZvFQVwsnkHPkHFOCObU3rK1
   2f0C0KVL3MGoxigCXafgeOpMTbD+PYHarX+7/OdfVD2Xm+FWl1N8caKbU
   nwuD+/XyyjC7DsH5alvFlTWOZtvmd+CPEp6phWI538bCxvr6r0IqRE/hK
   Q==;
X-CSE-ConnectionGUID: TB2alXqGQYKEmwK6zeXQxQ==
X-CSE-MsgGUID: DxUFIMdfQGKBpyOWN4xrbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11787"; a="83701185"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="83701185"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 11:24:27 -0700
X-CSE-ConnectionGUID: Dn+j99agQsKV+sD6RlvQJQ==
X-CSE-MsgGUID: +cH8+Y6nSxOn3cKL/ko18Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="238647460"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 15 May 2026 11:24:27 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kohei Enju <kohei@enjuk.jp>,
	anthony.l.nguyen@intel.com,
	dima.ruinskiy@intel.com,
	faizal.abdul.rahim@linux.intel.com,
	chwee.lin.choong@intel.com,
	kohei.enju@gmail.com,
	vladimir.oltean@nxp.com,
	stable@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net 09/10] igc: fix potential skb leak in igc_fpe_xmit_smd_frame()
Date: Fri, 15 May 2026 11:24:16 -0700
Message-ID: <20260515182419.1597859-10-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260515182419.1597859-1-anthony.l.nguyen@intel.com>
References: <20260515182419.1597859-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5F6C65562C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[enjuk.jp,intel.com,linux.intel.com,gmail.com,nxp.com,vger.kernel.org,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248894-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:mid,intel.com:dkim,enjuk.jp:email]
X-Rspamd-Action: no action

From: Kohei Enju <kohei@enjuk.jp>

When igc_fpe_init_tx_descriptor() fails, no one takes care of an
allocated skb, leaking it. [1]
Use dev_kfree_skb_any() on failure.

Tested on an I226 adapter with the following command, while injecting
faults in igc_fpe_init_tx_descriptor() to trigger the error path.
 # ethtool --set-mm $DEV verify-enabled on tx-enabled on pmac-enabled on

[1]
unreferenced object 0xffff888113c6cdc0 (size 224):
...
  backtrace (crc be3d3fda):
    kmem_cache_alloc_node_noprof+0x3b1/0x410
    __alloc_skb+0xde/0x830
    igc_fpe_xmit_smd_frame.isra.0+0xad/0x1b0
    igc_fpe_send_mpacket+0x37/0x90
    ethtool_mmsv_verify_timer+0x15e/0x300

Cc: stable@vger.kernel.org
Fixes: 5422570c0010 ("igc: add support for frame preemption verification")
Signed-off-by: Kohei Enju <kohei@enjuk.jp>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_tsn.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 725ba253165c..52de2bcbadbe 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -110,10 +110,16 @@ static int igc_fpe_xmit_smd_frame(struct igc_adapter *adapter,
 	__netif_tx_lock(nq, cpu);
 
 	err = igc_fpe_init_tx_descriptor(ring, skb, type);
-	igc_flush_tx_descriptors(ring);
+	if (err)
+		goto err_free_skb_any;
 
+	igc_flush_tx_descriptors(ring);
 	__netif_tx_unlock(nq);
+	return 0;
 
+err_free_skb_any:
+	__netif_tx_unlock(nq);
+	dev_kfree_skb_any(skb);
 	return err;
 }
 
-- 
2.47.1


