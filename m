Return-Path: <stable+bounces-127492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 691A5A79E7B
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 10:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80851896AD0
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 08:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A669240604;
	Thu,  3 Apr 2025 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="T0YmZK2/"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A894A13A244;
	Thu,  3 Apr 2025 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743670251; cv=none; b=EjithZlaWR99TtOwgLV8BbXhVsSK7yP3Sk1B1yeNtFudeUdFZxv51m80EJrNBCMmypys7VXLYSGMxAYT2Aved4qUHIxDOgiY47Vx01AS81MMet577FcTVcpE7McCY3QHW8E2UNWr493Sha4I9miLJbf4izq9OfKGy544dWW8WUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743670251; c=relaxed/simple;
	bh=hsm1NzR4usjbx6eO/EwG40atDxqPYD52GuN4cBVAfg0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=TLIigdMpJSvQabasfKIFGv2joYlpOITbxQu4vr6gMSXwyPUqAI74c/+vQgq6B2M/n0lCAfRK15D6Z0zYO+HvJFMq/kY/R1YDcdoYVEsJLt5wyZeDTz0fXOWYl9dNLVu/3LGtfsqdNHkiHl1QIkNjDQnJsjfJgjpBw5CtGuYzJAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=T0YmZK2/; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1743670239; x=1744275039; i=markus.elfring@web.de;
	bh=hsm1NzR4usjbx6eO/EwG40atDxqPYD52GuN4cBVAfg0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=T0YmZK2/pL9+WbMqmOXhvUo7+aEJ9PPrMuag5ZnelfrIFHE0Qne3yt30CZCJfTvV
	 BvoNlcsUkWLUY9B55A9t20il17ol7L3ssLqSY2xaxnuylioYofYXwz2IisKsaZL5f
	 gqhbybaQOHG/hZzZaqgqYHVfwY8PzkpBMtigzn8NkIw0g8ZTvOSKIVaGZHkvEQ4wk
	 zahvddiKFphUty4Ub4vpG1NWTmLCK9fGON7abJnuuuBkxKGN7XeqjFn17KJzf10Xr
	 QIABN0jQGu9QpA95VY3A2npeKxcWQsbk2DHYEYItSXm3vo9Mo2YBcF5RJClyCp3JC
	 jxN2GxFJENsiJXz1Kg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.50]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MsrhK-1t7KB53E2i-012IHI; Thu, 03
 Apr 2025 10:50:39 +0200
Message-ID: <970e78d3-e3bc-4a34-9ba8-40df4823726f@web.de>
Date: Thu, 3 Apr 2025 10:50:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Henry Martin <bsdhenrymartin@gmail.com>, linux-serial@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>,
 Taichi Sugaya <sugaya.taichi@socionext.com>,
 Takao Orito <orito.takao@socionext.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <20250403070339.64990-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH v2] serial: Fix null-ptr-deref in mlb_usio_probe()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250403070339.64990-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IyQRX81AoN2cTzefdi5EWIMxrAugxODoW9dQT5OAekcqd4WPkI9
 uAyGDMmtnVkQ+CGHwwmJEXvyk1lBr9sH1oGVSm3DkpcAv8mxPmgcr4mo6NhNv6gei7+AoeW
 xf1Dqy8Yn5/hldCS48DlmFr1Rd9cEUIquUONktOrroU/YUmPyDIskNzGnifPQyXEpY/h86q
 VZ5MxN/WcRGJS6JK/VPUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qn9RJRcmBMM=;K0Ku9YlURmKXZNnats0w/CadTYA
 vKAGlXpX1XsvOST4O8RjRWBFf7l42TmbhCD2myyNEdyPcu+IKJmWXKZzH89b8KSZqHofU76Bl
 b9kEYPKXRuS55dusEtsbExqAgjmKyKFFQyME3lkKyAGME7SBX1jWfNC08HerO6YoAG5W+Xyor
 5/4stNSZo8QqyvvvCII8J+l8EQu72vFSfXguWNis0Q3R3Udl+9efliVaX0APrg3tPt3pidno1
 NBymGxEIT0AZOPDFiiVI5zynCmbacGqGE52Zi5N0iyvsd+p55+ku4U+m/CIx19MBz0p5ue3Of
 DQYUAmxxmEflrziNvYOz0TgUjqb7ylTxVGhwKsgxsLPY15eXu9ePxtl7NX3iHmeipbODQnCcI
 CLS66Sk3Hw8FpiAQIlbRvJmhyDLGsXo9vGFDHOFTZJ9kvOxRn+AjFEFsYWMX8fxBBN8nW1qOU
 /G3fyZN5R8nY+f1cEavSGNjnwxACgQ9IJg4YD3YYp0o6GeSCDhf0P97CnvplTTef9jkvvNIN/
 A1S+4Z0QDbESwgpO2HZi1OEeyXchBqCvSNbxKVCXZ4pqUeD5Q9WFOlRLZ1f9tTaD87Q5jllhf
 /TwByyImGs/BuibAOIJ5X5faqPvXFnvZxtmYLbugWms/YKkATL4NkAKYCqokV041dEE/fiTqw
 H1gQeSzCDBKtWs8Z8HCPvea7INzFwlLcI+u7rCEeiYorbauHa6eg6EbzLJIZLd5UXS2vOwdYm
 q/rp1txbM28XyJHEPG92V/mRa+rTaI9D05UbGN5N9kwgJtLxBBqR9i5IEegy9yrlU8tyzKPhR
 u7qv24hZmRGBm/0jf9tNBfEPYHuCF/OQpBjFti6Rgcpf5YWadnlzpzm+bBXvc4+uB2F++7UOj
 pTxu6CD3Unk1HVQJOYNzwr1oZ2G15ETzb2i1S6WTUz64vtowBKeRvv49SDpIPs9aP3M2Mxy4U
 LzWYhJymlXcRQ2je8KkQNvW0c7lx0OrZxgfJXPL10vEiuvtdqTwltKiWVvukv+xyKF3NdNS6h
 BbLrLsMTxIXPK6+K8SHrghcJ2ldOsblE78WeapCxCuHkOpttvdcoxIlWiCFt/IMvEYxPbNzSh
 /Gdo5fQVJYlgjylzFDZa61FYz06FYMFx9Q8nzLKMpYtZCqFjsgicnFWe/gnEkfcSzOXI/XkI2
 5KKffcAIbr0s6tkmgSEb7ELob4e5i0VbSeuTNgAz7MXo5hqX6zVEDBqoVXa4rv6V1jUmAwOPi
 c6nLKaHUuUQdvWTpW4vGTg3138UdRpmrURH9ZTlI1FgNKtAkTzy/7er3iyLLwh97iGmbVtztC
 Bc3HBfoFrKAztJHjMb1OcB50nQfuiKh797bizMkjKbj7QSBgPRdbgb/asOaEUAAU0jeNqVx0+
 EwIcbe3MbnXjP9MMF9wHPqPl7CDYbdwbmn0weMDKMC5dSRKFGN5ecwMFXOImgJKbewHEKiPFg
 5hYkRr7q/Driejx95rYgls4EpIyCgnJ5dNFuxWUbqFaTisuoq

=E2=80=A6
> Add NULL check after devm_ioremap() to prevent this issue.

Can a summary phrase like =E2=80=9CPrevent null pointer dereference in mlb=
_usio_probe()=E2=80=9D
be a bit nicer?

Regards,
Markus

