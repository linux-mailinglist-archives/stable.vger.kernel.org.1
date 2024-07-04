Return-Path: <stable+bounces-58088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92174927D29
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 20:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EF36B2357F
	for <lists+stable@lfdr.de>; Thu,  4 Jul 2024 18:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B59313777D;
	Thu,  4 Jul 2024 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Es/ggW1u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1015136E28;
	Thu,  4 Jul 2024 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720118007; cv=none; b=k9Vuqwin6q/9vazaWaUsBOczT5IK5hkvZO8MuZp+VHaWJphXjSk/0oljQ5RraiO/2jHCDN1FWGn061kywUBvqyHHAs6Jq+DJ2rex2m0QE+epVIyEi4c2cW4VKEvAECgiqOz4MZZ4/C3x80n+iXNzuET/Sun8bRu7MRGq4zRqrPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720118007; c=relaxed/simple;
	bh=n5vgE0QBrC52K5xATWxIIUbE1yzT0GmtkrWhx/yuFcI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=E3/1JSemtsNoWVCIrxyDLa5jvkWn2VuJa2BmAuD1amyhvEZjXr3d4ZrKCNts2X2fQb28QDucffa79q+qAUr1yPBaItPfOCxKrALB/uCaSkyHwoR3uhU25rgUHL5TbsjQecTxItTthpwokfSstYC7OUieOoM1yUwq1uu47inz4dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Es/ggW1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFD7C32781;
	Thu,  4 Jul 2024 18:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720118006;
	bh=n5vgE0QBrC52K5xATWxIIUbE1yzT0GmtkrWhx/yuFcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Es/ggW1umo66oQkkL0ypdYkxmji4n0MTAf8J911bD5JIYCP388YbAzjj1veEYZzE1
	 As62lY8KptoorRGkmPYnLWAOodFcR9OfmR8xtSVkZQS7/3iDQN91zAJYze/VzWjB8A
	 q2KrM9pftFAhx7y+Q4HGb7uw8GEAYjSsJ0sR1Xfk=
Date: Thu, 4 Jul 2024 11:33:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
 Barry Song <baohua@kernel.org>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Lance Yang <ioworker0@gmail.com>, Yang Shi
 <shy828301@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] mm: Fix khugepaged activation policy
Message-Id: <20240704113325.fb9f1b04f99abaac315b5c88@linux-foundation.org>
In-Reply-To: <20240704091051.2411934-1-ryan.roberts@arm.com>
References: <20240704091051.2411934-1-ryan.roberts@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jul 2024 10:10:50 +0100 Ryan Roberts <ryan.roberts@arm.com> wrote:

> Since the introduction of mTHP, the docuementation has stated that
> khugepaged would be enabled when any mTHP size is enabled, and disabled
> when all mTHP sizes are disabled. There are 2 problems with this; 1.
> this is not what was implemented by the code and 2. this is not the
> desirable behavior.
> 
> Desirable behavior is for khugepaged to be enabled when any PMD-sized
> THP is enabled, anon or file. (Note that file THP is still controlled by
> the top-level control so we must always consider that, as well as the
> PMD-size mTHP control for anon). khugepaged only supports collapsing to
> PMD-sized THP so there is no value in enabling it when PMD-sized THP is
> disabled. So let's change the code and documentation to reflect this
> policy.
> 
> Further, per-size enabled control modification events were not
> previously forwarded to khugepaged to give it an opportunity to start or
> stop. Consequently the following was resulting in khugepaged eroneously
> not being activated:
> 
>   echo never > /sys/kernel/mm/transparent_hugepage/enabled
>   echo always > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
> 
> ...
>
> -static inline bool hugepage_flags_enabled(void)
> +static inline bool hugepage_pmd_enabled(void)
>  {
>  	/*
> -	 * We cover both the anon and the file-backed case here; we must return
> -	 * true if globally enabled, even when all anon sizes are set to never.
> -	 * So we don't need to look at huge_anon_orders_inherit.
> +	 * We cover both the anon and the file-backed case here; file-backed
> +	 * hugepages, when configured in, are determined by the global control.
> +	 * Anon pmd-sized hugepages are determined by the pmd-size control.
>  	 */
> -	return hugepage_global_enabled() ||
> -	       READ_ONCE(huge_anon_orders_always) ||
> -	       READ_ONCE(huge_anon_orders_madvise);
> +	return (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && hugepage_global_enabled()) ||
> +	       test_bit(PMD_ORDER, &huge_anon_orders_always) ||
> +	       test_bit(PMD_ORDER, &huge_anon_orders_madvise) ||
> +	       (test_bit(PMD_ORDER, &huge_anon_orders_inherit) && hugepage_global_enabled());
>  }

That's rather a mouthful.  Is this nicer?

static inline bool hugepage_pmd_enabled(void)
{
	/*
	 * We cover both the anon and the file-backed case here; file-backed
	 * hugepages, when configured in, are determined by the global control.
	 * Anon pmd-sized hugepages are determined by the pmd-size control.
	 */
	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
			hugepage_global_enabled())
		return true;
	if (test_bit(PMD_ORDER, &huge_anon_orders_always))
		return true;
	if (test_bit(PMD_ORDER, &huge_anon_orders_madvise))
		return true;
	if (test_bit(PMD_ORDER, &huge_anon_orders_inherit) &&
			hugepage_global_enabled())
		return true;
	return false;
}

Also, that's a pretty large function to be inlined.  It could be a
non-inline function static to khugepaged.c.  But I suppose that's a
separate patch.

