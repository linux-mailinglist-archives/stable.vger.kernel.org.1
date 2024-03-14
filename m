Return-Path: <stable+bounces-28151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9A087BD1A
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 13:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F302845A9
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 12:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53D45914E;
	Thu, 14 Mar 2024 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="FMesrgHe"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445F4266A7
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710421082; cv=none; b=UuOqPorTLpIBnWE3qTVf8WJJoH46lvzba8L7c38M/9y4KE+lXJzfCRgWct4udVQUcR9mbe34A7J8nziAV9Cnk7J+BoTGe9JYXAAywfuNs3QrQpD3yj8dLbyw5tv3HP3Yc8GdEMEwDNWYjrxYt8+CdlOLYR3JrMR6pi7tbDmhQWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710421082; c=relaxed/simple;
	bh=FZ1cNFBFlSPPoYIArzXQLyxrZdGncIEVSbuyezNCAXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUSW/Mw01AgYhupi+Ecd9B19rX3tY6GFnEFw0BIeR3Pb6iftNMIsohDN88RKhQ1XpaYfEUAStcBIjsKzg5U7ogUsJMgB3xuuzGFDTJKx+Ej8Wvjgf2MJseem4ibKvsgQ0eo0axNb5Jaqh7Dy1g9O0F/8zdQjEnjVtmvScUbjRPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=FMesrgHe; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1710421072; x=1711025872; i=deller@gmx.de;
	bh=odpt+UeAoQp3H+46vofAUF42dmajnUDfArduK5gjvLI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=FMesrgHeOMwe4IOj/OAF3o/te/rO1DTqn2lpsTWdcov+F9p6+8S8ePtA4wXs5Imt
	 4JicPkyhvHiOEHQBb15jZTy62qK1zT9cbwpnn5+KDh7g06e+OS/ifI1Ah6sbdirx+
	 XhTb0ovBjJwAfRXlkaf+vcW2JTzKU0vSr3E+nAbXSQg1m9J+br0me0lNMGnVFgCUM
	 2qkfySFFVU2pZ5/UYpPNZAzWTuWMpfVuKd4wNAaDshS6oCVa17MG8Asa0Ely5TPTV
	 3YSj1WiXAguvLfqv1d7wrYyxYcVDvbI99MmVxdnxU+U+wtU9qz/RJ/VWi2eRBdShW
	 HackVaLPKhbhv6fPdw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7Ka-1rdZve1nEA-00BaXf; Thu, 14
 Mar 2024 13:57:52 +0100
Message-ID: <ed1eda66-8d67-4661-b50f-f2b152928bf3@gmx.de>
Date: Thu, 14 Mar 2024 13:57:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bachefs stable patches [was dddd]
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Helge Deller <deller@kernel.org>
References: <ZfLGOK954IRvQIHE@carbonx1>
 <vubxxvlsgyzzn64ffdvhhdv75d5fal5jh5xew7mf7354cddykz@45w6b2wvdlie>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <vubxxvlsgyzzn64ffdvhhdv75d5fal5jh5xew7mf7354cddykz@45w6b2wvdlie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pHg2QXjuoUlpCdrUZQ+5YLre+8SC49itdaFZBu7CWq3XwuRGsQv
 ZCBdJtD5R7WzzCrwZy/jGTNXz0IkRyufpEgTEpKjrSRRi5qjZBBBocY+6Nlmr/jYSts6eLB
 68zybUVSQxySXi7bDEwaNrY9UU6Nc+XP/sUI4Qbg8vwEj1aIaLEktWe3P0gTROWwBXHnDrp
 YBoNGqtgsscVJbGRTNz0w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:t3RAqJSMjFQ=;4PfwVV9uKW8OjxHFxIvwpItM3/o
 +w3mwaUjRitJ8gEV9TrMv0lBwKAZw/N0xboh5l0EcpT0IRElrcRwMxIOCXf/mk1W1OZEIIOFL
 u8zVyYoi05VOp0clEpgTNdz5kc3NKbwT7vb5X/klGRPpntSrx0bm0VQRSed/QV0WCTlQSvshn
 RnyOn94IoDYfC6fPU/fftPm1jCBvWFKxxnmRX/lTunpDk5akKUtbksXyf4etLh2UKVKsrTJTA
 w9yjBc20cVYZv6Cz71t7PpFhlzCK3zjl/4fQYVhUFW/X+6vBMSDqQk/HSCLqNbIEmzXaVERo+
 S3dmugMGlTx9VsG+MyzXd0lUC2mECb/+lBvMsGVwNUoKsDa1niH9sY9e6RiGxhPUa/1OL/u/k
 +6KN/SbB4xf/mu86Ou8Dg4WhssAOtQxaWuy8vzKtcAVR5Wwk5amyChsVrSkyL1EIZvGrdrieT
 v0qLMqlY4IMHGjtN8NFhfM+Y6bjagQV0tE8c6jL+OX9GMwsb/1GMNqK5sZydFE4EcNYr5O/Be
 C9fMQ9gPcG7vgaCr8dZFk8HtGW+aZNAC4ANOydzMqsjGQPm26mPZDUdwaFxnphzm9tipOKR2V
 2HWUAdob1p15kAFLY9urLHBCesfnZZSd3piaHt2VpeFpANlSXIj9L4RwisRxs6zP8c/ucsy2t
 GYfFcNXhYIdy8Phr7UsrwOVGeOO6Y6OFB7XrO4RtthMawNNbYkxL0qPH2w48blUgFcP4CG9lt
 GJSlN9iFiqvihownob2mzW+GbeZS7mkN9NxZl4wCTdey4Mc9EoQpHaGp3bX16bot7d3WwRvIX
 KhvcALFdT1Lr3vesDSQsdv6yBaMZNQ4UkzixNLyq1/HP4=

(fixed email subject)
On 3/14/24 10:46, Kent Overstreet wrote:
> On Thu, Mar 14, 2024 at 10:41:12AM +0100, Helge Deller wrote:
>> Dear Greg & stable team,
>>
>> could you please queue up the patch below for the stable-6.7 kernel?
>> This is upstream commit:
>> 	eba38cc7578bef94865341c73608bdf49193a51d
>>
>> Thanks,
>> Helge
>
> I've already sent Greg a pull request with this patch - _twice_.

OIC.
You and Greg had some email exchange :-)

Greg, I'm seeing kernel build failures in debian with kernel 6.7.9
and the patch mentioned above isn't sufficient.

Would you please instead pull in those two upstream commits (in this order=
) to fix it:
44fd13a4c68e87953ccd827e764fa566ddcbbcf5  ("bcachefs: Fixes for rust bindg=
en")
eba38cc7578bef94865341c73608bdf49193a51d  ("bcachefs: Fix build on parisc =
by avoiding __multi3()")

Thanks,
Helge

