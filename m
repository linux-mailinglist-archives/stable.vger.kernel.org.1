Return-Path: <stable+bounces-183191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B07A0BB6C6D
	for <lists+stable@lfdr.de>; Fri, 03 Oct 2025 15:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606B819C399E
	for <lists+stable@lfdr.de>; Fri,  3 Oct 2025 13:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC271B4141;
	Fri,  3 Oct 2025 13:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NwJQ/ASp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0504816F265;
	Fri,  3 Oct 2025 13:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759496607; cv=none; b=XAxHuqxIjf1QnNP+DuzZ8S/ctxW6CT3P0HYd4ZRy+cfK1K1kLMtNR2dFvqU8zP1njo+bhYO+UQ13BenZx0mbGQy9F6iguNE4+IopVHAHv4OwaeV4IBnjOCpXjMgSiTDOfa/fUa5fnK95BdCig0B6Z/LdxZdb5PscZuQkL/nf81M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759496607; c=relaxed/simple;
	bh=D3n23xqYSXvSy/Naf1ERzsbmkFWo3vlQVCUkJAq6W4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+D2cBCnlZKmxoo3CRpHi157p6xQCRbwAO3i813nq8y8PEYMH9xiI+gOYicxYBItFKknW5qfReINvVnei76NJZzJdwIiuHAVCGgNuYVdR8SVZpCyGj+Hni9RJo7B+Vjqq9p74jTf+kiO3jvb1m7c9Aopt+IttjsfqdOC/lkGxXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NwJQ/ASp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B687C4CEF5;
	Fri,  3 Oct 2025 13:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759496605;
	bh=D3n23xqYSXvSy/Naf1ERzsbmkFWo3vlQVCUkJAq6W4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NwJQ/ASpH0aCZB5rIlMLHJGZfggKUXkAysFA+lBJINMmJfVFx4QHZ5UfaaNquz+79
	 nEy8SdlmVUXh+xd05s/2gJ5xE3F6p0GMcNJCr2IITGRE/j7AfJISwVmiQWem+9EV+Z
	 pIb2cWs2HcFzIKRJREzJyzEa0C/NFXUUYW9NhZE4=
Date: Fri, 3 Oct 2025 15:03:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Brahmajit Das <listout@listout.xyz>
Cc: stable@vger.kernel.org, linux-hardening@vger.kernel.org,
	kees@kernel.org, Christopher Fore <csfore@posteo.net>
Subject: Re: [PATCH 6.16.y] gcc-plugins: Remove TODO_verify_il for GCC >= 16
Message-ID: <2025100311-disparate-many-794c@gregkh>
References: <20251001155040.26273-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001155040.26273-1-listout@listout.xyz>

On Wed, Oct 01, 2025 at 09:20:40PM +0530, Brahmajit Das wrote:
> From: Kees Cook <kees@kernel.org>
> 
> [ Upstream commit a40282dd3c48 ]
> 
> GCC now runs TODO_verify_il automatically[1], so it is no longer exposed to
> plugins. Only use the flag on GCC < 16.
> 
> Link: https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=9739ae9384dd7cd3bb1c7683d6b80b7a9116eaf8 [1]
> Suggested-by: Christopher Fore <csfore@posteo.net>
> Link: https://lore.kernel.org/r/20250920234519.work.915-kees@kernel.org
> Signed-off-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---
>  scripts/gcc-plugins/gcc-common.h | 7 +++++++
>  1 file changed, 7 insertions(+)

Kees beat you to this, thanks!

greg k-h

