Return-Path: <stable+bounces-172884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52A9B34B92
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 22:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA785242393
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 20:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDD0275AF0;
	Mon, 25 Aug 2025 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jqr+xFc/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627C5223DFB
	for <stable@vger.kernel.org>; Mon, 25 Aug 2025 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153051; cv=none; b=UpasNGGTCDYx3O1U9gH+th+2oq8hLF5wfpTc1BM777AivCPUFNVekz0Wu7mQ3ZFohbnkqHyJ1Mfq/4utOzo7j+YeuIGwZH26+164NonSTuHauytjy7ZaZQedXtiw0kt1EpMEljML7IH98JH9QXdmyylB+CF3xTKczXvaeznqg+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153051; c=relaxed/simple;
	bh=lyyssDivZdiQWEzacr1cJ0xJzpgvmZD+lASe9pF75/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HW9RNdEKtNy7NNsjrUo1vtY0iJR2elHTW8ntAo3BKo406W040Png/Qdhb/foPH6mslUKsRMFw/MasDYwpUitaE2wK8xixVhDlAmhdsguQFinFwj32H3/Wq89Vs51kSVbExErZ8Psb85mgJz4ymUYj3/oOKIlazT15rwniQybxkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jqr+xFc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B51C113D0;
	Mon, 25 Aug 2025 20:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756153050;
	bh=lyyssDivZdiQWEzacr1cJ0xJzpgvmZD+lASe9pF75/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jqr+xFc/XnicikeIJZO5CwHvvSwN/mWmuPfQ8OXTAnjU/CBu4a2Lu0s8ITaIZoYka
	 TJ4Y3+5g1l9Xeg0vRlIizIochXoLTcO0mdcV/aKuizT36XWPEIfxq+Kbi8mFKH7UDs
	 O1F8zus9scJZy3KX4+jKUaJXUScGuJvSRe8pOhsk=
Date: Mon, 25 Aug 2025 22:17:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: billy@starlabs.sg, ramdhan@starlabs.sg, sd@queasysnail.net,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] tls: fix handling of zero-length records
 on the rx_list" failed to apply to 5.15-stable tree
Message-ID: <2025082508-undusted-tributary-124b@gregkh>
References: <2025082443-caliber-swung-4d8f@gregkh>
 <20250825082014.0a713fee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825082014.0a713fee@kernel.org>

On Mon, Aug 25, 2025 at 08:20:14AM -0700, Jakub Kicinski wrote:
> On Sun, 24 Aug 2025 11:07:43 +0200 gregkh@linuxfoundation.org wrote:
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> This is not needed prior to 5.19.
> 
> Sorry for not including the kernel version in the stable tag.
> I suppose Fixes is not taken into account when identifying where 
> to backport the patch?

It is, but my fault, I missed that this is not in 5.15, sorry.

greg k-h

