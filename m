Return-Path: <stable+bounces-41763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4898B6150
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 20:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9321CB20DB9
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 18:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ED713AD11;
	Mon, 29 Apr 2024 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="mMqrnJ+F"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4AD13AA20;
	Mon, 29 Apr 2024 18:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714416367; cv=none; b=qY2KV0gaSgFwGkdo+kSR/1+1Sh5hS3nZBIzpndUV7bph3mi7eJZTuz1Y6YgzfhivtBmB3FQP26QpdXMNjIhp6FzF8H5ECWzve1MV8RsMFwwEBgcRBe2E1xMTY2NQrA8lYxjbMMYA8D7VPWFQNgQmRt04sz+pC3UcWD8wMPVtn3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714416367; c=relaxed/simple;
	bh=3LH0ATCDUz78r2Tey+5bXVs+rUczTd3e47hk9qUT2uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ulpn8ns6Z3JGQXVFDc+0W7pKQiUkOIDS01+1+aW8PsIV5UBQgPH0Rv71hVfTkM+uCc2tIOFW1aC/RNVm6UBG03WtFklDb/PbOJeagAM7aZS67sT3IXIjUrhoFaJOr24llcIvtiS0Lhcqya8HlI6XUdLaCYDb7kwtP7qg1ZXvSKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=mMqrnJ+F; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=ZkJzNvR/m4pjy1+DgD6tXtFggu8kp9OwAo85IxPakxg=;
	t=1714416364; x=1714848364; b=mMqrnJ+FhZXdK5FEOih/T4F32qHzR2uAmg+7T27fDijNOlP
	2HrrSBmYOaMVb9btdat2GHy+fsfJnlUOdi6GKad0ToGfTXwoJMJ3KVE4vy4ajTrW0B7fylikChbg+
	ehjWazipG4om9YLyitMEIcvf0rRTeTkPKvfD7su/10CioE4Oh8IEKlIp9+G8P3NgLxFcmrkh4Lge9
	4tr4n0Iz3TOk5JfJ2tHchZj8VV/0QnLSYrqt/eX61J4JoJCpGLTJ7ZD3VlvMNhGUvUSZUBGYZE4DW
	UpTsOefxSDXaTJ3YEsPdYW6fD2U57Dky2A1+k9VDPYH97hFx/f2q81pESJ66oKIA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s1W0o-0000lq-9l; Mon, 29 Apr 2024 20:46:02 +0200
Message-ID: <8e8ca7a6-1511-4794-a214-2b75326e5484@leemhuis.info>
Date: Mon, 29 Apr 2024 20:46:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bluetooth kernel BUG with Intel AX211 (regression in 6.1.83)
To: =?UTF-8?Q?Jeremy_Lain=C3=A9?= <jeremy.laine@m4x.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
 Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
References: <CADRbXaDqx6S+7tzdDPPEpRu9eDLrHQkqoWTTGfKJSRxY=hT5MQ@mail.gmail.com>
 <1de62bb7-93bb-478e-8af4-ba9abf5ae330@leemhuis.info>
 <4bf3497d-0ede-4e05-a432-e88e9cbc10b4@leemhuis.info>
 <CADRbXaBkkGmqnibGvcAF2YH5CjLRJ2bnnix1xKozKdw_Hv3qNg@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CADRbXaBkkGmqnibGvcAF2YH5CjLRJ2bnnix1xKozKdw_Hv3qNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1714416364;7c17985c;
X-HE-SMSGID: 1s1W0o-0000lq-9l

On 29.04.24 20:28, Jeremy Lainé wrote:
> 
> On Mon, Apr 29, 2024 at 12:24 PM Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> So we either need to find the cause (likely a missing backport) through
>> some other way or maybe revert the culprit in the 6.1.y series. Jeremy,
>> did you try if the latter is an option? If not: could you do that
>> please? And could you also try cherry-pikcing c7eaf80bfb0c8c
>> ("Bluetooth: Fix hci_link_tx_to RCU lock usage") [v6.6-rc5] into 6.1.y
>> helps? It's just a wild guess, but it contains a Fixes: tag for the
>> commit in question.
> 
> I gave it a try, and sadly I'm still hitting the exact same bug when I
> cherry-pick the patch you mentioned on top of 6.1.y (at tag v6.1.87).
> 
> Thanks for trying, is there any other patch that looks like a good candidate?

Well, did you try what I suggested earlier (see above) and check if a
revert of 6083089ab00631617f9eac678df3ab050a9d837a ontop of latest 6.1.y
helps?

Ciao, Thorsten

