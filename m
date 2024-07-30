Return-Path: <stable+bounces-64655-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E4D941F44
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 20:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EE8BB2331C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C22218B468;
	Tue, 30 Jul 2024 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="APW6lWv1"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5701633999;
	Tue, 30 Jul 2024 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363083; cv=none; b=BJ8UeWIpCdhYmzGV8PtEkWKViuqBJZpSbXKN5VHduVlEnhQ+foWeFzaUHpJd92sDhjBr5vLe5y27QvYWePyOZNvPz6jEpmGayJOBXGZQ0IIeAUKlY9QqkH1lM0SgvCHtNT1RhpOl2CeWQsyTGTDq6pFaMi106Rk1JtItt5iT3gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363083; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=beBMxWCmZx4hBkmgwX16GSmioZ37xbPflMN+W4r+mAADDemm07tdCcH6ttD0yckPzYDajqKevXyfk8JJgqzCakZAs80Y6tlD3SitfThIyTswnQ/xoL2SgmkBdktQg6nU2+3ihzPTyy2qrKToUA43YDnOPii1YuEbu4wuuxUbWUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=APW6lWv1; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1722363078; x=1722967878; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=APW6lWv1hF42t1uEvjsfHRXabtU+xmqZKN+zUuLIqMk4JCWgH5b45nGzbIM2/6Il
	 fPNwJVmvmi2c7ksoRriQoaCThvn605b0T8CI5T13bfv4UghntytoejFnsmm68x6Lx
	 HegkvzsIDC6mgKyg8u8ITKbZ0HsB2Y/J7M9TYFvS/FjaI5GLHqu+8bQRlC2bzdYVp
	 a1q6dNkJvp/Y5agTeP2F/05BS2qQ9dMcd+rZAQQkmy7Y7OLh50SnM5aqq+9MU6FpJ
	 8iF/OKEtvSpzS42jXzM9UCXdU74OStE+8iMc1gH0xKsB6l62yUCrLh/Wpq/MiraPa
	 ShWKoJVHAeSTatsEdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.146]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mq2jC-1rvvwS2ER0-00epPT; Tue, 30
 Jul 2024 20:11:18 +0200
Message-ID: <4cdf3590-fc0c-4fdb-82c9-af78d0edad07@gmx.de>
Date: Tue, 30 Jul 2024 20:11:18 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:JK9B28lhaCYhSqJNEdc/1knRCirXwlFC48PXqIYe9A451pRaz6h
 kue5dm+2Bjt1/qi6vOX1+shQOb5y+UwUVKlaPVj6UUs3/TwNqaDXo1yb9S0PijUO9vmtII9
 JMItH13tNfuCNY5OTjyXSbiD+ceXLeFgBh5i9IW3kgym9EqIKxrUeLMNNehkgfbDX4xT/A7
 kBSIjND9q6L7DYlh2A15w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7Vx4ByjVa80=;d3sBOfKKcPncEdHQ19mKjv1ngKx
 mJaztk2FOI4O6la/wzmz/MTzebw41O+aTHWP5ersHOI2KjXczSIMhpXaGXhx9jRCt6i3Dib7c
 z4nLRWx5P1GK8gC9o8XiKpxdz6XNPC02OF3RkDifap7evX/jacfeqmX8+MUZSviJhXP9CmAXu
 envpwPNhvd5pCWM9u08wHaSfTQIrMigree7BybRX/nILycqgOp6Uw6EDfUqI4bdBtSWSR4l1k
 vGo3sedxDZl5iGeMBgPF+TtjZ7nlYerQWHl8i0xnqkvOtnuPwjg3d7HYAMdHdoS/gIZF85t4Q
 no83nBjng1Pdn7nvn4/DHmmDz7QWSgAwPOMCbKIEMHvPBWsSqEtjq9X2pfyxU7LHrdq4fjpAw
 Dknt+m/xBSQWTaFEEVTQsYa8NAEdr8o9fN+eKQfpw0+Y5I8A/S5WCyjv1RWk3v3HOCp3CXV2j
 JC1Rf0Z0E7j+nOalIWjOorkcRwAwHJq/dmPKxAcd62tzm83rR33F+7qS2LfQQh2N5uSuxkWhI
 x6zk4Ypj5f7cwVETc9N57bCBPm5G3cGV30AW+rIp8FwG78IZYlkbyUqENBOCVJej+PoHGCEXy
 2kJqh9Q3rqCDJq5BfZTFFukvotCvdaPJDbqZoxOJ98UcbFhxrZUTVU6Vf1U+Ow9h3mzY66U/W
 tYiJAM4YjDWKOKv1YKOMIFWgSZ6mRg/NhM9qUAHHLiqHsRG2zcUMlw+KldDjPsDQudmEvUdks
 smBzYAHGuxYuAEUHfmH/r4mJFO54fr8tMrpLsw/IJOiVB8i0oS0EZSsjit19JRa508DImQJBA
 3JgA8+rRIAzMyuLLmPfylEkQ==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

