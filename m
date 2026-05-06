Return-Path: <stable+bounces-244316-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GmHHCDO+mnMSwMAu9opvQ
	(envelope-from <stable+bounces-244316-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 07:14:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A83C94D6409
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 07:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E074301A915
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 05:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1782ED154;
	Wed,  6 May 2026 05:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hruDdlSH"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E952D9792
	for <stable@vger.kernel.org>; Wed,  6 May 2026 05:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778044443; cv=none; b=P6ACy68i8KdOKLOHMGJGFr9WKUd6cNOsjGp3oI7rAycVkdl3RadkIZiHu7iyyevtIzobuPqFICMP/A8++s7x8p9tKKXpEi2ID45P/LTsx34aRQzESTrQkyqRYLw4O33QuUP/UqTq84N/ud7p4HHmSiyI8cD2t+y0QHxiNj9FrUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778044443; c=relaxed/simple;
	bh=3mPDjpz9UoYLq//zME7f0LLK/FYBp27tbNuZ0h5zQJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NkDlHCW3jUmQKy2CM7xHncH891prqWUmdQUjy1vxCH7NVgDvyP31fitOJuiJR3s3Xu4RuRsQ622arL7VNEZ+wCmFOQx8/ZBz5EJyfgOwlmmHlVJwJ1dufWXmjB58vcRU2t/nXHDpXpF6bv2K5sb/bEjx5n5xO7a1Vc8NaTSqr8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hruDdlSH; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2f3c623322bso3602841eec.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 22:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778044441; x=1778649241; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ne6d3NPP/xf4CWREwfa7zTxmf8SmALy0wsZD1GHfx/w=;
        b=hruDdlSHHK/zBbWb8HtnaCSF5yAXUC3YmU7AckgiyHTkCOxCnmkn2PyrFQ9QBYivgw
         zi1zbk6YvxPLBk6gAdW3N6L0eOAhracP+6Yn0ySETPKmeDIo1ZWq+yaiDdtEzJLisQcT
         ijdPMpdUiyh+JtQHiQndtKZFslyd5ey9K34oy5PyKk7NwsEWTb41WHcBLjUJaVPasdGm
         Sl6kV4z4ht4qCPrJlPtml2tXpB0fiVNZ2kYBi0IUBab2hhFIs/qE03RWR1MUTgcAPxRa
         izgb5xzBGnz88M7ZHCIGSgYxrcnB2v8GJhv5kHBWgGzLoIVBNqrpyNKZtxCSWz5NZi/a
         tH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778044441; x=1778649241;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ne6d3NPP/xf4CWREwfa7zTxmf8SmALy0wsZD1GHfx/w=;
        b=JFD5GAK2SjiLs7/h20PSsGa+HaZWH/Rph02l2o5A8OXscKDdGZOKUY1v0KlnO9jygC
         PiThl4FeiXdeY3k0WECRYH3gtHBP1FA2f1dzXZEGH/Hr60zr2PkjKzrGC3aT6xug6QJA
         O+fSD44xhdSwjUr23KMeQG0vC2yFekyU6qTUM8JmYZ72weFq/UzV9uPCyV2BcIpxhVbX
         HKgtCLeXcZ7/a6c5NifDPScjyPUXNO2qff1sOKQ5bFzHFg1xkbR9+wL0xJ/mEZkuNauU
         3Cnvt/CKafSxz4wz9NBCJ4l3QORCXZ5imSyTHs2RhwdVa/QEvt6EoHfWra+hjQCS91HM
         TPJw==
X-Forwarded-Encrypted: i=1; AFNElJ+Se5DIF+MJhcg6zuwnvpgvhtbMomZiLwrPjVlTB7DtW4LP3yvQK84osuMjmH5/411wfgLgIWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5RH2T9n7WQANe5Dav0PaTosT6RP0XeUhOpCV0BoJsFNCdSaAF
	yJVV92Nxg4ccsEojVTFnWIw00Ea/CNRM4yXUMhFiAAm8DhFCGZpiCNInpeSvXxTy
X-Gm-Gg: AeBDievrt7auND6UJBsgDeA8WB/nnKGgQC5Al17dAFKfTgm27pykqm0HyyWIadWJojO
	I9dABVz3CZHoFY5P9gFrJlKZguhAhR7WcEVVWTa6awDoM4ii29C/No4+AvLy5JLQi6ywyAf0sGh
	uB5te6EyaGfrLdm+FPi1UkndOpdF3BfQLRUoTsymc0iXqnV5GtcqKQjnO/fChEEoTR2GfnGKKae
	BoQ4t4clvjxA/KunVpP+TVCQQPzfQou5vxgCm7ydfdLp+bi9aDO/dggDcthHEIP1cA6W6YPBVlR
	xxrd2/UuOqQGOoMp6lxVKpeuGzku4HydHcbxoVZP84MMkaKJ13GdJ5Xo19Sgfin/+BN8YOaLW4L
	Qpu3dHBdRSqWo9zqYPeKwLdskANpxuFQ8nHTBF3taAWLP9O8hA3PfOV5OloLIva8r8P+RE+/QfZ
	h1NKtvia7rnrIu1sjaac+Gvs9DZMyh5qb0rja9rkGqoNLW3zvt8fLflBDDxYseFJArHAOiDPy8n
	1FkHPgr+ku7wSpz9zSz6dA=
X-Received: by 2002:a05:7300:ec11:b0:2e5:5bf4:8869 with SMTP id 5a478bee46e88-2f54c87cd18mr1071089eec.21.1778044441041;
        Tue, 05 May 2026 22:14:01 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56fd8fa8csm1701041eec.21.2026.05.05.22.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 22:14:00 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Wed, 06 May 2026 02:13:45 -0300
Subject: [PATCH net] tipc: avoid sending zero-length stream messages
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260506-tipc-zero-length-stream-stall-v1-1-5d75f202227b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vche3aTUkSjr2I8lGWENbWQthoD4
 d2tepr8c/hWSoiKROdqpYiXJp1CiXpXkYwuDGDtS5M19mBa03LWWXhBnNgjDHnklCPco4zznq0
 0x33dw8qpoWLMETd9//wLBWS6/s/07O6Q/JVp2z7BsX93hgAAAA==
X-Change-ID: 20260505-tipc-zero-length-stream-stall-2c3741de2c93
To: Jon Maloy <jmaloy@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Ying Xue <ying.xue@windriver.com>, 
 Parthasarathy Bhuvaragan <parthasarathy.bhuvaragan@ericsson.com>
Cc: Jon Paul Maloy <jon.maloy@ericsson.com>, netdev@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 syzbot+aa7d098bd6fa788fae8e@syzkaller.appspotmail.com, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1829;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=3mPDjpz9UoYLq//zME7f0LLK/FYBp27tbNuZ0h5zQJs=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJm/zolsfyX8tXyhaf4/2exTZgqV4edNkotv/wkqaytYe
 Mq/5k5JRykLgxgXg6yYIsvqpEWWe7oeXK2PW+EBM4eVCWQIAxenAEzklTQjw9RT2lZRq45cOtos
 WXo1zHf3z9ub/y48vXSK3KWZJYs/LJzB8D8wLT1C+7bQ2qvlEgITgnesffT0hvbaBe6KbQHBYX7
 mz7kA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: A83C94D6409
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244316-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ericsson.com,vger.kernel.org,lists.sourceforge.net,syzkaller.appspotmail.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,aa7d098bd6fa788fae8e];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]

