Return-Path: <stable+bounces-188914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9721BFA990
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 09:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D88D3A3B80
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 07:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD892F99A8;
	Wed, 22 Oct 2025 07:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rxtTJvaC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2597C2EBBAC;
	Wed, 22 Oct 2025 07:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761118561; cv=none; b=qYqSffVq8wuDADNvzAGdK43vtjsDDt0Ww/HK+eQLQWhM7wVwFIzS9atJaTnjzrHTIshRqlFPJ/+HGkXVufLZprpczI485YA8SqrtpnGOYIA9+IUhg7QoYGGR5VNB7P0RlOeHuWGCIPjbsOCoWVG/UVju1Sv0Fp6Vvj2jxoZgjUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761118561; c=relaxed/simple;
	bh=zsndchJOPqaYYKkkXyTd1ldUAO9IBYagYpJiLPpm+Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H053r6tBQ6nmb6+dhhsyuK6396cMJbAdJkk+aJFXoFs4jcfDcTEOscW2Ho3cQQiF5uYm2L9qqWEwKPmKoJ09/titPCuXA2y6cOMldHu7jTfpFVxQfwyN+i9rQit1o9VdlokkyWB+Ss+HJvEIeEKgCd2KPquE4vSA8yx2KjZPaOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rxtTJvaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42432C4CEE7;
	Wed, 22 Oct 2025 07:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761118560;
	bh=zsndchJOPqaYYKkkXyTd1ldUAO9IBYagYpJiLPpm+Oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rxtTJvaCvcWu5yS0t2wcS96hIPCq3xbTohSIMFJ4Vc1o+B6KW7G3qA7ZoGId1mrqM
	 fcPmQdUDPx7LTVBf3DrZAXNLx+9SLiq1ARZCqZtf9fAB1OONfjmWZj10ip7U4QAt+E
	 aIuSeU06HDDNFKQ6OIljMkl4fAJM52QPdKyfDGcA=
Date: Wed, 22 Oct 2025 09:35:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Lance Yang <lance.yang@linux.dev>, stable@vger.kernel.org,
	akpm@linux-foundation.org, david@redhat.com,
	lorenzo.stoakes@oracle.com, shuah@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.1.y] selftests/mm: Move default_huge_page_size to
 vm_util.c
Message-ID: <2025102236-dismiss-liability-4e6a@gregkh>
References: <20251022055138.375042-1-leon.hwang@linux.dev>
 <49bfd367-bb7e-4680-a859-d6ac500d1334@linux.dev>
 <2025102245-backstage-sprain-76fe@gregkh>
 <ab0c5257-bbb3-4202-bac8-3e74176fe34c@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab0c5257-bbb3-4202-bac8-3e74176fe34c@linux.dev>

On Wed, Oct 22, 2025 at 02:20:26PM +0800, Leon Hwang wrote:
> 
> 
> On 22/10/25 14:07, Greg KH wrote:
> > On Wed, Oct 22, 2025 at 02:01:26PM +0800, Lance Yang wrote:
> >> +Cc: Greg
> > 
> > I have no context here at all :(
> 
> Hi Greg,
> 
> This patch fixes a build error in the 6.1.y tree.
> 
> The mm selftests failed to build, likely because some patches were
> missed during backporting. I believe it's better to fix it directly here.

Why not take the original patches instead?  That's almost always the
proper thing to do.

thanks,

greg k-h

