Return-Path: <stable+bounces-142973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66EEAB0A89
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22DE3506497
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 06:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E3626A0BD;
	Fri,  9 May 2025 06:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bsIx5Pqu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778A21D7E41
	for <stable@vger.kernel.org>; Fri,  9 May 2025 06:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746771796; cv=none; b=SXdd4TkRHmJQIT4UskUsyLbolQJkRFYP3Jc6/h8+XUHv7jS+h6I5Ye5lRRWaSn5O6RTEichqujGmlJ23HqNnYhTG3Q20pPvOaOYv35sad/06PPs+RmJ2k8yEMADf+47d/h0QFEL06yOp3D5SmtfI1gt5Zkd2Luzr2T9H98lD6Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746771796; c=relaxed/simple;
	bh=kn8r5q/GRTPLdDYuY2MvVda4RTpKBpgbbeySbjJy4zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPYmnUAUuclO98uodwxfDMFAVRdVKCVeaJ3gzrNC6wPEgUmkOh8O0nQHhY+GobbEuoiLIL1XXFS3fA1Il4Vz1ZDyVLxNG/4FtXuOFI02eZwL9vCK5gXd7XYgv6BR1hNjp4ePU3rxd9AnOk7GanWB5Sr1dtxM63IslzhU7VVVMeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bsIx5Pqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7111FC4CEE4;
	Fri,  9 May 2025 06:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746771795;
	bh=kn8r5q/GRTPLdDYuY2MvVda4RTpKBpgbbeySbjJy4zU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bsIx5PquXTsYF4KdcLXF4h9HN6XKRKG33XZtoIId38Os5lhrquYD/R7zvnwiw9OTG
	 p13Ro6ba76ApZ8QJzEyHzDEt4VQzitr7rvVl1nr0vfWSLv1kRN0t/3i24X7yXGg2Yz
	 etz39BrwmLgB+TCQ3uQYU9JYT1K4m78XATVGJufI=
Date: Fri, 9 May 2025 08:23:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 6.12.y] mm, slab: clean up slab->obj_exts always
Message-ID: <2025050957-pronto-overnight-20ed@gregkh>
References: <20250505232601.3160940-1-surenb@google.com>
 <20250507082538-05e988860e87f40a@stable.kernel.org>
 <CAJuCfpEdkkZd8RSZUPsXkq3BXzDvebfSHuF4T=AoRHDv8hgJzg@mail.gmail.com>
 <aBzmyRU6EXuuYCJu@lappy>
 <CAJuCfpGoto6chqWSN_FET4isyLfioKzxadEQbLyKYzXTwCo+FA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGoto6chqWSN_FET4isyLfioKzxadEQbLyKYzXTwCo+FA@mail.gmail.com>

On Thu, May 08, 2025 at 06:14:26PM +0000, Suren Baghdasaryan wrote:
> On Thu, May 8, 2025 at 5:15 PM Sasha Levin <sashal@kernel.org> wrote:
> >
> > On Thu, May 08, 2025 at 05:04:45PM +0000, Suren Baghdasaryan wrote:
> > >On Thu, May 8, 2025 at 4:18 PM Sasha Levin <sashal@kernel.org> wrote:
> > >>
> > >> [ Sasha's backport helper bot ]
> > >>
> > >> Hi,
> > >>
> > >> Summary of potential issues:
> > >> ⚠️ Found matching upstream commit but patch is missing proper reference to it
> > >
> > >Not sure why "patch is missing proper reference to it". I see (cherry
> > >picked from commit be8250786ca94952a19ce87f98ad9906448bc9ef) in place.
> > >Did I miss something?
> >
> > It tries to find one of the references described in the docs for
> > submitting stuff to stable@:
> >
> >         https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3
> 
> Ah, I see now what I missed. Thanks!
> Would you be able to add the reference or should I repost the backports?

No need, it's already in the queue for the next round of stable releases
in a few hours.

greg k-h

