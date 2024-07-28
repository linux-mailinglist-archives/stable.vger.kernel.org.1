Return-Path: <stable+bounces-62015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAF093E1FF
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 02:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0962FB21B87
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 00:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C031459F6;
	Sun, 28 Jul 2024 00:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYW2Oh1k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C49814535A;
	Sun, 28 Jul 2024 00:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722127734; cv=none; b=Xx37dpt/ISFF8RsRFT3+lrnnJylrKjx9B6w+PcXOlEVsTZZylkxerbzKsE7wxMB51OIOFdfj93Z7K8wT/1VUbTl3bN3gDZRcCMRfs7M2fQJnv3AWf7FfMZQmDIRLg5EKZEBg8VIyUbO+7C+vIOiJZyakj+o5Asy3PwIuJLhdJoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722127734; c=relaxed/simple;
	bh=7fN9jg+/l4OO5UkJTs3sgHOIzQ1RQVJB3UDHsdzEKos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVJ6tiB6IoiKiL35eR/OnlBYywv+btOLtEdKJvltxMwGGWPGnEfbTjZePJoM/GQJyz9N0SlXfUihP1iNkJ3jEZdxg7RTriMAf3OwHic9AoUk2zDBEyoj4FDVazsaShQSdaw4G4zIsTQSDVEbsjalCxDei7EfFzzoZkbPzL/NAOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYW2Oh1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1828CC32781;
	Sun, 28 Jul 2024 00:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722127733;
	bh=7fN9jg+/l4OO5UkJTs3sgHOIzQ1RQVJB3UDHsdzEKos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mYW2Oh1kQezyYizXtbeGm8+CDg0Ny7aCX4O9KTd1E/cSVU1TxDopNhnKAnRZzTqS9
	 pvmpX6TplHBq98oxjvpttGpzW4Djq//z5T750F6aF2Sy7t15A4ohUyhNxqX0SIhjM/
	 jqy8xtDxyUZ9+HhzBLW5wddDkEPFKiSSneiZMEuvnbOHWJkyq/d7/BZnYyD0kNn3rp
	 tKwt8HLIm0YBbItmotVLj/n7WZQqTuPaYB/SvKW3FOUFtco9CB/jwgAmWzkpedRXfG
	 Z4T18JOjvqVX5RXunKcRbu4RDl90UaVNN46qo+K0uxFRpboHvssJQgQYUksaKVtz6L
	 S+xBnxQ79Qebg==
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
Subject: [PATCH AUTOSEL 5.15 2/6] rcutorture: Fix rcu_torture_fwd_cb_cr() data race
Date: Sat, 27 Jul 2024 20:48:43 -0400
Message-ID: <20240728004848.1703616-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728004848.1703616-1-sashal@kernel.org>
References: <20240728004848.1703616-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.164
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
index 9d8d1f233d7bd..a3bab6af4028f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2186,7 +2186,7 @@ static void rcu_torture_fwd_cb_cr(struct rcu_head *rhp)
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


