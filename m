Return-Path: <stable+bounces-249647-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOufNVedDGq8jwUAu9opvQ
	(envelope-from <stable+bounces-249647-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:26:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EBF58305C
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 19:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF9F8300690F
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C182E2F12B3;
	Tue, 19 May 2026 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OL0a7HcA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B1226056C
	for <stable@vger.kernel.org>; Tue, 19 May 2026 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211602; cv=none; b=eaz/yIjVerRp7DJKgE/jmOtfgeelN/fJghIUr6LSeY/+3W6aGRciPccVkiXeA6Mt0+Ut1cXOAp56WQ5r0KrNOMmYi6L/x3wvwDK+c5hm7Luz1mX9wBA1R+tBfpGDwBoEbWffyZS9I6ncFDGpI9FBhh0zE1I0G7+SeSyqHXC1k04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211602; c=relaxed/simple;
	bh=egYyu/i+xaZaoDb0v9SpMFsflxy9+neCAhZXc7GqhbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g+0P6xv50bUmcQjUJJeDZudwJbpT3J0qN4Y431EKjLD6I2HDvhApCbt/IXYUfcB0kaU7u7hD7R3tm7v57t4jaY3YgFFW9qmDxsoGrxy/IE0+n19hV1Acsrlv5XbXGbTWgdebTN+ZWiWspCNMBIOIzAK7Mu3fMYNrlN7bzz6n+3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OL0a7HcA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a8f97f6bso6848505e9.2
        for <stable@vger.kernel.org>; Tue, 19 May 2026 10:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779211599; x=1779816399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1jbRD0zuDAkT/iOMZCuQC1mbw0VTyeq/zm8Dbw1smrw=;
        b=OL0a7HcAqs1a/9RxYMErmtMmMwyloN3x4w5/kAYtSlD8uHq6WZF+y1rcgnGb1Ts1Pq
         mE6ftoLWjoCn+GJSJrzqFK+W1XdLmq6dcFOQmJCkXZKkZhfPGwKKZ/RaCfZ1sgw6NgCe
         3hhAGwIxJycZP9LHjdGrkkUWCF3xlp8BfHZsJzxysdWC1tud+/zXC4ZZoFip8mO6bDlv
         SP6cXoZ1HhUF3f7T6tbm+qYyQx5MtXgY80dENYTfH9wzFqg5SUUOOO1KobR8l8oZscy1
         aCjm9mGcp9NSJhQfkJE7wPgwQ2P8Z2CZeCkrrAmyKCLoOLulJfG0WNfANRRRhk2Uqk7+
         Letw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779211599; x=1779816399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jbRD0zuDAkT/iOMZCuQC1mbw0VTyeq/zm8Dbw1smrw=;
        b=AF6ua4LtKqEZar14ESlKv2m9gckjdAvpielR479Mg4GrUPTcgKGMq3XlTVwvm+xkNB
         DpL90Y95SdBD44jy485ekXT896Fn62PIOb2+k/bEJHp1AS1whIJ/T9mMvuCpn5EJJv4A
         dQ8TFWwJtgLIga6tVyj64R09ByWG/NUZ4X6h309ZJX/lxMg83P/CVwN1QfvfacIpGxCh
         g0Mch8yGvhuvS+puEUfjvEZnh7kR40NbuzwVNoPtiKVqoTFh7LlLRnlmM57tO1FiqII3
         FL5LmGA/QK15V7N9zYI2yd/s4DLbjQZIb1CMUVYCU3UBcegtpNk3CMj0DCzt9RWNOLZN
         uA2Q==
X-Forwarded-Encrypted: i=1; AFNElJ9mmBHOpC2SCXnsGUMvbwcSf3UuNCSzmCOjVMiJGOH16w2ZAgfNnbsDljTnXt+DEsMeELzb74w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzazqEupUn6XSBtJw4WojHMcKTyo17R3XFCTSPEoe2rg9dwxQ8W
	ZjFhRb2N8IrvzwhxlQOY8vr2a+Kq92a0/c2FH/GSDH0e5FsgLtUFh5Dz
X-Gm-Gg: Acq92OE7cklYxthyfm9KygY4TRrUszXiZxycXxjm/hWoLL44PWdUk2ko27n2zKZQZDY
	8CyLiiINlICZM5hzbBkUbHuuGjyTMGd9Rg4sl1va+vqUk6eXBFKYEorzPDCZb0AdBDdt81OtVET
	kHkEYGjyk5zChQ4bmKoMwrTSvOiO9d0HWZi7v42GVcQGqtacKdKkSaZ/FM1BKL3uj4ENJMNxemb
	OnBft3HUJ7BbF88jNmgzsgYPxv6ACViqgVUKcE5uzHZnl00pi3nfp3+ahH2jyBObvxWjeIwLYWb
	0LLYhFvlX09YlqG8PiDK1bQd0cdwh3UFaPo4QG5uGAmoJUxjBv2K4ItkQTligKD5HrzJyl5cydM
	Q/obxfg4xrHYAy+ZszC+pqLOxLKInZp7GUirZ16bs1qJB3nI/56JgIOsB12mH8CXm4KxbMEb3LM
	xgRXxT8BlkwQCdcB7uhV6phDbtAZH6d6uz/hc3Lg7H4Dbd4dsiz44GsRsJAaeUa1UB2GgQG8uQj
	vgDxmc=
X-Received: by 2002:a05:600c:a48:b0:489:e696:127d with SMTP id 5b1f17b1804b1-48fe63022e8mr142076495e9.5.1779211599195;
        Tue, 19 May 2026 10:26:39 -0700 (PDT)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc4.inf.ethz.ch. [129.132.161.179])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feae166dasm128269335e9.9.2026.05.19.10.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 10:26:38 -0700 (PDT)
