Return-Path: <stable+bounces-205102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0EFCF906F
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 16:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71028305246F
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 15:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241653358B2;
	Tue,  6 Jan 2026 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwAubXcr"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A969313273
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767711998; cv=none; b=uKn/MbL4X8CPIqfgKNIHBK2qcSlKUZjYOP1LSg9zJX5e//tj5YGuA1q4P8WRFixSSYaW7WqgMjixo75Hcn7UZ541SXTV83zaG18T275RDavZsdjapL5tnYpV+6u81pNO2v6Btee0/redKtdnSDEmGPG7gROf7c5I3fryxKiufBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767711998; c=relaxed/simple;
	bh=Wlnk/11G9FNLpYzC4qc1aHujvRCSLXLDlxsPxH2TQqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lklvjpGMFZ93kY5To0snOPgTU46PELhZpHudN/bYXfZY+fQS4hN67Nm6DIY6eQvjvMWVUg757XnWruAeGXQ/CYP3ltdZBBIoDd3AO/EEXjnQH7uTgdDfvMPNYZDsXH8kV4QTlPNkO11w+VySett4NBeS6aKPpnUNLx3jbksV9rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwAubXcr; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-790ac42fd00so5860827b3.3
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 07:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767711991; x=1768316791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VesORcM4qYIh/AS4ROzcX+TIK5RLKNWV/oYtlzx/zN4=;
        b=VwAubXcryzDjcLBxvCHp4wdwixZ02kQwl1UgMXibe12ifytkQ3u/4snlbdxIy+buV3
         Xzg8dIPOwGgawmIkvdqeIj7y5IMKyAw/RlimvpBBnc9AQNO2W2k3U7cHD3K3aLJAkFdW
         jDLrDWED+grw+6w98oDpluXtmojz8MnNm3lQTYcnloI/zIWWPvd7PcKCmjMgYJ4AzNLk
         xKu5oJvHQThaJ42OJd+TQeR45GfNiKL5AAJGyeHSxnMcfiiqbheTQrs4EeZ/biyfz8Tk
         V1IFe8l8xOiGiEQ+4E6BrhitvLhUJ1MBkdtATGdQax4Q8svQ4qg5TASQ7HYM677nDBhx
         mMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767711991; x=1768316791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VesORcM4qYIh/AS4ROzcX+TIK5RLKNWV/oYtlzx/zN4=;
        b=bghisRXDAyvKf6m+2hNHmxcwmR9QgbkgnOSS8COD1Nf+v/7YL8g+sHQcWv213g1r+V
         mF4dFJshgi6EzaxvmyLBhmCdbcqOrM6ZsZNuSX3lOtg6iwd8Dg5NxyaRlOR6xQ5KPr6+
         vJVq/6plLbLe7ILVLeIfB5wMR0fw82qPZ9CPl+UOw2gWwEGuOBIlXyFTWRT4D0h2TcMV
         ABbCAk6QVm4sMFZQ9Em4yJUe474JZBgRl7n0Wu+W9n6coAGUyLM09eHs1hB0Yb0mi4GL
         AEGkD+Q65bNVxfGyHlCdvFic+PjPhVrsoc/Ccab87MK8CSMeHhPlBuez9jJkDNLO5uCB
         lIlw==
X-Forwarded-Encrypted: i=1; AJvYcCUx+TIfThIC0kSgbk52DG2+EcZ/86cjQBtzXu+Gk2fCyTx3U4bJjhgT8ikNA8t5K0GYCAJ5/74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCJfnGlkwYd8w7c9VWA9CQBjFAIPTMvh2bpIh72SssZPQjxZjf
	GRRfMTFfhTwSsrrKXeIvVaEcUieKeEPqH4At9H9TZtIRDdNYBRAp8WGz
X-Gm-Gg: AY/fxX7pT3UZfK5HNkfE56rfT+2GKf9OYr7sf0D4NoOs2HddHWCaGwO7pql+L2Qk+KC
	4tfL7bclM+gbWUlXM35Y3VvUgnx6dsC8Lfka7bpphWUGNgXVOoAAvpinMNp8n1Y8BvdCzorbteZ
	g4qEdmC0fT24dMCNkWCxbY+V3+ymdmJbDYaZfqfEBZLZM+i5G2pM2yOTyEfLboXzW4O4L3ElFJv
	YDreLSueF6B9kQbT5tEsUImPCviKn7l4Vpc1gLEBCs0iD/9U8JUaNw0XIOjM0Y+e1gm6XJ44e7+
	MvtMaBfpJQqr7awE8wa7JihqTMueS0rUwgyV6sp6Okd/BVVD2PHQzH0Uon6F2okf8mtVrf861mn
	MdhBFdB8HMUq46bQnIXarf0lZRqek1RUXYKIEbLkOMgEcMt4DmbNysa1SZz6K+82eAYGFx/gDDZ
	0iMJvs9xixcyxCKqvF0Mfq6+d3Kk1mzMFzuO5oPPGq9+XAevBwluE968sDn5d7PFZGPzuO/eNyT
	n/CAzhUww==
