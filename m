Return-Path: <stable+bounces-223622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOskBzW1rmkSHwIAu9opvQ
	(envelope-from <stable+bounces-223622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 12:55:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB19238434
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 12:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F16B302B839
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 11:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCAE3A5E92;
	Mon,  9 Mar 2026 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ed2VF7d4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBD13A4525
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057242; cv=none; b=j9D2myZ6lfOpmq+fPGvVZmGUXfHkQ9Xg0Efrp9WwMumM61RQa0Gr0YWBUippsFADVSA/DNct7xmdQXnz8bagmUHS4LZwJPut3+QFg6kgeXaG5G5x/mOUquBcNN/h//1HrMufOFoIDE3A+Jujzp2RQmLNa5ZLKug+gdRk1iQm1Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057242; c=relaxed/simple;
	bh=X/+zob7ZhxaLHUNfCEjz1njTM6ff/CxwgbQ73QGxHqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8cYOgR22FgPgWoeKz1j6/82U4mnDw8syoZSsUJEDE9iOYRHUnPD5GdGgvR4BICtM5T2OeyePivZa44WZPMd70i9t6FHEEK04DY9dXE9MIncGjyaiLidlLbf/KFRd7Aeqbhjd6UEAxiSb4Gz7u+t1f5qNeuYZfmilowRk/s4XVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ed2VF7d4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62536C4CEF7;
	Mon,  9 Mar 2026 11:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773057241;
	bh=X/+zob7ZhxaLHUNfCEjz1njTM6ff/CxwgbQ73QGxHqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ed2VF7d4ONLygzS4rewr+6e7Gx10SBZbVs8v5rPOLwDfIbYdl9kWxQdq8qA4Eqyi1
	 ZfSFkjSpVgHXGDneZNhSLMX0A9ZifJj4wH+rViHSF3aWCHXJzJVmGTI2xRHlxZjFfb
	 ZK0/JYAjq/y615/b01iv3g5ryemjOZcgakGSTOb2f5bCILa7SguIp7+bVi0bM+vMVh
	 m0xUpFfUTgHWKTMrLPH602IapJc3CCtXJb44bXviSbmB4ZXv9r/dCBiCsEmzkcHMgq
	 KJSaR6mJz5miFEa4Xr9dSt9brRPUV0KXdUfBtXOmq84AZnM3dfppONXTa7gb9qZEN/
	 hVyYAhTn/Nftg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vahagn Vardanian <vahagn@redrays.io>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] wifi: mac80211: fix NULL pointer dereference in mesh_rx_csa_frame()
Date: Mon,  9 Mar 2026 07:53:59 -0400
Message-ID: <20260309115359.840072-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026030901-expensive-cosmetics-5a04@gregkh>
References: <2026030901-expensive-cosmetics-5a04@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7DB19238434
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223622-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Action: no action

From: Vahagn Vardanian <vahagn@redrays.io>

[ Upstream commit 017c1792525064a723971f0216e6ef86a8c7af11 ]

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
[ adapted pointer access elems-> to stack struct elems, and replaced goto free with return ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mesh.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index d3a9ce1f8e53f..20b8ff83e3dbd 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1435,6 +1435,9 @@ static void mesh_rx_csa_frame(struct ieee80211_sub_if_data *sdata,
 	if (!mesh_matches_local(sdata, &elems))
 		return;
 
+	if (!elems.mesh_chansw_params_ie)
+		return;
+
 	ifmsh->chsw_ttl = elems.mesh_chansw_params_ie->mesh_ttl;
 	if (!--ifmsh->chsw_ttl)
 		fwd_csa = false;
-- 
2.51.0


