Return-Path: <stable+bounces-89280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7699B58B0
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 01:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0391C22ABA
	for <lists+stable@lfdr.de>; Wed, 30 Oct 2024 00:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCDC1CFBC;
	Wed, 30 Oct 2024 00:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3sIdQTf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068C71803A;
	Wed, 30 Oct 2024 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730248577; cv=none; b=j3SNrTY2ijgTOgKlMl1Kq4QUPj3ePAaDeO/W8Ii7TS2g/YymabV9KDT6wS5bfJ4sx0ZLSwkfr7xsI6Vtn+fed1yT6oplANy4y66FR5KhQUfzqT5WMXbe9JoD0qk9lj3nMc/Oi1fx83G6c1jw9MiCxQfOuiMnsXjBAxZ6n6qcHk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730248577; c=relaxed/simple;
	bh=/HjW54xYDACJ6q7j2rlofVRIPLz3g2Dq+v152sMGdQI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJnN0wf2K65ls3ajPO7blk3RraIFgCSittU78uiZDYmdEQ9BHUbjAjefgL4z9VF8PdfcmzCSjgaREpJESPG6ay22h9phdUbkTd4nSL5vYOzEwiMHIiKunyRkyLR6F4DoHnvUaMyUsxyapOShLI8iGzyHCon3k3wVymvT3KHQK7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3sIdQTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123C0C4CECD;
	Wed, 30 Oct 2024 00:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730248576;
	bh=/HjW54xYDACJ6q7j2rlofVRIPLz3g2Dq+v152sMGdQI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U3sIdQTf949itHnnQ+QuQVtwyREGkDsJxqLsqG7Vzf9hEEgw5X5eX0G54Tu81q0Ak
	 nh/Snu2JxPag7YcRvzlZlW/DyOMcl+iluAnrK3oKObN91K+/bWTrT0JoWiB9PdTQtY
	 Y+xrtp9uvitFPNToaNuxkte5ZMLVdeyAQOq3Tp8ez/NjShcGVoHC/wDPXv+YCOUYrB
	 5IG8l/VmFfPE9GIPC0DStfyVztpBU19LaC3Ed0h15/NjR0EGq4pxVq0ngunw6USM2a
	 EwHgyWQhIV2T5A18vpwRj6e7ceGjoC1fdL4/v9cLnZTVALDdEW/BNilADKqw5v+yqt
	 RNgSKoInGGq8Q==
Date: Tue, 29 Oct 2024 17:36:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] net: vertexcom: mse102x: Fix possible double free
 of TX skb
Message-ID: <20241029173615.6492d1d5@kernel.org>
In-Reply-To: <ea4842c2-7c65-4d45-9964-1a1274d29ea4@gmx.net>
References: <20241022155242.33729-1-wahrenst@gmx.net>
	<20241029121028.127f89b3@kernel.org>
	<10adcc89-6039-4b68-9206-360b7c3fff52@gmx.net>
	<20241029150137.20dc8aab@kernel.org>
	<ea4842c2-7c65-4d45-9964-1a1274d29ea4@gmx.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Oct 2024 00:06:46 +0100 Stefan Wahren wrote:
> > Exactly, I think it would work and it feels simpler.  
> I didn't test it yet, i need access to evaluation board before. But this
> change will behave differently regarding stats of tx_bytes [1]. The
> first version will include the padding, while the second does not.

Good point! But I think we'd be moving in the right direction.
tx_bytes should count bytes sent to the network, not data+metadata
sent on an internal bus.

If you connect this board to a different controller directly the
rx_bytes of the other end should match the tx_bytes of the board 
with mse102x. The byte accounting would benefit from further massaging
in a separate patch.

