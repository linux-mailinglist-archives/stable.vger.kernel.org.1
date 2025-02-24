Return-Path: <stable+bounces-119406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7337FA42B0B
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 19:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4689016F01E
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 18:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA17266593;
	Mon, 24 Feb 2025 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCnUeAAp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCD5265637;
	Mon, 24 Feb 2025 18:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740421178; cv=none; b=ZWWgYI+dSFt8DCcLslzzREfojLw244TocEBXFAr/MFe3FXz8NVUKLAN9TSb10RJhy8KD3404PHJExj1jv8CZVypdQj36sxFbgM2qw/kZCaMvNx20FSC/NduyBaUdUaBeGj2fDsh7PWMkN0j5E9tgqxcCRUhIo1/rqLmkxSCFQLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740421178; c=relaxed/simple;
	bh=1piqEsg8TREgMWofEyn4jJ96CEYOxAF1p1P8q05XkLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fRdkB+411vf7xuD9WduqOfLvLV5jityj5XC4/jeKwD9w/8jBsKzIw4cPszrVmjrItC+pS5vqj33u9Aov2MsSr+OIWVbNlom/6wgu7cRnjJfd7aTrkdLn0gVhfv2yaUNmYJ07sNBU2hLkV38l+DHhZ6MzCSSeZYoHGUa3EP1f4uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCnUeAAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963A0C4CED6;
	Mon, 24 Feb 2025 18:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740421178;
	bh=1piqEsg8TREgMWofEyn4jJ96CEYOxAF1p1P8q05XkLs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KCnUeAApLkkGko6SP7l7F15fOSW6KYftikbjynwWHDzhpGaS1C5dm+hphcTuhgcvD
	 6JjpO3g140z/Wflx4pTah+ylqAgeWOm0s99TJW9Cehz+NTcr7MwfHVaeHKae4rm2j+
	 enwWzEbTGM4hX7PmiPS0r4+cpkbHgtAvo2OXd5b43Q0kQa6IM+pxJMCIPOHoYhYaze
	 yEko/7XeLOjW1E4YTp6mEuE7w12Ny2Ll3h0zQh6hMk8fRSaPDXfQa4VNX1l5/1WWQ8
	 kTQtV3BKBLCAhsDpMRSw0e+uiRNp3Jifj8JHmnk8tA1rgLvt6FjJHsjJ3UnWzEByu9
	 mNf8tTFH8L+dQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 24 Feb 2025 19:11:51 +0100
Subject: [PATCH net 2/3] mptcp: reset when MPTCP opts are dropped after
 join
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-net-mptcp-misc-fixes-v1-2-f550f636b435@kernel.org>
References: <20250224-net-mptcp-misc-fixes-v1-0-f550f636b435@kernel.org>
In-Reply-To: <20250224-net-mptcp-misc-fixes-v1-0-f550f636b435@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 "Chester A. Unal" <chester.a.unal@xpedite-tech.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3536; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=1piqEsg8TREgMWofEyn4jJ96CEYOxAF1p1P8q05XkLs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnvLbEVe5ugfNB/pEH8gsCo37OFpAAyoQsRPom1
 VoDnLcRVI2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ7y2xAAKCRD2t4JPQmmg
 c0VrD/4wezF7LMq2B3x0qP48+OYaeX4LE+vQFlL2AyJudtuOv21VQynOTxViGWTiwukpGqKFe/r
 mVsYWPgDK3mSqKvQWZ+S3IirU+Hx6iY0K7D2FEu2hs6KEe6Qc6GYpRxKehY7ga2zfpElSOopwwu
 35Mt9GPcac0d0w/9WGZo0nyqee2YC4XQvtSdloya4SnSXwKW9X2A5Gp6FtLRHDGEjxRP8rYyHAr
 Naf7zHvZ/+rN3LSPggCmdNRI2xQe+MGaAIoiqBl5h8NiBcBkUD+/M1bDXg+JtSNxt2cexhAXqk2
 WvEMZ/tDuJuuQ2CTvJlFo9dk7dTBa6gqzEqpOgHZuFHQffVo9pMSLxoZBhRey96MjY6kz0YwqYx
 dud3EOMSLgegP6dMkdWu5ewGqN3pMd2wm8q70MCP31gsJc7JdriABPJDLGz0/NbTq/hsMIao/YN
 hMFJcLrDb1Oql8FbjW+LNVkPqzEB6h8XaHBg3AzsvMuXczStGG3oKeDTUap0Al+uP9C3Rq1ibOz
 9GPsdqk5H8CSZ0qUSLn5PRLbqLQ4c4HQLKLUZj+WtqHEx7HWat57mmqs/xyj37KxjS/sBtd6pWz
 it4xY8KhZeLGnDjOKCv38cjf6VflrtLucU6e+lNl4GGodzwa0N0SHLg6p1KiaLOO0lwtu6PfgAQ
 PmbczMT7fJqDjuQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before this patch, if the checksum was not used, the subflow was only
reset if map_data_len was != 0. If there were no MPTCP options or an
invalid mapping, map_data_len was not set to the data len, and then the
subflow was not reset as it should have been, leaving the MPTCP
connection in a wrong fallback mode.

This map_data_len condition has been introduced to handle the reception
of the infinite mapping. Instead, a new dedicated mapping error could
have been returned and treated as a special case. However, the commit
31bf11de146c ("mptcp: introduce MAPPING_BAD_CSUM") has been introduced
by Paolo Abeni soon after, and backported later on to stable. It better
handle the csum case, and it means the exception for valid_csum_seen in
subflow_can_fallback(), plus this one for the infinite mapping in
subflow_check_data_avail(), are no longer needed.

In other words, the code can be simplified there: a fallback should only
be done if msk->allow_infinite_fallback is set. This boolean is set to
false once MPTCP-specific operations acting on the whole MPTCP
connection vs the initial path have been done, e.g. a second path has
been created, or an MPTCP re-injection -- yes, possible even with a
single subflow. The subflow_can_fallback() helper can then be dropped,
and replaced by this single condition.

This also makes the code clearer: a fallback should only be done if it
is possible to do so.

While at it, no need to set map_data_len to 0 in get_mapping_status()
for the infinite mapping case: it will be set to skb->len just after, at
the end of subflow_check_data_avail(), and not read in between.

Fixes: f8d4bcacff3b ("mptcp: infinite mapping receiving")
Cc: stable@vger.kernel.org
Reported-by: Chester A. Unal <chester.a.unal@xpedite-tech.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/544
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/subflow.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index dfcbef9c46246983d21c827d9551d4eb2c95430e..9f18217dddc865bc467a2c5c34aa4bf23bf3ac75 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1142,7 +1142,6 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 	if (data_len == 0) {
 		pr_debug("infinite mapping received\n");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
-		subflow->map_data_len = 0;
 		return MAPPING_INVALID;
 	}
 
@@ -1286,18 +1285,6 @@ static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ss
 		mptcp_schedule_work(sk);
 }
 
-static bool subflow_can_fallback(struct mptcp_subflow_context *subflow)
-{
-	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
-
-	if (subflow->mp_join)
-		return false;
-	else if (READ_ONCE(msk->csum_enabled))
-		return !subflow->valid_csum_seen;
-	else
-		return READ_ONCE(msk->allow_infinite_fallback);
-}
-
 static void mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
@@ -1393,7 +1380,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			return true;
 		}
 
-		if (!subflow_can_fallback(subflow) && subflow->map_data_len) {
+		if (!READ_ONCE(msk->allow_infinite_fallback)) {
 			/* fatal protocol error, close the socket.
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */

-- 
2.47.1


