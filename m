Return-Path: <stable+bounces-46629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3530B8D0A8A
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671D91C215CB
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DEB161321;
	Mon, 27 May 2024 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xH7D8n1H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8498161301;
	Mon, 27 May 2024 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836447; cv=none; b=etSwlOCkEnWVp/rqaT5e7zNclzccKand7BRN9CeNr9AKbB/PNCn9EqYGlXw/U2rf6V27UZBS+LNcwl2b++1zrMZVzhdKa7UnXoegqK3lJgj+lAFSUN8HD7CO5OmJqYUC1DBJUmGCVEwnQo7VkYLdxBKpjI4QP+MFYj7MePCsZjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836447; c=relaxed/simple;
	bh=MyLPS8T5NzVeS/3+1UfEk43CJTy3UgtutYaFJZ6tyrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKgOoQ4Kacv3N9C2Z8ALyWarUI5iPxPhkRpCd1I1ZYJxK9LwdbCcgwXwUsphEPOdPMOKOSFDDha068OY3jJ2ALbZfF7j9hXA8i7SswR2bekTNpUVJElGyuaR2IOH6UwsNu9Q0wKiIb23wMB87RT+6NsyGIZYqGcJ3Vtc7I6mhlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xH7D8n1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2DFC2BBFC;
	Mon, 27 May 2024 19:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716836446;
	bh=MyLPS8T5NzVeS/3+1UfEk43CJTy3UgtutYaFJZ6tyrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xH7D8n1HRwQyGgRp43kE3myTzKSBcsf5adp32w/1g1pQkrlz4iGdPZzthzHnB617+
	 3OmhHbPbxUvJYzFyDqsq1iHp6O2F2enQBPOy+juyU56asAtY0PbFxAzaHRmDXgvYt2
	 laM4Q85rUupZPGMnd2x2EjeeSqQPaKSvFTzMTwCA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nikita Kiryushin <kiryushin@ancud.ru>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 058/427] rcu: Fix buffer overflow in print_cpu_stall_info()
Date: Mon, 27 May 2024 20:51:45 +0200
Message-ID: <20240527185607.265096994@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikita Kiryushin <kiryushin@ancud.ru>

[ Upstream commit 3758f7d9917bd7ef0482c4184c0ad673b4c4e069 ]

The rcuc-starvation output from print_cpu_stall_info() might overflow the
buffer if there is a huge difference in jiffies difference.  The situation
might seem improbable, but computers sometimes get very confused about
time, which can result in full-sized integers, and, in this case,
buffer overflow.

Also, the unsigned jiffies difference is printed using %ld, which is
normally for signed integers.  This is intentional for debugging purposes,
but it is not obvious from the code.

This commit therefore changes sprintf() to snprintf() and adds a
clarifying comment about intention of %ld format.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 245a62982502 ("rcu: Dump rcuc kthread status for CPUs not reporting quiescent state")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tree_stall.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 5d666428546b0..b5ec62b2d850a 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -504,7 +504,8 @@ static void print_cpu_stall_info(int cpu)
 			rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu));
 	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
 	if (rcuc_starved)
-		sprintf(buf, " rcuc=%ld jiffies(starved)", j);
+		// Print signed value, as negative values indicate a probable bug.
+		snprintf(buf, sizeof(buf), " rcuc=%ld jiffies(starved)", j);
 	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%04x/%ld/%#lx softirq=%u/%u fqs=%ld%s%s\n",
 	       cpu,
 	       "O."[!!cpu_online(cpu)],
-- 
2.43.0




