Return-Path: <stable+bounces-239644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO1fC7lN5mmgugEAu9opvQ
	(envelope-from <stable+bounces-239644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:00:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9BC42ED42
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2D713001463
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82BF33DEFE;
	Mon, 20 Apr 2026 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kObvwMhE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FC23368AE;
	Mon, 20 Apr 2026 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700854; cv=none; b=OoOM9Vw83x2ixM5iQcVW4sa7PpYK39VVufUKdiAYe4YWq6PfYR6kguAlkIWggXi5gwYzml7fO7ugYB1SNSvqYVFmXby35iICtK+87AtuBie1nZ15Cj6JzrAsizWMNg42iECMUpjQwCQe/MROPkplfzAz7hUbi+cTCk5DuWGgTa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700854; c=relaxed/simple;
	bh=Z5K64PGuPMrTpq81pdYSFFEjZ6jV465in7umJSboYOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcSJzRB/Ro8fNogMuubkpOru/A3R/EeS3AusJ7Wpi+9S5bLDUj9VJt4uPC09IPnug1mUeYuOQIg9RXeEr2xwmm1PCVFNr9zVRgzxLXSRp9/aooqUvNEWEJc1pDS9K+pDAtvw4H43BafvkxXrYJaYhzbzTO25B4/VUZFRj36IImY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kObvwMhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CB9C19425;
	Mon, 20 Apr 2026 16:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700854;
	bh=Z5K64PGuPMrTpq81pdYSFFEjZ6jV465in7umJSboYOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kObvwMhEt7hCuVQoMgf74fP/6mR+b9WRC4oPnCh+h2WG8Jl/0wA+V8/rUmeGCEe+2
	 crQhn9M69dsW5FV4QDlNjivbBNJYw+jY+dYKgu1FQbhnvV9SMjafrtXQCo5RUIfzBi
	 M/j46ucdfL5t97AgidQac7Ilr2JJ/7C1ogkwFTTY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiaoqiang Xiong <xxiong@redhat.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 086/198] ixgbevf: add missing negotiate_features op to Hyper-V ops table
Date: Mon, 20 Apr 2026 17:41:05 +0200
Message-ID: <20260420153938.704157918@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
References: <20260420153935.605963767@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239644-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD9BC42ED42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Schmidt <mschmidt@redhat.com>

[ Upstream commit 4821d563cd7f251ae728be1a6d04af82a294a5b9 ]

Commit a7075f501bd3 ("ixgbevf: fix mailbox API compatibility by
negotiating supported features") added the .negotiate_features callback
to ixgbe_mac_operations and populated it in ixgbevf_mac_ops, but forgot
to add it to ixgbevf_hv_mac_ops. This leaves the function pointer NULL
on Hyper-V VMs.

During probe, ixgbevf_negotiate_api() calls ixgbevf_set_features(),
which unconditionally dereferences hw->mac.ops.negotiate_features().
On Hyper-V this results in a NULL pointer dereference:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  [...]
  Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine [...]
  Workqueue: events work_for_cpu_fn
  RIP: 0010:0x0
  [...]
  Call Trace:
   ixgbevf_negotiate_api+0x66/0x160 [ixgbevf]
   ixgbevf_sw_init+0xe4/0x1f0 [ixgbevf]
   ixgbevf_probe+0x20f/0x4a0 [ixgbevf]
   local_pci_probe+0x50/0xa0
   work_for_cpu_fn+0x1a/0x30
   [...]

Add ixgbevf_hv_negotiate_features_vf() that returns -EOPNOTSUPP and
wire it into ixgbevf_hv_mac_ops. The caller already handles -EOPNOTSUPP
gracefully.

Fixes: a7075f501bd3 ("ixgbevf: fix mailbox API compatibility by negotiating supported features")
Reported-by: Xiaoqiang Xiong <xxiong@redhat.com>
Closes: https://issues.redhat.com/browse/RHEL-155455
Assisted-by: Claude:claude-4.6-opus-high Cursor
Tested-by: Xiaoqiang Xiong <xxiong@redhat.com>
Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbevf/vf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/vf.c b/drivers/net/ethernet/intel/ixgbevf/vf.c
index b67b580f7f1c9..f6df86d124b9e 100644
--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -709,6 +709,12 @@ static int ixgbevf_negotiate_features_vf(struct ixgbe_hw *hw, u32 *pf_features)
 	return err;
 }
 
+static int ixgbevf_hv_negotiate_features_vf(struct ixgbe_hw *hw,
+					    u32 *pf_features)
+{
+	return -EOPNOTSUPP;
+}
+
 /**
  *  ixgbevf_set_vfta_vf - Set/Unset VLAN filter table address
  *  @hw: pointer to the HW structure
@@ -1142,6 +1148,7 @@ static const struct ixgbe_mac_operations ixgbevf_hv_mac_ops = {
 	.setup_link		= ixgbevf_setup_mac_link_vf,
 	.check_link		= ixgbevf_hv_check_mac_link_vf,
 	.negotiate_api_version	= ixgbevf_hv_negotiate_api_version_vf,
+	.negotiate_features	= ixgbevf_hv_negotiate_features_vf,
 	.set_rar		= ixgbevf_hv_set_rar_vf,
 	.update_mc_addr_list	= ixgbevf_hv_update_mc_addr_list_vf,
 	.update_xcast_mode	= ixgbevf_hv_update_xcast_mode,
-- 
2.53.0