TIPC stream send currently enters the transmit loop even when the
user payload length is zero. This can build and transmit a
header-only connection message.

For local TIPC sockets, such messages are delivered synchronously
through the loopback receive path. When this happens while socket
backlog processing is being flushed, reply transmission can re-enter
TIPC receive processing repeatedly and trigger an RCU stall.

Make zero-length sends on connected SOCK_STREAM TIPC sockets a no-op
after the existing connection/congestion wait has succeeded. Leave
implicit connection setup and SOCK_SEQPACKET behavior unchanged.

Fixes: 365ad353c256 ("tipc: reduce risk of user starvation during link congestion")
Cc: stable@vger.kernel.org
Reported-by: syzbot+aa7d098bd6fa788fae8e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000cedbc405ae81531f@google.com/
Closes: https://syzkaller.appspot.com/bug?extid=aa7d098bd6fa788fae8e
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 net/tipc/socket.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tipc/socket.c b/net/tipc/socket.c
index 9329919fb07f..3c7838713d74 100644
--- a/net/tipc/socket.c
+++ b/net/tipc/socket.c
@@ -1585,6 +1585,8 @@ static int __tipc_sendstream(struct socket *sock, struct msghdr *m, size_t dlen)
 					 tipc_sk_connected(sk)));
 		if (unlikely(rc))
 			break;
+		if (unlikely(!dlen && sk->sk_type == SOCK_STREAM))
+			break;
 		send = min_t(size_t, dlen - sent, TIPC_MAX_USER_MSG_SIZE);
 		blocks = tsk->snd_backlog;
 		if (tsk->oneway++ >= tsk->nagle_start && maxnagle &&

---
base-commit: 95084f1883a760e0d4290698346759d58e2b944a
change-id: 20260505-tipc-zero-length-stream-stall-2c3741de2c93

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


