Return-Path: <stable+bounces-243971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EPxAhV9+Wmc9AIAu9opvQ
	(envelope-from <stable+bounces-243971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:16:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A98C4C6C1B
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 70C653010BF9
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E982D6409;
	Tue,  5 May 2026 05:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SrOVUbVD"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD043BED76;
	Tue,  5 May 2026 05:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958142; cv=none; b=ohh5M4WLGmrh157JBHLmOxJePu96TFvQ0FcvFKGgFovVFdYavW7mkbdHQCeRMGDp6v71sokXKtLVcs9fbaT4UDiz7gSOBIexnk6zrUNSDLmL1SZWXpKZwo9FFF0WRExN2A4EvWb3GnGc5B4HGjzIy5iC/OuMISBKoK55MeamaKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958142; c=relaxed/simple;
	bh=2RAQOzfBA0zgBDZbbDcF/c5M7cBlO2nDpz2w7IIAO0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cYWOH8eyC9X8NLnb2mWa3KOYrwL1+bCvFcQJPhbC+dZmlXL/a3q+uUfDgJUDwo7A5a3nkg1zxkjXCdQX9SVdMBYUTPhlYqRsreJz/npgrPGYmmsabm5sy41/DfBREE9EX4upmIwPfHLbGTCmWmdXi1B/WV5paZ7So+RKyDOZGHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SrOVUbVD; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777958140; x=1809494140;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=2RAQOzfBA0zgBDZbbDcF/c5M7cBlO2nDpz2w7IIAO0Q=;
  b=SrOVUbVDV4Lkm8V7yhhYCWMqKISYo3bnVwLewEAFk2Vt7XdnZp/VBPf8
   9nJc2khK8hdBPEVY+2YFVcxTmY+Y4cKKPah7xwA1ayVPmTuTj4Eqvj3UD
   I2gaaPb/y+X7rcwxjbliWe0ofEQD9T0cd2qW3e9RX2RedsqvwxWLscY0T
   w9uELTQtR43Op04MyHqL4i8ROEfjOaZRPZ/YFvZsV06aRtmDE37Xx3Onc
   nS4HsBc5DMOTFgiikO8SbfyG8RueXDLbV8c7CSEDsUHAo2QU+f3FzTS41
   YpQObShP9HB9k8oAQLXfFEcMvJWp0NJDSZtHKddj+Z34kz5H1rsYMc4Wx
   A==;
X-CSE-ConnectionGUID: 0Jt83cjCRiiOs0pC9PZyZA==
X-CSE-MsgGUID: qGjldlpXSNCHoApo7Q8q6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89126440"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="89126440"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:37 -0700
X-CSE-ConnectionGUID: IktRf72RTFO+s7255LmaZw==
X-CSE-MsgGUID: +wb1sHZRSYOhfStus+MRWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="239683492"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:37 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 04 May 2026 22:14:16 -0700
Subject: [PATCH net 03/13] i40e: keep q_vectors array in sync with channel
 count changes
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-jk-iwl-net-2026-05-04-v1-3-a222a88bd962@intel.com>
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
 Jacob Keller <jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>, 
 Sunitha Mekala <sunithax.d.mekala@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=6179;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=y+p65c3AnLtKBnDATGZ7Yumqax1fuJVkq4ufixTwyqg=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsyfNV9tTRpy9j6frC674bvfzNMCH6e/rX35yDHlptDMg
 4anFIoud5SyMIhxMciKKbIoOISsvG48IUzrjbMczBxWJpAhDFycAjCR428ZGdreMz+xuDehrJwx
 vNqt7ptxnXK5X+CLxcGZZz9osj675Mbwh9N3pvlsnd6ArZ2MzJd4zu+a763mcKSWSyZK+37098B
 VPAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 9A98C4C6C1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-243971-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid,napi_threaded.py:url]

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

For the main VSI, i40e_set_num_rings_in_vsi() always derives
num_q_vectors from pf->num_lan_msix. At the same time, ethtool -L stores
the user requested channel count in vsi->req_queue_pairs and the queue
setup path uses that value for the effective number of queue pairs.

This leaves queue and vector counts out of sync after shrinking channel
count via ethtool -L. The active queue configuration is reduced, but the
VSI still keeps the full PF-sized q_vector topology.

That mismatch breaks reconfiguration flows which rely on vector/NAPI
state matching the effective channel configuration. In particular,
toggling /sys/class/net/<dev>/threaded after reducing the channel count
can hang, and later channel-count changes can fail because VSI reinit
does not rebuild q_vectors to match the new vector count.

Fix this by making the main VSI num_q_vectors follow the effective
requested channel count, capped by the available MSI-X vectors. Update
i40e_vsi_reinit_setup() to rebuild q_vectors during VSI reinit so the
vector topology is refreshed together with the ring arrays when channel
count changes.

Keep alloc_queue_pairs unchanged and based on pf->num_lan_qps so the VSI
retains its full queue capacity.

