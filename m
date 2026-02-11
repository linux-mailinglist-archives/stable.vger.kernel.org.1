Return-Path: <stable+bounces-215869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNbvDlXTjGm+tgAAu9opvQ
	(envelope-from <stable+bounces-215869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 20:07:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A42CE127065
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 20:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5F1F30058DD
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 19:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BA226B2CE;
	Wed, 11 Feb 2026 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9YvCkob"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13482346ADC;
	Wed, 11 Feb 2026 19:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770836818; cv=none; b=R+n/bX7hvxblIMQrfZXSJJck3+IoLA/crxjmqOgnswJZiWNJ05qco/veajulBvIG71RWQtkiaHhz67bANw3lKd0OroQgC9O1KxikzIEXIKk1063bbKtJMeLQU1C8fZ91epxLMDreaIVPcSR3xSUmQiR2NFK1hNW5Dc9g5/zuSzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770836818; c=relaxed/simple;
	bh=1yOQN7PQEIRho9X34GhsEwbRNe8punC0i6d/rfJQc50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6s8jNelF0VLllMcVsEE9HkFC0nWnJiA/t58xFR8fGuNf5f4pOaXWHU18jNIZJws1PEOB0q21ivlVXlEs7bsTWidycvW2aFEhAfj6BJXmjTtabYr7oIxeN4WgCJaSMIRTnPjwjURySbeD8LonVhrxG1ROlB4AfqHykuj1zVcO8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9YvCkob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB08C2BCB1;
	Wed, 11 Feb 2026 19:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770836817;
	bh=1yOQN7PQEIRho9X34GhsEwbRNe8punC0i6d/rfJQc50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E9YvCkobBCZSo7aJFrSPN3thw+0XHfJNWyi/Empp7b3sP0IJlaRn+bojUbZYPNwiK
	 QBol6/9QPogue4V/QUooWwIB5wxsBYlME/LgCYxMg92K40buzb4zZ486H+WtEeLLHE
	 5uONcNldHPW2XIxfmqKZN6FP/SJxpdDRQERIiYgnDX4RCVFA3ut8whKSqjX16j7F0K
	 KxBC7pmBKQTXb4emJZpDlTuLU2YqgPCYhN6ScRHQbGD6NZEuQdA5BMhNnDquVesB7B
	 L6j9kBDMjGg/839hbdhWvXU8I0aBfI5SATl8dif7Ya/ZwCfqEtgbKHYoT47BFr8wjW
	 8Z6IwqYFf6ubQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Paolo Abeni <pabeni@redhat.com>,
	sashal@kernel.org,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 2/6] mptcp: schedule rtx timer only after pushing data
Date: Wed, 11 Feb 2026 20:06:20 +0100
Message-ID: <20260211190617.77192-10-matttbe@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211190617.77192-8-matttbe@kernel.org>
References: <20260211190617.77192-8-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2549; i=matttbe@kernel.org; h=from:subject; bh=32qO1VArjJDOXlEbLM+G54M2ILeFc+41VELU3gX5Al8=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ7LuuK1jKLi2/YKvO4uCvTd43dbu9tp3gPij4Kl1DwT SuS2x7SUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJE7ZowMZ+3nWxZs79BlKV9m s8a0/MjELT6VS1oEL2k+ElniU1FXyciwaJ8z41Nb7UAG55V55+9Unc7PqPl16+LPZTzMvvtul01 nBgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-215869-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: A42CE127065
X-Rspamd-Action: no action

From: Paolo Abeni <pabeni@redhat.com>

commit 2ea6190f42d0416a4310e60a7fcb0b49fcbbd4fb upstream.

The MPTCP protocol usually schedule the retransmission timer only
when there is some chances for such retransmissions to happen.

With a notable exception: __mptcp_push_pending() currently schedule
such timer unconditionally, potentially leading to unnecessary rtx
timer expiration.

The issue is present since the blamed commit below but become easily
reproducible after commit 27b0e701d387 ("mptcp: drop bogus optimization
in __mptcp_check_push()")

Fixes: 33d41c9cd74c ("mptcp: more accurate timeout")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251205-net-mptcp-misc-fixes-6-19-rc1-v1-3-9e4781a6c1b8@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in protocol.c, because commit 0fa1b3783a17 ("mptcp: use
  get_send wrapper") is not in this version, and is changing the
  context. The same modification can still be applied. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2d107a1f2ef9..ad0bfdd308be 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1666,7 +1666,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	struct mptcp_sendmsg_info info = {
 				.flags = flags,
 	};
-	bool do_check_data_fin = false;
+	bool copied = false;
 	struct mptcp_data_frag *dfrag;
 	int len;
 
@@ -1703,7 +1703,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 				goto out;
 			}
 
-			do_check_data_fin = true;
+			copied = true;
 			info.sent += ret;
 			len -= ret;
 
@@ -1717,11 +1717,14 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 		mptcp_push_release(ssk, &info);
 
 out:
-	/* ensure the rtx timer is running */
-	if (!mptcp_rtx_timer_pending(sk))
-		mptcp_reset_rtx_timer(sk);
-	if (do_check_data_fin)
+	/* Avoid scheduling the rtx timer if no data has been pushed; the timer
+	 * will be updated on positive acks by __mptcp_cleanup_una().
+	 */
+	if (copied) {
+		if (!mptcp_rtx_timer_pending(sk))
+			mptcp_reset_rtx_timer(sk);
 		mptcp_check_send_data_fin(sk);
+	}
 }
 
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
-- 
2.51.0