X-Google-Smtp-Source: AGHT+IGAPg8YR5odC5J7num/W2k21qmHdtRj/ssaOtbsGIAfgwQVFfKU55O7ciz7iIN10EDoMHRQkw==
X-Received: by 2002:a05:690c:3602:b0:788:e1b:5ee6 with SMTP id 00721157ae682-790a8b7a313mr60498667b3.70.1767711991309;
        Tue, 06 Jan 2026 07:06:31 -0800 (PST)
Received: from willemb.c.googlers.com.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6a4d00sm8142177b3.41.2026.01.06.07.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:06:30 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	axboe@kernel.dk,
	kuniyu@google.com,
	Willem de Bruijn <willemb@google.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: do not write to msg_get_inq in callee
Date: Tue,  6 Jan 2026 10:05:46 -0500
Message-ID: <20260106150626.3944363-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

NULL pointer dereference fix.

msg_get_inq is an input field from caller to callee. Don't set it in
the callee, as the caller may not clear it on struct reuse.

This is a kernel-internal variant of msghdr only, and the only user
does reinitialize the field. So this is not critical for that reason.
But it is more robust to avoid the write, and slightly simpler code.
And it fixes a bug, see below.

Callers set msg_get_inq to request the input queue length to be
returned in msg_inq. This is equivalent to but independent from the
SO_INQ request to return that same info as a cmsg (tp->recvmsg_inq).
To reduce branching in the hot path the second also sets the msg_inq.
That is WAI.

This is a fix to commit 4d1442979e4a ("af_unix: don't post cmsg for
SO_INQ unless explicitly asked for"), which fixed the inverse.

Also avoid NULL pointer dereference in unix_stream_read_generic if
state->msg is NULL and msg->msg_get_inq is written. A NULL state->msg
can happen when splicing as of commit 2b514574f7e8 ("net: af_unix:
implement splice for stream af_unix sockets").

Also collapse two branches using a bitwise or.

Cc: stable@vger.kernel.org
Fixes: 4d1442979e4a ("af_unix: don't post cmsg for SO_INQ unless explicitly asked for")
Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.24d8030f7a3de@gmail.com/
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Jens, I dropped your Reviewed-by because of the commit message updates.
But code is unchanged.

changes nn v1 -> net v1
  - add Fixes tag and explain reason
  - redirect to net
  - s/caller/callee in subject line

nn v1: https://lore.kernel.org/netdev/20260105163338.3461512-1-willemdebruijn.kernel@gmail.com/
---
 net/ipv4/tcp.c     | 8 +++-----
 net/unix/af_unix.c | 8 +++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f035440c475a..d5319ebe2452 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2652,10 +2652,8 @@ static int tcp_recvmsg_locked(struct sock *sk, struct msghdr *msg, size_t len,
 	if (sk->sk_state == TCP_LISTEN)
 		goto out;
 
-	if (tp->recvmsg_inq) {
+	if (tp->recvmsg_inq)
 		*cmsg_flags = TCP_CMSG_INQ;
-		msg->msg_get_inq = 1;
-	}
 	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 
 	/* Urgent data needs to be handled specially. */
@@ -2929,10 +2927,10 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 	ret = tcp_recvmsg_locked(sk, msg, len, flags, &tss, &cmsg_flags);
 	release_sock(sk);
 
-	if ((cmsg_flags || msg->msg_get_inq) && ret >= 0) {
+	if ((cmsg_flags | msg->msg_get_inq) && ret >= 0) {
 		if (cmsg_flags & TCP_CMSG_TS)
 			tcp_recv_timestamp(msg, sk, &tss);
-		if (msg->msg_get_inq) {
+		if ((cmsg_flags & TCP_CMSG_INQ) | msg->msg_get_inq) {
 			msg->msg_inq = tcp_inq_hint(sk);
 			if (cmsg_flags & TCP_CMSG_INQ)
 				put_cmsg(msg, SOL_TCP, TCP_CM_INQ,
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index a7ca74653d94..d0511225799b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2904,7 +2904,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 	unsigned int last_len;
 	struct unix_sock *u;
 	int copied = 0;
-	bool do_cmsg;
 	int err = 0;
 	long timeo;
 	int target;
@@ -2930,9 +2929,6 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 	u = unix_sk(sk);
 
-	do_cmsg = READ_ONCE(u->recvmsg_inq);
-	if (do_cmsg)
-		msg->msg_get_inq = 1;
 redo:
 	/* Lock the socket to prevent queue disordering
 	 * while sleeps in memcpy_tomsg
@@ -3090,9 +3086,11 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 	mutex_unlock(&u->iolock);
 	if (msg) {
+		bool do_cmsg = READ_ONCE(u->recvmsg_inq);
+
 		scm_recv_unix(sock, msg, &scm, flags);
 
-		if (msg->msg_get_inq && (copied ?: err) >= 0) {
+		if ((do_cmsg | msg->msg_get_inq) && (copied ?: err) >= 0) {
 			msg->msg_inq = READ_ONCE(u->inq_len);
 			if (do_cmsg)
 				put_cmsg(msg, SOL_SOCKET, SCM_INQ,
-- 
2.52.0.351.gbe84eed79e-goog


