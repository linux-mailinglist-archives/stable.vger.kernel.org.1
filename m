Return-Path: <stable+bounces-189953-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBE5C0D260
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 12:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2C0B04EA53B
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 11:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287834438B;
	Mon, 27 Oct 2025 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ifq5Ff6l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mcIeL0OD"
X-Original-To: stable@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775EE2E413
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 11:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564631; cv=none; b=UI4w/RoFgt6HzlbcB0uDhewQNXQ9QRuI6obTVDGqJBz0jMeK0FBULx0MhDftVdKq23vz7AW028OSiHTeC6zWrnRanSWfxQBg/IFns/6cXRh7vQ1dqd8zQN5tbGGwHxLzISpObWpYTUPGHkqyt4/7eGI4JvpdthZe3KQ0FG7185o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564631; c=relaxed/simple;
	bh=uW/eN2oC89tzmpNwIH1rP+UCTg+ZG0ib8ywUsZ6ddk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIPhGpm2ZNUWthTXItiopuQtdDTbr+alX8Ym8RXaxkxmZiyNnMEVg/lh4drO+ZjL8bCKvScjropK0VdQcYUqjnumGrAj4zhSyDGaq3ol9ZbTqfhSD3Y8QOxvyNKN1Bbxu9H9+5323lnZs2qz8PcUXvD3e7eOahDvvGMvKHNeN0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=ifq5Ff6l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mcIeL0OD; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 571711D00245;
	Mon, 27 Oct 2025 07:30:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 27 Oct 2025 07:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761564628; x=1761651028; bh=mrJvb+mELX
	W+fOjOjCYZoaaP+OYyfGi+3L2VftVWpFA=; b=ifq5Ff6lecXhSlKJz3YqPgj9UY
	tdCSjAozIa5pSL+VVUDaYh25uUyxCPvS2v9AXtNajQEuC9lhqPwZjeDtnOKr3bQi
	PvEXTdeHnU2hMN5Jp34GA21BfvO8KfxIZb/B0lTw2kMKCI3vJIoUIZvgHP7KL5o5
	V8bKXKpI6J5nqUrCJjrXXhTwLpVc3chfpfQuBxVZPY8il6MBNHUJYpId3rMdjkS5
	OLIhn+Ie6HXhRRpbg/5pE0Q47aCHa6Kj+T9CCm/9OjC730dv0ni3pWREjQv0hXb0
	si/SiwwmEAf/yuorYWBzmr1SmSMujhpOZ6OLSgZ7GOraXsBVcQx+g+kcsmMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761564628; x=1761651028; bh=mrJvb+mELXW+fOjOjCYZoaaP+OYyfGi+3L2
	VftVWpFA=; b=mcIeL0ODz/6QLvfhLurtH+L4uZqQGbfmDpApJEeyiE/dwmBpOWM
	BRzm44Gh6yBklSt2cI5UgPyVqBarmLMYLlbqHMcz08rJ3DxK0LLCoaZkYoUD+ITj
	ebeABQGJmxqWw2XiYSnl50ZNhOYTE1kfaUFlNcVA523pA1jPRg/VYvpf1Zd9nFKB
	qi0OKR9bUzWJI3bpWRIWT0aBIZSZyilyfT5b6cGLS16A5+CFSoG5sgA548pjK5D/
	MjdbZJqc8bozmk1J+HATq08w2UaahnNWP/3YTpPxXYlSmesuVl/pdGAq+CcLb7qW
	77JjatH0Ri4afuuRpnSQImAJdOJCYrk1x0A==
X-ME-Sender: <xms:0lf_aKpVitPYQuJAj4JOtYF9Rxl2WA6vVGVf5XutXfRsVc_CLSJ17g>
    <xme:0lf_aLs2CvDrg2bQIKlWo95f0Bhdx1XWE6oxyI3cf3pYBWMMIBD29oc8iNAXN_15s
    zpTHmOTCcLtN2JsZ7YRLrzQX7XV682NdgFokl4_dE7K6anoDw>
X-ME-Received: <xmr:0lf_aJ0nB1ztIcO8ir7w8gR9hbhQI-Nmqeqp7A_ZB46VhJAYCBBu9F61ZlSBRSNngegrJ7UdD1SLJujzsurmjaNktKTMOqkjwiH1Kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepkedvudelhe
    ekfeffgfduhfdvjeegtedvfedtgffhffetteeiudelhfetvdehgffhnecuffhomhgrihhn
    pehgihhthhhusgdrtghomhdpmhhsghhiugdrlhhinhhknecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhn
    sggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhifuh
    estghovghlrggtrghnthhhuhhsrdhnrghmvgdprhgtphhtthhopehsthgrsghlvgesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhntghhvghnghdrlhhusehhph
    hmihgtrhhordgtohhmpdhrtghpthhtohepmhgrihhlhhholheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepmhhklhesphgvnhhguhhtrhhonhhigidruggv
X-ME-Proxy: <xmx:01f_aGFjYSBry5iqMTrkEQTKhYSvr-yNdlvHkMNEG07pgXPcwVkNeA>
    <xmx:01f_aEvf7JcXXzEYtduGPRtFjzXVRiZdE78LVh8G1PQTgmb5i7xZLQ>
    <xmx:01f_aJqFDiZkF6CFVIARPEh5q9psrSZmd1R0xsZGnSqc8ps38zRjyQ>
    <xmx:01f_aLUAqn_K8C8F-NdyJtS413trThDFcdLIH0wJJK7y0nAuiI3LnA>
    <xmx:1Ff_aFmBIzz2Q714gULtE9AnzMy8s0QGu9sr44Jf2taG60RkJpIvvWak>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 07:30:26 -0400 (EDT)
Date: Mon, 27 Oct 2025 12:30:23 +0100
From: Greg KH <greg@kroah.com>
To: Celeste Liu <uwu@coelacanthus.name>
Cc: stable@vger.kernel.org, Runcheng Lu <runcheng.lu@hpmicro.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 6.1.y] can: gs_usb: increase max interface to U8_MAX
Message-ID: <2025102718-groove-dimly-a7d5@gregkh>
References: <2025102038-outsource-awhile-6150@gregkh>
 <20251020122616.1518745-2-uwu@coelacanthus.name>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020122616.1518745-2-uwu@coelacanthus.name>

On Mon, Oct 20, 2025 at 08:26:17PM +0800, Celeste Liu wrote:
> commit 2a27f6a8fb5722223d526843040f747e9b0e8060 upstream
> 
> This issue was found by Runcheng Lu when develop HSCanT USB to CAN FD
> converter[1]. The original developers may have only 3 interfaces
> device to test so they write 3 here and wait for future change.
> 
> During the HSCanT development, we actually used 4 interfaces, so the
> limitation of 3 is not enough now. But just increase one is not
> future-proofed. Since the channel index type in gs_host_frame is u8,
> just make canch[] become a flexible array with a u8 index, so it
> naturally constraint by U8_MAX and avoid statically allocate 256
> pointer for every gs_usb device.
> 
> [1]: https://github.com/cherry-embedded/HSCanT-hardware
> 
> Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
> Reported-by: Runcheng Lu <runcheng.lu@hpmicro.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
> Link: https://patch.msgid.link/20250930-gs-usb-max-if-v5-1-863330bf6666@coelacanthus.name
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  drivers/net/can/usb/gs_usb.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)

Breaks the build :(

