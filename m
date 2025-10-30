Return-Path: <stable+bounces-191700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F3CC1F18E
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 09:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17EC1897958
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 08:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FAC311956;
	Thu, 30 Oct 2025 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="nmzpqbDj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ITFmpGqq"
X-Original-To: stable@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1A72DC76F;
	Thu, 30 Oct 2025 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761814066; cv=none; b=QeoOTzMX5dP0uffAcf7RrbNtwdbRC1oqlXX2yl9W31hcI9t/dBgAiVcvC8QIRCtfOB+y+THwckFnGmWTnr6UbaTSlHPDfbV1kIAM25oF5LvTwFcaToao9f4eSUMeXJIuHDrd/SCW/dk+nk8JFSkvRRXFoormczsMNf3tsRN7Fl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761814066; c=relaxed/simple;
	bh=YnGa9DkQdvPRdDeqi8ahGPx9h1DVPHnC6LaywWx0p5w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UYYv0YLF6duPmsdEeWWg/2FXENoaIVj0Le8ne3Ci9ka2wHJ486DQySPoULBj3I2UYorIOwWolmfslrPY/reXGmoETf4NEYJFxGaz3f5pm+Eq1bmqf/mfIL6dg9ZFLGdk55YNopQHqAZEjv3ZE2HsGpRsZALPmpuN/l7UZ7ZGUdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=nmzpqbDj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ITFmpGqq; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C5E52EC011B;
	Thu, 30 Oct 2025 04:47:43 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 04:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761814063;
	 x=1761900463; bh=+LlsZk9yFd6QOpKTkvqKXGcbGnaMjw3ZltDuDEqH3fk=; b=
	nmzpqbDjw6y1CJqAbTLfcl+bxSs+xEkjNtDm5rU77iQqfJLfO+y1qbb3bfDastaX
	CM16o79l9/V4AoiDN5ls7SUfDozOXPFHnMRKRKlkJG+9WoRlUvXbb1z8SPZ+NOTt
	iHaIGJxmmybz3MDM/l3+Zx7rTpIlqftg4WNwOXY7Fu1P3SNscpRKMP0NDu1VzZC0
	f8zNDFTUWPHtJHv30RGxfGA1yoBdk1+7E68Kr4K9V5falvg7AbexERdlhNstHhZc
	5g8JIqXpb1Oy/qpAv6w26MgukVHf/6fzPPxRMEn+Wt8w1cjwUmhDvAxwsWfqxaw0
	P1Vs6Gy2to83ml357+oajA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761814063; x=
	1761900463; bh=+LlsZk9yFd6QOpKTkvqKXGcbGnaMjw3ZltDuDEqH3fk=; b=I
	TFmpGqqqCDBrWBwD3VwC6HHTzkdDyviLySPXNhMJvS3ZL7oplYuwPzEKOXqOwIXw
	+bBM2TWbMzPeOucTcA2fyKtxmUyVeKvIQF4wy6eh9ycj14QzK6NhR8Sjp8uutVWX
	s1Nc3MpTlFGcwy2eiOkmEKsC+NjdiYnkzJeF7gxAE0HFUW1s0WWijMtsO4zuMorC
	hIwIa7BC2xpeC8ENhAddY1vHbGkL2hqbCw87bOED6Q/ukIvw3Q0EZJzfGifawoSR
	Jzv6JS+ObBQEgxw8HW6jNUzdrN4ApF5o9Ot5wvZlPbZJQIIws2AAxMQwPMbT6V6/
	Bw7Ihdo+CSc1bPJnj8gCA==
X-ME-Sender: <xms:LiYDacEeXc7JF8wx4TqL_9BPZBkL55-Dn0NwhJr8TnjQnhzTtv5G5Q>
    <xme:LiYDaQJSwho8UWHqENe-n48LwapOKkHD1m2kK3xMPcEs_f-jR-Jha_6eCO3ptNaVc
    YyK5pM_2Js7Cev4haA4Dbdmffqfi_04_NK6VPtqkd2yFRHOqC31c2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieeiudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdprh
    gtphhtthhopehlihhnmhhqtddtieesghhmrghilhdrtghomhdprhgtphhtthhopehruhgr
    nhhjihhnjhhivgeshhhurgifvghirdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlih
    hnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepfihsrgdorhgvnhgvshgr
    shesshgrnhhgqdgvnhhgihhnvggvrhhinhhgrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggs
    lhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugiesfigvih
    hsshhstghhuhhhrdhnvght
X-ME-Proxy: <xmx:LiYDaUkRvCSMRRNT4vjLTd07Fb7CqufoXLvxIKjfZ8lKTTB-a3Zhfg>
    <xmx:LiYDaf3vnrmPs16wiUlzsUR2gD7OzVBbth80GnRrDjgs09zjkP0WDg>
    <xmx:LiYDaU3NSPpiLtb2RhnEqqO573m5yXalPjKMfHIyT31jxiLS3ZxRKg>
    <xmx:LiYDaRp4IjX6-rCSRwKJkVPqYx1gV50TQR4dTQvQu-3epsqHtm5Trw>
    <xmx:LyYDaRcJIvBGtSwUcuxluN6jYgSq8hixEOjoY0QPoKV6iRq3f5a0aiy9>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B4B48700054; Thu, 30 Oct 2025 04:47:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AIIjj2dROt1-
Date: Thu, 30 Oct 2025 09:47:22 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Miaoqian Lin" <linmq006@gmail.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 "Ruan Jinjie" <ruanjinjie@huawei.com>,
 "Luca Ceresoli" <luca.ceresoli@bootlin.com>, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Message-Id: <0f712780-8af0-4894-b75c-44fd7390dc3e@app.fastmail.com>
In-Reply-To: <20251030052834.97991-1-linmq006@gmail.com>
References: <20251030052834.97991-1-linmq006@gmail.com>
Subject: Re: [PATCH] misc: eeprom/idt_89hpesx: prevent bad user input in
 idt_dbgfs_csr_write()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 30, 2025, at 06:28, Miaoqian Lin wrote:
> A malicious user could pass an arbitrarily bad value
> to memdup_user_nul(), potentially causing kernel crash.

I think you should be more specific than 'kernel crash' here.
As far as I can tell, the worst case would be temporarily
consuming a MAX_ORDER_NR_PAGES allocation, leading to out-of-memory.

> Fixes: 183238ffb886 ("misc: eeprom/idt_89hpesx: Switch to 
> memdup_user_nul() helper")

I don't think that patch changed anything, the same thing
would have happened with kmalloc()+copy_from_user().
Am I missing something?

> +	if (count == 0 || count > PAGE_SIZE)
> +		return -EINVAL;
> +

How did you pick PAGE_SIZE as the maximum here?

       Arnd

