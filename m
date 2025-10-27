Return-Path: <stable+bounces-190030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4115C0F021
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3FA3BF445
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6507D30C626;
	Mon, 27 Oct 2025 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5zBToHb"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E88822D4C3
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761579299; cv=none; b=kjF+hzHc3lmNPh/3xJsgZJI70DClDSwVdqmeBQsgheb7cXEDtIwVSxonlJ+GC7S59fKHK1/0vMEQeVUq5nhkFJ9VUPYkxE4vcZjzWzDgTgZtNfEcSnwa/N6nyyprukU5FBfMb3/fdfNK80UfjIvIRjSq099xRhDP/zhrPxShJWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761579299; c=relaxed/simple;
	bh=npqMQNG+kkSJMj44DV9b43q2YLq0woSQU+hbY1FcfDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCxhZMHLld5uJ+u9JXzNyFil0gZJSGDGk+FFen7MnRkBVgHRnXsOXW85CjdbSFJmE9u7e+clSXDRkAupUpimD7zxPJ1aLUoYfA4mXszdoCdbzYJeYPzT9uKM+fAMIeV44DKle+Eh0SmETDQsSDskIMUuu5eZ9rrCHgaPj0h6OsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5zBToHb; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b403bb7843eso1057236766b.3
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 08:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761579296; x=1762184096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gPnVe0RYSSxW7eGWUnBIAZE7h+8589Z4nUqKP2rDTXA=;
        b=V5zBToHbUc/EPblZEnyEAuMXFv8OZDgHuYk6ojh/B76r+shKrC04Iu7L05OqKb3eOn
         ZwYlOGW49fNJl0unr++t3OXQf1xbZfiJ0j7t8pPHn1JhfJ/eoAECiuTfgP0lub0x4caD
         M1honsWVJ72V1PC1+gKu5ozD6O3tMl9btTejeONVlG0m0cY6B4gALkOOikEot60WZiYz
         2OaM9zZC+gErJ1THLVxJ1Obcjhivxyp97t/fga7mPmJ6Vor8Ulo/kIUmrJDPBx0B3l0/
         kZYMzO+iB8XvFBdot5UxEMigsMpWpTJrymF8MiBylQZy+LY5F1iwrIb4GB6LVPK+DxOw
         cAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761579296; x=1762184096;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gPnVe0RYSSxW7eGWUnBIAZE7h+8589Z4nUqKP2rDTXA=;
        b=bwFDXqN6KbXCLS4AVINb1acEuWopXEXnvzUzJPk8JR2++v25AJd+fVOekyLWcCvrpF
         yHqf38a4mmshMAd6jNhl7ougP/7C7hZDYcg9Uc/sqlw7HYZD8AhKyrYn00VTlarREDUW
         RnjbFxy94Sus5Cvs+WfcmBr6TfcGHCe06GJcXpSzyTroCcVHV6DpV/WX1yc6NNLyYWRs
         xRfjJdtuxwwfmjZ0B6sAAyIEZaZGmE3UdaHaaArXxWvkTbqCfTOtogPCpThzz5BaI2Xz
         RJirqPugNK2aJgJKSjlkeveRZJxa77CP04lPSbL6gSJB7dBOmILGSvGKNccP8ak3T1Zu
         Ys+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXuEyKDfyWZCpGHRg1ugBn0YIoB8MulnmQXDMGvO2u/0IWsYSuCK9WyUlNGsLERtMFcyrXxU7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdQ25u70A2htE4WXzyYSAHQVLAaEw7dSv+62nStPca3lHhpdOT
	xk0mrm1YY16G7I2Dq5RBc9hgaeNyIaM/aGMC76bw2tJPyS4R/SiY8+cT
X-Gm-Gg: ASbGncsyt4/T4hFYS901mnMBxit/hI3JKSm/qZOYBM7hpr5xPWBV036f5iVZWdi5O0V
	fiqbTPpAC9P8BAg+ZKjOKxczmz8O9QfTH6GzPgGjXhQ0iTyDffr4B54EBrGziNW+ykV6Jdk+CTS
	FA101FAf9J1yyiomPk56NsodGPRLJYz3vRhF3Nlw2LqiS3EU2kssCK7ZeWaOUGU41EQOWqNn+04
	5QBiXyZzdQbL55TrKufK+6jGnttGRrgUIWZM3d4lMHrzaNl83g8a6omt1G9V1JhUMULh6zxK9j3
	HvvVXbQ+AAaH4XjqBKN8jJtYN9kxDoHA23HVDWX5oFy0FWUd5WwSTuIoyNN9WId6E3155E4rE+D
	QQ+CDy6p3Ag+gf5pATN7O1aW/stkwFvm4oco8UbwRT6OzmXMIQ2nx/OdBMwLmw3M76bMnBPBQME
	GsCQbk7p+xdyyT5MayqBr27K4r4wkFJbgUji/Ur/JMuWTE2Cw1VOzowrqpyS1+QuGYk/st
X-Google-Smtp-Source: AGHT+IGIpwg05cYy7GcfgDxvaJSzOwaLJWS181MgeK2o+O5O1IAwUMBmynB9pTF9eZUsL20El/MxCw==
X-Received: by 2002:a17:907:96ab:b0:b04:aadd:b8d7 with SMTP id a640c23a62f3a-b6dba4460f5mr33178366b.13.1761579295540;
        Mon, 27 Oct 2025 08:34:55 -0700 (PDT)
