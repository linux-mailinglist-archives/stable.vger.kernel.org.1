Return-Path: <stable+bounces-121007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A5EA50979
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 19:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4360D3A56A9
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 18:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E417725335F;
	Wed,  5 Mar 2025 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kJeS2dNP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17F8253356;
	Wed,  5 Mar 2025 18:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741198610; cv=none; b=Xnq69dggmKu3Siu145ZT+AspeYOq8iRPQ8eH8OCoyDfQ6lct3PIBAx/EY3GaNsCQI7hJRRG3CqmfuC3SAMtTryltoH93MxgX3o02NnrnBO725TGfQ02lHfmvEJ+0jO7jxqQ4hWwF4kq9Ww4YIm6BbDuphsP4WgZHPbH7iBfSMC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741198610; c=relaxed/simple;
	bh=h88Ft+j4YT1ZxohW36aX82PASFK0QUEcd0FM+wAnWew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOYjIvIRPFtdIcUDKftuV+/N4N8Fep9yvtVW8vykoVNwnkcbjMhOieK61QC6TfIl7L16H0rVuodLBxjZLiAVLtXyk0nOb12xvL0zQwdm3kvNz8HHdtrKYCrzgcUFYSzBA6EBFQezdypdiMJ7auoIap5tHJFPOTBqfo0uqxEd03E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kJeS2dNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27552C4CED1;
	Wed,  5 Mar 2025 18:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741198610;
	bh=h88Ft+j4YT1ZxohW36aX82PASFK0QUEcd0FM+wAnWew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kJeS2dNPeXbARujZRZuW7kkaf8NXvZd/ePT2xYb8/UmVpTdMBgYcJKzArk1FQAs4R
	 vnzuwNNZgiAtDOLXygmsA6MogmsK8GI/2GC1YcIEaSjM9WndK2ZrrAVTVKrneZx6Q+
	 xYY68eX1v5z8/dxww/uIL/0wtKhJmja/P7qiXKKE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 6.13 086/157] perf/core: Add RCU read lock protection to perf_iterate_ctx()
Date: Wed,  5 Mar 2025 18:48:42 +0100
Message-ID: <20250305174508.766045468@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305174505.268725418@linuxfoundation.org>
References: <20250305174505.268725418@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

commit 0fe8813baf4b2e865d3b2c735ce1a15b86002c74 upstream.

The perf_iterate_ctx() function performs RCU list traversal but
currently lacks RCU read lock protection. This causes lockdep warnings
when running perf probe with unshare(1) under CONFIG_PROVE_RCU_LIST=y:

	WARNING: suspicious RCU usage
	kernel/events/core.c:8168 RCU-list traversed in non-reader section!!

	 Call Trace:
	  lockdep_rcu_suspicious
	  ? perf_event_addr_filters_apply
	  perf_iterate_ctx
	  perf_event_exec
	  begin_new_exec
	  ? load_elf_phdrs
	  load_elf_binary
	  ? lock_acquire
	  ? find_held_lock
	  ? bprm_execve
	  bprm_execve
	  do_execveat_common.isra.0
	  __x64_sys_execve
	  do_syscall_64
	  entry_SYSCALL_64_after_hwframe

This protection was previously present but was removed in commit
bd2756811766 ("perf: Rewrite core context handling"). Add back the
necessary rcu_read_lock()/rcu_read_unlock() pair around
perf_iterate_ctx() call in perf_event_exec().

[ mingo: Use scoped_guard() as suggested by Peter ]

Fixes: bd2756811766 ("perf: Rewrite core context handling")
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250117-fix_perf_rcu-v1-1-13cb9210fc6a@debian.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/events/core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8284,7 +8284,8 @@ void perf_event_exec(void)
 
 	perf_event_enable_on_exec(ctx);
 	perf_event_remove_on_exec(ctx);
-	perf_iterate_ctx(ctx, perf_event_addr_filters_exec, NULL, true);
+	scoped_guard(rcu)
+		perf_iterate_ctx(ctx, perf_event_addr_filters_exec, NULL, true);
 
 	perf_unpin_context(ctx);
 	put_ctx(ctx);



