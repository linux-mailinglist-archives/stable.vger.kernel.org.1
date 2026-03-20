Return-Path: <stable+bounces-227597-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AI10CFaGvWnQ+gIAu9opvQ
	(envelope-from <stable+bounces-227597-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:39:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5002DECAA
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BE8D3004600
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 17:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513D43D3CE0;
	Fri, 20 Mar 2026 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTj029Cl"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9BC3B9D9C
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774028293; cv=pass; b=b7ILfEkF4A5rQQH46JZDEEd2JnS/WaCOvgGXT8ckvmMBqDF+OP7ZWwh05mfOGe+7tIc4uhTD/CsRbkN/iTibU2a3ukrieMcUN23kgjN45SCcZth9WX8WougV3MpPpsb/gSIwA38/bDnKOO3/lU5ZtQZ0hvhmPSmOf/RQsie2kcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774028293; c=relaxed/simple;
	bh=vyzcxyLiua+aJmZ4gYNX1LoXWiN3e5CwNMBv7DWxiuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZTNARcNG+RW1nVE43LPoqCwEgp1d9bRydyA9KvWPTTjZYPwJgwKD0AaC21pcgS/qbhIcHu1C7vK315uliFEDr+xZ8i0p2AZE8EPFKt+Lh7tspD7+aoOeRKi1aPLQigqHHXnwyDrPN14sCVJk0EVAzeDusugXNA6dxSrTiaPNI/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTj029Cl; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3870778358aso15008451fa.1
        for <stable@vger.kernel.org>; Fri, 20 Mar 2026 10:38:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774028289; cv=none;
        d=google.com; s=arc-20240605;
        b=QURGbJ4M5MVHIwBnE30KAz+cacp33S+rq85LTRfQF0LEzk99xX9niCDve0c2Y6nrnl
         Y6ZNjzxkVX7u+SfFe4YURLRxQVfXlyPSWpPuXpBPrekG04LdyncfWVpbJZlqapTYQIbP
         2q6UaiL/yCYIvkV2xUTiBZeV6iBEFjWTxT78YAwxY+DpM7gJ2FzTCEfnJqOdcUvpTc2B
         xjq9nMAdFNgK3Cf4KC413WObacPTl9S7F93MRmmHfgxAX/Uy6ZBB2OBhFFMPiDJiPYZr
         L3tegMygwzzXMUioUI5sY/2Nef+am48WcEuzlsqI1pJQdEeKRUHpwCLXwPgGTfGR+tHf
         o2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pmt9ZSMy1khDGG6bbXx05FDoyR/j6jvheT25ANDu+v0=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=Z/K+qZfo/kb8nXWoVoR7Skrx9PuF5G98jrvEOodLoFZ0jd2EeUHgW47YpEVdH2250O
         wl1rAqMi0dFz6LT4CJOE4/o129QCGhHHnYYqUyisWMewBrnDiVhHTJdcoBKTpj7AfTMO
         ZRM8bkO58F7ZIQI29yM51aOTy12TadQeYGxAahw9WtXLrhg8EGjYDFQDa3oH+UWdq0Gj
         eK2818Nddv/lvaH8JVr6E6i6SRhNHjZyw53/MGUEX/7nm8Z4RMKWPGBC+VEprPr3EY/3
         /Wyuhr8Q4Zfd8bfDVb7/uWVc+3sMk+8IuuUyT8S5FkIW8lUDvjZzjxp4d/Wc68jPSpxJ
         r5iA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774028289; x=1774633089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmt9ZSMy1khDGG6bbXx05FDoyR/j6jvheT25ANDu+v0=;
        b=gTj029ClkLYTZBEQKn9w09Z8AeQX8lzIJwpKGmx0EWn8SQ3MfinYvGSaoKtGzoQjZ/
         Md4QgDS7nou4vxserMVOCp6cgepRjAdDMfF70z8P/y9D89JpxrBkyqJKOBmO2DFRCCPM
         dsj3Iy/bqzA9hvAfY6i+sihpspgGVVodFVIFQVNeNB8TIXw2hU1IRG0xGWZljfM1+6kT
         qavFN3UYMnpqhLLCulx7OvNM3US//OpVBOXytkunYOQjVA1tInq6Y99xZyhIsP6neR3I
         rcbQp/xjnMkJSsHsyYt6gTMawOAaHO7PP5vprOuOOYHJh13AyiRPn8nSWhbf/J7YBAf8
         7cAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774028289; x=1774633089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pmt9ZSMy1khDGG6bbXx05FDoyR/j6jvheT25ANDu+v0=;
        b=KUZ55l4K2be+OAGam6W2/FqogZhpwTgQbCPVVAdf0AvZyR9FhhY0Mn3zSvpIHLnKwW
         dSGOHIQt4wLeSxQbDT6lrRBxWWe/5tlul8SgrX/yyvMfMZvsoCiwM8D2dVQP2JPzv02e
         u1bemgxtEVu/391giKIJu1QsJuh3mF1WjwDlNSU1ctZdwKyFwHezHeQCPW0tO2iYg0v6
         Ix+wFLKE8U5PMZWvl95nmmkhHh3cBxLmskuJkHA108R2dieye1wBzsCadEVrEAjrFagU
         +NKs2ESQ0E1uWsidIeT3TgK7x7vJkQsNpDSH6QzzPGgidjCjzBsJHrsczCHNy+EuSCDp
         JJ3A==
X-Gm-Message-State: AOJu0YxWGIVLr9VI2AEmg+5XGQES3Ptj08KS9QFsD3gK7S4Oj3CkquWu
	BNXEnayt8ZLQ43UtS/XKGFbSWH/M0FmR8foUBeLs8T6p2V5V15XnO0KmCPJUayh9cHMhfc4JuWy
	I0+Rt5w6fTVYyubbFS7r9DMBxopOsZKg=
X-Gm-Gg: ATEYQzz8p+kxMTCNgAIurODPy4a8x28zPQwBa5ALflFs4IRi3AG2T0oE45ojczx8Oxt
	OStoivc3mNZmlCgy8JDuKcRhrrMFFidPQx7kynUxkZRSOlbF+PbmewZXLXziG4gOQUGff457LlG
	O2RIA/iN43DAMEJbv4UWi/bns5kYn8vJSoBbK32xRvjS5TtehHbjFa7hyYeJAWmDhTNySWfNUoL
	3J7+V4tUpD4nQlZUXMlNJRo6EjYc3hIUohvkJrdMHcXmaDi1AJup5x7JM0/ZEVKiKcUilebyDlc
	KlwHxPEqF/y3fOiibnfRoQ4A+lU25fk5SCkUNZH3
X-Received: by 2002:a05:6512:3b24:b0:5a2:7ba1:493b with SMTP id
 2adb3069b0e04-5a285b61bb2mr1577073e87.33.1774028288656; Fri, 20 Mar 2026
 10:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318122621.714862892@linuxfoundation.org>
In-Reply-To: <20260318122621.714862892@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Fri, 20 Mar 2026 23:07:56 +0530
X-Gm-Features: AaiRm52FvB6NLw_9Q9BMVK_7A-AjCHzUsNbZa9STwksvXwApxvnFr9Vap1kNFUw
Message-ID: <CAC-m1rryq6wtLUmuFALWiyrRNroqN5fOgXhhFOfysLDcRT4F5g@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/335] 6.18.19-rc2 review
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227597-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.608];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dileepdebian@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1A5002DECAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 6:00=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.19 release.
> There are 335 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 20 Mar 2026 12:25:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.19-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------

Build and Boot Report for 6.18.19

Build and boot testing was performed on version 6.18.19 using the
default configuration on both x86_64 and arm64 architectures in a
virtual environment. The kernel built and booted successfully, and
no dmesg regressions were observed.

Configurations: x86_64_defconfig, defconfig
Architectures: arm64, x86_64
Kernel Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit: 1cc312cd040851e0a56d3ce1f0f92cd232ab5cb0

Tested-by: Dileep Malepu dileep.debian@gmail.com

Best regards,
Dileep Malepu

