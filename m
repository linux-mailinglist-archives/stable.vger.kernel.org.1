Return-Path: <stable+bounces-244465-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNQGJy+4+2kXDwAAu9opvQ
	(envelope-from <stable+bounces-244465-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:52:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C3C4E0CDA
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 23:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 837FB304E0EF
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 21:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A836E3B3BF7;
	Wed,  6 May 2026 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R3gF/lI8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770E43B47FA;
	Wed,  6 May 2026 21:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104170; cv=none; b=TrjGmDeowkHHlhN4jzPrBi8Tau5jc/1lgOkYbUEBTuaQqzMLF7TGdo23s82BPlcWPtMiwnS1IcB4NVSVxIF3m5QKqzlUDvAYAS52Yp8R6xCzOGmxVqWiwvxH7vXE/5oEN3+ydB5WC0OvYHRXYrvQt8p2IPDIHf/ANNFORxheMFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104170; c=relaxed/simple;
	bh=oyZBFjPjBlakr0MMOvU9CdWBA6zPQZVjaxW3EbeV3nM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d0/SFOHKIbZ3lOigoRIovLuCBrLpkKmSJWpwCdE2QebugUEU5JZhTjcaK9Dt/J/EjsEpW4SfRRhFrGtIYzCrQJG/Mu98ildhGYXY/Eo2mNfRe5nwq7AD9bn2jrlfIBuKX2UgW6ppVxbOUF5LN3XXcjGfQpXLoeeQgo3fySECIEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R3gF/lI8; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778104164; x=1809640164;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=oyZBFjPjBlakr0MMOvU9CdWBA6zPQZVjaxW3EbeV3nM=;
  b=R3gF/lI8r8sg9CCbHpBlk3hObRA8jlewEK9Rns439Cg9cLS0wwMBNj5l
   MdN2q0tVeCuMJ9nJg+Eh64djoxJDikC5fMERWDz0ZUO1vuzAVyiNtQN7D
   +jW+r/1YoibQuL5X0eoh2E9mQAoy/RI9K9WDEQziSryhCpfxYqTiq8yjd
   dCiEE4JNoLBsYW3/24uFOYnnhSIYFH7JUOStwLP9203qZ+ujQeXt+VThY
   LhqSbKQ2LXOeLXcm/igHWjnEmojzsVG8IyXwCETp8O0GKt5B8fiAHNfG1
   DRDvTN3gbq/CoiLmL7mezPb27NsQjSnvLivWsDwNgEAdlXowYAEOYE9Zm
   A==;
X-CSE-ConnectionGUID: xU/tpHYFSoCHKkVBTZyyKg==
X-CSE-MsgGUID: O217g+uLToOLhCN/YIII6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78982541"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="78982541"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:49:21 -0700
X-CSE-ConnectionGUID: dm9ozoJeTwSpCuZvdMBwhA==
X-CSE-MsgGUID: Aymc9yAnSKC17YowzGvV5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="259698640"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:49:21 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 06 May 2026 14:48:17 -0700
Subject: [PATCH net v2 8/8] ice: dpll: fix misplaced header macros
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-jk-iwl-net-2026-05-04-v2-8-a5ea4dc837a9@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2402;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=lAspaYvbitHeyyKkwrTxeZbCxMU4G495INk1rQXCTJk=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhszf22N9k/eph8g972aS3t5yK/MTX9B6YaPF+i4BPYtOH
 jY6eFezo5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgInEnGNk2J5xflK5rcbtTDa1
 b+u8OdmaUs8WxkwPnbbmnd7aULl4LUaGFtPrDjM0Frj5zz7yTOnF2km/O7JvGWiKM6/a7ygk8zu
 IHwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Rspamd-Queue-Id: E9C3C4E0CDA
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
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244465-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

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


