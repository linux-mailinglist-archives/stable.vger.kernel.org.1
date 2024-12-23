Return-Path: <stable+bounces-105636-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A2E9FB0E8
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39E91882782
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 15:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5C819E98B;
	Mon, 23 Dec 2024 15:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YpqYMo+R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371027E76D
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734968967; cv=none; b=UElXFXPiYN4HRTF7Pe55fyriQ/afSRbLcQjbT/0Z0wMTi4gCLpibZqFKAMUmzq0GanaMzCOIHcFv6l+FZcY4z/YYAYrjtITOHapaCHprAvzgatwSmvaaUmC60lz8uRXmHGNIHv0PqQrfXB6wj0Xl+3Kz+MthGnBCKbMzgAb8VJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734968967; c=relaxed/simple;
	bh=d3wvAo2j+phbgnP333r7FxjZYonbsurixEGz8n3CEd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fp+XbQmzljUjkH0hVAbjIlxaRfWOubiJqUHQMZj4hPQXRnUALfz2+piPbrWhDZ2zsdehI0HKL0sAn3O4LwrMhVaQ0eiEIZVV0VbEWSNkswadLZG/2XRwC5UXSs0mauaZnu9Aahw85lpkuf7lbvD9hHtvy6QYesFjbKUgfpbL7/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YpqYMo+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE4EC4CED3;
	Mon, 23 Dec 2024 15:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734968966;
	bh=d3wvAo2j+phbgnP333r7FxjZYonbsurixEGz8n3CEd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YpqYMo+RL2jVFuyjYs95RilTSaQ82djz+WCWusTvvYGPM9urAa4UPbKwZ/VakFT3i
	 uLSLqglX0OSYdd/wdqbfmMsrSluuxG0JMeYRtoJ2lNzxwA9y0UagLM2AG2yeOXkmOJ
	 xFK2VwzHNB69Kj7JNEvIyXpM76U9wM5oyHa1tSpc=
Date: Mon, 23 Dec 2024 16:49:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas De Schampheleire <thomas.de_schampheleire@nokia.com>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org
Subject: Re: Request to port to 6.6.y : c809b0d0e52d ("x86/microcode/AMD:
 Flush patch buffer mapping after application")
Message-ID: <2024122346-dispersal-stream-f472@gregkh>
References: <Z2GZp14ZFOadAskq@antipodes>
 <2024121745-roundworm-thursday-107d@gregkh>
 <Z2LABy6mqCSdvBge@antipodes>
 <2024122345-demotion-zit-15c6@gregkh>
 <Z2lkZC_MgXe4rDRW@antipodes>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2lkZC_MgXe4rDRW@antipodes>

On Mon, Dec 23, 2024 at 02:23:48PM +0100, Thomas De Schampheleire wrote:
> I cannot currently move to 6.12 for these systems, this has other consequences
> and testing efforts.

Why?  Your testing efforts should be identical for a stable kernel
update or a movement to a new kernel version.  What is not working
properly for you in 6.12.y?

thanks,

greg k-h

