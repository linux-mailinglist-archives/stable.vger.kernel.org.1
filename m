Return-Path: <stable+bounces-238047-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJEpJAUp32lpPgAAu9opvQ
	(envelope-from <stable+bounces-238047-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 07:58:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DCD400A9A
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 07:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8C123051901
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 05:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654E13624C5;
	Wed, 15 Apr 2026 05:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlW0yCkL"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D48346E64
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 05:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232696; cv=none; b=oAAPnNKyUX3SEH8UwUXta0c+md3g+uEomituveZZCEormVgpfoy9up+iyw6Gg4KYd/hpjYITwAvbPHWev5MecSsBBDyjZpiMvQKHy37MZPgapZU11yCT3+w/CcRTtuk15rPAIcMWfe1uRC5yCD1MAPHSxsrDqM5DExLBBQ9fxmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232696; c=relaxed/simple;
	bh=YJk7HFFywOAvglX29zYP4iiLAIOHUmcE1zceWMyjEtA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jbZWYJxDbZEZY7XhT/B45O81OpcfPUzk/rrA/o6VLxLdMJBRGJntbg3XbVbKn9kYlZd5JgVyxsd3k1bwcouhqg6F8yPlmxEwwnG86JoeDVh4VvOuQkGosRplhrONwGwBTYcWly21hcRw4uigpHJH+W5ualFuQK3+P1EGr0XGj84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlW0yCkL; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79a7109f568so75158397b3.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 22:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776232693; x=1776837493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J7Qu+iufcZ9jYk8S+wuxRjUaOgj3R8vJUSvzid2gdM4=;
        b=TlW0yCkLIUBrvRuZTGswlI+GJHBMFFyVA1SRcXn5BMqV9Ujb5FhwfPEBoGmxCR3hL2
         CdF3kooUryWPabs6wKdosOsBxrtCE/SHio/Ii8HtuUCZ6f2fE8c0RDM/Yo9zoNIR8nj2
         6J4YDpN9TZfWhspbIOohqeDLPw4aHcwBv3uS4WZ96GhkdsqtCTQr4OR/PXvZXPpoFkbB
         e4NgD0w08T7n76l5FEOK53jFB4lYGJp0rLQiYW+UaFk9A1q24Xc9GWDRZwIyy0fcmaIm
         XEQ0b718Xvn4SYcubqmyq4A6lk703CF/FEtdUNMmHJuIIERo3wYNFpLCyM0QV6528Gvn
         CDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776232693; x=1776837493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7Qu+iufcZ9jYk8S+wuxRjUaOgj3R8vJUSvzid2gdM4=;
        b=AOpr9uKT+PZM61/BrrKuCD0TBRHrNStM0f3cZyQq7F2gCbgepUespY4zJvqO838omZ
         VO0tx0MeCcpFqDsfEzJx6CfIF8d0Ci83wdL+jzOaGDN2MAdQr4LoM9OwbL6jftkohDaz
         XLkocUjJ72Yy/5unRkipj3NPdlg31Zqpffkh5ddafFLNWCrLR7hXJYDYPcXhtxEdKIFJ
         yc+r8HTpzVUAqVWmLgB+x8NeMXE5Sv8HIO3MABaEQPfNbHgsJ0zN2PMs8x1ywP7lPLkJ
         /u1s02y9bGQFVGpEyCnNG47PLUKdN1ISfbrvL6ERU2//Ep9EG+xxM87Q/5YQT9II/BGn
         g0Dw==
X-Forwarded-Encrypted: i=1; AFNElJ9IF1IxZI6oUGF2dNuHjUqiD6vHNRUJjSnQpo+egH3E0Czs8H4sGGh6vEv0JTr5eDqI/5WY0A4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO33ruqqcX3oFmKwzUk8KSdgPCDBAb78GkYo0a9stxQKwC3hcV
	j5TwdLCSDZfusTqUhxaLlRV4WYXIw91NNY1o8a2f3byU0RLy+altZcF3
X-Gm-Gg: AeBDievpPaKcBNbzVAXddZy63AM6Rm9uAf/+QON+OouEurw+HZQtqlnElKsPdz7Df30
	fJ0L2qL2AyPRb4Z8I3dp2Cob6Irl1jrRU9gjXuRJjSsZKAzdUyTuTmV1VrYro94IOhOrrAUx//n
	YLMF2pIQ/HzEwCWm5SfaaqvzIWWtj/5LPm2cHTH8bCTSWdmy+P5aNlL/Tsm22h8jBM4lMPpQLTJ
	xDzzBCG+e9aagh8n+rorm9XMTsqQLxUEc7SgjlPjsqIXmdslJwWce6Anp2oZFGvDPgONvKRBEy/
	I5RiwYGdYjugB61RXG0LSWLYw7qvgV004HvRcMJ/LE1vGSEMM+Pj+PHII55l/D0eH9QV2zbA99F
	LzX+qcQaJcrbjwDTcNUyhRFeriF4CnH4mcmQ6zkSmD1W7gPuEHu5QPCp2Wxi06UjBIo0KTbinYO
	7X9IGPljajftUVNFvHmBV9mYNno0FQ/EqgyceOGP23PRSMhm4EO3RKqtAIslzljQKZryJAC4l/9
	P/8BdtH/ZlfnTqpk3F0XUR4WWqkNvnpHxbRax8=
X-Received: by 2002:a05:690c:85:b0:7a2:f14d:5a1 with SMTP id 00721157ae682-7af7252df6emr209920057b3.49.1776232693315;
        Tue, 14 Apr 2026 22:58:13 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b768d387eesm4440177b3.29.2026.04.14.22.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 22:58:12 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-hams@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH v3 net] rose: fix OOB reads on short CLEAR REQUEST frames
