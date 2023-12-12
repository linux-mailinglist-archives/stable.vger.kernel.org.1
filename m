Return-Path: <stable+bounces-6390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD5780E27C
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 04:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B76028249A
	for <lists+stable@lfdr.de>; Tue, 12 Dec 2023 03:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAE953BE;
	Tue, 12 Dec 2023 03:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cgw5LTG9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA534436;
	Tue, 12 Dec 2023 03:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B681C433C8;
	Tue, 12 Dec 2023 03:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702350530;
	bh=PacZo1dSyjuMTMTPcET3mNgd2NapBBAOTRpPuVaYDZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cgw5LTG9O7ZCS2qh87mez7MOKLqMvcTTRySUEa32FFEGKp15GiR7a2cgTFeHNDMOq
	 rjOTff3cw6m7z51C8fLh2BFsIuAH4gP0OBfGzn3N0pJ4bfECchg2AyknDIqDzKdWJR
	 6vsppOLfEPjK6JtWSdOmgReGvZYWhYE6NFAiEoIxjLQq7oJXCsdVKd754AGTc7p9xX
	 /gIqymnq0qUFYqJHDjneQOGndbiQucVhGV3LOlW6rix/kgkYjJ+4lmmJLvG07XdXl8
	 b1RweM2c+dLf2ZrZw+mje2B8k8ZShJI3rszz79OMv6TT/3R1Hfzqxkzhf+qpOhD29K
	 X5V/8qrGV35WA==
Date: Mon, 11 Dec 2023 19:08:49 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Hui
 Zhou <hui.zhou@corigine.com>, netdev@vger.kernel.org,
 stable@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net 2/2] nfp: flower: fix hardware offload for the
 transfer layer port
Message-ID: <20231211190849.6c7d5246@kernel.org>
In-Reply-To: <20231208065956.11917-3-louis.peens@corigine.com>
References: <20231208065956.11917-1-louis.peens@corigine.com>
	<20231208065956.11917-3-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Dec 2023 08:59:56 +0200 Louis Peens wrote:
> +		if (mangle_action->mangle.offset == offsetof(struct tcphdr, source)) {
> +			mangle_action->mangle.val =
> +				(__force u32)cpu_to_be32(mangle_action->mangle.val << 16);
> +			mangle_action->mangle.mask =
> +				(__force u32)cpu_to_be32(mangle_action->mangle.mask << 16 | 0xFFFF);

This a bit odd. Here you fill in the "other half" of the mask with Fs...

> +		}
> +		if (mangle_action->mangle.offset == offsetof(struct tcphdr, dest)) {
> +			mangle_action->mangle.offset = 0;
> +			mangle_action->mangle.val =
> +				(__force u32)cpu_to_be32(mangle_action->mangle.val);
> +			mangle_action->mangle.mask =
> +				(__force u32)cpu_to_be32(mangle_action->mangle.mask);
> +		}

.. but here you just let it be zero.

If it's correct it'd be good to explain in the commit msg why.
-- 
pw-bot: cr

