Return-Path: <stable+bounces-246705-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIirHjq4A2rj9QEAu9opvQ
	(envelope-from <stable+bounces-246705-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 01:31:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2D252B4D7
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 01:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 634A63045284
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 23:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487213655EE;
	Tue, 12 May 2026 23:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="iP+B+0cM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3AE25B0BE
	for <stable@vger.kernel.org>; Tue, 12 May 2026 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778628664; cv=none; b=HA5E22ceRonXFjuhh8M0uB7j8vussMxuKYVCWUGlFz19cSywTfQCvNu3IpdGM11Mod+PuuYOqM/jccxHqXGdS0mb5xpBvIIyf8si4LhAvts30kZELZ0qzMS5AGTKCfoeNrIib1izuqGM1MvtI0jP+oM3hVMrzD3r3sDmG6xrD8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778628664; c=relaxed/simple;
	bh=FyFKajl5L7V5+XAy0wD39pUFnzZ9XNW279qkg2Ja/78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5pTip85hQJ7TvppQPRJmorgoyYxuRKsAZQxHVbI1yC4xZC+/PWG28buihdqo8BSmXQ/PGk8ObkC2nkxbyg47hVMADR8ex0zyG0fzVpNi6u93+bY63gqTNbUVXgVMgc/RgWuYNL/F46TxD37izYTpjmA4jU82Enfd0/lV6XE7ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=iP+B+0cM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488d2079582so64034505e9.2
        for <stable@vger.kernel.org>; Tue, 12 May 2026 16:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1778628661; x=1779233461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qJWZbO9K9VNLteCi7nQZ8KhPP31M2G8iC8LnNx4jfJw=;
        b=iP+B+0cMGsXxwRKh+i44QK+DnE/P0ACKDM+j/MfUcF/B5A/eksqkz3SumgLBvmT/5y
         beomkl94YtvLivTZ9BtL9bHCtjfmP/qxrieWX2CmI2Pf5+tbAJNz+DL8vq5dc7BnvKsD
         bwULwgSwb0jI0H32lVqIMaIHJCKoDtvczQdQ4Z6p5wFG4WVfbrxCGaRA+waG6F8w37qZ
         /900iKPP8vMA8KNxSp+5FTAG51yaB6mVW8hqcubHRyTqMazZk5pMuyxCE0EEl1oJ2fdo
         kPyTXrm0KksomBnvPYXIYKm3OVDbu3mY29i89Ec9kRWHvdhonjXU1pDEAMwhDuWxlGxD
         YqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778628661; x=1779233461;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qJWZbO9K9VNLteCi7nQZ8KhPP31M2G8iC8LnNx4jfJw=;
        b=jIIytiB7ahzT19OrQwnmyKAWgQn9NpYjap8cO0fJH5veE22+SxZYlVPMKNroRqzlWE
         Gaa/SLhGf+lZtWHxzIMgF5MdFytDPrbppM2MDX7XphKMsyHVZKjWm78UK7MWcubXA316
         fSGlnfwisIs7jGHQZM1aSkmp0t66Enpf8D/R+7bIbGUEKPbhYxu2A+0fRpALc9Knpnpq
         /3P8MTkHEkmKXUIBzAlxzP50PNMQWkkH391+sYdMhNa5ctIBRtgmSL2NzYLUgQncCzsi
         7S4uZnj1sIW3Uc2ClQa/V38e5WTzwyiLQLIEhDMP1qZQt9EpFxZFVQS6qqgR+JRM2On2
         dP6g==
X-Forwarded-Encrypted: i=1; AFNElJ+1rw2J9QKw816UTi6IOhBxLTjZPBF/rDoSj3Fq19cOx/twUuVPGCiEcPhOHC5dEY1shRtLGXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY0UVQmPyDLUiQJ1eN0A8ZFF7Sih6NW+/PA6oib5XT4IUkyPHB
	gJ+f4slN7bC+bmXmFvEzEzh/yq0GidCvgetlbOLl3LQHuMB+KnMjboQ=
X-Gm-Gg: Acq92OE9LPz1dtBTg1keSBPagQds6rE2S5YYxy5mx0MlwkXd1bKMD/mrlcmaw71PIjU
	DSkkeMuQAUqzyjDCnPGad1UsAmzgFClFCM3d7OpldX7oqQHbTa/M/YXuOBtwi4kwfCYI33ZWfb8
	FwRO3kaRcthn64GFB4mhRN92o1fJax0OszBFYLbFCyWjNVJ/sVxIppqnvduq8hTX+qbPbhlCTcA
	iqZ1sOWREre0gq2aEfY8pYeQkAHOr6wbhUYx4WZ9oPIw8xgSf6Bht8a+JrMXa2menmpRsNaEMjC
	yX3UwkP/F4GXDg8xw10X4bNdYgmRq3om3ZpllDl3BvimStdc+zXxmehsvDRjcheVtejs1b3Hb+4
	JZU9y9CaJiurNHvDzrX1VfjAETgMakyrmN+NBfViqEfGWIqKGW1CI4jZwzCGdcTjQE4epQEuZ5r
	k5/wPCREPE44iGRBfrprg9KBBJh4xbjjN+nd0P1zP7Ey8FCyTM7SXHUi7aKZXDbm4UR0rCZaNE+
	vf3rbBgv9/+8g==
X-Received: by 2002:a05:600c:19cd:b0:48f:be94:d82c with SMTP id 5b1f17b1804b1-48fce9e1a34mr2332915e9.19.1778628661121;
        Tue, 12 May 2026 16:31:01 -0700 (PDT)
Received: from [192.168.1.3] (p5b05786a.dip0.t-ipconnect.de. [91.5.120.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fce05f41csm10297535e9.5.2026.05.12.16.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 16:31:00 -0700 (PDT)
Message-ID: <90116a48-a75d-48c9-b09f-97f541c0031c@googlemail.com>
Date: Wed, 13 May 2026 01:31:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 7.0 000/307] 7.0.7-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com, Tejun Heo <tj@kernel.org>,
 Andrea Righi <arighi@nvidia.com>
References: <20260512173940.117428952@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1D2D252B4D7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[googlemail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[googlemail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246705-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[googlemail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pschneider1968@googlemail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[googlemail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,googlemail.com:mid,googlemail.com:dkim,linus:email,peters-netzplatz.de:url]
X-Rspamd-Action: no action

Hi Greg,

Am 12.05.2026 um 19:36 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 7.0.7 release.
> There are 307 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Trying to build 7.0.7-rc1, I get this build error.

In file included from kernel/sched/build_policy.c:62:
kernel/sched/ext.c: In function ‘bypass_lb_cpu’:
kernel/sched/ext.c:4019:35: error: ‘donor_rq’ undeclared (first use in this function); did you mean ‘donee_rq’?
  4019 |                 if (task_rq(p) != donor_rq)
       |                                   ^~~~~~~~
       |                                   donee_rq
kernel/sched/ext.c:4019:35: note: each undeclared identifier is reported only once for each function it appears in
make[4]: *** [scripts/Makefile.build:289: kernel/sched/build_policy.o] Fehler 1
make[3]: *** [scripts/Makefile.build:548: kernel/sched] Fehler 2
make[2]: *** [scripts/Makefile.build:548: kernel] Fehler 2
make[1]: *** [/usr/src/linux-stable-rc/Makefile:2108: .] Fehler 2
make: *** [Makefile:248: __sub-make] Fehler 2
root@linus:/usr/src/linux-stable-rc#

The offending line seems to be part of eb5b997dadc517 (sched_ext: Skip tasks with stale task_rq in bypass_lb_cpu())
Adding Tejun and Andrea to CC.


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

