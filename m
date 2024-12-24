Return-Path: <stable+bounces-106078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B759FBF67
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 16:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945BF162907
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 15:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A071BCA1B;
	Tue, 24 Dec 2024 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="YTXdSjEc"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CD01991DD
	for <stable@vger.kernel.org>; Tue, 24 Dec 2024 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735052397; cv=none; b=X5NdkRQKB6pS2v8Y+I0bp659Rb2f6JalO/D9vPZkflgP9TUItVu1vylk4b+mSvmV2uCl1941xTqFnfLzOaU/CDw4wVlap34mNWdu2govsKybPvOrwFvEAlSyL/x1QliY7NWHhl1YM36An9rlv/Ir7bIKFKaViw8NO7ift+21iI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735052397; c=relaxed/simple;
	bh=dIh3tL5xlZ7tAnf9j3LTDw3P6peEVniwwFRYkuxnjXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUgN5tMzFD3iaWYJvIPsu/ID2ChrOMM4l5FCd+83FaSVUhh+3lv+k119RBSDKjRdCE2mIWBDpFNXIXM1qPT8MxHPO9BYgRzzFoWqcQu4WMpiyhibEOBvO5ZZhgCMXRvpX8TEs0B+ZahZPFITb2i9wz1qj8z6qGIqENKavhbnYOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=YTXdSjEc; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [10.10.165.19])
	by mail.ispras.ru (Postfix) with ESMTPSA id 6C47C40755C3;
	Tue, 24 Dec 2024 14:59:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6C47C40755C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1735052390;
	bh=BY/LFLv7Pf5wVRWBA7LkaIObSdqnag9YXL9QaysQGnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YTXdSjEcoXROq0+eecmAcM2+G3uJorPHjHOfvrjIqRcdJj4TJrtQoZNRYpzBJjuZ7
	 ArqWykbs6tBkXGDsCFQ2BScxqm39lVKejnC1WXwOEivSOHaIuMqnUzAF5Bi8y+Ypvi
	 FJtgdEnJdRsaz6aFnf7x6x0Z8ayNGCNyyT8UMDvw=
Date: Tue, 24 Dec 2024 17:59:46 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: mordan@ispras.ru
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] usb: ehci-hcd: fix call balance of clocks handling
 routines
Message-ID: <20241224-b6bb2469b4f8b29fd6cd3a57-pchelkin@ispras.ru>
References: <20241223093223-4173e9cdd41aad4a@stable.kernel.org>
 <1ca017108b4be8195b597ed5a2c22504@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ca017108b4be8195b597ed5a2c22504@ispras.ru>

On Tue, 24. Dec 14:56, mordan@ispras.ru wrote:
> Hello,
> 
> A required dependency commit is missing, as noted by Fedor Pchelkin:

Hmm... Vitalii, this was added to stable-queue by Greg KH after I've posted
the request, so everything is OK now.

https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=b0af78f3436d5d30681302b7ac7ffb794966e351
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=f89319493cac3a576aa90386751ce1041e101b6e
https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=22121974e9baf6da20d257b6ecacc15c7272969a

> 
> > The current patch was added to stable kernels lacking the necessary
> > prerequisite ff30bd6a6618 ("sh: clk: Fix clk_enable() to return 0 on
> > NULL clk") which is specified in Cc:stable tag of the commit description
> > per stable kernels documentation [1].
> > [1]: https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1
> > Could you please cherry-pick ff30bd6a6618 ("sh: clk: Fix clk_enable() to
> > return 0 on NULL clk") to 6.1.y, 5.15.y, 5.10.y and 5.4.y ? It applies
> > cleanly.
> > Thanks!

