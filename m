Return-Path: <stable+bounces-139692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B06AA94CB
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 15:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036A03AB9A0
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 13:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367D51B3930;
	Mon,  5 May 2025 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iPglz5wQ"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989502AEF1
	for <stable@vger.kernel.org>; Mon,  5 May 2025 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746452866; cv=none; b=kivJ/Nnn5pc4dedAXUkoBx4gZSRG4iQwrjlPKxfvVhxEC+Q4ybtYUbuNbqaU9fREF43he4Gsy+rxUIPpX6KbmyHYQY9rHhNFpwzxycAF0X+92q8p/JDVcbE4lrKpI4WHk0tXEPRNpTE3rU0NdwgFzyc5Gx9SRKhqzlEyX+A7nbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746452866; c=relaxed/simple;
	bh=iDsRxSFvGWZ8iQEZ9ojsqDzP0pxMucQYMQt9RC6MJ9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkGRk8guZFszdip1zfXvOPRyOG+hTeJ0tOUzh9bYubjqASK+8ANhFAyKvgQlxoFM3QCggNL/EmoCihM0Xc4MjaFTNPEm7051bRWFUjmmlG459d6oYZ+sy4IW1RroGIUvOYgQlYw3wVXQkwKg4AfSHIU7oLNocjPq1tbTp6zwI/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iPglz5wQ; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 5 May 2025 09:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746452850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qx48PhTzO3rF8uO6a5XOUaOk0R2RKacTt2lUffp+V+g=;
	b=iPglz5wQ7jnT66FGn5mLhd/ISfsdxSutntI1MaNU+mPhWifoQmG3ZZgE/cblYHzCcILgWz
	0sb9Tk/HoWCM8anvE73bQA9N5axH2BGrLXrd3qLM2W7y3TrkA4960N8ReAwzXSE6KQTMJn
	pnrZnZyv/5a+P6T+yUfwUWEkxConGs0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-bcachefs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.14.y
Message-ID: <idtrv7crzcpdlcxgysaqwfg6c2rb5bw4ymdwiejkjluask236b@i7aryq6kn2c6>
References: <hbrzmt73aol6f2fmqpsdtcevhb2sme6lz2otdn73vqpsmlstzt@egrywwkbtpfm>
 <2025050523-oversweet-mooned-3934@gregkh>
 <2025050558-subtly-swifter-fbed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025050558-subtly-swifter-fbed@gregkh>
X-Migadu-Flow: FLOW_OUT

On Mon, May 05, 2025 at 10:34:35AM +0200, Greg Kroah-Hartman wrote:
> On Mon, May 05, 2025 at 10:32:49AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, May 02, 2025 at 09:12:22PM -0400, Kent Overstreet wrote:
> > > 
> > > The following changes since commit 02a22be3c0003af08df510cba3d79d00c6495b74:
> > > 
> > >   bcachefs: bch2_ioctl_subvolume_destroy() fixes (2025-04-03 16:13:53 -0400)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://evilpiepirate.org/bcachefs.git tags/bcachefs-for-6.14-2025-05-02
> > > 
> > > for you to fetch changes up to 52b17bca7b20663e5df6dbfc24cc2030259b64b6:
> > > 
> > >   bcachefs: Remove incorrect __counted_by annotation (2025-05-02 21:09:51 -0400)
> > > 
> > > ----------------------------------------------------------------
> > > bcachefs fixes for 6.15
> > > 
> > > remove incorrect counted_by annotation, fixing FORTIFY_SOURCE crashes
> > > that have been hitting arch users
> > > 
> > > ----------------------------------------------------------------
> > > Alan Huang (1):
> > >       bcachefs: Remove incorrect __counted_by annotation
> > > 
> > >  fs/bcachefs/xattr_format.h | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > You list 1 patch here, but if I pull this, I see 2 patches against the
> > latest linux-6.14.y branch.  When rebased, the "additional" one goes
> > away, as you already sent that to us in the past, so I'll just take the
> > one that's left here, but please, make this more obvious what is
> > happening.
> 
> Also, as this single commit is a revert of something in 6.12.y, should
> it also be applied there to remove any false-positives happening with
> those users?

yup, pull request inc

(missed this because all the reports have been on 6.14, but no doubt
that's because gcc-15 has only recently been rolling out)

