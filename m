Return-Path: <stable+bounces-220396-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EA6KAjA0o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220396-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:30:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 943AC1C5DF5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC27A3359D73
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1934C3AB445;
	Sat, 28 Feb 2026 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVIlfmK1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCA53AB43B;
	Sat, 28 Feb 2026 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300288; cv=none; b=c/bzYksHblhAuXRba0wkTJJQDIMTwxnlAy0mBS4iI6XunifeWgu1tzhlC/vIpacEHzMvBA/AKwDBnZGgeS57iVtI9xf5AtuXPnnk38iEti9NMMqlqcfUvQMbRF4yeFoddcLGcXLcn4+nXBRwa+Vy8N+Jnkb16FSUtE8mtsOSZIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300288; c=relaxed/simple;
	bh=+FuiE37p1GIm7r8cnuNB6Z3inMMRPCWdZVfvrWDVax0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTMSD1xONsKwLVuxlxfKhEtYXX/xhjfGROav+jtxKWWnrxFHIhurl12wOBb6TuHgTWWSlJ2TT1pZhU55r0YUsYs2gFFys8M3p5RCPfgoxrv2aHQd/XYS6RdNJpdzk4vRoZwUou6Rz1KFbX+RRyFGU6JbMezULdfPrgZKfi34VRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVIlfmK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A1CC116D0;
	Sat, 28 Feb 2026 17:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300288;
	bh=+FuiE37p1GIm7r8cnuNB6Z3inMMRPCWdZVfvrWDVax0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rVIlfmK1/km97MXnmPUK7MlzBlJDwZBhWzegXScOacqMJCYkpejFYHtmXYNCQw+bn
	 usi8pnu17Zx526bOeEynuRvGz7J1DFbhmOlzJZWsWyJSjFNndW3FE3hfxCiXrPHaWe
	 8EP/BGb6UrAx1uhlQznO8JW23FCEuNTwqSbjSaWIWK7OrwnJRXP9NHvRZHCX+2RaUe
	 meZEKX/cdBpB4fUI0VHUtXaU09ukttiyVS6UyQBGXjSdAEOGV2Y/L2eHO82awQPWj9
	 dbW2B4e4E+f8YOahdJY10hl92XJFmuSJdd197Og+bkog8vKf61YGIPsj2Q3SJsi/EF
	 zZG1Dpuc4dfdw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 317/844] Bluetooth: hci_conn: Set link_policy on incoming ACL connections
Date: Sat, 28 Feb 2026 12:23:50 -0500
Message-ID: <20260228173244.1509663-318-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220396-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 943AC1C5DF5
X-Rspamd-Action: no action

From: Stefan Sørensen <ssorensen@roku.com>

[ Upstream commit 4bb091013ab0f2edfed3f58bebe658a798cbcc4d ]

The connection link policy is only set when establishing an outgoing
ACL connection causing connection idle modes not to be available on
incoming connections. Move the setting of the link policy to the
creation of the connection so all ACL connection will use the link
policy set on the HCI device.

Signed-off-by: Stefan Sørensen <ssorensen@roku.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_conn.c | 1 +
 net/bluetooth/hci_sync.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 5a4374ccf8e84..98f0461b3dd7d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1002,6 +1002,7 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type,
 	switch (type) {
 	case ACL_LINK:
 		conn->pkt_type = hdev->pkt_type & ACL_PTYPE_MASK;
+		conn->link_policy = hdev->link_policy;
 		conn->mtu = hdev->acl_mtu;
 		break;
 	case LE_LINK:
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index cbc3a75d73262..334eb4376a266 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6897,8 +6897,6 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 
 	conn->attempt++;
 
-	conn->link_policy = hdev->link_policy;
-
 	memset(&cp, 0, sizeof(cp));
 	bacpy(&cp.bdaddr, &conn->dst);
 	cp.pscan_rep_mode = 0x02;
-- 
2.51.0


