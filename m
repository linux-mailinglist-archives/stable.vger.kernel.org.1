Return-Path: <stable+bounces-255325-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SACjI+CfGGpvlggAu9opvQ
	(envelope-from <stable+bounces-255325-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:04:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B715F7C84
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78AD7301B146
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3793164B7;
	Thu, 28 May 2026 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2jb6jtdW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1464A27A476;
	Thu, 28 May 2026 20:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998592; cv=none; b=uItqWv8tjKJ3PQfFDoTcwJRWrnHRX/uoDphgF0l6+UuCrQPmpbKEiMJOfpIk7D3saPnbDUm0u1yOnpG4C0TOlT3acw3+a0N3RlPCEKvcmd++f97RnvYVw8VaXEfyd+VOqk7iilVWhw9UlgDeMoErh6Gy/jxdzYfRkiDgZf3eY3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998592; c=relaxed/simple;
	bh=5i+FbwxI+qS9D+Z6E8eDkveiwNkOyGvuJIXQ/0cQdwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvvQxgBym0exKMyrjSzwDE2CuUleYuGroAOr64aGJMj/TKvrmlK+jsmNpXJXSVd+yCO+2QuQVLj0AXVTbxj1kVXu+eSHwuLjz9rcXQ+ICBCy1Xt2cozQtQLae7YcvMjpml06cBdaMEpbN1puR6MgNEyWXc/E/6kVIyFSNNl6YLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2jb6jtdW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736A71F000E9;
	Thu, 28 May 2026 20:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779998591;
	bh=itneieVpOdVCIPbpNet71UrGwa3Ujmd6Nym9SwTdnpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=2jb6jtdWQKjkt1LKYcGenDNRolwJ49oAVyN4UAPI6DpV3/VAW3BH+nC3xMaMLnnHE
	 Ue/lHp3UeRso7mHYKq3Deqo1rCfSOO2L+IYV4O4VtQ6UEC1LK8pH3qDFo1CVPVO1KD
	 GX5xV/RCXe+ZVPxPg+26olWH/B5RhhahvhRHydgw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ijae Kim <ae878000@gmail.com>,
	Myeonghun Pak <mhun512@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 227/461] net: lan966x: avoid unregistering netdev on register failure
Date: Thu, 28 May 2026 21:45:56 +0200
Message-ID: <20260528194653.704524485@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-255325-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 37B715F7C84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit c4f3d6eb1fcf6cd9ce4644f604d5aad1ce594dfc ]

lan966x_probe_port() stores the newly allocated net_device in the
port before calling register_netdev(). If register_netdev() fails,
the probe error path calls lan966x_cleanup_ports(), which sees
port->dev and calls unregister_netdev() for a device that was never
registered.

Destroy the phylink instance created for this port and clear port->dev
before returning the registration error. The common cleanup path now skips
ports without port->dev before reaching the registered netdev cleanup, so
it only handles ports that reached the registered-netdev lifetime.

This also avoids treating an uninitialized FDMA netdev and the failed port
as a NULL == NULL match in the common cleanup path.

Fixes: d28d6d2e37d1 ("net: lan966x: add port module support")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Link: https://patch.msgid.link/20260506124331.31945-1-mhun512@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 47752d3fde0b1..1179a6e127c52 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -749,11 +749,10 @@ static void lan966x_cleanup_ports(struct lan966x *lan966x)
 
 	for (p = 0; p < lan966x->num_phys_ports; p++) {
 		port = lan966x->ports[p];
-		if (!port)
+		if (!port || !port->dev)
 			continue;
 
-		if (port->dev)
-			unregister_netdev(port->dev);
+		unregister_netdev(port->dev);
 
 		lan966x_xdp_port_deinit(port);
 		if (lan966x->fdma && lan966x->fdma_ndev == port->dev)
@@ -873,6 +872,9 @@ static int lan966x_probe_port(struct lan966x *lan966x, u32 p,
 	err = register_netdev(dev);
 	if (err) {
 		dev_err(lan966x->dev, "register_netdev failed\n");
+		phylink_destroy(phylink);
+		port->phylink = NULL;
+		port->dev = NULL;
 		return err;
 	}
 
-- 
2.53.0




