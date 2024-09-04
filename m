Return-Path: <stable+bounces-73101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 479AB96C848
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 22:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CC98B210D0
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 20:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F87413D532;
	Wed,  4 Sep 2024 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="tV+X64Df"
X-Original-To: stable@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94C31386A7
	for <stable@vger.kernel.org>; Wed,  4 Sep 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725481231; cv=none; b=smhbS8H1mF9vJoDsQ6D94DKxpIXVpGF2umfnEyUc6PsNG02oCdwgPQYKV35YDBv4wCfPuaUClFsBMEHmRT29d5AVI91wTWKNOKVPejll+m8i7iW+LdwHBoox8fsxXDZtD6IuOsSLF9bliFnfHfAjkTc+arZgiWcKut8b6INWNc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725481231; c=relaxed/simple;
	bh=IoQ1BmnxDoXfoHo6T3iQZSXcD1PKsWq+WQDxMIPN8Kc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PbrKHZ7ZSbKtzybfXGiC2M5chUdLWKPYSqvhl2qa4+y2I4TlnFAGXsZQXNeOb7XrW8T689EITk09hyNoozYkEQhROhLiI2REfzacLHjdcl6IWMELlKDv5/jSzEQQdrzvNXupyR7go7cCvyTv+I98LhfQfumCgwlVkA+IBABGheY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=tV+X64Df; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WzYlK39C4z6ClY8q;
	Wed,  4 Sep 2024 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1725481227; x=1728073228; bh=IoQ1BmnxDoXfoHo6T3iQZSXc
	D1PKsWq+WQDxMIPN8Kc=; b=tV+X64Df2b/OMVOc89zbMmFxz5KmBzYTjjWAckEk
	AXUiuZbkBFYbBDh27xB0pvyyDqwK/ladS3pf8YdcQdn1vvGd2Z9C6fsV5izwlKLe
	aSn6r9nzj5HYSKvn1Fwqt8JZtQ9Vbw3Nz9plaMgBnf1dOA4V1ZN6RdoHrvDyEby3
	v2Prwt4faTxp8CzLNRmdLT0vslPUkCqAFh2ijijxLiFQfHOEG+lgGrAa2xGyoA8Y
	GWhr5jiwZgkqRYFxHVgWBACo8yZCzJ1AZH33ZXBdzWa8FqQ9vyXJCn/STBVXDlTR
	vuXj2dL0kIthv/xiBQzlKWiMiWwSNejC/CSyuAJ2kD3nWg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id a9yTrYmVkHWR; Wed,  4 Sep 2024 20:20:27 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WzYlG5960z6CmLxj;
	Wed,  4 Sep 2024 20:20:26 +0000 (UTC)
Message-ID: <0ef2df38-560e-4f6c-8c81-f03a947d3dd4@acm.org>
Date: Wed, 4 Sep 2024 13:20:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: roles: Fix a false positive recursive locking
 complaint
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, stable@vger.kernel.org
References: <20240904201748.2901149-1-bvanassche@acm.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240904201748.2901149-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/24 1:17 PM, Bart Van Assche wrote:
> Suppress the following lockdep complaint: [ ... ]

Please ignore this patch and instead take a look at the one that has
been posted on the linux-usb mailing list.

Thanks,

Bart.


