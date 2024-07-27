Return-Path: <stable+bounces-61940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A56393DCF2
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 03:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E70A284F10
	for <lists+stable@lfdr.de>; Sat, 27 Jul 2024 01:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51FA15C3;
	Sat, 27 Jul 2024 01:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="SsTACFw1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZJyTTvqp"
X-Original-To: stable@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13668186A;
	Sat, 27 Jul 2024 01:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722044119; cv=none; b=hUhAH8x+zcYb0s/QV8iDDi/CvjZ82TZR+8eNixDBJyEMQs0tXsypuxdA2FwzL0Z5zDNB7VTODEBo0vvj1rc9h2AHmoFlFYrc95VkzPbH8Vy6NKrpoPA3AX8ToGE4xmufki63SGELvrYOD3Yms4hDESnA69LHf9slC3hbMFJcjoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722044119; c=relaxed/simple;
	bh=caKF6u6Pl+NoxLygxRMFyDqsz80P3X6Uwn53Yo++fvY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=R6l56E6d+kXOP0ZKRj91LXeT13KY4BL6rJlZjjCbFjQ5wVO3gMXy9MuVZGgJrmS8e7YMPC4flPJr/D23U4SO3oxe44k+Q0Y77gD1fMiYkdpJ8WaZdS2eSZs280F3LDKLv2BRJ7X3kJ3T5Dh6hNuXcnZG7gS+Ho4pe0bcgU8HuO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=SsTACFw1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZJyTTvqp; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0C323114016B;
	Fri, 26 Jul 2024 21:35:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 26 Jul 2024 21:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1722044116; x=1722130516; bh=oq
	cjv4bT7MIFsiqTNHBGPXx0q9DQaCb9mZzOClyodqM=; b=SsTACFw1XDFV8DKgxq
	jibFtpsUulIAceQTWNfRedAZVyEnVpaSJcdbyq+QuqLNaQ60FUXN8yVUGyK57Xoj
	7uQ+m4B+PiHy99xx0meQsPK2sEaerIEsUHsljX2S+znAs5e4k/IyHx8nJzAZCKNQ
	Yp3GCBMyWqUYb5UVi4b0VIMO9Y4ilUmkYTdZywsRQF4bNqxzsP5sfkbENeJiqdGw
	uVEbLAJr2a9S4IeastKZHMSHR3ay78sET0mqG0rdswifwMfz9YF+F2phbUhhJyIC
	IcPC4e1mNV8dI9O8gzspAXQndAoiXsUF9TQsbNZiDacBTsPLR/6Nc+2TKwEi3NJa
	RgGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722044116; x=1722130516; bh=oqcjv4bT7MIFsiqTNHBGPXx0q9DQ
	aCb9mZzOClyodqM=; b=ZJyTTvqpmSLVUzHIJwcN7y3lzNXIuaf/K7VhJgwHpwF9
	1JkDHKh4w0iqueN6J/PHBMQjGV8oSWMhZI7LfCVBg9ePnL6iPWKkG216qjPuKHAU
	wdqMFpZtXz6H7kwXl807IYH5bAq8WDwF57kIHTaAaNpcMUZMPC8gxz3C6OeAu1TV
	TeSRtYapEuwOvDqJX2ZZIDju0rSd+GLQzSaaX1mOqZdaPEMPD8ZTKJk1vQnwkPJi
	feBF5RMl+Vsh4IvwSYz49mPRKdbTbPI4lCbmW9VuzHn/T1VHJDRQikYyLG9UhNCp
	v3zY60YZfb5bA6VJabShUiSHH5sYKfn+YHTCMaSR2g==
X-ME-Sender: <xms:006kZgN-ePo0PUaBqf93TQ47a_r6XKa7EFlVIn8OnsTpbgiK62O9HQ>
    <xme:006kZm91PvNQdere4LRCCoSRrIQLuDrInOILfdEu0Co7PullGh7AfxEe6mBxUfm9w
    Gtsqz4bZ7296l3a96s>
