Return-Path: <stable+bounces-241000-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFBuC0GY62m7OgAAu9opvQ
	(envelope-from <stable+bounces-241000-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 18:20:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3B8461407
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 18:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FAC9300A398
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 16:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B3A3DF00B;
	Fri, 24 Apr 2026 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="pqWG63bx"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213033D905C
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777047611; cv=pass; b=Ara9xP9ywwcA4pt8a7hfmH2CjDfPr10lbfeqTCXVWdWlXwoPni4tSUrnWPIQPEM0JVBlgtuJBuWPoTNP4e66DRNJ13xWQ2T2jN2ae6qfTWHxxpBofjiQvgTM9coihG2YkJy8dzpzuhCHLlgi8BuUMBUIi1QObqRWq6VAEZHzEnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777047611; c=relaxed/simple;
	bh=uAHtlsVN96Sq+N4GugntRyO6Yy2LIY7UXKYaV91ExO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkzVFfXcK+kMr/Q930xCwrH8XglPmLE0Dr8TO/QqohVtbXRl2u2Y8/+mmtPn2O/rmURFEOlI1ksBcytwCbf/dRh0fuOS/lsV+Daha9EgviGiuyTnic9nDk25rKrH8umk21CjeAevz0MeYfOM5UfNlseijikOe3d+p5cu7S5uG3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=pqWG63bx; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c79506f3c40so2948825a12.1
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 09:20:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777047609; cv=none;
        d=google.com; s=arc-20240605;
        b=DKPTWJKqOAW3IC2PpzuL8v8wj6K+Mn/g3oIYAigfqBZKrmj43NBIM5fUIuJNqUue1F
         oyst1F4md7GtF7XXTqncjuDnBHRpCLChqvWza6YwTAS9bZFzukymm3djG8bb4ZxM84D+
         5A6qxQQ/tJxYwhD0xVjIanjftsFNtucOW6zCvJ7/WexDjZXo6GWH9kMk9emq/rJyqRQN
         FPfBGRQPuFVF0TCe9bVj2X+NdUEYHYBqxpWfMYZxCH3+XnWkWrHGLuxFA8NM/upX+vYo
         2uoQnUL7oF4wwCuCkQYQO1jVWD7S13HsiF05K8pVu+2+QsJ63AxBQO1JHidZVOCMLfYO
         I+GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QesipSYB2lynBtk6mNpF2Ov2dBclRS4CJkeDY60ZVB0=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=h22PKjR3/WeQSN06QiJ1ro8Gzdt7Tu5berR0S7CuZQYeycd65s0ruFXB+fqe5cJCpZ
         VswdiTBH7w6+VA+qsul/0HpElZewLAOgWLia+bqIUS2o1Ham73Y5YrRmgtl74Ge6V6G8
         aNueuirOekVUIcK4H0CYG4pPbb0YGN8fHipj6rYdwXuKg1ESjh4+7MZ5PrXPeJ8+g3J4
         V750syWYDN9mf55JQ8mUq/GIZ1FfDY4URBvxsNikd0CK//y8Htf5q1+prZ1xABz6U5GS
         JdTdk7bhwQm8XT2r1/zcvEI/iMJvOe9NHrYjwXJhfhQeljugIhgbOJcULuqyWl03RBK0
         dKeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1777047609; x=1777652409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QesipSYB2lynBtk6mNpF2Ov2dBclRS4CJkeDY60ZVB0=;
        b=pqWG63bxuG8G2abyqe53CyzrhuxRGXjMLzAWE5x/LxINgnlev80gh9+2n8NPOeziWZ
         q7pJn03Z7eh/FDKBZ3UvyhONN3Y9mVwSC5TdVTcotCMTHjuun8qR5ub9HdgbtRNn0lWb
         q1pMykfHUpGobIBY2oGND7lFZYMn6lwv7rpwBbm5YmjeQIVofZ9Z3/LAEVhlVcSggxWP
         nMqGB62rwwa5Fdtp+aoZ2WzU+sjbbawc0GM7JEcz8h/wJ0cfyF+jFJ+a0UEkf0FK7N7E
         0exuCnEs1W3VM5nL2cfjyNqITzykrFMPmF6tQ9Sf8u4DyUro5l+JXYBtwXg/+8ls3q4q
         ntrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777047609; x=1777652409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QesipSYB2lynBtk6mNpF2Ov2dBclRS4CJkeDY60ZVB0=;
        b=moYwwfWL9XUKih1uVOQotDRo/gUS3ojrrZs7neWwFsL/9WYx29xwCuKhE/8jbDMaBI
         Dx/fVjEV1D9ZkLtPdO/AqVT5IsJyKyQ6EilOHxSc2w6zDZ6TKJhJ3XGAmTsGqM3q8PP+
         9l1fZhEceY3kZjgjxxXCUehjUUfCmVsy5ECgSLd9MSg21s7qfH2gcTn/TBuFaPXgyjo6
         3YmkOtUZ4RUSUdqyUpCYDDZZZPKz/1VcxLa+H1NBV5YvpLPxYb2VURMgkNBS7a4eeyXI
         XtJQDhW2cr6JAQxC0Uy3Yi/fUrAIt2vNFTVM6MxbWST21ynaPGwA8LvFy3FgwnOju6Pl
         27Gw==
X-Gm-Message-State: AOJu0YwyVRTqMCPMGC8EQ5CkzdAXYriNjjoZtwYlDDi8Pyrd/g44B6vB
	zmnx5JDDTTiq3I4xhLXCXz+7H156e/HecKBYeDyXgqubdjqvvllU8PqpasKr0ZEtld494ISSBeW
	CyJfJpGH1yfU05C6OrWqkNmiA2S6S6g6hhOBAiBQGkw==
X-Gm-Gg: AeBDiesi8hBeiTvq882PiSb8x/jKEIb6Av12Cex8S6j9MRTvfvEDe5Yc3tuwO/kV3xT
	lTnuYzK6Q/hrVsOEM59fUUsOkvS1oYuUivYsIYH3jSpZLeZZd1JsE/2WzeMQS0ciAld5iT+xyGK
	k9LhH1GDRWoWYo0RBPYZgy6RHFjvwXD6b/x/W29Hgx9+6QCHD4iEkLrxQe2zGnV68bYT98kxdlZ
	d3HNQq8P5z1pWzFn+8AF3nv4lhXpKM48ottJ2mOr95HOswtqhFOBO0hKc+hpWGoO+Pho09Nqk2r
	8wK4kRmSHbM3LB2Gqoo=
X-Received: by 2002:a05:6a20:4309:b0:3a2:dc51:449 with SMTP id
 adf61e73a8af0-3a2dc510702mr22625990637.12.1777047609361; Fri, 24 Apr 2026
 09:20:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424132420.410310336@linuxfoundation.org>
In-Reply-To: <20260424132420.410310336@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sat, 25 Apr 2026 01:19:53 +0900
X-Gm-Features: AQROBzDhRqXSu2ARS4P9QlA5h7yA2wX07eL7EIpw_Pu0v7OVGEWCHBQ7H9BnTtc
Message-ID: <CAKL4bV7Ed-KnojutZwCnsNgg6iv9J22QDAayN1kWGeJ8c+9ZbA@mail.gmail.com>
Subject: Re: [PATCH 7.0 00/42] 7.0.2-rc1 review
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
X-Rspamd-Queue-Id: 6E3B8461407
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[futuring-girl.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241000-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takeshi.ogasawara@futuring-girl.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[futuring-girl.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]

Hi Greg

On Fri, Apr 24, 2026 at 10:33=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.0.2 release.
> There are 42 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 26 Apr 2026 13:23:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.0.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.0.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Linux version 7.0.2-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.0.2-rc1rv-gce7a64af92ed
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20260209, GNU ld (GNU
Binutils) 2.46) #1 SMP PREEMPT_DYNAMIC Sat Apr 25 00:53:31 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