Selftest napi_threaded.py was originally used when Jakub reported hang
on /sys/class/net/<dev>/threaded toggle. In order to make it pass on
i40e, use persistent NAPI configuration for q_vector NAPIs so NAPI
identity and threaded settings survive q_vector reallocation across
channel-count changes. This is achieved by using netif_napi_add_config()
when configuring q_vectors.

$ export NETIF=ens259f1np1
$ sudo -E env PATH="$PATH" ./tools/testing/selftests/drivers/net/napi_threaded.py
TAP version 13
1..3
ok 1 napi_threaded.napi_init
ok 2 napi_threaded.change_num_queues
ok 3 napi_threaded.enable_dev_threaded_disable_napi_threaded
Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

[Jake: use min() and clamp() as suggested by Simon on Intel Wired LAN]

Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/intel-wired-lan/20260316133100.6054a11f@kernel.org/
Fixes: d2a69fefd756 ("i40e: Fix changing previously set num_queue_pairs for PFs")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 34 ++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 6d4f9218dc68..23156015ed86 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -11403,10 +11403,14 @@ static void i40e_service_timer(struct timer_list *t)
 static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
 {
 	struct i40e_pf *pf = vsi->back;
+	u16 qps;
 
 	switch (vsi->type) {
 	case I40E_VSI_MAIN:
 		vsi->alloc_queue_pairs = pf->num_lan_qps;
+		qps = vsi->req_queue_pairs ?
+		      min(vsi->req_queue_pairs, pf->num_lan_qps) :
+		      pf->num_lan_qps;
 		if (!vsi->num_tx_desc)
 			vsi->num_tx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
 						 I40E_REQ_DESCRIPTOR_MULTIPLE);
@@ -11414,7 +11418,7 @@ static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
 			vsi->num_rx_desc = ALIGN(I40E_DEFAULT_NUM_DESCRIPTORS,
 						 I40E_REQ_DESCRIPTOR_MULTIPLE);
 		if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags))
-			vsi->num_q_vectors = pf->num_lan_msix;
+			vsi->num_q_vectors = clamp(qps, 1, pf->num_lan_msix);
 		else
 			vsi->num_q_vectors = 1;
 
@@ -11503,6 +11507,7 @@ static int i40e_vsi_alloc_arrays(struct i40e_vsi *vsi, bool alloc_qvectors)
 
 err_vectors:
 	kfree(vsi->tx_rings);
+	vsi->tx_rings = NULL;
 	return ret;
 }
 
@@ -12043,7 +12048,8 @@ static int i40e_vsi_alloc_q_vector(struct i40e_vsi *vsi, int v_idx)
 	cpumask_copy(&q_vector->affinity_mask, cpu_possible_mask);
 
 	if (vsi->netdev)
-		netif_napi_add(vsi->netdev, &q_vector->napi, i40e_napi_poll);
+		netif_napi_add_config(vsi->netdev, &q_vector->napi,
+				      i40e_napi_poll, v_idx);
 
 	/* tie q_vector and vsi together */
 	vsi->q_vectors[v_idx] = q_vector;
@@ -14264,12 +14270,27 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 
 	pf = vsi->back;
 
+	if (test_bit(I40E_FLAG_MSIX_ENA, pf->flags)) {
+		i40e_put_lump(pf->irq_pile, vsi->base_vector, vsi->idx);
+		vsi->base_vector = 0;
+	}
+
 	i40e_put_lump(pf->qp_pile, vsi->base_queue, vsi->idx);
 	i40e_vsi_clear_rings(vsi);
 
-	i40e_vsi_free_arrays(vsi, false);
+	i40e_vsi_free_q_vectors(vsi);
+	i40e_vsi_free_arrays(vsi, true);
 	i40e_set_num_rings_in_vsi(vsi);
-	ret = i40e_vsi_alloc_arrays(vsi, false);
+
+	ret = i40e_vsi_alloc_arrays(vsi, true);
+	if (ret)
+		goto err_vsi;
+
+	/* Rebuild q_vectors during VSI reinit because the effective channel
+	 * count may change num_q_vectors. Keep vector topology aligned with the
+	 * queue configuration after ethtool's .set_channels() callback.
+	 */
+	ret = i40e_vsi_setup_vectors(vsi);
 	if (ret)
 		goto err_vsi;
 
@@ -14281,7 +14302,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 		dev_info(&pf->pdev->dev,
 			 "failed to get tracking for %d queues for VSI %d err %d\n",
 			 alloc_queue_pairs, vsi->seid, ret);
-		goto err_vsi;
+		goto err_lump;
 	}
 	vsi->base_queue = ret;
 
@@ -14305,7 +14326,6 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 	return vsi;
 
 err_rings:
-	i40e_vsi_free_q_vectors(vsi);
 	if (vsi->netdev_registered) {
 		vsi->netdev_registered = false;
 		unregister_netdev(vsi->netdev);
@@ -14315,6 +14335,8 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
 	if (vsi->type == I40E_VSI_MAIN)
 		i40e_devlink_destroy_port(pf);
 	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
+err_lump:
+	i40e_vsi_free_q_vectors(vsi);
 err_vsi:
 	i40e_vsi_clear(vsi);
 	return NULL;

-- 
2.54.0.rc2.531.gaf818d63126a


