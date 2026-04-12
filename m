Return-Path: <stable+bounces-235843-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yg/CGuvh22krIQkAu9opvQ
	(envelope-from <stable+bounces-235843-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 20:18:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F893E55CC
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 20:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E61B3002B3D
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 18:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A60B3624CC;
	Sun, 12 Apr 2026 18:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Nk+5ppuS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E7326A08F;
	Sun, 12 Apr 2026 18:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776017893; cv=none; b=BzlF1HD9AEWWi0CYW4JKQsWyZNdKsbWcp8TZHOY2PX0BuZYWJnjlU5TlqnqPsqQB47alsDPBpeSyQB68BXMG6lpkw1/6fhTjjuMDbRzT8xdPH+9bGZBJ+w5BwYFiLRQaxM0bD7DFmKPOOSHEOQcEt7KOfOYWYWnPgIUZUOdHhL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776017893; c=relaxed/simple;
	bh=m1HogzxVR1Ef4cOOJK5L0Qa1mWVjgFEef8ioM1/IH7M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CqJGLzz7F0wAiYd8oyrYtaFcs+W5xDm4kgECPOawdZ6WUwbMIaYSZhVmsgbOze901th1lnQ5z/el6U5vRnSiwSoF1Cbm0kbIj9RnnmvPIHiiyArShEUBW4UHTxl693oNMlX8fK31GYGXVfqgrj/FPopb78WOX81SjM24UF//r9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Nk+5ppuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258D1C19424;
	Sun, 12 Apr 2026 18:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1776017893;
	bh=m1HogzxVR1Ef4cOOJK5L0Qa1mWVjgFEef8ioM1/IH7M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nk+5ppuSiTQeOq2FwCiWUDwzwb6fS2FZt8aspI2LcvNSvaBff1TbkFAbLbyo87Ij0
	 D9NvS+5xY6CReMsm/7eZmA5kqhh8ogR4ISpfEG2oA4RmZyi/wE4L2lBdhzkaRNd0N6
	 2zpiR/sjIb4YnbRapqjHmXNpLVonvjQOFORS5VUg=
Date: Sun, 12 Apr 2026 11:18:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 rppt@kernel.org, peterx@redhat.com, surenb@google.com, aarcange@redhat.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: preserve write protection across
 UFFDIO_MOVE
Message-Id: <20260412111807.42c3edf86d19528d7cb1bb7b@linux-foundation.org>
In-Reply-To: <20260409152822.1073083-1-gourry@gourry.net>
References: <20260409152822.1073083-1-gourry@gourry.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235843-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E9F893E55CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu,  9 Apr 2026 11:28:22 -0400 Gregory Price <gourry@gourry.net> wrote:

> move_present_ptes() unconditionally makes the destination PTE writable,
> dropping uffd-wp write-protection from the source PTE.
> 
> The original intent was to follow mremap() behavior, but mremap()'s
> move_ptes() preserves the source write state unconditionally.
> 
> Modify uffd to preserve the source write state and check the uffd-wp
> condition of the source before setting writable on the destination.

Please can we have a description of the userspace-visible impact of the
bug.

> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Cc: stable@vger.kernel.org

especially when cc:stable, thanks.

> Signed-off-by: Gregory Price <gourry@gourry.net>
>
> ...
>
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -1123,7 +1123,10 @@ static long move_present_ptes(struct mm_struct *mm,
>  			orig_dst_pte = pte_mksoft_dirty(orig_dst_pte);
>  		if (pte_dirty(orig_src_pte))
>  			orig_dst_pte = pte_mkdirty(orig_dst_pte);
> -		orig_dst_pte = pte_mkwrite(orig_dst_pte, dst_vma);
> +		if (pte_write(orig_src_pte))
> +			orig_dst_pte = pte_mkwrite(orig_dst_pte, dst_vma);
> +		if (pte_uffd_wp(orig_src_pte))
> +			orig_dst_pte = pte_mkuffd_wp(orig_dst_pte);
>  		set_pte_at(mm, dst_addr, dst_pte, orig_dst_pte);
>  

(presently wondering if this is backward compatible)

