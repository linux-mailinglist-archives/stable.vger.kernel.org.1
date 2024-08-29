Return-Path: <stable+bounces-71481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3394C9643B0
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 14:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57A381C24817
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 12:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D51E1922F2;
	Thu, 29 Aug 2024 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=shreeya.patel@collabora.com header.b="Ioj1IOK/"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235EB18C916;
	Thu, 29 Aug 2024 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724932866; cv=pass; b=aXmwhbvWp/uLkrs96qL3oQqOoqxpQzgZOI9OwXT76petfJ9w8eeTVS9fP1TjlG9fdZhJ4WSebRZjcHPCsw9A3pcfxuzzK4IwJ0CC2aXy+LTM7gUnQyTJZlD7+LjYz7g6vZPyp79BRI5LwkpaxUik5AjQN7C7Z8JlnL6xMx7u7e4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724932866; c=relaxed/simple;
	bh=5xKzhR89bpue/0eQdd1l6Vs4rAvduJP3oOA5bTwbmIk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=SXalshKXqfrg/0UyC3qNFxqSWoE1PZJ3Xdek48SyL7Kg/s4y28DcwG1a2P0lxteM1+54WQ6VV/vyBZwQQp/oqfeJk0BbQzxFYbnACAaHRK7+Np3YDJWfx8MBESEJ0JlNndsLcQS4b+DDyM7NIdeJ9aZdad8ktUFVlcjsmK6v5TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=shreeya.patel@collabora.com header.b=Ioj1IOK/; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernelci-regressions@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724932824; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gEUeMDlknsslWudInFfO2h6SlRWRFz8XND0cvsGwBQ/fQtywnEdFo0aZieDmpTWLDI911lvKc7ZckDAI76uyL6XLj8o07bU1YyCstmO6RV1jI3PZMyakmzQC8RCXBQUpPVPI0gi/Bs9ODKijL1MIqdSWPGMTM+nJIHwl8SOhGXo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724932824; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XMih+Ra2OZEiXSZgd9Koud+lRr5eqpgf2Qoc0vzxEm4=; 
	b=eG7YYxRaEGau3ls8pZE8DqF00rerEyQ71WitZ2jVKVxjr5JwNVEU4lmdqGyqT3fvOZ6wTLNQ2NK8aotewuT9zsUNBYbmiZ5amxEnsN7q70TTdmVArFNPmoBeBe8rIdh54uyHm5a5tBdCWYAC7ZlG+AM9IWFObQ1XwJUU/Tb/MIo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=shreeya.patel@collabora.com;
	dmarc=pass header.from=<shreeya.patel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724932824;
	s=zohomail; d=collabora.com; i=shreeya.patel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=XMih+Ra2OZEiXSZgd9Koud+lRr5eqpgf2Qoc0vzxEm4=;
	b=Ioj1IOK/vjqvnZtfGh7upF26YNk5tmY4nAAFNrDaw7RmWJB9nDjR7YL1tV4M9rYw
	muw8a2dsRTVPn+630DL6VBoNC5YLZ1LRwDeyLaXJAhavnnofQ1BJsc6gjGqTE3E1EBR
	sRl0G94hzwkBqP7h3ymlNwGSiKddhfq0wWb/IGFY=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1724932822202603.4018372370394; Thu, 29 Aug 2024 05:00:22 -0700 (PDT)
Date: Thu, 29 Aug 2024 17:30:22 +0530
From: Shreeya Patel <shreeya.patel@collabora.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: "stable" <stable@vger.kernel.org>, "patches" <patches@lists.linux.dev>,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	"torvalds" <torvalds@linux-foundation.org>,
	"akpm" <akpm@linux-foundation.org>, "linux" <linux@roeck-us.net>,
	"shuah" <shuah@kernel.org>, "patches" <patches@kernelci.org>,
	"lkft-triage" <lkft-triage@lists.linaro.org>,
	"pavel" <pavel@denx.de>, "jonathanh" <jonathanh@nvidia.com>,
	"f.fainelli" <f.fainelli@gmail.com>,
	"sudipm.mukherjee" <sudipm.mukherjee@gmail.com>,
	"srw" <srw@sladewatkins.net>, "rwarsow" <rwarsow@gmx.de>,
	"conor" <conor@kernel.org>, "allen.lkml" <allen.lkml@gmail.com>,
	"broonie" <broonie@kernel.org>,
	"Kernel CI - Regressions" <kernelci-regressions@collabora.com>,
	"Gustavo Padovan" <gustavo.padovan@collabora.com>,
	"Jeny Sheth" <jeny.sadadia@collabora.com>
Message-ID: <1919e0214a0.bc2e94fb482384.3257750178650984120@collabora.com>
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>
References: <20240827143833.371588371@linuxfoundation.org>
Subject: Re: [PATCH 6.10 000/273] 6.10.7-rc1 review
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

 ---- On Tue, 27 Aug 2024 20:05:24 +0530  Greg Kroah-Hartman  wrote ---=20
 > This is the start of the stable review cycle for the 6.10.7 release.
 > There are 273 patches in this series, all will be posted as a response
 > to this one.  If anyone has any issues with these being applied, please
 > let me know.
 >=20
 > Responses should be made by Thu, 29 Aug 2024 14:37:36 +0000.
 > Anything received after that time might be too late.
 >=20
 > The whole patch series can be found in one patch at:
 > =C2=A0=C2=A0=C2=A0=C2=A0https://www.kernel.org/pub/linux/kernel/v6.x/sta=
ble-review/patch-6.10.7-rc1.gz
 > or in the git tree and branch at:
 > =C2=A0=C2=A0=C2=A0=C2=A0git://git.kernel.org/pub/scm/linux/kernel/git/st=
able/linux-stable-rc.git linux-6.10.y
 > and the diffstat can be found below.
 >=20

Hi,

Please find the KernelCI report below :-


OVERVIEW

        Builds: 30 passed, 0 failed

    Boot tests: 334 passed, 0 failed

    CI systems: broonie, maestro

REVISION

    Commit
        name: v6.10.6-273-gb49f2df929ba
        hash: b49f2df929ba1bbf4ef3b81d88f8118cfbd8b936
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.10.y


BUILDS

    No new build failures found

BOOT TESTS

    No new boot failures found

See complete and up-to-date report at:

    https://kcidb.kernelci.org/d/revision/revision?orgId=3D1&var-git_commit=
_hash=3Db49f2df929ba1bbf4ef3b81d88f8118cfbd8b936&var-patchset_hash=3D


Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team

