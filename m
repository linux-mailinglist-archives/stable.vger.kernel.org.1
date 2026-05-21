Return-Path: <stable+bounces-253611-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD2qISY2D2qSHgYAu9opvQ
	(envelope-from <stable+bounces-253611-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:43:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DC55A97F2
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC15F3307A0D
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E81333A6E2;
	Thu, 21 May 2026 15:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SnS/4I5+"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B180024A06A
	for <stable@vger.kernel.org>; Thu, 21 May 2026 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378378; cv=none; b=na6YPa8lNTUQbsGSvYkwBmQbFBhsnLWD2uKOW/H0SQt7kDeM9wewF/IfoB5SYOjx+hX18nmXytUzbwOYfRoVI15K5An0JX3SZ5QiNz3zMhuPkjr9r21lxny5t4htLT2tMsgWd+3YNT+n41Becl8R2ij2knou+Jk2seNKvXPUv2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378378; c=relaxed/simple;
	bh=jc95M8tf1w7i6e3dGF4eV1p/aNTxU2U9gxoZm7w9/a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+mYBr2xtn9Ix4gbNdQHr69LpMLag9G+RNpDmfb3JR43JpJ9MAECIVwS4tiO8AZjat6rbwWWCzG1RPHo6eB3AOTApk71N3PFFWCHDJZEkSsMxKIzNaVB5GhSPAAhTdblD8DHeEVkpt7GqrULHfmgzayPZBG1Y2QPx6RPESkmxks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SnS/4I5+; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ac887af5-3d05-4f5b-910b-a2aa68a9cc7a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779378372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lZWk7SbAn/FMyo/jLJJgKY0cR2G1OfggAeZAYnfwfhE=;
	b=SnS/4I5+JPmj+/LCeKwQUbhw0aHMyVAy5h1VtEsCyXLTF/cTvhYBaH15CpJMXwHhj9Qumh
	UvQyd5tCfe+CcCC/MDn4H96WpZTkoM+ytCFdzqBgIdSlS/n+dFfIxQkMI4CFuJbrVye+bU
	hO2nTHirlHucgQBAxK4NOH/QC07cM+k=
Date: Thu, 21 May 2026 08:46:07 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] RDMA/rxe: Fix u64 iova-overflow family in
 MR/ODP/RESP/MW paths
To: Tymbark7372 <tymbark7372@proton.me>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "leonro@nvidia.com" <leonro@nvidia.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <GmtGfyiQI2c4YxeWS7woOgXgSEajslDC8awnuf_4qoOJJqg9XR_fzYq1AbkS9jp10kWIArTMsMRAu7rg9lgK3nKuWILBpSaJhFV7i_0-yXo=@proton.me>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <GmtGfyiQI2c4YxeWS7woOgXgSEajslDC8awnuf_4qoOJJqg9XR_fzYq1AbkS9jp10kWIArTMsMRAu7rg9lgK3nKuWILBpSaJhFV7i_0-yXo=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253611-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,proton.me:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 98DC55A97F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

