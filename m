Return-Path: <stable+bounces-179818-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B82EBB7DF3A
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37BD34E2955
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 10:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C31353344;
	Wed, 17 Sep 2025 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HTt4Nrr4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0109634F492
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103854; cv=none; b=AYCCUbbKvI/PaQa7cu5WRVkOiWVtNtqLhmnZ6oZUGugTlFDZwHKlExLN5Yo8Tu6hX2oMtUD3V704H6vVaAsxE0IxT73+WM5SMsu9EbiUHIQIyjbGK2NH5jRpmgU6TCjFcC/RIMF4S0626H4ItwD7fSV6pvtqF/Gv+vyak3bjpUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103854; c=relaxed/simple;
	bh=ZZVPr8zwc3jcO0OuCGyJfEYik/KPMCAqckFIByRhOZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ls4BEwpmWZvqzJg1rLvDu13IFlq7t63d3caEX+WDO7JlpJCWnqL3wFQWQBXGYsH2PZC5adE98Akvs3ReHl6FYEwNRrjjQY6Sjh3nargNFEKOkSxzLeNp6U7CAVuLFKeX1AlH0Ppl60uy+XNYXub0254vfDqrJIH8kAcN2sE33WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HTt4Nrr4; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b07dac96d1eso114026566b.1
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 03:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758103850; x=1758708650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfhBOmsmCdqnUMz/+8Ss3Stx4dtkUPFOWgiDwJ5M/m8=;
        b=HTt4Nrr42awsw/sWUUmkJaZXN/VLbWtlFTAMScXNR3O99EntNwP3wnXVCsMrz6cEK5
         5LWmcm07ExLRuQMwYcEOZJ+KFyBT/C0vw604BF0B1kN/TACYXQVfJ5c/tvolRvdtZfg2
         iiRH5JEZ6+CP33Qr7uYEVTIX9K/WJm82bG5+PkHJotTgUfMvptfkI2ANdD2XVbyv6B/E
         fzWXURrSyJSIIM0nmTHvg4h2ci6fw4x6aJRnxiRXGqEsOFxxHsjVbz+eaPrIGg+wc6Uu
         Lj2yDsNSVm0CEzUYaYFwI/tj8EPCGUMvvvlISA1CVvsQ/o3oOn02SSrnxf9igWnyyWUD
         MOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103850; x=1758708650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gfhBOmsmCdqnUMz/+8Ss3Stx4dtkUPFOWgiDwJ5M/m8=;
        b=rg5j1tpwuDYXb0yTj2UsaBW80jyxVTzdhmOH/xy/ch8tOzXlUvYhmFYgvVEPf+q/AJ
         stjeX3wiQDU/7AX+F8uRA+JZkBiv8VeQvv5OVVZiRpDDAMNWs87W4kMqSHmQihkVmyB4
         8x0Lh9pVlgRRNOh0RtAXn61+mye5mDDjqhWInIPMlBhZYbLlLFV4QbbAeAAaWocdL/Iu
         qgz1gx7HKLQQ7+26UfAWGZRrfpXWexaZ9hDqeTScGNq4vAYwgxqMhGayrRxmf+jg0YYw
         o7uEx51XFgdFpEpseLV8+mPRp1d+ucttBnmAFsoic3J1R82vrMbRvlkRyFcS86JC9itQ
         IUrA==
X-Forwarded-Encrypted: i=1; AJvYcCUQQRR6pcpMR816RBuXCILr2mJZQxfIvpoZkSiQZe+GNlNNp+xrzyYB5CfxJC/oeLLljcyBLlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ7xIWeUdLBXfa2aYthJM6wu9haXDxi4l0NwruxhoOybxBgLIj
	DiTgGkUZSgq32a9nkOBICZeX9ESOwIaYL6SwqG3276KfazaWiOU3tljetmelngJqRTE=
X-Gm-Gg: ASbGnct5YqFZ6VOh005sL+jTtMlE04tQMV2af7885ed+QFvR+yvsfZ+typAWY4YtPkD
	X3KlQprYIsyk5HtE5leuMSlrFDhm+9TE9DMt3CIbOlG4/VP+jhay5I+sDbntIEBwTUJ3WgnDWPK
	TIfT4y/vsnVBVfpDXXNQLVhzGoV02yTBkSLI3vWCtLWFocLjVicfsXN++rTxpT1RtbjKGL0vWsJ
	QFWjJyK9zbBLVyRMwAfvTFSjKJoXLDl/j+Yz9AoT/BT6PystYXDO9m4eZODFYhIfs7S0Z3VmEKb
	uBIcxi5wsyemas51fsjuqrMckjqL7Veg7rbfGjsCxHfg7FSVTwFpc8uEv6mGDq7jNSACoi1WyHf
	llnd5iWzJaTpWLgy+MZ6x4+JPDJI7eq7/3DbsuDepMK3gK7VF46rkUZ5QXsrA4gOt
X-Google-Smtp-Source: AGHT+IEffrTIn04hCkbbCjr83BNBKSLUY7sk2TJEFlqvq5wVXFDKpBzk6i+bXHi14sqiagolHGQ+ug==
X-Received: by 2002:a17:906:c106:b0:b07:c66d:798b with SMTP id a640c23a62f3a-b1be49e1b5dmr185057166b.11.1758103850321;
        Wed, 17 Sep 2025 03:10:50 -0700 (PDT)
Received: from ?IPV6:2001:a61:133d:ff01:f29d:4e4:f043:caa2? ([2001:a61:133d:ff01:f29d:4e4:f043:caa2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07d2870da1sm1004985666b.13.2025.09.17.03.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 03:10:50 -0700 (PDT)
Message-ID: <0f2fe17b-89bb-4464-890d-0b73ed1cf117@suse.com>
Date: Wed, 17 Sep 2025 12:10:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/1] net: usb: asix: forbid runtime PM to avoid
 PM/MDIO + RTNL deadlock
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?Q?Hubert_Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>, Russell King <linux@armlinux.org.uk>,
 Xu Yang <xu.yang_2@nxp.com>, linux-usb@vger.kernel.org
References: <20250917095457.2103318-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250917095457.2103318-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 17.09.25 11:54, Oleksij Rempel wrote:

> With autosuspend active, resume paths may require calling phylink/phylib
> (caller must hold RTNL) and doing MDIO I/O. Taking RTNL from a USB PM
> resume can deadlock (RTNL may already be held), and MDIO can attempt a
> runtime-wake while the USB PM lock is held. Given the lack of benefit
> and poor test coverage (autosuspend is usually disabled by default in
> distros), forbid runtime PM here to avoid these hazards.

This reasoning depends on netif_running() returning false during system resume.
Is that guaranteed?

	Regards
		Oliver


