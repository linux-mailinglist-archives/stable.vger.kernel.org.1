Return-Path: <stable+bounces-219788-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMywFFchoGkDfwQAu9opvQ
	(envelope-from <stable+bounces-219788-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 11:32:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E861A452D
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 11:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B4ED300E5D7
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 10:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5E43A1A5D;
	Thu, 26 Feb 2026 10:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="chDrl1W+"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B627F3921C3
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 10:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772101883; cv=pass; b=dLlNMeAaTDvhaa2SLdsaEkrERAFStm70DKeqp/9ZSoTcFUADrrye8MSRJN/Qm6dZf9JMWBT4qI1ETaqKVVnJ5b9BxY/YwX9KmS/h1jx6r8gWixPZJaKaL1cZwt1TE8WF74WYjAqXVi9WCr7f0ajp/ixdbyUwRne3zZMqtu67H7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772101883; c=relaxed/simple;
	bh=anYMqxwpR+nu7UEQOFNVZ3X5XYdS3eWHbk0GKrFqOOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ppoFpKxz9UCPqAJCrdtv6MsR+TDzvTTQit0jvTC5HNJzri+Vbh9q3kn4IBfbiQMAorl2CUXc22+X5KQ+5e93XcNJ+ekiNxlELVMY6YAOoVyZroEmnNzBLvIz/jNJj7UoesRYOZM9STx72d4Qm+T94I2XaPAYpVQ2KbUDakqkOJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=chDrl1W+; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1271195d2a7so503818c88.0
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 02:31:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772101880; cv=none;
        d=google.com; s=arc-20240605;
        b=RfbC5Veg7FZH3kYO1RTDUFPUzxAQtuJNaA8w5liaBN64i5brKkE9jotL4nMQtZHlQm
         jMoreWnnIYSKCrxVCGCtCObaRifSZmK+yXxawRlMmEFII1J3tcfaoBN0v2p7bLyaaUMA
         sCpfxr70X5le/5Qr9tMGp137P+FGO1KjclNsVbrD02axSZnlz/9zfibpNF+T6Sejam7h
         5S77EEaLULDx3ajvbGlJjVU3qea4/4cDkr5dkqc/5uKfZQrAn/3WPtM3d6QYVdYywIVM
         m0VSFZixuaLK22/XF+qM3gVkvRIRUisICciqEQBVec3UF+hXkwTv9s0kblxH9qsruXe7
         UuyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y6Xg9HxlpIibWsVNQjKHCybD682gjh649PRqD1j7+c4=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=eN+loDSjkhKncbj9gWKrdj6CvztzaO36PSsB84jNIB7lJLXQawkRUpDrWUwRzQoKKX
         Yn0fzkAubsiZBDV8FRktmepbDpiftbGGm06rR1elDWpb0loXV3fjyKXXYNIX4jgc/W3m
         Zlb5rf8Hl3CevgYtfvPbwQS74HQ+FVAki0OXtuDvu06fHbnNQt+AFrtiVmD6H3eZy74w
         mkNIGyBtd/WL9DcC21TIYqHlHdGHJ+/kYBvS2JKQJ+A4TSev66fxR00h0AkvqQHXtStA
         xlI8vcwP0+xu/vr+cBDxtGTpF5eLsxXotnzBFeAmoZwkoXVcCV3yO1N/E0hPZ5YIuhlK
         Al0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1772101880; x=1772706680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6Xg9HxlpIibWsVNQjKHCybD682gjh649PRqD1j7+c4=;
        b=chDrl1W+iKwbdE26IZJGc2ERV0JFJFFVCfdK98UjEFZPWwAd1CaRbqXepVgCTTK6gy
         gPScu8w5MbUrt3IymITe1Y4la6R0dXVFE5cxp2pyKGcNM+aHV5tqDu7P1zE7NJk0sKOu
         4zl1FgeQGCgW9H0khRvf9GVOctrYoXRge128WKFHeytkzZPjHSg0VjpiVhc5XdmI3bYi
         vOyZ+cFZQT7zqc3Ol4lNFnr+qw8l4nxWZ7sj6zlSGzr3uX11iOXdrALzeUgNEz/wHr73
         It+PdnYNEAgopqjsZrKB//MnvV9vHVzuVS9PVBYz45dBBAFIVl52amS48adZ5HvV5hXU
         K0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772101880; x=1772706680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y6Xg9HxlpIibWsVNQjKHCybD682gjh649PRqD1j7+c4=;
        b=fMhXRiouub3x4/1lFPqmhkR+403g4J0bMnVFZwJSupQ5h1s5J7VNZYuR3i/PjqR9Xp
         MZXSEr83CTXDVKAv+6Y7iSGGs8LXtY58Q/NqQ9fixrVgJFCP23MukMLx0YUgiyNjWxVU
         JwRGGgROSNEpmYyo6iX5wfu9BuqlPCzJOgmg0mHKU7MpCvxaWPrgYAGgWBB10a/jZl8v
         cHSEMHuLHb/+DE3/QN3EWX31VaqjU1dvtVr/YYLrqcPyURMfZb/6lNB2euv3cDfHRxAO
         q80qZQmUmbJkMAs/sI2z4Gc3pzFTuzV7JZldGxhJ+qBWU9RIbZdnUdJrmHwuIMs4ggiA
         e9fA==
X-Gm-Message-State: AOJu0Yxwl+BVbNH0RhORM/u4t9GEyCsk/Mt4NRIQUMYbK6UtjQR/Ki0g
	TzXa5+23+pbQUKdiU8XW0ekMun4Eug69yuZlrP7Qx4WUxYwCK+nPA99XIFM095HrSuWqQvrGgqK
	hGVtkpVAoUYpchSBVzbWreM4dw6Toy1ghGXIR+2RQVQ==
X-Gm-Gg: ATEYQzzlqQt6hf0Aj2w4Frfc0p+y31qlBBEtUaibPmDZZevB4Bqn496JOTaPSj1TVpy
	cXx9JnM+iubM5daeQVYKUxDY2knmoNP4rY/sehzVHkCR5TDfjzs6pOGLJWug5z7gr1mMCGFtN0I
	N6C/KDLJLpaPU+kAAYM474rogJ+YnTMz4T/h1TC4vQxeeB3w9sBQ84JH2gDkbrgEJO12jzmRTdk
	Ws1hkL665d7/TRi7qWCMuwRgEDv7Nl5j4nxKLW4z+QmbCsrYPwbuXwIYjfnqMyV7w9/GVASi0tX
	9UlVjv7wshV3vCcXvLa2OWEtXworMzhCc2HlPsrx
X-Received: by 2002:a05:7022:322:b0:127:337e:3301 with SMTP id
 a92af1059eb24-1278694d544mr1508180c88.12.1772101879559; Thu, 26 Feb 2026
 02:31:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225155341.094945851@linuxfoundation.org>
In-Reply-To: <20260225155341.094945851@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 26 Feb 2026 19:31:03 +0900
X-Gm-Features: AaiRm51FIIwYhOs-UxDvDGXiVZilXoc6wP4paS67hi--k9N-ihe-yynb-S9YUzY
Message-ID: <CAKL4bV52Tq8Q50Gn-zyd6Gdnm_c7YB02dsxQRYeujWkRyPdKCw@mail.gmail.com>
Subject: Re: [PATCH 6.19 000/781] 6.19.4-rc2 review
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219788-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,thinkpadx1gen10j0764:email,mail.gmail.com:mid,futuring-girl.com:email,futuring-girl.com:dkim]
X-Rspamd-Queue-Id: C5E861A452D
X-Rspamd-Action: no action

Hi Greg

On Thu, Feb 26, 2026 at 1:22=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.19.4 release.
> There are 781 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 27 Feb 2026 15:52:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.19.4-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.19.4-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.19.4-rc2rv-gcb2d80377c4e
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20260209, GNU ld (GNU
Binutils) 2.46) #1 SMP PREEMPT_DYNAMIC Thu Feb 26 17:16:20 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

