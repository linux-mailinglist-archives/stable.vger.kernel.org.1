Return-Path: <stable+bounces-174310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 694AEB362D0
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F28B54664AD
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB8222DFA7;
	Tue, 26 Aug 2025 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZvQRS6Ga"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A239221704;
	Tue, 26 Aug 2025 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214050; cv=none; b=IybC/OZLaU3oeEeZCBLdXUXy7p8nLt06RnhD1djbKUPFGQvLSwzyA8dTmWF3/V2t1OfGsnXS6IVNRm97RGy8PQN2Qe8SginLeQTdugwQzJ2U31eechQ3wUhHh/jVSNtGyjMHKNWknA/xpMbVGPYKXQ3DlftVB1wlCfEW4Pf3Nz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214050; c=relaxed/simple;
	bh=IyYY5VVba5aRL7Jl3PWCoIPJRRhDW7n5bw3LqsBQHIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQZnZCJgheJaNUeEdwVE+CNSUrZ97+uAlhF7tLbf7chNOXrpj0eGyy49YT3NWEGWt+esF3ssQGAvPKV5hCG9J1ZWyuXz0/X63IvGBde3gG/k4bohXUIh5CDSoS0CYIvKd3WzBGwqZEW7a32vHMWyWQrJYmthqs7dq9tNNvW3ll0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZvQRS6Ga; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D342CC4CEF1;
	Tue, 26 Aug 2025 13:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214050;
	bh=IyYY5VVba5aRL7Jl3PWCoIPJRRhDW7n5bw3LqsBQHIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZvQRS6GaEQJFHNiuChf0rtExN7l9obTPPhsu95unNduCAm1aOqhL5QKgnPJDZqTd0
	 OLID2qfh6zyMJV+eHVs4Y9/a6kxrXJG/s26HVvXDZ0TXLZLqnXgKRNWahAu/lTWI3c
	 UHMBP68a13tJIUaTJzx9VJHnqlnE8Xu/g2yFgA9U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	William Liu <will@willsroot.io>,
	Savino Dicanosa <savy@syst3mfailure.io>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 577/587] net/sched: Remove unnecessary WARNING condition for empty child qdisc in htb_activate
Date: Tue, 26 Aug 2025 13:12:06 +0200
Message-ID: <20250826111007.716059379@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110952.942403671@linuxfoundation.org>
References: <20250826110952.942403671@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: William Liu <will@willsroot.io>

[ Upstream commit 2c2192e5f9c7c2892fe2363244d1387f62710d83 ]

The WARN_ON trigger based on !cl->leaf.q->q.qlen is unnecessary in
htb_activate. htb_dequeue_tree already accounts for that scenario.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: William Liu <will@willsroot.io>
Reviewed-by: Savino Dicanosa <savy@syst3mfailure.io>
Link: https://patch.msgid.link/20250819033632.579854-1-will@willsroot.io
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_htb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 113b305b0d15..c8a426062923 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -592,7 +592,7 @@ htb_change_class_mode(struct htb_sched *q, struct htb_class *cl, s64 *diff)
  */
 static inline void htb_activate(struct htb_sched *q, struct htb_class *cl)
 {
-	WARN_ON(cl->level || !cl->leaf.q || !cl->leaf.q->q.qlen);
+	WARN_ON(cl->level || !cl->leaf.q);
 
 	if (!cl->prio_activity) {
 		cl->prio_activity = 1 << cl->prio;
-- 
2.50.1




