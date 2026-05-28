Return-Path: <stable+bounces-255324-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Bc+Ed+fGGpvlggAu9opvQ
	(envelope-from <stable+bounces-255324-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:04:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D055E5F7C7B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDA58301983B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE48C2F691F;
	Thu, 28 May 2026 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M33mqp3z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F1F24677F;
	Thu, 28 May 2026 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998589; cv=none; b=riCu/FNRan/UD/O3puYhBuXIEhvCKpAzxUTcA/1kC2FZBsMYDs00f/egtfQ+jlpKYfrhOSiYTPdzZOAWsPhhFmLp/8IZQksGLkDiKkeRDjNt05onsiTMI7fdGU8s8n33JFEHzdPzUdywJ/0reN9AiGL2ju7OINUBwCzhCmGUj9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998589; c=relaxed/simple;
	bh=p4Z8x1V3w0VYPW3xRIuPaPBtwxqIfOqkoQFYBOYmQ2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciXN6OUo/95sYFj4wCqWMvdxUX8+pz/i98wupVC4QPZvb591zGBO0Kxu0e5qM4N7wrJmHcw6yXuege9YeqA/63ka3ajzNQQjoB1eXK+oN9G6a/VNN9uozfj6fV/cvkeZ7JG/e19SpRpcyu4Kmlx5HDaQO8DkTmNRj/e6s+Ve88Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M33mqp3z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D461F000E9;
	Thu, 28 May 2026 20:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998588;
	bh=AdBjpBubMgFSeLqpXZsxsxtUtJewMoGkjBxSXp9w2kM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M33mqp3zp/DCDSAOb0/kXoRxn5lO/9Rn8fw/eoDBzWaQHd7LdgKUtzGhj4vEM9qQw
	 iv2e6Eiy8yOWxCTRLIj5OGlbaiUGOouXEQAnxtUJgqR2RC9RbmPeoEXjBVq2UpxuIx
	 bUNvyi/c5Jft2+nz6nxyu8rbEit3QTHILenBFS9k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ivan Vecera <ivecera@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 226/461] ice: dpll: fix misplaced header macros
Date: Thu, 28 May 2026 21:45:55 +0200
Message-ID: <20260528194653.674657906@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255324-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: D055E5F7C7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Vecera <ivecera@redhat.com>

[ Upstream commit 30f1658fc5387384c7a60b9d15c79cb959512c1a ]

The CGU register definitions (ICE_CGU_R10, ICE_CGU_R11 and related field
masks) were placed after the #endif of the _ICE_DPLL_H_ include guard,
leaving them unprotected. Move them inside the guard.

Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20260506-jk-iwl-net-2026-05-04-v2-8-a5ea4dc837a9@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_dpll.h | 32 +++++++++++------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
index ae42cdea0ee14..8678575359b92 100644
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
2.53.0




