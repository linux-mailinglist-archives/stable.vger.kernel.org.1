Return-Path: <stable+bounces-121302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E06FA55637
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 20:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5277F3A9958
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 19:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ACA26BDB5;
	Thu,  6 Mar 2025 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAhfw8kw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3DC25A652
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 19:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288272; cv=none; b=KWjE5SPMix2mEXiCI1pB5S84HPmioYrN2stKyhf1i11SL+zxj6gkvvHzkFF3S39f1wSHpzGp1ybG1XQUcq4lAVb0mg8cqEFw6tL5B7Ct3Y1aaselLPNnhFZ/MsNcVYGoSQfIuJV38r2zpTJsCOi1WXoKRvelEXKusOdsdfD9prk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288272; c=relaxed/simple;
	bh=lON2P5QNygeuZ/3myn4mnRuQkEXtqdL7vuTszaUvVP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ag/xR9srb+XA7EDBru1V2EgjNguk7RaNpQXsK8gonmMvHessPW+rKPt/HF51Hn30ySJrL2zNWTIEUH2Ywq081hby4hu4M5m47yoptY42rqEsgn0sLPOBi59z58Fx5WJD+MhkXpeuhTLUoN+LH2PmLps1vV5kd9vz96DX7t+Fi7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAhfw8kw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541F2C4CEE0;
	Thu,  6 Mar 2025 19:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741288271;
	bh=lON2P5QNygeuZ/3myn4mnRuQkEXtqdL7vuTszaUvVP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YAhfw8kwVS2VaDeEq0qoNfhL0dgcw3R5XeL0DNuyefmCjgxlgdnTqMdB1NPYk0loV
	 5TXdUVjzTkSYuk7ySSwtywj4gqMyDafDshT/uIxCd9fw/ZkUPpnwoC1teQfves1sul
	 3lmRj9QwBEpVpD6/zhg68myavPgOXkjn5LDNHz8qvlcYLhJJ2Sw2yFsLu/MmHLHiNi
	 JcRyMHGT3Bman2UMo0hG2hq6Xof7qsIS2x0eZ7slahiBRi86fk3dCjwq1rgLKhXU3M
	 /AdUcIPa9qJzTwsDBqwHIHgQgJnWkIzgRP9NIT6HUgRn525Ci2/xv9jVVcyysb/3gL
	 v+R17yuT6hihw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	simon@swine.de
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] uprobes: Fix race in uprobe_free_utask
Date: Thu,  6 Mar 2025 14:11:09 -0500
Message-Id: <20250306120115-aa46b505626900bf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <n2mkjosxf7bdnrjs4bb3zphj2tzfbssuqlgbq5m6zs3kxjrhki@5z3zuabq2tgg>
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

Summary of potential issues:
ℹ️ Patch is missing in 6.13.y (ignore if backport was sent)
⚠️ Commit missing in all newer stable branches

The upstream commit SHA1 provided is correct: b583ef82b671c9a752fbe3e95bd4c1c51eab764d

WARNING: Author mismatch between patch and upstream commit:
Backport author: Christian Simon<simon@swine.de>
Commit author: Jiri Olsa<jolsa@kernel.org>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  b583ef82b671c ! 1:  9f50b10df7c63 uprobes: Fix race in uprobe_free_utask
    @@
      ## Metadata ##
    -Author: Jiri Olsa <jolsa@kernel.org>
    +Author: Christian Simon <simon@swine.de>
     
      ## Commit message ##
         uprobes: Fix race in uprobe_free_utask
     
    +    commit b583ef82b671c9a752fbe3e95bd4c1c51eab764d upstream.
    +
    +    Christian Simon verified the regression exists in v6.1.129 as per method
    +    below and backported the mainline fix to the older version of
    +    uprobe_free_utask. After that change I can no longer reproduce
    +    the race with this method within 12 hours, while before it would
    +    show the panic in under a minute.
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
    +    [Christian Simon: Rebased for 6.1.y, due to mainline change https://lore.kernel.org/all/20240929144239.GA9475@redhat.com/]
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
| stable/linux-6.1.y        |  Success    |  Success   |

