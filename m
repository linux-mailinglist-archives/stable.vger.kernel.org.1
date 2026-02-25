Return-Path: <stable+bounces-219243-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QB9RMTmenmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219243-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:01:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C66192BDA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D67AB310217D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B296B2C21DF;
	Wed, 25 Feb 2026 06:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TQCdyVZZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7485B2C0F97;
	Wed, 25 Feb 2026 06:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002588; cv=none; b=WwAxe8zyIXSiV83rkcgLIHEDpyggBZWkKaFlhJ84Q3ibY1zY2kMKyXqEpiGW4mWQyPOp0bfHbidRpl2rdeRceAPAfyGENGcMjMohRvjrQ+SM31flrekZ+qA3kZFZR95UepQyM8Y91q+vIGDYZiFHGmF/tYEQ2okuzn/FXVvtxKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002588; c=relaxed/simple;
	bh=bVnu4S5oNByASj7WRl1j4OATgcaRX1H7fx+6hohu+QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c79GCHczXdLFv47+TBAl86UdOcPpFoCl/6nG8a4C8ZzY5Bg+Rpl2OxYUjM0nsDws9/3pbnJZ3VLHDc9Hm0rRpNQdJkza/FI5AxoMb0YBIARJy9LA9fHVyDzAAzbc931LTydx7J2LsBGtMo3BlvRg6+2n5aUhW2Ws9K6vFLGc4/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TQCdyVZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45286C19425;
	Wed, 25 Feb 2026 06:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002588;
	bh=bVnu4S5oNByASj7WRl1j4OATgcaRX1H7fx+6hohu+QQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TQCdyVZZ06Lr8qDBpvS+DFwv1YkEsWOlLoE4CizZmnc7u5SswyoishUQ3YYhtXrno
	 EIOtO3hpITECSTdQsp0mclcAC8mwYE3slfLJvZFKcqORxjk6ZLSavF3Zr3lDGYkl54
	 zpEoedn/5hf5Gl7K1uVO98UkPbi7Ys4zmklr0A08=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+1f22cb1769f249df9fa0@syzkaller.appspotmail.com,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 326/641] net: atm: fix crash due to unvalidated vcc pointer in sigd_send()
Date: Tue, 24 Feb 2026 17:20:52 -0800
Message-ID: <20260225012356.596689693@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-219243-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,1f22cb1769f249df9fa0];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 31C66192BDA
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiayuan Chen <jiayuan.chen@shopee.com>

[ Upstream commit ae88a5d2f29b69819dc7b04086734439d074a643 ]

Reproducer available at [1].

The ATM send path (sendmsg -> vcc_sendmsg -> sigd_send) reads the vcc
pointer from msg->vcc and uses it directly without any validation. This
pointer comes from userspace via sendmsg() and can be arbitrarily forged:

    int fd = socket(AF_ATMSVC, SOCK_DGRAM, 0);
    ioctl(fd, ATMSIGD_CTRL);  // become ATM signaling daemon
    struct msghdr msg = { .msg_iov = &iov, ... };
    *(unsigned long *)(buf + 4) = 0xdeadbeef;  // fake vcc pointer
    sendmsg(fd, &msg, 0);  // kernel dereferences 0xdeadbeef

In normal operation, the kernel sends the vcc pointer to the signaling
daemon via sigd_enq() when processing operations like connect(), bind(),
or listen(). The daemon is expected to return the same pointer when
responding. However, a malicious daemon can send arbitrary pointer values.

Fix this by introducing find_get_vcc() which validates the pointer by
searching through vcc_hash (similar to how sigd_close() iterates over
all VCCs), and acquires a reference via sock_hold() if found.

Since struct atm_vcc embeds struct sock as its first member, they share
the same lifetime. Therefore using sock_hold/sock_put is sufficient to
keep the vcc alive while it is being used.

Note that there may be a race with sigd_close() which could mark the vcc
with various flags (e.g., ATM_VF_RELEASED) after find_get_vcc() returns.
However, sock_hold() guarantees the memory remains valid, so this race
only affects the logical state, not memory safety.

