Return-Path: <stable+bounces-226898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OHWEAu3uWnJMQIAu9opvQ
	(envelope-from <stable+bounces-226898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 21:18:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A592B223B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 21:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9AD5312AA9B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 20:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C1E3803D9;
	Tue, 17 Mar 2026 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MOHhk60/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCF737F001
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773778376; cv=none; b=tQGqhHF3CP9Mf9sShdONxsRVQLMHsDPBuR2W6Wbtu34uNxYoQnuLyerrkbHmp1YGU8yxklgJzHsGGcphr9liFI6KJykI9LhQEhPEd48SNjCyS90jE+1yyBgL2+YNfnbsX8awdAqAT42gkc983DUt7wAxX2ni7u3c2bWLS+1MDSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773778376; c=relaxed/simple;
	bh=piiAGQho5DhZnDh4IuAy/qJ4Nw649GjoEt4P6sGvWt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dc2HxopbHRNLtY8OwjdYtgZ4mythmIMEMFDoRLbEZ9spSC+mwL9Zrd8fQUj/s5UEq2cxxIdUrV6LF1BP9OZs/32PO9zvHnYrJsq6TgTqjS6B+QMBwNajY9egNQO6p4HHA9heCZRpMvCaFwJEzEhpAeAj3x5asyHn9bX473kuv9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=MOHhk60/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso70171975e9.0
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 13:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1773778373; x=1774383173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=65oPjytHzpcYnHZINKta7EHM9RxuvM6iBbGC2oDe7NM=;
        b=MOHhk60/c97Wq8xLe+78uNK7QZCtsGZFlF6eB2CNyH1AvtYerdv5FgiMSTrVSeEVNM
         RBUPjdcyNdQsropbIn+YpGb/udQLyJZq9q3PEd44SmVWvoK6/rRSl7piDIaIQhdReg2p
         l2n3LEIYCMWKYF31Z1Poh6YBtYasYkqoDzsbxsEiVl8EtpbVL+6jewrZqvdT5KzKwdgX
         +vLxXd8kchTi9VZx6L3XxB6KgEXgACVfN+hWwXRuN+CGeaKiNRgrJkFPgi0nWl1igcS3
         +D8iaJgwZ3aNyh3EAk/EkHfQBlxWyyx44uCQM2L2AerzxPk8VdSXJdP9g/wh3lizaxcK
         JOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773778373; x=1774383173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65oPjytHzpcYnHZINKta7EHM9RxuvM6iBbGC2oDe7NM=;
        b=fT13McxBhZK5CK2HrImVFfzZIFOjlVeUa0jQ1IANJgTWxUiAasrnptgyVJmssb6RLU
         h3iXZksM8/smjN+47gPWBs1O4zD+wg8wq/OdOdNVyHDL/pSYh6/kzpqQ4/QbhjOHBili
         tEA7l9bkmX7r2nYklmo87hMi/ll2VsPFZbSqXQdZZqx+K3b0/+NtI1WZv6wOaLbj6fCT
         rAkPKdVr3n6IvC2Zwp1nEjaYQc8DWyhnpyiHVQn4WSg1ieYvaLnBWlT6akpkVbsofnry
         UzFOuHSVY5nAvCOvkKiYRWkU7QLPN1HPCnWbtITuc7PKSHI3LlldAFH6savWJAk0XWUN
         mVOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgu9juhqGn+44jKLzlHtWBXln7o39sPCiGW65+TK1598dNWTyjJhwFpfdc4mGgpypXsDGT0Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRAVPq0QuZzClVc2Tkwnu3N49CE73xfvE07spS9hXvE7VCXJEG
	Wx14emBMIgL1shF2SnzQYRbXiklmpYEzD+uaD09pfE2dkRqv8jh6pgI=
X-Gm-Gg: ATEYQzy3q7AWBIYCD37e2mE1VlXDFAxNW7hEvT0amfl/TlldsUUxwgWtXU1WQZPKlsR
	bCmJjejQTMx6QDcEg1A2VEkSacyEnTMO6t58hGFe3+BhKF/yAqHVrQ0vQl0ITqCNuxxCk7wtfIe
	EckLv3psyxlGJ4oNx4vfJlDjBLhZ+rxUAs+Fs9hwn13bEMf7ViPpmAfPJJazzZ83O/cDNIidd5F
	hAKbEQON0EryAzxgFBFedlZqNDoJM6LdrRlcmsi8C2yMUIeRQsLdjmb2ejQ8iH5NNlbHUzRCES0
	Mx2bLm9OHvwA4V35pqyVmD9Aex1O/OFBejGE2nuJlqVwohBMM6IrxfKFLp+cL5zrMUIkMT+m+vB
	PKd7hCr9ezJNjYqj3lo4bd4uKsKLw+k6wglWa7Rawzr+pJK4OVZA+XKSTVFJQmn7W0+T/ZqMLeD
	FjKinqvS43DCJEgd0/OscZePx/koDX+ccX07iNnx30Tlu0vxXuVxmPBI3ctntZcZQWPmMy70xG8
	Q==
X-Received: by 2002:a05:600c:4685:b0:485:40c6:f507 with SMTP id 5b1f17b1804b1-486f456feb6mr15233915e9.30.1773778372308;
        Tue, 17 Mar 2026 13:12:52 -0700 (PDT)
Received: from [192.168.1.3] (p5b05714c.dip0.t-ipconnect.de. [91.5.113.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8fad1sm157753265e9.1.2026.03.17.13.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 13:12:51 -0700 (PDT)
Message-ID: <1be99aaa-8a25-4556-a59f-6e33b7ac258a@googlemail.com>
Date: Tue, 17 Mar 2026 21:12:49 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.19 000/378] 6.19.9-rc1 review
To: Ronald Warsow <rwarsow@gmx.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260317163006.959177102@linuxfoundation.org>
 <10df8843-67e6-4830-955c-befc783f25df@gmx.de>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <10df8843-67e6-4830-955c-befc783f25df@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226898-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,peters-netzplatz.de:url,googlemail.com:dkim,googlemail.com:mid,mailvelope.com:url,gmx.de:email]
X-Rspamd-Queue-Id: E3A592B223B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 17.03.2026 um 18:47 schrieb Ronald Warsow:
> Hi
> 
> compile runs in an error:
> 
>    LD      vmlinux.unstripped
>    BTFIDS  vmlinux.unstripped
> WARN: resolve_btfids: unresolved symbol kthread_exit
> make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
> make[2]: *** Deleting file 'vmlinux.unstripped'
> make[1]: *** [/home/DATA/DEVEL/linux/Makefile:1277: vmlinux] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
> 
> 
> if I do:
> 
> git revert f5ee297b23d843d4ae690595aa29e8f5baeaecf9 --no-edit
> 
> see:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/? 
> h=linux-6.19.y&id=f5ee297b23d843d4ae690595aa29e8f5baeaecf9
> 
> 
> 
> all is fine here on x86_64 (Intel 11th Gen. CPU)
> 
> Thanks
> 
> Tested-by: Ronald Warsow <rwarsow@gmx.de>


I can confirm Ronald's finding. I see the same error on my 2-socket Ivy Bridge Xeon E5-2697 v2 server, and the same 
revert helps.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


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

