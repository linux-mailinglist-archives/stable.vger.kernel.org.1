Return-Path: <stable+bounces-212781-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKWPF5pte2mMEgIAu9opvQ
	(envelope-from <stable+bounces-212781-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 15:24:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F287B0E19
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 15:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA9B8300380C
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 14:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FDF2C159A;
	Thu, 29 Jan 2026 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b="XRFB7bhQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB1228852E
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769696659; cv=pass; b=jRm3kZ94IGG+BlVZWYIoILJHbSu41WsUJ2tt+qXW8hI4VIPwP0TL+Cdlh0xsTyZUlC3QqUZxdwFLCfVaBdpQFVqlGwHuPdoPReWN/IQ2nOuVcEW9eig9zjX6/bTppTSfFmKDb9Mjmj2IMo4MKSScTvCm/zchhP/6M17B5z5kddY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769696659; c=relaxed/simple;
	bh=xU1/ZfrXgM9HR/Zx0kKZpCKj99mAbA3yDtIE/KHX3A4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+nMhyjt909z3jHlt4P7O0fMWKMHKFSN6NhJQP1JtUBmKQQt+LKJanlzZUYaRJ6uVJtJZix+dtFXbcV9qoQaDkYT7rc2dyqPfnMy/gAty9VxF9nXm4hLZ3EomeJqXrNUonP8HlwYZzLj1z7wlT37pmZLsHbig+BWQiLw6XE0x9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com; spf=pass smtp.mailfrom=ciq.com; dkim=pass (2048-bit key) header.d=ciq.com header.i=@ciq.com header.b=XRFB7bhQ; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ciq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciq.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8c70daf9c94so115254185a.0
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 06:24:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769696657; cv=none;
        d=google.com; s=arc-20240605;
        b=LntJgXLZNBq4cFcZPQUym2OAGLjt6h9YhNDpdDqlgRhEVhABQUJB1vEzQo1xPyV1q/
         P+ilgGpwsrzOzDtVAbmnLSEHp2QvDFhHEpQO0cz3+guhgIEcYhpVphkAe15lSFUdVrt6
         dJo66dZ0rQ+7RdwmmbxQwfGO66iN7R7KvMDoQ4n+/CiW780xC0i1fi9Odu/BIgYSw0hg
         ftamQSzrQegojMLrbJGNoDTg+VlTE726Yt8D6eG73iqMUQlNwytluH/a8DYyIKqw2gxA
         WG5A7YMvHEhL4GxCs2EgYgw1a8DC5ABFzBYglZ1ZQjl6NfXIusdKnwPub9HXFPPITWZY
         OwqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gktut5wQC1km4p9bQI9Id4b3vU7e4+c1JajdasfISjk=;
        fh=bN1N9u37F9sfpeWZ2mDRMBHW5qqsdrFlcOzPW13gTq4=;
        b=AiQwMFSox5uRo8VB+aPiL/NLQ01Z3bEpcAAXml3ZG8gkbNhVeQk5WaQ7Og8T+lyhwz
         fot21/WcWfqKRJCXT8ZqvTidKlK3ztzH+3FwDMr/h8PCkIwxH6xPt/rQFncITqiJ+x6K
         5Iwpcx78Mms8TP0SbBEspXxXTDuoD0SfSM7F9OS+SXdDavTlUqDHkebxpX+YyvnC0//L
         nuOBLmLExcJVMdAgihSkyoT8mcqeHCXk+C21xvjd+ZhkhpaKAANWcKdQPAFuAnwmhae2
         CstBCgYKzpaEkgFhmYqnCSdhzqGtfJDXqQZXpzKZ3dxZV0zW/N/gM9FFdXy/Xd6QDKmI
         MfGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1769696657; x=1770301457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gktut5wQC1km4p9bQI9Id4b3vU7e4+c1JajdasfISjk=;
        b=XRFB7bhQKqY82TiSL4yN3hx/jHkGY4sLEh3lS3+ItoYsMgEKmqr2Z+xpwFPeCipKLq
         5E5BqL/KpyFRATVxc/JheKWGUEqyAOLdD/gpnhlKN8A4bTR5lwh7Cb+63xSrPQQ6v3Au
         hBKRTXbRXR1VSw7yIdxQcZ7gpAogReOmCdNekPNR9o1Gv0QpjReRMPDW7Sq8hxo1euFS
         7LIIKlXZvLouv5VAA+535fqSN7QJk+Ej8AhRBwKa2FINCy7VuDchwDJ0cIqTLRKBc1fG
         JIqUIAwMN1I8tLO92foQxh2p48sI8pbPlGERLeJPcwsHN2QjEM5wDJaB/VFGgr7YPndd
         aMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769696657; x=1770301457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gktut5wQC1km4p9bQI9Id4b3vU7e4+c1JajdasfISjk=;
        b=kl8iUl5QbEP3Y2/yFnr5xg4gbCy+/tXvdobHM4GPf+dC6zL+BsEt9ua3u3LxonfDUr
         9Qm+EkwQIg1ke3SdjZlTv5ciXGAJ/PEXqxCHiYrw5SbR8sG2ffUpBJ5K4U0i77HwcGPl
         zMmN8ZLnD0xTBVzpwtn9dNGOM/hx1veunvCCX0OrhhlqIwOCjolwT17Yf3/kE12JhaFa
         WxoNH1QWEjmFMOZMaWt+PJvMIQ7A+0h4jMKrIC2lMse6xgl022DTR2TA4gG82hQX7UuU
         7ufJiQgDXUQkg+1yUBrCkDih1Jm9s56qjh6jpOJsETBID4RsIKqLgq3vu7SC2+l5emDA
         Warg==
X-Gm-Message-State: AOJu0Yx9JEfu7+N8IUBWm6s0C3qqEGpumT3gtTfTxUNa0WXcnRvac9Om
	d+ntXHk1lqEMfZLWedUI6DfjuHjYqv4WcI1zAE5+QPSJkBkVqkrKBZGcM8Boi2tpG5twDC5Gtfs
	Dr9BDe667MqHEoOdJJwfxQQO/DE/+ODxQC/DI5htXkcGX7NmWbNPj/uFtvw==
X-Gm-Gg: AZuq6aITtq7nytUp+/2RlFHaMPAYHR7szWDsfmmAeOSPdNQNUnHFTiQw5D10ueN3gxg
	LvwOeeO8fYDbb1bBbiQwk620Lt3aWvy7VnoTj8gxOtLEcwiWQzMkt9/ndoq9wOONzz6Mm9otIsw
	BBB8rrrmRsCPDB1jTMCzVhRG7bGR8e5RZPrk8EZm6yDF+3/QlJxzCjyjL2tAooGFZmlSClvLrk/
	q2k4RmUOfTbD2oVQcuZK5K7nmkAbIQ5qA7OnNAPwNfjc4QZtD30vnctNv3lRhXKI4BgFlJB
X-Received: by 2002:a05:622a:241:b0:501:d6ab:99c6 with SMTP id
 d75a77b69052e-5032f888b28mr117185321cf.32.1769696656920; Thu, 29 Jan 2026
 06:24:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128145344.331957407@linuxfoundation.org>
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
From: Brett Mastbergen <bmastbergen@ciq.com>
Date: Thu, 29 Jan 2026 09:24:05 -0500
X-Gm-Features: AZwV_Qj5V6YFUeSBt4FZkzqCgXMyY-6bvFIqCSYP0qCnPkxUMX9ip_fsyKXL4_o
Message-ID: <CAOBMUvhEoJEZRGJWbmW+Nbt-mzfJ9Tnnv2Z8b1Ep_OR2zBee5w@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/227] 6.18.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ciq.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ciq.com:s=s1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212781-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,denx.de,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmastbergen@ciq.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ciq.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linuxfoundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F287B0E19
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 11:18=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.8 release.
> There are 227 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 30 Jan 2026 14:53:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Builds successfully.  Boots and works on qemu and Intel Core i7-10810U

Tested-by: Brett Mastbergen <bmastbergen@ciq.com>

Thanks,
Brett