X-ME-Received: <xmr:006kZnQSzirFzI7L9oIYmyz7S5aszGwD-VQWVGu00KIFyuEC1I0oEGrpfu0VSOYudG0f6nRmaV9p7tKewm_JtBOcpWYJA_0SmNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieeigdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeeuieffveeggf
    efjeeufeetveejuddtkedtgedtjeekgedufffhhfegkeekteetgeenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphdpnhgspghr
    tghpthhtoheptd
X-ME-Proxy: <xmx:006kZot_JT7q8sFbfXA-TdP7uk0btpMmCAPnzgpXfGlDxVfQA_ZmMA>
    <xmx:006kZof09YCdbat1C9BFnhywU0YUPa7EdwrU-IEeAH9MHuK4T3mGDw>
    <xmx:006kZs0DxeF-ujj4pLKvUxo67tJ1npqIGSmYecKcgSnokie7djo-sA>
    <xmx:006kZs9d5ttjKyeBpsTSF8VNmRZVp7oeWqgz6_YkLdireMhxZBFt-A>
    <xmx:1E6kZtHKzaRg3g8aVCulUTUK80VhUGXbMg3lP3mYbXEthMI8WcYZCfCG>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jul 2024 21:35:13 -0400 (EDT)
Date: Sat, 27 Jul 2024 10:35:10 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: tiwai@suse.de
Cc: stable@vger.kernel.org, edmund.raile@proton.me,
	linux-sound@vger.kernel.org, gustavo@embeddedor.com
Subject: Re: [PATCH] ALSA: firewire-lib: fix wrong value as length of header
 for CIP_NO_HEADER case
Message-ID: <20240727013510.GA163039@workstation.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725155640.128442-1-o-takashi@sakamocchi.jp>

On 25/07/24 09:56, Takashi Sakamoto wrote:
> In a commit 1d717123bb1a ("ALSA: firewire-lib: Avoid
> -Wflex-array-member-not-at-end warning"), DEFINE_FLEX() macro was used to
> handle variable length of array for header field in struct fw_iso_packet
> structure. The usage of macro has a side effect that the designated
> initializer assigns the count of array to the given field. Therefore
> CIP_HEADER_QUADLETS (=2) is assigned to struct fw_iso_packet.header,
> while the original designated initializer assigns zero to all fields.
> 
> With CIP_NO_HEADER flag, the change causes invalid length of header in
> isochronous packet for 1394 OHCI IT context. This bug affects all of
> devices supported by ALSA fireface driver; RME Fireface 400, 800, UCX, UFX,
> and 802.
> 
> This commit fixes the bug by replacing it with the alternative version of
> macro which corresponds no initializer.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 1d717123bb1a ("ALSA: firewire-lib: Avoid -Wflex-array-member-not-at-end warning")
> Reported-by: Edmund Raile <edmund.raile@proton.me>
> Closes: https://lore.kernel.org/r/rrufondjeynlkx2lniot26ablsltnynfaq2gnqvbiso7ds32il@qk4r6xps7jh2/
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>   sound/firewire/amdtp-stream.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
> index d35d0a420ee0..1a163bbcabd7 100644
> --- a/sound/firewire/amdtp-stream.c
> +++ b/sound/firewire/amdtp-stream.c
> @@ -1180,8 +1180,7 @@ static void process_rx_packets(struct fw_iso_context *context, u32 tstamp, size_
>   		(void)fw_card_read_cycle_time(fw_parent_device(s->unit)->card, &curr_cycle_time);
>   	for (i = 0; i < packets; ++i) {
> -		DEFINE_FLEX(struct fw_iso_packet, template, header,
> -			    header_length, CIP_HEADER_QUADLETS);
> +		DEFINE_RAW_FLEX(struct fw_iso_packet, template, header, CIP_HEADER_QUADLETS);
>   		bool sched_irq = false;
>   		build_it_pkt_header(s, desc->cycle, template, pkt_header_length,

Applied to for-linus branch in firewire subsystem tree[1], and would be
sent to mainline today with another patch[2].


[1] https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git/log/?h=for-linus
[2] https://lore.kernel.org/lkml/20240725161648.130404-1-o-takashi@sakamocchi.jp/

Regards

Takashi Sakamoto

