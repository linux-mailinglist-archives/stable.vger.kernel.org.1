Return-Path: <stable+bounces-258999-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDb4GPcuG2qU/wgAu9opvQ
	(envelope-from <stable+bounces-258999-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:39:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D41612314
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8D8E303B538
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0906F33E36A;
	Sat, 30 May 2026 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g3cJAMAz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC8E39A7FE;
	Sat, 30 May 2026 18:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780166256; cv=none; b=GfuIP635KL528FW+UGh6DXRM5aGs7Gs3luqFxe2UyoIHQoJMwJTXVhM2afJ3vqYyvf0YAuqu5LzMHI/6Gn7BVnt+hWbQnqQA/ZTTtGkqCuR5bc+/lCxCGA9Sp39YdKaOW5ZTzazWtSomKrvcWEuG6i04kZIOcXZ0esVMP48gzjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780166256; c=relaxed/simple;
	bh=wU7tZwWMOKCXhiFWm1ZlcvLJY6d+ksDv04YHK3be9Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/JMCgBFVHhYmb4ieMDcGpawpLqq9WQB+7totxaldqbtSFVgT4W/XamzTvzSUA70DJlXRuFyVRBac7FQwoSaKtbcFxMIVCFGabP5tCjJqn9RBicUZO6hnGSlq7tft3FIHAoOC/pMCB8ok+mSEaDwfI5zzm0+FSTI8ncOkUSCHwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g3cJAMAz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870171F00893;
	Sat, 30 May 2026 18:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780166255;
	bh=gyCxHEgJ68IvjlF/qFz7UyhpgElbq4MLJFjbElwRNoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g3cJAMAzRvZZDPiaIsUmGkKhT3c2FYk5u7EPkLm9Bivm8kN7kW1kQ5a99xtliUyPC
	 UqqdUWWJjsfWAiYK6AYe01sq4w74ehUK6QIZJXfPF8znGJBc2fmrHYec16j4AxIWOH
	 ANENKI0yGvH+Dq0uPrsfxQssb2KT/fIuwbJMuUBw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 317/589] Bluetooth: fix locking in hci_conn_request_evt() with HCI_PROTO_DEFER
Date: Sat, 30 May 2026 18:03:18 +0200
Message-ID: <20260530160233.268244054@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258999-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,iki.fi:email]
X-Rspamd-Queue-Id: 04D41612314
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pauli Virtanen <pav@iki.fi>

[ Upstream commit 5c7209a341ff2ac338b2b0375c34a307b37c9ac2 ]

When protocol sets HCI_PROTO_DEFER, hci_conn_request_evt() calls
hci_connect_cfm(conn) without hdev->lock. Generally hci_connect_cfm()
assumes it is held, and if conn is deleted concurrently -> UAF.

Only SCO and ISO set HCI_PROTO_DEFER and only for defer setup listen,
and HCI_EV_CONN_REQUEST is not generated for ISO.  In the non-deferred
listening socket code paths, hci_connect_cfm(conn) is called with
hdev->lock held.

Fix by holding the lock.

Fixes: 70c464256310 ("Bluetooth: Refactor connection request handling")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6310f4f9890eb..a2995dcb0ffeb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2786,8 +2786,6 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	memcpy(conn->dev_class, ev->dev_class, 3);
 
-	hci_dev_unlock(hdev);
-
 	if (ev->link_type == ACL_LINK ||
 	    (!(flags & HCI_PROTO_DEFER) && !lmp_esco_capable(hdev))) {
 		struct hci_cp_accept_conn_req cp;
@@ -2821,7 +2819,6 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_connect_cfm(conn, 0);
 	}
 
-	return;
 unlock:
 	hci_dev_unlock(hdev);
 }
-- 
2.53.0




