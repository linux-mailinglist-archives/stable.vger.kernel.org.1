Return-Path: <stable+bounces-220557-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Cs+OoY+o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220557-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:14:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 719621C6B88
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06D94320A791
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10E93D8353;
	Sat, 28 Feb 2026 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5ISElVL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4F3D834B;
	Sat, 28 Feb 2026 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300438; cv=none; b=V/aLY0290bRXCE1YYjL0U7FLGcz4pK1ydZroI2464lU6+e2z7jp5Ju9InDPTd7UckbzOTa+jqvZbvSmfG8YN/7wWVH22v5l0x9RRZr452Wo2dKJWo+9OHcJNc34OOIXtkpLavCnHarVQnK9WR5RUHdWO9gjq5ozGupVU+6hoyFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300438; c=relaxed/simple;
	bh=0TTJkMOME3sDF9qX8M3Nezn4qaRZBmS/veqUDaC1Glw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrJoAAS4C27SRgj74EPlw4Hl3Ypbj24JsDVcCaVQMrCfpaTzOw8huA7WJt0EU5bqKDD7jWRzQO90OtsjQuz9dhmD1Zj8KuWH9ZwDyBmog08zq2lRXmvPiFwME3x2rO8xh8h8+6taL3o2Y/3SoLKddxvY5tR4SRKAsoy/r8moMf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5ISElVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8063C19424;
	Sat, 28 Feb 2026 17:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300438;
	bh=0TTJkMOME3sDF9qX8M3Nezn4qaRZBmS/veqUDaC1Glw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V5ISElVLdv6aiUSoOv8Pg6MuF0z8o/nhO8aYkcj6beVC06wYgCyd8W1NFDIS0awoi
	 E4qYX0q5bbcxQUGDTb0IbqBx5EEo5RnGBMZKBX22xkD7i8B3jAFqWfN7mc/IU4UKX6
	 VT8jCu+aE8bq6rbh3l/3TkXjd9KXcI58s1sp24/Bt0upGX33KOi9i51esTGnbmxxFA
	 3nnDM+gUsJ8yA4FfWDjCYSPyjLd6DprlH/cryJfOkp5jfLvRm3iMflH7Phkir+Y1un
	 gSL2y/oF09ljep0Q+dVj74Gz7Nn9yYjjQVHzFHC/KS3PMxHxkgCkERYyUf7KtRY4SC
	 r+bxnPh6lP9QQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+52624bdfbf2746d37d70@syzkaller.appspotmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 478/844] kcm: fix zero-frag skb in frag_list on partial sendmsg error
Date: Sat, 28 Feb 2026 12:26:31 -0500
Message-ID: <20260228173244.1509663-479-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220557-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,52624bdfbf2746d37d70];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,shopee.com:email,appspotmail.com:email]
X-Rspamd-Queue-Id: 719621C6B88
X-Rspamd-Action: no action

From: Jiayuan Chen <jiayuan.chen@shopee.com>

[ Upstream commit ca220141fa8ebae09765a242076b2b77338106b0 ]

Syzkaller reported a warning in kcm_write_msgs() when processing a
message with a zero-fragment skb in the frag_list.

When kcm_sendmsg() fills MAX_SKB_FRAGS fragments in the current skb,
it allocates a new skb (tskb) and links it into the frag_list before
copying data. If the copy subsequently fails (e.g. -EFAULT from
user memory), tskb remains in the frag_list with zero fragments:

  head skb (msg being assembled, NOT yet in sk_write_queue)
  +-----------+
  | frags[17] |  (MAX_SKB_FRAGS, all filled with data)
  | frag_list-+--> tskb
  +-----------+    +----------+
                   | frags[0] |  (empty! copy failed before filling)
                   +----------+

For SOCK_SEQPACKET with partial data already copied, the error path
saves this message via partial_message for later completion. For
SOCK_SEQPACKET, sock_write_iter() automatically sets MSG_EOR, so a
subsequent zero-length write(fd, NULL, 0) completes the message and
queues it to sk_write_queue. kcm_write_msgs() then walks the
frag_list and hits:

  WARN_ON(!skb_shinfo(skb)->nr_frags)

TCP has a similar pattern where skbs are enqueued before data copy
and cleaned up on failure via tcp_remove_empty_skb(). KCM was
missing the equivalent cleanup.

Fix this by tracking the predecessor skb (frag_prev) when allocating
a new frag_list entry. On error, if the tail skb has zero frags,
use frag_prev to unlink and free it in O(1) without walking the
singly-linked frag_list. frag_prev is safe to dereference because
the entire message chain is only held locally (or in kcm->seq_skb)
and is not added to sk_write_queue until MSG_EOR, so the send path
cannot free it underneath us.

Also change the WARN_ON to WARN_ON_ONCE to avoid flooding the log
if the condition is somehow hit repeatedly.

There are currently no KCM selftests in the kernel tree; a simple
reproducer is available at [1].

[1] https://gist.github.com/mrpre/a94d431c757e8d6f168f4dd1a3749daa

Reported-by: syzbot+52624bdfbf2746d37d70@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000269a1405a12fdc77@google.com/T/
Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Link: https://patch.msgid.link/20260219014256.370092-1-jiayuan.chen@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/kcm/kcmsock.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 5dd7e0509a48f..3912e75079f5e 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -628,7 +628,7 @@ static int kcm_write_msgs(struct kcm_sock *kcm)
 			skb = txm->frag_skb;
 		}
 
-		if (WARN_ON(!skb_shinfo(skb)->nr_frags) ||
+		if (WARN_ON_ONCE(!skb_shinfo(skb)->nr_frags) ||
 		    WARN_ON_ONCE(!skb_frag_page(&skb_shinfo(skb)->frags[0]))) {
 			ret = -EINVAL;
 			goto out;
@@ -749,7 +749,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct kcm_sock *kcm = kcm_sk(sk);
-	struct sk_buff *skb = NULL, *head = NULL;
+	struct sk_buff *skb = NULL, *head = NULL, *frag_prev = NULL;
 	size_t copy, copied = 0;
 	long timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 	int eor = (sock->type == SOCK_DGRAM) ?
@@ -824,6 +824,7 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 				else
 					skb->next = tskb;
 
+				frag_prev = skb;
 				skb = tskb;
 				skb->ip_summed = CHECKSUM_UNNECESSARY;
 				continue;
@@ -933,6 +934,22 @@ static int kcm_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 out_error:
 	kcm_push(kcm);
 
+	/* When MAX_SKB_FRAGS was reached, a new skb was allocated and
+	 * linked into the frag_list before data copy. If the copy
+	 * subsequently failed, this skb has zero frags. Remove it from
+	 * the frag_list to prevent kcm_write_msgs from later hitting
+	 * WARN_ON(!skb_shinfo(skb)->nr_frags).
+	 */
+	if (frag_prev && !skb_shinfo(skb)->nr_frags) {
+		if (head == frag_prev)
+			skb_shinfo(head)->frag_list = NULL;
+		else
+			frag_prev->next = NULL;
+		kfree_skb(skb);
+		/* Update skb as it may be saved in partial_message via goto */
+		skb = frag_prev;
+	}
+
 	if (sock->type == SOCK_SEQPACKET) {
 		/* Wrote some bytes before encountering an
 		 * error, return partial success.
-- 
2.51.0


