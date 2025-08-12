Return-Path: <stable+bounces-167112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BFAB2221F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 10:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70183561E5E
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 08:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600F42E6125;
	Tue, 12 Aug 2025 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZQx/TFsR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2182E5B11;
	Tue, 12 Aug 2025 08:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988704; cv=none; b=o+JZf3lnAeSOufrXRNt5Cs8mv/9thqhL15BKGRslfFbceTTTTTSzU6tW8sj10Qn2q1RMuxbL/LDRii8UgDfKd9k/kKYNd0PFfeCsTFb0fs2XnCcnhAs8npfAkBBO6R0Uh/0vDWjzIL56ryRKrhogTWbjO7pLHcEZHOe+jhtyXtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988704; c=relaxed/simple;
	bh=lE0xY+oTU6FGZEMCkBj0kJYDg7HFHKJAQktlXPlNB6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qcy+iIuPOJugAP+fek13+L8trereNB2ir4tS8Y3m3k+AMym4m4xpQpDWhO4B6/pZF8zBAvQ/ltl49v3ZmEfQ12LKN7oITh4FW1CI7FTXw78GnEOSxd+KkVCw+OtEZ9ABiZwUMsCxVmQ7rI8841Bk5AHgznwQP665ok90o4NYMVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZQx/TFsR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DD2C4CEF4;
	Tue, 12 Aug 2025 08:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754988701;
	bh=lE0xY+oTU6FGZEMCkBj0kJYDg7HFHKJAQktlXPlNB6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQx/TFsRVerrpSQ1egOFPovObfDXNGvysIS6r2PXH8t4iURwWnxHqpKpsmP2/a49P
	 ebY1M0dNT8OB6gZ3zAwqsC5kPN4cMfwboS/mFAa/jA2YX/nj1mqR72nMraAk7T6GgE
	 1HOt1czx7GeSwcVRrndRNWhSOwnqX7ueJe/pf05c=
Date: Tue, 12 Aug 2025 10:51:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: William Liu <will@willsroot.io>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"sd@queasysnail.net" <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Savy <savy@syst3mfailure.io>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"borisp@nvidia.com" <borisp@nvidia.com>
Subject: Re: [BUG] Missing backport for UAF fix in interaction between
 tls_decrypt_sg and cryptd_queue_worker
Message-ID: <2025081250-slaw-seltzer-4650@gregkh>
References: <he2K1yz_u7bZ-CnYcTSQ4OxuLuHZXN6xZRgp6_ICSWnq8J5FpI_uD1i_1lTSf7WMrYb5ThiX1OR2GTOB2IltgT49Koy7Hhutr4du4KtLvyk=@willsroot.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <he2K1yz_u7bZ-CnYcTSQ4OxuLuHZXN6xZRgp6_ICSWnq8J5FpI_uD1i_1lTSf7WMrYb5ThiX1OR2GTOB2IltgT49Koy7Hhutr4du4KtLvyk=@willsroot.io>

On Mon, Aug 11, 2025 at 05:03:47PM +0000, William Liu wrote:
> Hi all,
> 
> Commit 41532b785e (tls: separate no-async decryption request handling from async) [1] actually covers a UAF read and write bug in the kernel, and should be backported to 6.1. As of now, it has only been backported to 6.6, back from the time when the patch was committed. The commit mentions a non-reproducible UAF that was previously observed, but we managed to hit the vulnerable case.
> 
> The vulnerable case is when a user wraps an existing crypto algorithm (such as gcm or ghash) in cryptd. By default, cryptd-wrapped algorithms have a higher priority than the base variant. tls_decrypt_sg allocates the aead request, and triggers the crypto handling with tls_do_decryption. When the crypto is handled by cryptd, it gets dispatched to a worker that handles it and initially returns EINPROGRESS. While older LTS versions (5.4, 5.10, and 5.15) seem to have an additional crypto_wait_req call in those cases, 6.1 just returns success and frees the aead request. The cryptd worker could still be operating in this case, which causes a UAF. 
> 
> However, this vulnerability only occurs when the CPU is without AVX support (perhaps this is why there were reproducibility difficulties). With AVX, aesni_init calls simd_register_aeads_compat to force the crypto subsystem to use the SIMD version and avoids the async issues raised by cryptd. While I doubt many people are using host systems without AVX these days, this environment is pretty common in VMs when QEMU uses KVM without using the "-cpu host" flag.
> 
> The following is a repro, and can be triggered from unprivileged users. Multishot KASAN shows multiple UAF reads and writes, and ends up panicking the system with a null dereference.

As you can test this, please provide a working backport of that commit
to the 6.1.y tree if you wish to see it applied to that kernel version
as it does not apply cleanly as-is.

Same for older kernel versions if you think it should be applied there
as well.

thanks,

greg k-h

