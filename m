Return-Path: <stable+bounces-23753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450C48680A4
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 20:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FCD21C298FB
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 19:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6949912FF81;
	Mon, 26 Feb 2024 19:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I6/Lindg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1859D1E4A0
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 19:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974759; cv=none; b=j6OeOSmniSDJuoLCbvgEMIfHSOlGPbNNfnCD3b3CcYE/XW+fqKrcD4hCi4+vIp1UM6aC8bzyOUlmZ9TNyQJKN5uA6O0P+mzc7+DnX78pvmUZ6OPEHoA9Lp02JQi/7RYj3nV6rYFXJ039w8b2eMSdisDYWlRF0fUNWp8R9lBZ4zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974759; c=relaxed/simple;
	bh=rHqDRJK0JbRpSL+bEyIzE/u0d0ssuAsw1lyWADUd48Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHhaW3EeiGwnganaNSpjSm3Iec2a1+W0PTe6uFxa6WVKVlw9673k5yOd26iA4XOAAUNQpmtP32YObyTKEmKA7hpkGoEM7zogtQIIzGrMs13ZVR5rXS0r2bACaIzc9srBnLVjcf3ewg0ZMvq3vAwU3Fw5DR4woSLsmB/bfAGGelc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I6/Lindg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317B8C433F1;
	Mon, 26 Feb 2024 19:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708974758;
	bh=rHqDRJK0JbRpSL+bEyIzE/u0d0ssuAsw1lyWADUd48Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I6/LindgNGRPJmcScrwdmW91Okn6kyuEz78DXQ5AuyRsIn4VJsC66swTqd5n2xNq8
	 aok5YjuCYB2wTMb/xSI3R6kcJBMsUvz+9wh8/TGR2U+23S6L5TryMUMqUcefZwyWdT
	 v1ooj7G+bXzy0t9oKKAcmy6OZlbFJ8MD8s7J7vZ0=
Date: Mon, 26 Feb 2024 20:12:35 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	'Roman Gilg' <romangg@manjaro.org>, Mark Wagie <mark@manjaro.org>
Subject: Re: [Regression] 5.4.269 fails =?utf-8?Q?t?=
 =?utf-8?Q?o_build_due_to_security=2Fapparmor=2Faf=5Funix=2Ec=3A583=3A17?=
 =?utf-8?Q?=3A_error=3A_too_few_arguments_to_function_=E2=80=98unix=5Fstat?=
 =?utf-8?B?ZV9sb2NrX25lc3RlZOKAmQ==?=
Message-ID: <2024022620-dreamland-hardwired-d86d@gregkh>
References: <0ca1f9f0-6a09-4beb-bbdb-101b3fc19c45@manjaro.org>
 <2024022453-showcase-antonym-f49b@gregkh>
 <1d327f8d-a099-4373-aee7-a5b443d52859@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d327f8d-a099-4373-aee7-a5b443d52859@manjaro.org>

On Mon, Feb 26, 2024 at 10:05:16PM +0700, Philip Müller wrote:
> On 24/02/2024 16:11, Greg Kroah-Hartman wrote:
> > the issue might be due to this patch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/releases/5.4.269/af_unix-fix-lockdep-positive-in-sk_diag_dump_icons.patch
> 
> Yes, reverting this commit makes it build again on my end ...

Can you attach a .config file that shows this?  I can't seem to
duplicate it here.

thanks,

greg k-h

