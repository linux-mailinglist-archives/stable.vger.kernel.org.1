Return-Path: <stable+bounces-215573-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0h/UH6duiml1KQAAu9opvQ
	(envelope-from <stable+bounces-215573-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 00:32:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E025D115664
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 00:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28AC030164BB
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 23:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355A12DECA8;
	Mon,  9 Feb 2026 23:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="RUX/OC8O"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E022264D3
	for <stable@vger.kernel.org>; Mon,  9 Feb 2026 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770679970; cv=pass; b=lOSOdwBGo/UNR0AESsF7a4rlZQy0797sLSDpS+8hJBiaUrZN8t0utV5XAxFucF3Qt5l20tuHzJbvH+V8gmIOLc4TZ0Uhk3AdNF/kFfeA3oXSHJzigBVzl7EEqN7mxOV5rdKiaoqcEigAjZR9UkNld8V9kT3vKZFdQDd/MyWHzVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770679970; c=relaxed/simple;
	bh=vSYIQM7cYfwv6Tzh8xu3FGMrbUKt0D7Wa7VzoYij/Og=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VqpHabK6J0bZKdwl/TzGaIwX5s/W4N8+OO1FbOlTj1z9qDWKqfEBazJMnmx/xd0hpomi/ScY3cdzK2EkbVje4eCASZ+TDRGXzBNd8snJyH/ZZ+JzdBuL7nsiFTsSz13/qWcIMzAvaT9M1WhzcOyuX3nCwwEOLfDXcqFvnU8nvEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=RUX/OC8O; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1249b9f5703so4837528c88.0
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 15:32:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770679968; cv=none;
        d=google.com; s=arc-20240605;
        b=DTQC9keI3Ts5wJUYABbBVBXA8gd/uExk/oa/A4p/WZWb+rXrNI33d8jOTNLN7Hpbmd
         TRyvLhSmmrqJj0mY21iRbKuJBZaHGb6YkhZP4RNeqspb47I1WD3VaNEKq6w0by61Xvky
         Ur6a1NS/rz67/gqLMdka+s9tGdH6HAVMe209qsoQbuuKYJ7BWJ04mD9O3SiOuA7H3zAF
         U44HDxauZvAWcVJmmfRel/SCj5NpJfw6yVSqMj4njsIRhmniKYL3tbzaYlqQGy4BC2PY
         4aLBGl8gs3i6ZFXRZqReJrnDWWGplT6or0ieF/eNZPWpIfvoAQD6u5bOibUuG1fabSfm
         PR2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/J4gYTV7arTSFYSrrW6JyFKLOVhsF68XhJ7osYlmqyw=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=D6uU7E4J2pyfs2EUXimwXZS+UzK1mS2W+FGFrHAeyk57hG9cK/ElMKpqNK6mWxp1Kf
         bx77YghKLp/KsaTrr8NKMQQqjU/XBGv5+rJHRprA7dMh1inj4/9Wx4QcM9qIpeI4snox
         t1l3+lvdbWh0yz4UahH2lNLq2QzoMpv95q8MzNHOgZKFdI5njC4sadTwJatIbP7z+Iur
         AQsDQfCL0bQg87JfPtDkOYiF25C2oxfPFeT9ZfHDT8ykvsfTP+1LqhPJb1OfFZDFq5B6
         XkbIF6wYFLY1jlgaaF4HM2kuiZVK6lqLvvxlTlWvWmrbVE8DzrQxq3DvxQlCTLlGDiQv
         1suA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1770679968; x=1771284768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/J4gYTV7arTSFYSrrW6JyFKLOVhsF68XhJ7osYlmqyw=;
        b=RUX/OC8OU+SpwkgH8AFaA140111ivWx/YpRTyKe8cC8SE3w2T4AsRMALXPkhoFJFZy
         L7UzTfZeTdVWI+MtQTv8Ra0T3uLI3uQ4W7KLd3XEETW82xWvZ17HperGOkPk9Yfqtg9E
         NJjntc2CDDE+fc2PwjyZebJjg3PmT2/5a4RFZ6H/+zGxZIMSQWiiQsnMvya3IIg0H1op
         ++tT6M6Lisy72CsCXBu6B7yclW/bBm5ROSJybtMStYOoBjhRs4x/FzZPD5IeHXFF3qcc
         JUoM8AjkJVDqyfTv8fUd0yYlRRrfkE9kuyMy5H74Hha5FmqzdDW1igJj1/FqAcpUvjeE
         r+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770679968; x=1771284768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/J4gYTV7arTSFYSrrW6JyFKLOVhsF68XhJ7osYlmqyw=;
        b=unLy101nMekHm7JPGUiNGn+Au58vpbR2rpL25afFB9R8e+W0/I7mD2SGSLbF14MM7a
         mz6nVUtCHCR+OPMQtybvMlc0NcPgsi9kSPVACKZQq9kEf5h2bluTSdE+jeWMcP4pEwyf
         /ta+SNb7aNjn9+Gn9XM9jzLEx5yWTcmSXVV2Z7gA+jbYjT/4FrGwrBH4lfP62wYrpTLX
         MzXgyJAuPjke8lNh8wBC2WqTiu16OwTKHd0FNr6SXyxOcS57be6CRTol36BP5HtvhiCi
         SCpIxlEfYzL2MvBJlT83vi55Pxh1Xxw2Duzvs1ebR5f2wCc1VXjugCJ5uiCZo3i11XnU
         nCCw==
X-Gm-Message-State: AOJu0YxpajFP/IfkFZFul98ULVlyP/Vpdt0Mvr57VRBmRZUqGMoavTB8
	yEcggP4CMlK2UfeJOKF6Sy0sSOATx93TY0pupwZyv1XIRDFuCOUMwWI6aAezVdB7RzieKeB8f1E
	RoYX/SiEP9Cc0Xs7Xm8C23fblmLuBBGh4ZeMJ4eFv5w==
X-Gm-Gg: AZuq6aIXcIkLOEnISBPcPuW3KLcGWW7If1KpQDbSE9+eglGl4bfWoWQeb6JC4nz3kZY
	UM6xSibfBbyxr3bMJ1f2ZQlFSkRqlMKmqdU/42TdgcIjx7tvoMwit+uuXu3J0FKLazB1q2x4YsS
	O6AUhZ91ty2pQrjEZowfx9yKJ5JtxIqLZkfKYE7TzQHHhGqOZevtpava4J0VOyqyOF0dt97xqFo
	gQwrcYh15LPcjUoIqYfBJaCIc++xvH+WeGFpaKni2KnSmTlwsCzh9DtuuvMrx1UccTx+OCZ
X-Received: by 2002:a05:7022:f9e:b0:11b:9386:8267 with SMTP id
 a92af1059eb24-127040052d0mr4515280c88.44.1770679967711; Mon, 09 Feb 2026
 15:32:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209142320.474120190@linuxfoundation.org>
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 10 Feb 2026 08:32:31 +0900
X-Gm-Features: AZwV_QjN4AF0sCIZTLO-vwWQ0AcVu_xbPrug3on0w4-b3rradmuPmuS0RXhAfCE
Message-ID: <CAKL4bV78xBr_VrqWj0TuXQLJ-JAN_C-VofQskufiZgv69JdbMQ@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/175] 6.18.10-rc1 review
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215573-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,futuring-girl.com:email,futuring-girl.com:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: E025D115664
X-Rspamd-Action: no action

Hi Greg

On Mon, Feb 9, 2026 at 11:26=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.10 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 11 Feb 2026 14:22:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.18.10-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.18.10-rc1rv-g0aa40b8da17f
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20260103, GNU ld (GNU
Binutils) 2.45.1) #1 SMP PREEMPT_DYNAMIC Tue Feb 10 07:52:43 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

