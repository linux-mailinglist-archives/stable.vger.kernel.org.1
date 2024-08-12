Return-Path: <stable+bounces-66734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AD194F134
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 17:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018901C220A9
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 15:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A4A184522;
	Mon, 12 Aug 2024 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnFoookQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BE917CA0B;
	Mon, 12 Aug 2024 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474968; cv=none; b=nM8XIToS/2KtBwP7rHgLr3QCOxRoXiyQpNRKP3myniN5YRimTrGr94EPYZIVucvCmCLfN1v1cz1F2C/ahubjPG73hNtnkXTdpuAVES+e1rgsbAHB6mdQQIx+DBugolp2eEUIxKVd9abgYfwGonWILS31Llk97mDcOhJIQYZY1PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474968; c=relaxed/simple;
	bh=ek0GvpFyQhMtfrRDWGQe+M5JkNQjyO//K/wFq0rCGyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJGjHR5FI7Uv98GcVnDmnhidBPOWV4A+j/aVEnitE4VbWgkuuOG2Q8Q98uodpokcszNrtZXp3chvuh2vPzFi6hpRT4gjItzIuOda35ArrPkhc+eu7FZJqIJvAVmluwtoJHidIlECRVSPw+TCDG1ZgE6Tw3CDAQGCNtmKmI6+RjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnFoookQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626C0C4AF11;
	Mon, 12 Aug 2024 15:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723474967;
	bh=ek0GvpFyQhMtfrRDWGQe+M5JkNQjyO//K/wFq0rCGyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NnFoookQTTVtQxkBWvsuSA404js9hHhV8kDsn2HghJqcbZWBtF94DHTcZ6gn0WcEJ
	 YDNkPrttazIh+UNLR6K39ecKpK7eGsJ/RmvlStyNivm3MxHpe++KU4/wTkTbXE5bLR
	 5WLWxeF+KDl9XAQxJMyyUdUZI9Pzo8NJeeR6AmYa88jvHrW6JOUWjMHh524JqCqkdr
	 egHNn9952rNYR6TfMnn8Gg2qhXrnLBDXeDl2tRzu3hbzZn6+OhI3r9qXUDwjdqkdEt
	 05++NQZkSkcGBufmr1Ib7Zja91sYj3mHr9VG5Yg95+IgeCVB8Asi/yUiVPIUCYmFsu
	 bKTUbo2GunCpg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.10.y 5/5] selftests: mptcp: join: test both signal & subflow
Date: Mon, 12 Aug 2024 17:02:19 +0200
Message-ID: <20240812150213.489098-12-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024081244-smock-nearest-c09a@gregkh>
References: <2024081244-smock-nearest-c09a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2733; i=matttbe@kernel.org; h=from:subject; bh=ek0GvpFyQhMtfrRDWGQe+M5JkNQjyO//K/wFq0rCGyI=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmuiP1Wc9DMJ0sM8XP8P+xL5GzdCymmKzXkHASE wWWBEXfkpOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZroj9QAKCRD2t4JPQmmg cyQrEADwhs7dQSbvAkeWa+B6d3nHOc6kiF8KXZzVXKNOxRKfPTLHouffphzIv6t5mNrUJaU4PsD FGy9AWJ+vkw4JIxsiCjXzYEbeWBed+A+sQp6prv3kowrzfSbQDyl190SvRksPF/S9uYeHfbaNX9 GTAPK7AyAJmZ7TBTRTE/Fga46TG1Ij+5ZyqJumXDJL1S8QuVhZKKFaBtAZDc7jOhVxR/afwKcoJ dWLiEcfD65LLj0Z1sPHKIhn6daAZB7yUlG4uTsdGPF/2ItrUketYW75/jpG+KoOVgvDvAtmXJAT y3AQ7FI4Dw+caCJyDqGUT50vEsS5cVgJaEGk4KiHiqF7c0J91rAsf5SOIVeMidOWrkXdeMlerJ+ lTqDXwPUX/39uZJ3UK7q3mV6MdYQkpvRKTZPTxegbVJO1JQTzjjfNmypTVuV1qZu/OqCj5iDIfm o6qCYthpmZJvZ65Js0JrfnaM08RGBqtHGDyTBfo8guJhLfmq8f1UmN7z2PcePg/yGjvXG0O1Ceb 0ptT34096w+trZi7UCh+fvNWWGOXHa6L5/j1lcFNRAFfC0pZGhbnId12XNzE3RrDibzN/n141z/ IETC7v7KZoBQrGNWFJkkZPRq7KaIEg+uqExVgRiGQHp1MPwihP4MVmkL74T+IhdjdZS0Aabdh6i 0XyRStvhthr/+2w==
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
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 8ab350059ce1..a3293043c85d 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1989,6 +1989,21 @@ signal_address_tests()
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
+		chk_add_nr 1 1 0 invert  # only initiated by ns2
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


