Return-Path: <stable+bounces-105118-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3AD9F5EDD
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 07:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C206116BC46
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 06:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E845C1553BC;
	Wed, 18 Dec 2024 06:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZNxosPpN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D4F154457
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 06:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734504769; cv=none; b=OGJnFUyJ6V3G5jz/Vq02AczYFUZuQhQbQQa5ZkB8sm4gM5T92xAsl4ih5lN8F68AAPAlxa5uOlTE4KjhjoeUP4hR0f1S+c+9nUIUcsoV0crctuMuq+JqDZq7Kgpee4b0S4mgXisOF+ASN+LlkmB8ZTNcu0bfd/3HfNYhe+0jsm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734504769; c=relaxed/simple;
	bh=JeCCIouZu23ZKnvVaCAJUitqcKF2AsGRefdtpLEGEB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCeeIV4syWgYrBQda8Ugd5zTgjODXHg/urlXsKjlgDwmra3WBRWShp3nQ4BXtBsbiw6GIGsxf77H49qdH2Nm9H1cKDyDNzJTkCNvQkVCJVBHX11jap9oNb0vJm9SH3sXV2EylV4PQjHE73p5rhAS8rLaGBrAR3jcjp+byTPPD2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZNxosPpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AAEC4CECE;
	Wed, 18 Dec 2024 06:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734504769;
	bh=JeCCIouZu23ZKnvVaCAJUitqcKF2AsGRefdtpLEGEB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZNxosPpNkVlIaT0byojcrIJSWep4nT15S47lV+hMD2q5gynfZt/qdy4wmIP8uBWvV
	 C68bo9XEn597HJu0PRRy9trbhGBNGKvI8XiYHt5Oth0FUjygCBHsr1fRfq57L3+X8O
	 PXIJpbjZDlHvR43QBAklozqOr6+3Kx/ZBWwiS12w=
Date: Wed, 18 Dec 2024 06:16:15 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Gohil <hgohil@mvista.com>
Cc: stable@vger.kernel.org
Subject: Re: request to backport this patch to v6.6 stable tree
Message-ID: <2024121858-puma-thinning-6f65@gregkh>
References: <CAH+zgeEVr3g23gtcbHtQnUpC5R2uDZ3T56wzx3g9cNnvOZ-+HA@mail.gmail.com>
 <2024121203-blinking-unblock-b85a@gregkh>
 <CAH+zgeE8Afr6EQTR3iYNnY9ESPcQWEW0nsGE4cAQsj-X_Jn2WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH+zgeE8Afr6EQTR3iYNnY9ESPcQWEW0nsGE4cAQsj-X_Jn2WQ@mail.gmail.com>

On Wed, Dec 18, 2024 at 10:35:51AM +0530, Hardik Gohil wrote:
> On Thu, Dec 12, 2024 at 2:07 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > It does not apply cleanly at all, so obviously you didn't even test that
> > this worked :(
> >
> > {sigh}
> 
> The dependency patch for this fix is
> fb6e30a72539ce28c1323aef4190d35aac106f6f (net: ethtool: pass a pointer
> to parameters to get/set_rxfh ethtool ops)

I have no context here :(

Please submit a set of working patches that you have properly tested.

thanks,

greg k-h

