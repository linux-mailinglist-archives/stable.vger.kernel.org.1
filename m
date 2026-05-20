Return-Path: <stable+bounces-249757-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJW8CaNSDWqgvwUAu9opvQ
	(envelope-from <stable+bounces-249757-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 08:20:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7522D58813E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 08:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFD0D3038C63
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 06:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CDA30CDB6;
	Wed, 20 May 2026 06:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hy47G6KX"
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E65C2F3C3E
	for <stable@vger.kernel.org>; Wed, 20 May 2026 06:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779257829; cv=none; b=LxI9rUvvxAUsjpriJkxn40IlGXRltdCR+tGewMH0kFa+olzuduUiJxxJ3FS7Y1q/yN5Zc4l9xZEa4T5EjK7N7yAx12JsFKxWoOMz3ojBOsbtUaSJ3sEjw5y4JlgcNWPCX/DwjwWgBYYp0hlV9NGogBGE0NqF1UsSpqsrKnB0+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779257829; c=relaxed/simple;
	bh=hH6UERnyWAOkGelJXDPeaNa6VtwgwWte4hecOa/8dgA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fkdsyv/aB2mgxZB1B/1c4ywyFejIY26t6L6GkGPZW5iF7F4qY729xv/MELIyopptLt2XyFYlvT93Y669CjTFuH0tdNvQ+SAqX3JPgiP+0cmMt/DIRPFTXCN+u74SG15eII7ecK2DuOFCYIYCzSB6TaQFaUnBwaT2TkqNB4Iqwvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hy47G6KX; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779257815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sp2pJ+82XHyKehOHniPHwM9kegm9WKiZRGipSAFGfRU=;
	b=hy47G6KXzrCGiCNcSHgbc/erLXASNRjikzSb1Zx4XJo3mU2UlRDtXANw3L+qlTCLFz6LQJ
	lvHczjf3rHYuF/wOTg990Pn8owSdQba9VFWJaP3f7XAGn4sw/ayhKhTKhGwhccHGEicS4G
	9Cl2k8QJfc3hQ4GtG8sEC2ZyzE77cXg=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v3] mm/hugetlb: restore reservation on error in hugetlb
 folio copy paths
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260520044912.6751-1-devnexen@gmail.com>
Date: Wed, 20 May 2026 14:16:07 +0800
Cc: akpm@linux-foundation.org,
 david@kernel.org,
 almasrymina@google.com,
 osalvador@suse.de,
 yuehaibing@huawei.com,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B3586132-590D-4472-8A4D-A76B0DA9E105@linux.dev>
References: <20260519230503.121293-1-devnexen@gmail.com>
 <20260520044912.6751-1-devnexen@gmail.com>
To: David Carlier <devnexen@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249757-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 7522D58813E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> On May 20, 2026, at 12:49, David Carlier <devnexen@gmail.com> wrote:
>=20
> Two sites in mm/hugetlb.c allocate a hugetlb folio via
> alloc_hugetlb_folio() (consuming a VMA reservation) and then call
> copy_user_large_folio(), which became int-returning in commit
> 1cb9dc4b475c ("mm: hwpoison: support recovery from HugePage
> copy-on-write faults") and can now fail (e.g. -EHWPOISON on a
> hwpoisoned source page). On the failure path, folio_put() restores
> the global hugetlb pool count through free_huge_folio(), but the
> per-VMA reservation map entry is left marked consumed:
>=20
>  - hugetlb_mfill_atomic_pte() resubmission path (UFFDIO_COPY)
>  - copy_hugetlb_page_range() fork-time CoW path when
>    hugetlb_try_dup_anon_rmap() fails (rare: pinned hugetlb anon
>    folio under fork)
>=20
> User-visible effect: on UFFDIO_COPY into a private hugetlb VMA where
> the resubmission copy fails, the reservation for that address is
> leaked from the VMA's reserve map. A subsequent fault at the same
> address takes the no-reservation path, and under hugetlb pool
> pressure the task is SIGBUSed at an address it had previously
> reserved. The fork-time CoW path leaks the same way in the child
> VMA's reserve map, though it requires the much rarer combination
> of pinned hugetlb anon page + hwpoisoned source.
>=20
> Add the missing restore_reserve_on_error() call before folio_put()
> on both error paths.
>=20
> Fixes: 1cb9dc4b475c ("mm: hwpoison: support recovery from HugePage =
copy-on-write faults")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: David Carlier <devnexen@gmail.com>

Reviewed-by: Muchun Song <muchun.song@linux.dev>

Thanks.


