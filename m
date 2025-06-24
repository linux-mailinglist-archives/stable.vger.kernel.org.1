Return-Path: <stable+bounces-158222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D5CAE5A9D
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 05:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286D24A3E1B
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 03:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352421C84DF;
	Tue, 24 Jun 2025 03:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VC5ANJfV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C8A1C84CB
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 03:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750737154; cv=none; b=QFjvN3dcTCzW2FlYeF1LqzosB3CjRE67ru6g5ifbpi71ioU/Uy6XJmAnHmPuHsnhCYGnTiu62CpyGEQ9Ip4ysG51+7y78MWsC4BVsIGM8eXZHK5iIeqUlrsqm4XphGe4em4NVWUpR8hl/ACIDJ1yJP+mnF9g1ckz0Ei2enUXpzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750737154; c=relaxed/simple;
	bh=Hv1Up3oVWHp6yY0G/3Nhwj+yhkM3t2pewHFQiUtlGiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogw0UNu73tKTbbfS+2vX7ecwt0LS/r+dKzOckryCNKT544rEftOvuAWrJ7s/2cMMrJXiCr0zXFEm0pN+wFNbPXmxOqrFF4Neolm3njlESXL3d4bpa8ISi3iWpCiuIAbYfKjxymbSSu9colQuy1nBuGuDctW5f3IYGv7NekG3uhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VC5ANJfV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22c33677183so44752915ad.2
        for <stable@vger.kernel.org>; Mon, 23 Jun 2025 20:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1750737152; x=1751341952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQHTM9Oxf4ZST61KkrbKf/tUfIpWLkggeBaS5KkwWvw=;
        b=VC5ANJfVfGxGTgEweYKZgwxJ4eQaXiIio7U1KKSOu1AFS8Yyrt3AKB08f09mwhTO8J
         AvKi1xB5ePNAibxtP5XvHeMvLcM5WVD/mILIJcRIK2SSgfNfTqcKC4sz08oiLvDjG5Nn
         WKKIez8OiMjl1nxPpApuOe0t+EoqgRX05vgxoIzTjHUUkqXva0KHk1dPV0qS+LFJ86wb
         oR0Ca5ykSXvoLenM+nwGUxN61CjtYW1qg+F3uUZ2ENUWjb6JFuVLL7umTz2t98bNxFqz
         LPWid1guaHwejAkgUu40NHgZAIxOSgIqdcbkApbB1zUGwXaHsa5xDFfQBZ0Rd+l4J7Tx
         jszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750737152; x=1751341952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQHTM9Oxf4ZST61KkrbKf/tUfIpWLkggeBaS5KkwWvw=;
        b=sMwlreNkIW1ryCAEb4qSfxXbyjKd+mbKGjBHaDNhKrPoIyV9/LUiTO3Cbizkbwusft
         dMZq/xZLo4rRePXBW+PDUF46SXsOOu8yGgh7bMSmdyST4v4LKMiTwXfGUuSAXERkoV+q
         30Ug16JX6SwkdJF3+ZD/D1IAfAg2EdTqHoxWRG2gnwJCwVYF5buUWIR+ktoLtiqStUqB
         9NZhc5UFCDBOxX+lrQMIYOB6awZ4J983ewZYutrIQnGrpKYYDYYHxgVwSbAHx3n0kVF0
         QbENNWJoA7GXNrFaNLGrDUrswISSjuMljGzKttgZzwQuVqIzwhc6BwRWLYQxfYh1qeaI
         7i/A==
X-Gm-Message-State: AOJu0YwPqxoTr3z49cgHgbLsIQlIp9TtCXYmxPmxOl19UZAXTkdVb/R4
	U3RiWooxpcZqXFGscsO/GKlYpCYiue4n1WfoWKi8XTuRKzVeXxiyOz8t0i0OIGL89w==
X-Gm-Gg: ASbGncuto66ctqDYI/89j0BaAmFcsgQc/ERqrgVsrx6bU3AiYRk8zSBkovWlFZWNC1j
	Dc7i61DJ3j/LXzwJV+esIJPsEQVvzBHOaEAzfyD/bBW6dgxZ4A9aiQGpN+P7MdG4Mek6NKsN3/B
	i5962B/ChV6Xcx6DthPYYmI4jQIavC8POCXv18No9gxS1dpIldcDB69jtoYoZELOzZLqxe5Owx+
	dqqvlvZEsM0QwVTwxao1UBxHTeKMn20dYsdmYvZF0CXWZ5wGhnjt7NR0Vkd+O++v2/g1JOb/4kl
	jl5su7pY4SZgdwwuvIAN7C7CpDanvisHjDlrf8IQAsosUaQyLy2P2LVR1yL8zmM1bfzgO+qo95A
	jibrwQ28=
