Return-Path: <stable+bounces-65586-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1B094A9DF
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 472D02883D0
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E206F2F7;
	Wed,  7 Aug 2024 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Go+sV/oK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F6C6BFD4
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723040257; cv=none; b=D9+D6t+ud+0thYm05YPzpzHZmq2+op66kbRWdszJLhKpE2T4d0sNG6SkEOf7fKo1+LGD4q9T84+mzKDdvjVdGfuQQrYHDZxOv5SS5Hwi9ISBxVIVGEXpl4Q+DwfYeSGohZwaITM7QOoXj6TEnDSR0p5+tK3JAre+M0zaWLqH6vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723040257; c=relaxed/simple;
	bh=iAcsXK6EI7v01ZdGE28jiTgQFslxyhstjElsSsMbMEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlgJVxVjatN/1SsIQnhSX+sCYHggS7T2KfCEx5dTLNhZfPmEb9Z2uJYMzLU4pZ0elXULdB/ACqBw7ruyEIVfWvxxInVeaW9OSXD8dGRk4wVEdFTHnpaasMjruZ7dDbUszkAyceJOJJ0eC67HHUJ5JjiP8RhElIKdATH4bcyRNmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Go+sV/oK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2FDC32781;
	Wed,  7 Aug 2024 14:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723040256;
	bh=iAcsXK6EI7v01ZdGE28jiTgQFslxyhstjElsSsMbMEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Go+sV/oKOnQmQMbRlf4vuxnRvk84Ut3uSm6bI+Y/WRG201PfEvWOLccxgr9HvYajY
	 1TYxItD7xb2faWGeyUtXNk1ukM0jIdQFemder19fByA3L6xT+20R6uPCoDojup9Lo4
	 FMt45u5Oev/hcTPE8fzmsM9NqLbon+4TYyQFpFjY=
Date: Wed, 7 Aug 2024 16:17:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Filipe Manana <fdmanana@suse.com>
Cc: dsterba@suse.com, hreitz@redhat.com, josef@toxicpanda.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] btrfs: fix corruption after buffer fault
 in during direct IO" failed to apply to 6.10-stable tree
Message-ID: <2024080723-hardly-trickily-025d@gregkh>
References: <2024080730-deafness-structure-9630@gregkh>
 <CAKisOQF_g-tU8BSEvR=Phsi7OFNZH0R7ehnnj8Qam-H6OzSAow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKisOQF_g-tU8BSEvR=Phsi7OFNZH0R7ehnnj8Qam-H6OzSAow@mail.gmail.com>

On Wed, Aug 07, 2024 at 03:14:03PM +0100, Filipe Manana wrote:
> On Wed, Aug 7, 2024 at 3:03 PM <gregkh@linuxfoundation.org> wrote:
> >
> >
> > The patch below does not apply to the 6.10-stable tree.
> 
> Greg, this version applies at least to 6.10:
> 
> https://gist.githubusercontent.com/fdmanana/96a6e4006a7fe7b22c4e014bc496c253/raw/f29ff056d65ae28025fc9637f9c5773457f4bb9d/dio-append-write-fix-6.10.patch
> 
> Can you take it from there?

Nope.  Please send it in email form.

thanks,

greg k-h

