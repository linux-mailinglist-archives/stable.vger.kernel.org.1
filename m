Return-Path: <stable+bounces-225598-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMsXI8EmuGnhZgEAu9opvQ
	(envelope-from <stable+bounces-225598-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:50:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1415129CC46
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 16:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78415302A508
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 15:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77E33A1A5B;
	Mon, 16 Mar 2026 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TcOeR9Sg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5E13A0E93;
	Mon, 16 Mar 2026 15:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675896; cv=none; b=j89TY0Woxnhchvw9LmZiblkGHAdElB/kPN17/hPC3V7pwfjtr2lZWTWn9MR8EuErNIdXIlUYpz+zvAoWqxgDSVDBWy7OYTW1Lyvf5BwiHxCUH7bC1NIe5skSONd/i9TBDFjKSt3f0WVZ5/I8JHt1I0C+6rvr4+mGwqGXWtio/2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675896; c=relaxed/simple;
	bh=IH6hjF+pkW2zjrOcoLLUCtQbwyxCT8NByC78D6ekXco=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Oyma/DbF1xw0eDQ/lZ9DImZ5bgJrKmnKtKfSezv13JoQnIGvaWPFYR6Cm2E8fMHP+8gzdxInOqYPNHDYhz3yX0TgoH7tKl9WKM0id6mp49PCzEBaudWKURa+fT1EN/u4NkFbM9kDIb5BLzbW84vMlgXZ+jGccH4EojD7KFGwqyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TcOeR9Sg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE97C19421;
	Mon, 16 Mar 2026 15:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773675896;
	bh=IH6hjF+pkW2zjrOcoLLUCtQbwyxCT8NByC78D6ekXco=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TcOeR9SgSAlkVmfMXk8wAz1W+adrhixRO9ilx9mDNYkqKasT0/37suCzyVn5arpef
	 8+axpziHyVNvrp8vMNMQTmTnKkwlsFNtb2TmxOlNa4WXFUg4R0IPHS7CHZvX2eRlfb
	 vnib7BcfwcCG2CaM+sGH5qQT9iRVVwlx83jDrY7I=
Date: Mon, 16 Mar 2026 08:44:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, Suren Baghdasaryan
 <surenb@google.com>, "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Qi
 Zheng <zhengqi.arch@bytedance.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] riscv: mm: add null check for find_vm_area in
 __set_memory
Message-Id: <20260316084455.bb44dd7baa47487f1e567ce9@linux-foundation.org>
In-Reply-To: <20260316151642.13738-1-osama.abdelkader@gmail.com>
References: <20260316151642.13738-1-osama.abdelkader@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-225598-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1415129CC46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 16:16:39 +0100 Osama Abdelkader <osama.abdelkader@gmail.com> wrote:

> find_vm_area() can return NULL. Add a null check to avoid potential
> null pointer dereference, matching the pattern used by other arches.
> 
> Fixes: 311cd2f6e253 ("riscv: Fix set_memory_XX() and set_direct_map_XX() by splitting huge linear mappings")

Three years ago.

> Cc: stable@vger.kernel.org

Why cc:stable?  Has anyone ever hit this?  Are we able to identify a
scenario where this bug might be triggered?

> --- a/arch/riscv/mm/pageattr.c
> +++ b/arch/riscv/mm/pageattr.c
> @@ -289,6 +289,10 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
>  		int i, page_start;
>  
>  		area = find_vm_area((void *)start);
> +		if (!area) {
> +			ret = -EINVAL;
> +			goto unlock;
> +		}
>  		page_start = (start - (unsigned long)area->addr) >> PAGE_SHIFT;
>  
>  		for (i = page_start; i < page_start + numpages; ++i) {
> -- 
> 2.43.0

