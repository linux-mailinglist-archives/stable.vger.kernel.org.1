Return-Path: <stable+bounces-70461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255EA960E3F
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 16:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BEC28663A
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9F71C57AF;
	Tue, 27 Aug 2024 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hu7fjJ0q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF03B1C8719;
	Tue, 27 Aug 2024 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769982; cv=none; b=UHqOFIIVEY4q5lECIfjvVIq7RQ16u9KbV7I/uttaTm8eBhVdkFy8GiLeJaL73hK/zezYdssu532DKIz0DZ6+AcI7QB8ElBdm5aoznE89EKrEAhXJERCeVV8jpXiUEafOAQMg/bxf0dTnA+PtXnsG4tqq2vO6FJASCbW5XJWbTbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769982; c=relaxed/simple;
	bh=4XPcEnc+kl8Zo9yZBWPLigo/Ji4UnIY33/HCCEtCyb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nh1TDm6VTzCwgYVNvEDu+mRgECmloN1LV16UOIG0vs8jGI6NUnZmDbTNyOt+nLavi8vj2PzMWzMzwEaG8tWqD9oxwAS1/W6v1CaIuKthmCZtCzKl2FrCnlRZCENy1subkt+kEC+BnpkmddbmONtHAZBxmom5dpTfgoIrWzlLWhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hu7fjJ0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407EEC6106D;
	Tue, 27 Aug 2024 14:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724769982;
	bh=4XPcEnc+kl8Zo9yZBWPLigo/Ji4UnIY33/HCCEtCyb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hu7fjJ0qC9i0gHU9gizwdSNvAwEMF0VSZuOE0S5gw6DdR/VXAgW2N/g+ZYR24yDBZ
	 kSbKE0Pn6JKaAns2KF5SljXCMx5+qDRxuVCPd/JlsVwdzmiUsAa2WJ/zjGXVyknTN+
	 mlfz4XkwCyKgHtZct/35sqc4w/RXashNd91inoBE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 093/341] rcu: Eliminate rcu_gp_slow_unregister() false positive
Date: Tue, 27 Aug 2024 16:35:24 +0200
Message-ID: <20240827143846.944837886@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143843.399359062@linuxfoundation.org>
References: <20240827143843.399359062@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul E. McKenney <paulmck@kernel.org>

[ Upstream commit 0ae9942f03d0d034fdb0a4f44fc99f62a3107987 ]

When using rcutorture as a module, there are a number of conditions that
can abort the modprobe operation, for example, when attempting to run
both RCU CPU stall warning tests and forward-progress tests.  This can
cause rcu_torture_cleanup() to be invoked on the unwind path out of
rcu_rcu_torture_init(), which will mean that rcu_gp_slow_unregister()
is invoked without a matching rcu_gp_slow_register().  This will cause
a splat because rcu_gp_slow_unregister() is passed rcu_fwd_cb_nodelay,
which does not match a NULL pointer.

This commit therefore forgives a mismatch involving a NULL pointer, thus
avoiding this false-positive splat.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c7cb465e2e0c7..8541084eeba50 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1298,7 +1298,7 @@ EXPORT_SYMBOL_GPL(rcu_gp_slow_register);
 /* Unregister a counter, with NULL for not caring which. */
 void rcu_gp_slow_unregister(atomic_t *rgssp)
 {
-	WARN_ON_ONCE(rgssp && rgssp != rcu_gp_slow_suppress);
+	WARN_ON_ONCE(rgssp && rgssp != rcu_gp_slow_suppress && rcu_gp_slow_suppress != NULL);
 
 	WRITE_ONCE(rcu_gp_slow_suppress, NULL);
 }
-- 
2.43.0