Date: Wed, 15 Apr 2026 05:57:56 +0000
Message-Id: <20260415055756.3825584-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-238047-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49DCD400A9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rose_process_rx_frame() calls rose_decode() which reads skb->data[2]
without any prior length check. For CLEAR REQUEST frames the state
machines then read skb->data[3] and skb->data[4] as the cause and
diagnostic bytes.

A crafted 3-byte ROSE CLEAR REQUEST frame passes the minimum length
gate in rose_route_frame() and reaches rose_process_rx_frame(), where
rose_decode() reads one byte past the header and the state machines
read two bytes past the valid buffer. A remote peer can exploit this
to leak kernel memory contents or trigger a kernel panic.

Add a pskb_may_pull(skb, 3) check before rose_decode() to cover its
skb->data[2] access, and a pskb_may_pull(skb, 5) check afterwards for
the CLEAR REQUEST path to cover the cause and diagnostic reads.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
V2 -> V3: drop kfree_skb() calls to fix double-free; add end-user
          visible symptom to commit log; use [net] subject prefix
V1 -> V2: switch skb->len check to pskb_may_pull; add pskb_may_pull(skb, 3)
          before rose_decode() to cover its skb->data[2] access

v2: https://lore.kernel.org/netdev/177614667427.3606651.8700070406932922261@gmail.com/
v1: https://lore.kernel.org/netdev/20260409013246.2051746-1-ashutoshdesai993@gmail.com/

 net/rose/rose_in.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/rose/rose_in.c b/net/rose/rose_in.c
index 0276b393f0e5..8e60dc562b4a 100644
--- a/net/rose/rose_in.c
+++ b/net/rose/rose_in.c
@@ -269,8 +269,14 @@ int rose_process_rx_frame(struct sock *sk, struct sk_buff *skb)
 	if (rose->state == ROSE_STATE_0)
 		return 0;
 
+	if (!pskb_may_pull(skb, 3))
+		return 0;
+
 	frametype = rose_decode(skb, &ns, &nr, &q, &d, &m);
 
+	if (frametype == ROSE_CLEAR_REQUEST && !pskb_may_pull(skb, 5))
+		return 0;
+
 	switch (rose->state) {
 	case ROSE_STATE_1:
 		queued = rose_state1_machine(sk, skb, frametype);
-- 
2.34.1


