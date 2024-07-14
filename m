Return-Path: <stable+bounces-59241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C393F9308CB
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 08:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B77281AEF
	for <lists+stable@lfdr.de>; Sun, 14 Jul 2024 06:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D16011CAB;
	Sun, 14 Jul 2024 06:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PWqIFQX0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E567110E0;
	Sun, 14 Jul 2024 06:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720938617; cv=none; b=b8jPgu73gZpKw31hbRxkrMVUCCTfOU1gAd8lMlji0FwKEw5ofd/uvytDWgo8blt61htcdQA0YxcfYPiY3X2K1pR0mIb15SNkfmmfwlivxQlb4bdIM/n+5Doo/ELFW2m7uWAYUeb8g+Q+xauqrRe4fvm/wKWB4e/JsbnZ4e09AF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720938617; c=relaxed/simple;
	bh=sBFgd+WEItz8VUi9xED8kOMJ/eLuvd8BybD7/TtbeCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLNkh/CVxr/ARZDJ0Gn3J00WObTjiE2zGLlANFovlE64iB9W7Vy4/Xioa2gmNeGaDajLU5zYQu46kSULR+qI5M8ln7t3ZecrJyiYpNvcgxxPft2AoBURhtAEbQD5Rp99PMVI4e/DImCCk+5OL/FTHalFIG5EejgsptyFtrsKq9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PWqIFQX0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAB8C116B1;
	Sun, 14 Jul 2024 06:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720938616;
	bh=sBFgd+WEItz8VUi9xED8kOMJ/eLuvd8BybD7/TtbeCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PWqIFQX0tWCG2xqXOskafUvZ5NM1EeF/g74Uk5vPhJk2puPCsvTkl3L3Pg5jFVm9n
	 jPDmnbMLc5tfz1GUjgKgLWgeIn/eNOKM4QQ42Yq9ViLNOcOG+uvLBZqCm+GAZY1+e5
	 VsNpLybT38R8uI3phlM8J6phzWZDtAFFt+v3BG7o=
Date: Sun, 14 Jul 2024 08:30:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tim Lewis <elatllat@gmail.com>
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-usb@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.1 000/102] 6.1.98-rc1 review
Message-ID: <2024071447-saddled-backrest-bf16@gregkh>
References: <CA+3zgmvct7BWib9A7O1ykUf=0nZpdbdpXBdPWOCqfPuyCT3fug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+3zgmvct7BWib9A7O1ykUf=0nZpdbdpXBdPWOCqfPuyCT3fug@mail.gmail.com>

On Sat, Jul 13, 2024 at 01:52:52PM -0400, Tim Lewis wrote:
> The patch
>     usb: xhci: prevent potential failure in handle_tx_event() for
> Transfer events without TRB
>     https://patches.linaro.org/project/linux-usb/patch/20240429140245.3955523-11-mathias.nyman@linux.intel.com/
> causes The Linux kernel
>     6.1.98
>     https://lkml.org/lkml/2024/7/9/645
> to crash when plugging in a USB Seagate drive.
>     https://www.seagate.com/ca/en/products/gaming-drives/pc-gaming/firecuda-gaming-hub/
> This is a regression.

Ick, is this also a problem with the latest 6.6 and/or the latest 6.9
and/or Linus's tree?

thanks,

greg k-h

