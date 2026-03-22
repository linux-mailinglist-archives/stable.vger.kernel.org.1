Return-Path: <stable+bounces-227804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id r4TuOJFFv2mj0wMAu9opvQ
	(envelope-from <stable+bounces-227804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 02:27:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 385202E7DD3
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 02:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7B1A300E718
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 01:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D480B3750C5;
	Sun, 22 Mar 2026 01:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPmy/hQK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9603A375AA9
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 01:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774142861; cv=none; b=lQsM5UmKUrVQIDwDvWIcwqEyOO5Mm/jxXJd6sSIi+j1CZZfdo4sJrfJYtW6zq31v09vpQuJRC1IXluhR0MP/qD1dfEo29nalr5EHhLQ7DsxVojfvoCBwIxEOGSfPHM/WIem339r5l3JYE/GhBbN66uviWIh3Dkk3f/r/QXZhvpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774142861; c=relaxed/simple;
	bh=oS2MML9CIH3w+3GAHGlCi36bnzdCQBHRbPyK9p8TinM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUfWpJYh9Bv1tAAesP2nU18d98o5J2QRq7jkwCtbzQ7lFKKZXQ+gA5Z3/QCN2C5Oovi0t3OyYfgLESLzeZ4yiek/qqJyVEthjJPssvmoQ2W6R+hxEz3A2Y78OaZRmPrPbmfSFh/6KBa574PaZQEVL1pF6WdB1SRLXNHXC5YP2M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPmy/hQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06256C2BCB0;
	Sun, 22 Mar 2026 01:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774142861;
	bh=oS2MML9CIH3w+3GAHGlCi36bnzdCQBHRbPyK9p8TinM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sPmy/hQKtsIFJVeUZdgfuQtm5vOisCqi2Aerr9/HBfVR23vV9DQ9Kvv6iTpIsHWJl
	 RfDcm2VPPTr+SuYe011XwKjUysR/QKhQPCPQ0nkj4v5YvWEiK5c+eVPPmgL+tbyiA6
	 CVaYVDamD1WPQgBnjs6EAzUjswqBgaU6V3jukbqamt6gkDGRzgdGfZUvDzSs7waJSK
	 ul3ntRVWoUVQ9bnJ8yIf5EDTLn+S8BxxqeHyZV+WGjH4EOxwxRcZf8Yz9NjNmoLsK6
	 EdIolvTDlDKZZU6L51rrjPuKhrVlx4HDdQuWf9gfhS6INipOshTFr4PxJ/sov5nbIK
	 FTY5mMgEVAsHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Yiming Qian <yimingqian591@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ
Date: Sat, 21 Mar 2026 21:27:39 -0400
Message-ID: <20260322012739.673067-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026032112-attain-reprocess-ab80@gregkh>
References: <2026032112-attain-reprocess-ab80@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[intel.com,gmail.com,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227804-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	HAS_WP_URI(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 385202E7DD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 5b3e2052334f2ff6d5200e952f4aa66994d09899 ]

Currently the code attempts to accept requests regardless of the
command identifier which may cause multiple requests to be marked
as pending (FLAG_DEFER_SETUP) which can cause more than
L2CAP_ECRED_MAX_CID(5) to be allocated in l2cap_ecred_rsp_defer
causing an overflow.

The spec is quite clear that the same identifier shall not be used on
subsequent requests:

'Within each signaling channel a different Identifier shall be used
for each successive request or indication.'
https://www.bluetooth.com/wp-content/uploads/Files/Specification/HTML/Core-62/out/en/host/logical-link-control-and-adaptation-protocol-specification.html#UUID-32a25a06-4aa4-c6c7-77c5-dcfe3682355d

So this attempts to check if there are any channels pending with the
same identifier and rejects if any are found.

Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
[ adapted variable names ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 88f8c98afd5f5..d9ac64bc5407e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6036,7 +6036,7 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	u16 mtu, mps;
 	__le16 psm;
 	u8 result, len = 0;
-	int i, num_scid;
+	int i, num_scid = 0;
 	bool defer = false;
 
 	if (!enable_ecred)
@@ -6047,6 +6047,14 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 		goto response;
 	}
 
+	/* Check if there are no pending channels with the same ident */
+	__l2cap_chan_list_id(conn, cmd->ident, l2cap_ecred_list_defer,
+			     &num_scid);
+	if (num_scid) {
+		result = L2CAP_CR_LE_INVALID_PARAMS;
+		goto response;
+	}
+
 	cmd_len -= sizeof(*req);
 	num_scid = cmd_len / sizeof(u16);
 
-- 
2.51.0


