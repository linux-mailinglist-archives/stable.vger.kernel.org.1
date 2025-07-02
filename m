Return-Path: <stable+bounces-159214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1738EAF10FE
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 12:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45C3B7B6D13
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D3E24DD18;
	Wed,  2 Jul 2025 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uRtTu/8R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30C32367D3;
	Wed,  2 Jul 2025 09:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450374; cv=none; b=tvdMLAq5nemdQHTf4ySrTx4Qgonk5YJaUNNz+1EDAOkrJBUIsk3ykAsEghMxUYW/e0oT704EyKAxvr0+RcluM9/CXRFv8LM+yDQbA0JElRe4x7WA9FWkw3oZzdqT7XNdoOKWjYZcKRLJXm78KoNotT8pgRDgA2dIlHxJsGJo8sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450374; c=relaxed/simple;
	bh=XMRpAQktxm89XHWwG+GVWrLa/+SVU+1NbDCJeQP02g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0iW64fE/PUIrbQqLx8hALov510gnEj/IX5PgfJXEhjLhlKZhbGf47/57WHleR4s4R3c9H2yHGiOkASxkFoCSw1wIkkNYWUFKUNkJ/ZuLt4WuWhIMovN4ds9E/bvzTpxWA9XK9TONmxSdRcth4GM4rX4f+hFTMIkXKCBD1G6Am8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uRtTu/8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CAFC4CEED;
	Wed,  2 Jul 2025 09:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751450373;
	bh=XMRpAQktxm89XHWwG+GVWrLa/+SVU+1NbDCJeQP02g4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uRtTu/8Rz2dABAnJUBZ0lc0kXLk/vshuNaa3QGDbSCIA2SmW54L5ayP+uWNxkCB4f
	 VvzoZN17/fbTi66eV+agU76Vyeya+FH803y9R6sNVrSOMM31l0opOOGhe7P4f5vFlQ
	 l2A95ncM9WQjqV3uBRgKWEkFtbRygo3ZzYPbmFPw=
Date: Wed, 2 Jul 2025 11:59:30 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Brett Sheffield <brett@librecast.net>
Cc: Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: 6.12.y longterm regression - IPv6 UDP packet fragmentation
Message-ID: <2025070216-duplex-ecologist-20ce@gregkh>
References: <aElivdUXqd1OqgMY@karahi.gladserv.com>
 <2025061745-calamari-voyage-d27a@gregkh>
 <aFGl-mb--GOMY8ZQ@karahi.gladserv.com>
 <CA+FuTSen5bEXdTJzrPELKkNZs6N=BPDNxFKYpx2JQmXmFrb09Q@mail.gmail.com>
 <2025062212-erasable-riches-d3eb@gregkh>
 <aFfO8a7vS1jeBonh@karahi.gladserv.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFfO8a7vS1jeBonh@karahi.gladserv.com>

On Sun, Jun 22, 2025 at 11:37:53AM +0200, Brett Sheffield wrote:
> On 2025-06-22 11:10, Greg KH wrote:
> > On Tue, Jun 17, 2025 at 02:25:02PM -0400, Willem de Bruijn wrote:
> > > FWIW, I did not originally intend for these changes to make it to stable.
> > > 
> > > The simplest short term solution is to revert this patch out of the
> > > stable trees. But long term that may give more conflicts as later
> > > patches need to be backported? Not sure what is wiser in such cases.
> > 
> > For now, I've applied the above 2 to the 6.12.y tree.  They do not apply
> > any older.  If I should drop the change from the older stable trees,
> > please let me know.
> 
> Thanks Greg.
> 
> For the older stable trees I agree with Willem that reverting the patch is the
> simplest fix.
> 
> As it stands UDP is broken in the older stable trees, so if this can make it
> into the next stable release that would be a good thing.

Ok, can someone send me reverts for the needed branches?

thanks,

greg k-h

