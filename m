Return-Path: <stable+bounces-264577-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7nK+Lxp5MWrwkAUAu9opvQ
	(envelope-from <stable+bounces-264577-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:26:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29136692112
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:26:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=yEIjdlQG;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264577-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264577-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B6C130BDCD6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EF446AF21;
	Tue, 16 Jun 2026 16:17:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93415466B57;
	Tue, 16 Jun 2026 16:17:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626653; cv=none; b=BTw6JoTeGiD2kf/5QIObu7QfjlylkP/o2B6ZEbl4oaOGfiN9ISwwAlci7oxzU+qjkCiek2aE33TYXMUHjfAgEuYuST5EWhPpq6wxA2ke6t33BT/Br0SRYTMOuMOAGuUc8AVs8QX2n+7EupreBd8GA2B5NBJ9g4mLuCZf/H1xvyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626653; c=relaxed/simple;
	bh=08WogQl0urN7LO06YIAR2XWlrn0Dbiyv76r9y6yEEgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8SqsllSLkEBXXCPKMEQSOA3rm+7xE/9trXyC10+aC/FF0u6gozcfnji7T9IFDJ5jC43R9CpjkoCXISf8PI6Tl+wet8LdCkkmuKuSDgeVzFeFPJ/t7jI/v5yF17D/lzwbWHXeMkebRQY18VCLu7mwZbpUH/rfSwy3jEkUkZjsO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yEIjdlQG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666E71F00A3A;
	Tue, 16 Jun 2026 16:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781626652;
	bh=tBgLdX3siB8xLw85vxz5HHQV+LFfM4tzu8TVe2SSH2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yEIjdlQGhxj6KjWJo8I8bf11OxVWgfQf0Oxm1eNukv1ht4ckTFmS/toTSQF8yfknN
	 8RDCIKuCeB8dEhB/wt+YND/3ZgzQ2PwOO/xcS78dpwviH0JTI8UDqrUCrH0moZ/i+9
	 DPjZAdYqgi6hJfRgkrkCC4e8eG5cr4QGGm7PPegM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sashiko <sashiko-bot@kernel.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 043/261] Bluetooth: ISO: Fix not releasing hdev reference on iso_conn_big_sync
Date: Tue, 16 Jun 2026 20:28:01 +0530
Message-ID: <20260616145047.098673912@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264577-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:sashiko-bot@kernel.org,m:luiz.von.dentz@intel.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 29136692112

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

[ Upstream commit 5cbf290b79351971f20c7a533247e8d58a3f970c ]

hci_get_route() returns a reference-counted hci_dev pointer via
hci_dev_hold(). The function exits normally or with an error without ever
releasing it.

Fixes: 07a9342b94a9 ("Bluetooth: ISO: Send BIG Create Sync via hci_sync")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/iso.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index f262c32da4f29b..935e230484b78c 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1445,6 +1445,7 @@ static void iso_conn_big_sync(struct sock *sk)
 
 	release_sock(sk);
 	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
 }
 
 static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
-- 
2.53.0




