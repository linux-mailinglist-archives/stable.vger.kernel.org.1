Return-Path: <stable+bounces-23887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D34A868D85
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 11:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CA3287400
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 10:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C985B138491;
	Tue, 27 Feb 2024 10:26:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D2213849F;
	Tue, 27 Feb 2024 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709029601; cv=none; b=FwO8/XnsMtQMbO3nMQBLQql5b025gPMJuX2qw2Bn7ciRa00TSH/XY9V0cEhfYm/JZo7UFU2F/WM8zGSj++kfQHIF5+efFp66qRHQauuSD/JGO1e1IP0FlEOpL5T6VqtcqHQ/Yq5ksIl+Pl83UnipeP8pog9vG5i74l6sahLw7s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709029601; c=relaxed/simple;
	bh=2V6msSSOGznnB/lFtzfEFRZx43Zk7T3DtjKa16ZisKg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rI6n4HaWk9zcqCVYJhGdoSrwYR8bDuy0Me4D46Pm4JIvDvaBkxNphD/+6cUD+gTURRE5Ya6xfGTNjRU+UniGOIOaj4BWgSmVi2NaJ4/BGBZg0cCrarpY/WESPCmd/BrZU4eg2ksc6N1XxdSYbrCv8ShrVkteLeBKf27vfZIArQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Davidlohr Bueso <dave@stgolabs.net>,
	"Paul E. McKenney" <paulmck@kernel.org>, Josh Triplett
	<josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan
	<jiangshanlai@gmail.com>, Joel Fernandes <joel@joelfernandes.org>,
	<linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, David Vernet <void@manifault.com>
Subject: [PATCH 5.15 1/1] rcutorture: Add missing return and use __func__ in warning
Date: Tue, 27 Feb 2024 13:22:22 +0300
Message-ID: <20240227102222.29584-2-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240227102222.29584-1-d.dulov@aladdin.ru>
References: <20240227102222.29584-1-d.dulov@aladdin.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-04.aladdin.ru (192.168.1.104) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

From: David Vernet <void@manifault.com>

commit 80dcee695143255261f30c7cc2a041ba413717a4 upstream.

The rcutorture module has an rcu_torture_writer task that repeatedly
performs writes, synchronizations, and deletes. There is a corner-case
check in rcu_torture_writer() wherein if nsynctypes is 0, a warning is
issued and the task waits to be stopped via a call to
torture_kthread_stopping() rather than performing any work.

There should be a return statement following this call to
torture_kthread_stopping(), as the intention with issuing the call to
torture_kthread_stopping() in the first place is to avoid the
rcu_torture_writer task from performing any work. Some of the work may even
be dangerous to perform, such as potentially causing a #DE due to
nsynctypes being used in a modulo operator when querying for sync updates
to issue.

This patch adds the missing return call.  As a bonus, it also fixes a
checkpatch warning that was emitted due to the WARN_ONCE() call using the
name of the function rather than __func__.

Signed-off-by: David Vernet <void@manifault.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 kernel/rcu/rcutorture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index d820ef615475..a76399bd43b9 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1165,7 +1165,7 @@ rcu_torture_writer(void *arg)
 			 " GP expediting controlled from boot/sysfs for %s.\n",
 			 torture_type, cur_ops->name);
 	if (WARN_ONCE(nsynctypes == 0,
-		      "rcu_torture_writer: No update-side primitives.\n")) {
+		      "%s: No update-side primitives.\n", __func__)) {
 		/*
 		 * No updates primitives, so don't try updating.
 		 * The resulting test won't be testing much, hence the
@@ -1173,6 +1173,7 @@ rcu_torture_writer(void *arg)
 		 */
 		rcu_torture_writer_state = RTWS_STOPPING;
 		torture_kthread_stopping("rcu_torture_writer");
+		return 0;
 	}
 
 	do {
-- 
2.25.1


