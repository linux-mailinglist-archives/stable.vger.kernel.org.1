Return-Path: <stable+bounces-241147-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBqVOS807WnxggAAu9opvQ
	(envelope-from <stable+bounces-241147-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 23:37:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E23E467E16
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 23:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E21053009B36
	for <lists+stable@lfdr.de>; Sat, 25 Apr 2026 21:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEAD225397;
	Sat, 25 Apr 2026 21:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbVlmS58"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913E983A14
	for <stable@vger.kernel.org>; Sat, 25 Apr 2026 21:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777153067; cv=pass; b=PmHnuXMJKxqclAlxhYSf5Hl7YXDBILLuz9gsjQawyk3Yz1Kf/zYW1TstnS9ttU51BvbooL1tF92IhurR0IWHJsJhXhAlmBq6dy5s07D0LEYStpzqH9OiyPTz0DC+rbt0Z2b3dvBgq/nBeCEEfGMbhXH6zBX6a/nt/QhsX7y2XE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777153067; c=relaxed/simple;
	bh=fVwaHjADj7hD0E27HijGqOG0DzLsu1OtbPTvKi5vgdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PnBbS9BQRBwlit1b/l/mfr8JGilugT6RGvZPbOHXkz3/Viuw6wNFf2tdzkmsicf9WV+7h8ZvqUF79MXJiHU7PTnpPZ5DZs12HdayuiRMCOYp/geP2iiB3APLa0Jdi8tS7roEusFei3ZHJQqHgYA1zpGaFjTIo2GA3FEKF+AkX2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qbVlmS58; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a2b5ea59a1so13140743e87.1
        for <stable@vger.kernel.org>; Sat, 25 Apr 2026 14:37:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777153064; cv=none;
        d=google.com; s=arc-20240605;
        b=OFGj/ohLzev5bXe5mbk5JMOSUlQM+Bbd7L3A0ahj5aqhmMppqHAuTHEFnoGVgr0mVQ
         pBB4cHBUUHUIGjZAqMOWWkzJMGwTlVO2a2tJ58dfFwNRjQoQYBKLC/cXlVOgIE/mhT6B
         IqTmwuD9lP7bauZdGNP7amhAFqAsEOodS3xi1gLdA0KAJW/IyRDwKlhdUNFv6p9/na02
         OjMgXZZnm0skqSZYGvJLX9VTXQeqO1VubRhQm68+nXBQp3Hw8w8OazWOv+nxXrflmQz/
         uawJhpQD5nMaKbaMQDiRRNAYGiNZVK+Tp/RxZsyLyGtJDOEP1vCmXh6vOAcFzLyKyuTM
         QqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TlFiMgzCvG8jVhDs0P645nDIJhplhuxTfjuhUWHaUpc=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=gtH6ug9fZv0XFUPj63wMvcfAfBEdqS4LbQoTaHNxmUVt0z+VKKE63ElBm2EQuSJzHD
         Tjsin0pTLROqA1QLUGNPF+oTCA0iJ/S9xRGKXkJ9xZPRPgOMnF2DOcEICZILufaSeYfw
         F7RlwngBuu5lUVwiDT5HbDy/L/VQCUVxTFwadgAnnmHI9QdRzDxlFCfzye9URrA/GQwb
         vQj+LKrhPGKJSlPDAyrV6ANc/kjCIpBb3esaUMSrdLEX6ZU8eibvyqQnBgtBPseS+l5N
         xJzjmsgvJyzr8GW67eI3gPiNKz/qIiNC2nW926D6aYnoMEUhCnPeuEVdon1jvuFXL3+U
         BpBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777153064; x=1777757864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlFiMgzCvG8jVhDs0P645nDIJhplhuxTfjuhUWHaUpc=;
        b=qbVlmS588IV2Qix1eeQxldcTspL4QP2NRqCRh9Bcz87sFAGUPTI48mCBJG/q3FNoWu
         vxCjFdUSW4mPyqDsZqMCQR8cnMo8C58sKAb+fU2mnW3iMdt6mjSySKdfOdLpgs8Wqdvm
         IXMe4AALOR+NEVh3ja+sOzPtUyBpqUgYfDBAQIcqkRsSBAiKH9puMsIhKpmFsrsx5+c/
         qZ2hVzdNcchElzuFQvytXOGKpRAe07H0hMqRBEZnuCtViKOC3AULWay0DShFzAGk8UaK
         LVVZFlfhrsO/Ydhv09WqBCyqqBJuZMA7p0Qxut7Sk8psvmr9o3EGMVBHdY83fcfOGi2/
         nN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777153064; x=1777757864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TlFiMgzCvG8jVhDs0P645nDIJhplhuxTfjuhUWHaUpc=;
        b=jXjIehXQeszMi+qDoAG6pHBMQERxxGNJ26eLCnJejBwfa/q17z1Lyvy7AwWG3m/C0y
         bcTSvmBJ21N+8ZjwQiTivvuPWKs/FfCv5VPMgw3KJNqfmDHEGC5uvnZqSQQhftTkYFRS
         7NURN50NyEYHMScQNNqijn9rVK5dcFFzpPYbOvaeAhyPTmy9Ds0qzCo4B4Xunu+RQfe4
         +hbSE85SSSGh2fo3CVGFz9SJUjsUv3HHn3ds3QddrHXe229pDvsVdChHG3XHPak2sIcG
         kCRgF8/s98Ia+6lUXxcpLOrZiADe3YRFCxd0CwZlW2wWI3TqktGe14MWOLl4dwQdSkSJ
         wmFg==
X-Gm-Message-State: AOJu0YytTunjHjR5AcIZ+cNpmqyxHR6E09DLTendcWnMbR1PISA425RZ
	jteQ+qI2AZCfDo86IhMy43S8bK9XIkCWTl90tW3Fw2DvhyInfxiOOX9oOmO2Jtw9u0c1F30hQra
	tdGTKicOBkT6T5FzO6l37v2fBKuCFSDc=
X-Gm-Gg: AeBDietOwpvtY7WV6epnY3BBYAdWtLy6a4yb/7AhQ5y4G/on3fOgYgp2xUbVhFHyndF
	9x3xkL5NomOlJ6QCoyI1FnXMC9O2it7jEH65zSmD0f2GaMbdgVMEsECibueWs6EI3TJoMm8PgSg
	3i7aYOKcnx8HRZ+z+XEYJbdQFsUSkpzvHqgVbTwKVH+HSLTPGBj2ieO7yLc/GO6cFhkj4xEpv3I
	yXp7ZnD512i0k0UIGBhSgi97XPtPwhvlHEO8IZ+qlXSyjx4pL+NyB5pkzGRRXdDHoUbSINGqaX+
	lAdR4QQ3px4ydKp4GBGAIGA9INP61SLfWpwIaciACwH3LUNTzaM=
X-Received: by 2002:a05:6512:1046:b0:5a4:113a:aef7 with SMTP id
 2adb3069b0e04-5a4172cc4d0mr11858454e87.17.1777153063484; Sat, 25 Apr 2026
 14:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424132430.006424517@linuxfoundation.org>
In-Reply-To: <20260424132430.006424517@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Sun, 26 Apr 2026 03:07:31 +0530
X-Gm-Features: AVHnY4J3No40B__j-9cDKQcum-5gJcF82PrcVNRfXqVzMuoEsRBx8u3rKx_G8pk
Message-ID: <CAC-m1rp8b3+sR9svJFeuPRZOfF0GekbDySQnpUTG=LzEHcYpSg@mail.gmail.com>
Subject: Re: [PATCH 6.18 00/55] 6.18.25-rc1 review
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
X-Rspamd-Queue-Id: 4E23E467E16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241147-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dileepdebian@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linuxfoundation.org:email]

On Fri, Apr 24, 2026 at 7:19=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.18.25 release.
> There are 55 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 26 Apr 2026 13:23:22 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.18.25-rc1.gz
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

I tested kernel version 6.18.25-rc1 by building and booting it in
a virtual environment on both x86_64 and arm64 architectures.

Build and boot testing was performed on version 6.18.25-rc1 using the
default configuration on both x86_64 and arm64 architectures in
a virtual environment. The kernel built and booted successfully,
and no dmesg regressions were observed.

kernel version: 6.18.25-rc1
Configurations: x86_64_defconfig, defconfig
Architectures: arm64, x86_64
Kernel Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
-stable-rc.git
Commit: 2bba374400df741071c2c40c53e8d4b8254899f2


Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Regards,
Dileep Malepu

