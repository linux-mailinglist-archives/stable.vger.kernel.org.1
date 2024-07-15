Return-Path: <stable+bounces-59342-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D247A931340
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 13:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75E931F238E7
	for <lists+stable@lfdr.de>; Mon, 15 Jul 2024 11:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B17189F5B;
	Mon, 15 Jul 2024 11:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VWlLX2oN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C573188CAB;
	Mon, 15 Jul 2024 11:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043708; cv=none; b=D7PDCj1ThvWjdIs9VSoy5tliqSlgTpM+5QUQ6SNIyvkAiMLYRHjuw9n/qCabgWgmlUB0DprLWl+0xRoBvcfSea7MWf45RoH9KKW10AYVsXXGi2giBwoViYnELTmO0xIC6ZJ2EMCdMmAtyTplo8LY0lQ4qzU6g9xTmgO42KyX9Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043708; c=relaxed/simple;
	bh=W2IxFXE4fwwOxLnrXBbCLzK+Cy8VbJhWZvZrbO221Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeCw9lV5+jotrf+Tc65bMTSXkCvAFAwSkqYieeJ94pXiSt/0OrtxhcaOpNtH8SnSzvB2grWqOdELlt5cxo/V082fq0Dd7Q1nNLOjuF45eMJYSZiRPn7OPzValRUdUsA+Lc3Fic06N6W4kkrqommd5YnGgqkzpsGkQ9yIn2x9p9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VWlLX2oN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F6DC32782;
	Mon, 15 Jul 2024 11:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721043707;
	bh=W2IxFXE4fwwOxLnrXBbCLzK+Cy8VbJhWZvZrbO221Nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VWlLX2oNjRLMhZ8xZ4Kh6QEnq/dDRl88CpMaaiHNZKCs7o3hvtT1t2j7xQvXxfkWC
	 uyaIt/alhjSBrMQ30QzhpV4UH9B/W5oouQ8Ss4+LV72vC2pydO7GscU5LfeKK1iZlt
	 GhY9wElwo8ukTJHLdKUXlzyf9jLAumshSyTULLLo=
Date: Mon, 15 Jul 2024 13:41:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Jim Mattson <jmattson@google.com>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Greg Thelen <gthelen@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 6.1] x86/retpoline: Move a NOENDBR annotation to the SRSO
 dummy return thunk
Message-ID: <2024071537-denatured-unspoken-62fc@gregkh>
References: <20240709132058.227930-1-jmattson@google.com>
 <2024070930-monument-cola-a36e@gregkh>
 <20240709135545.GIZo1BYUeDD6UrvZNd@fat_crate.local>
 <20240709141238.GJZo1FVpZU0jRganFu@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709141238.GJZo1FVpZU0jRganFu@fat_crate.local>

On Tue, Jul 09, 2024 at 04:12:38PM +0200, Borislav Petkov wrote:
> From: Jim Mattson <jmattson@google.com>
> Subject: [PATCH] x86/retpoline: Move a NOENDBR annotation to the SRSO dummy return thunk
> 
> The linux-6.1-y backport of commit b377c66ae350 ("x86/retpoline: Add
> NOENDBR annotation to the SRSO dummy return thunk") misplaced the new
> NOENDBR annotation, repeating the annotation on __x86_return_thunk,
> rather than adding the annotation to the !CONFIG_CPU_SRSO version of
> srso_alias_untrain_ret, as intended.
> 
> Move the annotation to the right place.
> 
> Fixes: 0bdc64e9e716 ("x86/retpoline: Add NOENDBR annotation to the SRSO dummy return thunk")
> Reported-by: Greg Thelen <gthelen@google.com>
> Signed-off-by: Jim Mattson <jmattson@google.com>
> Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/lib/retpoline.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Both now queued up, thanks.

greg k-h

