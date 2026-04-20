Return-Path: <stable+bounces-240014-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDaKM/Cx5mljzwEAu9opvQ
	(envelope-from <stable+bounces-240014-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 01:08:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 51670434CBE
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 01:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7D623015883
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 23:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C3D397E91;
	Mon, 20 Apr 2026 23:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="C7AsrrS7"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92143876D0
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 23:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776726510; cv=pass; b=eoyNbvMPC7otNUnUAcZEPUFXPgnRIpjwAR0hENk+UCVepaf2wccs4upD45dlsR4viW6G0t/BL3DG3XECGd/+dZCpC5y7aV/eCR/ZKMt+hbR6wfui7YSo8iQYybObzUQVFZ36MSKa7rxBim3Neu/nJ3Lt6LG6X3wUtqm19tYG2zs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776726510; c=relaxed/simple;
	bh=zmOFTBFPOAhWVkL57eSJhZw+Eq0A+KPRBxu2alBXACY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=huOAHnnfR7iHQFexGTbaYVcoBJBT52/Mbo1qr1hI1jv7QAY9xAtO6YBmoc2QwaU0lWB+niF6LS9r9D51nnJaHTOSo80ZIfzY/9IaalYStGXIq+e1SEuZtR08xguaz00NB5FTFwkfM4tebCc3kr0X/JWwnlOPfwxAPgfodI72vrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=C7AsrrS7; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1279eced0b9so5230327c88.0
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 16:08:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776726508; cv=none;
        d=google.com; s=arc-20240605;
        b=EvbzCNZYnttVKpc6TyO5EymoaIwqt24091gkoQl9J+/4vs1VQC9oTwrN8bkhgDNVp3
         TZe2kfnjmxJr2wVrztaAMononnkV4z9mkVWGdVqBke3WnT8sBXjkvXdmGq2dc5X7vvKl
         VHUhCrg77kZlB496+3ISJdJJF6gGP768tYTDZE4OoTcrOMzZ8XnR0gefOzlBU5oTODOq
         wzyE0PoL+xV+fjh9tyzFsO2VeTMNqzmD5pS1QNDTHTgx4anMC8LwHxkYDI8JSAGkko7U
         F8AZyeNa1aCM93+qdjt7kW+yAcAPH6d7UaM3oBZf13iliwGYIIky6h7REF7ha34aK2jq
         Qf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WfZw9lUoUdSkvL1mEcDKzmMDv2qNLFBrd2cb6geueH8=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=BIv5KD8wt3Ek3FdD+P/2Tmpo+jaIlBwZ7SXRgcQuA/2jcxDdCTFzf1NtZend2FrgTt
         xVVxY0Rh47tePvCkkSoDyFCcbZoZaXwu+iibr7fHD0ddSUlAnKZyZayYUSWe3k6/h5qB
         SjPjS5ulnx1aDdpNlxoqFFfwmVvKBShsFa4uK/Eyys3DpLtCLcHw+ylq4M9+LPkbXi25
         IBMQcKBC6NScwRqfbY5dbqHuT7aVpmlVfBWK98NYNfs85dkJwF4T88bdXTJf2IGMCXWj
         SWvgI9udwjY9oJrPooeFXVp9j4/xRoV55P5wpmhqh2X6SH6ps6x3GCJoPOMsRXZrqpuK
         1bAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1776726508; x=1777331308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfZw9lUoUdSkvL1mEcDKzmMDv2qNLFBrd2cb6geueH8=;
        b=C7AsrrS7x0kuUfIUjMbshQVngF4aGGLzM33Wf5H12I0yaqTRcZHwHt0oyeXZvrTVzS
         EjgtVqUSIf5exV1mYLZq6dR9AFgDr1stLTzRXPmDjNrgw6khDVg80Jnl3PzXazkK7yLN
         IOXkwVjyDsfyVjQBx0EXFl8+4HVE/IXIZehTYK/DMaKGNHlgO2yD0NR+vfWDbIddKEDw
         bMQW8TGOlkMMeMj4WkfqTnw4UCVEH1TWisWnkcirrZISXbSvuaKPLit283su/Hb7srt+
         lDFUjonXFbyCMn8IydsxBQtEWnTLyOK9MqcLIeNsLKBtWA0zLPJMjdaAQo/vjh5IIjo/
         uVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776726508; x=1777331308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WfZw9lUoUdSkvL1mEcDKzmMDv2qNLFBrd2cb6geueH8=;
        b=YuOkNxdUszGqkPAU47ob6cMkl9CjgKiUm0Uw+7FFA5jr03sW8bXU1VidHmVUowNlCh
         oyd0iX/UMZNnZGamzN6psdupmc8YtUJEMBpVhFcEgflvSI3YXlWBIXM2dXPiOd43pHcx
         LOQu1r94hlfZlJg68rcRvdOTgpDYJZGXc9Gjtd9xN83bl20Yv3YSo7Hoo6+IAA0fiSIq
         f9xwc/4S06tNrlYiLWx1ThsTWby1TNNEoAM7QvcKAxr/PO0QJU7HGKadB6jUAoFDNudS
         pp/hGl0iDtnkMJvRsP1MVcxoXEkEdLbIFhVktxrZe9HKpyB0wZkRfLUHsVitTLcIlzF3
         YiXg==
X-Gm-Message-State: AOJu0Yx8rR+Hi6UqQBUssj9S/PnTRjGC4U9kGxQ2bOhx16QYUzlehG4T
	sB3l7p7ybey4WtnV1TJKYsdAzhVX5td7w6Sed8Nw1UDDLvF13wJhFGuAIFpzkVIrIYewGGKV3GO
	cjYDm9FqxNyMjG04Gc52g3xZokCEZZnQzN9WiTnv/fQ==
X-Gm-Gg: AeBDiev/ShVe9F+ej+GUGnQPjYZ8VgZ22xt+hp0SEqcta8anPxt7Jx1jM+kn0Z08EWw
	G5GmwfYhOULrjcuCEtHWglViRbq8HpCmZKI008Pzigod813Tb/uUwvMcHuKapE86nN1/b3zzqXB
	HOq5oOtF6Jh0WsVWhDZ4y8USZyDP7K27pv3uo2bzKLL/y4AI6N2n+0eoCPvoCpCSzVyB1krZfhQ
	cPqf73miMF2bPkKMYalyAcKmC7VEQHS+socN4BVjZ+dXPj8UGQOvpgmjMG5mCtmwNILIhCMpCeE
	G7U9CX7/gfK9X/B/9ytb7lr+DWtPMg==
X-Received: by 2002:a05:7022:1282:b0:11b:e21e:5653 with SMTP id
 a92af1059eb24-12c73f995b5mr7198049c88.19.1776726507819; Mon, 20 Apr 2026
 16:08:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420153910.810034134@linuxfoundation.org>
In-Reply-To: <20260420153910.810034134@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 21 Apr 2026 08:08:12 +0900
X-Gm-Features: AQROBzDJnYb21chYbYwVabBhIScuKpcMqmeQBC43qTH-HqJf94L2Qz420LTB-zQ
Message-ID: <CAKL4bV6iDGydgwZc=Oqo_vTX4JEyrxvLkLh7KBN-KLsFMhs87A@mail.gmail.com>
Subject: Re: [PATCH 7.0 00/76] 7.0.1-rc1 review
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[futuring-girl.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240014-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[takeshi.ogasawara@futuring-girl.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[futuring-girl.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 51670434CBE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg

On Tue, Apr 21, 2026 at 2:17=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.0.1 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 22 Apr 2026 15:38:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.0.1-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.0.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Linux version 7.0.1-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.0.1-rc1rv-g01d779c88be5
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 15.2.1 20260209, GNU ld (GNU
Binutils) 2.46) #1 SMP PREEMPT_DYNAMIC Tue Apr 21 07:14:32 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

