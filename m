Return-Path: <stable+bounces-36782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC96889C1A2
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4BA1C21552
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE097FBCE;
	Mon,  8 Apr 2024 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="siGoXXpZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1227D3F8;
	Mon,  8 Apr 2024 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582328; cv=none; b=eNiYD/GL5QQRT7yVMcKullOxO0fSnxxeiWuf1iFagvWbm4xbjeQ0xz+myAzYKNWqh4CVfPFcIcfcbPlJQNOVjMJfr0+IKGX8Lx4NdMvVIPGY03Lrx6TfwD0oyyBsR7v2Pn35YeBdhjaHq1FjYHAhN5DWKOcLzOMO2eR/U2yBs8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582328; c=relaxed/simple;
	bh=XwFTHgeW5oqiaQmyFpH26ODOAmlD+qQkq5HAjjnRbHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJpPYo1I1w9PYtZkB3pgBFMW2oNpnm0n+yke7j0/gQXJDQ/pgucL02z5Xb8s0N2rut+PgT3vrMMi3fzVkHhKo9bri9jCHmS947pB07s1zQ33sUvdSO50M9BLvw4y/yyFa+aYKXK1o7jQZO7+uYY2sWCMJW944Tt71/8TkqQLjy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=siGoXXpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CEAC433C7;
	Mon,  8 Apr 2024 13:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712582328;
	bh=XwFTHgeW5oqiaQmyFpH26ODOAmlD+qQkq5HAjjnRbHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=siGoXXpZJXAjo0JSpvsMocsjxxZLylSFIOFY8z17LG4Slz2xAJiVJf7bFvG6ylhZv
	 NM/e7QPxrCEYH5t5x4f2sOkQd5UQjepfSgIU/qPEsSYgjqlc3y3hmBka9MetbSXtAV
	 iRFwgvfjISwmqGvHx3jXc2bqt/ehTjaT3oYUljjA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geliang Tang <tanggeliang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 084/252] selftests: mptcp: join: fix dev in check_endpoint
Date: Mon,  8 Apr 2024 14:56:23 +0200
Message-ID: <20240408125309.252660543@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125306.643546457@linuxfoundation.org>
References: <20240408125306.643546457@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geliang Tang <tanggeliang@kylinos.cn>

commit 40061817d95bce6dd5634a61a65cd5922e6ccc92 upstream.

There's a bug in pm_nl_check_endpoint(), 'dev' didn't be parsed correctly.
If calling it in the 2nd test of endpoint_tests() too, it fails with an
error like this:

 creation  [FAIL] expected '10.0.2.2 id 2 subflow dev dev' \
                     found '10.0.2.2 id 2 subflow dev ns2eth2'

The reason is '$2' should be set to 'dev', not '$1'. This patch fixes it.

Fixes: 69c6ce7b6eca ("selftests: mptcp: add implicit endpoint test case")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://lore.kernel.org/r/20240329-upstream-net-20240329-fallback-mib-v1-2-324a8981da48@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -796,7 +796,7 @@ pm_nl_check_endpoint()
 			[ -n "$_flags" ]; flags="flags $_flags"
 			shift
 		elif [ $1 = "dev" ]; then
-			[ -n "$2" ]; dev="dev $1"
+			[ -n "$2" ]; dev="dev $2"
 			shift
 		elif [ $1 = "id" ]; then
 			_id=$2
@@ -3507,6 +3507,8 @@ endpoint_tests()
 		local tests_pid=$!
 
 		wait_mpj $ns2
+		pm_nl_check_endpoint "creation" \
+			$ns2 10.0.2.2 id 2 flags subflow dev ns2eth2
 		chk_subflow_nr "before delete" 2
 		chk_mptcp_info subflows 1 subflows 1
 



