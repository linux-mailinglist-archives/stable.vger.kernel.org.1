Return-Path: <stable+bounces-111093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9096FA219A3
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 10:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59031640F6
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 09:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DF0199EB7;
	Wed, 29 Jan 2025 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HwSqS6pT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1222179BC;
	Wed, 29 Jan 2025 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738141543; cv=none; b=uCz5OlDUU8PMluEZFx0wGkI6fIgs5vpl/zctCQa/tI9+j78a3vWWDccqLpsyMXAZvgCkW/FyQo6YrafiqHyFjuGbR90LyhplbTsqYmFIWhnbO4HL52gLlQpXw5LUohoN1A9B2AF7Uy/4trXj8sgBKq+BfNdMYqw3t09xhVzwIxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738141543; c=relaxed/simple;
	bh=Q8NTuhBVqnZu5kUxXuIu5wikBIqX+rWJ1J0b9mlGgGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6YEZUj3JV9FGlKKwDo2FogtFmQwAKtkb5pW0XejqrKjB+HYBweTGIl8imjkoBsoWcTIlNk1i/uorVEJnb8xaXRTqqJt1L//MtXBllAAOTQVV4+S0ES0PhpkDcJD/Y4ek4IR7jIUed7hbFuNagFFNu8VNSfsZM6yisN01YUHgD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HwSqS6pT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C399BC4CED3;
	Wed, 29 Jan 2025 09:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738141543;
	bh=Q8NTuhBVqnZu5kUxXuIu5wikBIqX+rWJ1J0b9mlGgGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HwSqS6pTrgoxlJiBbX+fZakG7xzd9gx26HZ1WYoFZl0HN9I4vywpeEAPemr5T9CRk
	 xcFmQEONNIsrn5jdlXSd2TuDLk/uWYa8kIk/YbltsUB89XKqggvF7zXXaYQNc6DF8M
	 jR1nYuZ6v3XIEFgLvAHZsy0W0MvyoLlkN4+Aa9Vo=
Date: Wed, 29 Jan 2025 10:04:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Cc: Konrad Wilk <konrad.wilk@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	"jgross@suse.com" <jgross@suse.com>,
	"sstabellini@kernel.org" <sstabellini@kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	stable@vger.kernel.org
Subject: Re: v5.4.289 failed to boot with error megasas_build_io_fusion 3219
 sge_count (-12) is out of range
Message-ID: <2025012956-jiffy-condone-3137@gregkh>
References: <7dc143fa-4a48-440b-b624-ac57a361ac74@oracle.com>
 <9dd91f6e-1c66-4961-994e-dbda87d69dad@oracle.com>
 <2025012919-series-chaps-856e@gregkh>
 <8eb33b38-23e1-4e43-8952-3f2b05660236@oracle.com>
 <2025012936-finalize-ducktail-c524@gregkh>
 <1f017284-1a29-49d8-b0d9-92409561990e@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f017284-1a29-49d8-b0d9-92409561990e@oracle.com>

On Wed, Jan 29, 2025 at 02:29:48PM +0530, Harshvardhan Jha wrote:
> Hi Greg,
> 
> On 29/01/25 2:18 PM, Greg KH wrote:
> > On Wed, Jan 29, 2025 at 02:13:34PM +0530, Harshvardhan Jha wrote:
> >> Hi there,
> >>
> >> On 29/01/25 2:05 PM, Greg KH wrote:
> >>> On Wed, Jan 29, 2025 at 02:03:51PM +0530, Harshvardhan Jha wrote:
> >>>> Hi All,
> >>>>
> >>>> +stable
> >>>>
> >>>> There seems to be some formatting issues in my log output. I have
> >>>> attached it as a file.
> >>> Confused, what are you wanting us to do here in the stable tree?
> >>>
> >>> thanks,
> >>>
> >>> greg k-h
> >> Since, this is reproducible on 5.4.y I have added stable. The culprit
> >> commit which upon getting reverted fixes this issue is also present in
> >> 5.4.y stable.
> > What culprit commit?  I see no information here :(
> >
> > Remember, top-posting is evil...
> 
> My apologies,
> 
> The stable tag v5.4.289 seems to fail to boot with the following prompt in an infinite loop:
> [   24.427217] megaraid_sas 0000:65:00.0: megasas_build_io_fusion 3273 sge_count (-12) is out of range. Range is:  0-256
> 
> Reverting the following patch seems to fix the issue:
> 
> stable-5.4      : v5.4.285             - 5df29a445f3a xen/swiotlb: add
> alignment check for dma buffers
> 
> I tried changing swiotlb grub command line arguments but that didn't
> seem to help much unfortunately and the error was seen again.
> 

Ok, can you submit this revert with the information about why it should
not be included in the 5.4.y tree and cc: everyone involved and then we
will be glad to queue it up.

thanks,

greg k-h

