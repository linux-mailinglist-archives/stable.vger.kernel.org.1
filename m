Return-Path: <stable+bounces-140307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D672AAA75C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9BAE1883C95
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40243379CE;
	Mon,  5 May 2025 22:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSAJS+7T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435963379C5;
	Mon,  5 May 2025 22:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484608; cv=none; b=rAYXGuxx4kOYB1SdGEgFxm2K4vcLhxnV3dBDZVVGkcGTUWhuXEtTK1ms8sylNT4WSk1Wnq9J5nN+54TskZ6KPtoZ4lfjjW/p0ipb1DsLr5Sd8MLkNTiQ0st8dy3NSL5afZltNgqi6nr9p8vGWKEO7q2itLMMnG6a1sbKTqY0+d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484608; c=relaxed/simple;
	bh=OEbEVSv48B9JXaosrmPuliyiklKFTPE3Wjq/FCeeJnE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t9nQEi3O6Ls65WuyNqd0S68TIWpVLbi1/gj4IDCYk+XowoTCLEzUhnvYyb/ltlwbGTQR4FUZfgRV+j46c2rRqWge4GGcO+qjSv5h+CjZFq51+IHHvSCRc1yQxA0e5go0YL8Toxl2WFHAIctoUJlve2TM4KZeKhFpw3m0D5AfYcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSAJS+7T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32F5C4CEEE;
	Mon,  5 May 2025 22:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484608;
	bh=OEbEVSv48B9JXaosrmPuliyiklKFTPE3Wjq/FCeeJnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YSAJS+7T00iZX4DaBOUbSKXhfdmzObMaU5Z5RBA+wnyaVuBUHWmRJoB1k0bupD963
	 GObU1rwBLosg6wj2FNnbWrU0/MyADXF5t126gC2mFbO6Ds+MNdnxGT9kzpAGkUkhS1
	 eaHBp33d4kXubLALLpzaXpAd7kxBAKPmdErDhvAxBNQG0W9jQUE/VjS5RXXPwXs5MI
	 aAuCGRwiDK0EQcsNqzM7as5nQt4XVs34yVPNrS2m3loLiYUUd1PqZ/AH2X3dTbbNKd
	 QiTNCqd9ySUv8XiOKxUOYnMSIUaLpCMKbGGPaRzE2rvWnEffQ0R0tL/Bq7vr6fNsjc
	 9MbIOQ/WY3SDg==
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
Subject: [PATCH AUTOSEL 6.14 559/642] rcu: fix header guard for rcu_all_qs()
Date: Mon,  5 May 2025 18:12:55 -0400
Message-Id: <20250505221419.2672473-559-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 27d86d9127817..aad586f15ed0c 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -103,7 +103,7 @@ extern int rcu_scheduler_active;
 void rcu_end_inkernel_boot(void);
 bool rcu_inkernel_boot_has_ended(void);
 bool rcu_is_watching(void);
-#ifndef CONFIG_PREEMPTION
+#ifndef CONFIG_PREEMPT_RCU
 void rcu_all_qs(void);
 #endif
 
-- 
2.39.5