[1]: https://gist.github.com/mrpre/1ba5949c45529c511152e2f4c755b0f3
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+1f22cb1769f249df9fa0@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69039850.a70a0220.5b2ed.005d.GAE@google.com/T/
Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
Link: https://patch.msgid.link/20260205095501.131890-1-jiayuan.chen@linux.dev
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/atm/signaling.c | 56 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/net/atm/signaling.c b/net/atm/signaling.c
index e70ae2c113f95..358fbe5e4d1d0 100644
--- a/net/atm/signaling.c
+++ b/net/atm/signaling.c
@@ -22,6 +22,36 @@
 
 struct atm_vcc *sigd = NULL;
 
+/*
+ * find_get_vcc - validate and get a reference to a vcc pointer
+ * @vcc: the vcc pointer to validate
+ *
+ * This function validates that @vcc points to a registered VCC in vcc_hash.
+ * If found, it increments the socket reference count and returns the vcc.
+ * The caller must call sock_put(sk_atm(vcc)) when done.
+ *
+ * Returns the vcc pointer if valid, NULL otherwise.
+ */
+static struct atm_vcc *find_get_vcc(struct atm_vcc *vcc)
+{
+	int i;
+
+	read_lock(&vcc_sklist_lock);
+	for (i = 0; i < VCC_HTABLE_SIZE; i++) {
+		struct sock *s;
+
+		sk_for_each(s, &vcc_hash[i]) {
+			if (atm_sk(s) == vcc) {
+				sock_hold(s);
+				read_unlock(&vcc_sklist_lock);
+				return vcc;
+			}
+		}
+	}
+	read_unlock(&vcc_sklist_lock);
+	return NULL;
+}
+
 static void sigd_put_skb(struct sk_buff *skb)
 {
 	if (!sigd) {
@@ -69,7 +99,14 @@ static int sigd_send(struct atm_vcc *vcc, struct sk_buff *skb)
 
 	msg = (struct atmsvc_msg *) skb->data;
 	WARN_ON(refcount_sub_and_test(skb->truesize, &sk_atm(vcc)->sk_wmem_alloc));
-	vcc = *(struct atm_vcc **) &msg->vcc;
+
+	vcc = find_get_vcc(*(struct atm_vcc **)&msg->vcc);
+	if (!vcc) {
+		pr_debug("invalid vcc pointer in msg\n");
+		dev_kfree_skb(skb);
+		return -EINVAL;
+	}
+
 	pr_debug("%d (0x%lx)\n", (int)msg->type, (unsigned long)vcc);
 	sk = sk_atm(vcc);
 
@@ -100,7 +137,16 @@ static int sigd_send(struct atm_vcc *vcc, struct sk_buff *skb)
 		clear_bit(ATM_VF_WAITING, &vcc->flags);
 		break;
 	case as_indicate:
-		vcc = *(struct atm_vcc **)&msg->listen_vcc;
+		/* Release the reference from msg->vcc, we'll use msg->listen_vcc instead */
+		sock_put(sk);
+
+		vcc = find_get_vcc(*(struct atm_vcc **)&msg->listen_vcc);
+		if (!vcc) {
+			pr_debug("invalid listen_vcc pointer in msg\n");
+			dev_kfree_skb(skb);
+			return -EINVAL;
+		}
+
 		sk = sk_atm(vcc);
 		pr_debug("as_indicate!!!\n");
 		lock_sock(sk);
@@ -115,6 +161,8 @@ static int sigd_send(struct atm_vcc *vcc, struct sk_buff *skb)
 		sk->sk_state_change(sk);
 as_indicate_complete:
 		release_sock(sk);
+		/* Paired with find_get_vcc(msg->listen_vcc) above */
+		sock_put(sk);
 		return 0;
 	case as_close:
 		set_bit(ATM_VF_RELEASED, &vcc->flags);
@@ -131,11 +179,15 @@ static int sigd_send(struct atm_vcc *vcc, struct sk_buff *skb)
 		break;
 	default:
 		pr_alert("bad message type %d\n", (int)msg->type);
+		/* Paired with find_get_vcc(msg->vcc) above */
+		sock_put(sk);
 		return -EINVAL;
 	}
 	sk->sk_state_change(sk);
 out:
 	dev_kfree_skb(skb);
+	/* Paired with find_get_vcc(msg->vcc) above */
+	sock_put(sk);
 	return 0;
 }
 
-- 
2.51.0




