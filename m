Return-Path: <stable+bounces-66549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DF494EFC0
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA072B2235F
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945C318132A;
	Mon, 12 Aug 2024 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kXkm0NEp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B7E17E8E2
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473479; cv=none; b=WK3kKk8rgQ8DNIEgcc5V12aZXuFrMNHGB508uH13dvAbKXmTTrdGcnjjQbxYam/flY0uHVj20PUP9l3EKsnYH+VISK4QTvW8X4X6J5Ic4sCBw9DEScG+w1mwbO5YLZnat5prxZhKZx4dKKYkddeNE5K7Dzp0rX0OU1Os7BsvQCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473479; c=relaxed/simple;
	bh=J33ODb0jdMvjGXfb18N7gUExMr1Pv8FO7J+BGOW5v+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWB90paEkLJJeEpD96N9I+ugHj2XtCq8TwUu8to/UjlaLGoyqSzxO5slBhQkK2uJ2ptRC+2OKlhYS+C5J52LLtteHl5SR3gHrn8nTdKYrNBEGTZpCA4d4aWFc63MfgJFGNmgDcXvAoUyC7XpGNxNfa4fdcOr5hLxQllbL7LGP8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kXkm0NEp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86056C4AF0D;
	Mon, 12 Aug 2024 14:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723473478;
	bh=J33ODb0jdMvjGXfb18N7gUExMr1Pv8FO7J+BGOW5v+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kXkm0NEpf4kQbZnomlRPANxhd/3X5UuUXyWhN5Wb3jnnmxZ297yJCV1i/1vxAsyjN
	 hEpL1wcHOynepItstH2X9yY/Wi4r5XY1TcOoT78AOubpxIh7FJJAIk/67IO/pk2YYH
	 z/UDBLSF9fGkBzyFr+sKELedS5teZE9JzJ5JPvYc=
Date: Mon, 12 Aug 2024 16:37:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado <sergio.collado@gmail.com>
Cc: stable@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Manas Ghandat <ghandatmanas@gmail.com>,
	syzbot+6b1d79dad6cc6b3eef41@syzkaller.appspotmail.com
Subject: Re: [PATCH 6.1.y] jfs: define xtree root and page independently
Message-ID: <2024081227-habitat-cough-dfb0@gregkh>
References: <20240730201315.19917-1-sergio.collado@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240730201315.19917-1-sergio.collado@gmail.com>

On Tue, Jul 30, 2024 at 10:13:15PM +0200, Sergio González Collado wrote:
> From: Dave Kleikamp <dave.kleikamp@oracle.com>
> 
> [ Upstream commit a779ed754e52d582b8c0e17959df063108bd0656 ]
> 
> In order to make array bounds checking sane, provide a separate
> definition of the in-inode xtree root and the external xtree page.
> 
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
> Tested-by: Manas Ghandat <ghandatmanas@gmail.com>
> (cherry picked from commit a779ed754e52d582b8c0e17959df063108bd0656)
> Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
> Reported-by: syzbot+6b1d79dad6cc6b3eef41@syzkaller.appspotmail.com
> ---

What about 6.6.y?  We can't take commits only to older kernels, that
would mean you would have a regression.

Please resubmit for all relevant branches.

greg k-h

