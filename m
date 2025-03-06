Return-Path: <stable+bounces-121314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B05F8A55643
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 20:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133851896D43
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 19:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC72826D5A7;
	Thu,  6 Mar 2025 19:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ez29v4G3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB98A25A652
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 19:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288296; cv=none; b=MIitUyaOTUNtBM41foHnQxPDNxoaggNTX4vOug7Wqrtf9hYMhOHn9phn7cr7zY68XLvP8uElXQz0uji6SqTxwo4mEg5ffVXMAJE8xHWgi8X8PvKVn0yYyZBMyx54FS0Tlsd2dRj6LdEMzKEtGcyce7i6JhfdC0FqlD9Wob60wow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288296; c=relaxed/simple;
	bh=9k/ywUTE1xT9mRIhmTR8TXXOiRe8QqBAkdBWxAr8JBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b94DgyJIxgXEiaDtMNqi/iMjdSBaMX0tHg7FKJYVSj+tmxjujkg++tsGal+V7BDHn/r6t+3XgJAAL9adH8JEUOFHqFc6wJ/W9n2E8rsAClKGScRENL1K5rA5NR0lohNsGLIMfTRQGvmfgZ/SSUGN/fogSYoM6aIC4Ud+AzMFi04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ez29v4G3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234DAC4CEE4;
	Thu,  6 Mar 2025 19:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741288296;
	bh=9k/ywUTE1xT9mRIhmTR8TXXOiRe8QqBAkdBWxAr8JBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ez29v4G3DDBTNSoC/fSpCA4FFA/zK7uUs0AhOOtrPvscjwTx6qTDtQhiZ8zbBZpgL
	 MJguTNPivoQUeU9Lz5A5g8atDijoT2Eunh2Tx+iQsFIO7jlVzV5hWl6bRKVjBIOVNh
	 G4MNLKooWXyYh+xGFlI9VKxy03AaDvhFku3Qju5webetpbxYrN9inulXNquCUG6Hhg
	 1eLVoBn2OMCe9FkZYEcV1tKjttNSzxia9EPVZFSqztsVTsu1sIYkBrEMcr+k08WMZo
	 /4Vyqw3hKm24lkva7jt2DWnQQaQ5wcWWN9jK6KVtl55TH7EJ+uVKpBlMuyECVmGedz
	 GcLyYLgZ8Y8GA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Simon <simon@swine.de>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] uprobes: Fix race in uprobe_free_utask
Date: Thu,  6 Mar 2025 14:11:34 -0500
Message-Id: <20250306114042-a92211a19571094d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <f2x6zmel57ijjmvy7fqy2h4uaffm2cptpnj3ei7ythdmwi6vd7@h4ohwls4p77f>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: b583ef82b671c9a752fbe3e95bd4c1c51eab764d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Christian Simon<simon@swine.de>
Commit author: Jiri Olsa<jolsa@kernel.org>

Note: The patch differs from the upstream commit:
---
1:  b583ef82b671c ! 1:  c65c252796df6 uprobes: Fix race in uprobe_free_utask
    @@
      ## Metadata ##
    -Author: Jiri Olsa <jolsa@kernel.org>
    +Author: Christian Simon <simon@swine.de>
     
      ## Commit message ##
         uprobes: Fix race in uprobe_free_utask
     
    +    commit b583ef82b671c9a752fbe3e95bd4c1c51eab764d upstream.
    +
    +    Christian Simon verified the regression exists in v6.6.80 as per method
    +    below and backported the mainline fix to the older version of
    +    uprobe_free_utask. After that change I can no longer reproduce
    +    the race with this method within 1h, while before it would show the
    +    panic under a minute.
    +
         Max Makarov reported kernel panic [1] in perf user callchain code.
     
         The reason for that is the race between uprobe_free_utask and bpf
    @@ Commit message
     
         Fixes: cfa7f3d2c526 ("perf,x86: avoid missing caller address in stack traces captured in uprobe")
         Reported-by: Max Makarov <maxpain@linux.com>
    +    (cherry picked from commit b583ef82b671c9a752fbe3e95bd4c1c51eab764d)
         Signed-off-by: Jiri Olsa <jolsa@kernel.org>
         Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
         Acked-by: Oleg Nesterov <oleg@redhat.com>
         Acked-by: Andrii Nakryiko <andrii@kernel.org>
         Link: https://lore.kernel.org/r/20250109141440.2692173-1-jolsa@kernel.org
    +    [Christian Simon: Rebased for 6.6.y, due to mainline change https://lore.kernel.org/all/20240929144239.GA9475@redhat.com/]
    +    Signed-off-by: Christian Simon <simon@swine.de>
     
      ## kernel/events/uprobes.c ##
     @@ kernel/events/uprobes.c: void uprobe_free_utask(struct task_struct *t)
    @@ kernel/events/uprobes.c: void uprobe_free_utask(struct task_struct *t)
      		return;
      
     +	t->utask = NULL;
    - 	WARN_ON_ONCE(utask->active_uprobe || utask->xol_vaddr);
    + 	if (utask->active_uprobe)
    + 		put_uprobe(utask->active_uprobe);
      
    - 	timer_delete_sync(&utask->ri_timer);
     @@ kernel/events/uprobes.c: void uprobe_free_utask(struct task_struct *t)
    - 		ri = free_ret_instance(ri, true /* cleanup_hprobe */);
      
    + 	xol_free_insn_slot(t);
      	kfree(utask);
     -	t->utask = NULL;
      }
      
    - #define RI_TIMER_PERIOD (HZ / 10) /* 100 ms */
    + /*
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

