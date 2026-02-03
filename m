Return-Path: <stable+bounces-213152-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IyzDAd1fgWnfFwMAu9opvQ
	(envelope-from <stable+bounces-213152-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 03:39:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB75D3D00
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 03:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EADE3016C99
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 02:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F5530DEC6;
	Tue,  3 Feb 2026 02:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wIupbiN5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68782158535;
	Tue,  3 Feb 2026 02:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770086359; cv=none; b=GNGC1+zr8DHGzwcUeAI6Y1bCSsNPwRfuljX/tNGV82dY01NDJZxN+qldrKze9TMt8WIO1rlDbKIG/zx/UB9t9p6dVm2qychX+rwSduNCX8jlrOiXiZ6Mqu+rPlViTZulr2zF9uHVNg9m95FEq5oC72gg4WYPPANepFZddcDCIa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770086359; c=relaxed/simple;
	bh=PFouNFmJPcItJkoCjf2nW+gBfA1Uk2K5fhShN0MNegw=;
	h=Date:From:To:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HPl82D5dIXdHErDcZZOttOMV1yBD/rN27zIAB4+GaKkTeLCZqyB9arlH1rw81UOSjinNFFytaO8ytATBakGv0ncXJ2UV+4wbUopGElLc6vDYEOsDJ0LcytIEmYpxxmK+563G+VySNr2LjFTrHIoN+PPE3bzfLQPwY6aV73bMOYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wIupbiN5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9A9C19425;
	Tue,  3 Feb 2026 02:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1770086359;
	bh=PFouNFmJPcItJkoCjf2nW+gBfA1Uk2K5fhShN0MNegw=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=wIupbiN51G8pvhpGQEtZRLIGcxFA1YurL9mL8e+20w7tnXqaOn2GY8VihVfXh9HQx
	 u0BTBD/1GWs7VkQAjwe9tnM2Mvl2+wkI1HaekzWae1XaYUXoLMq+kR+MzT9sU6OkbP
	 9v4uevy6Zw0lZEmHCbh8/OunQ1Zn22Lu9ekbz6AE=
Date: Mon, 2 Feb 2026 18:39:18 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>, David Hildenbrand
 <david@kernel.org>, Muchun Song <muchun.song@linux.dev>, Oscar Salvador
 <osalvador@suse.de>, Wupeng Ma <mawupeng1@huawei.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH v2] mm/hugetlb: Restore failed global reservations to
 subpool
Message-Id: <20260202183918.057dac34b3a1819328814fc9@linux-foundation.org>
In-Reply-To: <20260121094754.8a30b7f7fcff34f579883e40@linux-foundation.org>
References: <20260116204037.2270096-1-joshua.hahnjy@gmail.com>
	<20260121094754.8a30b7f7fcff34f579883e40@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213152-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,linux.dev,suse.de,huawei.com,vger.kernel.org,kvack.org,meta.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email,linux-foundation.org:dkim,linux-foundation.org:mid]
X-Rspamd-Queue-Id: 4CB75D3D00
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 09:47:54 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 16 Jan 2026 15:40:36 -0500 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> 
> > Commit a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
> > fixed an underflow error for hstate->resv_huge_pages caused by
> > incorrectly attributing globally requested pages to the subpool's
> > reservation.
> > 
> > Unfortunately, this fix also introduced the opposite problem, which would
> > leave spool->used_hpages elevated if the globally requested pages could
> > not be acquired. This is because while a subpool's reserve pages only
> > accounts for what is requested and allocated from the subpool, its
> > "used" counter keeps track of what is consumed in total, both from the
> > subpool and globally. Thus, we need to adjust spool->used_hpages in the
> > other direction, and make sure that globally requested pages are
> > uncharged from the subpool's used counter.
> > 
> > ...
> > 
> > Fixes: a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> > Cc: stable@vger.kernel.org
> 
> This (simple, cc:stable) patch presently has no reviews, if someone
> could please be so kind.

Oh.

Joshua, it's unclear from the changelog - what are the userspace-visible
effects of the bug?

