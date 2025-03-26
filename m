Return-Path: <stable+bounces-126651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB089A70E4C
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 01:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6B4189A53F
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 00:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8A8111BF;
	Wed, 26 Mar 2025 00:47:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E402BB15;
	Wed, 26 Mar 2025 00:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742950054; cv=none; b=NDJxj5g69pkQVvym8vtMQokfFvngEYc5zKOXsh8BmnNnHCiMP+uWUYN5iu88dfzwlZT+XNwnPp5HDc5Nnln4BZ77icgsc1spE5R8rRrxexg8crk8LciPrrLpDgBugQs3qNbX0nPD5gJZhbLfnZcUX6WcF5PCXKsP5WB/1eLXfmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742950054; c=relaxed/simple;
	bh=k3LLtjEfy/u0Crsnr2qzo9+Rivq6WchURVA5DJmhYIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9YFlM+iRdsm1iLsbwDjq0OwIQCcKqrWR9ZPWg4n7+DH6PaNzX3wMAaQVLnAitkmkOTx45gMHyBuN1rbadKck5oZNqhx/8SzQakmMpDQt1WTvl9GwwkdYcmL9DnZKcz/FyA1mtNQKoKTDBgXnoqyk+RnIiP7hdE77OvcxNI2T0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8F3C4CEE4;
	Wed, 26 Mar 2025 00:47:32 +0000 (UTC)
Date: Tue, 25 Mar 2025 20:47:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sahil Gupta <s.gupta@arista.com>, stable@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>, Kevin
 Mitchell <kevmitch@arista.com>
Subject: Re: [PATCH 6.1 6.6 6.12 6.13] scripts/sorttable: fix ELF64
 mcount_loc address parsing when compiling on 32-bit
Message-ID: <20250325204731.24f26003@batman.local.home>
In-Reply-To: <2025032554-compile-unlivable-0fb4@gregkh>
References: <CABEuK17=Y8LsLhiHXgcr7jOp2UF3YCGkQoAyQu8gTVJ5DHPN0w@mail.gmail.com>
	<20250326001122.421996-2-s.gupta@arista.com>
	<2025032553-celibacy-underpaid-faeb@gregkh>
	<20250325203236.3c6a19f4@batman.local.home>
	<20250325203723.53d3afde@batman.local.home>
	<2025032554-compile-unlivable-0fb4@gregkh>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 20:45:00 -0400
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Mar 25, 2025 at 08:37:23PM -0400, Steven Rostedt wrote:
> > On Tue, 25 Mar 2025 20:32:36 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >   
> > > I guess it is loosely based on 4acda8edefa1 ("scripts/sorttable: Get
> > > start/stop_mcount_loc from ELF file directly"), which may take a bit of
> > > work to backport (or we just add everything that this commit depends on).  
> > 
> > And looking at what was done, it was my rewrite of the sorttable.c code.
> > 
> > If it's OK to backport a rewrite, then we could just do that.
> > 
> > See commits:
> > 
> >   4f48a28b37d5 scripts/sorttable: Remove unused write functions
> >   7ffc0d0819f4 scripts/sorttable: Make compare_extable() into two functions
> >   157fb5b3cfd2 scripts/sorttable: Convert Elf_Ehdr to union
> >   545f6cf8f4c9 scripts/sorttable: Replace Elf_Shdr Macro with a union
> >   200d015e73b4 scripts/sorttable: Convert Elf_Sym MACRO over to a union
> >   1dfb59a228dd scripts/sorttable: Add helper functions for Elf_Ehdr
> >   67afb7f50440 scripts/sorttable: Add helper functions for Elf_Shdr
> >   17bed33ac12f scripts/sorttable: Add helper functions for Elf_Sym
> >   58d87678a0f4 scripts/sorttable: Move code from sorttable.h into sorttable.c  
> 
> Backport away!

Actually, I only did a git log on scripts/sorttable.c. I left out
sorttable.h which gives me this list:

$ git log --pretty=oneline --abbrev-commit --reverse v6.12..4acda8edefa1ce66d3de845f1c12745721cd14c3 scripts/sorttable.[ch] 

0210d251162f scripts/sorttable: fix orc_sort_cmp() to maintain symmetry and transitivity
28b24394c6e9 scripts/sorttable: Remove unused macro defines
4f48a28b37d5 scripts/sorttable: Remove unused write functions
6f2c2f93a190 scripts/sorttable: Remove unneeded Elf_Rel
66990c003306 scripts/sorttable: Have the ORC code use the _r() functions to read
7ffc0d0819f4 scripts/sorttable: Make compare_extable() into two functions
157fb5b3cfd2 scripts/sorttable: Convert Elf_Ehdr to union
545f6cf8f4c9 scripts/sorttable: Replace Elf_Shdr Macro with a union
200d015e73b4 scripts/sorttable: Convert Elf_Sym MACRO over to a union
1dfb59a228dd scripts/sorttable: Add helper functions for Elf_Ehdr
67afb7f50440 scripts/sorttable: Add helper functions for Elf_Shdr
17bed33ac12f scripts/sorttable: Add helper functions for Elf_Sym
1b649e6ab8dc scripts/sorttable: Use uint64_t for mcount sorting
58d87678a0f4 scripts/sorttable: Move code from sorttable.h into sorttable.c
4acda8edefa1 scripts/sorttable: Get start/stop_mcount_loc from ELF file directly

-- Steve

