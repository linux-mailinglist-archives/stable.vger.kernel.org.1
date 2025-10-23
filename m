Return-Path: <stable+bounces-189144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6D0C022C0
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 17:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9623AC37F
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 15:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB44233CEB7;
	Thu, 23 Oct 2025 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ths7bD0u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F03093AC;
	Thu, 23 Oct 2025 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233719; cv=none; b=tBxsmo6bprx/NJmH4llAksL2JdJ3mYWjGckeasAVF61eIQq22LcNkWml6UYFJZ2F3js3su3hxurDIvu2ajZw0f8xnyhFOYNmM6iWk4LhYmYh1xh2uR6m2Op9h8Oq/7Im2RXDPQg7g374ivLzYBx73i/E63lbvfm1PsrggrVvNP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233719; c=relaxed/simple;
	bh=G3zyCbcH62Rx8I3WW+EGgnCGe7yYgcZMnSMyAprvtFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvkQpNEbnbjcpI4dm++iVLBI7z1ylXJ8aGJaEnbihZ58JuxpakJFbUo+nyLQT8or+FECzQ/QaBAGStn9EIG+Q8e3RUl0EveSN/xe+jQ8IUrYxtoCdAYZ/WZIxJqwy3IZDhzXKsJdw3tD2rzzvczpkNGeM0S3DNbOHgQfPGe4Tvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ths7bD0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3627DC4CEF7;
	Thu, 23 Oct 2025 15:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761233719;
	bh=G3zyCbcH62Rx8I3WW+EGgnCGe7yYgcZMnSMyAprvtFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ths7bD0u2+Foe1WKN3t6rZ0OurGUivIDm+Wwe6sVazrnMAgjGQPaBGOmWt1Lje+0M
	 rB44f+7Qo5mssVSqYCTaGgu+9YytA0enVOAuQLAl77qKhTEU8Ld97OzI5jFwm+NlAz
	 xDbjrGK9cdWRXiXbv5VHNDcPvkNDPoLjeJh6FqNilmRji+Nr2b3SY5K8udgiTwljWB
	 Q83yYCt7OUvXmacEeA2OS4fkUx7O8PXySuJOnlN/gqpekh7NsqEc7i10jNtCmDT2LK
	 s/Kb6GYafwZagQoEc1nSdkZncXAtkIXMqjhZYhpHEUgJgpWXZv+LPL76dIKUi63P0r
	 u/F5ZF/Rk94Sg==
Date: Thu, 23 Oct 2025 08:35:18 -0700
From: Kees Cook <kees@kernel.org>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, svetlana.parfenova@syntacore.com,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>
Subject: Re: Patch "binfmt_elf: preserve original ELF e_flags for core dumps"
 has been added to the 6.12-stable tree
Message-ID: <202510230834.25F76B0B5@keescook>
References: <20251023152554.1030000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023152554.1030000-1-sashal@kernel.org>

On Thu, Oct 23, 2025 at 11:25:53AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     binfmt_elf: preserve original ELF e_flags for core dumps
> 
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      binfmt_elf-preserve-original-elf-e_flags-for-core-du.patch
> and it can be found in the queue-6.12 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

No, please don't. I already asked that this not be auto-backported:
https://lore.kernel.org/all/202510020856.736F028D@keescook/

-- 
Kees Cook

