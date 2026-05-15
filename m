Return-Path: <stable+bounces-248282-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKGZFhhOB2rAxgIAu9opvQ
	(envelope-from <stable+bounces-248282-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:47:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D54D5553EB1
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BD87310A23D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2B93E00A1;
	Fri, 15 May 2026 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ojGlca73"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610393F44E7;
	Fri, 15 May 2026 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861335; cv=none; b=GtnHesVergG78D4W2M5mUp3M4YfyUssPVrW4AUo1ox9QKjt6uh1+u+C7IhsqEhwntE0gh07J14nr3v/uBHkwj4mAMZLEJ+GBZnFeqboqP6Aq3hRCpZnZOU2yNJpUEhcd15CMql5pKkHHBANjRmSW60ci+B1xNwLQpLXIVBE7+BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861335; c=relaxed/simple;
	bh=Ik0HE8aze8lFsfs4elQIYsZKt1QVWCKSEl4iLH9zYvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crlmmSepRZA9DBig8FGPxjvtL79v4PDnxsyRm/yp8y2jAy8uEQt0OviJr6AgxZPDSIc/lvhRmBpXcgaLk8IEcB5e/JyZTkpa3EpHytpJAZnUWTEwbmws2LEH7PmVOwmJqxvg1+WMxNArfvtvDZexhzj4Ev0CYeWiAqIqZqvI0qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ojGlca73; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E47C2BCB3;
	Fri, 15 May 2026 16:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861335;
	bh=Ik0HE8aze8lFsfs4elQIYsZKt1QVWCKSEl4iLH9zYvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ojGlca73dJ350CFBtmYQge4iLc9eqU/YJnPQRu8P2pFgGrh6826wsmugjKj8JcE9c
	 qw3I7qmXCR5EP5JH0viHoSV3YPWa7dXJFtGOHVZrMDhULLOtAboXNnyrNiD1ag5pr3
	 ex2eLTFd5XW/ZbdwpEz/ySohF72cjffwGrf7morM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sashiko <sashiko-bot@kernel.org>,
	Gang Yan <yangang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 287/474] mptcp: fix scheduling with atomic in timestamp sockopt
Date: Fri, 15 May 2026 17:46:36 +0200
Message-ID: <20260515154721.210694428@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: D54D5553EB1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248282-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,kylinos.cn:email,msgid.link:url]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gang Yan <yangang@kylinos.cn>

commit b5c52908d52c6c8eb8933264aa6087a0600fd892 upstream.

Using lock_sock_fast() (atomic context) around sock_set_timestamp()
and sock_set_timestamping() is unsafe, as both helpers can sleep.

Replace lock_sock_fast() with sleepable lock_sock()/release_sock()
to avoid scheduling while atomic panic.

Fixes: 9061f24bf82e ("mptcp: sockopt: propagate timestamp request to subflows")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260420093343.16443-1-gang.yan@linux.dev
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260427-net-mptcp-misc-fixes-7-1-rc2-v1-2-7432b7f279fa@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/sockopt.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -159,10 +159,10 @@ static int mptcp_setsockopt_sol_socket_t
 	lock_sock(sk);
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		bool slow = lock_sock_fast(ssk);
 
+		lock_sock(ssk);
 		sock_set_timestamp(ssk, optname, !!val);
-		unlock_sock_fast(ssk, slow);
+		release_sock(ssk);
 	}
 
 	release_sock(sk);
@@ -235,10 +235,10 @@ static int mptcp_setsockopt_sol_socket_t
 
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		bool slow = lock_sock_fast(ssk);
 
+		lock_sock(ssk);
 		sock_set_timestamping(ssk, optname, timestamping);
-		unlock_sock_fast(ssk, slow);
+		release_sock(ssk);
 	}
 
 	release_sock(sk);



