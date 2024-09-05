Return-Path: <stable+bounces-73656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFE396E1ED
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 20:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 898301F26A93
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 18:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A94317BEB7;
	Thu,  5 Sep 2024 18:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="bKVw90Yi"
X-Original-To: stable@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FBE17BA7;
	Thu,  5 Sep 2024 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725560584; cv=none; b=eDhjmCeitzcE8lJ/mrJYE1eaWE6wfxJkMwRA+FQDMoT0NtyNqG+NCpHNU/B1PK7ro0nVhd+36pfE/KFa8QWYuq01gadz5r7F19Rd8ail2MhaVmBRlVzKkq8+yZG0mb0i8431cIsPKT4hNol/vKH3dw73clwt3SKjsVOI2EbmV8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725560584; c=relaxed/simple;
	bh=/OFq2WRdIwpWrJVTQEKo/lCUMR7GDyPPe7B3l5o/UpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vo3V8SoYBn1pK4cGG+s4e82JKkOxciDHiGo7l+x3QpXj7Ti2ltUVlO1UYI4t7PsAsTcEoxD0TfodyLY7ZzKVgGSmHUfMHQ7NclFtklfIk5A4eIFgRkO41qhvs+ak9R0l4AnbiNGJ2vs6KMDt5ye8cWJreXh8/h6eyw7O9eYeYnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=bKVw90Yi; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4X075L6gbZzlgMVN;
	Thu,  5 Sep 2024 18:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1725560580; x=1728152581; bh=AzsneNIKyYbesR6Zk4PMDJNg
	3KUahAQqOkpm9HjhbJs=; b=bKVw90YimpC22hpsjAQdibOuvLnOpqHo3kM2OGs/
	O7stdZDMM47RHhMFokM9yhdRKNsDKONzDEaXLrU+8Q2tARUwyN1StiGvqS15Qylj
	X95hSjiUNmc1YcONjfee+EN4TPPz/El4imxkWhwQqlcteLB+s/WK+mMTxAuJsfDi
	ffNSCQBOzWbbxK992xeRI0B0sMTeMTzMY9q6ET9EYsC+o74glgCiiUucQScnz+YW
	WRxGt5JqO6SC/EZiPpfh1LsfZdAldqny3h75hrZKdOzEn2/dn40fwjGvOjuxdPbu
	bqjUQBiVKlpJx9dwybrEwBdioWhpWUHesI5R9bJKpkdd4w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id N6nfXQJkDRVI; Thu,  5 Sep 2024 18:23:00 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4X075H6dS3zlgVnF;
	Thu,  5 Sep 2024 18:22:59 +0000 (UTC)
Message-ID: <b439473b-a312-436a-9a3c-05d3eab3e1e3@acm.org>
Date: Thu, 5 Sep 2024 11:22:59 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: roles: Fix a false positive recursive locking
 complaint
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Amit Sunil Dhamne <amitsd@google.com>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, stable@vger.kernel.org
References: <20240904201839.2901330-1-bvanassche@acm.org>
 <CAPTae5+gX8TW2xtN2-7yDt3C-2AmMB=jSwKsRtqPxftOf-A9hQ@mail.gmail.com>
 <8feac105-fa35-4c35-bbac-5d0265761c2d@acm.org>
 <d50e3406-1379-4eff-a8c1-9cae89659e3b@google.com>
 <bcfc0db2-d183-4e7b-b9fd-50d370cc0e9b@acm.org>
 <CAHp75VeA6N_jmkz0-asjogYx4ig8Q=zxnNM7C4m5FV94pH-nCg@mail.gmail.com>
 <CAHp75Ve4qfvBDgDHnjDbRW5buXnhGSp1aOQ6avOLGYnBY8UggQ@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAHp75Ve4qfvBDgDHnjDbRW5buXnhGSp1aOQ6avOLGYnBY8UggQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/24 11:14 AM, Andy Shevchenko wrote:
> To be clear, something like
> 
> #define mutex_init_with_lockdep(...)
> do {
>    ...
>    __mutex_init();
> } while (0)
> 
> in the mutex.h.

How about using the name "mutex_init_with_key()" since the name
"lockdep" refers to the lock dependency infrastructure and the
additional argument will have type struct lock_class_key *?

Amit, do you want me to add your Signed-off-by to my patch since
your patch was posted first on the linux-usb mailing list?

Thanks,

Bart.


