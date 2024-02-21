Return-Path: <stable+bounces-21797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 293BB85D2DD
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 09:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8C41C22831
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 08:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBE63D0A9;
	Wed, 21 Feb 2024 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="H7TaBOX3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zr/aKmTq"
X-Original-To: stable@vger.kernel.org
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422523D0D2
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 08:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505632; cv=none; b=PXYdDN/dZvH78f/eJ3jFOPSDRUlMP0+WIjihzRktDhITlXBmNTi9AAXueIummRTo3wIc30b1V+1cu+wR93gQTa4AQtYQ0VugpMK+mqvRihWqrY3TKvR5xmocIPAvUVM9ypj59QZAOJ6ySMVgJIDnXzNO1NIU5fQFPg+SdFycXqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505632; c=relaxed/simple;
	bh=seAWvNEF+bpbfdQiXWD4tzHW4PNYgdcLH8yVn3vPhSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McmdCRlu5BA+SCD/ZW4UI8E4Vgihq7Uwo97RjnRTqpIutJxc53/X3dfrRtvdL7Ww/3Ns1x64cCyqzz1aSoI+xOrmZ26e1y85/P69IzVj+qnW3jzEt5z12Vb6xItUyEaJwcjBSPyIbI7Ie6Sw2oUsxrmt5w3zmv1WkgPjdl28adY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=H7TaBOX3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zr/aKmTq; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3144D13800B1;
	Wed, 21 Feb 2024 03:53:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 21 Feb 2024 03:53:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708505616; x=1708592016; bh=68c7U6GWch
	1ANmqpPUknCJmr+7osoRa28nWAXTwftM0=; b=H7TaBOX3uXNd0J/iN/T39yeRI9
	jZPCIdXws+zWGIwCkzLhQa8jIjvJDFl5nBRNcnXZDdAKfV/Biuo3nfSTWAS+i8SC
	ozFx0T3h1cD8bibKcZcEgV0QGWTkstmJIHMXFPxqoMlVX/2tctmtBthf0YpS7Ts2
	ol5EWuy/yO9yMOkmz4eERpGwqFHkUnGecwab0OvkJCsTlaYJYR+hx/5u3IH8DC1i
	asFWy9aiea6zgpXHRl5qUmIoTht94jyLohlui0qVsEQN6DPQNQCN0Fqa/tk8jcxY
	26dbeillJbRU0k96P+Nure1uLixVShdDlF2rptOPfE4ULGsSaJYnTu6uPeuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708505616; x=1708592016; bh=68c7U6GWch1ANmqpPUknCJmr+7os
	oRa28nWAXTwftM0=; b=Zr/aKmTq6rRtm4QlmXAiK20RyNPKrKjAFJwgKpa1FY9n
	iTjgi5Lf02pwmv0qgJj3Jo7aY8tVBZH8zFfBDlcDrBV78GDpbsUNnYtKW2QL9/DS
	oqNXnw1D06HYwe9ISmGo1/pObdooEALBGiF1u2GDJVnzGE2xJJosD/kABvG2rPdl
	Ek+ltgN334j0QXPyQ09I/KxhTODqqsnVMA94G2ug6+R0W4471v3U7q1QAyet/EQ4
	mAOEC5vuUQhcLjCsT2IdhQgfSIc+ERUiGDOeHLpR2ewrtZfGk+qpy/rZm1kvQTRf
	D6u0TfPXo82n3gruJIbykkIgrasTsUcG3G1lZ6M/gg==
X-ME-Sender: <xms:D7rVZdzYNt0_v-KO-BHq43S_JTAM9VCz6EVasjDiBzFIzsC7TtgP0Q>
    <xme:D7rVZdQZ9nG_8lKdCWlNaKvdkooK5M_JKZo7JWzRXMqk5vjSzUFA-v3ms4tUI_q4T
    gapwGz2-vsZDQ>
X-ME-Received: <xmr:D7rVZXXPzT_BJqBGKqEAYlsIpcvITmpusCn7u_xQ-DJJpE_1MrOzUzGDbfMasBZU35DMFSh8tnE9lBjlLzfj7zIESplbpmquzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:D7rVZfjeww2D3dE7d-UIdb4fLFkyEEtcdwmeTxhwUVEL8q_9iBoyvg>
    <xmx:D7rVZfCDnK8OOfeEoEOXQGlZFc_APkZUovuwH6VDiMLVxN1X9BhHQg>
    <xmx:D7rVZYJpVKYRwUr1pQFg_6T1380IHaJFCY-BBJqs1wxKVmy4BqxGkQ>
    <xmx:ELrVZXa7apUhKk0R1Z3bA90qkLLzQ-Eh-pMHovP8R6uGPUWCry3F_g>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 03:53:35 -0500 (EST)
Date: Wed, 21 Feb 2024 09:53:20 +0100
From: Greg KH <greg@kroah.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: stable@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 5.15.y] arm64: Subscribe Microsoft Azure Cobalt 100 to
 ARM Neoverse N2 errata
Message-ID: <2024022112-laziness-alongside-0c87@gregkh>
References: <2024021948-flashing-prescribe-3dcf@gregkh>
 <20240220192816.2842423-1-eahariha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220192816.2842423-1-eahariha@linux.microsoft.com>

On Tue, Feb 20, 2024 at 07:28:16PM +0000, Easwar Hariharan wrote:
> commit fb091ff394792c018527b3211bbdfae93ea4ac02 upstream
> 
> Add the MIDR value of Microsoft Azure Cobalt 100, which is a Microsoft
> implemented CPU based on r0p0 of the ARM Neoverse N2 CPU, and therefore
> suffers from all the same errata.
> 
> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
> Link: https://lore.kernel.org/r/20240214175522.2457857-1-eahariha@linux.microsoft.com
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  Documentation/arm64/silicon-errata.rst | 7 +++++++
>  arch/arm64/include/asm/cputype.h       | 4 ++++
>  arch/arm64/kernel/cpu_errata.c         | 3 +++
>  3 files changed, 14 insertions(+)

Both now queued up, thanks.

greg k-h

