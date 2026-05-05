Return-Path: <stable+bounces-243977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNoAAMJ9+WmZ9AIAu9opvQ
	(envelope-from <stable+bounces-243977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:18:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A0F4C6CED
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E90E73057245
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B0C3CAE94;
	Tue,  5 May 2026 05:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4t3bQbr"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720FD3C5550;
	Tue,  5 May 2026 05:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958146; cv=none; b=p3YBTLLyy76WJrsgmXAqeSxI8tQhWzfbU559KWDLyvCzZtU+wqHakhMFA/K44dU24J/VAO3c2YGm/g+oqkq+WpkLqZqoEV2RcpNyeW1V4wj0nRlx2+OvcL77lgmZW8lxuP+Bw1vz/tzBcpggWvwmCYHKk870Zrd8lOPFXnBrvuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958146; c=relaxed/simple;
	bh=wHo5j9nJDIamG49pqy+qz+6YnpC7rg7uJNijoxFDE5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eHj/eqeRybKgt8cY/dICtu2oNjfZ5foVUgZpvs+NCF4TDm2PCUstP28wvkdlVbPECKZwl0goC+rJQH4TaQlxmufVmMjqbm+ANRuuvYvABehHkebKXguPqbPwJbljtDIhXLBEM92qN56SiGsMDK7DYlgasm6/AlpEUGjT7zdqVW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4t3bQbr; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777958144; x=1809494144;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=wHo5j9nJDIamG49pqy+qz+6YnpC7rg7uJNijoxFDE5s=;
  b=n4t3bQbrvVN8HZI+ZJpXk/MZtKm0vgOYn8raYb69A5mNn7QjNjQyQrtQ
   b8LSTqLANVHupwJfsb/do7kMQjZKTbTAYs/TTjhisZVgBo3fkzuZ/M8No
   0DPzBoWXL6OHXs4LQuVFVUjMJjkiqC+NF4KnsmqVv9b7PosKZd8cwNAQ+
   2gXcTAIh66TOK8q8JJWGMyTuvOPBtVMU+P5DbVwYowKsO6y2RWCgqKYs5
   vaNzLT5zc8+FWjuQC6niCZqtifWekljnN0AN5yLmnO7LEgCY3mDP4rNud
   ZEJOFsAVrqpyFm6j7Qvc00Vm/CrVRVg787DJ39T6l2h93UadB2hOw0WKC
   Q==;
X-CSE-ConnectionGUID: oNuW78jyRM2IIRzrtHeLzQ==
X-CSE-MsgGUID: Km36hlNDTF+Yg+/xgl7Mgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89126488"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="89126488"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:37 -0700
X-CSE-ConnectionGUID: TICpKPviSzeAC64Lks8Oqg==
X-CSE-MsgGUID: 1OWoshimSZeAoNnRAN0T4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="239683515"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:37 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 04 May 2026 22:14:23 -0700
Subject: [PATCH net 10/13] ice: fix locking in ice_dcb_rebuild()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-jk-iwl-net-2026-05-04-v1-10-a222a88bd962@intel.com>
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
 Bart Van Assche <bvanassche@acm.org>, intel-wired-lan@lists.osuosl.org, 
 Arpana Arland <arpanax.arland@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=8xxRBB2hCfnptncdvaHpAb1aQ37pmgCfaRqlFzs73jI=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsyfNd83dX8sW1THFya9VGb2vg/BK2stbH5fa90df69Ni
 U3hz8rLHaUsDGJcDLJiiiwKDiErrxtPCNN64ywHM4eVCWQIAxenAExkDQPDPyNZAdUXqmcZi0Mt
 DpX4XJ1Q+E93P+fG9z5az7RMV80KXMHwP5AtWebA9l+iZ2W234q2Wbvt1/+f2ipbZBeu1In2ex4
 ZxQoA
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: B2A0F4C6CED
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
	TAGGED_FROM(0.00)[bounces-243977-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,osuosl.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: Bart Van Assche <bvanassche@acm.org>

Move the mutex_lock() call up to prevent that DCB settings change after
the first ice_query_port_ets() call. The second ice_query_port_ets()
call in ice_dcb_rebuild() is already protected by pf->tc_mutex.

This also fixes a bug in an error path, as before taking the first
"goto dcb_error" in the function jumped over mutex_lock() to
mutex_unlock().

This bug has been detected by the clang thread-safety analyzer.

Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
Fixes: 242b5e068b25 ("ice: Fix DCB rebuild after reset")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Arpana Arland <arpanax.arland@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index 16aa25535152..0bc6dd375687 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -537,14 +537,14 @@ void ice_dcb_rebuild(struct ice_pf *pf)
 	struct ice_dcbx_cfg *err_cfg;
 	int ret;
 
+	mutex_lock(&pf->tc_mutex);
+
 	ret = ice_query_port_ets(pf->hw.port_info, &buf, sizeof(buf), NULL);
 	if (ret) {
 		dev_err(dev, "Query Port ETS failed\n");
 		goto dcb_error;
 	}
 
-	mutex_lock(&pf->tc_mutex);
-
 	if (!pf->hw.port_info->qos_cfg.is_sw_lldp)
 		ice_cfg_etsrec_defaults(pf->hw.port_info);
 

-- 
2.54.0.rc2.531.gaf818d63126a


