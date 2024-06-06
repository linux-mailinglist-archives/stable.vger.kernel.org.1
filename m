Return-Path: <stable+bounces-48900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B804E8FEB09
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43C4AB250A9
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD7C1A2C1F;
	Thu,  6 Jun 2024 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cw143r4i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69929197536;
	Thu,  6 Jun 2024 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683202; cv=none; b=XnTfj3NyL2E6RrvDxzpYZ0STDDTbEx+9wlJGxA9s/STrxArqVycXD1Rqk2XTB0lcqqffDqNCj2hmUrrLqtKcfYQB/74nP/Fl9q7JauOdPytd0MCGJpjiW0QN2MvPesDJEJPk486FXJHvEgMqGdrOGr4QX2vr0f7AmUXmLAZwkgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683202; c=relaxed/simple;
	bh=dcHldm8FnKoCCHEjmvfxAOh76hCWLRBqKWU4EaW28rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8qnzjzddo5cJpvr6Ds0R6h90XHiYln2IeQLnkeae7joTbqX3g71FJifO+O31DTu9jgZYKUjSgL1gNOZZbd6bxi7PTkqxlZQoCRDVaD/Ng+1/0fIyrdOWJ3tTleZOTZ9tpiRClMQB+VM3jZAQe9OsoO8jmdZQHeB069abfU8ggI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cw143r4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B94C32781;
	Thu,  6 Jun 2024 14:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683202;
	bh=dcHldm8FnKoCCHEjmvfxAOh76hCWLRBqKWU4EaW28rA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cw143r4i8AGM5guzoRNLpXhEVS1LEvkpw416IdfzBeAu7bAUND8Q3NlLJfqz+nta2
	 GgpiHmn+Xw2M5DzTR1Hekfra9YPKCFkMqilQD1KfZ7IDmMR4IZkZMc+cvI/wYLHPXs
	 50HOadVLhfapbxNj66018m2ZP6uvCnsM2PRKMFvg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nikita Kiryushin <kiryushin@ancud.ru>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 080/473] rcu-tasks: Fix show_rcu_tasks_trace_gp_kthread buffer overflow
Date: Thu,  6 Jun 2024 16:00:09 +0200
Message-ID: <20240606131702.559859754@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikita Kiryushin <kiryushin@ancud.ru>

[ Upstream commit cc5645fddb0ce28492b15520306d092730dffa48 ]

There is a possibility of buffer overflow in
show_rcu_tasks_trace_gp_kthread() if counters, passed
to sprintf() are huge. Counter numbers, needed for this
are unrealistically high, but buffer overflow is still
possible.

Use snprintf() with buffer size instead of sprintf().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: edf3775f0ad6 ("rcu-tasks: Add count for idle tasks on offline CPUs")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tasks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index b5d5b6cf093a7..6f48f565e3acb 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1789,7 +1789,7 @@ void show_rcu_tasks_trace_gp_kthread(void)
 {
 	char buf[64];
 
-	sprintf(buf, "N%lu h:%lu/%lu/%lu",
+	snprintf(buf, sizeof(buf), "N%lu h:%lu/%lu/%lu",
 		data_race(n_trc_holdouts),
 		data_race(n_heavy_reader_ofl_updates),
 		data_race(n_heavy_reader_updates),
-- 
2.43.0




