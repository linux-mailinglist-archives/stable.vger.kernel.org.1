Return-Path: <stable+bounces-119545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD570A44894
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 18:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D3917A5B3D
	for <lists+stable@lfdr.de>; Tue, 25 Feb 2025 17:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C401B19993B;
	Tue, 25 Feb 2025 17:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="vQk4+0T0"
X-Original-To: stable@vger.kernel.org
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F7A194A59;
	Tue, 25 Feb 2025 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.182.119.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740505292; cv=none; b=DjwKbYa87nhVqnPBHHA1lfm6gelOdk8AcqpFXwWmbhyQoOM/OzjqXzoDDii00Oam6Hqex4UyFn4KVNGaZ+MpjY/JgSElcM91rqNz1h2CKO66oMNP3qFEEAzrUUAa30VP6Tu5ws4naRmS3lxCx+8bWGQsoLQ0/S9HOs3mlRMUw90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740505292; c=relaxed/simple;
	bh=gZ9azeov55xkLXY+W2frk6ujUo/ML78OAupnzsnNQ5I=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=VhtydxyWFUvTuEe3v+fwQVlHNkjpVeZT/4ktKO2LwUhLG5G/JaVSxv7rC4M/qXWux4pTkKqbsoEPnChG/gfV7/pzxOv/eSh+O5vD2Ia7hiGLc/5qU/RPJkK97nJ9u1W+TmAysYohDDdFwVSRMEwJuV0GCAg8HHLXclgv4uh9lIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=vQk4+0T0; arc=none smtp.client-ip=217.182.119.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay3.mymailcheap.com (Postfix) with ESMTPS id 0722A3E917;
	Tue, 25 Feb 2025 17:41:23 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id E11F2400F0;
	Tue, 25 Feb 2025 17:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1740505280; bh=gZ9azeov55xkLXY+W2frk6ujUo/ML78OAupnzsnNQ5I=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=vQk4+0T0pO39EPIqQLmw0e7DKkbyF4Vs3kxxgVJX33WOs4nDDOgat8kjoovATDQia
	 dU9TspXZKxh2avYay+RvtXQFFj1wRtGpKpa23wjq9qS+y8WSsRLK+lQJZdHnQ9dWHJ
	 1jT9oZzMAlldzLOqXHdMctW8OeLyKWa1JzviVn5g=
Received: from [172.29.0.1] (unknown [203.175.14.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id D1B2B401D1;
	Tue, 25 Feb 2025 17:41:17 +0000 (UTC)
Message-ID: <c2b8f8af-db2b-4b64-9e45-83e2b0a3d919@aosc.io>
Date: Wed, 26 Feb 2025 01:41:14 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: core: Enable root_hub's remote wakeup for wakeup
 sources
From: Mingcong Bai <jeffbai@aosc.io>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Huacai Chen <chenhuacai@kernel.org>, Huacai Chen
 <chenhuacai@loongson.cn>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Kexy Biscuit <kexybiscuit@aosc.io>
References: <20250131100630.342995-1-chenhuacai@loongson.cn>
 <2f583e59-5322-4cac-aaaf-02163084c32c@rowland.harvard.edu>
 <CAAhV-H7Dt1bEo8qcwfVfcjTOgXSKW71D19k3+418J6CtV3pVsQ@mail.gmail.com>
 <fbe4a6c4-f8ba-4b5b-b20f-9a2598934c42@rowland.harvard.edu>
 <61fecc0b-d5ac-4fcb-aca7-aa84d8219493@rowland.harvard.edu>
 <2a8d65f4-6832-49c5-9d61-f8c0d0552ed4@aosc.io>
 <06c81c97-7e5f-412b-b6af-04368dd644c9@rowland.harvard.edu>
 <6838de5f-2984-4722-9ee5-c4c62d13911b@aosc.io>
 <6363c5ba-c576-42a8-8a09-31d55768618c@rowland.harvard.edu>
 <9f363d74-24ce-43fe-b0e3-7aef5000abb3@aosc.io>
 <425bf21b-8aa6-4de0-bbe4-c815b9df51a7@rowland.harvard.edu>
 <0ca08039-73fb-4c4b-ad10-15be8129d1b7@aosc.io>
 <5b4349c8-26ae-4c95-8e60-9cccbb1befe6@aosc.io>
 <6c9b295c-3199-4660-b162-188a9ab5a829@aosc.io>
Content-Language: en-US
In-Reply-To: <6c9b295c-3199-4660-b162-188a9ab5a829@aosc.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E11F2400F0
X-Rspamd-Server: nf2.mymailcheap.com
X-Spamd-Result: default: False [-0.10 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Alan,

在 2025/2/9 18:22, Mingcong Bai 写道:
> Hi again,
> 
> Oops. I missed the dmesg.
> 

<snip>

Gentle ping as it has been almost a month since our last correspondence. 
Can you please advise if you would need any further information and, 
since the fix is probably incorrect, if you have any suggestions as to 
how we could move forward with a better fix or platform-specific quirk?

Best Regards,
Mingcong Bai

