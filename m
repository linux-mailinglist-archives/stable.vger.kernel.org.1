Return-Path: <stable+bounces-217198-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I2cBab8lGm8JgIAu9opvQ
	(envelope-from <stable+bounces-217198-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 00:41:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8C7151FB8
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 00:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC5A8300AD55
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 23:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A667332ABF9;
	Tue, 17 Feb 2026 23:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="UOL0dkSY"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEBD32ABFF
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 23:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771371678; cv=pass; b=G0p1he/9TdRwRQy8lToMbwI+hoL3egF1jnV4jpm3y0IUt3i7UN8kD8dAmkLxdCzSLbbCHOSetsOfN1+TKVNNQiiKD6Iol9sagb83m6EwVgIHRNR2Jcw6tsX2NaumKpO6HJ7N57+EuFLl6DJCIZOKXI4Z57anSbtVrXgfkjNo4VA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771371678; c=relaxed/simple;
	bh=ZC2MeXtrSzUu8L4Ep48hQ8nuNJnmtlq6AhNproNpzvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YqOzbWkie02Aj9R7WIMU5ZN76j3W06u5pZdRSjkMgZXUT40q7HchRxmganOLOCkecYQAMprm0Vtea/wM0ovdQllLHkOttom5et/shay7c4oZ+OFtx6BtK0TyDNTQMfLxwVyUXq+hBtNO3uMkQk7vqpafYqjVb4NO/ouD/G26Mzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=UOL0dkSY; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12732e6a123so802439c88.1
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 15:41:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771371672; cv=none;
        d=google.com; s=arc-20240605;
        b=GaTtJO7WD8N33Uxp7+7ACcacTbInIRzaiLIH1fqMESn1OzaS9+XMTrIoMvRouQT+C2
         Iiqc0c15qLf8zmk1ZXheEj0c+1BlI0Qh2wSnZ3P1a6SrcDGZQzh07Tmp7Js9nFn5jCZi
         i6+QJubf2GDiFeypMKt6VWCrrDAyHD0a5yVOoGgzvMQDzMCs8A0bBohZ1uWZ9nsNzSRF
         ZdV9qFrxyfbQAfVLxLcl3mWoQjgU3EIw69Kl+YzxllPZhrSjjn4Y68qWaHrXlOPL1bdQ
         rgdnsRFpytc4uTnJkUCGP5y+EgynwblQvmKue0j+ecAOPQckB9fw9ypx5B5gIgZIZ5XQ
         FMBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wCl+O8bYQ5IhuKuSsxlP3FcvowY6kRwa3uqsFQa7UZ8=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=UDShH3mHOrHXC6k/m3ipBM5mqDYLXj1eBDmGLy9RznQ84d1SioMiPifOUdH3m8FdAs
         vlUhfr/wCCe3LKxi1s9Sv6NbqhsZ+53G6d51RFNDyo2Rzk/SKiXFfp6/A88ZeNI4m1Cg
         lSjtFwy/ZpXbZsNh2eI8NaU6swIaxMKCSL8ct9Jy1JO4qAX5Xwl+Qk/c4Igoz/Lzj25v
         IpXBWXbwP09VOqafdYL9WDm9WWAPD7fhMUjEqtD8Gebvng2CQ5Yh7qNEr3zlkUQNgqiW
         ReHiYalHzqZb9HRfpY/mBvDjUkkGBugDIDqmJdgWdODKX+r0e951MZE8oWCbVoOtQ+1u
         dSmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1771371672; x=1771976472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCl+O8bYQ5IhuKuSsxlP3FcvowY6kRwa3uqsFQa7UZ8=;
        b=UOL0dkSYhVVQzMezCfPWGYhVJo3da3xomra8sAOPIunNMvOHfh7yb6SL4UE2AModhr
         X8s3zkT2b68htJf6xYuZJYGN05NhWswA96kP3KDBNHzhurTNhIs8lhadedphwozRSSMt
         2YCUC2y/JCuVWM3QmCeHQTJAoOpeZxMxxtQ4k5Zsd8TYsePZUlJqOf70WNC79uO51TPH
         sWng3y6HJR3D/pUwbKSAwuhVIMz3xHLYcZ5bT9zDmCzSpDwXOLigd42RICS+kxRs1v5B
         NcZBhyJHZ+pCoq14+G5/AWCb+1xb3TQF4X60pBJyG6fo9VXDkEVJFWPiF03PYtBjlGsw
         HoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771371672; x=1771976472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wCl+O8bYQ5IhuKuSsxlP3FcvowY6kRwa3uqsFQa7UZ8=;
        b=fQXuxipFkbp9Epa1EJhMJy3rM487h6iGz9XWxYVX5RRSY7GVsvzaCSRRxXFnySdpKV
         aw8qMa08YDH+GNDJcDsSwLxYAZJvStwoydRrOXFcEmXzMlegVI8MMDa+C9vGq6J97Wl8
         1GWtkDc2VceiBOzwWfX0JhHo0IWg72PhL/omuYKprWJLahXmAIBKauGsEkipV3rO35Lw
         Q0uABfKNiAHGwB++szibT8RZsisGTT6IiouhEE1t3zbyfcth+sE1xln0qFq7N+4jrczR
         jIYUHOyoKbOw92TFqim3pGD6k7YN1njaKiuO5LcEskEcBeYeKFNilN7z6VY83J64r0Aq
         HSGg==
X-Gm-Message-State: AOJu0YxLBziP6GJsSk+tev9+KnolEr8o/JLBSkvzY5itAOU8l/a4iduV
	7VxQWD9fnfbMHeIAHzKWe7UkKlxucVQ877eFybly/g1+sgdBxhx7+c40TL7KlHY02ABFViS38UD
	EYnAlwsh9Vt7JpQOwZGER2gNsHDCFz9Q7RkYLYazDKw==
X-Gm-Gg: AZuq6aI+IQ0YxtGx9mi6PkxiservmN/k9aOP3Mp1ldo9fUx4OoQ5yDBxgTgg38eUj/C
	dTch4dZqjsX/SKfQkzS5k/zWd84Ojj2rI2ewQdtLmiVXDJtgNSPiXE4Q0s3ebj7ezvWwPEFUvL5
	f6CZbtLQyTwKEwj0c0mUdRHTOerjaMr/5T+GAtmMjaGf74i7CiCOOXbEhxKCAEoN0+fA8ja1Sxk
	YcSqLzp5qSQsfXVNwDoRZHMRrcbiTFtV4oRVro8N4o/LMwlUyrDHRCNMHUgauA6ZBp0mVG85ERK
	WCwLeL3s
X-Received: by 2002:a05:7022:11d:b0:124:9acd:3b15 with SMTP id
 a92af1059eb24-12759a6b6ffmr13932c88.39.1771371672085; Tue, 17 Feb 2026
 15:41:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217200002.683975158@linuxfoundation.org>
In-Reply-To: <20260217200002.683975158@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 18 Feb 2026 08:40:56 +0900
X-Gm-Features: AaiRm50IAir4FGafBUzb-FMs_r7-weMTOUOwb2koN7-A26RIcgUsPGiDNCjlZBI
Message-ID: <CAKL4bV5uUNTJXzFLwwiHO5ZWk2R7p45u7v_Bxo3L-mg1x8LxEA@mail.gmail.com>
Subject: Re: [PATCH 6.19 00/18] 6.19.3-rc1 review
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
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217198-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[futuring-girl.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takeshi.ogasawara@futuring-girl.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[futuring-girl.com:email,futuring-girl.com:dkim,thinkpadx1gen10j0764:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 3E8C7151FB8
X-Rspamd-Action: no action

Hi Greg

On Wed, Feb 18, 2026 at 5:50=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.3 release.
> There are 18 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 19 Feb 2026 19:59:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.19.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.19.3-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.19.3-rc1rv-g40e4767c6df5
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20260209, GNU ld (GNU
Binutils) 2.46) #1 SMP PREEMPT_DYNAMIC Wed Feb 18 08:05:33 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