在 2026/5/21 8:39, Tymbark7372 写道:
> This series fixes a family of u64 overflow bugs in the rxe Soft-RoCE
> driver.  All four sites share one root cause: addition of an
> attacker-influenced iova/addr (u64) with an attacker-influenced
> length/resid (size_t/u32/int promoted to u64), without overflow
> check, leading to an OOB read/write primitive in the rxe responder
> workqueue.
> 
> I originally reported these to security@kernel.org.  Jason Gunthorpe
> confirmed that rxe and siw are development-only drivers without
> embargo handling and asked me to send patches publicly, so this
> series follows that direction.  security@kernel.org is intentionally
> not in Cc per Jason's instruction.
> 
> Patches:
> 
>    1/4: rxe_mr.c mr_check_range
>         The USER/MEM_REG case computes iova + length and compares to
>         mr->ibmr.iova + mr->ibmr.length.  Both additions wrap in u64.
>         Use check_add_overflow() for both ends.
> 
>    2/4: rxe_odp.c rxe_check_pagefault
>         Loop condition addr < iova + length wraps when iova is near
>         U64_MAX and length is positive.  Compute iova_end with
>         check_add_overflow() once and use it in the loop condition.
> 
>    3/4: rxe_resp.c duplicate_request
>         Third clause iova + resid > res->read.va_org + res->read.length
>         has u64 wrap on both sides.  Use check_add_overflow() for both
>         ends.  (Site A in check_rkey, also in rxe_resp.c, calls into
>         mr_check_range and is closed by patch 1.)
> 
>    4/4: rxe_mw.c rxe_check_bind_mw
>         Same wrap class as patch 1.  Found by sibling-site grep; not on
>         the OOB-write path of the three primary bugs but a
>         structurally-identical u64 wrap that would let an attacker bind
>         a memory window outside its parent MR's range.
> 
> Verification:
> 
> Each of the three primary sibling triggers (patches 1, 2, 3) has been
> exercised on v7.1.0-rc3 + KASAN in QEMU as the OOB-write case.
> Patches 1 and 3 produce a single-page-fault Oops in rxe_mr_copy after
> the wrap.  Patch 2 produces a single-page-fault Oops in
> rxe_odp_mr_copy.  All three are triggered by a single ibv_post_send
> from an unprivileged local user with /dev/infiniband/uverbs0 open.
> A working LPE exploit demonstrated end-to-end privilege escalation
> via the rxe_odp path under the verification config (KASAN dev-build,
> selinux=0, nokaslr).  Full PoC and writeup were attached to the
> original security@kernel.org submission.
> 
> After applying all four patches, the same triggers no longer fire;
> the wrap checks correctly reject the attacker iova.  Re-tested in the
> same QEMU+KASAN configuration.
> 
> The trigger PoCs are simple libibverbs programs (one per sibling)
> that I am happy to provide on request.
> 
> Fixes / stable:
> 
>    1/4: Fixes 8700e3e7c485 ("Soft RoCE driver"), v4.8+
>    2/4: Fixes 2fae67ab63db ("RDMA/rxe: Add support for Send/Recv/Write/Read with ODP"), v6.15+
>    3/4: Fixes 8700e3e7c485 ("Soft RoCE driver"), v4.8+
>    4/4: Fixes 8700e3e7c485 ("Soft RoCE driver"), v4.8+
> 
> Pre-f04d5b3d916c LTS branches carry the older wrap form
>    iova > mr->ibmr.iova + mr->ibmr.length - length
> instead of the current `iova + length > ...` shape.  Patches 1, 3, 4
> will need a backport variant for those branches; I can provide on
> request.
> 
> Tymbark7372 (4):
>    RDMA/rxe: Fix u64 iova+length overflow in mr_check_range
>    RDMA/rxe: Fix u64 iova+length overflow in rxe_check_pagefault
>    RDMA/rxe: Fix u64 iova+resid overflow in duplicate_request
>    RDMA/rxe: Fix u64 addr+length overflow in rxe_check_bind_mw

To be honest, please do not send the commits with the attachment.

Normally, use the command to send several commits: git send-email 
001xxx.patch 002xxx.patch 003xxx.patch ... --to xxx --to xxx

Zhu Yanjun

> 
>   drivers/infiniband/sw/rxe/rxe_mr.c   | 12 +++++++++---
>   drivers/infiniband/sw/rxe/rxe_odp.c  | 10 ++++++++--
>   drivers/infiniband/sw/rxe/rxe_resp.c | 11 ++++++++---
>   drivers/infiniband/sw/rxe/rxe_mw.c   | 11 ++++++++---
>   4 files changed, 33 insertions(+), 11 deletions(-)
> 
> --
> Tymbark7372 <tymbark7372@proton.me>


