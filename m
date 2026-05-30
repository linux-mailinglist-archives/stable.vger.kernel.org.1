Return-Path: <stable+bounces-257347-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNR9KBUbG2pk/QgAu9opvQ
	(envelope-from <stable+bounces-257347-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:15:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D91560F388
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E86E309B28B
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8AF34104B;
	Sat, 30 May 2026 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cuSRQoFJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03472690D5;
	Sat, 30 May 2026 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160677; cv=none; b=IeVFaJCUMFj44huGGn8F6ArahvSWz74tlu8VCrj/mUiNEqulMvKdrEB3t4QzS4Bcsr2n4QlO4S1DEZGbCEdm+FcovO0X9TgAJft3PjEVXvxiGQSZhDlzopbbdNwb8ijpBQQbqbVKTpOL4LfgPHgJf1jJlQ+UCOZwvoD6PvsxzKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160677; c=relaxed/simple;
	bh=hQZs4XCTYQcFZCSVR83u8Wvr8SJ53WchQddkCed3I5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3EhF5yegpzjra/1D94MHJ/3JuXe3trb09I/wR7JX5Q3tGzKp6oHEDeO3VRmw8zYlJW5LcOE75XS4F2xqyk3G42LplrgNceajWdtRL1FXgzUjtumzV1Rjny6pETgt7rHAtjdVcFRspQpdEwfrjFD64sFP/zTT7Ekn2tM6jpYKJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cuSRQoFJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118021F00898;
	Sat, 30 May 2026 17:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160676;
	bh=ZbV+9wXIrsHefJBkIDarSJpVtifiZrVGTvEz5aVpnRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cuSRQoFJn6bmBpEq9nVPYqBQM29U2LdThgaIkZCCdJuEOijbYqhoMNQ+kr53OW/3M
	 ZnhcndHQLvJa1LgCjFG+Gw7IqS4G39malG0bBYiB4WPFoJa6r6xthBAOSqnTVQoZ7X
	 GvhlL33u9Bz21hUxdY1o2F12G+iq9uY+vJhiLubI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gang Yan <yangang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 373/969] mptcp: sockopt: set timestamp flags on subflow socket, not msk
Date: Sat, 30 May 2026 17:58:17 +0200
Message-ID: <20260530160310.613419377@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257347-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0D91560F388
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gang Yan <yangang@kylinos.cn>

commit 5f95c21fc23a7ef22b4d27d1ed9bb55557ffb926 upstream.

Both mptcp_setsockopt_sol_socket_tstamp() and
mptcp_setsockopt_sol_socket_timestamping() iterate over subflows,
acquire the subflow socket lock, but then erroneously pass the MPTCP
msk socket to sock_set_timestamp() / sock_set_timestamping() instead
of the subflow ssk. As a result, the timestamp flags are set on the
wrong socket and have no effect on the actual subflows.

Pass ssk instead of sk to both helpers.

Fixes: 9061f24bf82e ("mptcp: sockopt: propagate timestamp request to subflows")
Cc: stable@vger.kernel.org
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260427-net-mptcp-misc-fixes-7-1-rc2-v1-1-7432b7f279fa@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/sockopt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -159,7 +159,7 @@ static int mptcp_setsockopt_sol_socket_t
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		bool slow = lock_sock_fast(ssk);
 
-		sock_set_timestamp(sk, optname, !!val);
+		sock_set_timestamp(ssk, optname, !!val);
 		unlock_sock_fast(ssk, slow);
 	}
 
@@ -235,7 +235,7 @@ static int mptcp_setsockopt_sol_socket_t
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		bool slow = lock_sock_fast(ssk);
 
-		sock_set_timestamping(sk, optname, timestamping);
+		sock_set_timestamping(ssk, optname, timestamping);
 		unlock_sock_fast(ssk, slow);
 	}
 



