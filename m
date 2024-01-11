Return-Path: <stable+bounces-10495-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D0982AB68
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 10:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981281F25DEF
	for <lists+stable@lfdr.de>; Thu, 11 Jan 2024 09:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A814511722;
	Thu, 11 Jan 2024 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wD1F1Mth"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BFE12E7C
	for <stable@vger.kernel.org>; Thu, 11 Jan 2024 09:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB40C433F1;
	Thu, 11 Jan 2024 09:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704966991;
	bh=P9sEDuSzqxqXpyo30FC2veX3grbd6FyB6jxxHkCjJBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wD1F1Mthn+kl7fNsMUxtnXyc3QQouRcLfAN9VDyXd0qr3DJvPL6arTQGLtNXXaFrn
	 b0+pdclciMvwXqdGoi1ZZ/Sl/bkgM9d5m8A6due56SDi/ktcwvDqSgM8Q9lcyQRM2V
	 ZkH1ptgfyu4HYNZjdzxpp7xl5blQrfBKgupgTl+E=
Date: Thu, 11 Jan 2024 10:56:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: John Fastabend <john.fastabend@gmail.com>
Cc: stable@vger.kernel.org, jannh@google.com, kuba@kernel.org,
	daniel@iogearbox.net, borisp@nvidia.com
Subject: Re: [PATCH] net: tls, update curr on splice as well
Message-ID: <2024011122-aflutter-juniper-1f81@gregkh>
References: <20240109225956.279609-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109225956.279609-1-john.fastabend@gmail.com>

On Tue, Jan 09, 2024 at 02:59:56PM -0800, John Fastabend wrote:
> commit c5a595000e2677e865a39f249c056bc05d6e55fd upstream.
> 
> Backport of upstream fix for tls on 5.x kernels.
> 
> The curr pointer must also be updated on the splice similar to how
> we do this for other copy types.
> 
> Cc: stable@vger.kernel.org # 5.15.x
> Cc: stable@vger.kernel.org # 5.10.x
> Cc: stable@vger.kernel.org # 5.4.x
> Reported-by: Jann Horn <jannh@google.com>
> Fixes: d829e9c4112b ("tls: convert to generic sk_msg interface")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  net/tls/tls_sw.c | 2 ++
>  1 file changed, 2 insertions(+)

Now queued up, thanks.

greg k-h

