Return-Path: <stable+bounces-94604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114CB9D6001
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 14:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97392832F8
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 13:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1B970834;
	Fri, 22 Nov 2024 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uIQquapo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE48F12E7F
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732283508; cv=none; b=o/c5WspmA/rIUfvHhQVECohnUWFCBRud8iyx0S0HZw6wrVG766hemfvwN2E1qEPHKPR7ZqhaCAsgsw4Wyjr3d1urZXI0Cmah6+Xa2jmVaJkcOCz+SgqK4UflL+s8PjF6Iq93DR205SK7VDDjxiXzD7O8xdML4gWSzXKCINx/I1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732283508; c=relaxed/simple;
	bh=bc/gH2995kbT/L1mlc7iis7mwDfNIhjeKkVVRKDru1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwMPdvGW5DoCj55aCEjbORZoYVIL8wMvp86/80jRnAaMky/DLCLbA2gEmDw+9LtXQYV19dnHJmFiWSFTeEeZQwR7Uq5NB5dZqbIHliaJoRd1H72hZqwP2wXReEftn0tclNxx6z/zR7eP+ugYBUXjJaenC7e8rQr1NBvg84gk1h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uIQquapo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73EAC4CECE;
	Fri, 22 Nov 2024 13:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732283508;
	bh=bc/gH2995kbT/L1mlc7iis7mwDfNIhjeKkVVRKDru1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uIQquapoNkKLSHxBzEb+ttzpdITi2xK8zZC2gXCy+fdS5r9/P9P2G4D6LEvhEqz4N
	 tdfs4H+7Jsf8t5jUcmbB2CKxgZ31uqc9QPlc3xlDGITwYeaquw0PfxZDNVoHitGLFR
	 3VvwlvxZD5+OBZF/uyYnB7dKh5JE/TB4FUrgcBXKeTPv7F33q5BGkeMJCPzYPxy+uN
	 NztIQ3DTs9uLQtqVt7L9KCXnDVFlZiKIVbasph4RxhHCvYDctbQSDrv4bAtygR/sxc
	 0Y5+DWJGDNToPFoA4wguXFRUq3OXm5a1r+3MtD51bx7LGA6qRvwuZ6YJoCjQ5FAJq0
	 aJpJS+746r7ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krister Johansen <kjlx@templeofstupid.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15.y 1/2] rcu-tasks: Idle tasks on offline CPUs are in quiescent states
Date: Fri, 22 Nov 2024 08:51:49 -0500
Message-ID: <20241122082613-0ce075e0ad10e9e9@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <c56243da5c8b4451097b39468166248790f9a1de.1732237776.git.kjlx@templeofstupid.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 5c9a9ca44fda41c5e82f50efced5297a9c19760d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Krister Johansen <kjlx@templeofstupid.com>
Commit author: Paul E. McKenney <paulmck@kernel.org>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
--- -	2024-11-22 08:20:56.541099344 -0500
+++ /tmp/tmp.xl2TPMYb3p	2024-11-22 08:20:56.533807007 -0500
@@ -1,3 +1,5 @@
+commit 5c9a9ca44fda41c5e82f50efced5297a9c19760d upstream
+
 Any idle task corresponding to an offline CPU is in an RCU Tasks Trace
 quiescent state.  This commit causes rcu_tasks_trace_postscan() to ignore
 idle tasks for offline CPUs, which it can do safely due to CPU-hotplug
@@ -10,15 +12,16 @@
 Cc: Andrii Nakryiko <andrii@kernel.org>
 Cc: Martin KaFai Lau <kafai@fb.com>
 Cc: KP Singh <kpsingh@kernel.org>
+Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
 ---
  kernel/rcu/tasks.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
 
 diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
-index 8fe78a7fecafd..ec68bfe98c958 100644
+index 5528c172570b..8648685e7dfa 100644
 --- a/kernel/rcu/tasks.h
 +++ b/kernel/rcu/tasks.h
-@@ -1451,7 +1451,7 @@ static void rcu_tasks_trace_postscan(struct list_head *hop)
+@@ -1090,7 +1090,7 @@ static void rcu_tasks_trace_postscan(struct list_head *hop)
  {
  	int cpu;
  
@@ -27,3 +30,6 @@
  		rcu_tasks_trace_pertask(idle_task(cpu), hop);
  
  	// Re-enable CPU hotplug now that the tasklist scan has completed.
+-- 
+2.25.1
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

