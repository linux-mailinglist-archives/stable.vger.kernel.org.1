Return-Path: <stable+bounces-188373-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B22BF7973
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 18:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A10419C3254
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 16:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70429345CAE;
	Tue, 21 Oct 2025 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YIBUXKD6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A957345738;
	Tue, 21 Oct 2025 16:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062857; cv=none; b=O47TuqUO5Ca2b//cVcZNWdm8pTED0aBMxT9qZ/4pZGnY9qpQg9sHEoVdBS2FE60KGsOBiS4jfeENzrZVylw6ZVJkLyNt6ZwvHMFfbtvCwEqvA0kR2JEUL27jPMRwrWMGLo6zkoWXBVE3vhPl/gVYNMJ06LvLZVY1Q11lIRjssnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062857; c=relaxed/simple;
	bh=sRsqZ9Gxkv0xzgUAZLXIFfIxGhtDC8Iiu6B79hHd/N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExYLw7pzxvIXohzkcgXf23KkYBt5+rCOvtaR0qemBQ/fdm910rRDMk9RO4sbIH+bOPhbbIq+gVmMIwxCtaeUGtSDGa4ZzfkiJz3TACEqJNjWJnoPDk9s4cVT4Y6cT+DLtiCU4BhSfvzhxa7GatIhPgJ9tD6RIsMI0mfyNJe1rWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YIBUXKD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F185C4CEF5;
	Tue, 21 Oct 2025 16:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761062856;
	bh=sRsqZ9Gxkv0xzgUAZLXIFfIxGhtDC8Iiu6B79hHd/N8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YIBUXKD63bcbJDQ9+9LFUbnmgEGeDJeG5nbDp6PZw31IGYC+7rt70qqLzSymRSRrr
	 kK467ooETQSJQ32A70df3enrfkdILUOI1UIvnzrJE0tLD6Ad8A9S/kK+etUIbfecI4
	 tLupwvAzxkuGrrY7QgtaT7WymfCpP2ML58kwpE2k=
Date: Tue, 21 Oct 2025 18:07:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dimitri John Ledkov <dimitri.ledkov@surgut.co.uk>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>, masahiroy@kernel.org
Subject: Re: [REGRESSION] Secureboot violation for linux enrolled by-hash
 into db v6.17.4 and v6.18-rc1
Message-ID: <2025102104-battery-battering-038e@gregkh>
References: <CANBHLUjPbXYghPx5zDwLDcGKXb7v7+1u-bpZ=L9r=qW7vDZ=cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANBHLUjPbXYghPx5zDwLDcGKXb7v7+1u-bpZ=L9r=qW7vDZ=cg@mail.gmail.com>

On Tue, Oct 21, 2025 at 03:00:56PM +0100, Dimitri John Ledkov wrote:
> If one enrolls linux kernel by-hash into db (for example using
> virt-fw-vars), the secureboot fails with security violation as EDK2
> computation of authenticode for the linux binary doesn't match the
> enrolled hash.
> 
> This is reproducible in AWS VMs, as well as locally with EDK2 builds
> with secureboot.
> 
> Not affected v6.17
> Not affected v6.17.3
> Affected v6.17.4
> Affected v6.18-rc1
> Affected v6.18-rc2

great, we are bug compatible :)

Once this is fixed in Linus's tree, we will be glad to take the fix into
the stable branch.

thanks,

greg k-h

