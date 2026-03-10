Return-Path: <stable+bounces-224416-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAkZGPgDsGlAegIAu9opvQ
	(envelope-from <stable+bounces-224416-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:43:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E83FC24B6EB
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 681D2322F84F
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A17241C0BC;
	Tue, 10 Mar 2026 11:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZK5sVUz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB9C388E65;
	Tue, 10 Mar 2026 11:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142150; cv=none; b=Gdxb5IIHp1mi/MAhZ2KxrWBlcTcLHRFivcmQE3Ev11G1PXsBvqozEPsiQzh1Kc9l2YipJusBd8NQlhWaEv+ulkpE3E4+92pKb0/s/aqDOr3CGdTT93wgDOv+K8KvKZVns8U1w8FRQJ2y7G5nmBWd9Viux07zG7b45t8BHTr4c4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142150; c=relaxed/simple;
	bh=vzHeDVNfroUBXFi5WKkCMGLEhsHjAq9KGfaGMQrRu28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iToOj5RhLmmlZjWh17ng/fqpTwNasMEidDxtg5EfPLkJOhLynXAVEAoA3u0Btev9VqNiPT/w/JTwQ0ox19tzR7vf0iryX3tklPGLeaOG2st/X8MmaI6WYuuZs3pg3QAzk5YAU7wXsH908OkUWAEW3KeodE1vlJ1kG+Gbj4xANT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZK5sVUz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45480C2BCAF;
	Tue, 10 Mar 2026 11:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142149;
	bh=vzHeDVNfroUBXFi5WKkCMGLEhsHjAq9KGfaGMQrRu28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IZK5sVUzlxs/04rq2/r0amF2QK9LvtmABEZQpbRf1qJGfUi5X1fWXt0HqjDGQPXvf
	 FsoZACi8u5ufLW2HNkr4viVZLu2TbhXTwA5Ux7S8ecdo4XYdoZL1ybYxA4VlBZN/tE
	 z0iugXOdltLXsdvHRij5AJZ1g4+fLeY8hUv5xz/IzEIa1jEV80Xy3KDNieJjz9MKxG
	 ZbST7lOKbCNnQJ01W+EPT3C8FyfZ3CABaEelWdTXYTheNg5q258nQB8SYzipXW0TwE
	 DXt5HaTm3SBR6Q/xfiC46HgisgXllBzfhaljABPazzkk25FVKBc0Hkkq/e+iEgomhq
	 YzBs2k3AAOqYA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: MD Danish Anwar <danishanwar@ti.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 237/314] net: ti: icssg-prueth: Fix ping failure after offload mode setup when link speed is not 1G
Date: Tue, 10 Mar 2026 07:18:16 -0400
Message-ID: <ebe822ce82c2a754e813a593c333ea89f873b2f6.1773141555.git.sashal@kernel.org>
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
X-Rspamd-Queue-Id: E83FC24B6EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224416-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,ti.com:email]
X-Rspamd-Action: no action

From: MD Danish Anwar <danishanwar@ti.com>

[ Upstream commit 147792c395db870756a0dc87ce656c75ae7ab7e8 ]

When both eth interfaces with links up are added to a bridge or hsr
interface, ping fails if the link speed is not 1Gbps (e.g., 100Mbps).

The issue is seen because when switching to offload (bridge/hsr) mode,
prueth_emac_restart() restarts the firmware and clears DRAM with
memset_io(), setting all memory to 0. This includes PORT_LINK_SPEED_OFFSET
which firmware reads for link speed. The value 0 corresponds to
FW_LINK_SPEED_1G (0x00), so for 1Gbps links the default value is correct
and ping works. For 100Mbps links, the firmware needs FW_LINK_SPEED_100M
(0x01) but gets 0 instead, causing ping to fail. The function
emac_adjust_link() is called to reconfigure, but it detects no state change
(emac->link is still 1, speed/duplex match PHY) so new_state remains false
and icssg_config_set_speed() is never called to correct the firmware speed
value.

The fix resets emac->link to 0 before calling emac_adjust_link() in
prueth_emac_common_start(). This forces new_state=true, ensuring
icssg_config_set_speed() is called to write the correct speed value to
firmware memory.

Fixes: 06feac15406f ("net: ti: icssg-prueth: Fix emac link speed handling")
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Link: https://patch.msgid.link/20260226102356.2141871-1-danishanwar@ti.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index e42d0fdefee12..07489564270b2 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -270,6 +270,14 @@ static int prueth_emac_common_start(struct prueth *prueth)
 		if (ret)
 			goto disable_class;
 
+		/* Reset link state to force reconfiguration in
+		 * emac_adjust_link(). Without this, if the link was already up
+		 * before restart, emac_adjust_link() won't detect any state
+		 * change and will skip critical configuration like writing
+		 * speed to firmware.
+		 */
+		emac->link = 0;
+
 		mutex_lock(&emac->ndev->phydev->lock);
 		emac_adjust_link(emac->ndev);
 		mutex_unlock(&emac->ndev->phydev->lock);
-- 
2.51.0


