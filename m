Return-Path: <stable+bounces-196849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F639C83486
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 04:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3813AE402
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 03:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEA727D77D;
	Tue, 25 Nov 2025 03:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVZi2JWw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877BA13AD26
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 03:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764043125; cv=none; b=PnRGxHzg4l5bs4uJOwosWeJwTOdCwMwEAKIaWX7uc91kE8ZSkGorToiJMwAnferVlWbGEFLtbEoY7BdnN2TVbGYqw6bM1KVvJoqDJHTAvPzhnYasBFWTaNlqObvNjjZ4sZTfTU0TP6/Qp9ZJYwhWs3Xxxg90eJZa8ASW0Q1FibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764043125; c=relaxed/simple;
	bh=oM+wCminf2YqbTUZQ5/zuO0DQYqX8A5uQiRWdsCCHyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tw6wBww0UudKALgM3dl7+d7wCzg44gvU2k3U040bKxxG75gAesIA16UbxSyIPawbgSzeOfbKBRsZ4oAEEjPe1FtMOMEumUHNCqXGbAEUlpU//n1x0V7CmHN2dM6Zy/TBUNUhz10kc0VdgmcPUxH/Xans7soVjRebO1Wvp5weRrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVZi2JWw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A43BC4CEF1;
	Tue, 25 Nov 2025 03:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764043125;
	bh=oM+wCminf2YqbTUZQ5/zuO0DQYqX8A5uQiRWdsCCHyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PVZi2JWwOnFy+l1BZbmskwHMbG9yrDzpHlswC0zisiNMTe9l16fnZIxzMavBzUXHS
	 VIhyhoX5SDezM4Wp+7i4IATkpRn9PZl09EkFZI1bBIdRrKOwF6vc8h7pdT77iksXA5
	 SFnzdogBxIvyDUk0ggCxpJxy5hNPi1SNHPTAi+EB+sQzbFBy+zrzpmCvP7aoAMc0zC
	 zwlBO46O8dIn3Gm+YCan2wnUAUthXdZyTLDzSgsJgYL1yDjzsh4OhQS1rlSXX2tv72
	 jaAEsuQnY7aZDVgi4IdXMANh4cIgRajowO2Hf5UfEtpv4Oquq1zOFzRUH45veUkj54
	 VpqkTGNChq4Bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gang Yan <yangang@kylinos.cn>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y] mptcp: fix address removal logic in mptcp_pm_nl_rm_addr
Date: Mon, 24 Nov 2025 22:58:42 -0500
Message-ID: <20251125035842.386893-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112435-stray-aflutter-0f77@gregkh>
References: <2025112435-stray-aflutter-0f77@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

[ Upstream commit 92e239e36d600002559074994a545fcfac9afd2d ]

Fix inverted WARN_ON_ONCE condition that prevented normal address
removal counter updates. The current code only executes decrement
logic when the counter is already 0 (abnormal state), while
normal removals (counter > 0) are ignored.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
Fixes: 636113918508 ("mptcp: pm: remove '_nl' from mptcp_pm_nl_rm_addr_received")
Cc: stable@vger.kernel.org
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251118-net-mptcp-misc-fixes-6-18-rc6-v1-10-806d3781c95f@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/pm_kernel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index 07f50d0304cfa..f72892b7abc3a 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -548,7 +548,7 @@ static void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk)
 
 void mptcp_pm_nl_rm_addr(struct mptcp_sock *msk, u8 rm_id)
 {
-	if (rm_id && WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
+	if (rm_id && !WARN_ON_ONCE(msk->pm.add_addr_accepted == 0)) {
 		/* Note: if the subflow has been closed before, this
 		 * add_addr_accepted counter will not be decremented.
 		 */
-- 
2.51.0


