Return-Path: <stable+bounces-223129-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FbKHrCCqGmYvAAAu9opvQ
	(envelope-from <stable+bounces-223129-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 20:06:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8752206E28
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 20:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15AA43020FD6
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 19:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85D63D300D;
	Wed,  4 Mar 2026 19:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YzMfsBYZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D47B3CB2CF
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772650834; cv=none; b=Mi/AIYEjCpIENN2BH16ZRWMzcSfLbKJefzqarGMb3ffOVNDWM47/RIVnUrZPhsUSyUca9PiL5lLEwXT18ep9IWMiGim9hMrVo3zMNeszKO1F/dQ+utc/fVT5JkXd+T4nu50yn+ujpZdYCUiEwb4SRZTBHe+LDLkOTD04MT3y7MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772650834; c=relaxed/simple;
	bh=Ex0d6iTateZyQ6s19YPLWn4hounqenjetRXcGw3hIJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGttFCW9xFN2Bcv9COJpV9qNovP0WwIpy9AG0xUZzxtPswnXC0yHhnxcj5iI9JxXYqYGX5sy903++bulJ1KVN93dqD6qNqOyl4d8hjSOBzasylA8E8DSZ/SpSApfhdyLYvoXb4muXJ+H+Hra/JLNaAAqonBiMA7TpSGK0IUKkRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=YzMfsBYZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483487335c2so59792775e9.2
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 11:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772650831; x=1773255631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NHkIqy50UvljDnwlCiELC421h3S89zPHPV6d2u5RZ6E=;
        b=YzMfsBYZfa1iNnddYTLlMPw4SZKlVISY06zkT++2ciJBi681f70HlpO22kt44CyBgi
         NaEXw8YRB33yFf8v1lf84kd/pAEoZ1xwzD5gROmVVxroyOaeLomQew7iBHtmmjBXcA1p
         li4Kd1HS+UZN1LDMG6uWymO1VPcSIEAHDrySioOH7BLC474Po45vTqx2h59hob3gVLWs
         M67PLOC3gbq+C4cuTAnDKwthywCdhHEU+EXcKhHYW3G2JvYOd+Hi3MbtdVwXo4A1C51Z
         j/XVCkp2VyYix61iFaSKigYCWFUGc24IUAltvNkMeoeV6PEYYrDcVP9xUN1wJLyVb+XQ
         IlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772650831; x=1773255631;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHkIqy50UvljDnwlCiELC421h3S89zPHPV6d2u5RZ6E=;
        b=ZL1SBurS/yrrSJRbKlLWlAZ3JSOI+txlbZt2xArWWqAjq9ZAKgHUyJ9DRqFAN9XBFj
         V7k/bJvjof5l7uDXKK+AxIS9W2P//U2ES/SpdSpJJdXARPC6n0XAqpLNKyljUTD6PkGq
         Lurs2GKyZ0vspZwz7lCTH8G78KzlLRrtCy3L+51idz2rabkjLGV3KJsASfjNE20nn0jE
         s6r125Zi5TCPPthH4dBmEsetNWq8adsmMcMkTWTDr1vMiOMRQPUX+NzDOJ4Wbp0HQZfg
         3qKt7s3W1hyBf3d0EzxbaxR6LMukvN88XiEMbpa5/VQV9wQwKJJBwPyyxQfj4O1Klvs2
         mdlA==
X-Forwarded-Encrypted: i=1; AJvYcCUYokmQQJOba7Jct2O0FzBgDAZmF1EqYZtfZXTl3aQXMvzjML+ep49RCp4T+lFhbcV+A58P4Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFTZzuQpph2hu3hNStlH2lbLOXRnRn4N7llfes4IMIYFBb2xWj
	EiNSmUo/8DGrMH96bqK4MSUKZXQgkXHx+ztfam9t6b1HzkA6OV2FCts=
X-Gm-Gg: ATEYQzyjLhGZV/ijVHVv8cLHN3UPY7AyFBWlRnxw1T97kxP3ZQ6y6Bu/KtvR6Y2hIXP
	Qqhtpw/8RGNHVhOa/K5EnQanneN8PwHuTq3JTFIHNwAclM4wWneJn7JH78lf8klkhGqkLniWzXG
	U8SS91AoVKKhdI46SAN7+s5icv0HzR3yHVfPrfN5FMDke8TDwE7uRbDAezxLSE5Bvzv/lAv+q3j
	TitKZiAgsiVbpjCUFJjFpVY0QV19hRH6B6rdkSqgSbav3tRkVl1HSBE1B3dEWEM7+GQ5+xDpbaM
	EebrcOEU23qLEXFyZkOBOQLYv8/6OAak09Q+h7T8Cc0QdkQHIBIokIxI8K+FdeMY/8oFksb+yDn
	X1dEUvBzSaFFMLhfQoZ6JEAuB+fI2d5sfDwGMmgXP864g6h1Ey+0c3b18L4F+9CyPWEW8mQnhYs
	Ky2sCtGm1KXYU27gKUpGOEgg+9bPMROi0qauXpT0h+i6iSGeXJq1Jd4vpscJh9twe82S2zjfsP6
	g==
X-Received: by 2002:a05:600c:4f8e:b0:47f:f952:d207 with SMTP id 5b1f17b1804b1-485198744bfmr55840005e9.19.1772650831387;
        Wed, 04 Mar 2026 11:00:31 -0800 (PST)
Received: from [192.168.1.3] (p5b057b4d.dip0.t-ipconnect.de. [91.5.123.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851a8ea6c1sm17214745e9.11.2026.03.04.11.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 11:00:30 -0800 (PST)
Message-ID: <0be301c0-f9be-4d70-9fdb-7a260ccf83ac@googlemail.com>
Date: Wed, 4 Mar 2026 20:00:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [REGRESSION] Linux kernel 6.12.75 fails to compile with
 -Werror=implicit-function-declaration
Content-Language: de-DE
To: Aditya Garg <gargaditya08@live.com>,
 "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Cc: "ardb@kernel.org" <ardb@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "graf@amazon.com" <graf@amazon.com>,
 "guoweikang.kernel@gmail.com" <guoweikang.kernel@gmail.com>,
 "henry.willard@oracle.com" <henry.willard@oracle.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "jbohac@suse.cz" <jbohac@suse.cz>,
 "joel.granados@kernel.org" <joel.granados@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>, "noodles@fb.com" <noodles@fb.com>,
 "paul.x.webb@oracle.com" <paul.x.webb@oracle.com>,
 "rppt@kernel.org" <rppt@kernel.org>,
 "sohil.mehta@intel.com" <sohil.mehta@intel.com>,
 "sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "x86@kernel.org"
 <x86@kernel.org>, "yifei.l.liu@oracle.com" <yifei.l.liu@oracle.com>
References: <DD397543-DDDE-4215-A116-318AEAFFC359@live.com>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <DD397543-DDDE-4215-A116-318AEAFFC359@live.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E8752206E28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223129-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[live.com,linux.ibm.com,linux-foundation.org,oracle.com,linuxfoundation.org,kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	FREEMAIL_CC(0.00)[kernel.org,alien8.de,linux.intel.com,amazon.com,gmail.com,oracle.com,zytor.com,suse.cz,vger.kernel.org,redhat.com,fb.com,intel.com,linux.ibm.com,linutronix.de];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mailvelope.com:url,googlemail.com:dkim,googlemail.com:mid]
X-Rspamd-Action: no action

Am 04.03.2026 um 18:35 schrieb Aditya Garg:
> Hi
> 
> I found out that Linux kernel 6.12.75 failed to compiled in my automatic builds. The compiler throws the error:
> 
> arch/x86/kernel/setup.c: In function 'ima_get_kexec_buffer':
> arch/x86/kernel/setup.c:380:15: error: implicit declaration of function 'ima_validate_range' [-Werror=implicit-function-declaration]
> 380 |         ret = ima_validate_range(ima_kexec_buffer_phys, ima_kexec_buffer_size);
>      |               ^~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> make[7]: *** [scripts/Makefile.build:229: arch/x86/kernel/setup.o] Error 1
> make[6]: *** [scripts/Makefile.build:466: arch/x86/kernel] Error 2
> make[5]: *** [scripts/Makefile.build:466: arch/x86] Error 2

I already found and reported this in the RC cycle [1], and Sasha dropped it in -rc2 [2], and now in the release, it 
obviously has, somewhat mysteriously, reappeared [3], affecting all of today's 6.x stable branch releases.


[1] https://lore.kernel.org/stable/66461c13-1bb3-473c-b57f-adba9db4f756@googlemail.com/
[2] https://lore.kernel.org/stable/a04b1aa6-ba46-4368-9dfe-6320a2dafa79@googlemail.com/
[3] https://lore.kernel.org/stable/c435a3c6-5952-453f-9e50-31e0c6cdd09f@googlemail.com/


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

