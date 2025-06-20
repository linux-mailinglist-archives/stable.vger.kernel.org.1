Return-Path: <stable+bounces-155170-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4615DAE1F79
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8611889681
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDEB2DFF2C;
	Fri, 20 Jun 2025 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="YKlwUAzL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kBf5dlwQ"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DCB2DCC13
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434730; cv=none; b=Qu86k8JzZ1XmXbxXs22gGezEXy7rhDTwcbZ9b5gDE9ER0hUEtmUpTnN1p6sRMzveQ9q6XR/NtxN0AsZXXpcPOO0u0Bo1S8wr6l64jkRDElrkyOSNEq5yvKoXXhskLGCyx3IsajAvUQpynJOF7mdeLKIUrCYdiuXsafeOqfzMgWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434730; c=relaxed/simple;
	bh=xiZTiVv1UqfU93QFZK1ozpktJuJp72B3zO7QW0vVGwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mean7arkAdq2lHSsfG/9/ovtqG0KIOvp8k06ZXSdwsmkNzcsjzwfi4Xaw9LLtq7f45qa0AuzYQkLalODn/1GLWYP0xHMqLKu9SOkXnKx6OHkLhXxzebYSDhDjh2D1OB4D7Q9HLbqfOwEpiuIlwDtfxeJ3ZfOkncwU1D7U0E8Rjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=YKlwUAzL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kBf5dlwQ; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 183262540118;
	Fri, 20 Jun 2025 11:52:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 20 Jun 2025 11:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1750434726; x=1750521126; bh=NaN1PWDDZ3
	UFj6DApSn1qtifvcg0oOiG50gIme/Bnng=; b=YKlwUAzLYblqdzOfRpoa+yvqSx
	yXxELyqkfybDjNDJBoRR7guh5UJC/2bC49VZADBGTD2bPTw+S+aD4z6/vtwwZzQS
	2y8/I2SDXtfJQZqFKzUN/XKvG7oz75YxeLbKkTqm6fdL2pTu/rr3p1XTvg5O01uv
	VP9sKYHPiwFy74I/dIyQOzVEGZ9TamxryARNOqF+T94ApGK7wc8uCTW9/+1/GHy2
	c3d8o6HV3CnlAqhR+nrTcKPUYPtB4W5BM/dQAotQD8KWlHeYXVRdxWa5oT+N9vM1
	uhTP93j+HBxoXElgeYcZpSLw/AKUgIFIvXdlPM3YfoSwcw+Gx8n2iyNZFSUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750434726; x=1750521126; bh=NaN1PWDDZ3UFj6DApSn1qtifvcg0oOiG50g
	Ime/Bnng=; b=kBf5dlwQ3lM/x9PQ7AKzb1DNmXQIK+VszyedT6ySXyoJmzI5D8y
	uDgkhYXTIXSsbG8oxT0HtcxkrBPeFBmr0Mkif9k4Vy8GzHCq2X1PJ6aYpNo5nuKU
	l3LQcRSz3F8bztq+Bntr/TCxTz7O9mSwusDnbZCLWehBd3k/O3qQ12jJVHktAF7N
	mDenT2YWt8wmOFVUyspQ/OxLjmFA48NwkbVcGuhVF98Tawk43YBXYULjHt/DnjVD
	yrilGxtExtCdjWHn3D7HBl5Ee8O8OWblXJ4B4SdZdAvpmhzAdaIjD08ikASy0FnH
	grSq7ndbqd5rq81FMJ+1tYazinTTNg5UOJQ==
X-ME-Sender: <xms:poNVaCdNyZK7U7YiB09i7CPyCwFnqcNJSo2wxWoHGnylugBGwCUUEA>
    <xme:poNVaMP_8JSc18zXcIYdFUOZiqgAvq7XbwR4sYvGnJQj7IYYXSQvh6lTedooHzNKX
    fLoKwIHPTjBOg>
X-ME-Received: <xmr:poNVaDhwislERYc0RrZoODpqD0ZQFX2d6MsCFKtphTlKPeg1j3s2Sj754ooRNLCGPWyVHPnmTMHHDpFqil-gtQtOSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdekkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfmjfcu
    oehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepueefudetheelvd
    ffffegvdejleeuffejtdekjeduhffgheekhffgffefffevuedtnecuffhomhgrihhnpehg
    ihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgpdhpmhdrmhgvnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgt
    ohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hshhhunhhgqdhhshhirdihuhesshhushgvrdgtohhmpdhrtghpthhtohepshhtrggslhgv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhhohhrrdhsohhlohgurh
    grihesphhmrdhmvgdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:poNVaP-DR3ltsk_5aOTrYnNwxiRlVOtsaT_gownGbjOn7Gu7lE88RA>
    <xmx:poNVaOsRYvFxIproXKSuR4PTIHdONvRy8DJnveVjRknP1RIjLLtB9Q>
    <xmx:poNVaGFfZbJQLEVLxPwRG3J-pJ8sF1VIhDjhWivqhODkpGY_a3bosQ>
    <xmx:poNVaNNT5IbG8oWVggomfXdC-EvZp3G8y-wBnTCUgZph5zJJBn6yjQ>
    <xmx:poNVaIt3s7uJaapVfKaQR47CntmLpZc5IN8zV2fxBNUSiLBogY8LCCtO>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 11:52:06 -0400 (EDT)
Date: Fri, 20 Jun 2025 17:52:03 +0200
From: Greg KH <greg@kroah.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: stable@vger.kernel.org, Ihor Solodrai <ihor.solodrai@pm.me>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH stable 6.6 6.12 1/1] selftests/bpf: Check for timeout in
 perf_link test
Message-ID: <2025062057-unfounded-refusal-1796@gregkh>
References: <20250609052941.52073-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609052941.52073-1-shung-hsi.yu@suse.com>

On Mon, Jun 09, 2025 at 01:29:38PM +0800, Shung-Hsi Yu wrote:
> From: Ihor Solodrai <ihor.solodrai@pm.me>
> 
> Recently perf_link test started unreliably failing on libbpf CI:
>   * https://github.com/libbpf/libbpf/actions/runs/11260672407/job/31312405473
>   * https://github.com/libbpf/libbpf/actions/runs/11260992334/job/31315514626
>   * https://github.com/libbpf/libbpf/actions/runs/11263162459/job/31320458251
> 
> Part of the test is running a dummy loop for a while and then checking
> for a counter incremented by the test program.
> 
> Instead of waiting for an arbitrary number of loop iterations once,
> check for the test counter in a loop and use get_time_ns() helper to
> enforce a 100ms timeout.
> 
> v1: https://lore.kernel.org/bpf/zuRd072x9tumn2iN4wDNs5av0nu5nekMNV4PkR-YwCT10eFFTrUtZBRkLWFbrcCe7guvLStGQlhibo8qWojCO7i2-NGajes5GYIyynexD-w=@pm.me/
> 
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Link: https://lore.kernel.org/bpf/20241011153104.249800-1-ihor.solodrai@pm.me
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---
>  .../testing/selftests/bpf/prog_tests/perf_link.c  | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

