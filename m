Return-Path: <stable+bounces-219713-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAHcAxxnn2lRagQAu9opvQ
	(envelope-from <stable+bounces-219713-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 22:18:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA8C19DC29
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 22:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0311C30D1F9A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 21:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9223168F8;
	Wed, 25 Feb 2026 21:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="In8aS3Sy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA7F314A82;
	Wed, 25 Feb 2026 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772054161; cv=none; b=GsarXG9b4NU+CQTrASruWMadyqJVQyCrFNkFBNBDkYYmtt2n/DNqsxZTmw6DzotsL1wPLx4qU2vsdrmWwES7LJkSfUUPemZawcfMLLQgK+NQBm5JYyG+Elwh66HrYYNAClrhYqEf/u1N02hOxO6pqR4odAV7VFtBTyFzj74CkIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772054161; c=relaxed/simple;
	bh=rWG09sxb4d5oN6hg5wMkg4dgKd29FcaXmVKoIXL5BCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d02/2Om4lwJ6C8GjXz6I2bKZBy5maPZ6ErdDIpPEy81S0Ntz+Cvj0OtQrMPf1zB/hCQuBtBMYcHIEGDnVQMWf17hNyZbPNQGhZZ2qY8kLE0lnxbSxjZq5SGx024AbDIsQyka4jybn8Ip9ySZQO3JX24O2pI3FXHSkQf2HB9NklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=In8aS3Sy; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772054160; x=1803590160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rWG09sxb4d5oN6hg5wMkg4dgKd29FcaXmVKoIXL5BCQ=;
  b=In8aS3SyDKaq6whzj98c6tYVlNuWNbIWqoDn6ciSzMUFOW26elcwYZ8e
   ldKFP5sw3jN2OxRf2fDR3pWFzbLszsbwUi0j2ffQAvtSKdmNzyD/B20+k
   GRHYkq8lljdBCEKzNFTqcwg1sKbLfyQRNHLeOKHE0LxEUEAy+L6iI796L
   +Fokbezo/4B0q5sSofmzLRlC34dKjyu6OX0jryFWwKlOFi0BleqmkMTK1
   gd1goOgGZhIgHYOqzgolmCBLOCjkhdNkkFqRxiu07rypuLidtlDZtONa+
   NfMFHbyie5TxyzFm8p42DUCKbnfJkQiHAIW4/t/bfLpgIK8CUuwJTvtHd
   g==;
X-CSE-ConnectionGUID: CouMLEInSPC8kPg6W4WipA==
X-CSE-MsgGUID: t/l7djzKRKaZleTPC3puPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73013822"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="73013822"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 13:15:57 -0800
X-CSE-ConnectionGUID: HapgMNX6RRWe/CySXzci0A==
X-CSE-MsgGUID: EgtshCswRl62FloiBDDDog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="239349709"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 25 Feb 2026 13:15:56 -0800
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
Subject: [PATCH net v2 10/12] ixgbevf: fix link setup issue
Date: Wed, 25 Feb 2026 13:15:41 -0800
Message-ID: <20260225211546.1949260-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260225211546.1949260-1-anthony.l.nguyen@intel.com>
References: <20260225211546.1949260-1-anthony.l.nguyen@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219713-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,mpg.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AA8C19DC29
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