X-Google-Smtp-Source: AGHT+IF1y0ffLKAfVYKpMJf9xo9NX1jgKm2imfDe37RrPHmBuH2SDq6knEDp13vjAONxZokqmgb6gg==
X-Received: by 2002:a17:903:330b:b0:238:121:b841 with SMTP id d9443c01a7336-2380121b84bmr33201285ad.17.1750737151527;
        Mon, 23 Jun 2025 20:52:31 -0700 (PDT)
Received: from bytedance ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8393565sm96003475ad.46.2025.06.23.20.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 20:52:30 -0700 (PDT)
Date: Tue, 24 Jun 2025 11:52:16 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pu Lehui <pulehui@huawei.com>
Cc: stable@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Wei Wei <weiwei.danny@bytedance.com>,
	Yuchen Zhang <zhangyuchen.lcr@bytedance.com>
Subject: Re: Host panic in bpf verifier when loading bpf prog in 5.10 stable
 kernel
Message-ID: <20250624035216.GA316@bytedance>
References: <20250605070921.GA3795@bytedance>
 <20250616070617.GA66@bytedance>
 <2025062344-width-unvisited-a96f@gregkh>
 <20250623115552.GA294@bytedance>
 <2025062316-atrocious-hatchling-0cb9@gregkh>
 <e9fa5e34-eacd-4f35-a250-2da75c9b7df8@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9fa5e34-eacd-4f35-a250-2da75c9b7df8@huawei.com>

On Tue, Jun 24, 2025 at 09:32:54AM +0800, Pu Lehui wrote:
> Hi Aaron, Greg,
> 
> Sorry for the late. Just found a fix [0] for this issue, we don't need to
> revert this bugfix series. Hope that will help!
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=4bb7ea946a37
> [0]

I can confirm this also fixed the panic issue on top of 5.10.238.

Hi Greg,

The cherry pick is not clean but can be trivially fixed. I've appended
the patch I've used for test below for your reference in case you want
to take it and drop that revert series. Thanks.

From f0e1047ee11e4ab902a413736e4fd4fb32b278c8 Mon Sep 17 00:00:00 2001
From: Andrii Nakryiko <andrii@kernel.org>
Date: Thu, 9 Nov 2023 16:26:37 -0800
Subject: [PATCH] bpf: fix precision backtracking instruction iteration

commit 4bb7ea946a370707315ab774432963ce47291946 upstream.

Fix an edge case in __mark_chain_precision() which prematurely stops
backtracking instructions in a state if it happens that state's first
and last instruction indexes are the same. This situations doesn't
necessarily mean that there were no instructions simulated in a state,
but rather that we starting from the instruction, jumped around a bit,
and then ended up at the same instruction before checkpointing or
marking precision.

To distinguish between these two possible situations, we need to consult
jump history. If it's empty or contain a single record "bridging" parent
state and first instruction of processed state, then we indeed
backtracked all instructions in this state. But if history is not empty,
we are definitely not done yet.

Move this logic inside get_prev_insn_idx() to contain it more nicely.
Use -ENOENT return code to denote "we are out of instructions"
situation.

This bug was exposed by verifier_loop1.c's bounded_recursion subtest, once
the next fix in this patch set is applied.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Fixes: b5dc0163d8fd ("bpf: precise scalar_value tracking")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20231110002638.4168352-3-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/bpf/verifier.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e6d50e371a2b8..75251870430e4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1796,12 +1796,29 @@ static int push_jmp_history(struct bpf_verifier_env *env,
 
 /* Backtrack one insn at a time. If idx is not at the top of recorded
  * history then previous instruction came from straight line execution.
+ * Return -ENOENT if we exhausted all instructions within given state.
+ *
+ * It's legal to have a bit of a looping with the same starting and ending
+ * insn index within the same state, e.g.: 3->4->5->3, so just because current
+ * instruction index is the same as state's first_idx doesn't mean we are
+ * done. If there is still some jump history left, we should keep going. We
+ * need to take into account that we might have a jump history between given
+ * state's parent and itself, due to checkpointing. In this case, we'll have
+ * history entry recording a jump from last instruction of parent state and
+ * first instruction of given state.
  */
 static int get_prev_insn_idx(struct bpf_verifier_state *st, int i,
 			     u32 *history)
 {
 	u32 cnt = *history;
 
+	if (i == st->first_insn_idx) {
+		if (cnt == 0)
+			return -ENOENT;
+		if (cnt == 1 && st->jmp_history[0].idx == i)
+			return -ENOENT;
+	}
+
 	if (cnt && st->jmp_history[cnt - 1].idx == i) {
 		i = st->jmp_history[cnt - 1].prev_idx;
 		(*history)--;
@@ -2269,9 +2286,9 @@ static int __mark_chain_precision(struct bpf_verifier_env *env, int frame, int r
 				 * Nothing to be tracked further in the parent state.
 				 */
 				return 0;
-			if (i == first_idx)
-				break;
 			i = get_prev_insn_idx(st, i, &history);
+			if (i == -ENOENT)
+				break;
 			if (i >= env->prog->len) {
 				/* This can happen if backtracking reached insn 0
 				 * and there are still reg_mask or stack_mask
-- 
2.39.5


