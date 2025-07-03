Return-Path: <stable+bounces-159784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF91AF7A5F
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B035606EB
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6190B2EF65A;
	Thu,  3 Jul 2025 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jiRlR4in"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5232EF299;
	Thu,  3 Jul 2025 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555338; cv=none; b=LcVCORvg9MPU0x/vx268gIMY2UT3PqPqidSsmsAU4lZERb617sbN0QTBc5jPdEqhfP5StkN/Emr6RdF0xPwVODexc1WiL+7dbHrOvfNGgfZaAxJx9nKAc4ytWjlI52L0xJsHtmfCgDle6re4sN4+Li2hmChTaVn0OZP+B2KM9yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555338; c=relaxed/simple;
	bh=XpRFKb49J0G+iJ91watV7H0gVDdekBuNJ2J2KrABarg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o45Q6bEcgi0/jytWJ/PPKR+q74NlONjI61CcLALa7Za9RdRtvgyoc7YjPXvPhak/8c2bqUxoVjauTWUxyOKnOlnEjwk0SZuDDOFTbz0fQBK1Y9X1LY4+fgdo4BHpMwszbqxJi97H6a3LIbUCKgjKEZWKxOXwByapmH9atB9gZIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jiRlR4in; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D49C4CEE3;
	Thu,  3 Jul 2025 15:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555338;
	bh=XpRFKb49J0G+iJ91watV7H0gVDdekBuNJ2J2KrABarg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jiRlR4iniMr7wjAdYyawkao5wmHkueIcyX3nG7NUltW4ItxvxDXQoIsnd4gOMdSGw
	 ncLTwW0L3WBU2p4r8tIt/TaWCSQxJqqjeX9wfvew5eRGNk0Zpr+3Ocysxf5+vHyyWi
	 5gH0m0okK7odf4fqkB2+QAcB6CEV8ybvQMC7Op+8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 247/263] sched_ext: Make scx_group_set_weight() always update tg->scx.weight
Date: Thu,  3 Jul 2025 16:42:47 +0200
Message-ID: <20250703144014.321089259@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703144004.276210867@linuxfoundation.org>
References: <20250703144004.276210867@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c50784e99f0e7199cdb12dbddf02229b102744ef ]

Otherwise, tg->scx.weight can go out of sync while scx_cgroup is not enabled
and ops.cgroup_init() may be called with a stale weight value.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 819513666966 ("sched_ext: Add cgroup support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/ext.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index afaf49e5ecb97..86ce43fa36693 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4074,12 +4074,12 @@ void scx_group_set_weight(struct task_group *tg, unsigned long weight)
 {
 	percpu_down_read(&scx_cgroup_rwsem);
 
-	if (scx_cgroup_enabled && tg->scx_weight != weight) {
-		if (SCX_HAS_OP(cgroup_set_weight))
-			SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_set_weight, NULL,
-				    tg_cgrp(tg), weight);
-		tg->scx_weight = weight;
-	}
+	if (scx_cgroup_enabled && SCX_HAS_OP(cgroup_set_weight) &&
+	    tg->scx_weight != weight)
+		SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_set_weight, NULL,
+			    tg_cgrp(tg), weight);
+
+	tg->scx_weight = weight;
 
 	percpu_up_read(&scx_cgroup_rwsem);
 }
-- 
2.39.5




