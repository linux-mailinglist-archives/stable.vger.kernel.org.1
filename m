Return-Path: <stable+bounces-208011-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0D6D0F152
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 15:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99407300A3CD
	for <lists+stable@lfdr.de>; Sun, 11 Jan 2026 14:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC44634678B;
	Sun, 11 Jan 2026 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RXjQsG1H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D70346AC0;
	Sun, 11 Jan 2026 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768140995; cv=none; b=CZEPdXRVB9baN95XGaIzwMkJZ69U8sok8ufWZIXAlQY6oRmM7ObDEmGmOjlKXnrUHnN6O9bN00FLY7EkgAD/HnNCG0fhX5oyETBBEWEt/aKCjvz76+3h+0onfXsmnqNr/g93jVwcx0Ffq1FxD/Fxy8oGWUxF4lOpRwBWBtI3LIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768140995; c=relaxed/simple;
	bh=oySkaMt+zNOoYY9atXdKAQX1DdiHuO2jXiDi9c8tT2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tjo0MoLXT9rBp+rRjnsfFad1ri7dbaHyp0Ty3l/SIFWMz19D5HgG6ZAEbH6uayqPlUflBlw3CghFiiHNjiJmA9ecePndI/yGxUsfHKKjDCJFftAIEmRXnC2JjMPJngY/OzBqqudTmk0h/LgkJo7aQZza/9rrauch0CAsopBvQUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RXjQsG1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24994C4CEF7;
	Sun, 11 Jan 2026 14:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768140994;
	bh=oySkaMt+zNOoYY9atXdKAQX1DdiHuO2jXiDi9c8tT2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXjQsG1H7lLS8mlsyUvyFlGNhv0lS3k3Ks/i/oJIhKDhU8ypKjxCcJKUx560YLlaW
	 BIAcy1TorPeA1JSeX17CCsizPCkv9kDRNUih5DLNkEMU6Mj4CG+ts/zvTYnbofHYIk
	 p564VDVlq/Vg78mcT78JH8Rt8FmQk3ORNEblPHPk=
Date: Sun, 11 Jan 2026 15:16:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Marnix Rijnart <marnix.rijnart@iwell.eu>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] serial: 8250_pci: Fix broken RS485 for F81504/508/512
Message-ID: <2026011158--1d2d@gregkh>
References: <20260111135933.31316-1-marnix.rijnart@iwell.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260111135933.31316-1-marnix.rijnart@iwell.eu>

On Sun, Jan 11, 2026 at 02:59:17PM +0100, Marnix Rijnart wrote:
> v1: https://patch.msgid.link/20250923221756.26770-1-marnix.rijnart@iwell.eu
> Changes: 
>  * Added fixes tags
>  * Cc stable
> 
> Commit 4afeced ("serial: core: fix sanitizing check for RTS settings")

Please use more digits here, "4afeced55baa", like you did in the Fixes:
lines.

> introduced a regression making it impossible to unset
> SER_RS485_RTS_ON_SEND from userspace if SER_RS485_RTS_AFTER_SEND is
> unsupported. Because these devices need RTS to be low on TX (fecf27a)
> they are effectively broken.
> 
> The hardware supports both RTS_ON_SEND and RTS_AFTER_SEND,
> so fix this by announcing support for SER_RS485_RTS_AFTER_SEND,
> similar to commit 068d35a.

You can line-wrap at 72 columns, and again, use more digits for the
commit, and spell out the full name of the commit.

> Fixes: 4afeced55baa ("serial: core: fix sanitizing check for RTS settings")
> Fixes: fecf27a373f5 ("serial: 8250_pci: add RS485 for F81504/508/512")
> Cc: stable@vger.kernel.org

So where does this need to be backported to, where the first commit is,
or the second?

thanks,

greg k-h

