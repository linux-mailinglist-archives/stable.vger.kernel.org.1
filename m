Return-Path: <stable+bounces-249016-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLzBK2mlCGrezQMAu9opvQ
	(envelope-from <stable+bounces-249016-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 19:12:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1190B55CC96
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 19:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD45B301429A
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 17:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426DB3E5A15;
	Sat, 16 May 2026 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YsuniPda"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F103ED5B2
	for <stable@vger.kernel.org>; Sat, 16 May 2026 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778951513; cv=none; b=GoKvnDZAgRoVJJPaECQBNM09+hwyXczol1jUywANiZXoVRWYF1wAX5jATMumdRKmbuKXR7eqJa/Ymqr6mneywWOkZ1U09xJi/8CwXH0qLsubuzaWjZazbkRWkclKQ5Mubkzn6YknqFvkFA4n6459thpCiG9WJV+fuWgJ8awYvgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778951513; c=relaxed/simple;
	bh=oX33zzrhzx2wnBTO434znlc7XiOBQWwh4mIrmCX2a+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXeROQZRYhiIbWzURkqqAa81VTNTUN0Fn23sbxW6Nv5XOQqrFkmcN/HDHHNveMxjWannny17qdSmuoIog3D6xJyMlDhKhfCQjaJgDI1jzju9t4cTiWCvQMaDTLLKZfQVOFyAYqCsB+bGwdPs+c/uekmxbJcYS4I9XOYrrUkHhdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=YsuniPda; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so4331185e9.3
        for <stable@vger.kernel.org>; Sat, 16 May 2026 10:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1778951507; x=1779556307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=daDGZ35CtqHe++jeBQ8nOe5orQydlheCaV35Ow+XAS4=;
        b=YsuniPdaMM/6dHYCUKTm0JBKRU8QH2eYZ9t7gtBzKTpJlpL4Z8bbVcSSp3IBwk0c9C
         ysNGJpfDi5AMWFtwMBpF+86NU8jv2nSmWMLhkVTA3yMvUkFdqfsXIEEwb+dTvZa4kT3a
         dpXzqtOs+9oFfAjfBMUHMIILE73CQGzSv8NsBzlVvajCcJwirZ0a+gYrB7NIOMDk7kCe
         f4U2JkRn+iyR8Mh+BpuHm4qkqc5NKJPQLy3znecZNwMnNIlmF37F6Z35HtTaS38iYiCV
         hbl3uaCHoBdbLkG11Q34uARweP871r8GMzeWNtju+7/lJSu2TZnCYnPQQ+wd3Rdy/hj+
         4uOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778951507; x=1779556307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=daDGZ35CtqHe++jeBQ8nOe5orQydlheCaV35Ow+XAS4=;
        b=S+IEx+bCZDj72/gLKyFK7cpj7UPfb5LqpTom0QmdZ2Wey7ATFPySxDM5mA/XmM8BNP
         ZJB12Q6IEMAU5zb4QBXY7NcQK16ARFUIRe5ycGDuIYhHtRKZ5JgHuM+BiDzROD0ui+dB
         GIRnEIKiSPxFDtGaV0QTnHZ1hyt6U/dKVoSsXxc1Iut0sGP7X2XJ/rb9Z1uQjiEmx+4k
         9yMm98crLYLUgechVOInoYvChOudLZn5UkiubNXA6T77svslotqb3mAnVdPnP7aIOJEi
         dH0AsZsyK8/vX7fdH6LbeT+wKlOhfg9EvAiqZ539pj+cye6hR613FbDE4TJfgAu5uMlM
         booA==
X-Forwarded-Encrypted: i=1; AFNElJ8ToFnCLNVuP8Lh4VEdaTjs333mcGlJiX+F/yi9S4hmg4fL86TwuM0LR7i/kBovjFK5DT6QszI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSbjxJcWBBS84u9IwskhwBiiArceZMTWvjo0EEuTxNSMGkoxrs
	KQOrVn/huBnDP8JMci/Ya4xs+i+uV/CkvR6cVFhRM9s2W/BarJSogDo=
X-Gm-Gg: Acq92OFB3JBrKW56Zs+JHPWk3n2igTVnmYhg7T9lnnlRyMBE9aueGtJdWffggGnO0CR
	PdYW/bmLOusaSrx9XjITYhOYou9TyeazZ3bRFZLfdpvkrHjuXx+GU/rewr3YUFht4hC0ZUkW1EB
	ySkEC4yDbCW/OGQOvZZEUgm7/NLuwxyZXXJGOpqqZsolM04aIcGzJtTWzeDLYn2NWPEkKtDpB4b
	oEb/1KWi2MTpdUHbtIKciRGYe7BX+TyywlLd4fI3Kx1zer4tqHr5TzTOlyXDy3SnunHZr/0sypS
	0s2JmaNJJ1iT4NsdcgKxF73XShnQycwPBDpCxec60+vCntGencn/uy++N4m8GCEFuHvFiRs/3Rk
	f5g/O2J+9hVnK2JdHY1pWG4up004GSgvjPKHnxD+Zgocm7/U6D5cUXOc0BlgeC2P94LMPU9788T
	FhEo46tJbqox/m+7OiCFOi9wmKI0jlcwrSn1SP1U18XjWSjHVn3kjMnkydSUHGazFxE7aTG7Xfa
	Hk=
X-Received: by 2002:a05:600c:a00f:b0:48a:5301:bb5c with SMTP id 5b1f17b1804b1-48fe63263dfmr124480665e9.16.1778951506303;
        Sat, 16 May 2026 10:11:46 -0700 (PDT)
Received: from [192.168.1.3] (p5b2b4b92.dip0.t-ipconnect.de. [91.43.75.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febf81970sm56216295e9.8.2026.05.16.10.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 10:11:45 -0700 (PDT)
Message-ID: <a56911f8-9c02-464e-b61c-0d565a5dbd43@googlemail.com>
Date: Sat, 16 May 2026 19:11:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/144] 6.12.90-rc1 review
To: Greg KH <gregkh@linuxfoundation.org>,
 Wentao Guan <guanwentao@uniontech.com>
Cc: achill@achill.org, akpm@linux-foundation.org, broonie@kernel.org,
 conor@kernel.org, f.fainelli@gmail.com, hargar@microsoft.com,
 jonathanh@nvidia.com, linux-kernel@vger.kernel.org, linux@roeck-us.net,
 lkft-triage@lists.linaro.org, patches@kernelci.org, patches@lists.linux.dev,
 pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com,
 stable@vger.kernel.org, sudipm.mukherjee@gmail.com,
 torvalds@linux-foundation.org
References: <20260515154653.469907118@linuxfoundation.org>
 <20260515190713.620177-1-guanwentao@uniontech.com>
 <2026051658-affront-uplifting-095b@gregkh>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <2026051658-affront-uplifting-095b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1190B55CC96
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249016-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlemail.com:mid,googlemail.com:dkim,suse.cz:email,mailvelope.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Am 16.05.2026 um 12:09 schrieb Greg KH:
> On Sat, May 16, 2026 at 03:07:14AM +0800, Wentao Guan wrote:
>> Build failed, you can drop the commit to build ok, same as 6.18.30-rc1:
>> git revert 14d9ce90cf4855d638ecbcdb0c208a144d6f991b..
>> Revert "sched_ext: Use HK_TYPE_DOMAIN_BOOT to detect isolcpus= domain isolation"
>>
>> Tested-by: Wentao Guan <guanwentao@uniontech.com>
>>
>> BRs
>> Wentao Guan
>>
>> defconfigs:
>> https://gist.github.com/opsiff/a840ae9e3d6857f5b7bacb9cdc49f8e9
>>
>> Log:
>> In file included from kernel/sched/build_policy.c:63:
>> kernel/sched/ext.c: In function ‘scx_ops_enable’:
>> kernel/sched/ext.c:5524:34: error: ‘HK_TYPE_DOMAIN_BOOT’ undeclared (first use in this function); did you mean ‘HK_TYPE_DOMAIN’?
>>   5524 |         if (housekeeping_enabled(HK_TYPE_DOMAIN_BOOT)) {
>>        |                                  ^~~~~~~~~~~~~~~~~~~
>>        |                                  HK_TYPE_DOMAIN
>>
>> missed HK_TYPE_DOMAIN_BOOT is introduced in this commit:
>>
>> commit 4fca0e550d506e1c95504c2d9247bc92bf621bf6
>> Author: Frederic Weisbecker <frederic@kernel.org>
>> Date:   Mon May 26 13:06:21 2025 +0200
>>
>>      sched/isolation: Save boot defined domain flags
>>
>>      HK_TYPE_DOMAIN will soon integrate not only boot defined isolcpus= CPUs
>>      but also cpuset isolated partitions.
>>
>>      Housekeeping still needs a way to record what was initially passed
>>      to isolcpus= in order to keep these CPUs isolated after a cpuset
>>      isolated partition is modified or destroyed while containing some of
>>      them.
>>
>>      Create a new HK_TYPE_DOMAIN_BOOT to keep track of those.
>>
>>      Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>      Reviewed-by: Phil Auld <pauld@redhat.com>
>>      Reviewed-by: Waiman Long <longman@redhat.com>
>>      Cc: Ingo Molnar <mingo@redhat.com>
>>      Cc: Marco Crivellari <marco.crivellari@suse.com>
>>      Cc: Michal Hocko <mhocko@suse.com>
>>      Cc: Peter Zijlstra <peterz@infradead.org>
>>      Cc: Tejun Heo <tj@kernel.org>
>>      Cc: Thomas Gleixner <tglx@linutronix.de>
>>      Cc: Vlastimil Babka <vbabka@suse.cz>
>>      Cc: Waiman Long <longman@redhat.com>
>>
> 
> Also dropped from here, thanks.  My fault, I should have only backported
> this to 7.0.y as the commit itself said to.
> 
> greg k-h


Now I really wonder why I didn't hit this build error with that patch included in 6.12.90-rc1...
Because I hit it in 6.18.32-rc!

Let me check my .config ...

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

