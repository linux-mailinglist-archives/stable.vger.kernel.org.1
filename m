Return-Path: <stable+bounces-132654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8C0A889F4
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 19:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4DC21898D9B
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 17:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963DC288C90;
	Mon, 14 Apr 2025 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y5xfS4ej"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9EA19F438;
	Mon, 14 Apr 2025 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744652262; cv=none; b=YE5E/f+ghM/S5f6p2cKMcywX+oHMOD7oLavQLLFbQD0NbFvUnNEOuKFYcOPmBlp9NA75Z8a33IC7MiJXVRCVVZ1HNaXe9Omr5eWTwsnym/cZArtwDU5S/6rWsL+jNL9/7eGDWqtDKs0cLTl4thnvXfCxzTo7gPhFBfUtVIlvDsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744652262; c=relaxed/simple;
	bh=m7xOIfsgNMothsqizkGy2Vv5fvaA9k1wGGQA0Y1ZR0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpCKQ3mR7qI0NuvpmWM4DNLOy9vYGKtn3YoNz2ZJnwFgO9PPgchtPpBtjzoZ28xNb0kaz/L9LkOKZWpT6aspyIxKZger71xiEfkawqLk0Qw7KmSSR+nGdOkScfrjO/jMyAje4dzHSAW5QK3SQT7NoBoW6tsqQk0WURhKLQV5uEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y5xfS4ej; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3906AC4CEE2;
	Mon, 14 Apr 2025 17:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744652261;
	bh=m7xOIfsgNMothsqizkGy2Vv5fvaA9k1wGGQA0Y1ZR0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y5xfS4ejvcZn4gds472hBvOb9lnQgP/gTPaJs9mtFGCk/r49GLQTNYuvr+N7RemL+
	 zTXvh0zCp5oFPNiFDkKf7V8GM73tJRNged1H4AM5SI3OQIozKddRaX8H/Mj+dTbwRb
	 0WPzfaCA6Kcb7wewr8RSpXTzD4AH8uKKq6H8eTA0=
Date: Mon, 14 Apr 2025 19:37:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Patch "x86/mm/ident_map: Fix theoretical virtual address
 overflow to zero" has been added to the 6.14-stable tree
Message-ID: <2025041417-playful-detention-2aaa@gregkh>
References: <20250414103727.580274-1-sashal@kernel.org>
 <nk543is45cokcdjnnovpopirhqlejfp3xgzs4wdpjyyskumw5w@fbw5bqq3x3mt>
 <2025041450-filled-varnish-f9d3@gregkh>
 <zsvsv723jviiktxgjfpevjq3fzdmn36pavhkrv3dkwq7pegghe@tbaz4aqkdgt3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zsvsv723jviiktxgjfpevjq3fzdmn36pavhkrv3dkwq7pegghe@tbaz4aqkdgt3>

On Mon, Apr 14, 2025 at 02:59:11PM +0300, Kirill A. Shutemov wrote:
> On Mon, Apr 14, 2025 at 01:56:00PM +0200, Greg KH wrote:
> > On Mon, Apr 14, 2025 at 02:36:55PM +0300, Kirill A. Shutemov wrote:
> > > On Mon, Apr 14, 2025 at 06:37:27AM -0400, Sasha Levin wrote:
> > > > This is a note to let you know that I've just added the patch titled
> > > > 
> > > >     x86/mm/ident_map: Fix theoretical virtual address overflow to zero
> > > > 
> > > > to the 6.14-stable tree which can be found at:
> > > >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > > > 
> > > > The filename of the patch is:
> > > >      x86-mm-ident_map-fix-theoretical-virtual-address-ove.patch
> > > > and it can be found in the queue-6.14 subdirectory.
> > > > 
> > > > If you, or anyone else, feels it should not be added to the stable tree,
> > > > please let <stable@vger.kernel.org> know about it.
> > > 
> > > It was explicitly called out that no backporting needed:
> > > 
> > > >     [ Backporter's note: there's no need to backport this patch. ]
> > 
> > Now dropped thanks,
> 
> BTW, is there any magic words for this? Tag or something?

No, you did it right, we just missed it, sorry.  That's why we have
reviews and send these emails out :)

