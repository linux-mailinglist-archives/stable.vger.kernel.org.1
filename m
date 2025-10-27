Return-Path: <stable+bounces-189965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A8EC0DA3E
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 13:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E969420F40
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 12:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D809135975;
	Mon, 27 Oct 2025 12:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="lu6C/Tuh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1+0sVhQe"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B61E18DB26
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568587; cv=none; b=rEZAkiCdG+gCojFprQ+qpP+hcHWs1w7rC8OZDwOUbjW1wjHkM3WBDKLThj15tqcNWgy3FiEDm4P7b31P07FstpgYyTC6O1SbKmTZchO8IshtWsS0SeiZWXxME4BqpOgwJEBEsM6dNMKf/8HtK8XmtiQSVR+nw01FBlRZ5S69NcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568587; c=relaxed/simple;
	bh=BclNnW3wldH2o/wgE939m3ajOJK2nf2stszZOuVeQBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNRtTCfCu1R6DPVZqNQru7kbv8iJgRUzkiHDIs2hksp2GOLcH+0pDW2vZD8+B+BgQqmdFcywPG1BUMVWFwQl3SdT/cjQi+aqwQOMb7hiBRUAqZqP22qT4Bpf7AIoXTdfSPQ6ssUmUiaZSW1EI5BasEswSwXa9uqt+ytq8QXwPOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=lu6C/Tuh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1+0sVhQe; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 780041400256;
	Mon, 27 Oct 2025 08:36:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 27 Oct 2025 08:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761568584; x=1761654984; bh=BAozztRhu9
	W165MtYWDG1P6jcNHOalf3kNdauyy9EPM=; b=lu6C/TuhKR9hTTkt3dhOZW5c4L
	ts34xY+4gwsrTHiHS7F4Dk7ZHbRtBhHg4sMa1zdzb6WxLFaBNzKSl/ihywPCLaTM
	N7kdLK/WBE6U/FaUuFaXjM+ld2KkiG/OspCYJbf/WrHXZMuA96Nw5teQG+QnLwS7
	oL+TIT7YuhsTpMwfVeYwqso+mMPbE9hWCPlxDuYjaaDHwi8aEWBxzjMv5lPOiGVU
	S+ICIMwaWnfd8L5Kt8dLSOpvK1WsT4y3HEscjIVaCt1RPjhdzEIE53hVuTIhIcO0
	q3fpwhmNy3ZuFDZ3Lzn3E53P6job5P78N1f5ldgzNumkgpeLbCLbY7B4fH1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761568584; x=
	1761654984; bh=BAozztRhu9W165MtYWDG1P6jcNHOalf3kNdauyy9EPM=; b=1
	+0sVhQesnK8X8YVTozzTCIwJl7P8U8vGt5V38TF+puKWvmsnZVyFw/+eDtJXAJ8+
	iCu3WoWoe4tjs22d0WBOckZBpRPL8NufFrDJzc+yqNQ7/TlJUz94Z+WTafzyuYsN
	f6FH9ZbEZYwGOeSzpxWzNVQIHz4Y5vQOaDiH4faU+R/9/gKfWg/SnkpQfgAA1k3j
	NWzy6aI9VuxBTB1Pcdry6wkpLT9u1XL1HyD5RTmcGIPNlCt6RDyYu2VyVK5yWpj4
	c8RgKQACkHVXb2PbpgyA7so1eHqD0IGVI7hZHt09oFcOBI4sWnnokecZwSBfLBFZ
	xcOb+qFEScNXpFpv3euZQ==
X-ME-Sender: <xms:SGf_aCBYtKPIBLIrsDXc7nLEX_36oT4i_Dh8ZoSB5kBsXkzE7jLT4Q>
    <xme:SGf_aDYso9MxeMoWxuO8oMU6SmEdwtqeGB3Kuh1q2fcuqz6sxW8-id1_dJ58YwPjj
    N436xpmodySJw5ewGpV6d04JxSXsOEa9TxG88yH_jCH4iWJInfwgy4>
