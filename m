Return-Path: <stable+bounces-66268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2C194D137
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 15:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 671F61C22486
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 13:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1327818E04E;
	Fri,  9 Aug 2024 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=volny.cz header.i=@volny.cz header.b="mboFrFyW";
	dkim=pass (1024-bit key) header.d=volny.cz header.i=@volny.cz header.b="mboFrFyW"
X-Original-To: stable@vger.kernel.org
Received: from gmmr-4.centrum.cz (gmmr-4.centrum.cz [46.255.227.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6C31E86F
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 13:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.227.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723210082; cv=none; b=IxddvnXh18jvqEGk/K3JstdBTKZxEIMwZidqf8hgQul7OWvBkzZAF1KwfpgzZaafpkGNkHQ3MXxnZhUVKXNA3FIZYSqJr5y4wOSv60OEM9/V9n/pxCzk6tili57r0KKl9EiS0FnDiuQQlvXLBIfjZ9Fbwj95Z2pIjXNjjzsKCDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723210082; c=relaxed/simple;
	bh=Kgo8ad1YtHNCT8jqC4VshnRPcL96rdm7efbryORE0Ns=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:Cc:From:
	 In-Reply-To:Content-Type; b=XbrkteuV6GqS76yUY9hNy1nTC1UkEE3JK+/PhIasej5rDfTQhVcgjL4TeOM3Y7slP1r3p6QKT5he8ai4qyEOu30SdnYBngHkI7vat65MT9DF5Swz5uTtp56RYPzEdNhIQtmRde8Vulw0R1qMerlRdQismF3XiFbEqDw2gUKt7E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volny.cz; spf=pass smtp.mailfrom=volny.cz; dkim=pass (1024-bit key) header.d=volny.cz header.i=@volny.cz header.b=mboFrFyW; dkim=pass (1024-bit key) header.d=volny.cz header.i=@volny.cz header.b=mboFrFyW; arc=none smtp.client-ip=46.255.227.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=volny.cz
Received: from gmmr-1.centrum.cz (envoy-stl.cent [10.32.56.18])
	by gmmr-4.centrum.cz (Postfix) with ESMTP id A3CE21D733
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 15:26:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=volny.cz; s=mail;
	t=1723209999; bh=hyhesl6KCfXqQnxkhm8y9wnpBrNXfy9DApCw8kTOfoE=;
	h=Date:Subject:References:To:Cc:From:In-Reply-To:From;
	b=mboFrFyWLkBvSiuTNGVjMkZvWAjiNi1gq1iE29wJQb29bZUSlov0aaCKh6LrbgeDM
	 6JjRvVnM11lbw5bvGQnwnzjB4y8LMLhup73NIv5jSOlHBS4wcutM22CuCCoDj8mgHY
	 aHYNkh679K/LAUtCBNDhIYt53STQD50PvwTVXByE=
Received: from gmmr-1.centrum.cz (localhost [127.0.0.1])
	by gmmr-1.centrum.cz (Postfix) with ESMTP id A063C18A
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 15:26:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=volny.cz; s=mail;
	t=1723209999; bh=hyhesl6KCfXqQnxkhm8y9wnpBrNXfy9DApCw8kTOfoE=;
	h=Date:Subject:References:To:Cc:From:In-Reply-To:From;
	b=mboFrFyWLkBvSiuTNGVjMkZvWAjiNi1gq1iE29wJQb29bZUSlov0aaCKh6LrbgeDM
	 6JjRvVnM11lbw5bvGQnwnzjB4y8LMLhup73NIv5jSOlHBS4wcutM22CuCCoDj8mgHY
	 aHYNkh679K/LAUtCBNDhIYt53STQD50PvwTVXByE=
Received: from antispam61.centrum.cz (antispam61.cent [10.30.208.61])
	by gmmr-1.centrum.cz (Postfix) with ESMTP id 9EDE0183
	for <stable@vger.kernel.org>; Fri,  9 Aug 2024 15:26:39 +0200 (CEST)
X-CSE-ConnectionGUID: oFm1GOODSv2UcYK4+YDKIg==
X-CSE-MsgGUID: Qs4vpOb/Q8aRWlOaKjnWIw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A2ENAABAGLZm/0vj/y5aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUAJgTIGAQEBCwGFJIRWiB2JJS0DhDuNbIoVgVaBfg8BAQEBAQEBAQFNB?=
 =?us-ascii?q?AEBhQYCiVUnNAkOAQIEAQEBAQMCAwEBAQEBAQEBAQUBAQYBAQEBAQEGBgECg?=
 =?us-ascii?q?R2FL1OCZwGDfQEBAgMjDwEFQRAJDwQDAQIBAgImAgJMAggGARICAQGCfIJlk?=
 =?us-ascii?q?x6bPHqBMhoCZd4SNYFWgRouAYR7AYNOAYVlO4IMgi+BAoEJRIEVJ4MDPogeg?=
 =?us-ascii?q?mkEhlmBHoJgh0WCEgGCFFcPglyBYoItJoE0gQuHNYgCgQ8DCQYCAgIPFxYGA?=
 =?us-ascii?q?1khARIBVRMXCwkFKoRYhEcLgyIpgUwlhBeBNRQBg2SBZwwEXYFfEIU+Fy6Bc?=
 =?us-ascii?q?IE+gV5KgndLg12CAEI/gll0AVUQOAINAlEdEy0CAQttPTUJCxsGPachgzEkC?=
 =?us-ascii?q?yREeWKxGJUMBwNigzKETZxxBg8EL4QFjQCGSxYDkleYbyKqW4IWhCdSGY48F?=
 =?us-ascii?q?tApdjsCBwEKAQEDCYtigUsBAQ?=
IronPort-PHdr: A9a23:YbYLzR2r0LpfsPU6smDOyQIyDhhOgF0UFjAc5pdvsb9SaKPrp82kY
 BeHo6QxxwGQFazgqNt6yMPu+5j6XmIB5ZvT+FsjS7drEzIjt4A9sjdkPvS4D1bmJuXhdS0wE
 ZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZrKeTpAI7SiNm82/yv95HJbAhFiiaxbal2I
 Ri5ognct9QaipZ+J6gszRfEvnRHd+NKyG1yOFmdhQz85sC+/J5i9yRfpfcs/NNeXKv5Yqo1U
 6VWACwpPW4t68LnrAfOQwSS6HcEXWoYjhRHAw7e7BHnRZjxqTf1tvB82CaBI8L7S60/VCm44
 KdqTB/ojzoHNyI8/WrKhMF8kL5XrRS8rBFk3YXafJ+aO+Z/fqPFfNMVW2xBXtpKVydcBo+wd
 pYDA/YdMepdqYT2ulkAogakBQS0B+3hxDBHiXHr0600zeosDwHI0w48ENwBq3nUsNb4Ob0OX
 eyp0qXFzzPOZO5W1zfn74jIdwgsrf+JXbJxbcXRyVMgFwffglWQs4zqJS+a1uQKs2iF8eVvS
 fmii3AgqwF1pDiuxt0ghZXIh44b11vJ8iB5wIcpKt24UkF7ZcSoEJtKty6AK4R2QsQiQ392t
 ykm0bAGp5m7fCwMyJUn3RLQd/2GfpGO7xn+W+mfPS12i2h5eLKjmRmy606gx/XyWMS73ltHr
 zRJn9fDuHwQ1RHe68iKRuZj80qv3TuC1B7e5+NaLU47lKfWK54szLA0m5cNsUnNECH7lkX2g
 aGWcEgv5+um6/z/b7jpp5KQLZF4hwH+P6g0hMCzH+Y1PhIMUmWb4eix1r7u8VfkTLhKjPA6i
 LTVvZ7YKMgBu6K1HQlY2Zs55RmlFTepytEYkGECLFJCZR2IkZDkO0rLIPDkFfe/hEmskCtzy
 /DGILLhBpLNI2DMkLfkZLp98EtcyBYrzdxC+55YEK0OL+z1Wk/trtzYExo5PxaozOfmENl91
 4UeVnyTAqKBP67fsEWE6vwvLuSMfoMZpijxJvo/6/PsjXI1gVodcrOo3ZsTZnC4BPNmI0CBb
 Hrpg9cODWcKsRA6TODwiF2CSyRcaGqyX6I7+DE0Fp6pAJzdRoCqhLyB2ie6EodKaWFHElyMC
 2vnd52YW/cQbyKfOs1hkj0eVbigUI8h0QuhuxT6yrd8Lerb5DcYtZT929hx/eHTkgsy9TNsA
 8SHz26NV310nn8PRzIuxqBwv0N9yk2d3qhjmPxYFNtT5/VSUgohMZ7czvd6C8zpWg7beteJS
 VCmQsipAD0rU90+3cEOb15nG9q+lhDDwzaqA7gNmryQGJw76LnT33zvKMtm1XbG27cuj0M8T
 stMK2KmnKh/+BbXB4LTlEWZjamqebwa3CHW7GiD13aBvFlEUA5sVqXIRX4SalPLotT650PCS
 qejB6woPARP18CMNrdHZNvxgVpbQffsIs7ebH6plmmoHBiG3ryCYJLxe2UF0iXQEFAKnRkL8
 3iJLQQ+HT+ho2zGAzxuC13vZ0Ts/PFmpn2iVkE6wFLCU0o09buv+1YugfWWWrtH3LMeuTwlo
 j9lNFWwxdTbD5yHvQU3OO1Hfdo35Fpvy23UrUp+M4amIqQkgUQRICptuEa7nRB2AYVJlY4qt
 nohzA1sJKmwzlRFcSLe1oK6cunSK2Ly9RTpa7Tf0VHZztud0rkI7PIp7V7x6lL6XnE++mlqh
 oEGm0CX4Y/HWU9LCcqZbw==
IronPort-Data: A9a23:SHeLOqOemIgfeanvrR3XlsFynXyQoLVcMsEvi/4bfWQNrUolhTRWx
 zFJWmHXO6nYZmH2fd8kYIzl/E0DvZ/QyNc1G3M5pCpnJ55oRWspJjg7wmPYZX76whjrFRo/h
 ykmQoCdap1yFzmE+0rF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZg6mJTqYb/W1LlV
 e/a+ZWFZAf1g28saAr41orawP9RlKWv0N8nlgNmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwOhxIktl
 YoX5fRcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KWZg8
 KU3DxchVQ7ZuumH4+74e8VPp8t2eaEHPKtH0p1h5T7cSO0jXYiaG+PB6NlExio1wMtcdRrcT
 5ZHL2AyMVKaOUIJZQp/5JEWxY9EglH6cjZYoVbTpbA+6GjU0gF6+KbqNNzEPNeYLSlQthjJ+
 zOfpDmiav0cHOWElSSd1Xjrv7/Gpxz/f4sxFruH1+E/1TV/wURWUnX6T2CTo/iji1W6UthOA
 08Z4Cwjqe417kPDZsPwUAe1u2WFuRgHc95RCPEhrgWMzLfEpQqUGAAsVSJIYtgrnNE5SCZs1
 VKTmd7tQzt1v9WopWm1qunS927vf3JPcildOEfoUDc43jUqm6lr5jqnczqpOPfdYgHdcd0o/
 w23kQ==
IronPort-HdrOrdr: A9a23:UtWbeay0vuIkqOIc1Jx4KrPwFr1zdoMgy1knxilNoNJuA66lfr
 OV/cjzsiWE8Qr5OUtQ/+xoV5PsfZqxz+8R3WBVB8bHYOCEggeVxeNZh7cKqgeIc0bDH6xmtZ
 uIGJIRNDSfNykYsS+32maF+4tM+qjhzJyV
X-Talos-CUID: =?us-ascii?q?9a23=3Atgpmg2twytGadc/k12HXe41o6IsiXHiE41D3D3S?=
 =?us-ascii?q?mU1tieZ7JCm6824Jrxp8=3D?=
X-Talos-MUID: 9a23:POWDhQQEco+QmW39RXTVn218LOBipJ3+AXoylbIPmMuCCg1vbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,276,1716242400"; 
   d="scan'208";a="69591353"
Received: from unknown (HELO gm-smtp10.centrum.cz) ([46.255.227.75])
  by antispam61.centrum.cz with ESMTP; 09 Aug 2024 15:26:39 +0200
Received: from [192.168.1.100] (unknown [78.157.137.12])
	by gm-smtp10.centrum.cz (Postfix) with ESMTPA id 0D41F1683CD;
	Fri,  9 Aug 2024 15:26:39 +0200 (CEST)
Message-ID: <4bbe7ded-33cb-44e8-bad3-633580d98e5b@volny.cz>
Date: Fri, 9 Aug 2024 15:26:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Fwd: mmap 0-th page
Content-Language: en-US, cs-CZ
References: <7cbde1da-c985-40f3-9368-c45146a9095e@volny.cz>
To: Jiri Slaby <jirislaby@kernel.org>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev
From: "michal.hrachovec@volny.cz" <michal.hrachovec@volny.cz>
In-Reply-To: <7cbde1da-c985-40f3-9368-c45146a9095e@volny.cz>
X-Forwarded-Message-Id: <7cbde1da-c985-40f3-9368-c45146a9095e@volny.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I am apologizing for sending again.
I have forgotten to add all recipients to previous e-mail.
...


-------- Forwarded Message --------
Subject: 	Re: mmap 0-th page
Date: 	Fri, 9 Aug 2024 12:45:01 +0200
From: 	michal.hrachovec@volny.cz <michal.hrachovec@volny.cz>
To: 	Jiri Slaby <jirislaby@kernel.org>



Good afternoon,

I finally have in Fedora Linux kernel version 6.10.3:
Linux fedora 6.10.3-100.fc39.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Aug  5 
14:46:47 UTC 2024 x86_64 GNU/Linux

I have set this setting to zero:
cat /proc/sys/vm/mmap_min_addr
0

Then I compiled your program, where I only added the main and the return 
statements:

int main(void)
{
char *zero = mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_PRIVATE | 
MAP_ANONYMOUS | MAP_FIXED, -1, 0);
*(char *)(NULL) = 'A';
printf("%c\n", *zero);
return 0;
}

I got error at running the compiled program:
Program received signal SIGSEGV, Segmentation fault (at line 2 of your 
program)

Can you help again, please.

Thank you.

Michal Hrachovec


On 7/31/24 09:43, Jiri Slaby wrote:
> On 31. 07. 24, 9:39, Jiri Slaby wrote:
>> On 26. 07. 24, 12:36, michal.hrachovec@volny.cz wrote:
>>> I am trying to allocate the 0-th page with mmap function in my code.
>>> I am always getting this error with this error-code: mmap error ffffffff
>>> Then I was searching the internet for this topic and I have found 
>>> the same topic at stackoverflow web pages.
>>
>>
>>          char *zero = mmap(NULL, 4096, PROT_READ | PROT_WRITE, 
>> MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
>>          *(char *)(NULL) = 'A';
>>          printf("%c\n", *zero);
>>
>> still yields 'A' here with 6.10.2 w/ vm.mmap_min_addr=0.
> Yeah and mind LSMs...
>


