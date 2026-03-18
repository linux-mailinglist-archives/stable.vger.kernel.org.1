Return-Path: <stable+bounces-227077-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ANpLZ62umlWawIAu9opvQ
	(envelope-from <stable+bounces-227077-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 15:28:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6C52BD212
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 15:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7579130C4DAE
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DEA3DA5C0;
	Wed, 18 Mar 2026 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElHBZ8Vv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591F73D47AF;
	Wed, 18 Mar 2026 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843040; cv=none; b=ggWQCbcQN70sOV373dkzhHhIyvc4n6gmlwYibep8zYQVKTtGnlI6iwHbGoxmTX2hkWNaV+eoVZWw5qsEWlmbOkhzy1+cVuKK8LbFBOGfLfF5BAggddUB8uClSHHqOamkD5mhnW2A8lcAzWHcwC/MmjauTo40k7dxPtxsNFTMMDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843040; c=relaxed/simple;
	bh=fezKM7Xvi051pm+0o/waft8Nh8Zbwa9FBAsqhL+7GOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQzO7bfIJqOTAwu34SD9mUF2/WDHN+Ed6aT/gBj3pD9JqGZi1bIJEDWMkkYPA+8Tve+2iVI6VKFe1H0CUUYnx/cqADUVypFRcc4PejNUkFliJk/l0LDEnn5Kzo9IwFcNSRkh10YqODaDJG64Cy9udfm6llIpEFAvZbGfQFeOkLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElHBZ8Vv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CEEC19424;
	Wed, 18 Mar 2026 14:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773843040;
	bh=fezKM7Xvi051pm+0o/waft8Nh8Zbwa9FBAsqhL+7GOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ElHBZ8Vv9qBAlwoqfdktt9Gp8rntF/lBOYp1KQDNhJNqAco0f83PxFVuWmFsO+9kG
	 89lQNxkt98JNPcTYwc/eSZ60nYNI2g0/HSpBW2zfqeltoEMowMwisdDF0TEADMyDDT
	 k+T3UzgIt6sRxXhDq33smnFU/7Lg4yYgUg3S2cSRWwn40qa7DdFqOMwsV9Rzkn/yS5
	 7InhP8mFagc3sNBV5ZgW9iMxXTFhQT0hXTxRNzeK2BQTsh0kRfhWX5Bo5E08ch/6ur
	 ZuuyZoIEj2n9AyqWdtFhpYwBsp5W5TwmfaRfEK0Y1Rxy+FWZksdckAVqbr8dXHPDlD
	 n8TOHGIO4dW5A==
Date: Wed, 18 Mar 2026 14:10:29 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "Boone, Max" <mboone@akamai.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] mm/pagewalk: fix race between concurrent split and
 refault
Message-ID: <789b4585-7542-412a-b9ab-3f7de8d8dc89@lucifer.local>
References: <20260317-pagewalk-check-pmd-refault-v1-1-f699a010f2b3@akamai.com>
 <7ded426a-0cb5-437b-9634-8d806b704db6@lucifer.local>
 <719CB417-F511-402A-91E3-8A696ABCE0D5@akamai.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <719CB417-F511-402A-91E3-8A696ABCE0D5@akamai.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227077-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,akamai.com:email,lucifer.local:mid]
X-Rspamd-Queue-Id: CB6C52BD212
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 01:08:33PM +0000, Boone, Max wrote:
>
> > On Mar 18, 2026, at 1:55 PM, Lorenzo Stoakes (Oracle) <ljs@kernel.org> wrote:
> >
> >> […]
> >
> > So IOW, the PUD entry is split, then refaulted back to a PUD leaf entry
> > again?
>
> As far as I understand indeed, although the usage and faulting of huge
> pfnmaps does not feel intuitive to me yet. Empirically, yes, observing this
> when follow_fault_pfn() in drivers/vfio/vfio_iommu_type1.c is running
> concurrently with walk_pud_range(). I have another patch sent up to
> that list because this fix causes follow_fault_pfn() to return -EINVAL [1].

Ack

>
> >> […]
> >
> > I think it mirrors the retry logic in walk_pte_range() more closely right?
> > Because there it's:
> >
> > if (!pte)
> > walk->action = ACTION_AGAIN;
> > return err;
> >
> > I.e. let the parent handle the PTE not being got by pte_offset_map_lock(),
> > and you draw a comparison to this in the comment in walk_pmd_range().
>
> I’d personally say that the main logic introduced is walk_pud_range() retrying when
> walk_pmd_range() fails. We’re also splitting the PUD in walk_pud_range() and
> descending. But yeah, retry logic mirrors walk_pmd_range(), deciding that we need
> to retry mirrors walk_pte_range().

It's not a big deal we can leave that as is.

>
> >
> >>
> >> Fixes: a00cc7d9dd93 ("mm, x86: add support for PUD-sized transparent hugepages")
> >
> > Yikes, really? :) This is from 2017, I'm a little surprised we didn't hit
> > this bug until now.
> >
> > Has something changed more recently that made it more likely to hit? Or is
> > it one of those 'needed people to have more RAM first' or bigger PCI BAR's?
>
> Yeah, frankly, this is the first patch where I could find the splitting being introduced. It might
> be more correct to refer to the introduction of 1G huge_pfnmaps?

Yeah maybe that makes more sense? David - what do you think?

>
> >
> >> Cc: stable@vger.kernel.org
> >> Co-developed-by: David Hildenbrand (Arm) <david@kernel.org>
> >> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >> Signed-off-by: Max Boone <mboone@akamai.com>
> >
> > Only nits here, the logic LGTM, so:
>
> I’ll write up a PATCH v2 later today.

Cheers!

>
> >
> > […]
>
>

Thanks, Lorenzo