X-ME-Received: <xmr:SGf_aN7pDO_flSH5XyItiMYH6TjL9hcROH0dbjml2Rwe1UwTuzLmBoz5-lZa2WCp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeevvghlvghs
    thgvucfnihhuuceouhifuhestghovghlrggtrghnthhhuhhsrdhnrghmvgeqnecuggftrf
    grthhtvghrnhepfeevkeduhfdujeetueettdekuedvvddugeeuudeiueejjeeljeetteej
    ueduffeunecuffhomhgrihhnpehgihhthhhusgdrtghomhdpmhhsghhiugdrlhhinhhkne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuhifuhes
    tghovghlrggtrghnthhhuhhsrdhnrghmvgdpnhgspghrtghpthhtohephedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepghhrvghgsehkrhhorghhrdgtohhmpdhrtghpthht
    ohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhunh
    gthhgvnhhgrdhluheshhhpmhhitghrohdrtghomhdprhgtphhtthhopehmrghilhhhohhl
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmkhhlsehpvghnghhuthhrohhnihigrd
    guvg
X-ME-Proxy: <xmx:SGf_aMYx5gQ1OAsZCJWmr4WXNXSXfrAyy3Zi1tecDXb0QpoHU3_3KQ>
    <xmx:SGf_aEjSWLLGelr6QJQ5sZd1SmF7gCww-NG-EPRBqeKZ8L06czkuKw>
    <xmx:SGf_aF-SGgsRC_JhfoQccbZheqQieB9--9fA9MQzXMS9j4UuKcDVfA>
    <xmx:SGf_aHr0nkEaj1Fv3_BoAqZFg4zyUrFTj8_Wx1O89xpZHhnSYyaLsA>
    <xmx:SGf_aJoZR1H99a_J04vydLivm_aYlgve-EGJpE0yFXXZR3_OE_weOxT6>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 08:36:22 -0400 (EDT)
Message-ID: <d44b2488-e53d-4b5c-a795-63daec557f3b@coelacanthus.name>
Date: Mon, 27 Oct 2025 20:36:19 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] can: gs_usb: increase max interface to U8_MAX
Content-Language: en-GB-large
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, Runcheng Lu <runcheng.lu@hpmicro.com>,
 Vincent Mailhol <mailhol@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>
References: <2025102038-outsource-awhile-6150@gregkh>
 <20251020122616.1518745-2-uwu@coelacanthus.name>
 <2025102718-groove-dimly-a7d5@gregkh>
From: Celeste Liu <uwu@coelacanthus.name>
In-Reply-To: <2025102718-groove-dimly-a7d5@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-10-27 19:30, Greg KH wrote:
> On Mon, Oct 20, 2025 at 08:26:17PM +0800, Celeste Liu wrote:
>> commit 2a27f6a8fb5722223d526843040f747e9b0e8060 upstream
>>
>> This issue was found by Runcheng Lu when develop HSCanT USB to CAN FD
>> converter[1]. The original developers may have only 3 interfaces
>> device to test so they write 3 here and wait for future change.
>>
>> During the HSCanT development, we actually used 4 interfaces, so the
>> limitation of 3 is not enough now. But just increase one is not
>> future-proofed. Since the channel index type in gs_host_frame is u8,
>> just make canch[] become a flexible array with a u8 index, so it
>> naturally constraint by U8_MAX and avoid statically allocate 256
>> pointer for every gs_usb device.
>>
>> [1]: https://github.com/cherry-embedded/HSCanT-hardware
>>
>> Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
>> Reported-by: Runcheng Lu <runcheng.lu@hpmicro.com>
>> Cc: stable@vger.kernel.org
>> Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
>> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
>> Link: https://patch.msgid.link/20250930-gs-usb-max-if-v5-1-863330bf6666@coelacanthus.name
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>  drivers/net/can/usb/gs_usb.c | 21 ++++++++++-----------
>>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> Breaks the build :(

Sorry.. I have sent fixed version..

