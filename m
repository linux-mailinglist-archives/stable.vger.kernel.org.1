Return-Path: <stable+bounces-121719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5AAA599CF
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 16:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891F918887EC
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 15:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7F422D78A;
	Mon, 10 Mar 2025 15:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="REa9zp1T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8E922D4F4
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620098; cv=none; b=Y2rGv1tiIOiAGf6JAjipp0fHmdVAJsWNGz3/4F5Pgq0aj3UFwgJ5JZTCR5XBpG0ynE9pilLN3cg2BiI4XW0UnVUkbjeG1+V7CBSeEz1q3r9vqrl0pQNVFeEE4thw4Hw0J6K5A/o/H9LX30nKntV2xdKqAP3Krf1uAYcSjQRZS4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620098; c=relaxed/simple;
	bh=LcX+y03stgK7EjoyVi8Ewm0Yynhc7tSHjo31aJdg+/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ko422bFTOgVYeseCe7S+Q9YCDLFlnkOrOWV0hDN0l3nctyPHGCatoSHnfyIAvbRSD4tj6/8e2s2r3fv/NwrA5vWACFqB5fw9YXowSs0D7dcgC/Sb6pdLAnBu/9QC9d6Plw4ZVJSfWy4OzXvE//ad1nBWnUkhuKScaByubxiezUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=REa9zp1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46506C4CEEE;
	Mon, 10 Mar 2025 15:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741620097;
	bh=LcX+y03stgK7EjoyVi8Ewm0Yynhc7tSHjo31aJdg+/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=REa9zp1TL7peXhL8LNO7ab276jNHLf+nAAXh6YqCGeuz27Z1QIHeOtrZ9/1/ugwnB
	 CEWXYggxLatzOpGhH0xPo43DfAP5pBVhdkACWujWgOekDnSiyz7gCPRdcB9voez9Be
	 SeGkw6C6/IVqaDxCstkKh38FwXnK+csw1zC15bu4=
Date: Mon, 10 Mar 2025 16:21:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel J Blueman <daniel@quora.org>
Cc: stable@vger.kernel.org
Subject: Re: net: cadence: macb: Enable software IRQ coalescing by default
Message-ID: <2025031027-endurance-hundredth-5bbf@gregkh>
References: <CAMVG2sts_vaXReAYsQ60RQoc_76dT2TkthZHsX=FvRNMA177=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMVG2sts_vaXReAYsQ60RQoc_76dT2TkthZHsX=FvRNMA177=g@mail.gmail.com>

On Mon, Mar 10, 2025 at 10:56:29PM +0800, Daniel J Blueman wrote:
> The macb ethernet driver (Raspberry Pi 5) delivers interrupts only to
> the first core, quickly saturating it at higher packet rates.
> 
> Introducing software interrupt coalescing dramatically alleviates this
> limitation; the oneliner fix is upstream at
> d57f7b45945ac0517ff8ea50655f00db6e8d637c.
> 
> Please backport this fix to 6.6 -stable to bring this benefit to more
> Raspberry Pis; it applies cleanly on this branch.

Now queued up, thanks.

greg k-h

