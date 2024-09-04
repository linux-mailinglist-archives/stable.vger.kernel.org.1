Return-Path: <stable+bounces-73007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5433896B998
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 13:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10331F26EF1
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 11:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4561CC887;
	Wed,  4 Sep 2024 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQdXoY8d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B10126C01;
	Wed,  4 Sep 2024 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447884; cv=none; b=HloBK1nVdM0tcvz2ocBzuRuIErEZptttq4W7mTSoLL1JOHaufmAVV+WlCOZJdW72yfeZ+1UJqp7bLrgP6LfLVtGZ9LwjHpioK10ZslIKS0g2d1fWCbREXOnyq4+dhxviOEwjybbzb1dpwQZNXTayTOPt6cr5lmdY3hrssQc9Ehk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447884; c=relaxed/simple;
	bh=B1DJkpXywV4KEEhNiYSrPQ8gaBz1TQS6IEnopSq37jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgSdmvuIDtm6TMe3N6jBVYV80h4Ew9h5/gwSTg5rpKI9JeiVsLqw3s42pfvjGoqOfk+gR34/lu/JXN2oX/za7PKL2qVzNI9CWbWVY/QKZ0GMepoId1fu05G10QOzpBIiAln9LgNMKIgWysviKIl5UMeuIRlV6gAA0OiZ+77pMp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQdXoY8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37256C4CEC2;
	Wed,  4 Sep 2024 11:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725447883;
	bh=B1DJkpXywV4KEEhNiYSrPQ8gaBz1TQS6IEnopSq37jE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bQdXoY8dHIDM0xEPmfAz7GPcUblnKfm3Bk4SHcuu83VdIPP1LZHXDlWCeNDvbn5J0
	 I8P3nhVBvSqAFtCBa03NNXaqYLlXsuFq7QsC+CfyYkb9Tj8nFZr2UYdyA2CFuwEGAF
	 StMKgNW/XvMhWSpucQz533RxvNxFMm0A+T+7iwhDY6rIrGKl8bkoNF18R7BwR3xVXE
	 lDQAzjxSJ7j/Gnn/vuDrriv7tZinCszvnFlhN2nnIUkjkuW3zCc9DKWiAwxz1msRT3
	 wn2bwWHGJUJZAmejobf4QV6QC7c2gN8wXr4E0Cu1Rx0QUuetQb+a1AvoF3QQxg3bPB
	 t6m04ieaELSaA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y] selftests: mptcp: join: validate fullmesh endp on 1st sf
Date: Wed,  4 Sep 2024 13:04:31 +0200
Message-ID: <20240904110430.4084188-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024082645-hurled-surprise-0a7c@gregkh>
References: <2024082645-hurled-surprise-0a7c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825; i=matttbe@kernel.org; h=from:subject; bh=B1DJkpXywV4KEEhNiYSrPQ8gaBz1TQS6IEnopSq37jE=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2D6+CNaWz2cENENfHZ1vuPLjKlQlHCROlB0+1 Q0PSqJ9vRyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtg+vgAKCRD2t4JPQmmg c09FEAC+ZuZMLP/2OjK5dn5pXpmkg3PKcynBvjzDWfIqmBa1rUYUSvcoOIPyfDkRij3ruN6B3uI XkdjH+x3H+Ruuiuf2cSdbIwXP0OlISSM5RT1KeO3Ym8t4GiDW5705NhvoHQf1rkWT+VJFf173Ok C5YT5AuQHSuv1Qunz/cKdJo7hg1MEdzfWanLjunXjD5doMze0b4NJ+lZVY9UuvPqpRuWfsvdpWU Pees1HLtbT6BG8Av/i59P/7UGKIlLPbKb1xo3TUaJ6E/cSxvE7zfEklkY3+yprBPPwpNJGC4aqM UlbhosI+a13mwxou3+aMspDFOuAb5aguN/Ze3mlUi5iL1L+MEwyGSww2cxeIotFQTEuHjB7FSIz vJxn8RwFsDdwc8zqV23q+r9pHtyrW+g2iTtNWhmacG4xDz6X2srOLPnwkIdN44Ce3iBotpB8Jep BT2rbjvWzXUsghR0mk1ZNXqEtuT7fbz+sslGqejr6H/iqpAedTXGcIpxkSo/U8pU1BCDC4vdIh6 8tpPvyld9GslPE9T2CbFzxET00CfJThNSn+TnKeKYAtSl5og9BV/+CM3L9soVm4kUyW53XYtplt zu4c0vRPv2S9sFS/AeNErWtqNVxqpG9vOFVqXLv0kFhc5FvEFz5Ol+u/AmHurJEG0mTxDBCtYXy rQNHg6VOW3XORMw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 4878f9f8421f4587bee7b232c1c8a9d3a7d4d782 upstream.

This case was not covered, and the wrong ID was set before the previous
commit.

The rest is not modified, it is just that it will increase the code
coverage.

The right address ID can be verified by looking at the packet traces. We
could automate that using Netfilter with some cBPF code for example, but
that's always a bit cryptic. Packetdrill seems better fitted for that.

Fixes: 4f49d63352da ("selftests: mptcp: add fullmesh testcases")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240819-net-mptcp-pm-reusing-id-v1-13-38035d40de5b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflicts in mptcp_join.sh, because the 'run_tests' helper has been
  modified in multiple commits that are not in this version, e.g. commit
  e571fb09c893 ("selftests: mptcp: add speed env var"). The conflict was
  in the context, the new line can still be added at the same place. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a73358d753aa..3d6d92d448c6 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3023,6 +3023,7 @@ fullmesh_tests()
 		pm_nl_set_limits $ns1 1 3
 		pm_nl_set_limits $ns2 1 3
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,fullmesh
 		run_tests $ns1 $ns2 10.0.1.1 0 0 fullmesh_1 slow
 		chk_join_nr 3 3 3
 		chk_add_nr 1 1
-- 
2.45.2


