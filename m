Return-Path: <stable+bounces-76026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC73B9775D4
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 01:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41031C241DE
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 23:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E151C3303;
	Thu, 12 Sep 2024 23:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnSIsPMX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A7C191F8F;
	Thu, 12 Sep 2024 23:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726185561; cv=none; b=GFXmK2Xh/Wbr0r/OjdiHmO5BCJqgYdsMgkP2Z1CJhe9OFkDkfZ/U5a51Dcy/xkXO7SIl11aGG908LCBndZHKppMw2juPdh+dZCYtnlwUFlZ2xqtNCnuXMv0Q8obxzqI9AwFwVUeGxzda601f9tqY1Zg76CKng7cElrupWI/fcSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726185561; c=relaxed/simple;
	bh=e/9rbe4DitFlkIbJi18NYfvmIAV/APL6FYVEP0JqCpE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uo1aZltvPEQpjEzZczv5jfE/6BZJtbvoo8q3vChXp9XYYq2NGUW9TEUC/oaTrXortSWj6Y/WjBL8FKb+kArDWCQVVxI9zFD/w0mS4U31oqVSox9zRSjuh593do0OtAxlNU1K5o7GnQL6FnTyTqyfBZJSM+cYdU8Lbw7T7aN3x/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnSIsPMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE32C4CEC3;
	Thu, 12 Sep 2024 23:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726185561;
	bh=e/9rbe4DitFlkIbJi18NYfvmIAV/APL6FYVEP0JqCpE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NnSIsPMXh5wrA/4Ja8GTy2t+Qs5i+/3bz7QmUzkYsnDf+VxbuifMhRuoD0gNVSRP5
	 AVVC9oLZr4x0aeKWsnc9vLcuTKPHeywQ57KHNVHmMmFnS9UmbIOKff2FER8wbr50Zf
	 gu9CqVrw7pRzn0Wytl0/Be9e7m+56rgqa8twTwi2q9KUPNhXcZJ9V34dPNoMB1aDMB
	 e52oqAohctYiASCU7JZxXSEIqY+kcc/QYpdpk+8X8WS3Hov5sJQ+LzSeK5QHVZSGQQ
	 ijkmoF1u/OcrlaFR4L2PNwZQmSqRXFTRpFlv0KiZ2JPMbok9ssvt0YmMH1H/4qxp10
	 useMbCYdM2EtQ==
Date: Thu, 12 Sep 2024 16:59:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCHv2 net] usbnet: fix cyclical race on disconnect with work
 queue
Message-ID: <20240912165919.22ad693c@kernel.org>
In-Reply-To: <bb1cbc3d-fc46-4d0f-90b3-39b25f5bc58e@suse.com>
References: <20240905134811.35963-1-oneukum@suse.com>
	<20240910154405.641a459f@kernel.org>
	<bb1cbc3d-fc46-4d0f-90b3-39b25f5bc58e@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 11:37:14 +0200 Oliver Neukum wrote:
> > barriers? They make it seem like we're doing something clever
> > with memory ordering, while really we're just depending on normal
> > properties of the tasklet/timer/work APIs.  
> 
> Good question. I added this because they are used in usbnet_defer_kevent()
> which can be used in hard irq context. Are you saying I should check
> whether this is actually needed?

I am slightly bolder, I'm saying that my reading of the code is 
that it is in fact not needed :)
We build our "proof of correctness" on tasklet/timer/work APIs
which already provide all necessary barriers.

> > FTR disable_work_sync() would work nicely here but it'd be
> > a PITA for backports.  
> 
> So should I use it?

Up to you. It'd avoid work rescheduling but the backport would
be a pain, and off top of my head timer doesn't have a disable
so we'd still need the flag.

