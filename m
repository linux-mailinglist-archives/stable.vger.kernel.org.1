Return-Path: <stable+bounces-239829-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLSQDLJo5mkNwAEAu9opvQ
	(envelope-from <stable+bounces-239829-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:56:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B29C24324A0
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A6073723DF4
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049B933F5BC;
	Mon, 20 Apr 2026 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dSMSpd3r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC791329C6D;
	Mon, 20 Apr 2026 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701322; cv=none; b=LKG9tcUCq4aRjGs5yJnqPkCxZ/pnLWGuz9FUNMhi8ldKSTavB4SyJNjByJrcMEXJy60JAbhxwYo3XGY5SB48xmbFMco5JempK7JsJiZY7h6Rao2pQ0ntJew6LtXsZ451cDTNR0evzMuEIou54F5G2YqDDJ+w4BnvEvYz/9tsSio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701322; c=relaxed/simple;
	bh=JzgQAlvsFGNkHVKkYAiAlhh7tzb5wLn0FTZus8TNF5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjkLCp6qMNhnTUiKQP8LeRQvvQVgk+ROI6j1eNoO87Lu92sk5kCHcfc+lvcuFGh1R8T71WQu+nFyCZ2fjJWZWsfrdlA2jGk8RdNztpCug0QTOCi2Zux2FEQzpyp2391vjt0iHiWLcmSoupk2oDV+ZuqyEyceitDv+bJor8KL+GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dSMSpd3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1212EC2BCB4;
	Mon, 20 Apr 2026 16:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776701322;
	bh=JzgQAlvsFGNkHVKkYAiAlhh7tzb5wLn0FTZus8TNF5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dSMSpd3r1SORWU3feSmx7t4l7vARVj4+Ovo7ceS9whu49ChUSeQ3YOdMUz2IbiGmu
	 3HdTH60Q+/n15MruFmZf3fzjPKbNPeqC5JFyyzvChNZyOF8Msm9IrbFn2VTP4uQHNd
	 CN14yOWcK2Um+F7c7G/WONuHFmW1SLkaled90SNc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Golle <daniel@makrotopia.org>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 068/162] selftests: net: bridge_vlan_mcast: wait for h1 before querier check
Date: Mon, 20 Apr 2026 17:41:40 +0200
Message-ID: <20260420153929.499136773@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153927.006696811@linuxfoundation.org>
References: <20260420153927.006696811@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-239829-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[siemens.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,makrotopia.org:email]
X-Rspamd-Queue-Id: B29C24324A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Golle <daniel@makrotopia.org>

[ Upstream commit efaa71faf212324ecbf6d5339e9717fe53254f58 ]

The querier-interval test adds h1 (currently a slave of the VRF created
by simple_if_init) to a temporary bridge br1 acting as an outside IGMP
querier. The kernel VRF driver (drivers/net/vrf.c) calls cycle_netdev()
on every slave add and remove, toggling the interface admin-down then up.
Phylink takes the PHY down during the admin-down half of that cycle.
Since h1 and swp1 are cable-connected, swp1 also loses its link may need
several seconds to re-negotiate.

Use setup_wait_dev $h1 0 which waits for h1 to return to UP state, so the
test can rely on the link being back up at this point.

Fixes: 4d8610ee8bd77 ("selftests: net: bridge: add vlan mcast_querier_interval tests")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Link: https://patch.msgid.link/c830f130860fd2efae08bfb9e5b25fd028e58ce5.1775424423.git.daniel@makrotopia.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
index 72dfbeaf56b92..e8031f68200ad 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_mcast.sh
@@ -414,6 +414,7 @@ vlmc_querier_intvl_test()
 	bridge vlan add vid 10 dev br1 self pvid untagged
 	ip link set dev $h1 master br1
 	ip link set dev br1 up
+	setup_wait_dev $h1 0
 	bridge vlan add vid 10 dev $h1 master
 	bridge vlan global set vid 10 dev br1 mcast_snooping 1 mcast_querier 1
 	sleep 2
-- 
2.53.0




