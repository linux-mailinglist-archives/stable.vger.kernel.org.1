Return-Path: <stable+bounces-224440-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJfiJqwCsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224440-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:38:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DEE24B2D4
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17235306AEDA
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F07938A711;
	Tue, 10 Mar 2026 11:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rf6i4fJg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C705C387361;
	Tue, 10 Mar 2026 11:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142172; cv=none; b=LR1G9pmCtlcxaw5p/fSc1PF4q4JIMetAoc/7/1d9ho/+yLrvj88LHU49UauyChzscHiSU+dkFn5EP9k2pH6iVMHB0SSF+qkYAQT54pgLk44cnHNb8gxybgI/AwGnLEXGjtePBmPJ50SMB6GMNjjNINI/F6m8GB8ip4CayVah/i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142172; c=relaxed/simple;
	bh=RjjYiFVFRpwfCGN73jvea6TUnr85kR/rVutQxAOwxPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTtJMYr6NwtJ9zPG/OLSkszUtEJlzDTmmqRgPAggDczP0xkQ9CwvD/LLyHLG/BW/Pk/GJsbI5i7xt7xzJLqjEROECx/Ah4fkLbtNSpSHoniAdXffc6Nl9DzpNfxF8/2babAZRrdLjWylVahLF2XRqLeEI4eA1BHw7vbLZ9bsCPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rf6i4fJg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C08C2BC86;
	Tue, 10 Mar 2026 11:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142172;
	bh=RjjYiFVFRpwfCGN73jvea6TUnr85kR/rVutQxAOwxPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rf6i4fJgsxinPLSGzVS7JV8aFeYkeay9GNVLx9eQqldaLs4I/4JrCRs4SJg0UwxAY
	 kEcAI7SJfDctAGS8p8KlTF/E3Dva+VN6l6eEnyCrR1he/myuL+sdEg8roW+cnXA+rr
	 l1H3PsNsfeoNbrKur35vjpci8jf7I3oUxMuE2VGhH1T2dgL3RN1lPfzQdenmlN+1fD
	 N6h7jR0UF14F39F9/ZNMNRECAUA2zg5nGOBAAHC8rcOSZAAlX4PQKyQfgwQScz1ZOA
	 ze295KLn4Me5CXyKGYO3I8m0I+Xlmu8vIs4P6IjXup4IpQsVuB359dfA8mNJnrLYUM
	 EZsPB2kyGHW1A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 261/314] ice: fix adding AQ LLDP filter for VF
Date: Tue, 10 Mar 2026 07:18:40 -0400
Message-ID: <30d1cf08ea61583d1d925510e8b8bcc560b5f876.1773141555.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 21DEE24B2D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224440-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Larysa Zaremba <larysa.zaremba@intel.com>

[ Upstream commit eef33aa44935d001747ca97703c08dd6f9031162 ]

The referenced commit came from a misunderstanding of the FW LLDP filter
AQ (Admin Queue) command due to the error in the internal documentation.
Contrary to the assumptions in the original commit, VFs can be added and
deleted from this filter without any problems. Introduced dev_info message
proved to be useful, so reverting the whole commit does not make sense.

Without this fix, trusted VFs do not receive LLDP traffic, if there is an
AQ LLDP filter on PF. When trusted VF attempts to add an LLDP multicast
MAC address, the following message can be seen in dmesg on host:

ice 0000:33:00.0: Failed to add Rx LLDP rule on VSI 20 error: -95

Revert checking VSI type when adding LLDP filter through AQ.

Fixes: 4d5a1c4e6d49 ("ice: do not add LLDP-specific filter if not necessary")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index eb148c8d9e083..95160c8dc1bba 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -6428,7 +6428,7 @@ int ice_lldp_fltr_add_remove(struct ice_hw *hw, struct ice_vsi *vsi, bool add)
 	struct ice_aqc_lldp_filter_ctrl *cmd;
 	struct libie_aq_desc desc;
 
-	if (vsi->type != ICE_VSI_PF || !ice_fw_supports_lldp_fltr_ctrl(hw))
+	if (!ice_fw_supports_lldp_fltr_ctrl(hw))
 		return -EOPNOTSUPP;
 
 	cmd = libie_aq_raw(&desc);
-- 
2.51.0


