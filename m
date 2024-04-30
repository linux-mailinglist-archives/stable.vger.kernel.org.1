Return-Path: <stable+bounces-42823-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F82E8B7F1F
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 19:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B93928637A
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 17:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE51190662;
	Tue, 30 Apr 2024 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lj8XngXp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32692190661
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 17:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498915; cv=none; b=EGKDDpZqjnLDGfSAN0kKG4R+e6H8H81mIoVD8fe7wg2p+8fJrWUij6iQODwE44twR12GpreoyXkwAdH6xmG8RmLBhzOPm6lEnhmqUhrH48jUJ7LeaK/V7flzlrSittb64MaOiPQxOGRJtlE2DaODPExoaT0yrCKuaT9z8+NqeRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498915; c=relaxed/simple;
	bh=aPwhN12Q5ywsIelJBenI+enhra3DeRCdUuVZGsSHx1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fP1JTkiLAx0gxSIDnSY1l3pRXC7A/higL0CezYtgZsocHltaaAyt8BtlAajUsjTYmqty+CzhJty7q+QmbACMF9kqky0RuvD8FFG5sqOCZuMFMfYNlQLANby4przFawAoLqhYvOvA9+PbWNrWTmdFRbR/HXs5aCfVYYWScz7q0Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lj8XngXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7B6C2BBFC;
	Tue, 30 Apr 2024 17:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714498914;
	bh=aPwhN12Q5ywsIelJBenI+enhra3DeRCdUuVZGsSHx1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lj8XngXpmL1bjwQQmA1Ost7oU1wN0BCA6nLnEYD0Mb3rb6Q8NkdKN3nva7RZiNTbd
	 Ac2zObQKTbCw79u0+XsxnxJzjB9RTjUHTKcMfAbmF5c/gyeTu2TbtIJZeD43SzRlKa
	 8oZsv/x6Di5Uyapel+wHQ4g9Dfn0m53lZBQJXKCo=
Date: Tue, 30 Apr 2024 19:41:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: vanshikonda@os.amperecomputing.com, jarredwhite@linux.microsoft.com,
	rafael.j.wysocki@intel.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] ACPI: CPPC: Fix access width used for PCC
 registers" failed to apply to 5.15-stable tree
Message-ID: <2024043016-overhung-oaf-8201@gregkh>
References: <2024042905-puppy-heritage-e422@gregkh>
 <24df5fe0-9e1a-4929-b132-3654ec9d8bf3@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24df5fe0-9e1a-4929-b132-3654ec9d8bf3@linux.microsoft.com>

On Tue, Apr 30, 2024 at 09:05:28AM -0700, Easwar Hariharan wrote:
> On 4/29/2024 4:53 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x f489c948028b69cea235d9c0de1cc10eeb26a172
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042905-puppy-heritage-e422@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > f489c948028b ("ACPI: CPPC: Fix access width used for PCC registers")
> > 2f4a4d63a193 ("ACPI: CPPC: Use access_width over bit_width for system memory accesses")
> > 0651ab90e4ad ("ACPI: CPPC: Check _OSC for flexible address space")
> > c42fa24b4475 ("ACPI: bus: Avoid using CPPC if not supported by firmware")
> > 2ca8e6285250 ("Revert "ACPI: Pass the same capabilities to the _OSC regardless of the query flag"")
> > f684b1075128 ("ACPI: CPPC: Drop redundant local variable from cpc_read()")
> > 5f51c7ce1dc3 ("ACPI: CPPC: Fix up I/O port access in cpc_read()")
> > a2c8f92bea5f ("ACPI: CPPC: Implement support for SystemIO registers")
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Hi Greg,
> 
> Please fix this with the following set of changes in linux-5.15.y.
> 
> Revert b54c4632946ae42f2b39ed38abd909bbf78cbcc2 from linux-5.15.y
> Cherry-pick 05d92ee782eeb7b939bdd0189e6efcab9195bf95 from upstream
> Pick the following backport of f489c948028b69cea235d9c0de1cc10eeb26a172 from upstream

Please provide a series of patches that I can apply that does this,
attempting to revert and cherry-pick and then manually hand-edit this
email and apply it does not scale at all, sorry.

thanks,

greg k-h

