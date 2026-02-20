Return-Path: <stable+bounces-217520-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNvQBmqul2nO5QIAu9opvQ
	(envelope-from <stable+bounces-217520-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 01:44:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D291163F1A
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 01:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AED83090CD6
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 00:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A7622126C;
	Fri, 20 Feb 2026 00:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HSnBtHzI"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FF4207A32;
	Fri, 20 Feb 2026 00:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771548045; cv=none; b=a5LDE8KTq2BBsS2rBDto9cJ84wMXyl0hQxG4t2mzlFxG8AGQw7921JLS6VmQjMgChmidLIUWSCbHhsC9DGob71yDCh+Uin6mwU0hOU1GhpriCSD3dgu0CDn0rjni194+D9M2p+L64IxJJRepb9INBMCN6Ir/4AZEG1X1aICZ/C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771548045; c=relaxed/simple;
	bh=rWG09sxb4d5oN6hg5wMkg4dgKd29FcaXmVKoIXL5BCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLto/+XyxZL71w0+rvOZ7cTTDh1r/Ktmmu5GIV5NXqRbSGzdencnb9VMqx+W23hrNTfXJx5+VdsLzWJ1gTa9r8ZNqicer0YulCVo3Fef6UU641KxAEcFiQ/27no/ODGJbl5KP3fu9Rk8FTOK2VRt/J/jvoascQ53PuGQHCpqOrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HSnBtHzI; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771548044; x=1803084044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rWG09sxb4d5oN6hg5wMkg4dgKd29FcaXmVKoIXL5BCQ=;
  b=HSnBtHzI4qRiWYByeQr+HBzfDHmpyJjYlo8j57+zFwAnKrph3nrroI5b
   bSaTqjsiOkXZxJguS52a6g2JjJPGknQI5vG84LLKxCyrfNNjCwpQfMFyO
   ixqdOudwbbSAR7w0N5VpAX2PWwEOVb6eqzCIurRRLwr+Wc7EokP05JeUC
   O+nPCdvdHte4MYAhRlT5kjJnxUfArKZbT1dPClpLVHvIhnBLb6dgQO5c/
   Q1SYQsG9k0PYX9ww6r0x9lA7ufgVLhL0ys8dF/Cy1F+AhhSBb0h2SY4DM
   lhoh9om2Treuuqf6VUepr24asrZlGEgFYS0XMya9Sg4BwF291LvNyS9J/
   w==;
X-CSE-ConnectionGUID: 2vWEMFBHR0yvwr/KFiPr2A==
X-CSE-MsgGUID: gyLVMosnQPmcPiRWQ+L2CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="76484231"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="76484231"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 16:40:34 -0800
X-CSE-ConnectionGUID: OdlTtVzMRzSgFI8hR3WtVw==
X-CSE-MsgGUID: J1RH6lbGS7CuG1sXYse10A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="218850492"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 16:40:34 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	stable@vger.kernel.org,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 10/13] ixgbevf: fix link setup issue
Date: Thu, 19 Feb 2026 16:40:22 -0800
Message-ID: <20260220004027.729384-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260220004027.729384-1-anthony.l.nguyen@intel.com>
References: <20260220004027.729384-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-217520-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,intel.com:mid,intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D291163F1A
X-Rspamd-Action: no action

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

It may happen that VF spawned for E610 adapter has problem with setting
link up. This happens when ixgbevf supporting mailbox API 1.6 cooperates
with PF driver which doesn't support this version of API, and hence
doesn't support new approach for getting PF link data.

In that case VF asks PF to provide link data but as PF doesn't support
it, returns -EOPNOTSUPP what leads to early bail from link configuration
sequence.

Avoid such situation by using legacy VFLINKS approach whenever negotiated
API version is less than 1.6.

To reproduce the issue just create VF and set its link up - adapter must
be any from the E610 family, ixgbevf must support API 1.6 or higher while
ixgbevf must not.

Fixes: 53f0eb62b4d2 ("ixgbevf: fix getting link speed data for E610 devices")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: stable@vger.kernel.org
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/vf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index 74d320879513..b67b580f7f1c 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -852,7 +852,8 @@ static s32 ixgbevf_check_mac_link_vf(struct ixgbe_hw *hw,
 	if (!mac->get_link_status)
 		goto out;
 
-	if (hw->mac.type == ixgbe_mac_e610_vf) {
+	if (hw->mac.type == ixgbe_mac_e610_vf &&
+	    hw->api_version >= ixgbe_mbox_api_16) {
 		ret_val = ixgbevf_get_pf_link_state(hw, speed, link_up);
 		if (ret_val)
 			goto out;
-- 
2.47.1


