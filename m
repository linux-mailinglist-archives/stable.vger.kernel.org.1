Return-Path: <stable+bounces-104494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E96C9F4B5D
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 13:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C7316C6FD
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 12:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5E61F37D7;
	Tue, 17 Dec 2024 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bdKivbsa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A001F03FC
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734440229; cv=none; b=Qlq/9CRGHKDyL6waZSTqRGo9248cFH5WEqDhhQXQnqxlk6QarcoGgwN6i/c+RAv/7koxfMTkSWGXmvNnvCMhEisVbn2gtVL14mxBRRIcAaywmSVztLcSgzlW/LLZsnj+vwgW4Wz1lUtZPo9HqncJREUfvCnV3fn6VCzthqUO+mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734440229; c=relaxed/simple;
	bh=atGQ5cediCFCx+fmJIFOBTILFzPbwxZtpDeDySpxqSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/uZhcu2K7CL7jm7Jk5kiYRiW39yd8B6PezAXCjRH8kUZ5lq/4l4tZPyVfPiIr7wfGYcNcM7atyjcF7+HFnLaz1NLBPwwrM/a5N3CmFBW6y8j5a4qNysyOUmtRGpJ9gOfQmX5VTChsDCvOV1v21K2y3r3stFyUJ9hkXjvUpx34M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bdKivbsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0F9C4CED3;
	Tue, 17 Dec 2024 12:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734440228;
	bh=atGQ5cediCFCx+fmJIFOBTILFzPbwxZtpDeDySpxqSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdKivbsatvMclhhsXw9A4E6If18ODGn8xEy4DtFjHq8mZYfkAsE2gm1nS18RKjFhe
	 /d5q6qUv9WhUmSOIVrfvbOshXG7WRS/Db/UB9ksZxh5M1qEaSFdg+SiNbabNdHz5a1
	 wFd9pqrb5ob/pPktqQI4BY2PemoBt0Sp/vzou0Nw=
Date: Tue, 17 Dec 2024 13:57:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Beno=EEt?= Sevens <bsevens@google.com>
Cc: stable@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
	stable@kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 5.15.y] ALSA: usb-audio: Fix a DMA to stack memory bug
Message-ID: <2024121738-pulverize-subatomic-262e@gregkh>
References: <2024121040-distant-throng-b534@gregkh>
 <20241217124318.734250-1-bsevens@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241217124318.734250-1-bsevens@google.com>

On Tue, Dec 17, 2024 at 12:43:18PM +0000, Benoît Sevens wrote:
> From: Dan Carpenter <dan.carpenter@linaro.org>
> 
> The usb_get_descriptor() function does DMA so we're not allowed
> to use a stack buffer for that.  Doing DMA to the stack is not portable
> all architectures.  Move the "new_device_descriptor" from being stored
> on the stack and allocate it with kmalloc() instead.
> 
> Fixes: b909df18ce2a ("ALSA: usb-audio: Fix potential out-of-bound accesses for Extigy and Mbox devices")
> Cc: stable@kernel.org
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://patch.msgid.link/60e3aa09-039d-46d2-934c-6f123026c2eb@stanley.mountain
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> (cherry picked from commit f7d306b47a24367302bd4fe846854e07752ffcd9)
> [Benoît: there is no mbox3 suppport and no __free macro in 5.15]
> Signed-off-by: Benoît Sevens <bsevens@google.com>
> ---
>  sound/usb/quirks.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)

I see 2 versions of this, which one is correct?

When sending new versions, always properly version them.  I'll delete
this and wait for a proper v2.

thanks,

greg k-h

