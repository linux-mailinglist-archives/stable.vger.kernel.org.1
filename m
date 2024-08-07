Return-Path: <stable+bounces-65952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FD694B025
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 20:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FB92844DE
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 18:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B275D1419B5;
	Wed,  7 Aug 2024 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqOyzUKV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6758B85654;
	Wed,  7 Aug 2024 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057091; cv=none; b=kv9TaQ2tsM2OGOODYksALNxOPRpABpp7mnFiByd2pu9UbGlV3QHoncySGMG2N7Z75859DXr+w2tNkfPI7XSfQsetUtED4ArGVCZatz1U13ZKrRpnvepPzqOMPtPdBE2Le4/Ay0rYupvRedn/+sIptmTu8B8ckIgy1naBXHpIcRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057091; c=relaxed/simple;
	bh=VA3AZvGKqMqT+1zQLWzRU672H6EzzX96alsUNuqBLoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwni4b7GnNNs07Qhxjzr4hvvpeoyNvT+9+Kz1+AGv1AIZJHpVlU6odPa/PyhjH1Ql1bzsiQDwdCVdLNs//oQLJIQt9sOjh3FIOF/bIHuqrzerg6Vaoj/BSzdQWkG/gx8tnE8pQVX+LH/xk/cLcfmFR0Ul/Zq7jiOvt4hPg5hu3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqOyzUKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE17C32781;
	Wed,  7 Aug 2024 18:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723057090;
	bh=VA3AZvGKqMqT+1zQLWzRU672H6EzzX96alsUNuqBLoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OqOyzUKVxLC2xvR8zEsbzxC4CpQ6XdcPWWUa9LZuw7peeWGbOANcpUXDjGDGa+vGs
	 iBEEKQ/rGWQ39M6ibPsST9ClgajdSQPA6S6fY6XtTPU/q2+zqbr+KM6DWb+OSAw8HP
	 kINW0CGKm0N1lxi3WrqfMkZMnIfRBxQLyDnvqHqhbQXvlX3pq+nCEM1f1ZWhzMpan7
	 s1/+nZV2th22qTTpacKzdHjQnLcvUw7K27CzlUtZbo3o3crcVjrDBiVL1Vak9plnZz
	 6AhlcZkz+B8TgFOFti7o5/LlwlI3FlYgOm3dQJyHOzKklfAtqJIp/rWKhqfHm3K+48
	 9M7719TQMj4ZA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6.6.y] selftests: mptcp: fix error path
Date: Wed,  7 Aug 2024 20:58:05 +0200
Message-ID: <20240807185804.1872347-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024080739-imperial-modular-7da5@gregkh>
References: <2024080739-imperial-modular-7da5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1355; i=matttbe@kernel.org; h=from:subject; bh=5HzRJTMLSwzmtkFAZ/My1MpIkLRartnjFoWidv4z8gE=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBms8O8Lurx303ibHwaM7xxVpw+mTQDh8dpKCjjt mQqz4r7daqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrPDvAAKCRD2t4JPQmmg czrID/4+RtcCN/iVgjlDe6aEYQj1Coj66vQf24V8G1oVi3S9vAsg64jpQagPEa5orz2AGOPmtOp FJmh66gw75FdpXYv2aWBvhEGbVgYm1pLiwzSwoFk3TA1eVfjLTcUzi7OvF/I4kg6cV3xsGSB2dU uu7hc/+NPNAzhupf57u0yrg1KgeRA0Jfeyc5ZV36iWEyl/gmnjLhNWSNoflE1hQrczDUCNopq/q mGri9pVVtVJ17QNzGYDhDHNXwYsT+PaUe7CzIvyb5E+OjiKUY/wUJVejCyB+s2f7AYDTxjgmD4H Vn1tSskKzK+a2XtawMS8uQsM1gysx1VWG6iD6B2Jl4+JnttqMNAUdFBudiKBmH3OP8CPLNxrtRe w9yau5hxoNCmzP8GT++pCIY82xIuyuxYynzxb7iaZIG8eLLai6KyrqNmYc7LS8MhWakf20bK4qW vGSQ+xpA551B9QeiQ1cDTDPfZAZA3cJbulGZyu+j0g8lJWMr8LZsrjAb3xX1PupCpj/431gm9hn EqNqGGEjCnLL6oIKJPsVo888cStv8wpq3JGzM6q+X7K1Ge47GYerO0kAk8uukzRoTDKlGCIjiBH sK6hpg85pFLbk+/9qQ6a6XsGBTzrhAmCCg+bKGQmf/pUTS0lF4zZR6lLH2kFNWA4vecI3lx+UY4 DDhAQr1oKhG0Ggg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>

commit 4a2f48992ddf4b8c2fba846c6754089edae6db5a upstream.

pm_nl_check_endpoint() currently calls an not existing helper
to mark the test as failed. Fix the wrong call.

Fixes: 03668c65d153 ("selftests: mptcp: join: rework detailed report")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
[ Conflicts in mptcp_join.sh because the context has changed in commit
  571d79664a4a ("selftests: mptcp: join: update endpoint ops") which is
  not in this version. This commit is unrelated to this modification. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a2dae2a3a93e..d7973b1202d9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -812,7 +812,7 @@ pm_nl_check_endpoint()
 	done
 
 	if [ -z "$id" ]; then
-		test_fail "bad test - missing endpoint id"
+		fail_test "bad test - missing endpoint id"
 		return
 	fi
 
-- 
2.45.2


