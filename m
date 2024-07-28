Return-Path: <stable+bounces-62007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182BB93E1E9
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 02:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E3B1C203A3
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 00:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A9D84D3F;
	Sun, 28 Jul 2024 00:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLOuECl3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E15B84D0F;
	Sun, 28 Jul 2024 00:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127717; cv=none; b=XKIFCqw7pQIaAbqZCE3jx3gud4mFEpb8I+Oiz7TUyLvyvCkA41NB19QWjUFjKiZ1PwvP4XQoOJ308qTSY2ImFOWfOoENpWMrf4u4pNOZTL8maEsyS+Ka7kuohUgk2mTEB/j15q55upTLsQK7tZaWJK8Lz6YuHGDW0YA4yhDgbQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127717; c=relaxed/simple;
	bh=I7tExzlKjBCss9qmA8DBJ4E/YI+XUhtSiyvSgFoCY4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3P3Unm4i+1HgPm1fIjQWIbk8UggqfYmUX7djp2sNlrI33d1Bp+w3mu9Qux9900OeEPvaceI0hYFwBnImQ00C6Dav8gNDLVX38c5+wGAd7C3rrcrr3dwD7XpPrskoQkpqOGc/zJXGOlqIOuDCOCo73rCMYhg7Ja6FoVxQcioH2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLOuECl3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884C9C32781;
	Sun, 28 Jul 2024 00:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127717;
	bh=I7tExzlKjBCss9qmA8DBJ4E/YI+XUhtSiyvSgFoCY4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FLOuECl3JIL+oPyVPCosCXSlHnSs+LQq+cabyPwP9+H73KUWiH/UGTgU9eU3IxR2K
	 pTwRWPJgkJ0+rOWCSJC0M5pgwathZ2CgiHMx+rp5g9kSF6xTu81cqvVOvCo+7Pb0Jh
	 DnDM/mLUy6NyHuX1ahUM9IdGaxXcYtbibRBs2OpaxdiwgwP5IVeZO+kLQhEEcWgEx0
	 7U0+DQpPY3XcDUNZulw/Xedbc5lMJUf3BBFwT/MeIl/SEGjHQW2c/FQKvlgPmE5hvt
	 p2pcpYJNmpCyK1+/xnuUi353pnAXxTU0PbX9hk95NBryEVAVk54iSIqkDW+WR2lVfJ
	 1e5jfUdNT1ksA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	kasan-dev@googlegroups.com,
	Sasha Levin <sashal@kernel.org>,
	dave@stgolabs.net,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 2/8] rcutorture: Fix rcu_torture_fwd_cb_cr() data race
Date: Sat, 27 Jul 2024 20:48:24 -0400
Message-ID: <20240728004831.1702511-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728004831.1702511-1-sashal@kernel.org>
References: <20240728004831.1702511-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.102
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

[ Upstream commit 6040072f4774a575fa67b912efe7722874be337b ]

On powerpc systems, spinlock acquisition does not order prior stores
against later loads.  This means that this statement:

	rfcp->rfc_next = NULL;

Can be reordered to follow this statement:

	WRITE_ONCE(*rfcpp, rfcp);

Which is then a data race with rcu_torture_fwd_prog_cr(), specifically,
this statement:

	rfcpn = READ_ONCE(rfcp->rfc_next)

KCSAN located this data race, which represents a real failure on powerpc.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: <kasan-dev@googlegroups.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8c45df910763a..c14517912cfaa 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2547,7 +2547,7 @@ static void rcu_torture_fwd_cb_cr(struct rcu_head *rhp)
 	spin_lock_irqsave(&rfp->rcu_fwd_lock, flags);
 	rfcpp = rfp->rcu_fwd_cb_tail;
 	rfp->rcu_fwd_cb_tail = &rfcp->rfc_next;
-	WRITE_ONCE(*rfcpp, rfcp);
+	smp_store_release(rfcpp, rfcp);
 	WRITE_ONCE(rfp->n_launders_cb, rfp->n_launders_cb + 1);
 	i = ((jiffies - rfp->rcu_fwd_startat) / (HZ / FWD_CBS_HIST_DIV));
 	if (i >= ARRAY_SIZE(rfp->n_launders_hist))
-- 
2.43.0


