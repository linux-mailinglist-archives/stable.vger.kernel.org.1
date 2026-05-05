Return-Path: <stable+bounces-243980-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF+8KaF9+WmZ9AIAu9opvQ
	(envelope-from <stable+bounces-243980-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:18:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 956624C6CD0
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31A3F301CF61
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA473CCFC0;
	Tue,  5 May 2026 05:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X0ECfEUb"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1B93CAE8D;
	Tue,  5 May 2026 05:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958148; cv=none; b=WH7vxQz3v1Vu8T1hmy/AR+PJNwQ6XKTyVQfN2HZMJ7s4ALliE51+5Fr1HDMtegBBr3zESYjuBC3kZXzzRdtkh3y8pNvVgTXWU8IDdbDNbaiiE7r3jWyilX4KQ2T4HnUqHCJBOywUXaUULfan4KUi5oykkZnLFUuDxo/OHIUOGqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958148; c=relaxed/simple;
	bh=oyZBFjPjBlakr0MMOvU9CdWBA6zPQZVjaxW3EbeV3nM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jZPqgf6QD39jhsfCEZF/9HeuQj89oaSwCT2UBhumqPq5Q2C/o2ee35P6XBe3YIjzf7i70XDq4eyOLIGwjUFGBn0V8yvJFNHgzrdmtknDVn0cOb6UFJDbrDHlyMS4/FWxVAy9JJiDZF7Z6LCj7B3dD/PX92tpUgXEzWpsgdGiEhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X0ECfEUb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777958146; x=1809494146;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=oyZBFjPjBlakr0MMOvU9CdWBA6zPQZVjaxW3EbeV3nM=;
  b=X0ECfEUbDFCyR/Qx8RxMs5HYMyuAu1qs9cGanAvIGjv83xil0pfmdeq4
   oMR5QvSueEtDN5Em4Mah8cXgJ4PJxm+Bbic3K27Rg6ysVEl0JdLLZGCkd
   mAo0yCWhPndurSXbeUi0OljMA1EFD2L5Tjtu1FNPGyh2zrAtE5wdwWu+C
   lLtevuf4KT9cqjPIj/eiW1H/9IoRpcDwHfJj+U1Qhv9npFrptKUQa1g+w
   l9O/eYkc78eTswARmc+AreA8QHBvQelpZcMmpkvfBYMLIQyPT6PYCrXdd
   LN8/APptmjFIgGmAuHP7IfXS6/qps5NDzqDKDnNOjdekCJje2g9Eaheoj
   w==;
X-CSE-ConnectionGUID: xLSjvNH9SJy7kfmn2OrETA==
X-CSE-MsgGUID: bViZNO8aSwSSvh37mdkLlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89126503"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="89126503"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:38 -0700
X-CSE-ConnectionGUID: kM7B0bzsR8217l4qf9ZDTA==
X-CSE-MsgGUID: I7uKum+uTUCqiJJohBLrOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="239683525"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 22:15:38 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 04 May 2026 22:14:26 -0700
Subject: [PATCH net 13/13] ice: dpll: fix misplaced header macros
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-jk-iwl-net-2026-05-04-v1-13-a222a88bd962@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2402;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=lAspaYvbitHeyyKkwrTxeZbCxMU4G495INk1rQXCTJk=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsyfNT/+i4fLHHraHWTC2bmr7mq4n9O2Xr/bHKHJGSfjH
 gh2rL/bUcrCIMbFICumyKLgELLyuvGEMK03znIwc1iZQIYwcHEKwETuBTP8U/dWP5BiEz9Pae9W
 t6f3xGb5sWS410cVKh2cfH7qAacyXoZfTOcMpxxZoaFisSH15+EvbcuMd1Z4iO3es7Z9/QnbJwb
 ebAA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: 956624C6CD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243980-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Ivan Vecera <ivecera@redhat.com>

The CGU register definitions (ICE_CGU_R10, ICE_CGU_R11 and related field
masks) were placed after the #endif of the _ICE_DPLL_H_ include guard,
leaving them unprotected. Move them inside the guard.

Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.h | 32 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index ae42cdea0ee1..8678575359b9 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.h
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.h
@@ -8,6 +8,22 @@
 
 #define ICE_DPLL_RCLK_NUM_MAX	4
 
+#define ICE_CGU_R10			0x28
+#define ICE_CGU_R10_SYNCE_CLKO_SEL	GENMASK(8, 5)
+#define ICE_CGU_R10_SYNCE_CLKODIV_M1	GENMASK(13, 9)
+#define ICE_CGU_R10_SYNCE_CLKODIV_LOAD	BIT(14)
+#define ICE_CGU_R10_SYNCE_DCK_RST	BIT(15)
+#define ICE_CGU_R10_SYNCE_ETHCLKO_SEL	GENMASK(18, 16)
+#define ICE_CGU_R10_SYNCE_ETHDIV_M1	GENMASK(23, 19)
+#define ICE_CGU_R10_SYNCE_ETHDIV_LOAD	BIT(24)
+#define ICE_CGU_R10_SYNCE_DCK2_RST	BIT(25)
+#define ICE_CGU_R10_SYNCE_S_REF_CLK	GENMASK(31, 27)
+
+#define ICE_CGU_R11			0x2C
+#define ICE_CGU_R11_SYNCE_S_BYP_CLK	GENMASK(6, 1)
+
+#define ICE_CGU_BYPASS_MUX_OFFSET_E825C	3
+
 /**
  * enum ice_dpll_pin_sw - enumerate ice software pin indices:
  * @ICE_DPLL_PIN_SW_1_IDX: index of first SW pin
@@ -157,19 +173,3 @@ static inline void ice_dpll_deinit(struct ice_pf *pf) { }
 #endif
 
 #endif
-
-#define ICE_CGU_R10				0x28
-#define ICE_CGU_R10_SYNCE_CLKO_SEL		GENMASK(8, 5)
-#define ICE_CGU_R10_SYNCE_CLKODIV_M1		GENMASK(13, 9)
-#define ICE_CGU_R10_SYNCE_CLKODIV_LOAD		BIT(14)
-#define ICE_CGU_R10_SYNCE_DCK_RST		BIT(15)
-#define ICE_CGU_R10_SYNCE_ETHCLKO_SEL		GENMASK(18, 16)
-#define ICE_CGU_R10_SYNCE_ETHDIV_M1		GENMASK(23, 19)
-#define ICE_CGU_R10_SYNCE_ETHDIV_LOAD		BIT(24)
-#define ICE_CGU_R10_SYNCE_DCK2_RST		BIT(25)
-#define ICE_CGU_R10_SYNCE_S_REF_CLK		GENMASK(31, 27)
-
-#define ICE_CGU_R11				0x2C
-#define ICE_CGU_R11_SYNCE_S_BYP_CLK		GENMASK(6, 1)
-
-#define ICE_CGU_BYPASS_MUX_OFFSET_E825C		3

-- 
2.54.0.rc2.531.gaf818d63126a


