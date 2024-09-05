Return-Path: <stable+bounces-73675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A546696E4E8
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 23:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C011F24674
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 21:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E38C1A7266;
	Thu,  5 Sep 2024 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Ms+EitTl"
X-Original-To: stable@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4931A01AD;
	Thu,  5 Sep 2024 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571103; cv=none; b=TxkrRK7rt/xe+ySfOrJHZIEsg9HXqrWboP0tNW9wQ9GZWzJ83DFRaXyrvaGOcrNcSRnz4dBbHu7Pj641Msw2ydPWzFFcVzQIZH7gbvC3HLWy5tXvze9pRTaDs/rojGUW/Bnlph0mdCouXXzQX18/KiK58Xj4IWa8qlAVjekuxJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571103; c=relaxed/simple;
	bh=gimzTn0lOkjIZNa6LhGj/LhMDv/+anMetyTxiDuoBR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BqXX3YKFmlsra3Q+j++OHf3mkqATNlfV/SNAuY8xW/pRKWbzNsu4fUryQ9WNunrcmQouu7hF1aqsuGPSA+bghOtzwbIAkcFDNrPHiwoJ7wSdkj0TY6qyJ8PhuRDZNa6G24qXrthcmtgA9VWNMvFKYgwL9lLOvLexiPW3AANWHlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Ms+EitTl; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4X0Bzd3VhTzlgMVN;
	Thu,  5 Sep 2024 21:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1725571098; x=1728163099; bh=gimzTn0lOkjIZNa6LhGj/LhM
	Dv/+anMetyTxiDuoBR0=; b=Ms+EitTlCsexET5K/0xcfYU5lJBGu7lggNjpn3s0
	cp6dmvzXfpJMGA88l5Kl73ZpkcSK4nGsrPJpqKh2F2IsUNWI6bAPQgiIcRWZEj2O
	X21XAHKFS81L5eL93Qt6+gg601+Pdkl8Dq9fjFiE3usFwTJ/VK5OeJK/Ervlz6dn
	yI33zhUaZlOfVaFaptPSYyTol9UXaOkntMvq3dXzxZxPreE1Rf1Gss/3XX9+wnuY
	QERSdsufrc5ux1WdDQ6suHdHcmdGhdZpruyadHnz2LB0OOEmOBuJV4RPfgVBzRT5
	xvafqbbea20VPKV2+pZFPRgQog5rzq0Ps8lTIv8Ms/W78g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vzrvC57KNhFg; Thu,  5 Sep 2024 21:18:18 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4X0BzY1q5jzlgMVL;
	Thu,  5 Sep 2024 21:18:16 +0000 (UTC)
Message-ID: <d7536bf7-a11e-4c1a-97ec-f53e2f8ace74@acm.org>
Date: Thu, 5 Sep 2024 14:18:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] usb: roles: Fix a false positive recursive locking
 complaint
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Amit Sunil Dhamne <amitsd@google.com>, Hans de Goede <hdegoede@redhat.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Badhri Jagan Sridharan <badhri@google.com>, stable@vger.kernel.org
References: <20240905204709.556577-1-bvanassche@acm.org>
 <20240905204709.556577-4-bvanassche@acm.org>
 <CAHp75Vc61fJSUJtYbMKhWE4tCv-qHRTyFT_PrK0x6Y7zB3dYNg@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAHp75Vc61fJSUJtYbMKhWE4tCv-qHRTyFT_PrK0x6Y7zB3dYNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 9/5/24 1:54 PM, Andy Shevchenko wrote:
> On Thu, Sep 5, 2024 at 11:47=E2=80=AFPM Bart Van Assche <bvanassche@acm=
.org> wrote:
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Badhri Jagan Sridharan <badhri@google.com>
>> Cc: stable@vger.kernel.org
>=20
> If you put these Cc:s after --- line it will reduce the commit message
> while having the same effect (assuming use of `git send-email`).
> lore.kernel.org archive will keep it.
>=20
>> Fixes: fde0aa6c175a ("usb: common: Small class for USB role switches")
>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>=20
> Co-developed-by ?

Thanks for the quick follow-up. I will make these changes if I have to
repost this patch series.

Thanks,

Bart.

