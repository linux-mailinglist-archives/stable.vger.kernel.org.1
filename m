Return-Path: <stable+bounces-19725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CEF8532D1
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 15:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1304D1F22B94
	for <lists+stable@lfdr.de>; Tue, 13 Feb 2024 14:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDED5731B;
	Tue, 13 Feb 2024 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OvgAiawu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E715786C
	for <stable@vger.kernel.org>; Tue, 13 Feb 2024 14:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833860; cv=none; b=PxmnwbZbY0OdPTDqpCX5YBUvVlaIhqR3XznoZeRf6ufXeCTjHidAGtcBAJCYeirC8JXoS6iH5tOSPtozUq05LivDcLcQATnlXTURxWU7/XO+eRYC+Sb5/+HS1+B6U46gEuvS7uLfPUrPc460Lai8nK8v/T5NH6zsExu65Bwk/Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833860; c=relaxed/simple;
	bh=SOXRPXDth3TVihcnsdb0v1OxK8ixQ4VePcocqVeIHLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kDkp4KJsXm17KcLd3Uxv0L2/WTQ+ftjZ7++Oqj8JBkNL36lxwugBX5NNLsbb3Vg95KqxD08n0xqJgMN3wstxB07gbTlDGYmjNaJJFErbvQUg7knH6RW/mD3DTvCZtweUPtoUE6JMTS/dayhtRZFuEJtnFsNC4t8p7f2TyxiI1Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OvgAiawu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F903C433F1;
	Tue, 13 Feb 2024 14:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707833859;
	bh=SOXRPXDth3TVihcnsdb0v1OxK8ixQ4VePcocqVeIHLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OvgAiawuRZexoPQ90yhzQK6D39111+upHhldSLkHuoWbK/27427CSHg2Il+niCYVa
	 ExqGyegsgB1JBHNiPjb++Yput4WV7mlgLlTuRgETiORXM8DFBeD7LSKWgyTPnl7fqn
	 Kr96YIShELXp8wHm2Bt3t8MX49zcm6cx1fYCdgMM=
Date: Tue, 13 Feb 2024 15:17:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?utf-8?Q?Micha=C5=82?= Pecio <michal.pecio@gmail.com>
Cc: mathias.nyman@linux.intel.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] xhci: handle isoc Babble and Buffer
 Overrun events properly" failed to apply to 5.10-stable tree
Message-ID: <2024021351-overstay-crisply-f6af@gregkh>
References: <2024021308-hardness-undercook-6840@gregkh>
 <20240213143921.25a6f291@foxbook>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240213143921.25a6f291@foxbook>

On Tue, Feb 13, 2024 at 02:39:21PM +0100, Michał Pecio wrote:
> Hi,
> 
> > The patch below does not apply to the 5.10-stable tree.
> > [...]
> > From 7c4650ded49e5b88929ecbbb631efb8b0838e811 Mon Sep 17 00:00:00 2001
> > From: Michal Pecio <michal.pecio@gmail.com>
> > Date: Thu, 25 Jan 2024 17:27:37 +0200
> > Subject: [PATCH] xhci: handle isoc Babble and Buffer Overrun events
> 
> This patch depends on its parent 5372c65e1311 ("xhci: process isoc TD
> properly when there was a transaction error mid TD.").
> 
> The parent commit appears to be missing from your 5.10 and earlier
> queues for some reason, hence the breakage.

That parent commit would not apply to those older kernels (and I had no
hint that it should go there.)  I've backported it to 5.10.y ok, but 5.4
and 4.19 were harder.  So if you want both of these in those older
kernels, please provide working backports and I'll be glad to queue them
up.

thanks,

greg k-h

