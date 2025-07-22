Return-Path: <stable+bounces-163678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE25EB0D62C
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 11:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EBE97B08BB
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 09:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCAE2DFA5C;
	Tue, 22 Jul 2025 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xPKwIh3f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07D42DFA59
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 09:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177360; cv=none; b=XYk8GuEkEjvHjg10gIF+YSMNtL4Dk+uvM10x/EvvD9vDfGblj41HYLPFcXWOxntUYdF4WAl12cKf0xdcqvoFyaZW4TIxgnt+vfNxh0gx6ZiFXPhEKvLJPTqDebGMe1zW7OpvWRt8e1s7z6dRfHzhfcu6Q8AaP9/cTgR+0lUTdyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177360; c=relaxed/simple;
	bh=qRKi+9jC9HynMa3ZsHjkPw2Uq2QXMxZJNeH5z1eWuWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ec6zJNTVzZNUTIkLUrWjyGVexXQFYQt3uF0r8AiTNF4LqSzNBzdB93kO1KZuLwIouH4HVv3w8d3z+Ee0BFziyPyei60QebEbdAiZcTSNjVGNPflp265hSHLbKkH12SXSBxw0k3PbOT3WnoJshl0g9U85zcEt608jh7a+mG0ZZbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xPKwIh3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17ECDC4CEEB;
	Tue, 22 Jul 2025 09:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753177360;
	bh=qRKi+9jC9HynMa3ZsHjkPw2Uq2QXMxZJNeH5z1eWuWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xPKwIh3f6tHFtApEXbvpvblCgE0FWzrgmH4ekqILjKrC6y4bb5rUQOsbnCKc2vi1G
	 xZ1wf4N1uTz2QdsA9Nt3mjJw+nx2ibfdqJRAitvDRJ2KuguYJHOpa5hsYRKUffd//J
	 VgDxyVTZK4Q+DuVOp5PfTn6JXGh2NWiL9tThzcTI=
Date: Tue, 22 Jul 2025 11:42:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc: stable@vger.kernel.org, qat-linux@intel.com,
	Damian Muszynski <damian.muszynski@intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ahsan Atta <ahsan.atta@intel.com>
Subject: Re: [PATCH 6.1] crypto: qat - fix ring to service map for QAT GEN4
Message-ID: <2025072202-partridge-utilize-9db7@gregkh>
References: <20250717170835.25211-1-giovanni.cabiddu@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717170835.25211-1-giovanni.cabiddu@intel.com>

On Thu, Jul 17, 2025 at 06:06:38PM +0100, Giovanni Cabiddu wrote:
> [ Upstream commit a238487f7965d102794ed9f8aff0b667cd2ae886 ]
> 
> The 4xxx drivers hardcode the ring to service mapping. However, when
> additional configurations where added to the driver, the mappings were
> not updated. This implies that an incorrect mapping might be reported
> through pfvf for certain configurations.
> 
> This is a backport of the upstream commit with modifications, as the
> original patch does not apply cleanly to kernel v6.1.x. The logic has
> been simplified to reflect the limited configurations of the QAT driver
> in this version: crypto-only and compression.
> 
> Instead of dynamically computing the ring to service mappings, these are
> now hardcoded to simplify the backport.
> 
> Fixes: 0cec19c761e5 ("crypto: qat - add support for compression for 4xxx")
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Damian Muszynski <damian.muszynski@intel.com>
> Reviewed-by: Tero Kristo <tero.kristo@linux.intel.com>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: <stable@vger.kernel.org> # 6.1.x
> Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
> Tested-by: Ahsan Atta <ahsan.atta@intel.com>

You did not mention anywhere what changed from the original commit (and
it changed a lot...)  So this looks to me like an incorrect backport, so
I have to just delete it :(

Please fix up and send it again.

thanks,

greg k-h

