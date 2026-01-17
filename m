Return-Path: <stable+bounces-210143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 239B3D38D8C
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 10:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA096300877A
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 09:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F90233506F;
	Sat, 17 Jan 2026 09:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zUI1Dgw7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DAC310784;
	Sat, 17 Jan 2026 09:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768643924; cv=none; b=KMMyVivVvPTUVLOwrCH+HYmAQ2fUcGaq7u6h67To8esM5xXZ8lVXvGVp4BCCpUmVDvo6iOPAOmpjPPrJlTGTXWqvbNu3Ekcv5xD2dpO6UZDjLdND7tsqGwLWEkKsaGhDR4zP4JQFYkIjzgvP5cRXHA+WRnJiFtmPxk5G3Kx6N4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768643924; c=relaxed/simple;
	bh=AFSia1obhNqrEehJDOsSEV0fsb4zvirvIWC+KQ5aHpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6puiYpKqmLePHoFEO5KlWeDVv2gWVQ17nI9/hYUc2awPsiVU2lPoPUH39sRaYwfvZUY206UP4U5Hh2rKJmzYaiRVrsT5A1+AySS0cp2VA4xOngWnutwbMY+WH8qQODZC5puHGSBrxNjQZl+e+I1rc3pP2ZIbCv69maR0Kb1H7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zUI1Dgw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D878C4CEF7;
	Sat, 17 Jan 2026 09:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768643924;
	bh=AFSia1obhNqrEehJDOsSEV0fsb4zvirvIWC+KQ5aHpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zUI1Dgw7NPQAUBeNoS0fGA6CVX+Q8u3dpZ1WurLKQo+IYaXMbrggQQzeIQ7UCITbV
	 s9mm/+Fk9wMmNzmkuswzvejSKR71cQI55iwb8pd7p3huV8H5W1XmOZRDZxZW6k/gfR
	 KcpYgnbHF38UPkKXYdv83Bs7NJ+4j6hCLrQaYFWg=
Date: Sat, 17 Jan 2026 10:58:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Weigang He <geoffreyhe2@gmail.com>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: fix missing null termination after
 copy_from_user()
Message-ID: <2026011725-ecosystem-proved-a6ba@gregkh>
References: <20260117094631.504232-1-geoffreyhe2@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117094631.504232-1-geoffreyhe2@gmail.com>

On Sat, Jan 17, 2026 at 09:46:31AM +0000, Weigang He wrote:
> The buffer 'buf' is filled by copy_from_user() but is not properly
> null-terminated before being used with strncmp(). If userspace provides
> fewer than 10 bytes, strncmp() may read beyond the copied data into
> uninitialized stack memory.

But that's fine, it will not match the check, and so it will stop when
told, so no overflow happens anywhere.

> Add explicit null termination after copy_from_user() to ensure the
> buffer is always a valid C string before string operations.

It's ok, and is valid, and this is all debugging code.  This isn't a
real bug, sorry.

> Fixes: 87a03802184c ("xhci: debugfs: add debugfs interface to enable compliance mode for a port")
> Cc: stable@vger.kernel.org

Nope, this doesn't "fix" anything.

How was this bug found?  What tool did you use for this?  How was it tested?

thanks,

greg k-h

