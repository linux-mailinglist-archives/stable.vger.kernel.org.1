Return-Path: <stable+bounces-188836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0CDBF8E8D
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 23:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B213B0EE7
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 21:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FC328000C;
	Tue, 21 Oct 2025 21:10:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BC228504F;
	Tue, 21 Oct 2025 21:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761081011; cv=none; b=aaQB3H/O0Tg/k0W3GozGMj66ILfwtVRuXzm8xcv/TOG01EWrKpsk1Ey3V8vpWpsyUiM2CGtqeIJY46B77DXFNS18wv6jYCk6i+xcwO/sB+A5AyIcpzOfEP0EbeMba0Icg10B8mtmn5L9Z4Wi4CLGQWJoJn67a4Y/dFygxhj/nAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761081011; c=relaxed/simple;
	bh=HEt6WD06oYzuqeSOXwxyNbgmB4LKiDDTAoQolw9CRwc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YCGLUWGqCXvj9AjQ0Sjl/zqonUohGo6qx+gE1yokXRruquyJUN0jpbHHJ+k4qwZszFsf6HesYpduALNWoAYip05GDKaXu6qq5/gjEp/M3ysCV3qPxq//9HhaLTzkOx49LUfVYWCWZrvo9j58AsIn4+rJa6T5SK4AEa4xMcQ3Zbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 078792337D;
	Wed, 22 Oct 2025 00:00:16 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	rcu@vger.kernel.org,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10/5.15] srcu: Tighten cleanup_srcu_struct() GP checks
Date: Wed, 22 Oct 2025 00:00:16 +0300
Message-Id: <20251021210016.181003-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

commit 8ed00760203d8018bee042fbfe8e076579be2c2b upstream.

Currently, cleanup_srcu_struct() checks for a grace period in progress,
but it does not check for a grace period that has not yet started but
which might start at any time.  Such a situation could result in a
use-after-free bug, so this commit adds a check for a grace period that
is needed but not yet started to cleanup_srcu_struct().

Fixes: da915ad5cf25 ("srcu: Parallelize callback handling")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
[ kovalev: backport to fix CVE-2022-49651; added Fixes tag for commit
  da915ad5cf25 that introduced the srcu_gp_seq_needed field and the
  race condition between grace period requests and cleanup ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 kernel/rcu/srcutree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index b8821665c435..5d89d941280f 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -388,9 +388,11 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 			return; /* Forgot srcu_barrier(), so just leak it! */
 	}
 	if (WARN_ON(rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)) != SRCU_STATE_IDLE) ||
+	    WARN_ON(rcu_seq_current(&ssp->srcu_gp_seq) != ssp->srcu_gp_seq_needed) ||
 	    WARN_ON(srcu_readers_active(ssp))) {
-		pr_info("%s: Active srcu_struct %p state: %d\n",
-			__func__, ssp, rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)));
+		pr_info("%s: Active srcu_struct %p read state: %d gp state: %lu/%lu\n",
+			__func__, ssp, rcu_seq_state(READ_ONCE(ssp->srcu_gp_seq)),
+			rcu_seq_current(&ssp->srcu_gp_seq), ssp->srcu_gp_seq_needed);
 		return; /* Caller forgot to stop doing call_srcu()? */
 	}
 	free_percpu(ssp->sda);
-- 
2.50.1


