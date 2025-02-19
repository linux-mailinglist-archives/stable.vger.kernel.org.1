Return-Path: <stable+bounces-118118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC53CA3BA03
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6666E1884195
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959951CF284;
	Wed, 19 Feb 2025 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ilcvx/2j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540BD1CD213;
	Wed, 19 Feb 2025 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957288; cv=none; b=CwR5KW2L32iArBiZDN5YrrWrjp0evH/CDcFlE8wUQh/CatSo/ZrMXaI0aRMsFUjMlQIfDThmvWeOeOGtW+xveqxBypN6jrcGmw5A+lZ8fYQBM2MEqFCAKb9HBEOTnW0n1XRazhy39LlUv8B+IAjWpJrdI9VEf+8osXRF19gQgTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957288; c=relaxed/simple;
	bh=rl2XNc30GX4aLvIm+YIT/dsh1Zq4kSe2/vWZuV2wp58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CALVA/vutvTGw36KJJA8eNEokZIgwmhKkek+ZO+pndtQwl3vVx7030N6rcMUScgSMcBC6gMScpPccFQIPktc/i83Pwrbx7rDoyjwW7nb2eHilGtp12+9FBs/HuJTcoOXtfXsiqYGHYyXB2q8fQdnUMLys4cUuaWedc2lORwHzT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ilcvx/2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C31C4CED1;
	Wed, 19 Feb 2025 09:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739957287;
	bh=rl2XNc30GX4aLvIm+YIT/dsh1Zq4kSe2/vWZuV2wp58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ilcvx/2jeosvl3onPmT3RPWkhwSVEBN3rn29j3nGoCvNakfslDEccDqXSX6Lfi7d2
	 f/rDgndR0dVhgtv9HPWzGwOXrq+lPOYCmh02pXqfZB1jXTN4cg82HOql8UNgM8gBV4
	 vtTzJC7PSIHKjhCXBAuua0sGylmtYl0fL8ToCGSI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Axel Busch <axel.busch@ibm.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Muhammad Adeel <muhammad.adeel@ibm.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 473/578] cgroup: Remove steal time from usage_usec
Date: Wed, 19 Feb 2025 09:27:57 +0100
Message-ID: <20250219082711.614532049@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Muhammad Adeel <Muhammad.Adeel@ibm.com>

[ Upstream commit db5fd3cf8bf41b84b577b8ad5234ea95f327c9be ]

The CPU usage time is the time when user, system or both are using the CPU.
Steal time is the time when CPU is waiting to be run by the Hypervisor. It
should not be added to the CPU usage time, hence removing it from the
usage_usec entry.

Fixes: 936f2a70f2077 ("cgroup: add cpu.stat file to root cgroup")
Acked-by: Axel Busch <axel.busch@ibm.com>
Acked-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Muhammad Adeel <muhammad.adeel@ibm.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/rstat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 7006fc8dd6774..0ae90c15cad85 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -477,7 +477,6 @@ static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
 
 		cputime->sum_exec_runtime += user;
 		cputime->sum_exec_runtime += sys;
-		cputime->sum_exec_runtime += cpustat[CPUTIME_STEAL];
 
 #ifdef CONFIG_SCHED_CORE
 		bstat->forceidle_sum += cpustat[CPUTIME_FORCEIDLE];
-- 
2.39.5




