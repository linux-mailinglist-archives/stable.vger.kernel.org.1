Return-Path: <stable+bounces-216264-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FAuGtVQj2nnPgEAu9opvQ
	(envelope-from <stable+bounces-216264-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:27:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C87D7137EF8
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5517D300A740
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 16:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC30225775;
	Fri, 13 Feb 2026 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OC1Q3hgA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3DD54763
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771000016; cv=none; b=Gz0Sf24RVXEjbee4BeTMCYtLt511Njeq8VJWQ17gsNwk8AYHWmMvUDwkhmWKh0wuofbDZT34xqUHr/yGesaSCbPEeJP1gTKUacvqoq7w/XfRnWpxJXkOyI4goLHPRJx7IaPQOCV/LQHKxGJ1EMB8xltSzP/xOkwEWl0PAUpekOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771000016; c=relaxed/simple;
	bh=9YmZh/uq8bir5RxWKfixDxTifj6YnOZOxkqroeS+roY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5RrY0Sq0v7zqREdoUiOywTIDHUN1VWX2CbtrIOnRhpx0eOtxfLxem9r8sw3QvYfNjSR2xqTzOKfNJvb9N97gw5a9wp1O/pgD6VUu0ZBpEH1mkeqkusMhQDYg+KgBklAF/sJlHhsC7L2aAKqk9nw+BPEWNKixQWHgrlv9Ebtprk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=OC1Q3hgA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso9240015e9.3
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 08:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1771000013; x=1771604813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=btjRa7SAXxAwy3tcL6MhGx9Z8DwTnzSLSGZM38a16QA=;
        b=OC1Q3hgArTai4qIb2oelTFAe3vZH83ZCCBeNc+GFazXA7WDUUvV/XzRjM2bmIRtL2f
         2RVNXjdcX09u9uJgo+xcZN/qV0I+0Qs9yqDHEaD0twm91aI64KpXeBwxyH+tc5x2u4zt
         c18Qj+dOeonuQdX8Dnz7LSjhmdPGScn6P0JwIGt3sUuuQnSxzfM2La3JrdGANHIkuSPK
         0EGLAGOTdvDomh4hkFP9grT5+4x+p684GYCSokf6enVFviFBLwivpynSJAf+OUiXp+g2
         4a8y7C883Bl9KHOfr6YfCXg7emdX700Sf2n3Z3liivcl+lmlyPF5kkyhGRnUm2WNLG9x
         4pSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771000013; x=1771604813;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btjRa7SAXxAwy3tcL6MhGx9Z8DwTnzSLSGZM38a16QA=;
        b=u0hnV7OM+LModHhcGF2h5RKOI9jHE1tg2aATUQGC4sqUiGeOou7YMs/N2cfCXx5/zq
         x1BWvox/uHlJB72Ufs4NopD67kzpcnMpA0ucy8ji3tdGG0XdRDnubdHvHuLUEIubQ3dO
         UTr4On/Thi4QKin1Pps46pgBkt4iAlSG6TsSmMmNnvl+V6By1EUv7kI37qJrLBQIDPUh
         Ov67l05G0hBFi9yfWe3g8UBs9Oa0wy+Mft40y8I6e1C0GQFT1/4N7PcP1JwffUNcgvoi
         ZwAAVRUyAupd6P9qXODbCYOVpK9lwIB/XKsWyuJbCiMh7XQHj0F6Hmol4fXNIrgZ7WBP
         rqWw==
X-Gm-Message-State: AOJu0Yz5KwxNzWXzVjKHV5EOls7aNuXRPSsDD841CwJaUiC0HQJQyU0W
	JyCj32mZmiIBidXcjf1ZUXDmfe1UFd/Ur5WppHZL6AYtQVzurP1bfj1hhcbm
X-Gm-Gg: AZuq6aJgweVHpUTbrWB3CQo4Wuwz1rt8N7mvafz4130Px/VgCst0BjhCH0MewwyR4DH
	u0TOIAlveNBxmjr8gdarf/ocnsLJDytdRBCKkMs6hcvcdQiX3SIZHi360+f798FiAD2qQHAQub+
	TN1NgT+S+PbDSyhBL5ng2Are53aJJvuXIo7piim2C3vYnL2qOAuWY3eXiCLx5LcRpi/wxgIL0DS
	AV1sSGdmR1jRhk8CutQ7qcDjsZo+2XWZCS4Q18Pl+lnZZ7UAtnK4qkunliY3CCHgJrFqm9JrOjp
	6+tPtsfXpSVFBnsxZ4xoHkcKpvIu3blVsnbRHAZ4EfnqLG3kpHQ1U7km7IrcYX+lCyBNjNJwhq7
	LjtACH1A4iCrPaRKoqMNq6HF9yXKJ7CcTzUFmRIrrNqeDvrX8TxBIf8CxCqil5DNflfptw9any2
	1c8icVSimXmGgxRpt0iKpE/F2gTxje5T/868BtDAB8anYOQe3i0X8aNYmn7oFeVKNrm3BDTBdi0
	BEc
X-Received: by 2002:a05:600c:524d:b0:46e:1a5e:211 with SMTP id 5b1f17b1804b1-48373a69e13mr46917485e9.21.1771000012919;
        Fri, 13 Feb 2026 08:26:52 -0800 (PST)
Received: from [192.168.1.3] (p5b2ac4a9.dip0.t-ipconnect.de. [91.42.196.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4836cd7af87sm110015355e9.1.2026.02.13.08.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 08:26:52 -0800 (PST)
Message-ID: <a856f911-c493-4c48-ade8-467d9da1f628@googlemail.com>
Date: Fri, 13 Feb 2026 17:26:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.19 00/49] 6.19.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Achill Gilgenast <achill@achill.org>, helpdesk@kernel.org,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 sr@sladewatkins.com
References: <20260213134708.713126210@linuxfoundation.org>
 <DGDX0HGRJJ3N.1F1EWJEDMYZND@achill.org>
 <2026021312-magma-dormitory-53af@gregkh>
 <2026021325-repacking-crumpet-5861@gregkh>
 <2026021353-perfume-drum-3776@gregkh>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <2026021353-perfume-drum-3776@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216264-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlemail.com:mid,googlemail.com:dkim,mailvelope.com:url]
X-Rspamd-Queue-Id: C87D7137EF8
X-Rspamd-Action: no action

Am 13.02.2026 um 16:57 schrieb Greg Kroah-Hartman:
> On Fri, Feb 13, 2026 at 04:36:39PM +0100, Greg Kroah-Hartman wrote:
>> On Fri, Feb 13, 2026 at 04:35:27PM +0100, Greg Kroah-Hartman wrote:
>>> On Fri, Feb 13, 2026 at 03:48:19PM +0100, Achill Gilgenast wrote:
>>>> On Fri Feb 13, 2026 at 2:47 PM CET, Greg Kroah-Hartman wrote:
>>>>> This is the start of the stable review cycle for the 6.19.1 release.
>>>>> There are 49 patches in this series, all will be posted as a response
>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>> let me know.
>>>>>
>>>>> Responses should be made by Sun, 15 Feb 2026 13:46:52 +0000.
>>>>> Anything received after that time might be too late.
>>>>>
>>>>> The whole patch series can be found in one patch at:
>>>>> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.1-rc1.gz
>>>>
>>>> Hey, the link to this patch (and all other stable-review patches from
>>>> today) seem to be not uploaded yet. Is this expected?
>>>
>>> Nope, not at all. let me see if something went wrong on my side...
>>
>> Ok, pushed again from my side, let's see if it propagates properly
>> now...
>>
> 
> It's a kernel.org mirror issue, it's being worked on right now...

It seems only the tarballs are affected?! I could git pull this RC just fine some 10 minutes ago and build it. Adding 
Helpdesk and Konstantin in...

The 404 is funny though, kudos to whoever made this :-))

Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

