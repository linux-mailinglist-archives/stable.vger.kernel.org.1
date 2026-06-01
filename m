Return-Path: <stable+bounces-259642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGcXL17MHWrHeQkAu9opvQ
	(envelope-from <stable+bounces-259642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 20:15:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CABDD623D3C
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 20:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40FFA3014A14
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 18:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B2F3E1718;
	Mon,  1 Jun 2026 18:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZpNh+px"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DE62D9EFB;
	Mon,  1 Jun 2026 18:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337169; cv=none; b=u6VompFcegsDQBNTfAPZ8w3AgBOIj5Sw6jWh5dLwgQocfBhYCccugl/Z2L/CoxHmv3sEtAENhWPbR3WvARzo+DyRYjrjSfJTAOHzyiVCiAiP+FHnQtukyPpzFLZ0R627RPo+uP7TjkdR1qgPzBYvkt53vuzierakUrvrdCl4d0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337169; c=relaxed/simple;
	bh=y8b8cdu75Vz6SQYYvSK1vHmq/Yl9xle2fQvD2+pPBqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQMjYmlK0VC0RrvPX7Z60vvrdyvFh01GOOXy+2EPOJJCnMtjHIIaoOJ+0oDqrp4l9/BEiv+ee3a6Dx8JXFdxJcRdtPgOH7rFdlpyA/S5lVeZMgPuy6bKvtt9LeM8fsWRsD57YnUUusR62GowKTmNbdirSsiZCeCsn6mzQlDDBX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZpNh+px; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48B1F1F00898;
	Mon,  1 Jun 2026 18:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780337168;
	bh=MPIfI9k2oAu7CLM7hdDN2drmWMIEsFegPNxwh6nEkHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GZpNh+pxAYEE2fyC60cEj1j/k/7WKOtv6elnviyPut51Cp3Bwg83O+8rFr+aw9//L
	 NUHhdBp+BdH0mdlnvLB3IXWW/SAasUb2Iz+wEjh+MA2eQbSqqwQ6qIVMFjzyzVAwGi
	 PtdtKFQaS6HeqTCYPfjQo3NlXgFy7YTAuWzQbVxPiY81kZRB9ue35+nKj2rNQxSeFJ
	 Eux/po7Go3RMxO2L8q38ORR/f3OzfWHqdETnIoOrZT0ssYSDchjxlUOpqRRgxo7mbL
	 SPWstnIweCSymw20ncdWUtJY9Vov2pU3k8KWH2TAqYnsRNhuL+fWIncxX3D77zDEQ/
	 /WOzowHtk1QXg==
Date: Mon, 1 Jun 2026 19:06:02 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>, 
	David Hildenbrand <david@kernel.org>, stable@vger.kernel.org, 
	Sashiko AI review <sashiko-bot@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Andrei Vagin <avagin@gmail.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/6] fs/proc/task_mmu: use huge_page_size() in
 pagemap_scan_hugetlb_entry()
Message-ID: <ah3J7SHzUajlY5rA@lucifer>
References: <20260529172331.356655-1-kas@kernel.org>
 <20260529172331.356655-3-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529172331.356655-3-kas@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259642-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kvack.org,vger.kernel.org,kernel.org,infradead.org,google.com,suse.de,rere.qmqm.pl,arm.com,arndb.de,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CABDD623D3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 06:23:26PM +0100, Kiryl Shutsemau (Meta) wrote:
> The partial-page check compares against HPAGE_SIZE (PMD_SIZE), which
> is wrong for gigantic hugetlb hstates (e.g. 1G). The walker hands the
> callback a huge_page_size()-sized range, never start + HPAGE_SIZE, so
> the comparison always declares it partial and aborts the WP. Compare
> against the actual hstate's page size.
>
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

> ---
>  fs/proc/task_mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index e21a38ac745b..1489c67e88f7 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -2960,7 +2960,7 @@ static int pagemap_scan_hugetlb_entry(pte_t *ptep, unsigned long hmask,
>  	if (~categories & PAGE_IS_WRITTEN)
>  		goto out_unlock;
>
> -	if (end != start + HPAGE_SIZE) {
> +	if (end != start + huge_page_size(hstate_vma(vma))) {
>  		/* Partial HugeTLB page WP isn't possible. */
>  		pagemap_scan_backout_range(p, start, end);
>  		p->arg.walk_end = start;
> --
> 2.54.0
>

