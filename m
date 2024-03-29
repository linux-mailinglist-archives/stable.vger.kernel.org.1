Return-Path: <stable+bounces-33152-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9B489182B
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 12:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FDF01F22DB5
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 11:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1DB6A357;
	Fri, 29 Mar 2024 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VjDAnPuA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E803D0A1;
	Fri, 29 Mar 2024 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711712898; cv=none; b=N7DkSx+TSfiyPq/TpZbwT17ga3UJCbNCCLeKT3xA4vQGNs+QVQPVAjt5OOpK1FlLSn4zyPnZ9KUcUKgHClVQTiZpE4io9smhVUtg+F7MA2PSI2YIgKCo3nDQ3VOv4dsyMJxPHd3BO1kE7hdSZ9F5tzfwtKQt1huoQ7W/HvscC54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711712898; c=relaxed/simple;
	bh=I22JG+LAKQWzj57yn9Vaf9zkzyn7QzVWGVHgMsG6CZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrCQfskzge9J4YHkoKNoOjeyE93JsC8h8RPR2lMJHyBopSJXWdwvlqKBMGBDt4S+7366GcfXY15Au+Z9V+2PBwtQHeJolV1dYXckM2k05wXBRdvHRpZ2yGYj1/agPzh7g6q5jpHrw9LNlpVmv7R9pMq9GYuBdVCSvpkt3hIhS7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VjDAnPuA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BF4C433F1;
	Fri, 29 Mar 2024 11:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711712897;
	bh=I22JG+LAKQWzj57yn9Vaf9zkzyn7QzVWGVHgMsG6CZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VjDAnPuAhrEoQm21LgEwrNgb1oBxsdRWXlAjDX3zu+SrT+UbdE5Ql/FwHrpygX8JI
	 fM0ZCcH5tc9VNrBTs2s4S590CRY4dYk0LyqLNOY2nfMrhWBCLIVm1JBLm1kUSJ8h8n
	 IqKhxpyATo4vdiqz24gb++RdheFhdrdnWmehIB9g=
Date: Fri, 29 Mar 2024 12:48:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Srish Srinivasan <srish.srinivasan@broadcom.com>
Cc: stable@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, vakul.garg@nxp.com, davejwatson@fb.com,
	netdev@vger.kernel.org, Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Vasavi Sirnapalli <vasavi.sirnapalli@broadcom.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] net: tls: handle backlogging of crypto requests
Message-ID: <2024032951-risk-debatable-f711@gregkh>
References: <20240328123805.3886026-1-srish.srinivasan@broadcom.com>
 <2024032945-unheated-evacuee-6e0a@gregkh>
 <CA+1BbzyCr4sFS8qQ4U6g6mi-sD72y==ubBd2bxXiRLEvvx8-KQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+1BbzyCr4sFS8qQ4U6g6mi-sD72y==ubBd2bxXiRLEvvx8-KQ@mail.gmail.com>

On Fri, Mar 29, 2024 at 04:02:57PM +0530, Srish Srinivasan wrote:
> On Fri, Mar 29, 2024 at 2:53 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Mar 28, 2024 at 06:08:05PM +0530, Srish Srinivasan wrote:
> > > From: Jakub Kicinski <kuba@kernel.org>
> > >
> > > commit 8590541473188741055d27b955db0777569438e3 upstream
> > >
> > > Since we're setting the CRYPTO_TFM_REQ_MAY_BACKLOG flag on our
> > > requests to the crypto API, crypto_aead_{encrypt,decrypt} can return
> > >  -EBUSY instead of -EINPROGRESS in valid situations. For example, when
> > > the cryptd queue for AESNI is full (easy to trigger with an
> > > artificially low cryptd.cryptd_max_cpu_qlen), requests will be enqueued
> > > to the backlog but still processed. In that case, the async callback
> > > will also be called twice: first with err == -EINPROGRESS, which it
> > > seems we can just ignore, then with err == 0.
> > >
> > > Compared to Sabrina's original patch this version uses the new
> > > tls_*crypt_async_wait() helpers and converts the EBUSY to
> > > EINPROGRESS to avoid having to modify all the error handling
> > > paths. The handling is identical.
> > >
> > > Fixes: a54667f6728c ("tls: Add support for encryption using async offload accelerator")
> > > Fixes: 94524d8fc965 ("net/tls: Add support for async decryption of tls records")
> > > Co-developed-by: Sabrina Dubroca <sd@queasysnail.net>
> > > Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> > > Link: https://lore.kernel.org/netdev/9681d1febfec295449a62300938ed2ae66983f28.1694018970.git.sd@queasysnail.net/
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > > Reviewed-by: Simon Horman <horms@kernel.org>
> > > Signed-off-by: David S. Miller <davem@davemloft.net>
> > > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > > [Srish: fixed merge-conflict in stable branch linux-6.1.y,
> > > needs to go on top of https://lore.kernel.org/stable/20240307155930.913525-1-lee@kernel.org/]
> > > Signed-off-by: Srish Srinivasan <srish.srinivasan@broadcom.com>
> > > ---
> > >  net/tls/tls_sw.c | 22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> >
> > Now queued up, thanks.
> >
> 
> Greg, this patch (i.e. v1) has hunk failures.

What do you mean?  it worked here just fine.

> Just now I have sent v2 for this patch (after resolving hunks).
> Requesting you to queue up v2:
> https://lore.kernel.org/stable/20240329102540.3888561-1-srish.srinivasan@broadcom.com/T/#m164567a5bd32085931a1b1367ae12e4102870111

Let me see what the actual difference is...


