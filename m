Return-Path: <stable+bounces-248609-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SATqHrVNB2pZwwIAu9opvQ
	(envelope-from <stable+bounces-248609-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:45:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0DD553DA6
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F0B23053727
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4F73F9292;
	Fri, 15 May 2026 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZBbHeqCG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB193FBB4D;
	Fri, 15 May 2026 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862170; cv=none; b=M2oMk6fLDRF2EhbwClvZazGz5NSzA/aJALkby3t+Jp/Mr//R2SinWfvcYM56yzJTnMGzt3F+1Je51ggZCbUBz7nySu3ZpeMK3N2iguc0VLIw9rWyri0ihSUD2/wnNfhLYZ7R0sr5TeHD7ddQG8WU5dv5VnP2vHM3/62YSq8eLvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862170; c=relaxed/simple;
	bh=mzMMfAactXXrpZ95RxdpijML86SmkTTlkhvJBt7ZFns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtyWi5RGJ443T/mxbJrF0M2RkqJKLgb0CQoT+X8bDY578qmq43uU2S+ROEOHCCxNRn8jbWLmDvc/umJrZmwH0JAvd23PT9+bXd/gV2fea2gUxkiMLpC4wcJFqMutAm8KkARFizYLxyImnV3ZwyTBiifCUzpczjXsfqAn+Ah9E9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZBbHeqCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2DBC2BCB0;
	Fri, 15 May 2026 16:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862170;
	bh=mzMMfAactXXrpZ95RxdpijML86SmkTTlkhvJBt7ZFns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZBbHeqCGk2yohtF30t7G6P+B8i0bJaly+vWP7DhANclmgPGXKuv8Rx08JHZXJPf8Y
	 1FAsxSFc3q4yqU2odqEpVmDWovJsyOKmIXiBSf2DWR17fQnv37Q0xNVLYJp/+h/p9L
	 Dldn5+onnu+qDizbqE70tZFnEuyIkYWX9v/0CyHs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ben Morris <bmorris@anthropic.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 135/188] sctp: revalidate list cursor after sctp_sendmsg_to_asoc() in SCTP_SENDALL
Date: Fri, 15 May 2026 17:49:12 +0200
Message-ID: <20260515154700.257584104@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154657.309489048@linuxfoundation.org>
References: <20260515154657.309489048@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 2C0DD553DA6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-248609-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,anthropic.com,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anthropic.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Morris <bmorris@anthropic.com>

commit abb5f36771cc4c05899b34000829a787572a8817 upstream.

The SCTP_SENDALL path in sctp_sendmsg() iterates ep->asocs with
list_for_each_entry_safe(), which caches the next entry in @tmp before
the loop body runs.  The body calls sctp_sendmsg_to_asoc(), which may
drop the socket lock inside sctp_wait_for_sndbuf().

While the lock is dropped, another thread can SCTP_SOCKOPT_PEELOFF the
association cached in @tmp, migrating it to a new endpoint via
sctp_sock_migrate() (list_del_init() + list_add_tail() to
newep->asocs), and optionally close the new socket which frees the
association via kfree_rcu().  The cached @tmp can also be freed by a
network ABORT for that association, processed in softirq while the
lock is dropped.

sctp_wait_for_sndbuf() revalidates @asoc (the current entry) on re-lock
via the "sk != asoc->base.sk" and "asoc->base.dead" checks, but nothing
revalidates @tmp.  After a successful return, the iterator advances to
the stale @tmp, yielding either a use-after-free (if the peeled socket
was closed) or a list-walk onto the new endpoint's list head (type
confusion of &newep->asocs as a struct sctp_association *).

Both are reachable from CapEff=0; the type-confusion path gives
controlled indirect call via the outqueue.sched->init_sid pointer.

Fix by re-deriving @tmp from @asoc after sctp_sendmsg_to_asoc()
returns.  @asoc is known to still be on ep->asocs at that point: the
only callers that list_del an association from ep->asocs are
sctp_association_free() (which sets asoc->base.dead) and
sctp_assoc_migrate() (which changes asoc->base.sk), and
sctp_wait_for_sndbuf() checks both under the lock before any
successful return; a tripped check propagates as err < 0 and the loop
bails before the re-derive.

The SCTP_ABORT path in sctp_sendmsg_check_sflags() returns 0 and the
loop hits 'continue' before sctp_sendmsg_to_asoc() is ever called, so
the @tmp cached by list_for_each_entry_safe() still covers the
lock-held free that ba59fb027307 ("sctp: walk the list of asoc
safely") was added for.

Fixes: 4910280503f3 ("sctp: add support for snd flag SCTP_SENDALL process in sendmsg")
Cc: stable@vger.kernel.org
Signed-off-by: Ben Morris <bmorris@anthropic.com>
Acked-by: Xin Long <lucien.xin@gmail.com>
Link: https://patch.msgid.link/20260508001455.3137-1-joycathacker@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sctp/socket.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1985,6 +1985,15 @@ static int sctp_sendmsg(struct sock *sk,
 				goto out_unlock;
 
 			iov_iter_revert(&msg->msg_iter, err);
+
+			/* sctp_sendmsg_to_asoc() may have released the socket
+			 * lock (sctp_wait_for_sndbuf), during which other
+			 * associations on ep->asocs could have been peeled
+			 * off or freed.  @asoc itself is revalidated by the
+			 * base.dead and base.sk checks in sctp_wait_for_sndbuf,
+			 * so re-derive the cached cursor from it.
+			 */
+			tmp = list_next_entry(asoc, asocs);
 		}
 
 		goto out_unlock;



