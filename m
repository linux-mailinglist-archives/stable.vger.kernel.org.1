Return-Path: <stable+bounces-225151-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yM7IBFYhs2m5SQAAu9opvQ
	(envelope-from <stable+bounces-225151-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:25:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF44627909B
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77DC43054C94
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF24D2D2491;
	Thu, 12 Mar 2026 20:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EiepJynO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5FF374E44;
	Thu, 12 Mar 2026 20:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347148; cv=none; b=VgMXpw0OAP2w5ug9w7s/7Nirj29klrwFf9xwqUsEmKzcnXfyWZ0RU8XNSGvFRu0irI8d1yb+dOdax/r67ys554L3gezeE7+3MjMc6ldtyqhDN50EJzkmp/3gTKDT//hIssY69wbaf5DWarU/Wt6S91a9cM3h3z80Q5OTTGQzX2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347148; c=relaxed/simple;
	bh=/iywMNXZgDhrXpMlvMmKi5bqtg6+gs34TZzGSaEl1zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5U4Ise3H+tzKcDNktp5+9bj/rSS0ijwLT8ApnUruoQQXFdRlRCV3bkDh1XjS1mEjgvuLNGMH1rYn5NBcb//ZmnfDKhn6wjt0+Kfvha2ZBHUo0N4EopQETN9O8IbkkmiUtGK+JcKy6zI8F+ojPDoBEVce53QhqXJSsDw6EzxL9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EiepJynO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A16C4CEF7;
	Thu, 12 Mar 2026 20:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773347148;
	bh=/iywMNXZgDhrXpMlvMmKi5bqtg6+gs34TZzGSaEl1zY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EiepJynO8AoUnpEGzjuvxpmFjUAHd7lOe5xw5VKnn3adAwnsoe1NKePxrzHnDA9/0
	 zYYjxQVhgsmWJLx6c/MzQIuvaDT4aF3234MLHVrd8mB3fd9cm4d/zQ15IYsHv63BuV
	 BCuVvuECrhrE2wLwzH4s4Sh9Zlh6Kiwima/glrBQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+72e3ea390c305de0e259@syzkaller.appspotmail.com,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 190/265] atm: lec: fix null-ptr-deref in lec_arp_clear_vccs
Date: Thu, 12 Mar 2026 21:09:37 +0100
Message-ID: <20260312201025.177123317@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225151-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,72e3ea390c305de0e259];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linaro.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,appspotmail.com:email]
X-Rspamd-Queue-Id: AF44627909B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiayuan Chen <jiayuan.chen@shopee.com>

[ Upstream commit 101bacb303e89dc2e0640ae6a5e0fb97c4eb45bb ]

syzkaller reported a null-ptr-deref in lec_arp_clear_vccs().
This issue can be easily reproduced using the syzkaller reproducer.

In the ATM LANE (LAN Emulation) module, the same atm_vcc can be shared by
multiple lec_arp_table entries (e.g., via entry->vcc or entry->recv_vcc).
When the underlying VCC is closed, lec_vcc_close() iterates over all
ARP entries and calls lec_arp_clear_vccs() for each matched entry.

For example, when lec_vcc_close() iterates through the hlists in
priv->lec_arp_empty_ones or other ARP tables:

1. In the first iteration, for the first matched ARP entry sharing the VCC,
lec_arp_clear_vccs() frees the associated vpriv (which is vcc->user_back)
and sets vcc->user_back to NULL.
2. In the second iteration, for the next matched ARP entry sharing the same
VCC, lec_arp_clear_vccs() is called again. It obtains a NULL vpriv from
vcc->user_back (via LEC_VCC_PRIV(vcc)) and then attempts to dereference it
via `vcc->pop = vpriv->old_pop`, leading to a null-ptr-deref crash.

Fix this by adding a null check for vpriv before dereferencing
it. If vpriv is already NULL, it means the VCC has been cleared
by a previous call, so we can safely skip the cleanup and just
clear the entry's vcc/recv_vcc pointers.

The entire cleanup block (including vcc_release_async()) is placed inside
the vpriv guard because a NULL vpriv indicates the VCC has already been
fully released by a prior iteration — repeating the teardown would
redundantly set flags and trigger callbacks on an already-closing socket.

The Fixes tag points to the initial commit because the entry->vcc path has
been vulnerable since the original code. The entry->recv_vcc path was later
added by commit 8d9f73c0ad2f ("atm: fix a memory leak of vcc->user_back")
with the same pattern, and both paths are fixed here.

Reported-by: syzbot+72e3ea390c305de0e259@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68c95a83.050a0220.3c6139.0e5c.GAE@google.com/T/
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Link: https://patch.msgid.link/20260225123250.189289-1-jiayuan.chen@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/atm/lec.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/net/atm/lec.c b/net/atm/lec.c
index 42e8047c65105..4a8ca2d7ff595 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -1260,24 +1260,28 @@ static void lec_arp_clear_vccs(struct lec_arp_table *entry)
 		struct lec_vcc_priv *vpriv = LEC_VCC_PRIV(vcc);
 		struct net_device *dev = (struct net_device *)vcc->proto_data;
 
-		vcc->pop = vpriv->old_pop;
-		if (vpriv->xoff)
-			netif_wake_queue(dev);
-		kfree(vpriv);
-		vcc->user_back = NULL;
-		vcc->push = entry->old_push;
-		vcc_release_async(vcc, -EPIPE);
+		if (vpriv) {
+			vcc->pop = vpriv->old_pop;
+			if (vpriv->xoff)
+				netif_wake_queue(dev);
+			kfree(vpriv);
+			vcc->user_back = NULL;
+			vcc->push = entry->old_push;
+			vcc_release_async(vcc, -EPIPE);
+		}
 		entry->vcc = NULL;
 	}
 	if (entry->recv_vcc) {
 		struct atm_vcc *vcc = entry->recv_vcc;
 		struct lec_vcc_priv *vpriv = LEC_VCC_PRIV(vcc);
 
-		kfree(vpriv);
-		vcc->user_back = NULL;
+		if (vpriv) {
+			kfree(vpriv);
+			vcc->user_back = NULL;
 
-		entry->recv_vcc->push = entry->old_recv_push;
-		vcc_release_async(entry->recv_vcc, -EPIPE);
+			entry->recv_vcc->push = entry->old_recv_push;
+			vcc_release_async(entry->recv_vcc, -EPIPE);
+		}
 		entry->recv_vcc = NULL;
 	}
 }
-- 
2.51.0