Received: from [10.0.1.60] (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85308cbbsm809169366b.4.2025.10.27.08.34.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 08:34:55 -0700 (PDT)
Message-ID: <f65c1650-22c3-4363-8b7e-00d19bf7af88@gmail.com>
Date: Mon, 27 Oct 2025 16:34:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net: phy: dp83867: Disable EEE support as not
 implemented
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251023144857.529566-1-ghidoliemanuele@gmail.com>
 <ae723e7c-f876-45ef-bc41-3b39dc1dc76b@lunn.ch>
 <664ef58b-d7e6-4f08-b88f-e7c2cf08c83c@gmail.com>
 <aP-Hgo5mf7BQyee_@shell.armlinux.org.uk>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <aP-Hgo5mf7BQyee_@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27/10/2025 15:53, Russell King (Oracle) wrote:
> On Mon, Oct 27, 2025 at 01:57:48PM +0100, Emanuele Ghidoli wrote:
>>
>>
>> On 27/10/2025 00:45, Andrew Lunn wrote:
>>>> Since the introduction of phylink-managed EEE support in the stmmac driver,
>>>> EEE is now enabled by default, leading to issues on systems using the
>>>> DP83867 PHY.
>>>
>>> Did you do a bisect to prove this?
>> Yes, I have done a bisect and the commit that introduced the behavior on our
>> board is 4218647d4556 ("net: stmmac: convert to phylink managed EEE support").
>>
>>>
>>>> Fixes: 2a10154abcb7 ("net: phy: dp83867: Add TI dp83867 phy")
>>>
>>> What has this Fixes: tag got to do with phylink?
>> I think that the phylink commit is just enabling by default the EEE support,
>> and my commit is not really fixing that. It is why I didn't put a Fixes: tag
>> pointing to that.
>>
>> I’ve tried to trace the behavior, but it’s quite complex. From my testing, I
>> can summarize the situation as follows:
>>
>> - ethtool, after that patch, returns:
>> ethtool --show-eee end0
>> EEE settings for end0:
>>         EEE status: enabled - active
>>         Tx LPI: 1000000 (us)
>>         Supported EEE link modes:  100baseT/Full
>>                                    1000baseT/Full
>>         Advertised EEE link modes:  100baseT/Full
>>                                     1000baseT/Full
>>         Link partner advertised EEE link modes:  100baseT/Full
>>                                                  1000baseT/Full
>> - before that patch returns, after boot:
>> EEE settings for end0:
>>         EEE status: disabled
>>         Tx LPI: disabled
>>         Supported EEE link modes:  100baseT/Full
>>                                    1000baseT/Full
>>         Advertised EEE link modes:  Not reported
>>         Link partner advertised EEE link modes:  100baseT/Full
>>                                                  1000baseT/Full
> 
> Oh damn. I see why now:
> 
>         /* Some DT bindings do not set-up the PHY handle. Let's try to
>          * manually parse it
>          */
>         if (!phy_fwnode || IS_ERR(phy_fwnode)) {
>                 int addr = priv->plat->phy_addr;
> 		...
>                 if (priv->dma_cap.eee)
>                         phy_support_eee(phydev);
> 
>                 ret = phylink_connect_phy(priv->phylink, phydev);
>         } else {
>                 fwnode_handle_put(phy_fwnode);
>                 ret = phylink_fwnode_phy_connect(priv->phylink, fwnode, 0);
>         }
> 
> The driver only considers calling phy_support_eee() when DT fails to
> describe the PHY (because in the other path, it doesn't have access to
> the struct phy_device to make this call.)
> 
> My commit makes it apply even to DT described PHYs, so now (as has been
> shown when you enable EEE manually) it's uncovering latent problems.
> 
> So now we understand why the change has occurred - this is important.
Good. Thanks.> Now the question becomes, what to do about it.
> 
> For your issue, given that we have statements from TI that indicate
> none of their gigabit PHYs support EEE, we really should not be
> reporting to userspace that there is any EEE support. Therefore,
> "Supported EEE link modes" should be completely empty.
> 
> I think I understand why we're getting EEE modes supported. In the
> DP83867 manual, it states for the DEVAD field of the C45 indirect
> access registers:
> 
> "Device Address: In general, these bits [4:0] are the device address
> DEVAD that directs any accesses of ADDAR register (0x000E) to the
> appropriate MMD. Specifically, the DP83867 uses the vendor specific
> DEVAD [4:0] = 11111 for accesses. All accesses through registers
> REGCR and ADDAR can use this DEVAD. Transactions with other
> DEVAD are ignored."
> 
> Specifically, that last sentence, and the use of "ignored". If this
> means the PHY does not drive the MDIO data line when registers are
> read, they will return 0xffff, which is actually against the IEEE
> requirements for C45 registers (unimplemented C45 registers are
> supposed to be zero.)
> 
> So, this needs to be tested - please modify phylib's
> genphy_c45_read_eee_cap1() to print the value read from the register.
> 
> If it is 0xffff, that confirms that theory.
It’s not 0xffff; I verified that the value read is:
TI DP83867 stmmac-0:02: Reading EEE capabilities from MDIO_PCS_EEE_ABLE: 0x0006

This indicates that EEE is reported as supported, according to:
#define MDIO_AN_EEE_ADV_100TX	0x0002	/* Advertise 100TX EEE cap */
#define MDIO_AN_EEE_ADV_1000T	0x0004	/* Advertise 1000T EEE cap */

So the PHY simply reports the capability as present.

I verified this behaviour before submitting the patch, which is why I wrote:
"While the DP83867 PHYs report EEE capability through their feature registers."

Anyway, if the value were 0xffff, the code already handles it as not supported.

Let me know if I should test anything else.


