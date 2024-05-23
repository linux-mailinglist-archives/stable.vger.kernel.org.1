Return-Path: <stable+bounces-45977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B368B8CD9AF
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 20:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F0028284A
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 18:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394A676F17;
	Thu, 23 May 2024 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="C6Kk+Cae"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F83537FF;
	Thu, 23 May 2024 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716487780; cv=none; b=kPXkSx5IpUJxvcaTtKd6orbH+15mxoORsKs11KNye3l+VCq3gl1bYGliteR7nLAYBCayxkmaq5R8SUierMmY03bOKbpjz5T0MB7kgCodneYDzDUmakqxV4tKNkBvtj4W2nAecSC1InxkGWT9sye3ABunsB3lYb/SDlM/1Sq+SRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716487780; c=relaxed/simple;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=e7Rs2tqp/JNZkoKHYHoruYbhahxd3TzSAgNmx+wA+NXq7VTopBl/CXoHqhXfMc+lXRUHZaHiSPrLs3997z5YvtVfhN5V6wxG4mHdch68fovCoJuwySZTSHTx3i1JA8xKlFobjGdp2LmLyI2YzvqS+JWkXt5FkOAlLFX/+7GTh2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=C6Kk+Cae; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716487774; x=1717092574; i=rwarsow@gmx.de;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=C6Kk+CaeEBsuPdbBVphWzEK2gkhafDFLcElTB3KBlrf4Fw7f/DoOIafChC50WeLc
	 8iE19Amcytyqpa6+f5BPQZdeTYiXC1k6OwML/CCM4T3yaKpG9o1JY/e8wZf/Lpr2j
	 1bOQKkNJxoWyXEw+k1aNAIVmgkE//QNVvR0MqWzdh+OFwEjHAIhVht9Ad80EKbnUw
	 I0qPvtL3wZPWV7/M8nBZMRHUO00rnFUHRz8y1bdiY22HlvW0gMISdmztwl6B5j5iC
	 QwVNWttrZcfMYTfu8VCrNxZrShGNo8nxeZtmfVJs/cLEG+YJWRNvbnFKNhYluZabg
	 6twEa12QYArK8HAwNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([92.116.253.15]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9FnZ-1sCh332Y6h-007VFp; Thu, 23
 May 2024 20:09:34 +0200
Message-ID: <c7b3528d-d09a-4ea6-a587-c2e2f7fb222c@gmx.de>
Date: Thu, 23 May 2024 20:09:34 +0200
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
Subject: Re: [PATCH 6.9 00/25] 6.9.2-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:CLqZJRPSCjZX+KKyoz+mtIm0pLRGGCgz8GGuzj6yvQbB4cpfr5Y
 S7io3dwHpOZW8K9m/R1KLTv8EIIKHztRfqJlVwpUhR3FWGmcKXQFYmjOj6fmw8oNrSwLzpp
 jtsoKzhaxgciWS6WHjW9wJv3KhAKo5IuygO+Vx4K/TxaAg+rLWNPl4BjWpc2fFUNZ2qSwSu
 MoHDoGo0JjcbfXw5c9nSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JOJtwedHdjY=;qAwhznuwt9PiJLlqJy3AuGTTy8l
 S+/pCuZMkJIR37IcEqubcwH+KZhkNF5Z+cOCoqJixb1CxK5c3WRogLxlFP+ql8rvdEFcNIEYV
 sQOIqEZ2hPI5YVyC5LchG6iTzPmQeUUN+29x/ew7jcP0a5w3fTG0fAU2Io5moMO7wlpMdXz7K
 EboYGKJT2DVmsjYw0qg2bEFMPOPvLWG1IGp0R5Jh1971UgTyxCi98VrTu6TedXqphkJIsaPut
 a5Hve2PCLfFT0YiLLUitpz6Ukk6A/YC7p8pM4WEpxq8147lgLQhesiZZWWtfdCbWY1U1YxT6f
 2mwO3fyR618W8YlOj4nNmWNRL1a40CtUFgOUStSYUQLB3ysAGx72etniijsFe8pRe4YK6A0Pl
 bRHQqZDXw9ORoyUTHvMZRxTSheOuILk4EXJhJPxjOl1sf9+912nxSjUoi64cEEgKtIOqdU0Bx
 ZOAPXPI1Lpa1mCKVKji5rfbQ3r0sD3SCuT1AB9vIps6+1YSwTRcJDcum0TffFxOz2k6v43AfV
 HmUoS4xSN6VjsNDHGseShkM7rQYYi3/Lc1lOThasOxwrAqkXGGEyDYoc0gLzoArPzMyW6c80D
 5K/Lcpo0Qz+w5AhGJ9d8eI/88nE8MQNoE6sXDXExtzwth1Md169Oh8J9V/plAk4jp8wpajXHh
 CsIVt8ebwHzVRf6PLsSn9xHbCrw6ZNnRQinF9iCuyzR161aJ71hqUkfeu5u66T02PPZsBuYRW
 MIn7fRn7wWLWiuXJ4I6sRwPSmNFBwW52DobmweNNM4XKossLXojZZ+BRxDALLIjJh3uxTO7CW
 ckv10VLVbJ+Gi5ywiRTJn5D9PyVrjp0dNZzGvBFvScz7g=

Hi Greg

*no* regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


