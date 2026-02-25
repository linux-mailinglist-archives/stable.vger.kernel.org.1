Return-Path: <stable+bounces-219566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPEaFK2jnmlPWgQAu9opvQ
	(envelope-from <stable+bounces-219566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:24:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E36719359B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 08:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13B8F3058DE4
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF387285C9F;
	Wed, 25 Feb 2026 07:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="FkQ+UqQa"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5E4284B26
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 07:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772003117; cv=pass; b=I/q7kOm+nlS4IaTSr4R7bDJskFWorAeasbhl0cIO1A1AbpZK3j37u+qdCBfq97EiKI4sScwG1JAQXxyghdrUI+vAfvwlDHGnEHirjvC2ysVbeDTcpmr/SMIe0RWtljxva3Zg88HzwGC7su+z/DyQz6GSwEcy8pqWSiuv2nH/8p8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772003117; c=relaxed/simple;
	bh=/k02X8PaewizvlJgw/fQUp1hsa/3ik7+nBt9aGGxX2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqELWKJxWEgvhyuftShNkn7lt3tE66ODH09LC1GgYlybvEbfHH9lqJSHJtq4wt6dcQ0eMGr89o5O0VF9cBjA2Lsfc2gcEptkWz8/hIjsSziLaYvR+ogo045wEpTDVyQQQ64OFwQkiMRvEFHE+96aKQngByH3KIqmtw1Q+UtlB18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=FkQ+UqQa; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1275750cf9cso5258203c88.0
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 23:05:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772003116; cv=none;
        d=google.com; s=arc-20240605;
        b=GnRsp1aU+xDN7olouqDq5orpcTrqo570YTGQ7COXXwPAXA+ZcO1VnzLulCGXAHNWNZ
         s7Y5WmimvrY8I6F/ELpO5dzBA+yWqrWcH4ClxPogOFRwLKmoR2W6B4tPMdOrw/jqXmx/
         PxlPkFXGqU9VBjZGFcwiuOMsBS8/9HpcQ73m+Cn67ABUzBs+n7UQVswhjny1bSTS5NnE
         ldFBuZluMAMoudp1Fj0NRXEDwVFTpc51HatfnmOU9c/mavyGnVBRJlAwXcFJjnESxMPn
         k/RCNybqcB9qG8ZYbgpZEjXChIycQVO0r2lSrCrnShsP6Bv99foNV925pCJhUogeP1wS
         F7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7TFbtURUgNYCS5/WPabeVvrWCG/zY7PV+Pugh1pyRdQ=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=EWoa6E7Zycs4OMOSvStq84a2gOetTRxF87xbX/vHUTzKACxrtM9KXvD6JLSFjLcwjw
         asdhjIHo7JTVOVNvFxTL3kGlOn0pq9XkPLcqDz9wcTTY2YoPyO+7AemvuXcoYTVr+Ypm
         uLONDvBS5fCGBw3wkoXx6dApmClzdmmnacjNk7ys1zKoyIsbUc/vgtCq/EEPZSMk1qJs
         sR+dr05a5LF4DZBZc/5AyXWNRD/Y3WAT2INOjRaQTwNoUbdNv7fl2eunhPmUONHjI80N
         FNVt6WcF40jXprjc7b9CSYBH9Gc6HxDgG/kyFinK/bxS2vXy6gWMnvhNeOE5lSW+NOzq
         GSxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1772003116; x=1772607916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TFbtURUgNYCS5/WPabeVvrWCG/zY7PV+Pugh1pyRdQ=;
        b=FkQ+UqQazo6BD5lDIcrB5WGi3oj0cdK0YCY5r965ga587jRGqUHsM/VK5UsWsNLW22
         LMhiVtHwVHkT+8XtiHU3qd5c5wvBlnSp7hlImsXpFHLpJ6dmYtm0lEU4pyFNBpQOgAqa
         YangFjBQ8l9G53xZYsVxyz8lVqnefE9Nfzs+Qoy3hOrpHC9/g70ehskO6qkfhZHSkqe6
         dSBdWKLTg2LwQCJjOrrEQ+eP1vtKioKWiZghiLzHdQfovHFRxM75Nx93o8XB3GJK+dlP
         KvYRrXcPSnf7BBd4YJ4rfBMFRKH2cpcrRmMQ6O4zp7T6umqVpA0fefB7zAWrNTwVIB4N
         30fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772003116; x=1772607916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7TFbtURUgNYCS5/WPabeVvrWCG/zY7PV+Pugh1pyRdQ=;
        b=m6Pvnj7lZciHFu03tJ1IeY3tsE186uH4JBF2wUq5qvWbFotaNG6Iv4kWS9CX8tEbc0
         y3zh2AsMW6KrX8XNsbOk5HlAwDuUKiMrbwBk4lKYxI8HNLw3hWWtZ5ETQkOru3xvKeEv
         dAdK1Nb+8jJ03Fu7LZ0qJYW8vJHq6M3BZFLO1NA8DP+NHYqrbKwU3oZo+3LWIx3Olfvb
         A1oTSWolCSot+bi2St91AvFYcCMcW+R/TNicv8nIU0WuvKMhcY7aFB/0c1s97XMU/LYU
         DTFE65urSa+ogMEoRiRcVDGlCIb4dkKfYW/gJ3t8QIcoHZyb1kfjds48kVklbkCgu0tB
         Y8Dg==
X-Gm-Message-State: AOJu0Yz7pFaHfDZMa8ATZa7B8ZCDpbq/Ayb8ihFgQJGfHb58sG3q5xCH
	Rq6UyHUec1VH0zvH23YOiwILpqCRJ6miNoUAZrOjnCnMA+0lQKjHpx5Snxv+ha1mPwlBLNDQtcO
	G02+XrE/kjIjnW0YNwcJPmw4yih2LrH0aQvva/fiuUdRqV6WDEKk521U=
X-Gm-Gg: ATEYQzzsm/8js1C3as87xyIU87SqEqMhnFQncx5zAVg0ekuBY2ImGlmMqpCVo7K5r91
	guEEH3PQv9QHJgTFryBzKJ4uRMG7c90dVjhtZlXW8rIXBVL2bPzCdxnFundmJb5qOJuERAXNWni
	5Z3oV9su+Fwekf9KjFdk/zUZPBbITTcsyoTXC9dE+2nQjhdSWmHnNTw/p9+PmnGLTsAiJxGz+6O
	mXlz4AOuIRKK+mCCEZqrJbLfGBQg9bWn3okQNAFk0FFkSRe3BpZ6bOuDlE0+BUje5xV6iwKH0ps
	TRj2PyslzKD5fHtLPgTv/nVe3G7R18u3QRoYa5bM
X-Received: by 2002:a05:7022:2393:b0:11e:395:7dfc with SMTP id
 a92af1059eb24-1276ad1862emr6627438c88.28.1772003115532; Tue, 24 Feb 2026
 23:05:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225012359.695468795@linuxfoundation.org>
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 25 Feb 2026 16:04:59 +0900
X-Gm-Features: AaiRm50tZLuddJ8DYu3vbB1Cq2ZxX5eSbN50zMadaSBbDd1MGNdy6MitJ2VBOZA
Message-ID: <CAKL4bV5cpxvJxFx31Pv4=rgXRvF1bcYjcHg8TORaanQRQptZdg@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/781] 6.19.4-rc1 review
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219566-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,futuring-girl.com:email,futuring-girl.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,thinkpadx1gen10j0764:email]
X-Rspamd-Queue-Id: 9E36719359B
X-Rspamd-Action: no action

Hi Greg

On Wed, Feb 25, 2026 at 10:27=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.4 release.
> There are 781 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 27 Feb 2026 01:22:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.19.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.19.4-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.19.4-rc1rv-g88b880238ef8
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20260209, GNU ld (GNU
Binutils) 2.46) #1 SMP PREEMPT_DYNAMIC Wed Feb 25 15:32:50 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

