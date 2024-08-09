Return-Path: <stable+bounces-66248-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C966794CEFA
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061371C2155D
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 10:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC000192B64;
	Fri,  9 Aug 2024 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkorLTHj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91EE192B60;
	Fri,  9 Aug 2024 10:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723200860; cv=none; b=B9c8J2cWMPXSYYnwInPeQKzMum+kvkMlRZ0HDX7fa8AZRPs22zUz5YPUb+vy933c5nAttVCg4ZQqszCOec1oQRnDTUW96yS2519nW2BqC/K68OhFVLUvn6lP7OZBzICSxsAeRTiphj8+hcvs5E69MyZmmuglGmpkRztZ1fWZ7zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723200860; c=relaxed/simple;
	bh=mIy8OCMJjbDJRr0Uw+t6ZyqmDG2lLt0/ipVE5kaw754=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDc2qSwMPA6hqbR+FSQyZxe7NHoqvUiHweAMA7vYTGsUHmgvHKcrq8WwmWRyIo0puPR9QcHrt3yb2VZFtkkZiiRLuUImuF4NKRLb101WtjGPvdS+kH1AImcw6SoaFjcr+DIoZEA4QM4GE0o4mds++6fHotvRICtk2rf3XqscCVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkorLTHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C07C32786;
	Fri,  9 Aug 2024 10:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723200860;
	bh=mIy8OCMJjbDJRr0Uw+t6ZyqmDG2lLt0/ipVE5kaw754=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tkorLTHjO7c+sqhqx0s9z00oQy7wQyiEyGJ/bDOakApJ+HfFTDFP5I90qJKRfq/+r
	 kTWy9deG4zzCq9uNDvXIab+9QYepSNXEmvJ4837kEWTqYisE7F8uuo6babedL0VV1Z
	 RIOqlo8EUlS6wd+bDmb8uB0BGA+b00zmk3a9NmMha5kFm9TMxjJGrvdbnlihZgZ2fr
	 YqUK3b05vu3y9M2SVAJY4vHzKACRh7BX5fPoMaUuHLHu/a326ciDsiI0fp3/KZkiPC
	 wM80SU7i95wOr94GK+wu0VUdjtNzLOjKe5YCy7du/ZqbjnvMk/dI8zrondzNGTeipg
	 IuCcKFfv6qQ7g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10.y] mptcp: sched: check both directions for backup
Date: Fri,  9 Aug 2024 12:54:13 +0200
Message-ID: <20240809105412.2901173-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024080759-deploy-send-dfa5@gregkh>
References: <2024080759-deploy-send-dfa5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2724; i=matttbe@kernel.org; h=from:subject; bh=mIy8OCMJjbDJRr0Uw+t6ZyqmDG2lLt0/ipVE5kaw754=; b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmtfVURlEGLCH2iaJNsSGUnudgJaQSQ8EOjz7KF tnNk/8l4PmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZrX1VAAKCRD2t4JPQmmg c/IFD/0SmhUFLS3ux3Fe4eyTmEZeMJZYLFocQ2rxwYiyzwALclXDXCYLDu0V9AjyIH6i3HcD0jt qB6EuyulsxhXVUB/oq1Bl9WpDAHjsW7qmufQ60vUasHaxx8ClLZsJUjKvcnJm5isMJlk6ATZzgg igqmtQSY6z7mlPyzEZMHS1mFVNPGPeTe/Ih45fecYsgS5IN0klcSxjthGRyDqlaXS+63t0xnOTy udicJXSrNHW2hL40+yV5uPHzOKCG39KnuARfXRpT2Zyhr8y1ZouzEF4Hhh/09LyrXyWIlwchedk DjzBxUrCAV8yEfdElIe5D4awLcBsM6N7sgek+ShysbViEAfdiNqZuIqxpuJTVmBEiOneSBEdnVy ZG1KKoJm7XMtIICmWsH+8fkNWMtX3539OvdhH33lPm0IDUrZWAa2XZFIvO2667MQSI8Oe3spPer Oy/kAv1yYj5CToIxa2pJxh8g/88DyIDISRXbuKVXAty3ajCusBwkKZJYkkWiVxQQgdoRZGQDLHn LnYE/08B3Eg1kwOfarbZQ/gioM4M86VqfdWzdKHTJbhqKoBJmj19JAeO717jasS41F1jhqVB+ea 6+LDYZ6Y0IJrKDOmwEpMx6aE8ET4Jin9/tV/qMON1EsBg7G1C+rRv5hsYQGo5pq98eibTZue56F 3mYpGfqyhBMhnqQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

commit b6a66e521a2032f7fcba2af5a9bcbaeaa19b7ca3 upstream.

The 'mptcp_subflow_context' structure has two items related to the
backup flags:

 - 'backup': the subflow has been marked as backup by the other peer

 - 'request_bkup': the backup flag has been set by the host

Before this patch, the scheduler was only looking at the 'backup' flag.
That can make sense in some cases, but it looks like that's not what we
wanted for the general use, because either the path-manager was setting
both of them when sending an MP_PRIO, or the receiver was duplicating
the 'backup' flag in the subflow request.

Note that the use of these two flags in the path-manager are going to be
fixed in the next commits, but this change here is needed not to modify
the behaviour.

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Conflicts in protocol.c, because the context has changed in commit
  3ce0852c86b9 ("mptcp: enforce HoL-blocking estimation") and in commit
  33d41c9cd74c ("mptcp: more accurate timeout"), which are not in this
  version. This commit is unrelated to this modification.
  Note that the tracepoint is not in this version, see commit
  e10a98920976 ("mptcp: add tracepoint in mptcp_subflow_get_send"). ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a36493bbf895..a343b3077458 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1124,11 +1124,13 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk,
 		send_info[i].ratio = -1;
 	}
 	mptcp_for_each_subflow(msk, subflow) {
+		bool backup = subflow->backup || subflow->request_bkup;
+
 		ssk =  mptcp_subflow_tcp_sock(subflow);
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
-		nr_active += !subflow->backup;
+		nr_active += !backup;
 		*sndbuf = max(tcp_sk(ssk)->snd_wnd, *sndbuf);
 		if (!sk_stream_memory_free(subflow->tcp_sock))
 			continue;
@@ -1139,9 +1141,9 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk,
 
 		ratio = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32,
 				pace);
-		if (ratio < send_info[subflow->backup].ratio) {
-			send_info[subflow->backup].ssk = ssk;
-			send_info[subflow->backup].ratio = ratio;
+		if (ratio < send_info[backup].ratio) {
+			send_info[backup].ssk = ssk;
+			send_info[backup].ratio = ratio;
 		}
 	}
 
-- 
2.45.2


