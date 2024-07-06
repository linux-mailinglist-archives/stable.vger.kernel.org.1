Return-Path: <stable+bounces-58169-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F280C929234
	for <lists+stable@lfdr.de>; Sat,  6 Jul 2024 11:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D881F21FAD
	for <lists+stable@lfdr.de>; Sat,  6 Jul 2024 09:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFF7502BE;
	Sat,  6 Jul 2024 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kXgk8EPi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107F94F5EA;
	Sat,  6 Jul 2024 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720258063; cv=none; b=USDRCnGLav2K6TjvqwECr6/ncVBuiKweVJonbu7u+hWlKjw4aXoVA60zGSEszuIB0watTqYAgii31eEeYei5DO7d9GyQ8cmG9PFVgvero+RLN3BmDuuxuOzop24zB/+fGvCGkM/ShkQEY5epWeJzbUabhpTtngvN3sIPcXD6BN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720258063; c=relaxed/simple;
	bh=Xm1V4jmP/DMnHm/HfNRL2rJ4O28658EcRrs33bm9sdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZ7CyAd/tiA7OPDw9cxMfV7AGWrYxlxGfm8aES2iyLvmDwSfIO3bkE87qIyi99avbwPyrkJGX+ze0IpWfzkA0IS+3WLrDO4OeIQxSdU4d9tBIvdUikQ52gFrIwtQjIJiL24p7Lni9ZqpYvrRHHLFR80yGNdIV4YDcj7p32WWLlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kXgk8EPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30D4C2BD10;
	Sat,  6 Jul 2024 09:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720258062;
	bh=Xm1V4jmP/DMnHm/HfNRL2rJ4O28658EcRrs33bm9sdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kXgk8EPiNmjPUM9AYJ9iWGrt/FXt7B9BljzZdYbMethrvdXMZxAXu1LOUkdOiqrzY
	 lpLBkHnsGVsWR4I3eF3xmnwPkY5C67HONVILHqy6UqMCk+dqwLNASI5mAUoaRpZtYw
	 ayOqG2AWi8pHZ11gmRlf2gwvSM9lLkgal3DP2SBc=
Date: Sat, 6 Jul 2024 11:27:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ronald Wahl <ronald.wahl@raritan.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Ronald Wahl <rwahl@gmx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] net: ks8851: Fix deadlock with the SPI chip variant
Message-ID: <2024070630-smudgy-stunner-28b5@gregkh>
References: <20240704174756.1225995-1-rwahl@gmx.de>
 <20240705173931.28e8b858@kernel.org>
 <2f3c0444-c02a-4fff-8648-d053a0cb21a2@raritan.com>
 <4e4fad0c-c7bf-4b64-a30f-489c5dc4875c@raritan.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e4fad0c-c7bf-4b64-a30f-489c5dc4875c@raritan.com>

On Sat, Jul 06, 2024 at 11:22:11AM +0200, Ronald Wahl wrote:
> This e-mail, and any document attached hereby, may contain confidential and/or privileged information. If you are not the intended recipient (or have received this e-mail in error) please notify the sender immediately and destroy this e-mail. Any unauthorized, direct or indirect, copying, disclosure, distribution or other use of the material or parts thereof is strictly forbidden.
> 

Now deleted

