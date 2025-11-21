Return-Path: <stable+bounces-196548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B0642C7B397
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 19:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4E0A4F000E
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 18:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5205B2E6CD2;
	Fri, 21 Nov 2025 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmZtx7qF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FD626F2A1
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 18:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748279; cv=none; b=KvFFlxZXzhYu6b1/n0i4NZ4lOt6SA9U3pDZCd7/c59d+dm2h0OSCkZ8twzopXKKV6C8Nj+teDx1QS5sBajZd9ZeHoy2PxkxmTGGrts8pnzMK2NLPMQfkr4TwmJ6J1vcR3VngRYo9JgpaOB4C4tMjZisyIDQnK8vKz3m2tn9vrJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748279; c=relaxed/simple;
	bh=R74su8ySQdausE3Rfv64FndH2cOLmbfDURtu0TW0ZVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQUC0lSS08Yo9vUQ6VZPH/9yM6oMaS3zWwMcFlaKLhesUo7BTp5Hf69UEvwBGqEZw6BSDcuIx3xQnXh1vYniPON+KT1yR0umscflUqlmpz/SZr6W943ht/t3imoLEFm5hvtWpinEHTbbE3zHtZoUF3bLvj+dh0Ot1lYiRKc4dSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmZtx7qF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46418C4CEF1;
	Fri, 21 Nov 2025 18:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748278;
	bh=R74su8ySQdausE3Rfv64FndH2cOLmbfDURtu0TW0ZVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NmZtx7qFL4GvyVdN3yFxkVsuO8XXaOgpFjygo6T8x8vaO0ZGZEKAEd6XjODCsRmID
	 KRVBM+tZfWAj1m3T0PCsU4oR+kkKi3lQmg/hshAX+4JBrHnxo+jkQFGgaiHuKptuGA
	 B9i6D/wqTXKT9GCXyEpysefyeuGlQmjb9xQneUqOr1MC4NynXw2shDb8l3im8QS4VV
	 6hHQjMzTnn4+RuOd6lF2c3WW3G5BY5xHjzmv5OF36QLhHWj7I29YSQD1vNoGk+WGtL
	 OzNCjjswQXzZ9EaL3s8hykRx3wwbAgVOIzlHqm6MNY1C/bWDs3R7Zgzy1696MENXoL
	 dQADOjzG4lBiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] selftests: mptcp: connect: fix fallback note due to OoO
Date: Fri, 21 Nov 2025 13:04:36 -0500
Message-ID: <20251121180436.2635827-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112057-untapped-profile-9004@gregkh>
References: <2025112057-untapped-profile-9004@gregkh>
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
index dacf4cf2246da..d43eb907d244e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -523,7 +523,7 @@ do_transfer()
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


