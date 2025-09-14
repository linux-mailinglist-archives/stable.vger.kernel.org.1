Return-Path: <stable+bounces-179577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D19B569D3
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 16:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A92417AD34
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 14:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C00202976;
	Sun, 14 Sep 2025 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=niklas.cathor@gmx.de header.b="fDt8BgQ0"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C0B1DED4C
	for <stable@vger.kernel.org>; Sun, 14 Sep 2025 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757861308; cv=none; b=pKLo6wAjPUDFuVkDS8Ofxqv1+Kq9Mvwxhnk2/jVKtHq1sPPoG8I6ard/nj/70GL4GaJ7kz+WvzMGqDF8AcdXKa5W0icp/xrGx7rMBG7IPrb3w4DcAlrwnVoDogwBkQlqUOC1UiwjES9GDQJdP9eVcDztSREeQq197pgg/e6A5tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757861308; c=relaxed/simple;
	bh=PuQNq598Y9pkhC9Dc8o48DnRl9FYyZQVDGjUcyJFTLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jqEDXlFtIeOjc7DA8RwB8mfNDnESj27B/otzGxojLM5QVDQJktMOYo/ZmcOXMwfJjjXSrgEJmFxN+MBoff/gwvHLPzvY78KqKM+3kQtEDkGHd7HTeKZsQLJik0h9TLFCnj7A8w847G+2xzBzmum/qQmee+cT8K3UfSh7s30+KWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=niklas.cathor@gmx.de header.b=fDt8BgQ0; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1757861298; x=1758466098; i=niklas.cathor@gmx.de;
	bh=BPrv2bmq4Ggj63wB5lNKnpgjJiagc010pOxYH+Gw1oQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fDt8BgQ0DqnduL7w1aZDzcuBj3k7r8MNEJXtrH9LRX0IvSvqGyA/EB+q42sYiNeq
	 iigMqtkeM78bOwHDDGQXUNvcW12fwG3DZUy8e4MitRf8Z7I4H/3jktHyewLsxxfK6
	 wcVnXsT+5KmLFcrRFPhJ/nufwFc5WZFicqCapsFZUTW1PpFXIZnXCc4eNXA7ldUbL
	 w+CL2ek40uI5Pjk+yDBDkNtoPSOmvL/UzHTd+DiSvX4ZFw0DMSRWXctQS7L0bqOoh
	 OZ6j7OnurE05uGxH4T2rklwRFoizyR7LLGxk6F3RIHRgLB1lvV0Oy3oh/1JXXtwVE
	 SdmUZexOEKLWFcRY1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.20] ([95.90.244.124]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDQiS-1v4zHo2lte-000wdj; Sun, 14
 Sep 2025 16:48:18 +0200
Message-ID: <c14f75ff-2c88-4747-8bbb-85a3eb659749@gmx.de>
Date: Sun, 14 Sep 2025 16:48:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Please backport commit 440cec4ca1c2 ("drm/amdgpu: Wait for
 bootloader after PSPv11 reset") to v6.16.y
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Salvatore Bonaccorso <carnil@debian.org>
Cc: stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
 Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Marcel Jira <marcel.jira@gmail.com>, 1114806bugs@debian.org
References: <aMakc-rP93XNJaA6@eldamar.lan>
 <2025091431-manpower-osmosis-b679@gregkh>
Content-Language: en-US
From: Niklas Cathor <niklas.cathor@gmx.de>
Autocrypt: addr=niklas.cathor@gmx.de; keydata=
 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
In-Reply-To: <2025091431-manpower-osmosis-b679@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wJBkfEf9axOaHOzGyDYhjwM4D4oSy+7HjOYJxo21EAN0H+WgpLD
 6Rjun1bJpCUv99d+gggf6n/G17uwfqkqtBgkDpug2eCkiXohoplDUyuiHpVJp2Ue6Yr+HzG
 6UWP1xTCDuJ0DMmRnIncVi4FAxYkYUAResRi0irZRZ9LdVpUEd5KiWBAURo8eYES90qE00b
 Bcdl6OfxkaZceh99zLUtQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fopQpCd8yr4=;/EEtgrGruDyBG1zakATM4A9swaf
 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

Hi Greg,

On 9/14/25 1:43 PM, Greg Kroah-Hartman wrote:
> On Sun, Sep 14, 2025 at 01:18:11PM +0200, Salvatore Bonaccorso wrote:
>> Hi
>>
>> In Debian we got the report in https://bugs.debian.org/1114806 that
>> suspend to RAM fails (amdgpu driver hang) and Niklas Cathor was both
>> able to bisect the issue down to 8345a71fc54b ("drm/amdgpu: Add more
>> checks to PSP mailbox") (which was backported to 6.12.2 as well).
>>
>> There is an upstream report as well at
>> https://gitlab.freedesktop.org/drm/amd/-/issues/4531 matching the
>> issue and fixed by 440cec4ca1c2 ("drm/amdgpu: Wait for bootloader
>> after PSPv11 reset").
>>
>> Unfortunately the commit does not apply cleanly to 6.16.y as well as
>> there were the changes around 9888f73679b7 ("drm/amdgpu: Add a
>> noverbose flag to psp_wait_for").
>>
>> Attached patch backports the commit due to this context changes,
>> assuming it is not desirable to pick as well 9888f73679b7.
>>
>> Does that looks good? If yes, can you please consider picking it up or
>> the next 6.16.y stable series as well?
> I have a revert of the offending commit in the 6.16.y queue right now,
> as this was pointed out as causing a problem:
> 	https://lore.kernel.org/all/20250904220457.473940-1-alexander.deucher@a=
md.com/
> so that should resolve this issue, right?

Yes, I can confirm that applying that revert to 6.16.y solves the issue=20
on my machine as well.

cheers,
Niklas


