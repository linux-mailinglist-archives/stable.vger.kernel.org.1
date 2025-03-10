Return-Path: <stable+bounces-121720-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B173CA59A0E
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 16:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1B94188D8D9
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 15:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDA922B8CA;
	Mon, 10 Mar 2025 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xImpYZtz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AB122A4E0
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741620888; cv=none; b=Q8skYspZ4+xWeCaSvQB259mPGwEIBYnCFzXxQksrtNoQrZvpDqUo3itjprRsMF8xfaYiwZGrb4chogcbVx+lmHyNGLPoTGBYjmAjFZrYZkkdiOUcEE0D2qHLHp6XJZUH0hRBB9FH0myvkRjx6sRFzrpb1t06oga3edduXKadpGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741620888; c=relaxed/simple;
	bh=13B4u4Np7mg78XZeGxuR8YTXPzBmdWaWuaRW2cVRUo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7S+3rbdydi2C/X3wVhDWeChPoPAaNV5drFtE1lk6K5CU4xYrFjT+xUbYKlF1yyqeq5ogJMDvYY3FHiFY5pgb92DhJLC7GuK9VfgGQKd10wT9u1NGciieWeRP1kxKRnO+TctgqignQ3Z2NXb20/RVezIzSSu0SoY5hWKwRJwNbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xImpYZtz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EC6C4CEE5;
	Mon, 10 Mar 2025 15:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741620887;
	bh=13B4u4Np7mg78XZeGxuR8YTXPzBmdWaWuaRW2cVRUo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xImpYZtzpGDIecU1eWdEZUMgXeXuwfOXS0itKMj5pj3Peoz/v62OA1+XZJwYhQYSW
	 XcWuOYeW1R099f1LbIVUKUki2bOQ4vVMwh+iYZZXsDzFv+YkUJKR3IeQD+YlgQQfNL
	 i5CydE5VfYHlHIZKOZXgBmnLR2LjztXOl/tlac30=
Date: Mon, 10 Mar 2025 16:34:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel J Blueman <daniel@quora.org>
Cc: stable@vger.kernel.org
Subject: Re: net: cadence: macb: Enable software IRQ coalescing by default
Message-ID: <2025031023-parrot-playhouse-4997@gregkh>
References: <CAMVG2sts_vaXReAYsQ60RQoc_76dT2TkthZHsX=FvRNMA177=g@mail.gmail.com>
 <2025031027-endurance-hundredth-5bbf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025031027-endurance-hundredth-5bbf@gregkh>

On Mon, Mar 10, 2025 at 04:21:35PM +0100, Greg KH wrote:
> On Mon, Mar 10, 2025 at 10:56:29PM +0800, Daniel J Blueman wrote:
> > The macb ethernet driver (Raspberry Pi 5) delivers interrupts only to
> > the first core, quickly saturating it at higher packet rates.
> > 
> > Introducing software interrupt coalescing dramatically alleviates this
> > limitation; the oneliner fix is upstream at
> > d57f7b45945ac0517ff8ea50655f00db6e8d637c.
> > 
> > Please backport this fix to 6.6 -stable to bring this benefit to more
> > Raspberry Pis; it applies cleanly on this branch.
> 
> Now queued up, thanks.

And now dropped.

Daniel, always cc: the authors on the patch you ask for so that they can
review the request as well.

thanks,

greg k-h

