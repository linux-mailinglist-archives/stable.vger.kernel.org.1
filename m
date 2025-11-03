Return-Path: <stable+bounces-192106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475B9C29B2D
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 01:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D233A5A7F
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 00:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809D7146588;
	Mon,  3 Nov 2025 00:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cGnLSa7y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9CE290F
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 00:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762129319; cv=none; b=cgEB3q9ECsgaEfL2uhjPQDki3PJkQUe8WUOYKdiSrDW5K/xSNQApvZ1dWGdiVI1nKfwjHsmLEYuq+e3RvSvLoQvWj66mG0l886SPjPVaSQyQCTQfaarbqbP0HsV9iH95ivpDWqnOgeS+nqycMLPq+lfaLkRHCfR1839Rn7SXob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762129319; c=relaxed/simple;
	bh=xuitAWclERtFJM9WPrOgMLqINCKlfrqKe15Lya9DV/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLVeFnuIzT2BA5rB4qo9RC6U5T/eO/d0+8sfZSZDg4Xa8fDr8wshuiTgPph00ZX8SvaIXnIXhVrWQWMLYEsnS2fbbqCqhOmwFKa2bC6PwsHl5pN/L+uNayhTV0Zmcp9i10RXLavTiWwRRpt2FeoLcKmIHpd3JzTMUs2vAjIkfm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cGnLSa7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AC7C4CEF7;
	Mon,  3 Nov 2025 00:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762129318;
	bh=xuitAWclERtFJM9WPrOgMLqINCKlfrqKe15Lya9DV/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cGnLSa7yGY9PypyZdAdPG1XSX/UCyYsr1FnD4ZOAvYpQIcqVmADNFR3fFL8aaaT02
	 nTmy/QoSx2NAGHhtb4dZEeGbWMxzcSh9Lb/azg12rsDQq4zCxri2ERoF5LBx3Bzhuc
	 5z7Q/7sonpgC6ZlD7jSxQVwuh4hiCtU6BvjkbVRg=
Date: Mon, 3 Nov 2025 09:21:54 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: gourry@gourry.net, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/CPU/AMD: Add RDSEED fix for Zen5"
 failed to apply to 6.12-stable tree
Message-ID: <2025110330-algorithm-sixfold-607b@gregkh>
References: <2025110202-attendant-curtain-cd04@gregkh>
 <20251102173101.GBaQeVVeAvolV0UMAv@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251102173101.GBaQeVVeAvolV0UMAv@fat_crate.local>

On Sun, Nov 02, 2025 at 06:31:01PM +0100, Borislav Petkov wrote:
> On Sun, Nov 02, 2025 at 11:19:02PM +0900, gregkh@linuxfoundation.org wrote:
> > +static const struct x86_cpu_id zen5_rdseed_microcode[] = {
> > +	ZEN_MODEL_STEP_UCODE(0x1a, 0x02, 0x1, 0x0b00215a),
> > +	ZEN_MODEL_STEP_UCODE(0x1a, 0x11, 0x0, 0x0b101054),
> > +};
> 
> Yeah, we don't have that min microcode gunk with the device_id match so we'll
> have to do something like we did for TSA. I.e., below.
> 
> I'll test it tomorrow to make sure it doesn't do any cat incinerations :-P

No worries.  Don't know if you want this for any other stable kernels
older than that, but it didn't apply there either :)

thanks,

greg k-h

