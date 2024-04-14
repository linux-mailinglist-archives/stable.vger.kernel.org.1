Return-Path: <stable+bounces-39099-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC6A8A11E8
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42021F23343
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432E214600E;
	Thu, 11 Apr 2024 10:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t5TaFxFV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DCD6BB29;
	Thu, 11 Apr 2024 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832514; cv=none; b=qFLR4Ape0fGPKRPkoKbC1H3Vr1slay4UCB3iX+Nb9an/fhMludSgOP05ngbX0ikuUtZgsLFVtmpQHkMPXfn0YACQOnVndKxXn2Edwx6Ki2zc057F6AT2bU/IIl6b9pNxxw3xiLreU1lfuEcPlcj20RFWDa6onX0l1uetHz1TGyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832514; c=relaxed/simple;
	bh=/xbFUqzX0fHMluL8yejKpnJWZ2cZBQ/XW/LjTcLIHDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOjHcjJ88+7n0MSq0LB6z1McTIAUYDpJtP0YiH/KJiRqjMJEdIUNEJVGm1CLUwcXfeNtHE29pDFbjjfhhsQzK6wrs/U7IHTJVr/QvNBYKmuNofwfO22pqRl9GsTpK7vnTrCuNaQGO2JaEy4IpbYDpo4JZneKwWJGpder8LHsW2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t5TaFxFV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737A4C433F1;
	Thu, 11 Apr 2024 10:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712832513;
	bh=/xbFUqzX0fHMluL8yejKpnJWZ2cZBQ/XW/LjTcLIHDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t5TaFxFVPZU8nlGy9DgmgQ15oHJFaohzdZXZ0bv9Xh2qcLUYEQBFsueQCHMOAOfpq
	 IJej88vDFu8tpHcteOO6YzrZbrFpnPC+sw6ODbvWKc/suU6KOiga86kG+zAd9B3/vr
	 KgEJqEjrx6cEFHcysSqTzC9LhDAJgooFKPuSYFkI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 37/83] rcu-tasks: Repair RCU Tasks Trace quiescence check
Date: Thu, 11 Apr 2024 11:57:09 +0200
Message-ID: <20240411095413.800405614@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095412.671665933@linuxfoundation.org>
References: <20240411095412.671665933@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul E. McKenney <paulmck@kernel.org>

[ Upstream commit 2eb52fa8900e642b3b5054c4bf9776089d2a935f ]

The context-switch-time check for RCU Tasks Trace quiescence expects
current->trc_reader_special.b.need_qs to be zero, and if so, updates
it to TRC_NEED_QS_CHECKED.  This is backwards, because if this value
is zero, there is no RCU Tasks Trace grace period in flight, an thus
no need for a quiescent state.  Instead, when a grace period starts,
this field is set to TRC_NEED_QS.

This commit therefore changes the check from zero to TRC_NEED_QS.

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/rcupdate.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 319698087d66a..6858cae98da9e 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -205,9 +205,9 @@ void rcu_tasks_trace_qs_blkd(struct task_struct *t);
 	do {									\
 		int ___rttq_nesting = READ_ONCE((t)->trc_reader_nesting);	\
 										\
-		if (likely(!READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\
+		if (unlikely(READ_ONCE((t)->trc_reader_special.b.need_qs) == TRC_NEED_QS) &&	\
 		    likely(!___rttq_nesting)) {					\
-			rcu_trc_cmpxchg_need_qs((t), 0,	TRC_NEED_QS_CHECKED);	\
+			rcu_trc_cmpxchg_need_qs((t), TRC_NEED_QS, TRC_NEED_QS_CHECKED);	\
 		} else if (___rttq_nesting && ___rttq_nesting != INT_MIN &&	\
 			   !READ_ONCE((t)->trc_reader_special.b.blocked)) {	\
 			rcu_tasks_trace_qs_blkd(t);				\
-- 
2.43.0




