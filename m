Return-Path: <stable+bounces-141575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2550BAAB472
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15CE67B4001
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA2829550A;
	Tue,  6 May 2025 00:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+EbGQbH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB4D2F1CE2;
	Mon,  5 May 2025 23:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486767; cv=none; b=komFCKkTA2Lat7MxYwavRyxUlkyoiw+a/2bEubo0JQ8yt3KzLur+PgU89Ew3FWhX3yYH3PZcMmYlke6cGqsvHbWE+HRbkTVi5BvJxkobyLcHexckoBCkgcp50E/VP5lTvYQMwcx8rEPxqTVJN99V4sKRsIxljPf9dAUn0CWfwb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486767; c=relaxed/simple;
	bh=CJ7mdf4vRbTYoLfPVW/MpaXB5BFerskzFGtYZi0NiU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nH5zjy7cGwyGNiqUReh7ePlHcpBBrreo0KT80aZmiHmXtQ0BaHPZvm7a2yQUzmnvFZ72NBKLoHrn+DyNa9p6ApBRH77QuLwk1wS1y11e51YtiGh4BN9hwG+kUljU1WCZ56nwld0KzMDv74K5sHEAPT5yvcpf29DMT/kVQm9Io+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+EbGQbH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85142C4CEE4;
	Mon,  5 May 2025 23:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486766;
	bh=CJ7mdf4vRbTYoLfPVW/MpaXB5BFerskzFGtYZi0NiU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J+EbGQbHZz6M+EevWUBBJ5uLAc52mFoXfJtxv7ziawoTlqSAl9+5nv9dtXC6U4gZY
	 Chc2g2JGDndcKskBVXpfAzmh3GblCORKLM+j5w93oK0fH8DU+3d6ZDKFFeuxHQRM9e
	 GmucS0UUOATRY20AF4Ye20UZ/kQ4HeiM4lZNBgc+6L+O5lPqYzrKk7yinQvt8JQknK
	 HrKyQ2Bxrpypkf/aRiDsjf8XpxJAWWnBsPR/vEI9j+NqyXxJqSZWz4mYofRT5Blr19
	 nYlf6AOQwAYceFknidoIXC8bocR0ergrgMbLVIEkejZrILOJWBj38m6K0U5nsYtkaa
	 1FeAwAjdpeG5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 192/212] rcu: fix header guard for rcu_all_qs()
Date: Mon,  5 May 2025 19:06:04 -0400
Message-Id: <20250505230624.2692522-192-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Ankur Arora <ankur.a.arora@oracle.com>

[ Upstream commit ad6b5b73ff565e88aca7a7d1286788d80c97ba71 ]

rcu_all_qs() is defined for !CONFIG_PREEMPT_RCU but the declaration
is conditioned on CONFIG_PREEMPTION.

With CONFIG_PREEMPT_LAZY, CONFIG_PREEMPTION=y does not imply
CONFIG_PREEMPT_RCU=y.

Decouple the two.

Cc: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/rcutree.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 5efb51486e8af..54483d5e6f918 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -105,7 +105,7 @@ extern int rcu_scheduler_active;
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
-#ifndef CONFIG_PREEMPTION
+#ifndef CONFIG_PREEMPT_RCU
 void rcu_all_qs(void);
 #endif
 
-- 
2.39.5


