Return-Path: <stable+bounces-254304-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PPQKk56FWp8VgcAu9opvQ
	(envelope-from <stable+bounces-254304-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:47:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC455D45CF
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB41C3028F72
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B5C3DDDA1;
	Tue, 26 May 2026 10:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKQNMi+d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2423D75DC;
	Tue, 26 May 2026 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779792459; cv=none; b=JYYsh3UlA6FBeE3qnC2c5vtb/Wjin9p43fZGjp4Mu0FRk56JfRQDkpgJbhlcvDOgI3MddW4g75J2sQVQptc65WOiFETsH/Xsw0+zSrwkMLpCVxKKbviQ17PAW+V/KgC/G4/k2gk4Y/uXBxgO+Vk86SPndFDgzNYzHfbZfAHL7EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779792459; c=relaxed/simple;
	bh=GdJwaj9SIEMz9GzHUvvOj5WuquDL+OnfGmMGvDx8i1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwIfaa/xSDIuFpWfdiwFVgFw6OzvEwYFRoe0zv9bNayqzfoE0gB3B4TpX2w/wh5L5aq3u2mAlcvtXVAFdSXzxV+BebLnjUkYuQon4GGiobLl8yFB+4mSSlICHQcZf7Dtzea3ZGUzY4PAWaAnsbdZcWTbOko/txwgAw3zF0Cs8k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKQNMi+d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2417C1F000E9;
	Tue, 26 May 2026 10:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779792458;
	bh=RcmL+NENyll/pO8MenmBG7srmhHZmhOd06anio1GuLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HKQNMi+dRX+QuTlcnlyfpbp7zJPtm4qwGeff2d20aJu+Uo1SHuIIbuQziX/KxN4wt
	 jGw3idlDvZqXZ2Zj3aOa3Nt61A95qGStElxWtKDA3dVaICYFGlLodRi9PgFGoiwVDx
	 MZuMNu2UBVyL+N5HbY0tV/gHJ2S/RSmeNTOKIcXNRc0eBpEmqpEiqJrRqqKzqyzCru
	 Wkc9CIW50WeNFvZOY31pUOLgovg7hOSpXsnVefKAGtSVtunAGR+ee1URsVTlScxgxH
	 Ke5845psKJA4SnjApyZ4uY5P/qfjEQWKu5LvVzHncZsWVSK/igCRxcZKu3eUxE8YDR
	 0qILHktU6IXrA==
Date: Tue, 26 May 2026 11:47:31 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Yin Tirui <yintirui@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <liam@infradead.org>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Dan Williams <djbw@kernel.org>, Alistair Popple <apopple@nvidia.com>, wangkefeng.wang@huawei.com, 
	chenjun102@huawei.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: update file PUD counter before
 folio_put()
Message-ID: <ahV1WCxlXhOKfO_S@lucifer>
References: <20260526101355.1984244-1-yintirui@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526101355.1984244-1-yintirui@huawei.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254304-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:email]
X-Rspamd-Queue-Id: 3FC455D45CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

You sent this twice :)

On Tue, May 26, 2026 at 06:13:55PM +0800, Yin Tirui wrote:
> __split_huge_pud_locked() updates the file/shmem RSS counter after
> dropping the PUD mapping's folio reference. If folio_put() drops the
> last reference, mm_counter_file() can later read freed folio state via
> folio_test_swapbacked().
>
> Move the counter update before folio_put().
>
> Fixes: dbe54153296d ("mm/huge_memory: add vmf_insert_folio_pud()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Yin Tirui <yintirui@huawei.com>

Patch looks sane to me, so:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

There seems to be an identical problem in __split_huge_pmd_locked() - could you
do the same fix there?

Thanks, Lorenzo

> ---
>  mm/huge_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index a5f4a48b7b77..9832ee910d5e 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3027,9 +3027,9 @@ static void __split_huge_pud_locked(struct vm_area_struct *vma, pud_t *pud,
>  	if (!folio_test_referenced(folio) && pud_young(old_pud))
>  		folio_set_referenced(folio);
>  	folio_remove_rmap_pud(folio, page, vma);
> -	folio_put(folio);
>  	add_mm_counter(vma->vm_mm, mm_counter_file(folio),
>  		-HPAGE_PUD_NR);
> +	folio_put(folio);
>  }
>
>  void __split_huge_pud(struct vm_area_struct *vma, pud_t *pud,
> --
> 2.43.0
>

