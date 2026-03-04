Return-Path: <stable+bounces-223131-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Z0c/FwuKqGlXvgAAu9opvQ
	(envelope-from <stable+bounces-223131-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 20:37:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6C320725B
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 20:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9447E30342A9
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 19:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C943DBD59;
	Wed,  4 Mar 2026 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="TWACE2JO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FE936F40A
	for <stable@vger.kernel.org>; Wed,  4 Mar 2026 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653062; cv=none; b=tnXUQiTXxHolP2/m5R2H9xQZ0Rwa5Cid7/cvCZ6Jt/HOTE3zdshssXPt0P6i6Cw36YWYUyh0NqsfOR/0wEBPcM8Mph3jd5I0XEB//eDh6RXE+XSD45fvRGJDqENpz9++4R+X0a7hV5TlYFCO4T0UgftHA7DdFDn8lF/0RLVeHYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653062; c=relaxed/simple;
	bh=OW4eMik25G2FSgHJIPyZQ1r4N5NU7khno8sw7a5jgWA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NlewW5TlJrewNiU499N2TAkVAI32Sed8XSwYdrlR3hszuG+7QKAAxPzEh136Zzl5Tlq73Qd/8oskjR71LLX+vYhS+3rMWU4mgQXkSF8UCkCUpIDPEXlxZ/lXBWHpSjr6j6AI6iV+gn4BkW5PTVNDvFyzy6Prlx2S3THoGBJm51A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=TWACE2JO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48373a4bca3so45138295e9.0
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 11:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1772653059; x=1773257859; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f5y32mR6YkYWaR3orbX6cTWzoDxvktA7ezcoK5BfB34=;
        b=TWACE2JOojar0ICpa4uLmW12ALFrChmKaLnRkrmjC59bSgLMNW/ZfTQy5bnmcGEeov
         Fu3fdzTL3cSQD4U1NdOLbz1+l0GGCcbvS42CmAvu07O6I7kmOjq0WdvNA4YZbTXJz960
         Kr+mdJCnJzo6uEA+YIQa+/0rRWniCyMqerTsqjT/ddbN7CccefpPH31S+qVdIM21ETTQ
         7URYE63RU0Xo+SHL2/jZkmB43qMZtYdY9XsDSFXW7iCQf+bycBEkM86o7lBcXMFggH3Z
         CxNXRnci5eXcV+c2gSDgNNBwSscniNcTX9pfyxRx2zlosCaJ7tvUS84l23/4w62IxPFp
         pylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772653059; x=1773257859;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5y32mR6YkYWaR3orbX6cTWzoDxvktA7ezcoK5BfB34=;
        b=WxYJXhObNeir01JKJ0EWi7zazhbHiJ54X8Nm/pabNNWfC4E217Tjjqay+D7kocTawb
         Ciypb3TsfigNTd32PZxc00TEAb/R/1H5ccHrB7llhEmx8W0p97uCOHzd0WO9EfB5PFlO
         IQAYF9CeBMamhEMNf2Q3wTHVVlupgl7exD23/J/HtgKBbsvWaHlpgiIPhFFXTMvqb8LX
         Y/W752hbTjGC1bHf11Sod1OThRxcBBA/+yTulVgjy6mI2YNzPTHM1myBXnH3Ii20j74P
         2I6zjw90iTsWCe10q8bXxmkozbqIEaJwxgdoxtbdbp7yVfQ9BGjWCFq25wknIWxLxnV7
         M8GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRCf5UPpXUJKDo8IarsNAc8jTxJNoKugdD6vSDrPYY2Cm947qZL9SmRDBuC4IzhTAxuzuynvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+shmCp/5MbTyBXj/H6DoKsHqxduQ7FLshBIW+7XDqPigqXY9V
	OlG3uEoKos4Nw3Ede344gt2gQDAJSKxpJ4eSbUgt32n5u2Jf7Frn13k=
X-Gm-Gg: ATEYQzyRdGdsyp4VXkOc357MamslPxvLRPqpMlP5rtGo8BprkwD0/oG7N1JwyI5KU16
	OQjBE3eQsvOMiyuEo5HenVpU9MdWB4FwD9ONtiEiNhrdzv/PA/Eenod4kSx/Xqgrb8FGSQCgvsg
	F5WKQ0AKSMQdt9pKhPVTavoZW+taYOy/WcCsmk69G80bcj7rZXtAF6DfaWuHWu+E5srH0MiVu1Z
	S0Oddool8+7b9uKKKdnOxBudb6ndIdPTF+Yl8JepCIlji+eLtqAkYchbF2mwzkIneVDhsyOCUTr
	/veZq9AxLQGld5HiHujbbFT61LkVPg88lxpLPtTjeQaBxVdYP5NY9OYln/PAMFdEf8/aUJdXwLN
	dBsKyn47hFhX85C3suTQI5ibEcT9cl2J0meT3LTMgJxJSc1hi6T7Zg4Bdi9hgfLQc26ilXo1g3N
	lfyWs/xGWx3mlk+4dftc4DrZDg8tckT9nTJFFBYTnPrGa4lkaw3haacS2XSFAx/4AI7cxjVi1Z6
	g==
X-Received: by 2002:a05:600c:a087:b0:483:badb:618b with SMTP id 5b1f17b1804b1-4851988467amr52417485e9.24.1772653058811;
        Wed, 04 Mar 2026 11:37:38 -0800 (PST)
Received: from [192.168.1.3] (p5b057b4d.dip0.t-ipconnect.de. [91.5.123.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75b272sm43811476f8f.24.2026.03.04.11.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 11:37:38 -0800 (PST)
Message-ID: <89916194-2d0a-4adf-a095-5bdd685abf28@googlemail.com>
Date: Wed, 4 Mar 2026 20:37:37 +0100
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
From: Peter Schneider <pschneider1968@googlemail.com>
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
 <0be301c0-f9be-4d70-9fdb-7a260ccf83ac@googlemail.com>
In-Reply-To: <0be301c0-f9be-4d70-9fdb-7a260ccf83ac@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AD6C320725B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223131-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[peters-netzplatz.de:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,googlemail.com:dkim,googlemail.com:mid,mailvelope.com:url]
X-Rspamd-Action: no action

Am 04.03.2026 um 20:00 schrieb Peter Schneider:
> Am 04.03.2026 um 18:35 schrieb Aditya Garg:
>> Hi
>>
>> I found out that Linux kernel 6.12.75 failed to compiled in my automatic builds. The compiler throws the error:
>>
>> arch/x86/kernel/setup.c: In function 'ima_get_kexec_buffer':
>> arch/x86/kernel/setup.c:380:15: error: implicit declaration of function 'ima_validate_range' [-Werror=implicit- 
>> function-declaration]
>> 380 |         ret = ima_validate_range(ima_kexec_buffer_phys, ima_kexec_buffer_size);
>>      |               ^~~~~~~~~~~~~~~~~~
>> cc1: some warnings being treated as errors
>> make[7]: *** [scripts/Makefile.build:229: arch/x86/kernel/setup.o] Error 1
>> make[6]: *** [scripts/Makefile.build:466: arch/x86/kernel] Error 2
>> make[5]: *** [scripts/Makefile.build:466: arch/x86] Error 2
> 
> I already found and reported this in the RC cycle [1], and Sasha dropped it in -rc2 [2], and now in the release, it 
> obviously has, somewhat mysteriously, reappeared [3], affecting all of today's 6.x stable branch releases.
> 
> 
> [1] https://lore.kernel.org/stable/66461c13-1bb3-473c-b57f-adba9db4f756@googlemail.com/
> [2] https://lore.kernel.org/stable/a04b1aa6-ba46-4368-9dfe-6320a2dafa79@googlemail.com/
> [3] https://lore.kernel.org/stable/c435a3c6-5952-453f-9e50-31e0c6cdd09f@googlemail.com/


I have to correct myself: the last two I screwed up myself by doing stupid things in the wrong directory 🙁

Sorry for the noise!

So 6.18.16 and 6.19.6 are fine, only 6.1.165, 6.6.128 and 6.12.75 are still affected.


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


