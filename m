Return-Path: <stable+bounces-58259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 242F492AE6C
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 05:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A17E3B20DB8
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 03:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA063D966;
	Tue,  9 Jul 2024 03:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szvrwWO0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165D857333;
	Tue,  9 Jul 2024 03:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720494394; cv=none; b=jHu5YVPX77mPjM/9lAHKvJjU2miyvWHt5QpMTufYAAY5DAEBUeaP6UiNSYfMFQYr/Aodz3bJF1Oy0Et9IzW+NI7WZjp5kKKuQZqAqKVVzyROhLX8ZIYUlDUyC8NFjFQ7BtrT+ThDlnkeCr1aKFcsnB97NyVogaw5C5Zs5d+I/WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720494394; c=relaxed/simple;
	bh=1ca40bwx7A72ld18Tr4csWHV3LMCDkRfpWF6YBSUs4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIGFbQ/f2G9pHGeN6chTuiXussavfHHu5BOjHe04PweymeBp4QrceO3DXQsRqG1SIgMgdUPBVRLvFcbGgCEEPZy2DgOl/tsWidUGr9usTisEP0pclYwKQU80n+2rZaBhBTz8+WEJ1rGnsTP2igcOCuOKQVkuZUJPTiKJ/UODN2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szvrwWO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AA8C116B1;
	Tue,  9 Jul 2024 03:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720494393;
	bh=1ca40bwx7A72ld18Tr4csWHV3LMCDkRfpWF6YBSUs4k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=szvrwWO07eBWR80+iayGlVDACj2uZXEjU7LNNZPgv35+nLpYJXiE6KLNAm8rifjEk
	 yS8AiKwuIn39f2JhPV9FjnfjWpHtDnvvFQLiiT5uoKRxCyauWKop+cGZz08mdQOAYw
	 AQaZinsiONEISUdbTEOMlGL+kPI9f46aSW4f95NXpvseu8bpP0yPd29jN3CeYFD/em
	 0OfQnmGYzsGdiS2cphmBeLEYWNwlyEMVlN4Ue9H/tZ/BZHxc73mj0Qk5Fc5a66AsLj
	 yPphA80L4ZIvwBwPM/PGe+O/JdUW5EJyt+D8PhBa+7xRJmfkSu2ahc3uTky5/bgRjq
	 xlXFTggwKrVew==
Message-ID: <2068de6c-830c-42f7-bdd8-46ab30450a18@kernel.org>
Date: Mon, 8 Jul 2024 21:06:32 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/4] ipv4: fix source address selection with route
 leak
Content-Language: en-US
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org
References: <20240708181554.4134673-1-nicolas.dichtel@6wind.com>
 <20240708181554.4134673-2-nicolas.dichtel@6wind.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240708181554.4134673-2-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/24 12:15 PM, Nicolas Dichtel wrote:
> By default, an address assigned to the output interface is selected when
> the source address is not specified. This is problematic when a route,
> configured in a vrf, uses an interface from another vrf (aka route leak).
> The original vrf does not own the selected source address.
> 
> Let's add a check against the output interface and call the appropriate
> function to select the source address.
> 
> CC: stable@vger.kernel.org
> Fixes: 8cbb512c923d ("net: Add source address lookup op for VRF")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>  net/ipv4/fib_semantics.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



