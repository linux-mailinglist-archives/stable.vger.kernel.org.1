Return-Path: <stable+bounces-189145-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D28C02296
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 17:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8BEA4FFD63
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 15:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3BF33B960;
	Thu, 23 Oct 2025 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sT+15DhD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEE03148D9;
	Thu, 23 Oct 2025 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233744; cv=none; b=tM4M5n3LlzJ5ESTuqsJiJPdFQUCJXYNFlcg/z+MEhkRm0z5VSR2cEPN3O/oC4tWs5Y3WV4RnJRcTWeaKMPP5qrvoCa/UZcsTVzJHxrhSdIipx5Q+S1Koth4TbnxEHjaUskOGmq4wb4ZNxHKT2ZmCVtdSlGJ/Yn9NyKR4xNH5F6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233744; c=relaxed/simple;
	bh=hDUWxawxamxl1xPFSfqHASEzJWjCJbxWTVWKxSIMDCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iiqq1jGEww4knKBM3hnXrCRukoVZGDGwCIDpL0YK4+yhaSa9QDclZaUbkv87wBKDTllvV5LDyRRU0Bh3Wf0rmiGvzX5eH/HO9+9sMJT3Wokn9A2eNOsinfk6Vc6Zs+NMRoxnOtxFK4F5UgP4DL+5cVpVsr2MpEoWpUTfxYBbgHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sT+15DhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18912C4CEE7;
	Thu, 23 Oct 2025 15:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761233744;
	bh=hDUWxawxamxl1xPFSfqHASEzJWjCJbxWTVWKxSIMDCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sT+15DhDrB0UH7dc3cIDS3yrMg6zxDGXGPuvxnH5SKj9FoLG8YMOMdlUgTfIVSGPQ
	 Uv4Tycir5V4+FFnCRl+QIqjGMYM7irR6r8HZJ4ZVv7SEwq1sou7goRPrlgj1pQcnBN
	 kydGl98C3OMOXRpsgK0T9N4djhVPWR4jUYwEeeZ+v1I/Lr5mwZXyVkoN44wJyjlyOu
	 8wcvYGZ/KqO2EyFT3WkEgmIMrE1WY/QDxFI1DqvpQfaaJVclW73JsLnen7GtG6tVIh
	 Wk78WMBDoqFEEGIBK/i5KQGMHNCoejUCxAF9Na/zxkMKA9+M7858wZHdC7CH3a3ak3
	 GKwQQHjm18PNQ==
Date: Thu, 23 Oct 2025 08:35:43 -0700
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
 has been added to the 6.17-stable tree
Message-ID: <202510230835.964611CF@keescook>
References: <20251023152409.1026224-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023152409.1026224-1-sashal@kernel.org>

On Thu, Oct 23, 2025 at 11:24:08AM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     binfmt_elf: preserve original ELF e_flags for core dumps
> 
> to the 6.17-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      binfmt_elf-preserve-original-elf-e_flags-for-core-du.patch
> and it can be found in the queue-6.17 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

No, I asked that it not be backported:
https://lore.kernel.org/all/202510020856.736F028D@keescook/

>
-- 
Kees Cook

