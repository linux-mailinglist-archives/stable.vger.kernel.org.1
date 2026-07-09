Return-Path: <stable+bounces-272778-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YETBB0T4TmoTYAIAu9opvQ
	(envelope-from <stable+bounces-272778-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 03:24:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B57072BAAB
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 03:24:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=w28TomuM;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272778-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272778-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D99B830134B2
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 01:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731EB38E8AC;
	Thu,  9 Jul 2026 01:22:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156A2389DF0
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 01:22:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783560166; cv=none; b=AJteQwPh77L7k6uhyMk3SR9ALykJ1c2/vdHNt/ZrX6FoaUYFHq/lHqAxEK5w0ys9DRuPnfc443uaz210ofOvkLiRalzCt0+fXf0HLvnFQo7TMG2e1vjNxq+C+/lLeDKkMfAktbkg21SVCQI5ibuyDfUBB7L3sA605eQKfCvcvo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783560166; c=relaxed/simple;
	bh=M9tQ59gdCIMG5lI+Fdf2WAqDr2TWJKOqyav1e5ga+o8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SkoQb77oeliTdylFYinORazwynq3cf4sdXv2PyXKZAulm5yb3x+sERXLwZTtxhK2imOlvzzpfHPnZh6/fS6z/bnYwsofJG7R3cBvufKGTE/R7YSeiia3XnKbB33xQfpJVoGsZ8Yd59Gd1m8ylvoanU4LyZX3yWIl20dPq7vRkZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w28TomuM; arc=none smtp.client-ip=91.218.175.184
Message-ID: <d4af0c54-3bd6-401c-905a-ce546f2da475@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783560162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WP5VJ41f/odwMRot0Mx2KzzrsSJNLef7CDVaENhJTWc=;
	b=w28TomuMW/Yp4z6VgP+9xOE0Zm1dG0n+iN6z9+o1mdlhwJHgFL43HE9PJYYAROJmLTXogJ
	wt7bqRbYeywVudFFakBghqpbDB40d8rZDSewbuwHq0QeKGMzA0rNmr10R5xNxAjXZ0Q8rc
	u05rfzdyT7YNE1LSq/CumVyIFYQ/kdw=
Date: Wed, 8 Jul 2026 18:22:32 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: fix responder UAF on IB_QP_MAX_DEST_RD_ATOMIC
 modify_qp
To: Ibrahim Hashimov <security@auditcode.ai>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260708224550.1281-1-security@auditcode.ai>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260708224550.1281-1-security@auditcode.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272778-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[auditcode.ai,gmail.com,ziepe.ca,kernel.org,linux.dev];
	FORGED_SENDER(0.00)[yanjun.zhu@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:security@auditcode.ai,m:zyjzyj2000@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:yanjun.zhu@linux.dev,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,auditcode.ai:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B57072BAAB

On 7/8/26 3:45 PM, Ibrahim Hashimov wrote:
> rxe_qp_from_attr()'s IB_QP_MAX_DEST_RD_ATOMIC branch frees and
> reallocates qp->resp.resources[] (the rd_atomic resource array used by
> the responder to track in-flight RDMA READ/ATOMIC/FLUSH requests)
> completely outside of the IB_QP_STATE handling above it. Unlike every
> other place that tears this array down -- rxe_qp_reset(), reached only
> under IB_QP_STATE, always calls rxe_disable_task(&qp->recv_task) /
> rxe_disable_task(&qp->send_task) to drain the responder and requester
> tasks before touching per-QP state, then re-enables them -- this branch
> runs with the responder task (rxe_receiver(), scheduled as recv_task on
> the rxe_wq workqueue) fully live and unlocked. A userspace modify_qp()
> that sets only IB_QP_MAX_DEST_RD_ATOMIC (no state change, so
> __qp_chk_state()/ib_modify_qp_is_ok() never runs and qp->state_lock is
> never taken here) can therefore race the responder in two ways:
> 
>   1. free_rd_atomic_resources() calls kfree(qp->resp.resources) and
>      alloc_rd_atomic_resources() kzalloc_objs()'s a new array while
>      rxe_prepare_res()/find_resource() in rxe_resp.c are concurrently
>      walking &qp->resp.resources[i] with no lock held -- a straight
>      free-vs-read race on the array itself.
> 
>   2. free_rd_atomic_resources() only NULLs qp->resp.resources; it never
>      clears qp->resp.res, the raw pointer *into* that array that
>      rxe_resp.c caches across a multi-packet RDMA READ/ATOMIC/FLUSH
>      reply (set at rxe_resp.c read/atomic/flush-reply sites, cleared
>      only on the normal completion paths). If a modify_qp() races a
>      resource still referenced by qp->resp.res, the array is freed out
>      from under the cached pointer and the next reply packet dereferences
>      it -- independent of the kfree/kzalloc_objs() window in (1).
> 
> Reproduced with KASAN: a single process driving one RC QP pair in rxe
> loopback, one thread pumping large multi-packet IBV_WR_RDMA_READs
> against qpB while a second thread hammers
> ibv_modify_qp(qpB, IB_QP_MAX_DEST_RD_ATOMIC), reliably (~11s) produces
> 
>    BUG: KASAN: slab-use-after-free in rxe_receiver+0x4f78/0x89e0 [rdma_rxe]
>    Workqueue: rxe_wq do_work [rdma_rxe]

Can you share all the stack trace with us? Thanks a lot.

> 
> with the freed kmalloc-1k object being the rd_atomic resource array
> freed by the modify_qp() thread while the recv_task kworker reads it.
> An identical run modifying only IB_QP_MIN_RNR_TIMER (no resource free)
> is clean.
> 
> Fix both races the same way rxe_qp_reset() already handles tearing down
> this exact array: quiesce the responder task around the free/realloc by
> calling rxe_disable_task(&qp->recv_task) before free_rd_atomic_resources()
> and rxe_enable_task(&qp->recv_task) after alloc_rd_atomic_resources(),
> so rxe_receiver() cannot observe the array mid-free/mid-realloc. And
> close the still-open window for (2) at the source: have
> free_rd_atomic_resources() clear qp->resp.res along with
> qp->resp.resources, exactly like the existing completion paths in
> rxe_resp.c (check_rkey()/duplicate_request()/RESPST_CLEANUP) already do
> when a resource's lifetime ends, so a drained-and-resumed responder
> restarts at RESPST_CHK_PSN against the fresh array instead of replaying
> a stale reference into the old one.
> 
> Only qp->recv_task is drained: qp->resp.resources / qp->resp.res are
> touched exclusively by the responder (rxe_resp.c); the requester
> (send_task / rxe_sender()) never reads them, so there is no need to
> widen this beyond what rxe_qp_reset() would drain for the equivalent
> state.
> 
> Verified on the same v6.19 KASAN stand: with this fix applied, the
> identical differential reproducer drives sustained MAX_DEST_RD_ATOMIC
> storms against qpB well past the ~11s pre-fix time-to-first-splat with
> zero KASAN reports, versus reliably tripping the slab-use-after-free in
> rxe_receiver() described above before the fix.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> Assisted-by: AuditCode-AI:2026.07
> ---
>   drivers/infiniband/sw/rxe/rxe_qp.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index f3dff1aea96a..646957707765 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -172,6 +172,7 @@ static void free_rd_atomic_resources(struct rxe_qp *qp)
>   		}
>   		kfree(qp->resp.resources);
>   		qp->resp.resources = NULL;
> +		qp->resp.res = NULL;
>   	}
>   }
>   
> @@ -709,9 +710,15 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
>   
>   		qp->attr.max_dest_rd_atomic = max_dest_rd_atomic;
>   
> +		/*
> +		 * Not gated by IB_QP_STATE above: quiesce the responder task
> +		 * the same way rxe_qp_reset() does before touching this
> +		 * array, so rxe_receiver() can't race the free/realloc.
> +		 */
> +		rxe_disable_task(&qp->recv_task);
>   		free_rd_atomic_resources(qp);
> -
>   		err = alloc_rd_atomic_resources(qp, max_dest_rd_atomic);
> +		rxe_enable_task(&qp->recv_task);

If alloc_rd_atomic_resources fails, that is, qp->resp.resources is NULL.
After rxe_enable_task(&qp->recv_task);  qp->resp.resources(NULL) will be 
used in resp. This will cause problems.

drivers/infiniband/sw/rxe/rxe_resp.c:656:	res = 
&qp->resp.resources[qp->resp.res_head];
drivers/infiniband/sw/rxe/rxe_resp.c:1325:		struct resp_res *res = 
&qp->resp.resources[i];

Zhu Yanjun

>   		if (err)
>   			return err;
>   	}


