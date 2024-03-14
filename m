Return-Path: <stable+bounces-28211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED5787C520
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 23:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 802A91C21357
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 22:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D6B768F3;
	Thu, 14 Mar 2024 22:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IZ4465Cl"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B281A38EE
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 22:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710455309; cv=none; b=Q9YRNMd6mK93jpzGstrC7Zk1QZ8LTS9PylCunD7B8XCJmWt50cJV4MMibyuMRe8o/+jrnyd+U/m5ncazwHBJHjtMv0dKGVTnj3E6aPfeJ/GJ3uparJrqdJvdgpoq1/np9tqL3SHOeNvG+G1NR5YjT1no75GAsVnfLDU1geFWU9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710455309; c=relaxed/simple;
	bh=zCDtOs0kKSR8Boqa5NoAF7xegf7qu2eynD+erkERzq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDTLAYu4o7mgtIkm+H2gQzmH1L9QmN7++Do/w6vm3erXMSGHhf3kX3gWUGkrH0lvoG0qlnnGcnRsGklFOy5yRD10qvEy+UHp2kkm6P1FzNfSqWQZ5JpU3ht4l9K/XU2eUQTv62iQfXP/tOv4urI76e23Q7DaLVsEUD6s65vodoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IZ4465Cl; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Mar 2024 18:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710455305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Z1kRO6+tYwb971I8a42ToeAKVO9wRQom+8ZGNcHgjw=;
	b=IZ4465Cldw1X1SZU346jDiai2kY5GdIbaK+9bzB+oqfvEGCjm/J/asH2BEdscBCgPd4tfz
	BZ6XDzxmqaDKp+SJOt1Q65nd2nXcVHFs+mD4zMqJF6+E1QYElRdwqVVIuYpfq0nq2KygsD
	6fN5/WVHNRot5rZC8B4UEUZtfLbsBA0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Helge Deller <deller@gmx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, Helge Deller <deller@kernel.org>
Subject: Re: bachefs stable patches [was dddd]
Message-ID: <thnbm5zupofog4iyhngtrbgzw7ewbzpxwyngrwrgmleax7f5gw@bshmpb2umowr>
References: <ZfLGOK954IRvQIHE@carbonx1>
 <vubxxvlsgyzzn64ffdvhhdv75d5fal5jh5xew7mf7354cddykz@45w6b2wvdlie>
 <ed1eda66-8d67-4661-b50f-f2b152928bf3@gmx.de>
 <2vpsaj7bwn5yvpyerexgga3m22wvqfom32hbc3cics4vrs6lbm@gc47zhr756sr>
 <77fd3622-8b01-418f-9dab-2ab23a3a844e@gmx.de>
 <rgwqmfpfcpcnmoma5by4qf6c5ehugdz2uijkffdwq2cdhingqy@7676cbvj34vl>
 <96db0a2e-ba5d-4d78-be69-14414d6bb5ca@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96db0a2e-ba5d-4d78-be69-14414d6bb5ca@gmx.de>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 14, 2024 at 11:25:28PM +0100, Helge Deller wrote:
> On 3/14/24 23:19, Kent Overstreet wrote:
> > On Thu, Mar 14, 2024 at 10:34:59PM +0100, Helge Deller wrote:
> > > On 3/14/24 20:08, Kent Overstreet wrote:
> > > > On Thu, Mar 14, 2024 at 01:57:51PM +0100, Helge Deller wrote:
> > > > > (fixed email subject)
> > > > > On 3/14/24 10:46, Kent Overstreet wrote:
> > > > > > On Thu, Mar 14, 2024 at 10:41:12AM +0100, Helge Deller wrote:
> > > > > > > Dear Greg & stable team,
> > > > > > > 
> > > > > > > could you please queue up the patch below for the stable-6.7 kernel?
> > > > > > > This is upstream commit:
> > > > > > > 	eba38cc7578bef94865341c73608bdf49193a51d
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > Helge
> > > > > > 
> > > > > > I've already sent Greg a pull request with this patch - _twice_.
> > > > > 
> > > > > OIC.
> > > > > You and Greg had some email exchange :-)
> > > > > 
> > > > > Greg, I'm seeing kernel build failures in debian with kernel 6.7.9
> > > > > and the patch mentioned above isn't sufficient.
> > > > > 
> > > > > Would you please instead pull in those two upstream commits (in this order) to fix it:
> > > > > 44fd13a4c68e87953ccd827e764fa566ddcbbcf5  ("bcachefs: Fixes for rust bindgen")
> > > > 
> > > > You'll have to explain what this patch fixes, it shouldn't be doing
> > > > anything when building in the kernel (yet; it will when we've pulled our
> > > > Rust code into the kernel).
> > > 
> > > Right. It doesn't actually do anything in the kernel (which is good), but
> > > it's logically before patch eba38cc7578bef94865341c73608bdf49193a51d
> > > and is required so that eba38cc7578bef94865341c73608bdf49193a51d cleanly
> > > applies.
> > 
> > yeah I just fixed the merge conflict
> 
> Where did you fixed it?
> Those two patches are already upstream, and ideally should go downstream as-is...

https://evilpiepirate.org/git/bcachefs.git/log/?h=bcachefs-for-v6.7

