Return-Path: <stable+bounces-215682-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOzyHwhgi2nDUAAAu9opvQ
	(envelope-from <stable+bounces-215682-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 17:42:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EF611D5ED
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 17:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0E3D83004D36
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 16:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9540630FF33;
	Tue, 10 Feb 2026 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b="fjkNyX1U"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7BE30EF7F
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 16:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741761; cv=pass; b=uIZ1YTzdjngjx6SU2ayC5xDH+19cuOQo6UfePxN6v9jfjKoxKZsHGcNk9fNbZzQumv4XtNvck+oVtfovFsP9YclDUJWOv+lytwHaBtmpLs4ZQh86/Ml9mB7h+Xn7hL0VKhv8qA4VAhIxhwxrDEejm0t8H5DBKwcf1uqJCUldt10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741761; c=relaxed/simple;
	bh=R27vjPThPF4gZpuO2X4CyaikTBZPoJwo+jfJS1RMcyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSS4/6jiGUDuyXLdrhJU2ShjgIL+TqEJUkMp3rfS4NWDhamG/dMtfdZPsexu8k6Qesj1Lmy9T5aJP1wQGCWVLwsfcaMjXPsU4SEgn+UMP2MTwVI/0BsVQbqFcJw9KPXakrXfKgCGoizvWEnGTifBL+M8hvHtjmRgst+Uv1wp860=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20230601.gappssmtp.com header.i=@rajagiritech-edu-in.20230601.gappssmtp.com header.b=fjkNyX1U; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so154974466b.2
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 08:42:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770741759; cv=none;
        d=google.com; s=arc-20240605;
        b=Gcxr3sH2/yhYte7VnksOEKJNiR99FsD7kVNozAp6N1UZHC7EhWmQ3vW5uFHJPuz1fc
         W3Kpt7AQlXnmeGzBsjlje7NAdwZ4Qo78+D4+h5RIAGGZkRqRJclqIViuQ4HJusH6Cuae
         UaTJUBnUxWYEqHqG3lm5LUJrNJwJrOoSC1ZUnpBu10v4RxwWOYCwUjobjlHKYRBr9Jl2
         aN0HkHd53Q6ct9pYvJxMWTybWz5ZTuOWCtrsFubPq6MBUch8pOksUZRoKfG06fow8unz
         7cEOYSZTDx/a017fE/FiZxTYeyzyKn7Jpwx+qel3NlhsyRS8bAUIQ+F+ZHcSWnErc3Hk
         DNLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wyp/Y3IdbKULn1kjcIoZk7XD4vO5YGxkd7qKZ8DS29U=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=WR4eIHRenxYJCe74uIUZAIPYXwrMKlkcjiVhFGF0TpvIEtoWB3oBPMUqt2aYGdpzw6
         +F0iHqQ/hjtSXDudjkGFfFbVfUwbobE7WJJVoUIgVWru+FZmd8q4gVPJpzSnxew/uofL
         Lm5o5JoYiSAyxZ3au3GBGmLOGdnNtz1qMA953lC9OCz9lZO1kn9jAMv0v2gKppOI6ukN
         oo31u6XHLP+qDVOCCHbBQ7JE7GJaI6DSGK9iCraPXubp2spZcXpnr1pOJtQkKxZcIXOY
         ysCOhrKOIPcWKTn008HSPltBxYBxSgF7MqyAMSuhq4IZfStf8u8KEFviD1UPLQZjq5ax
         /law==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20230601.gappssmtp.com; s=20230601; t=1770741759; x=1771346559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wyp/Y3IdbKULn1kjcIoZk7XD4vO5YGxkd7qKZ8DS29U=;
        b=fjkNyX1UV4TFzBW3oewsrM2oj+gyVP1l8sQE+O84KYjXhkbocADRwKjB6BPsxQiXlM
         C6DHbzCij7WxoFoAhZPkqpThUIgHSsUSvTrSyobzwx0fvQXrd5yKaI1YPMrvUR3u2CV+
         QnUx19GBItFFxZAuQoOQvNayFagX8WlRMK7lol6f0asjYEFCS7zzZN+Jkf7q89HM9y4p
         0RQt5r13BUOdvvTgGSTk5W6hiozDzhnVe1ze9Rt6yGizSu2dVf/pCUS08L0ZmsOxi8Fo
         waSIpQ4EqWBMSYhyAwA7ZUgpamhM9/7MXgEbcVtPHxZVoErPUQTu1f0zLCANSXGI5I0i
         e7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770741759; x=1771346559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wyp/Y3IdbKULn1kjcIoZk7XD4vO5YGxkd7qKZ8DS29U=;
        b=FdT6NF2ZplmI9Yq6lxkHX9aE8iNZpHEA5c97jBaKRPAHHcQbZ9I5F/vv8zvPBjuWp5
         e6MeTBNS0Y/st02/fQRdpRYGuzZP7ULhnLJaFlMldJnKmZO0RDdJNxEWv0ZZJfMiX7ua
         +k5VC6NyT+Nk5Pv+02buMAlszlsfNbaH8T8yxOjllaVR9IzqJTslSo4IXXhbG8aTUeXv
         fZEMta8SfDMUgHd558iuMenVoEo0VuFqnIVMTuaM0mYMKFlk4Z4Kbqe59Trj5unJwL3m
         DWNsRKJrAjYVNiEOMwnj2c6FMxFLdtIhR8SiwUjkGeXC821/1cfZIFyFrwB+xjj/AnQc
         xfag==
X-Gm-Message-State: AOJu0Yxxs5tVJ0ljqpuXgM0WhTTJEn1DfklQ2gnkLgSSb2DbByMDUA03
	xsV5HOYZMXKUabJyIdsGzk1EXy72t2WzwF0Ij3xxtTWE9TjXoHAMzfWYIRsCqUXmuL5VmK5ASZ5
	tVEYWu4sgf1hZsTF6z1Rc1wVy4IIBct0/8y5WAHL0Lw==
X-Gm-Gg: AZuq6aKT8Yo63HuV1JZ+NBhlaIUMtC0YMLqd/cXUcPHtaB6+bl6tDlubT3eqC4C2MCZ
	80ECwn2TWf9u+5wn9C5l7Xsi27a5MTG9eYzEXagvhK58gCzo+NAAsrghpqXOZ7OsaJwv/jy6B6H
	gNxupCLMXkssRNwC17jjK3xs/ci6mKWCD0/clE778Gw4+DJ+m+ulDCub3OPdridP++dnX3T/5Md
	W1nt363J36RAF2UsJUBNgBC1GbBAhQkOoRKJsZ0IEUV8Tps9X8DiRDd0t0400lpLRB74nqVXIax
	VRw/GYzDZNsif31DL+O+TmFZYgedvcWaBsuoDvw+mdoVILpfvtwroWFPrZLH4gfnXRt3fQ==
X-Received: by 2002:a17:907:849:b0:b87:720c:f182 with SMTP id
 a640c23a62f3a-b8edf173b94mr836851366b.9.1770741758598; Tue, 10 Feb 2026
 08:42:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209142320.474120190@linuxfoundation.org> <CAG=yYwkhAAm76qUH_2dCHUp8+hGzvgT1Fm_288Z-=QRG+tAbfQ@mail.gmail.com>
 <2026021034-salt-unhearing-88b5@gregkh>
In-Reply-To: <2026021034-salt-unhearing-88b5@gregkh>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Tue, 10 Feb 2026 22:12:00 +0530
X-Gm-Features: AZwV_Qiyrx5DzjivxeQYlkKlLQf016y2YvbWZSbuIjVSoODzbueV9Z2dTXJhL0g
Message-ID: <CAG=yYwkUnCcHhB3WYXQ7kVn4VX59O67NmGQCieZkiPo8oOw+uw@mail.gmail.com>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[rajagiritech-edu-in.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[rajagiritech.edu.in];
	TAGGED_FROM(0.00)[bounces-215682-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[rajagiritech-edu-in.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeffrin@rajagiritech.edu.in,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 62EF611D5ED
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 9:13=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Feb 10, 2026 at 08:34:53PM +0530, Jeffrin Thalakkottoor wrote:
> That's good, finding one here would mean that there was a problem :)
>

> Why did you load/build this driver into the kernel?
i did not load it manually . May be  it came through  "make localmodconfig"

> Any other lp  messages or drivers loaded?
---------------screenshot--------------------------
$lsmod | grep lp
lp                     36864  0
parport                81920  3 parport_pc,lp,ppdev
-----------------screenshot-------------------------

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>

--
software engineer
rajagiri school of engineering and technology-

