Return-Path: <stable+bounces-240138-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKsZDdtu52ke8AEAu9opvQ
	(envelope-from <stable+bounces-240138-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 14:34:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AE143AAC3
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 14:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABBEF3060A0E
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8CF3CB2F2;
	Tue, 21 Apr 2026 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZqwRoox"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22093BE62F
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776774689; cv=none; b=C0uxVJRLXeC5t+8WMXrpx9v7juafOg+gNxYAEDMGQCSWQ2Cfn+hxkmDzjOW3NEGHhLF1PfqeJpW4ukRpVKGjXmpaE+PbBQrOgA3jfiDuV1Q+jVIJKyCCM/zQoNjiArksbbl4wTXcv13FCwoMmVjKPu4aM8Uy+EiTyRBUiCpW5co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776774689; c=relaxed/simple;
	bh=usACHL7JFJ+Iojq2WMGOR+XEp5pZozfvJwRKATA+b/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjMFC929PqYY4gdyXtiQ2i4dX4BbQSwx3E0g4G+okF7znYH2RUFeXlFoAYgsKBzCy6I87D42NBFI6EPf3dUU2l9S8KGMiAiUaG6FJ8tOBLG/r0v0q5JfW23TZFIUa9B1pt6B+VdnAtZixKWfylsRCx3tP6dCP0k+/IXFw7UefBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oZqwRoox; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ad9516a653so21709695ad.0
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 05:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776774684; x=1777379484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qCHQt+5njpxpDnHvEMfTt2VrNOBnIxuj1+x6opPunc=;
        b=oZqwRooxG1EQH9IR+N9JAP7ZGi/X6mEnWAfgIFe7c9aTqD7y+/Z73H9SZ3hweSWuGH
         vT/mns5SFKsLhas35xVi2T3C7uJecCWP01AM24PuEgeYmcWiSxBYWYEU8IvV94A0SzjQ
         uWoht621Kw/J3Gis5Ne5txUs+fodLf81/IAPS+VMNqjI3lFPsDhqEP8z07bIzbg2Avj5
         lStzqXo9B9dcY+549BVBnpEUBtnbTTWc2a6AXd9MssAqL3nFuf0iIkSGNwfxRXSUq9Ss
         zfWtF+5zsaty7+rlLN4JGRlik78MrXiq2EmLUQcQ/EQShIDoVDsZrLO5RDXEcjqh3taV
         YWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776774684; x=1777379484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2qCHQt+5njpxpDnHvEMfTt2VrNOBnIxuj1+x6opPunc=;
        b=NuWiBIzbCyzXj/2VJdZtSP/z3Eao3d8IC6FySFWDDQaiiL2FqSh7VEx6O/xInEnrqy
         6kMrdCKG4cmfBkf+wtftG0eGztCB765T2vb60dG/vB2UMpC7BrpechO3c1QozMQw12aN
         XpoF3m5tWVrMx5Ugx6xHALNEC3RLAS6l7zEUN0AHw4nTO/rpxu8lxogJGG4OCSONzhGS
         W9UdQPOATEmu342Z7hh60fNQouLPoqfVAGsx6lofnR8RFUJGa1THB3wdaBJk7BxyhRin
         3txpMRQwrnNwDPGa8fXSbsi8UzG3PMqAykKRKjSgp4Ui+imouX0a0cK9u8g5MyGkSuGy
         8Zig==
X-Forwarded-Encrypted: i=1; AFNElJ9woqxolydMlE8gOoYbNeaS3WHLBRpGrUwmYOOTqJ4bnztQxegcFinaWG+6zikJN64Exi7gFzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCiLS7yA02EITnUrYfry2YInzVUhPRyqNcZfrFzJ64RLIqwBUZ
	1QVOpODoNRw60mlLlsOUIlmbxGw6yKsHNhkbPdmaJSn2axMvpmhsOwSe
X-Gm-Gg: AeBDievxMxzf+st/m9WLZowPK+5w0wkB9LssBUbRh5CPKwDax5aaeFVCLeWex79H0Hc
	cbtPGo9UP6uQ2MwEmXz2vMzL+sOmVGftvMufNJKdQF6uZJklG8wG3YSTmMq84oq/AafOfEWvYHH
	lqVs56E2EGQZ4s1aVjPiezLm6hzSsCijnvy7SJjY574cVy4eY3CQ+Vnzr6VZaRjZ930W5+pCVA0
	UggXFwzr/6iYfcgvLvi7gXiMiufafYiE1kjL9nV8Kv2rszbPocS/KfDcXZTJFzeFA/hKAUBUxk8
	+mstGETjCiqjnF2wh+E6ha7ZxuRlS9rPSkFuJ8cTxOdirERfwAsHylV77oyOkQ+0EGk6hbWuoJR
	KeuJx+QxNvlFdgPyNOam7VLfNAUKUzP9g3pALqbA5lm0wc3D/IbHcgTdXaHEb7aw8Kqvgvbtnnt
	58Syt0UyAoy4qmBgGJcpDHj3p9pvlg2dSC/98j1ZPX/qbrSpy2HI8jQTcdIIILjA==
X-Received: by 2002:a17:902:db10:b0:2b2:4a9a:b149 with SMTP id d9443c01a7336-2b5f9e79dcfmr197068945ad.9.1776774683926;
        Tue, 21 Apr 2026 05:31:23 -0700 (PDT)
Received: from DESKTOP-MUHC17F.tail07b66e.ts.net ([188.253.121.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff409sm169724315ad.14.2026.04.21.05.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:31:23 -0700 (PDT)
From: Zhenzhong Wu <jt26wzz@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	tamird@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Zhenzhong Wu <jt26wzz@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v3 1/2] tcp: call sk_data_ready() after listener migration
Date: Tue, 21 Apr 2026 20:31:05 +0800
Message-ID: <20260421123106.142299-2-jt26wzz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421123106.142299-1-jt26wzz@gmail.com>
References: <20260421123106.142299-1-jt26wzz@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-240138-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jt26wzz@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4AE143AAC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When inet_csk_listen_stop() migrates an established child socket from
a closing listener to another socket in the same SO_REUSEPORT group,
the target listener gets a new accept-queue entry via
inet_csk_reqsk_queue_add(), but that path never notifies the target
listener's waiters. A nonblocking accept() still works because it
checks the queue directly, but poll()/epoll_wait() waiters and
blocking accept() callers can also remain asleep indefinitely.

Call READ_ONCE(nsk->sk_data_ready)(nsk) after a successful migration
in inet_csk_listen_stop().

However, after inet_csk_reqsk_queue_add() succeeds, the ref acquired
in reuseport_migrate_sock() is effectively transferred to
nreq->rsk_listener. Another CPU can then dequeue nreq via accept()
or listener shutdown, hit reqsk_put(), and drop that listener ref.
Since listeners are SOCK_RCU_FREE, wrap the post-queue_add()
dereferences of nsk in rcu_read_lock()/rcu_read_unlock(), which also
covers the existing sock_net(nsk) access in that path.

The reqsk_timer_handler() path does not need the same changes for two
reasons: half-open requests become readable only after the final ACK,
where tcp_child_process() already wakes the listener; and once nreq is
visible via inet_ehash_insert(), the success path no longer touches
nsk directly.

Fixes: 54b92e841937 ("tcp: Migrate TCP_ESTABLISHED/TCP_SYN_RECV sockets in accept queues.")
Cc: stable@vger.kernel.org
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Zhenzhong Wu <jt26wzz@gmail.com>
---
 net/ipv4/inet_connection_sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 4ac3ae1bc..928654c34 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1479,16 +1479,19 @@ void inet_csk_listen_stop(struct sock *sk)
 			if (nreq) {
 				refcount_set(&nreq->rsk_refcnt, 1);
 
+				rcu_read_lock();
 				if (inet_csk_reqsk_queue_add(nsk, nreq, child)) {
 					__NET_INC_STATS(sock_net(nsk),
 							LINUX_MIB_TCPMIGRATEREQSUCCESS);
 					reqsk_migrate_reset(req);
+					READ_ONCE(nsk->sk_data_ready)(nsk);
 				} else {
 					__NET_INC_STATS(sock_net(nsk),
 							LINUX_MIB_TCPMIGRATEREQFAILURE);
 					reqsk_migrate_reset(nreq);
 					__reqsk_free(nreq);
 				}
+				rcu_read_unlock();
 
 				/* inet_csk_reqsk_queue_add() has already
 				 * called inet_child_forget() on failure case.
-- 
2.43.0


