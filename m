Return-Path: <stable+bounces-121082-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E80A509C6
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4D43A4D68
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C1F257AC2;
	Wed,  5 Mar 2025 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AWfY875+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB4C23027C;
	Wed,  5 Mar 2025 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198830; cv=none; b=C8mdAYqh03Uo8QTbn1LnKhxIyz0bVW2H0MTNn4AlZW9wbS530YDiOBoDhXa6XWGZubyTEQV6Ag78YfZDQwTwRGTWnC1+qQf0qHVbNPhV9YEnlR8gTJxzYptU/mqo+RDDj5EQ+pUjjcjPWZ2wF4NAK1/Huz4+acG7xGGV73pqbMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198830; c=relaxed/simple;
	bh=F4WiTLNkXwM+FMcBauhxZ1Rh8PVxuzbdTYsvp4NsAjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRNTflaadjHjM+ieWM4f6db4WR1kmFP/COLhMJC4qM5A8CrUkXKuvpCn4pTpfQ7QeM7o7ZKKrj3onpaqR/SFHRXqa5MjCrEsyn6tNZ6wkr6p/cfxeMBnhL3dCtEii1NIuQQESLcoW7MooTCUDMnz9bxcyOzgRo3mCrc5myiS7DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AWfY875+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE505C4CED1;
	Wed,  5 Mar 2025 18:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741198830;
	bh=F4WiTLNkXwM+FMcBauhxZ1Rh8PVxuzbdTYsvp4NsAjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AWfY875+HM2qAVvGEP4DQfYLnJ0n/AUROeS7q73q0BBYknSAsMHkmx0Q7sHPXp5JQ
	 VcsM0/P9RZg35naYuNyNNjdFX5iD8itC/2qSa1nrT0TjuA/x+9PwiBdkZrAFRZ4IuQ
	 O9CYvGEgH3HTYEL4K0+tB/KZbt7+gnUhI5ubrFNg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Chester A. Unal" <chester.a.unal@xpedite-tech.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.13 130/157] mptcp: reset when MPTCP opts are dropped after join
Date: Wed,  5 Mar 2025 18:49:26 +0100
Message-ID: <20250305174510.529152884@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.268725418@linuxfoundation.org>
References: <20250305174505.268725418@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthieu Baerts (NGI0) <matttbe@kernel.org>

commit 8668860b0ad32a13fcd6c94a0995b7aa7638c9ef upstream.

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
Tested-by: Chester A. Unal <chester.a.unal@xpedite-tech.com>
Link: https://patch.msgid.link/20250224-net-mptcp-misc-fixes-v1-2-f550f636b435@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/subflow.c |   15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1142,7 +1142,6 @@ static enum mapping_status get_mapping_s
 	if (data_len == 0) {
 		pr_debug("infinite mapping received\n");
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
-		subflow->map_data_len = 0;
 		return MAPPING_INVALID;
 	}
 
@@ -1286,18 +1285,6 @@ static void subflow_sched_work_if_closed
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
@@ -1393,7 +1380,7 @@ fallback:
 			return true;
 		}
 
-		if (!subflow_can_fallback(subflow) && subflow->map_data_len) {
+		if (!READ_ONCE(msk->allow_infinite_fallback)) {
 			/* fatal protocol error, close the socket.
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */



