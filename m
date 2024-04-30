Return-Path: <stable+bounces-41813-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C378F8B6C61
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 10:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3CB61C222CA
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 08:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0751F4085A;
	Tue, 30 Apr 2024 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hoO+GWhE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80723FE51;
	Tue, 30 Apr 2024 08:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714464091; cv=none; b=rRt/+OCjfs7NPEtnp+ZPeAGiSwCxPJONf9jjZsUiErWknIx+vZ/bztXqrJNXlFkiCikM8s5CMV33gWywWMCyPi7+MhBqXkIQ/p56hQIjfXv6SV8lAfMLH7llJAWWtc/HkQzli2bs1NqymA8+ud9xEaN9hrc0ZeenpytITU6GSgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714464091; c=relaxed/simple;
	bh=Ivf8CZAnBx0jRErie+QIQroeMkAJvGihEtDiGqm7Dds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVOyEDHWi80T6cA2rBF06THB/9ZRNRk6PlaBOpyj7QJAq4kde5JQyCe0mQGcX9rtdXIyvStKYAg28UiNl7NGzLfNHKI02O4MhZnmWjWhlDyzucXrV0kwM94pRGJuHKAgnDFd6SIbUVN7MbEgoN/U3hf04CL30DLD0YJcUvaoMc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hoO+GWhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AA9C2BBFC;
	Tue, 30 Apr 2024 08:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714464091;
	bh=Ivf8CZAnBx0jRErie+QIQroeMkAJvGihEtDiGqm7Dds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hoO+GWhE3pNtmESPSyptY4Q+9eF/VnvIxRJAH/plQ8QkenRkbjc1kPNDHASEn1xIo
	 lCrqyDfnQ1rK3o4LIjRGKMOJSS/3lVMVK+NxDV0UOnfBO72fvlvPIztprguPTG+Zce
	 3Tjl8LUT0q6+Nvd6dwrC05/+EDAZEU2xle9qD+0Q=
Date: Tue, 30 Apr 2024 10:01:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Atishya Jain <atishyajain.it@gmail.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Kernel Issue: Wrong EFI Loader Signature followed by Kernel Panic
Message-ID: <2024043036-encourage-attractor-a889@gregkh>
References: <CAAwq=D4tUP65CNLuYib_YFBYwz2mYNw+wXzAyacf+tJ18Op2eA@mail.gmail.com>
 <2024043037-capture-trench-3611@gregkh>
 <CAAwq=D4-VY8mqRxu2TVeoavOOvB4DMgxGzASjiBm3bvbW_5g2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAwq=D4-VY8mqRxu2TVeoavOOvB4DMgxGzASjiBm3bvbW_5g2Q@mail.gmail.com>

On Tue, Apr 30, 2024 at 01:20:27PM +0530, Atishya Jain wrote:
> XDP is used for Fast Packet Processing which is only on the RX path of the
> kernel . XDP on TX path is not supported by the kernel .
> Mail list for egress XDP : (Add Support of egress XDP patch )

If you rely on external changes, please work with the developers of
those changes, nothing we can do about them.

> So I Extracted the patch from it and first Applied on the latest Version
> only but got many failed to patch messages so I looked for different
> versions and 5.4 got matched almost perfectly .

Again, 5.4 is VERY old, and probably is doing something wrong with the
efi stuff that your system is expecting.  Please try a more modern
kernel version please.

good luck!

greg k-h

