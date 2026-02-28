Return-Path: <stable+bounces-220552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WExgAFBOo2nw/QQAu9opvQ
	(envelope-from <stable+bounces-220552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:21:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 941EF1C8459
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CD78335620C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBDE3D6CAC;
	Sat, 28 Feb 2026 17:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGQtqvl+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8853D6CA1;
	Sat, 28 Feb 2026 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300434; cv=none; b=cwVyFJBNZ+HG5ZwJBRaecS2kRXlftSzotYZMEIHD0eAsRwqyaU/Xa55tE0h/TGyVZcxgSWdVJs8/XX3jKIGAwp92MK46gjZsXUSdcLovpWYh6zhtEfQZKwbfZ0yq+8kFPJtXzwG35OYuS0C3tQoXWN8j/D3i8N/J8yl0zl7qL6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300434; c=relaxed/simple;
	bh=bAekLvKe5cXYjCit2m3nXXMiwpO0zC6TC3rs3T5uT+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kU16+uqv/EzDYCUiN1d2/OCYyYCZ6IJCAy37GIyl2fHhHXoqeafj/8Gg+rA+udWjyltJ9w8hOwjB/N9fCJoC0yI7M0SHLuEdGcmPv48XNu+ZIudmz4TtsFRM0fRDtauqllSssSLruH3wOE2YQYHJgu7wUw7WGDYHgU2FFIA2k9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGQtqvl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4EAC2BC87;
	Sat, 28 Feb 2026 17:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300433;
	bh=bAekLvKe5cXYjCit2m3nXXMiwpO0zC6TC3rs3T5uT+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BGQtqvl+8X7SF22gnHYtagtq2cD9kO5CLLqFPSnimszG9xe5Bq2vkx3zZyzuhS7Gu
	 TSZrJ++LId+BBSiJf7gNwFyZ+gC42CzBk93J+LypmPJ9AYe6UbwNQVmc6slmwINNqo
	 AInayieQ/mYBoSYd45GNpTAr7tgGRNiELvRSswvCPeH8U9bn0CxqlA+IdHVy0Rl9/T
	 qssA4lxBSQ1PQ1HHpGw5oGnZPaVGBIoto0rkYNUofE/Cffm+2ay4DW8w/k72zOYJ6g
	 Z348ZHVEegKhr/DGy0BiO13pCPG/+gjSmvBpmQMq3aCYqxKUtKK8/KVNpjeOWzu+c1
	 GJ7knjyEF4ldA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 473/844] Bluetooth: L2CAP: Fix response to L2CAP_ECRED_CONN_REQ
Date: Sat, 28 Feb 2026 12:26:26 -0500
Message-ID: <20260228173244.1509663-474-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220552-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 941EF1C8459
X-Rspamd-Action: no action

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 05761c2c2b5bfec85c47f60c903c461e9b56cf87 ]

Similar to 03dba9cea72f ("Bluetooth: L2CAP: Fix not responding with
L2CAP_CR_LE_ENCRYPTION") the result code L2CAP_CR_LE_ENCRYPTION shall
be used when BT_SECURITY_MEDIUM is set since that means security mode 2
which mean it doesn't require authentication which results in
qualification test L2CAP/ECFC/BV-32-C failing.

Link: https://github.com/bluez/bluez/issues/1871
Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced Credit Based Mode")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/l2cap_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0b236e977d70e..a5038160675ea 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -5096,7 +5096,8 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 
 	if (!smp_sufficient_security(conn->hcon, pchan->sec_level,
 				     SMP_ALLOW_STK)) {
-		result = L2CAP_CR_LE_AUTHENTICATION;
+		result = pchan->sec_level == BT_SECURITY_MEDIUM ?
+			L2CAP_CR_LE_ENCRYPTION : L2CAP_CR_LE_AUTHENTICATION;
 		goto unlock;
 	}
 
-- 
2.51.0


