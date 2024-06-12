Return-Path: <stable+bounces-50281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 366689055BC
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 16:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDA5128B47B
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBF217F36D;
	Wed, 12 Jun 2024 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zdO1TG77"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EABB17F363
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203823; cv=none; b=r99qFEmIuQjkTEk2RQXbqqHKGIEQgumLDQxc42L1aUZGlosJX/B22TBbixx2Hn7bHK6ILUTEfXlekvAnrPT4Me00YS3aYl3RGl8JW66XnHTCH0xIq3RqLjeAEuhLH54IhSu9SjsruMPp6P37chR0PGg3smYy2nw+YJnA5yOhcVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203823; c=relaxed/simple;
	bh=LlFXj3XHYq3xIqZ13vx4Ibe66yVgx4m4n5Udvq0JgAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQ7dR0AUwyYfVuIzvG4fOXSyEaKZfmuh0MP8l8XAv0KmuZ/4zFusjdkiEJ9Ah7ZzaPTDq4YXFadzdr37vmaBzxQrRGJMM/U5jH1ytaiTxwZ4wVP6M2oO4MlulH+6pvkNW4gDijBypPFnZ7adOsUjsZPJ1UrIyn9EdkP2nHZC9SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zdO1TG77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60A6C116B1;
	Wed, 12 Jun 2024 14:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718203823;
	bh=LlFXj3XHYq3xIqZ13vx4Ibe66yVgx4m4n5Udvq0JgAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zdO1TG77sgRo6HxKXGKW3NY9tGYTZ3n7z+99hGwg2USqmEWYF2RvicMMP2Vp5XAIp
	 WSFFkFkPA5aZxnqmBamBiX1QjuChSIjaoCgbFapjAwSP0GXwkEhhpr8+71vOTO31Et
	 rfk7k/rcReZp1DylSuIOajd+oL6ZYMuwcLh2zrhU=
Date: Wed, 12 Jun 2024 16:50:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ronnie Sahlberg <rsahlberg@ciq.com>
Cc: stable@vger.kernel.org
Subject: Re: Candidates for stable v6.9..v6.10-rc1 KASAN
Message-ID: <2024061247-jasmine-uptake-0ccc@gregkh>
References: <CAK4epfyYE=4PubEzyZw-LoSU6kuD3UCpHOWH8cWjw2pHxj19Bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK4epfyYE=4PubEzyZw-LoSU6kuD3UCpHOWH8cWjw2pHxj19Bw@mail.gmail.com>

On Thu, May 30, 2024 at 09:14:04PM -0400, Ronnie Sahlberg wrote:
> These commits reference KASAN between v6.9 and v6.10-rc1
> 
> These commits are not, yet, in stable/linux-rolling-stable.
> Let me know if you would rather me compare to a different repo/branch.

Nope, this works!

> 
> The list has been manually pruned to only contain commits that look like
> actual issues.
> If they contain a Fixes line it has been verified that at least one of the
> commits that the Fixes tag(s) reference is in stable/linux-rolling-stable
> 
> 195aba96b854dd664768 KASAN, Out of bounds
> 2e577732e8d28b9183df Kernel panic, KASAN
> 20faaf30e55522bba2b5 KASAN, Syz Fuzzers, Out of bounds
> c1115ddbda9c930fba0f KASAN, NULL pointer

I've queued up the ones that were not already in releases.

thanks!

greg k-h

