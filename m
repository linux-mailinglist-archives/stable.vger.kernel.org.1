Return-Path: <stable+bounces-126649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D12FA70E3E
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 01:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948403A51F7
	for <lists+stable@lfdr.de>; Wed, 26 Mar 2025 00:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9C018035;
	Wed, 26 Mar 2025 00:37:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B47410E4;
	Wed, 26 Mar 2025 00:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742949446; cv=none; b=pg5d5i3ez/83OnlEbw9r2uJ6RptsQ6jOL8rRmxN/BjnOOlo+NG8Bj3NmXo8feBH41o5AgPjtbgXrVb6D4sx2k+r+WqgVW+8IVpKQrGSnP2JPEtk0HdmU3U7Va9wK1om568SO/BExg5XEH6H1BN6nIfoZ2p8AnTbQfjo6hgqFI/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742949446; c=relaxed/simple;
	bh=UHXucbfL4AD4wQ/GcCSwD6vlnVOe5FuNhEFpGpmBvF0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t7w8Q4dfjQBab5PTkyohKyzwltBZAwkGpdBjgHsSkNVgm6ahbDxIyoT9umWEex5uRyyfgsqnnWH2C6MU+tx/UyFTykki1OhsaERg3/J49KweEiATj2AiY9XpZ5p+a9BRnf2f6Fe4Tkl0K5R9jJWL87JvBT9T5MgNcAPmj7O5ZU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06ECC4CEE4;
	Wed, 26 Mar 2025 00:37:24 +0000 (UTC)
Date: Tue, 25 Mar 2025 20:37:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sahil Gupta <s.gupta@arista.com>, stable@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>, Kevin
 Mitchell <kevmitch@arista.com>
Subject: Re: [PATCH 6.1 6.6 6.12 6.13] scripts/sorttable: fix ELF64
 mcount_loc address parsing when compiling on 32-bit
Message-ID: <20250325203723.53d3afde@batman.local.home>
In-Reply-To: <20250325203236.3c6a19f4@batman.local.home>
References: <CABEuK17=Y8LsLhiHXgcr7jOp2UF3YCGkQoAyQu8gTVJ5DHPN0w@mail.gmail.com>
	<20250326001122.421996-2-s.gupta@arista.com>
	<2025032553-celibacy-underpaid-faeb@gregkh>
	<20250325203236.3c6a19f4@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 20:32:36 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I guess it is loosely based on 4acda8edefa1 ("scripts/sorttable: Get
> start/stop_mcount_loc from ELF file directly"), which may take a bit of
> work to backport (or we just add everything that this commit depends on).

And looking at what was done, it was my rewrite of the sorttable.c code.

If it's OK to backport a rewrite, then we could just do that.

See commits:

  4f48a28b37d5 scripts/sorttable: Remove unused write functions
  7ffc0d0819f4 scripts/sorttable: Make compare_extable() into two functions
  157fb5b3cfd2 scripts/sorttable: Convert Elf_Ehdr to union
  545f6cf8f4c9 scripts/sorttable: Replace Elf_Shdr Macro with a union
  200d015e73b4 scripts/sorttable: Convert Elf_Sym MACRO over to a union
  1dfb59a228dd scripts/sorttable: Add helper functions for Elf_Ehdr
  67afb7f50440 scripts/sorttable: Add helper functions for Elf_Shdr
  17bed33ac12f scripts/sorttable: Add helper functions for Elf_Sym
  58d87678a0f4 scripts/sorttable: Move code from sorttable.h into sorttable.c

-- Steev