From: Zijing Yin <yzjaurora@gmail.com>
To: Remi Denis-Courmont <courmisch@gmail.com>
Cc: Zijing Yin <yzjaurora@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] phonet/pep: disable BH around forwarded sk_receive_skb()
Date: Tue, 19 May 2026 10:26:33 -0700
Message-ID: <20260519172635.86304-1-yzjaurora@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[pastebin.com:server fail,sin.lore.kernel.org:server fail,syzkaller.appspot.com:server fail];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-249647-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yzjaurora@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: B0EBF58305C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The networking receive path is usually run from softirq context, but
protocols that take the socket lock may have packets stored in the
backlog and processed later from process context. In that case
release_sock() -> __release_sock() drops the slock with spin_unlock_bh()
and then calls sk->sk_backlog_rcv() with bottom halves enabled.

Typical sk_backlog_rcv handlers process the socket whose backlog is
being drained, so the BH state at entry is irrelevant for the slocks
they touch. pep_do_rcv() is different: when the inbound skb targets an
existing PEP pipe, it forwards the skb to a different *child* socket
via sk_receive_skb(). That helper takes the child slock with
bh_lock_sock_nested(), which is just spin_lock_nested() and assumes BH
is already off. The same child slock therefore ends up acquired with
BH on (process path) and with BH off (softirq path):

  process context                   softirq context
  ---------------                   ---------------
  release_sock(listener)            __netif_receive_skb()
   __release_sock()                  phonet_rcv()
    spin_unlock_bh()                  __sk_receive_skb(listener)
    [BH now ENABLED]                  [BH already disabled]
    sk_backlog_rcv:                   sk_backlog_rcv:
     pep_do_rcv()                      pep_do_rcv()
      sk_receive_skb(child)             sk_receive_skb(child)
       bh_lock_sock_nested(child)        bh_lock_sock_nested(child)
       => SOFTIRQ-ON-W                   => IN-SOFTIRQ-W

Lockdep flags this as inconsistent lock state, and it can become a real
self-deadlock if a softirq on the same CPU tries to receive to the same
child socket while its slock is held in the BH-enabled path:

  WARNING: inconsistent lock state
  inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
   (slock-AF_PHONET/1){+.?.}-{3:3}, at: __sk_receive_skb+0x1cf/0x900
    __sk_receive_skb              net/core/sock.c:563
    sk_receive_skb                include/net/sock.h:2022 [inline]
    pep_do_rcv                    net/phonet/pep.c:675
    sk_backlog_rcv                include/net/sock.h:1190
    __release_sock                net/core/sock.c:3216
    release_sock                  net/core/sock.c:3815
    pep_sock_accept               net/phonet/pep.c:879

Wrap the forwarded sk_receive_skb() in local_bh_disable() /
local_bh_enable() so the child slock is always acquired with BH off.
local_bh_disable() nests safely on the softirq path.

Discovered via in-house syzkaller fuzzing; the same root cause also
on the linux-6.1.y syzbot dashboard as extid 44f0626dd6284f02663c.
Reproduced under KASAN + LOCKDEP + PROVE_LOCKING, reproducer:
https://pastebin.com/A3t8xzCR

Fixes: 9641458d3ec4 ("Phonet: Pipe End Point for Phonet Pipes protocol")
Link: https://syzkaller.appspot.com/bug?extid=44f0626dd6284f02663c
Cc: stable@vger.kernel.org
Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
---
 net/phonet/pep.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/phonet/pep.c b/net/phonet/pep.c
index 4dbf0914df7d..cc6226cc4343 100644
--- a/net/phonet/pep.c
+++ b/net/phonet/pep.c
@@ -671,8 +671,23 @@ static int pep_do_rcv(struct sock *sk, struct sk_buff *skb)
 
 	/* Look for an existing pipe handle */
 	sknode = pep_find_pipe(&pn->hlist, &dst, pipe_handle);
-	if (sknode)
-		return sk_receive_skb(sknode, skb, 1);
+	if (sknode) {
+		int rc;
+
+		/*
+		 * pep_do_rcv() runs from two contexts: from softirq via
+		 * phonet_rcv() -> __sk_receive_skb() with BH disabled, and from
+		 * process context via release_sock() -> __release_sock(), which
+		 * drops the listener slock with spin_unlock_bh() before draining
+		 * the backlog.  The child pipe slock is taken below via
+		 * bh_lock_sock_nested(), which does not itself disable BH, so
+		 * disable BH here to keep both acquire contexts consistent.
+		 */
+		local_bh_disable();
+		rc = sk_receive_skb(sknode, skb, 1);
+		local_bh_enable();
+		return rc;
+	}
 
 	switch (hdr->message_id) {
 	case PNS_PEP_CONNECT_REQ:

base-commit: edc502717be153674b0b3eefb8b40734c747c138
-- 
2.43.0


