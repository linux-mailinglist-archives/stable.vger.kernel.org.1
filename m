Return-Path: <stable+bounces-234338-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCmxAvee1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234338-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:31:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB493C0DC3
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5971C3133D7E
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAB13D9DB0;
	Wed,  8 Apr 2026 18:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a7kuxp7j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC7D3D522C;
	Wed,  8 Apr 2026 18:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672600; cv=none; b=uCdDRwWA98cCY6QWVl1s+vPJU+mT9ULocKqzM9KGhYKIYjH2SN+4kT/iD/rLMORDhu+0ISs9ihWsLhn0iskeJCaM39IsQ9O63N+rcdbh+9ImeffVeegn4TX05B+cJQGqRH3U/vF83gUosO1OqIikw6KBWksgj2TkaxwqUPamcDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672600; c=relaxed/simple;
	bh=IRt/fKMCQ/kUfzILNXiTPIfOA935sa47FVcAvuQlvNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/531mpYLlSZBJzzYOLBHnLURzkIIMHKDs13yRncMz3+r3/duO84if1nynB9+qc1KDoHIaGqthCnDZmPH2u+lRy4Y1DIomvuXS0OnBdjoaHuyVOQ1FMvbl/hJWMRaFqLE2vbZYlJmlGxH7sY0tvJgS1XPm2eF/QwsAu24UOPvnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a7kuxp7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21902C19421;
	Wed,  8 Apr 2026 18:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672600;
	bh=IRt/fKMCQ/kUfzILNXiTPIfOA935sa47FVcAvuQlvNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7kuxp7jKLW8Nk2LnfcBfXKeTSZdhCI//L+/Zu6W8VIFOg+IHTT8MfrTrD7c/lcv6
	 vJB+d2Gy0pOXmcQrEhCRPCktqBuru/FGp5GefzwSq1Nvmawkn9G6juSK1IS9MqUWS+
	 b8Qu9Uwy44r6YuuqBI6YI1hq6fBwB45RZJjEjris=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luka Gejak <luka.gejak@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 062/160] net: hsr: fix VLAN add unwind on slave errors
Date: Wed,  8 Apr 2026 20:02:29 +0200
Message-ID: <20260408175915.521370334@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175913.177092714@linuxfoundation.org>
References: <20260408175913.177092714@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234338-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 5FB493C0DC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luka Gejak <luka.gejak@linux.dev>

[ Upstream commit 2e3514e63bfb0e972b1f19668547a455d0129e88 ]

When vlan_vid_add() fails for a secondary slave, the error path calls
vlan_vid_del() on the failing port instead of the peer slave that had
already succeeded. This results in asymmetric VLAN state across the HSR
pair.

Fix this by switching to a centralized unwind path that removes the VID
from any slave device that was already programmed.

Fixes: 1a8a63a5305e ("net: hsr: Add VLAN CTAG filter support")
Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
Link: https://patch.msgid.link/20260401092243.52121-3-luka.gejak@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/hsr/hsr_device.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index 70e958caa956d..b34a9b680aab3 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -473,8 +473,8 @@ static void hsr_change_rx_flags(struct net_device *dev, int change)
 static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
 				   __be16 proto, u16 vid)
 {
-	bool is_slave_a_added = false;
-	bool is_slave_b_added = false;
+	struct net_device *slave_a_dev = NULL;
+	struct net_device *slave_b_dev = NULL;
 	struct hsr_port *port;
 	struct hsr_priv *hsr;
 	int ret = 0;
@@ -490,33 +490,35 @@ static int hsr_ndo_vlan_rx_add_vid(struct net_device *dev,
 		switch (port->type) {
 		case HSR_PT_SLAVE_A:
 			if (ret) {
-				/* clean up Slave-B */
 				netdev_err(dev, "add vid failed for Slave-A\n");
-				if (is_slave_b_added)
-					vlan_vid_del(port->dev, proto, vid);
-				return ret;
+				goto unwind;
 			}
-
-			is_slave_a_added = true;
+			slave_a_dev = port->dev;
 			break;
-
 		case HSR_PT_SLAVE_B:
 			if (ret) {
-				/* clean up Slave-A */
 				netdev_err(dev, "add vid failed for Slave-B\n");
-				if (is_slave_a_added)
-					vlan_vid_del(port->dev, proto, vid);
-				return ret;
+				goto unwind;
 			}
-
-			is_slave_b_added = true;
+			slave_b_dev = port->dev;
 			break;
 		default:
+			if (ret)
+				goto unwind;
 			break;
 		}
 	}
 
 	return 0;
+
+unwind:
+	if (slave_a_dev)
+		vlan_vid_del(slave_a_dev, proto, vid);
+
+	if (slave_b_dev)
+		vlan_vid_del(slave_b_dev, proto, vid);
+
+	return ret;
 }
 
 static int hsr_ndo_vlan_rx_kill_vid(struct net_device *dev,
-- 
2.53.0




