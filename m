Return-Path: <stable+bounces-230100-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEduBOxgwmmecAQAu9opvQ
	(envelope-from <stable+bounces-230100-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:01:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8090306180
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 11:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A6153111FF3
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 09:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1361A3E0C49;
	Tue, 24 Mar 2026 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQiRqyYc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99003DFC94;
	Tue, 24 Mar 2026 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774345854; cv=none; b=bGRbxwBLnDekGa3YPaKHonbXalFXHADxexHg2pJXxwn+gZWrKSYqh+8CeKj5QS7NkXhT62+R8L/LIEsYbhgnRgRjE+c0JFry6NK4uvODWhsB4Mn/E6UZMKnJFdz3cGpj+vXHRxYIOA4NlP8rmm1ioCU7M1gZZW06S8CZnx8TKFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774345854; c=relaxed/simple;
	bh=WWYsXIQKqwFtBguw1GEAWGegDLh6cX2bIrRO2RLIyzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5lbqUlpGIhS4euEglZegfK/f+MCbllJnfMbAOFyG+fISyWhoN2e8xJZ2E2Ae+Zm2+HJigK26L6nWpodiFUUWAxs1XcMuUot0jxneUfW5dsZrR3e57DvnAKD31wIBLunJadnf4NYmeU1Ya40AEmzI+Cb4yBz5Xj/d4Cs0y2PxuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQiRqyYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3BCC19424;
	Tue, 24 Mar 2026 09:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774345854;
	bh=WWYsXIQKqwFtBguw1GEAWGegDLh6cX2bIrRO2RLIyzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQiRqyYcRmELaB+VZmYUJYA15dVoRuxkEWQm7FDMWAplfeaAWTwPA6XuA78R/JFEI
	 jihgqHpbeDWVZb84Cs/s1XVgZp4G7AgcRhbofeCHdd9LV/9lETKUVRoLDBfbhIL6xm
	 89WBWFBVN5q4I7NV8sIF8tUZ4F5Spi/3ZpGUcrfEDDnzI7iBfRuiOrXrwZohWREk3p
	 cT0Cql2ZRNN+QiKv/QWbn3x29AJH8O0FffqRMBKu8VJSAJuCjm6zERNKJvD3xQ26yt
	 zn8MvxnEgWsC9HYdY+kaEVrI90ob3wz7DxVgICmsorHz38ZHiTr+sm5hDUS5OeJFrX
	 FSDoZwwd46j5Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	sashal@kernel.org
Subject: [PATCH 6.1.y 1/2] selftests: mptcp: join: implicit: stop transfer after last check
Date: Tue, 24 Mar 2026 10:49:38 +0100
Message-ID: <20260324094936.1826804-5-matttbe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324094936.1826804-4-matttbe@kernel.org>
References: <20260324094936.1826804-4-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3684; i=matttbe@kernel.org; h=from:subject; bh=WWYsXIQKqwFtBguw1GEAWGegDLh6cX2bIrRO2RLIyzA=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDIPxRmZGq3VPFvq/9un9Hq0cJtrVY+bL/+Dy+dm/Dude D9q5wvvjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIlsa2dkONn4vbls667uTU5b 9XYzHLukYC65uPKy2Mutq73deuYa6jMybHmr5zxp4jnBjUerV/IsmXtrxhe+DrO59nvj2P9fyg5 o4wAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230100-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8090306180
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

With this kernel version, the 'implicit EP' MPTCP Join selftest ended
with an error message:

  115 implicit EP                          creation[ ok ]
                                           ID change is prevented[ ok ]
                                           modif is allowed[ ok ]
  TcpPassiveOpens                 2                  0.0
  TcpEstabResets                  2                  0.0
  TcpInSegs                       315                0.0
  TcpOutSegs                      617                0.0
  TcpOutRsts                      1                  0.0
  TcpExtDelayedACKs               289                0.0
  TcpExtTCPPureAcks               6                  0.0
  TcpExtTCPOrigDataSent           306                0.0
  TcpExtTCPDelivered              306                0.0
  MPTcpExtMPCapableSYNRX          1                  0.0
  MPTcpExtMPCapableACKRX          1                  0.0
  MPTcpExtMPJoinSynRx             1                  0.0
  MPTcpExtMPJoinAckRx             1                  0.0
  MPTcpExtAddAddr                 1                  0.0
  MPTcpExtEchoAdd                 1                  0.0
  MPTcpExtMPFastcloseTx           1                  0.0
  MPTcpExtMPRstTx                 1                  0.0
  MPTcpExtMPRstRx                 1                  0.0
  TcpActiveOpens                  2                  0.0
  TcpEstabResets                  2                  0.0
  TcpInSegs                       617                0.0
  TcpOutSegs                      315                0.0
  TcpOutRsts                      1                  0.0
  TcpExtTCPPureAcks               308                0.0
  TcpExtTCPOrigDataSent           306                0.0
  TcpExtTCPDelivered              307                0.0
  MPTcpExtMPCapableSYNTX          1                  0.0
  MPTcpExtMPCapableSYNACKRX       1                  0.0
  MPTcpExtMPJoinSynAckRx          1                  0.0
  MPTcpExtAddAddr                 1                  0.0
  MPTcpExtEchoAdd                 1                  0.0
  MPTcpExtMPFastcloseRx           1                  0.0
  MPTcpExtMPRstTx                 1                  0.0
  MPTcpExtMPRstRx                 1                  0.0
  MPTcpExtRcvWndShared            1                  0.0

That's because the test was waiting for the end of the transfer for no
reasons, which ended after a timeout with an error. In this case, the
stats were displayed, but this error was ignored: the end of transfer is
not validated in this test.

To fix that, stop the transfer after the last check, similar to what is
done in the other tests.

Fixes: 699879d5f866 ("selftests: mptcp: join: endpoints: longer transfer")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 80497053fe2f..044ba9c4e169 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3429,6 +3429,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		run_tests $ns1 $ns2 10.0.1.1 128 0 0 slow 2>/dev/null &
+		local tests_pid=$!
 
 		wait_mpj $ns1
 		pm_nl_check_endpoint 1 "creation" \
@@ -3441,6 +3442,7 @@ endpoint_tests()
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags signal
 		pm_nl_check_endpoint 0 "modif is allowed" \
 			$ns2 10.0.2.2 id 1 flags signal
+		kill_wait "${tests_pid}"
 		kill_tests_wait
 	fi
 
-- 
2.53.0


