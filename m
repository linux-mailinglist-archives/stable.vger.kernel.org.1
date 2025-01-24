Return-Path: <stable+bounces-110426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD00EA1BE31
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 23:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5548D3A8EC6
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 22:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41931E98EC;
	Fri, 24 Jan 2025 22:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuB6+/8L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A58E1E3DE3;
	Fri, 24 Jan 2025 22:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737756007; cv=none; b=fxHI6NxdVN7k+yDOtiS4TNZmkfNSPKTuowvuIG0GaPHh8Wv0NG72Eiwcd5YJXOKmduxJGKHKFKA/vIAFYQTOwv2xPTw76R8CYeGNzlDADaqH50d2iQ5Cx4hX4sW5jGV9uCD/hqn2pC4QPCfwQ7ovYWi+B0VWThxEL2WC0Vs132c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737756007; c=relaxed/simple;
	bh=kuHBqtFvlCr667IMv1JE6CrZZkpt4VSU8BaVu0QoaKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fr7+wZLNvrBBcjsOtMYvMutuVX/Up1APFCuHMMn0wN3CazNuZquFqHH8Kl0aupxPDtHsJHimd8LHDVxP8uvWzxVONNaZLTtXpaJ84+bAqjWfQcbw8HECwA4VuIOs5VSoJOdRN8l7OoDQ+DFmx4UvE7waKS0RDiWYfAq7TORKyZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uuB6+/8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B87C4CED2;
	Fri, 24 Jan 2025 22:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737756006;
	bh=kuHBqtFvlCr667IMv1JE6CrZZkpt4VSU8BaVu0QoaKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uuB6+/8Lsfwhl7OMhjOktd78io9ZggxIP7HLZm5BsQ9SJtJhDo99MOwsf3TqAhct0
	 qRhw82+El0R24JbvozEi8G4AafS1ge4INgcmzA7D3uYI/0GL2LoVy9NGRikyVx5VhS
	 WmaqR3n/uPtBZKAzxm/GYDIUislOx0TmCf+G/PbiYAqXhfcYBuWHMSZalClm6IyE8+
	 EkD6GtjMAicdWl2DdSbCcx1vFM1TsFHVXIYR3yhnL8VgC9Eaa8VyZr49sJ5iesZMJs
	 LHkM7pVSFFAb3s3gJZY2JsJgwvKhR+Aq7SY48Ovrvlnr+tvAVteSpe/uDhe4Vi6Nbv
	 bmzlwP2TjY1+w==
Date: Fri, 24 Jan 2025 16:00:05 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Basharath Hussain Khaja <basharath@couthit.com>,
	Saravana Kannan <saravanak@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] of: address: Fix empty resource handling in
 __of_address_resource_bounds()
Message-ID: <173775596409.2511219.13763390679214460358.robh@kernel.org>
References: <20250120-of-address-overflow-v1-0-dd68dbf47bce@linutronix.de>
 <20250120-of-address-overflow-v1-1-dd68dbf47bce@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250120-of-address-overflow-v1-1-dd68dbf47bce@linutronix.de>


On Mon, 20 Jan 2025 15:09:40 +0100, Thomas Weiﬂschuh wrote:
> "resource->end" needs to always be equal to "resource->start + size - 1".
> The previous version of the function did not perform the "- 1" in case
> of an empty resource.
> 
> Also make sure to allow an empty resource at address 0.
> 
> Reported-by: Basharath Hussain Khaja <basharath@couthit.com>
> Closes: https://lore.kernel.org/lkml/20250108140414.13530-1-basharath@couthit.com/
> Fixes: 1a52a094c2f0 ("of: address: Unify resource bounds overflow checking")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  drivers/of/address.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 

Applied, thanks!

Please resend the kunit test with 0-day issues fixed.

Rob

