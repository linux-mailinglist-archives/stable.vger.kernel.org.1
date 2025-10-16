Return-Path: <stable+bounces-186169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BECBE3F11
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 16:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E373C505CA0
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 14:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB62A340DA4;
	Thu, 16 Oct 2025 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K2UYK7NB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAD532D7FB;
	Thu, 16 Oct 2025 14:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760625448; cv=none; b=agNZUEmVdV/1OxZacfuyUSplHGOy/M/rXXDF0W90/TX/ZaDwEP3j2fwJ6V1soMU6gopS0ojdpfb5x9g0fqEzUP3wSwmInfAPdCaZghpjAitR6etXlkOXSO61ISrLeiaXPAVCRqAQ068pN2O4o4Z43fYbJ8koYOUHaCUA88Jg1us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760625448; c=relaxed/simple;
	bh=mLeBEMOKmK6uG4+hLDIks5z9pq7ystHRKBL/58jl7fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caJEf+5eerfpekOkCsosyAw6bBWgB4QTHrZyqtAvgc5y92TpuZXeK0O9DItMwxFnnxP3J2pZGZ8k866hDoM8Z53eAkdtiihDWI5Eh+ekJzvB40WP8dNkfBgg941+X9g2LYAWyfZ0EvM53knXfjWgCN+g6Xy8KloRjJjtSVLXZO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K2UYK7NB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3245C113D0;
	Thu, 16 Oct 2025 14:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760625448;
	bh=mLeBEMOKmK6uG4+hLDIks5z9pq7ystHRKBL/58jl7fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K2UYK7NBqr+IlKOY6LeW9VzrnL4KwZDzctVBRjRrqkeE75ZKSIizk4sgErqrJsKp3
	 BliaQ3AUJ/FUlPX8wxlWHA1HmGvdCYmQTjZ1+5A7Bzp7pGVg5kQK2wDZXReZcY8/H2
	 UZkOML+jPJ6Lxew9zBIjEYV1S6kJPYPLfXygwk3I=
Date: Thu, 16 Oct 2025 16:37:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	WANG Xuerui <kernel@xen0n.name>
Subject: Re: Patch "LoongArch: Init acpi_gbl_use_global_lock to false" has
 been added to the 6.12-stable tree
Message-ID: <2025101611-removed-imperfect-854d@gregkh>
References: <20251015114243.1341568-1-sashal@kernel.org>
 <CAAhV-H5ph0b3pf2PQV3hw83vPxKO-9Vba=XUCFRON1BUh7Y4oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H5ph0b3pf2PQV3hw83vPxKO-9Vba=XUCFRON1BUh7Y4oQ@mail.gmail.com>

On Thu, Oct 16, 2025 at 10:30:20PM +0800, Huacai Chen wrote:
> Hi, Sasha,
> 
> On Wed, Oct 15, 2025 at 7:42 PM Sasha Levin <sashal@kernel.org> wrote:
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     LoongArch: Init acpi_gbl_use_global_lock to false
> >
> > to the 6.12-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      loongarch-init-acpi_gbl_use_global_lock-to-false.patch
> > and it can be found in the queue-6.12 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> >
> Please also backport feb8ae81b2378b75a99c81d3156 ("ACPICA: Allow to
> skip Global Lock initialization") as a dependency for all stable
> branches.
> 

Now queued up, thanks.

greg k-h

