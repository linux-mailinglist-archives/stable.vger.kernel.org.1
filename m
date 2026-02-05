Return-Path: <stable+bounces-214454-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLANIKGOhGl43QMAu9opvQ
	(envelope-from <stable+bounces-214454-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 13:35:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 069ADF29AB
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 13:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6CCD53006821
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 12:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8E335CBAF;
	Thu,  5 Feb 2026 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MNvGOeNF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6770D2E62B5
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770294940; cv=none; b=jOx3d5g4WRkjgmXkCMH1nSL7cC35FwwMPV58HEjiqAzV1Ov4dqmfIiyCHiqYyQ69vxOWsWQQCgyjUsTptw0Qaj0ThktUOVwj1/gvc6kEYvxnmVYKo6Hsrg9oBmUDc+B2mufrQwPw60h/Gc9G6Ear6+UyDTeLv9Xa/S8kFWOBKFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770294940; c=relaxed/simple;
	bh=+53hNWU4aBifgGqYzlqXVZY1azKSazPsTo4RB5ZisTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K4RMkkCRSNhbNaVJ40rtpm1RgPZ5uoCAgcSPYH0H0WjlcT6q7G8U2I/TLkXm2rxgtV8M/n+5WQT16PkDpSLsLMzsHH3U9gDpjGPCRHyr3ZzSjNbs+iiAbNK+XnQisadD0yu0cLzf9miKX6bkCiArfJkbymm/XeZna8P2NF/V0Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=MNvGOeNF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48068ed1eccso9419635e9.2
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 04:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1770294939; x=1770899739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JMinWwuSYZAsnfOZ7eW4Hdd19Fsy4Vy9sVbUdrkHtqs=;
        b=MNvGOeNFjRv9j2RzRZSO7DpCHN1+mXNFzTesb5cdGgu25PTvpHxuim2zHwtAymUjfY
         r5JQfN/fhy5Srj3ghG8dRmZOmXB3G16g2COjSplL+KS/Muy8IJg3cGps4UcVOzrSi6uU
         jqh08N3IeN3AG0iR7k+XQARbNTA6oFQ1oh4JZ3ZZ7OTSpJWrbJaTEeLtbyLEixKL9G8M
         ShBbuS2k9IlVOHXjKDdlP8rtPKZNCa/vC/kVZ+0VQi6Cap67OFCAzkOXSdb/nRYuIDOS
         rfCUxFAoRbrFXU3qGba2+p1me4BN63EibSTHj78Wi6Eikta3KnCclJPJm9dHI7IWcDBb
         77uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770294939; x=1770899739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JMinWwuSYZAsnfOZ7eW4Hdd19Fsy4Vy9sVbUdrkHtqs=;
        b=eFWR9HPFJUzTe4IeTPoJ2ovnWd6dafnXdBXusBlYL5vXgVl11CvLBpjZKs1icbgqtL
         6XJjzPZ9MxQdLf0Va75JPlEuPZvpY+vUEeKe9TV4WlcwttzpcdkBMeT1WoezyWOkDt9w
         B4VjwasNEP4wYsXBkHHTNyAGs6JCFqij66nhHkp1i0FUEik0rQH4g6jSixVJOPvVdoIE
         N+uNUZAZiQfgxDB5uJvJsuzV9lSLKLg0PURBn7oN/ujSacbFKs7SLwf/bwGhW7Jk2Tjg
         R5wSquS0dch7I3nVi8RH240MK8/rquGkoeXf4KgUryWBlimEl+TnA/4z/GNlENYSYAuH
         MrLg==
X-Gm-Message-State: AOJu0YyN4MTjKoeKwQKRcOrn27LDcZO3nHW9iEk8gc3SfJfF7EuwFl4N
	FXSwTyG6Pil1RlwS0oby2E8cpmK9JFeqNbjolmLRrrsijGRebtVGzag=
X-Gm-Gg: AZuq6aJ1UlgKEq52SFoVkERcMp4Lesev8DBlTGR8ejVFmbs6HNxcAEsSOzpfeOAHLZz
	MpFGf5dwKOJ0x2h/POjNUHVX94trriLEiUd4fzSgh69Rh+uf3V/Uy52lZFQbcBL/FtMjVfznzuv
	fSVtlxCt+vyr9tYvMSH+IqFnX5r8eqYtmz4y29i7HBROaUrHDJ47eZhp2MCugHY2oJW5oUf9yqA
	7hO7Ivbul3KKasUViFO/iiX2R/QJ2dwaAgVg246pqlW0+ZHrqpG4yawtv4b7b/on8MClo6WtzkS
	UDgZbw3iro52MsyuWWHW79A676DAVxp1ksocMwkEcyuYuCPzy/SUx8ZCsao/eVkMzMUYLXpEd6O
	bgv4S/WETKE7NeNMDRYj0jtUkkO8hE/RhM5f8SYY3HfvZEkeXzuXHvDJpewgqiMHUOm8ODLmg9d
	oWqdTBuLMXdY/lcW/gcVTO2FWfEeql/OZqSMELJTmgeWvNrUB/t8wR/YjrquCtiR8=
X-Received: by 2002:a05:600c:3b16:b0:480:3b4e:41b8 with SMTP id 5b1f17b1804b1-4830e9934d2mr89621855e9.33.1770294938500;
        Thu, 05 Feb 2026 04:35:38 -0800 (PST)
Received: from [192.168.1.3] (p5b2b46dc.dip0.t-ipconnect.de. [91.43.70.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4361805edcfsm12882690f8f.35.2026.02.05.04.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 04:35:38 -0800 (PST)
Message-ID: <8bb7a822-2643-4511-9c14-c3bc2d1bfb07@googlemail.com>
Date: Thu, 5 Feb 2026 13:35:37 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/280] 6.1.162-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260204143909.614719725@linuxfoundation.org>
 <25910fd9-ecc8-4119-9abc-2ab6baf5ce77@googlemail.com>
 <2026020510-ember-darkroom-37f6@gregkh>
 <2026020526-frisbee-coauthor-8ca3@gregkh>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <2026020526-frisbee-coauthor-8ca3@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214454-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlemail.com:mid,googlemail.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mailvelope.com:url,linus:email]
X-Rspamd-Queue-Id: 069ADF29AB
X-Rspamd-Action: no action

Hi Greg,

Am 05.02.2026 um 09:33 schrieb Greg Kroah-Hartman:
> On Thu, Feb 05, 2026 at 09:31:30AM +0100, Greg Kroah-Hartman wrote:
>> On Wed, Feb 04, 2026 at 11:17:38PM +0100, Peter Schneider wrote:
>>> Hi Greg,
>>>
>>> Am 04.02.2026 um 15:36 schrieb Greg Kroah-Hartman:
>>>> This is the start of the stable review cycle for the 6.1.162 release.
>>>> There are 280 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, please
>>>> let me know.
>>>>
>>>> Responses should be made by Fri, 06 Feb 2026 14:38:23 +0000.
>>>> Anything received after that time might be too late.
>>>
>>> It seems that this time, I cannot even build this RC. When I run "make
>>> menuconfig" I get a big serious of warning and error messages; something
>>> seems to be really messed up here...
>>>
>>>
>>> root@linus:/usr/src/linux-stable-rc# vim .config
>>> root@linus:/usr/src/linux-stable-rc# make menuconfig
>>> scripts/kconfig/Makefile:215: Warnung: Das Musterrezept hat das Peer-Ziel „scripts/kconfig/mconf-bin“ nicht aktualisiert.
>>>    HOSTCC  scripts/kconfig/mconf.o
>>>    HOSTCC  scripts/kconfig/lxdialog/checklist.o
>>>    HOSTCC  scripts/kconfig/lxdialog/inputbox.o
>>>    HOSTCC  scripts/kconfig/lxdialog/menubox.o
>>>    HOSTCC  scripts/kconfig/lxdialog/textbox.o
>>>    HOSTCC  scripts/kconfig/lxdialog/util.o
>>>    HOSTCC  scripts/kconfig/lxdialog/yesno.o
>>>    HOSTLD  scripts/kconfig/mconf
>>> /usr/bin/ld: scripts/kconfig/lxdialog/yesno.o: warning: relocation against `acs_map' in read-only section `.text'
>>> /usr/bin/ld: scripts/kconfig/mconf.o: in function `show_help':
>>> mconf.c:(.text+0xa1b): undefined reference to `stdscr'
>>> /usr/bin/ld: mconf.c:(.text+0xa20): undefined reference to `getmaxx'
>>> /usr/bin/ld: scripts/kconfig/lxdialog/checklist.o: in function `print_arrows':
>>> checklist.c:(.text+0x2c): undefined reference to `wmove'
>>
>> <snip>
>>
>> Ick, yes, I can reproduce this myself here, something is odd.  Let me
>> track it down...
> 
> Ok, found the offending commit, will push out a -rc2 in a bit with this
> fixed, thanks for testing!
> 
> greg k-h

I was too tired yesterday evening to investigate my build error and poke around deeper, but today I looked into it 
again, and I found that when I revert the two kconfig patches in this RC

7c177eca9e7af1f0a56171b7718a1b05aaa0f237 "kconfig: fix static linking of nconf"
eb5defa1e8284b8b79653beadc92c273c170db7d "kconfig: refactor Makefile to reduce process forks"

then my build error goes away, the build succeeds and the produced kernel seems to work fine.

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

