Return-Path: <stable+bounces-46195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 600D28CF341
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 11:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACE2282039
	for <lists+stable@lfdr.de>; Sun, 26 May 2024 09:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908C217BB6;
	Sun, 26 May 2024 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvrs87T4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FF7179AB;
	Sun, 26 May 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716524; cv=none; b=OFI5KKaLGOW/lMjlhJghXVzQ3NZY00+Dvnf5dkoqx+Ua63P7TP2MLEKW4Y2hsq4imvrCbtONRFyQ/rgpk0nZEh1ldDP6jkBWainVC2LnMXhfv7eTzzXbmFb89bBvAqQZcI1zer58ETWGjakJ70CNtBVa0t0R9tbPUb7yx2vdvwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716524; c=relaxed/simple;
	bh=o3Y4QJcNroVboOkCDrziFORCtAWMtT3jlX2Cyqih+zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/PDWUgPmKa4LFtoey/QoFVg+R9TTTy60cZRixcZtz+pI0bwGfu7tGJHtI4JvUTRfF/nHRp1QOfACNKiYCz7tcdwN3nR81Qh1UShy+tF+04FE8oxNJ0ZmVx/ZFiJmTKupaJEWF8FgCHCy9f59SUvG+PyCzyfzgRu3BSDtsZqLGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvrs87T4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7380AC32781;
	Sun, 26 May 2024 09:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716523;
	bh=o3Y4QJcNroVboOkCDrziFORCtAWMtT3jlX2Cyqih+zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bvrs87T42+d93eck1770i66bqVBmChzo17nAP60VZreDI4v2qfvoGBQDSKVK/KvFf
	 djOt4SsNw2SOosZlHdeSIiddXJjKgP+j6K7KuZ+AqB8IDOYpIl68667UPrdnAV7pAl
	 GDogl3UWRMqEIrXtUfOb+QwyTqdHFOmXiwk8yQ569tI73hxIp7h8/IEMOKAOs+5J6m
	 QPYzmZ8msLfJ3w1liMwAoTc0VGnA1a+TmGeaNCil8vgsVuxTK+K4FEBuXNcvfWzvrQ
	 z2cpWYPi0r7QkGLNdh9b6eeJLUcVEUVzmwPcYfz04DVLSjkE7CbOR1hSlCtMrJ6BR8
	 l1DD8fC750C/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	dave@stgolabs.net,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	boqun.feng@gmail.com,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 07/15] rcutorture: Fix rcu_torture_one_read() pipe_count overflow comment
Date: Sun, 26 May 2024 05:41:39 -0400
Message-ID: <20240526094152.3412316-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526094152.3412316-1-sashal@kernel.org>
References: <20240526094152.3412316-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.1
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 8b9b443fa860276822b25057cb3ff3b28734dec0 ]

The "pipe_count > RCU_TORTURE_PIPE_LEN" check has a comment saying "Should
not happen, but...".  This is only true when testing an RCU whose grace
periods are always long enough.  This commit therefore fixes this comment.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/lkml/CAHk-=wi7rJ-eGq+xaxVfzFEgbL9tdf6Kc8Z89rCpfcQOKm74Tw@mail.gmail.com/
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/rcutorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 45d6b4c3d199c..5dfea5c6de577 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1997,7 +1997,8 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp, long myid)
 	preempt_disable();
 	pipe_count = READ_ONCE(p->rtort_pipe_count);
 	if (pipe_count > RCU_TORTURE_PIPE_LEN) {
-		/* Should not happen, but... */
+		// Should not happen in a correct RCU implementation,
+		// happens quite often for torture_type=busted.
 		pipe_count = RCU_TORTURE_PIPE_LEN;
 	}
 	completed = cur_ops->get_gp_seq();
-- 
2.43.0


