Return-Path: <stable+bounces-251854-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKc1LZz/DWo95QUAu9opvQ
	(envelope-from <stable+bounces-251854-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:38:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA923596D34
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE53E32577CA
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0B13EEAC6;
	Wed, 20 May 2026 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EHp8jKeB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6BE1C3BFC;
	Wed, 20 May 2026 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299060; cv=none; b=UX2O6XPVG81/mS5M5ylLShc4SQzwdpsEVu6yYcmnCeBGKSfoSx+Ad6pdp6yt7VesvFMXKS7PqFUh7u89aGbqJpYzLcBMMw60x6vnX+DBEf6gNL0bySR+evFwEDZ14pnS4QnY9bs2qW2rIxzKMCCa6EhaL1IbZYj2VlPgNRphGQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299060; c=relaxed/simple;
	bh=9bJ2pE/1R6VeU7MIIGGJzlKzLP/EcIp7F50mxV8Dea8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ri+rreuFv6p8jSL2GXJPAaZQX1NKkcvcs1fGnpgq093VWxITcF7zZ7nKsnw0N63ZJ8CkbJcR0XCOghkkGa104mSbD3jEhYrdFHXoTrnP0ya7XnToN1/pkjjhjDl2DoMaSRknYTuRi0KvnC0p9qT4ffHx7QOmnVADQiwI6dpD8sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EHp8jKeB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31FC1F00893;
	Wed, 20 May 2026 17:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299059;
	bh=Sb4IwxocFjBKhO1/U4l072zp3ebjqazcet54nuRRz/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EHp8jKeB+1G/WUg+mWU9QPwzrvh2wDQH3wyMXn4RacOZMLrlW4NVAY5hM0dcx/nv/
	 FxN8Y67+Zw7tZaFKEMrOPXyH0bU3kl7tAfHu+PmMSLoDhdHbw7dWuIwI8+0zSRCHl3
	 SOAYwyLw4a5MM8Ol65/UmQLNOA1SMfZfQN1K9ucE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 646/957] ice: fix adjust timer programming for E830 devices
Date: Wed, 20 May 2026 18:18:49 +0200
Message-ID: <20260520162148.538343459@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251854-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,intel.com:url,intel.com:email]
X-Rspamd-Queue-Id: DA923596D34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

[ Upstream commit 885c5e57924dc040b23d0ad0d8388f0e35772159 ]

Fix incorrect 'adjust the timer' programming sequence for E830 devices
series. Only shadow registers GLTSYN_SHADJ were programmed in the
current implementation. According to the specification [1], write to
command GLTSYN_CMD register is also required with CMD field set to
"Adjust the Time" value, for the timer adjustment to take the effect.

The flow was broken for the adjustment less than S32_MAX/MIN range
(around +/- 2 seconds). For bigger adjustment, non-atomic programming
flow is used, involving set timer programming. Non-atomic flow is
implemented correctly.

Testing hints:
Run command:
	phc_ctl /dev/ptpX get adj 2 get
Expected result:
	Returned timestamps differ at least by 2 seconds

[1] Intel® Ethernet Controller E830 Datasheet rev 1.3, chapter 9.7.5.4
https://cdrdv2.intel.com/v1/dl/getContent/787353?explicitVersion=true

Fixes: f00307522786 ("ice: Implement PTP support for E830 devices")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20260416-iwl-net-submission-2026-04-14-v2-1-686c33c9828d@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 35680dbe4a7f7..161a0ae8599c1 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -5381,8 +5381,8 @@ int ice_ptp_write_incval_locked(struct ice_hw *hw, u64 incval)
  */
 int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
 {
+	int err = 0;
 	u8 tmr_idx;
-	int err;
 
 	tmr_idx = hw->func_caps.ts_func_info.tmr_index_owned;
 
@@ -5399,8 +5399,8 @@ int ice_ptp_adj_clock(struct ice_hw *hw, s32 adj)
 		err = ice_ptp_prep_phy_adj_e810(hw, adj);
 		break;
 	case ICE_MAC_E830:
-		/* E830 sync PHYs automatically after setting GLTSYN_SHADJ */
-		return 0;
+		/* E830 sync PHYs automatically after setting cmd register */
+		break;
 	case ICE_MAC_GENERIC:
 		err = ice_ptp_prep_phy_adj_e82x(hw, adj);
 		break;
-- 
2.53.0




