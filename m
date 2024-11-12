Return-Path: <stable+bounces-92789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 340839C5879
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 14:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA861F2344C
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 13:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FF37080B;
	Tue, 12 Nov 2024 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="RDnp73/4"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BB21BDC3;
	Tue, 12 Nov 2024 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416547; cv=none; b=a9JbSqbTpn7zfM8Ey6s1GeUqZhzMuwBIWj1BFB14EzhjCRgvqKhgs5zyiyI5jrgTvs0TbBoF97lW3oxmFwhn8PzvfCBOVCRHzTX/7/3e2g9j9RnK0p9ZQTKGIqkno1Nkmm8yANVkQ8gRP9TmI64jlYSMzJRXSKOJX4H5upMU8J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416547; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=dC4vk5+jR74PK7NnAcjS+nxNkdf951/wVKLz8reIohaOdCLNiL58mWgs1/3MvbvSpBIW9drlSxPayxF1nae3nDiTIelmu1GRVxXQC4yoy4jmCNtWgmzA+ImEyopoA+Rmgaq0C/VrUCXqW9A61JCdRJjeGqu6KHao61L4P5r8i1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=RDnp73/4; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731416541; x=1732021341; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RDnp73/4Ylpmu6TuqoCMdeinvLaFs+CVplJftxH2bGMJG8VEbdRdM/Vdb6LsJ101
	 o073dXHBk1KGGo8I1reupBl0VlMRWGqPXGG8kChOwjkheU2ZSoD5QOGy9G/0OTzYF
	 5ChQSCfuhmaQl5TVLTYn7o5B68RR105uWeR+g16Dc3xtwPCXvA/UFNuNsEpii47p4
	 H1dmJ0sqUbO5L7Y5k3y7180DQTfqJRYm5l9VagNnTWXgomGtx0yRRWggNSEDWZFAu
	 RZValsEBY04RK3AbSzPhfSBwHv0H+5rtSRdvYBix0bswRbsR1qTLk6h/CPFEprrNH
	 csoX8znnfnqc7Y/JkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([92.116.253.5]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhlKs-1tflQz0mqu-00cdCZ; Tue, 12
 Nov 2024 14:02:21 +0100
Message-ID: <4a97b74f-2890-4b84-a1de-19fc0adfaf29@gmx.de>
Date: Tue, 12 Nov 2024 14:02:19 +0100
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
Subject: Re: [PATCH 6.11 000/184] 6.11.8-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:e/g8KOPxMjoZFSdpk9v9xbQjTeT5w5ZpxntfT7fExW4bFZ7VIL8
 mcHE8sCTMq/bSdhi01LLeOsMh5zQ9TZe506kkf8XMrdOTqLypmfvJUswK3ZsHeuoH1dV266
 83/DIKevV/aUL4n7F0AKZpA5r5uEEAzGlwNSxRs0601wHsxF50w3ao2ooQEQMBKMq+LyBs8
 5obvmI7WR+4XXM8sEuwoQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zi6EiFIXS08=;cbTh7Q64u0X2fOIoJYgnQbl1l17
 C06KhNxEPGEYTfINBoCP7gG12hEkvRaSfRc29prcgHypsdTzALxsLMN3CSkDL20aw0+VxfShP
 jiZzp4W8GV9sWjJi8GRUqXpyviAKLuL1X1qPD+CjBoV79GBzwyw8DuUjOg75pU3h4smPNPqEj
 cnT92BAr9rFahFJ46Pkx54d7DUjYpioMNs8buiguW2eA7HtPIdPeE7T00nmbv/JZ972M0H6Gz
 UbOoP73CTe8NuAn/fLEriUQ4WNwWxzumALvTTQcpW2Owd1Ysqxo8gI0Jp37jPtzxOfcRVkqKr
 LtKjRXxgc3U/XLra2UPx25D8mujtrYL1K/+NTFXhUSB1hrhzYx091VExpTJXGxrVZ1Hen42Ha
 9mnm3JnbekM6odWzV8z37w+zW0ityaGgsdvI8VWRhWnhexznEwm4jzKXdHvDEjyzva+FKWhix
 SrrrJATLLCC5orZf4/CZKeOSaslHNnfKgBgmaIlfrE9L3Vla6XlmP17ErUYiVFI9xqIyMmyE3
 psmMP4S4JvhacXq8G4QONcT6GJkplvWggQdlxXxCXoP6BDUXrrj8wmLQ/VxksYPPG8P7tztu0
 qR05BRW5cSCtZZU1RTquH/jt8b4wL1bPkgbRqqbZaUYKvbJg5gYTNOdEacKWQlEer63lPxrP5
 dbhw4Phhjv7oVMnXU0JgTcGqSSjRTrCOvk+PNqq9C3siUrFt2cErCrirOKutlaYwm6814UtmI
 83S60+NBl6u+WK4fJFRflxbpC/HV4JFl4p1sE+IzyeCeLiUb5kH0EgyoGqIUjMMhY4mZXkUXi
 LFvi3jevJkHyMVB6fJDbYdfg==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

