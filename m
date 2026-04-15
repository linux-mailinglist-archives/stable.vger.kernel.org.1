Return-Path: <stable+bounces-238045-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFZJNo4n32nmPQAAu9opvQ
	(envelope-from <stable+bounces-238045-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 07:52:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEFF4009C4
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 07:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF46130ED4E6
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3139237FF73;
	Wed, 15 Apr 2026 05:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZscOL1a"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC0B381B0A;
	Wed, 15 Apr 2026 05:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232173; cv=none; b=hX1sQHKkFuGyvolbRdGA6MNpjhnDXKHGS9ClpYPPMcRVe67nyuTayMUkwT6+0KodAQx+dtfoqlXnygFnPL0XIW4QhOyEV5vPkf2g6PpCOKUG4UENuE3+4IdAXlH87CqokDlM1Kvn9mJtIR1hliD+GYqwSJSCtwrdQC3Rgsg6Xpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232173; c=relaxed/simple;
	bh=POWdV/FGd+2c1wJaDInNscdlnBwu8jGvqNlYX4vI5oQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XLd40/0A645N0Pm6EP0+Baj0RAmETdFLaDMbbS52ZRkLQVuhHdEiG8si0R+FEEaAIXyDKy7jz8nVa3DtEeWX7PkHl1UgMtWxdsgBuzJZBbXqmMsLYQnI/KNCLmpqOPGLQThrV0xqOC64rpeK0w+2UQ/8lXL2unkEbKqbMWHfaaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZscOL1a; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776232171; x=1807768171;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=POWdV/FGd+2c1wJaDInNscdlnBwu8jGvqNlYX4vI5oQ=;
  b=hZscOL1a14xhaHrU+aVTJoLTUwMwd/A+1n7wpqu4QCUcGDgmBUBiC4bG
   7Ae523Sh9c5h2R3CKC5EvtHkX87lNkmXKgm/dGJJUTP088mxVs56Wpq/4
   q7nwA5S39NPzY7OLqhcRTPVDlDTnv08pfHeYbSzLAy6gXKWt2LTKHSUto
   jE5raV3xpXH+ofN5Iuc3S8ZtowECoqUISTwStIUe7N7dljiq0cGbYrGDM
   CboEOHnt/fPZ0hxbN6X/0a5AGW+sleDZFZkL5/DpZ9e47otfelFiDCm+s
   +sfLJk2klz9WloHR4dK+WDJO1mkKtIkoYP3mWsjb50lqqigoSCyL241BD
   g==;
X-CSE-ConnectionGUID: ctS+nSgtR1i8VyJgrBPPMA==
X-CSE-MsgGUID: 3X0rxFzBTyOi7gDpxdZTTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77105973"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77105973"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 22:49:26 -0700
X-CSE-ConnectionGUID: Ix7SE42AQU2Vfwmo03lhkg==
X-CSE-MsgGUID: IEUi2YyKRBKiKkKCsEzwoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="253714820"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 22:49:26 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Tue, 14 Apr 2026 22:48:05 -0700
Subject: [PATCH net 10/13] i40e: fix napi_enable/disable skipping ringless
 q_vectors
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-iwl-net-submission-2026-04-14-v1-10-852f38e7da39@intel.com>
References: <20260414-iwl-net-submission-2026-04-14-v1-0-852f38e7da39@intel.com>
In-Reply-To: <20260414-iwl-net-submission-2026-04-14-v1-0-852f38e7da39@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, stable@vger.kernel.org, 
 Sunitha Mekala <sunithax.d.mekala@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=5242;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=8pzCpKcT3fQx3sB5nwBof8I9mY09WCz1hR9rA/VKP2I=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsz7ao/mJwUzCx06mdSqlsR44Jfsx289Gu9O+riWpYccv
 3U0dfPzjlIWBjEuBlkxRRYFh5CV140nhGm9cZaDmcPKBDKEgYtTACYia8XIcLf8btuVhR/mWMjX
 OP7mqrGvTT2jz3qLva8xsGTvxGybFQx/5fbkn0vTTXxhdkVfO/30cmWjdXa9X882z7xTYnf8l6g
 HEwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238045-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 8EEFF4009C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

After ethtool -L reduces the queue count, i40e_napi_disable_all() sets
NAPI_STATE_SCHED on all q_vectors, then i40e_vsi_map_rings_to_vectors()
clears ring pointers on the excess ones.  i40e_napi_enable_all() skips
those with:

	if (q_vector->rx.ring || q_vector->tx.ring)
		napi_enable(&q_vector->napi);

leaving them on dev->napi_list with NAPI_STATE_SCHED permanently set.

Writing to /sys/class/net/<iface>/threaded calls napi_stop_kthread()
on every entry in dev->napi_list.  The function loops on msleep(20)
waiting for NAPI_STATE_SCHED to clear -- which never happens for the
stale q_vectors.  The task hangs in D state forever; a concurrent write
deadlocks on dev->lock held by the first.

Commit 13a8cd191a2b ("i40e: Do not enable NAPI on q_vectors that have no
rings") added the guard to prevent a divide-by-zero in i40e_napi_poll()
when epoll busy-poll iterated all device NAPIs (4.x era). Since
7adc3d57fe2b ("net: Introduce preferred busy-polling"), from v5.11,
napi_busy_loop() polls by napi_id keyed to the socket, so ringless
q_vectors are never selected.  i40e_msix_clean_rings() also independently
avoids scheduling NAPI for them.  The guard is safe to remove.

Add an early return in i40e_napi_poll() for num_ringpairs == 0 so the
function is self-defending against a NULL tx.ring dereference at the
WB_ON_ITR check, should the NAPI ever fire through an unexpected path.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/intel-wired-lan/20260316133100.6054a11f@kernel.org/
Fixes: 13a8cd191a2b ("i40e: Do not enable NAPI on q_vectors that have no rings")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 28 ++++++++++++++++------------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c | 10 ++++++++++
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 028bd500603a..b4ca8485f4b5 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5182,6 +5182,14 @@ static void i40e_clear_interrupt_scheme(struct i40e_pf *pf)
 /**
  * i40e_napi_enable_all - Enable NAPI for all q_vectors in the VSI
  * @vsi: the VSI being configured
+ *
+ * Enable NAPI on every q_vector that is registered with the netdev,
+ * regardless of whether it currently has rings assigned.  After a queue-
+ * count reduction (e.g. ethtool -L combined 1) the excess q_vectors lose
+ * their ring pointers inside i40e_vsi_map_rings_to_vectors but remain on
+ * dev->napi_list.  Leaving them in the napi_disable()-ed state
+ * (NAPI_STATE_SCHED set) causes napi_set_threaded() to spin forever on
+ * msleep(20) waiting for that bit to clear.
  **/
 static void i40e_napi_enable_all(struct i40e_vsi *vsi)
 {
@@ -5190,17 +5198,17 @@ static void i40e_napi_enable_all(struct i40e_vsi *vsi)
 	if (!vsi->netdev)
 		return;
 
-	for (q_idx = 0; q_idx < vsi->num_q_vectors; q_idx++) {
-		struct i40e_q_vector *q_vector = vsi->q_vectors[q_idx];
-
-		if (q_vector->rx.ring || q_vector->tx.ring)
-			napi_enable(&q_vector->napi);
-	}
+	for (q_idx = 0; q_idx < vsi->num_q_vectors; q_idx++)
+		napi_enable(&vsi->q_vectors[q_idx]->napi);
 }
 
 /**
  * i40e_napi_disable_all - Disable NAPI for all q_vectors in the VSI
  * @vsi: the VSI being configured
+ *
+ * Mirror of i40e_napi_enable_all: operate on every registered q_vector so
+ * enable/disable calls are always balanced, even when some q_vectors carry
+ * no rings (as happens after a queue-count reduction).
  **/
 static void i40e_napi_disable_all(struct i40e_vsi *vsi)
 {
@@ -5209,12 +5217,8 @@ static void i40e_napi_disable_all(struct i40e_vsi *vsi)
 	if (!vsi->netdev)
 		return;
 
-	for (q_idx = 0; q_idx < vsi->num_q_vectors; q_idx++) {
-		struct i40e_q_vector *q_vector = vsi->q_vectors[q_idx];
-
-		if (q_vector->rx.ring || q_vector->tx.ring)
-			napi_disable(&q_vector->napi);
-	}
+	for (q_idx = 0; q_idx < vsi->num_q_vectors; q_idx++)
+		napi_disable(&vsi->q_vectors[q_idx]->napi);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 894f2d06d39d..3123459208d3 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2760,6 +2760,16 @@ int i40e_napi_poll(struct napi_struct *napi, int budget)
 		return 0;
 	}
 
+	/* A q_vector can have its ring pointers cleared after a queue-count
+	 * reduction (ethtool -L combined N) while napi_enable() was already
+	 * called on it.  Complete immediately so the poll loop exits cleanly
+	 * and we never dereference the NULL ring pointer below.
+	 */
+	if (unlikely(!q_vector->num_ringpairs)) {
+		napi_complete_done(napi, 0);
+		return 0;
+	}
+
 	/* Since the actual Tx work is minimal, we can give the Tx a larger
 	 * budget and be more aggressive about cleaning up the Tx descriptors.
 	 */

-- 
2.53.0.1066.g1eceb487f285


