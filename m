Return-Path: <stable+bounces-254628-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKGCHDIYF2px3wcAu9opvQ
	(envelope-from <stable+bounces-254628-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:13:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBFA5E78B8
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52E4C301AA90
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97AC382368;
	Wed, 27 May 2026 16:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPuOzV3i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5A93DD534;
	Wed, 27 May 2026 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898253; cv=none; b=g779ouzAYSb6yqJoN6ovH732mvlenR9nNIp2azj7fAMWh82Terh/yLCmn7Pszs0ty/7vUeTY4S2+ZAe2tyFQyV5qMxYb3MQRzkPDWj4HZawGDBrgMtutZ77MSBKTsQ/MCLsv68x202po6FkiHabevYc0SKNhaudf+tagswJpCJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898253; c=relaxed/simple;
	bh=CX3exghaEU7oijl4Qm+XajRGZGjWFznqdUxi59T5X4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdO1wWMOGK+ExmSvjFSoX+wzZCA3N8vT88MIg3NWtMKndQXu9pzDQIzn9cC4P8FSUuifDB02O5eQVcmePSuCKOFIS89rXbot0EqjrFZA/cA1tBaKlLdV8AFFIoxjNpIel3FIM2nYGmo/GXOp3iMvnUSFubmmR1Lv0RcEsENI820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPuOzV3i; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D101F000E9;
	Wed, 27 May 2026 16:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779898251;
	bh=CX3exghaEU7oijl4Qm+XajRGZGjWFznqdUxi59T5X4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MPuOzV3ikmn3ser1vdTu0I7pRDht3seabVH7Hg/9v9USEHiof8yUdQnShFjScSoTb
	 wdlaE+ErrX6xUpzLPhl9U+fXdVTfi0yRbZeC00fJS2ccPaDv0gMC5+6XhPblJ5PeS6
	 i+7lP7lyQ8xf17fO5n6Fk+MPMcTxWkgkfthrAyTYwzQja+or0O0RVqC2yaVkuPPHQS
	 3ScbA9+3q0nykiU5eDEWY+WnpI9zPngSRPNxobjR/zDfX+lBOmEpm4Xj/opPKsuM4s
	 sW5CviajEZlNQ2CHFGIvSbiwSzQdY5KFZ3qlNiC5BnbBRNa8LgJpKZGSN/u1OBCmAl
	 r7dqJXWThO+wg==
Date: Wed, 27 May 2026 17:10:43 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Yin Tirui <yintirui@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <liam@infradead.org>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Vlastimil Babka <vbabka@kernel.org>, Yang Shi <yang.shi@linux.alibaba.com>, 
	wangkefeng.wang@huawei.com, chenjun102@huawei.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: update file PMD counter before
 folio_put()
Message-ID: <ahcXZQCA0TsC1Qjc@lucifer>
References: <20260526101337.1984081-1-yintirui@huawei.com>
 <ahV8PuP2sg7fV_DR@lucifer>
 <58434ba7-78c8-44a5-8262-98fcaf131e6e@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58434ba7-78c8-44a5-8262-98fcaf131e6e@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-254628-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: DFBFA5E78B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 02:25:35PM +0200, David Hildenbrand (Arm) wrote:
> On 5/26/26 13:05, Lorenzo Stoakes wrote:
> > On Tue, May 26, 2026 at 06:13:37PM +0800, Yin Tirui wrote:
> >> __split_huge_pmd_locked() updates the file/shmem RSS counter after
> >> dropping the PMD mapping's folio reference. If folio_put() drops the
> >> last reference, mm_counter_file() can later read freed folio state via
> >> folio_test_swapbacked().
> >>
> >> Move the counter update before folio_put().
> >>
> >> Fixes: fadae2953072 ("thp: use mm_file_counter to determine update which rss counter")
> >
> > That's an old commit :) I mean I suspect we're probably not actually ever
> > dropping the folio ref to 0 here since we never had a report since ~2018.
> >
> > The page cache keeping a reference I guess?
>
> I assume we could be racing with truncation.
>
> Truncation would have to trigger unmap itself before we do the
> folio_remove_rmap_pmd().
>
> While the race could happen in theory I think, I do assume this would be rather
> hard to trigger.

Yeah, I mean unless we missed it somehow it seems like any such race if it
exists is very tiny.

But obviously we really do need to fix this! :)

>
> >
> > But doesn't mean we shouldn't fix this on principal/there being some way
> > this could happen.
> >
> >> Cc: <stable@vger.kernel.org>
> >> Signed-off-by: Yin Tirui <yintirui@huawei.com>
> >
> > LGTM, so:
> >
> > Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
>
> Acked-by: David Hildenbrand (arm) <david@kernel.org>
>
> --
> Cheers,
>
> David

Cheers, Lorenzo

