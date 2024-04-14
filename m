Return-Path: <stable+bounces-39379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 666C68A42A5
	for <lists+stable@lfdr.de>; Sun, 14 Apr 2024 15:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3611B20D1F
	for <lists+stable@lfdr.de>; Sun, 14 Apr 2024 13:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4B342049;
	Sun, 14 Apr 2024 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z3OKHC7Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCBC2D61B
	for <stable@vger.kernel.org>; Sun, 14 Apr 2024 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713101702; cv=none; b=Bpq31ey6GsQ0xSCGJv8uvUt1GAARmkl0bUYP+2huCp8fJRb/riXWUC59WXDGKw3/CM+y+BFfYCv8np93gARiF3123WaxT9+PqTJc+gg1y55Iw6s6ICAq8jelp5FFW0EIEVsYcawQd6GKYDLVKZdDWUVnr5UA9Yn7iKU1q83PrZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713101702; c=relaxed/simple;
	bh=LxZGdSQhR4kxo1DLO4rLPsziywTHW1eBeiK9MWyywQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vs+lhnqH4MXm7uyamOQY4L5wdGReOYDKwLa13v3oHGvBECiPWym9DqMkOO1RHhMMnSoFawFo2+cv6UAOWIXZyICUDh3aLLo0VDaFxPO6woXgNBD6CX7sAqjF0u6CrKxFTJPTEces/Cco9qlhz0fDsQ0hHa7elIWX7WEuPHRvb1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z3OKHC7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FE5C072AA;
	Sun, 14 Apr 2024 13:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713101701;
	bh=LxZGdSQhR4kxo1DLO4rLPsziywTHW1eBeiK9MWyywQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z3OKHC7YRfmUHkvjUzTCYFO8en1v+ZjyOjV5oo78T5/CEXEA3C1JTKhJjFmt8eBiL
	 ILE9pu6viU13sm+ufUTgvSv3jd8kKcNdYqA4z2/B3e/UMelOmw/1CxQmL/CbgQvdU6
	 MKFV4KdZsXrq3YrOo3k4FZ2FohqIqOcTvdeFexOI=
Date: Sun, 14 Apr 2024 15:34:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Gong, Richard" <richard.gong@amd.com>
Cc: stable@vger.kernel.org
Subject: Re: Add commit "eed14eb48ee1 drm/amdgpu/vpe: power on vpe when
 hw_init" to kernel 6.8.y
Message-ID: <2024041450-regretful-arguably-4afd@gregkh>
References: <6be49d46-0448-4fd5-b605-b0274889e1b0@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6be49d46-0448-4fd5-b605-b0274889e1b0@amd.com>

On Thu, Apr 11, 2024 at 02:57:52PM -0500, Gong, Richard wrote:
> 
> Hi,
> 
> The commit below resolves s2idle failure on processor for AMD Family 1Ah
> Model 20h,
> 
> 	eed14eb48ee1 drm/amdgpu/vpe: power on vpe when hw_init
> 
> Please add this commit to stable kernel 6.8.y. Thanks!

Now queued up, thanks,

greg k-h

