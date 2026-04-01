Return-Path: <stable+bounces-232759-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBVTLkr/zGnRYgYAu9opvQ
	(envelope-from <stable+bounces-232759-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 13:19:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EE1379424
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 13:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 965BB303C293
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 11:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FEA43D0903;
	Wed,  1 Apr 2026 11:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="A33Hs1VS"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ABF3CCA0C
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042073; cv=pass; b=VPzZuIAkCY0VfH1utIsXvrs8AUQN33fGPrwWDG7MS/AYzPfX2d4QuQqT9TPyKoe6YPFRiX06YERoGS8rGR1qn7bknxBqX9c7Mt3CnWLetk+99f1gkWHxzO5PSr5xZ+qXo+IKHlBhOtVVqwnrIvkynH35BEstdMEF4leiHubKQng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042073; c=relaxed/simple;
	bh=pc5H36RuEHckCC4rxZiHAV25J1O0MfCUQosX2L+946Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZp6wsIotQkvsh5tBkZxarmKkka4kI0+A+OvYzzcs7IucDvvcZcEI/9SGo+ZOJcRqUVT0PUItQz8Zelfz/PlWek+s6O3eeM6MDAF0YdnaIcHYa8hxZkgWUxm0Rv94CWe6qIy2tHOXPxAa8QU+20iqz4yjAxFlBKidWv3udMr5Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=A33Hs1VS; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-128ebee22caso393573c88.0
        for <stable@vger.kernel.org>; Wed, 01 Apr 2026 04:14:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775042071; cv=none;
        d=google.com; s=arc-20240605;
        b=Qv6feF5eJhaxIj/09471prDqGf/Ycbbt5kw8M7LG7zLfd7OO3N+2i6z7/OWyYLyhT9
         57HLFBy0Ons1QFhljwGByasbonfRAMpqmYEEjL903ForAL/H3yOgoRyXGtV/CaBgZhOt
         U8Nt0oukTMRLk7NhiyAjD93JgbBCq8SUngtXSnBfXIqSBl6aT2u6Yor4kOWmSsoc0eyj
         PAkcZ2EJy6W6wO4OeVRnYrg4grnFj2CPc2rYTiXqoKpKsITDOAHaGQUFPFXN+bOIgXzA
         f4aaGZ8FYUqStIuLNpU2nR56S4b6PnD7EOK3BTBzf3Ge2nevQ5VsBR0Nuqi/KkipAG+V
         q3eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tZhdqGF0+1HrQa1yHew2N2aXTxqOA/y8rCZpynRhAAg=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=END9Qe6McDrb58ch24Wa4Xah1tGOe6M1YB23ByKS0vyiBC4nrxs3BCNRmonUnSzH/P
         67U2MOFaKCq9PMSgUatVgNDxCM7tAF1ukS4yT30NFZ6AAm3UcLONvHJCRu5p8TcQELbz
         TsV4SmjczJKWmOf+FNCrR2zoswTnWbCbee32tbw1/3XqOaDhkVXadMOmQqwdFPXOrT0b
         i4YZe8/hvReIaRe9jmO6y9P9cbjZQAXNN28pW5oyDstkQtftaBDyPR1Lt8b70ZiHEP+z
         zPBkId0oOeswYwpFY8GT03JhBp2igBd5FBenq/KS4shD3MwG+ffDqEmhzTyUbG/qdgIs
         iRZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1775042071; x=1775646871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZhdqGF0+1HrQa1yHew2N2aXTxqOA/y8rCZpynRhAAg=;
        b=A33Hs1VS9/6RamNSOgPiVIxm4WT+VlyN3M0k2wkkIbeOV45zZ9Jm76kh7YQdJ5Wr37
         s05nQkcccAIaqtP6yUYxlzsKFT885Fr1cXLWBMryKWeFQowjliX1717dj26EuNid73TL
         CJ7Oe3iJDPc66utYgHGJ0Y2M1aufd1WpF+Y4ZcDlSaWM9DZIjlGjKCAM7kAb73SQ6RIQ
         +PkptlRRiLezigGvIjQUCNoF1dC3llX6uML3S6aC7TaE+/IUIBJx/w8yvsqah2EAjRRJ
         pZVLoyDvw/ZhmiyR1OVYk4IG+sOxLNoak9CuvHRUqEByz8R4xNUwMlD3nZtEDFLA3cFb
         6/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775042071; x=1775646871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tZhdqGF0+1HrQa1yHew2N2aXTxqOA/y8rCZpynRhAAg=;
        b=WzTDdokW7ptHiXCxn0oXy/0OZTHeDMEivRw9ZuVk4hcgff1s56HdBjPkfBlKYTel5K
         9Jh3LezUkbR7lm2Ba34fZSrMuN2z4WH7b5BxOqF6lh9+uHfKK2AVwDMFDGCdBnylqB9e
         fCDVP4g6dbVb1dZ4TRbE4DoD3dD4U80jJ85slyBjN+eLY6QW3VUGPsmYe8TIuQfvt3Vy
         +wUPyFhWM1cmEclBfXMS3w80GugbRdtFiskN9fnt23KTlbmy5y3/r9MlFw4IeD+Rzqyt
         evIEl8u5nnObqFYTd1vT+HAPEJowTmU9vYDZRUqu5XRSDfCWG9fam2UrqnKJ3VIfv/PP
         Wg4w==
X-Gm-Message-State: AOJu0YxE25TwFQx4u7YdPgJEwaQnoEqRI42pREfdKd2AJFMPtzGqSP4G
	VoJgSOr3kPeygcfgNxxgUs6T8HEnphTRVMR7xkB5YUjEhA0wLFabITg/4vygLi+1zRBBfKXEGg3
	uq2vrPppsBIYnHNPorw7KMeIuQVHl4e5nS33Z0SD/FQ==
X-Gm-Gg: ATEYQzwUn35N6jh2KeKTvwxkLTs7WOuVbyzMD/W6IsFZi4m8yBobdcl0EzrsIg8eS7f
	esZyH9LHOwcarv2Jmx54IjGOHjckGWzd28HyfWZtjh5l+RqJrfWgrRivvaalRbr9yvJ7oaYL9R+
	0UzcLlARKNFnkN+aHffe2sv+qKT2ud4UEz2YzDoMqrC/dyE3zk+ED7uRxW0bhaN038PguSffn3v
	TIJs68y4QxY7niv6aqerAANejQ7NSXGW0U0K2fG+GaI/UX2/1rMXjqRiF8j+OeEmQvKLsL2fVRr
	UhfcHwf7
X-Received: by 2002:a05:7022:6720:b0:11b:b179:6e17 with SMTP id
 a92af1059eb24-12be65988efmr1913619c88.34.1775042070889; Wed, 01 Apr 2026
 04:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331161758.909578033@linuxfoundation.org>
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 1 Apr 2026 20:14:14 +0900
X-Gm-Features: AQROBzCcWjpIDbqMiVDnMHwjdZ3Du7329NtkcMVFmn20aZQ4M0bdNteoauZCp2s
Message-ID: <CAKL4bV6wXdd-FRft9p69+LDNfw6=yarXgRAmNVZTE6PYLW0kNA@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/342] 6.19.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[futuring-girl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232759-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takeshi.ogasawara@futuring-girl.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[futuring-girl.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,mail.gmail.com:mid,thinkpadx1gen10j0764:email]
X-Rspamd-Queue-Id: 17EE1379424
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg

On Wed, Apr 1, 2026 at 2:01=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.11 release.
> There are 342 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Apr 2026 16:16:56 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.19.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.19.11-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.19.11-rc1rv-g411f8a553ae8
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20260209, GNU ld (GNU
Binutils) 2.46) #1 SMP PREEMPT_DYNAMIC Wed Apr  1 19:21:05 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

