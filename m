Return-Path: <stable+bounces-229018-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFAqN7BrwWkVTAQAu9opvQ
	(envelope-from <stable+bounces-229018-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:34:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABF92F85C0
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5E9331CC6D4
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDDD39182F;
	Mon, 23 Mar 2026 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tLJyLfH3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BE92D9ECB;
	Mon, 23 Mar 2026 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277797; cv=none; b=tHZbFQCmtCdBepa2BmAvUuMU0n9WPfFD1WUBYGRymYzfimGoR1Ayo7tRxXbLFwx+lkvVlbqlwIKhR4daIiDJD+xVpZdfOxJhI4BtvfE5ssILVQQ3UoF5gyncQrsQOam1cbmmzgIR5ftjkELWue0eBhOQLXGeVs5ugDPzJybrbLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277797; c=relaxed/simple;
	bh=gajc+07gG6oG12zuhw4AjAQG1PhO2Jb0bIWiQGl3xiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdBysNstnoU6PJB+OrMoiF3T3Y6QTD+ABWbW3NPlDVMcOTJYULmGMS3HKwC0rueg4zXtlZvlzLj7cF1nBiJ/E6QmKbgO1yYGfRRPEBapPre8RFvi+gQsGmKmYEfcB6qy4mwOI2pxOcUP2zqtbN0RLUcQnOv+Mrc9zF9yZt6PC8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tLJyLfH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97A2C4CEF7;
	Mon, 23 Mar 2026 14:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277797;
	bh=gajc+07gG6oG12zuhw4AjAQG1PhO2Jb0bIWiQGl3xiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tLJyLfH3oDkfxtPdg1fz3JupOdvjG/44DpWVTpt3Wij201ffVAKJC5OAegLSAj1h/
	 C7APv+TMfQr+1Av1zglIUpuwS/7jaO1D03TDpBP+1Lb8qPxO+wfF5r1UODNwzsPi2r
	 oKfxeNSY3whWUU2w2tpQLh+981kjY4Owcn0S6oAA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vahagn Vardanian <vahagn@redrays.io>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.6 107/567] wifi: mac80211: fix NULL pointer dereference in mesh_rx_csa_frame()
Date: Mon, 23 Mar 2026 14:40:27 +0100
Message-ID: <20260323134536.467153543@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229018-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6ABF92F85C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vahagn Vardanian <vahagn@redrays.io>

commit 017c1792525064a723971f0216e6ef86a8c7af11 upstream.

In mesh_rx_csa_frame(), elems->mesh_chansw_params_ie is dereferenced
at lines 1638 and 1642 without a prior NULL check:

    ifmsh->chsw_ttl = elems->mesh_chansw_params_ie->mesh_ttl;
    ...
    pre_value = le16_to_cpu(elems->mesh_chansw_params_ie->mesh_pre_value);

The mesh_matches_local() check above only validates the Mesh ID,
Mesh Configuration, and Supported Rates IEs.  It does not verify the
presence of the Mesh Channel Switch Parameters IE (element ID 118).
When a received CSA action frame omits that IE, ieee802_11_parse_elems()
leaves elems->mesh_chansw_params_ie as NULL, and the unconditional
dereference causes a kernel NULL pointer dereference.

A remote mesh peer with an established peer link (PLINK_ESTAB) can
trigger this by sending a crafted SPECTRUM_MGMT/CHL_SWITCH action frame
that includes a matching Mesh ID and Mesh Configuration IE but omits the
Mesh Channel Switch Parameters IE.  No authentication beyond the default
open mesh peering is required.

Crash confirmed on kernel 6.17.0-5-generic via mac80211_hwsim:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  Oops: Oops: 0000 [#1] SMP NOPTI
  RIP: 0010:ieee80211_mesh_rx_queued_mgmt+0x143/0x2a0 [mac80211]
  CR2: 0000000000000000

Fix by adding a NULL check for mesh_chansw_params_ie after
mesh_matches_local() returns, consistent with how other optional IEs
are guarded throughout the mesh code.

The bug has been present since v3.13 (released 2014-01-19).

Fixes: 8f2535b92d68 ("mac80211: process the CSA frame for mesh accordingly")
Cc: stable@vger.kernel.org
Signed-off-by: Vahagn Vardanian <vahagn@redrays.io>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac80211/mesh.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1640,6 +1640,9 @@ static void mesh_rx_csa_frame(struct iee
 	if (!mesh_matches_local(sdata, elems))
 		goto free;
 
+	if (!elems->mesh_chansw_params_ie)
+		goto free;
+
 	ifmsh->chsw_ttl = elems->mesh_chansw_params_ie->mesh_ttl;
 	if (!--ifmsh->chsw_ttl)
 		fwd_csa = false;



