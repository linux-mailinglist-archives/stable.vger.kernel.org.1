Return-Path: <stable+bounces-196551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F044C7B406
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 19:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B30D4F0A41
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 18:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167642E6CD2;
	Fri, 21 Nov 2025 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOIKIXMg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4F92DF6F8
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 18:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748637; cv=none; b=XC5xODs5OTGaXoHHvyRpWcTbrKTiIixjd5MdjEwzC0vVeQLoM7UdEdGvkS87RK6HWyNQ2ZbDtJZA1oall2bZ05h19716liu76EzLkC8MiIbCKTrqeIGWGFyN7Di8BTqIBJ2h34ppayVJrLKDITHcBmQgz9cl3Gtw3ojF/aej2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748637; c=relaxed/simple;
	bh=QIFDOVZuZhL7aInL+RFFF8j9IlafO9HdTk+A+ru+5/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXLjgmSxXh2u7gh3uLQjJQPKkM5AL4u/qRUyEIt4FDnwqrtvsSZnmDp3iLPgn+pDwYWymLOp1i3IiLBL2bz9LKGVJ5T2wHShjax65GYLQK4PMqgSRLIFY23GBoHKzIZr/Rpjv9/CREkMEIekWWSDW3fWdJaF9BkK6LAQMQqLwPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOIKIXMg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3E7C4CEF1;
	Fri, 21 Nov 2025 18:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748637;
	bh=QIFDOVZuZhL7aInL+RFFF8j9IlafO9HdTk+A+ru+5/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pOIKIXMg+C7+Lpwkgztncc/3hELONQQm9Sou8pCSD/96WpLMbisnlmHqCNNPvud2w
	 G72b4gPLrTYj2fczO/Smf8Ag+OTWwPPAw+ENmq1BI+q+slU+XZ94VdO7uhH3k8frh3
	 7RSpQ1D2bnTFsVTN00LRADm4Y8GxE+jTzX/cxpbd8pzN8ks3uIM+fv9z6k+3UC5k6B
	 Oxza+hmxL2T+D898iVn8VargzIos8aTbM3bWVLajBLjw0SuAjg3K5AiDQ6gnY3DKhk
	 pWWv2VBAc3om0ClgjSO2ZDCuI60VwJ7N6QxUROy/UBb4iRniOSnT83++ywlGOKAakK
	 LHAhc/pBTadDQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] selftests: mptcp: connect: fix fallback note due to OoO
Date: Fri, 21 Nov 2025 13:10:34 -0500
Message-ID: <20251121181034.2640730-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112058-distinct-glisten-21aa@gregkh>
References: <2025112058-distinct-glisten-21aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

[ Upstream commit 63c643aa7b7287fdbb0167063785f89ece3f000f ]

The "fallback due to TCP OoO" was never printed because the stat_ooo_now
variable was checked twice: once in the parent if-statement, and one in
the child one. The second condition was then always true then, and the
'else' branch was never taken.

The idea is that when there are more ACK + MP_CAPABLE than expected, the
test either fails if there was no out of order packets, or a notice is
printed.

Fixes: 69ca3d29a755 ("mptcp: update selftest for fallback due to OoO")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251110-net-mptcp-sft-join-unstable-v1-1-a4332c714e10@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Different operators used ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 5a1277d172865..1853285d78e67 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -535,7 +535,7 @@ do_transfer()
 			"${stat_synrx_now_l}" "${expect_synrx}" 1>&2
 		retc=1
 	fi
-	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} -a ${stat_ooo_now} -eq 0 ]; then
+	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ]; then
 		if [ ${stat_ooo_now} -eq 0 ]; then
 			printf "[ FAIL ] lower MPC ACK rx (%d) than expected (%d)\n" \
 				"${stat_ackrx_now_l}" "${expect_ackrx}" 1>&2
-- 
2.51.0


