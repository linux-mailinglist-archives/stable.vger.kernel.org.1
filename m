Return-Path: <stable+bounces-67442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F736950138
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 11:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2CC31C219E2
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 09:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5EC17F4F2;
	Tue, 13 Aug 2024 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kbhDJ3My"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4993517D8A6;
	Tue, 13 Aug 2024 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723541318; cv=none; b=EP8IEMPBV3yp+kEpq+uCuQPRFzOdyDXMflYREnFY3kSQ7K8TPsdG7T6uhMWT0xa/Q76dI+PBjx3zyvNVTkfEnUJGWavHWuLzg0GO1xaDi4P2IWR1sKhkWCi+pxTVXK55n/Yc9gvDsbVQCEfJT4i0NkLSj08RACp2ORc0OZ3mzoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723541318; c=relaxed/simple;
	bh=2ZotMhiT2PSPQoLLzix4mEWXnewBcxBziYA55KpBuws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVR4jcxuMCwFiRKh/WyH6pUbCO15J6ltTTgkRYkTi3D4GDKUpAfDwOepj87blczgPD95tl92nxfXwttDYXjDlHq69pqSBd9AST2xY1JuATevBdAX3YT4Z1WcfiuRH1qL0pX5HQ47e9EP6HerGvQtboXLNXX51NgFsL46e2qPdw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kbhDJ3My; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D26FC4AF0B;
	Tue, 13 Aug 2024 09:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723541317;
	bh=2ZotMhiT2PSPQoLLzix4mEWXnewBcxBziYA55KpBuws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kbhDJ3Myde7Qsb6DLgwzheArzXBNJrq6NkDkPCXHtbJsTmmst2Tdcz07hjx8dg2ne
	 ODrzBuqzcopmun8EafJ5Q7aXJe/TJjaQLOyZp59L4t66osS3DEXl49lB/OfkVjY0Js
	 UkmeUTd53Wj6EMFSSR0esJ1ShaTmljk2cDkaDSFLT3A/dJ++m2NPN4CYdds0nL0Jon
	 9UFWDNjBbptFmOh0tpkDdNVy/MVW7riykBVIwNRdF4YBiQggw4rfS5j9svjB476Sj0
	 dTRAY4F5VuZd2VhCmpZLA/vMgI71CcMT3ys5SIxLHqQT5gKN6iWbp0QjgR2dw/fcM1
	 QDnw/l5DJYLIA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1.y 5/5] selftests: mptcp: join: test both signal & subflow
Date: Tue, 13 Aug 2024 11:28:21 +0200
Message-ID: <20240813092815.966749-12-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024081245-deem-refinance-8605@gregkh>
References: <2024081245-deem-refinance-8605@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3031; i=matttbe@kernel.org; h=from:subject; bh=2ZotMhiT2PSPQoLLzix4mEWXnewBcxBziYA55KpBuws=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmuycv1tnW+L5VJVw5K9gZiWIuKSHM/t/btT+d6 jAvMnHm5oeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrsnLwAKCRD2t4JPQmmg c/mSEADwL0+Z0a2LQc8B05rjbFR8XS0R24vbeZWuOP1zOC7rcB4E2IzpY+3QH0+rwcn/SYG+zeK e2qb/98QmhJboec0UQJKfKpQJxIVXhNnzI8Ici5IZmGDb1h8C5wuJCawqGvZizdHZQ8yQ+U83Su AjezZNcc/Scy4FxpobJ6TgDf/WGT0e5IfQ3C+Po0U1yny4Z2vEmqGeLrBrEL7AMGi5fMKc5xnFz ESjXfZh7xJxMmIRDpCLmZk9B7Xh2n7xvVI/DwU5bN6pJKqOx5qGQRYbN7z2VpqU2jc+uR2PR6ph FU9j4yGGxtEwFsuVZ1O+BIx9gNBoEslrsRYzEVUKaovSucZ/hOBQceHX5javGnbmqlb/6ewed0q VaaamY02iUopRQ6wQoCkV8d709tAN1vkdKGgXX/cuxJtFMjWIqMexLVw2AQhfXFFwcBwJpEdMH0 3YBGgtE1KT5CaO8oaR+5gQHlsroyQaHPTRjeDehfsbR7ms76bQ1Bxb+B0DFL8qt888mWbx5bFsH Rw5Csc7zhaCVYV0cxISo/qpQIAChnsbPS3qUDCQ8gwbATGb6p/8zp1/x5cwGFavXVE7ZV4xei0j WaFOjh+kSzXl2CVHY5ImTP+kgcCFUG6ajfqBB5eSLde/QJGXtf9bAtWaXyisW54PdbaVJxJwgnQ SetkkJPb01Mp+tg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit 4d2868b5d191c74262f7407972d68d1bf3245d6a upstream.

It should be quite uncommon to set both the subflow and the signal
flags: the initiator of the connection is typically the one creating new
subflows, not the other peer, then no need to announce additional local
addresses, and use it to create subflows.

But some people might be confused about the flags, and set both "just to
be sure at least the right one is set". To verify the previous fix, and
avoid future regressions, this specific case is now validated: the
client announces a new address, and initiates a new subflow from the
same address.

While working on this, another bug has been noticed, where the client
reset the new subflow because an ADD_ADDR echo got received as the 3rd
ACK: this new test also explicitly checks that no RST have been sent by
the client and server.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 86e39e04482b ("mptcp: keep track of local endpoint still available for each msk")
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-7-c8a9b036493b@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ No conflicts, but not using 'chk_add_nr 1 1 0 invert': in this
  version, 'chk_add_nr' cannot be used with 'invert': d73bb9d3957b
  ("selftests: mptcp: join: ability to invert ADD_ADDR check") is not in
  this version, and backporting it causes a lot of conflicts. That's
  fine, checking that there is an additional subflow should be enough. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index a28310764654..a73358d753aa 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2090,6 +2090,20 @@ signal_address_tests()
 		chk_add_nr 1 1
 	fi
 
+	# uncommon: subflow and signal flags on the same endpoint
+	# or because the user wrongly picked both, but still expects the client
+	# to create additional subflows
+	if reset "subflow and signal together"; then
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 0 2
+		pm_nl_add_endpoint $ns2 10.0.3.2 flags signal,subflow
+		run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 1 1 1
+		chk_add_nr 0 0 0         # none initiated by ns1
+		chk_rst_nr 0 0 invert    # no RST sent by the client
+		chk_rst_nr 0 0           # no RST sent by the server
+	fi
+
 	# accept and use add_addr with additional subflows
 	if reset "multiple subflows and signal"; then
 		pm_nl_set_limits $ns1 0 3
-- 
2.45.2


