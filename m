Return-Path: <stable+bounces-244835-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E+CKd5a/mkWpgAAu9opvQ
	(envelope-from <stable+bounces-244835-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 23:51:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D374FC0F3
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 23:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85AE1301A3AD
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 21:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5429C312803;
	Fri,  8 May 2026 21:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WmGqQ8vj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A57306D26
	for <stable@vger.kernel.org>; Fri,  8 May 2026 21:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778277083; cv=none; b=GdImAnNMD/S0gvdgktSDi6xZU6nUZoXBBGdpj2+6mOFWWwe7BSpJlKaPMOv2lhIzM+JnwTljc6gS1YvprW4aBv7Q/YjIH/tvOONSflWSVHzJrzfD7/FwF6hLz3arekfajodHLsLc1sVkAp3tZ9mrH+Ujzpntw2RR6wnVnAdWqug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778277083; c=relaxed/simple;
	bh=C9QhXNau5H10Vsv2I9QSQcs5z5pQXQI4hTBlKbEYUdM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qRi9lsRbREniNH6a3kl242VlQoFuMtRODaDBrtSz9wKY8pIYeQFXitu5QAtR/g6dWX+g76QjEK5fKYO/LWd4QtOugmYS/36QTxvBKnPMvo5UEYKl6g/s3xnq6aFwp+v2WDnJ2FsPFNBDf81hZUe/02uL79KrenKur6crDSuo+UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WmGqQ8vj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35131C2BCB0;
	Fri,  8 May 2026 21:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1778277082;
	bh=C9QhXNau5H10Vsv2I9QSQcs5z5pQXQI4hTBlKbEYUdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WmGqQ8vjDV4ZvaVH0iE/01aNlECAJH5GwTvX/6N/C9UCOON+ZhEYc3GRFoVdtqlVP
	 Pe+U4KcjjA2eNCttCtcX40ltu8dhR7FldWOGqSFoLE1Y5FpKD43ejXBYFmSltjxCVA
	 Qhd2mi7zwjvAAky8ZGiu9TKD+Qp1A66NHbqKgQRY=
Date: Fri, 8 May 2026 14:51:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: david@kernel.org, ljs@kernel.org, riel@surriel.com, liam@infradead.org,
 vbabka@kernel.org, harry@kernel.org, jannh@google.com, sj@kernel.org,
 ziy@nvidia.com, balbirs@nvidia.com, linux-mm@kvack.org, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-Id: <20260508145121.35e2552d403b94ea6f748b90@linux-foundation.org>
In-Reply-To: <20260508013728.21285-1-richard.weiyang@gmail.com>
References: <20260508013728.21285-1-richard.weiyang@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 01D374FC0F3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-244835-lists,stable=lfdr.de];
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
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri,  8 May 2026 01:37:28 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:

> For pmd_trans_huge() and pmd_is_migration_entry(), we does following
> before return the pmd entry:
> 
>   * re-validate pmd entry
>   * check PVMW_MIGRATION
>   * check_pmd()
>   * handle on pte level if split under us
> 
> But for device-private pmd, we just return after pmd_lock(). This may
> lead to inproper situation.

What is "improper situation"?

> This patch fixes commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration
> support device-private entries") by following the same pattern as
> pmd_trans_huge() and pmd_is_migration_entry().
> 
> Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Balbir Singh <balbirs@nvidia.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: <stable@vger.kernel.org>

If we're to propose a fix for -stable backporting I believe we should
fully explain to -stable maintainers *why* we're making that proposal.

IOW, and not for the first time(!), what are the worst-case
userspace-visible effects of this bug?



