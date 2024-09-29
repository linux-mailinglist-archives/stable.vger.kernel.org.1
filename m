Return-Path: <stable+bounces-78216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D489894FE
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 13:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57096B22E16
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 11:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A8115C150;
	Sun, 29 Sep 2024 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="aBnp+SXF"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F99184D;
	Sun, 29 Sep 2024 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727608301; cv=pass; b=MyKXckaT73t9wxKOEHJYw08XOjbTT772aPm/y/3BzsjHY1tYFBujBJZblu3zZOEJRgsXZWHyEdLwiY6JPPF3aPrLU3s/p6IzTrt56qctXjERsd4BulyIYOUUJBagH2yjoBeXqsL1Vg4bv2WQGCK0/FHoBt5a3sMc1UjInNId7Yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727608301; c=relaxed/simple;
	bh=9Mk8F23/7jbtkp5ROHqadlTCcgFHMuHPEb0gM0Nr/aw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=oyfmnCLJjWV9DDDx7PO0hxOoY5VpyNCotQoQgJLsal5lIpOisXAKjsaDOjpVoEHkEhFI97kSlAoWch4omjvjKkn/ycSdx6qd9stHG9JnYeWdz4f0c/rdVw2Pk89pVy1qKsOiTJXY/v0Ip2JhrqjRKUndDt7gFQvPofzVnFWuwPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=aBnp+SXF; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1727608270; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZMG+vLQ3BLYL5KnIGo4x9Lz1ypnsIbZBjuAHUYt1hrWYe1+Vd1403yaJJZAvJMl7PppK+k2HuAH3bc4gd6qmAyeirw0C+2hPzq5Qu9BxYErJEzOAfpo6BwtddBW4CP4OFxaEHeXCWWAMcLq+NDWvj/2tiq+gZaBhQqlgn1ZRpfI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1727608270; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9OTTrBfB9yKk3re56uatFDd3pNVZaxB5QXQbah8W5+o=; 
	b=A0usfQtmdGeYwBWivW5j3J7A8U3yaS47Wc6qpdlNoXEiA6MUhA84USlXusOG76cFfTFnrv9xTMdauM2myiJ/b48mevQbiXCBhFmh8bImIDI6g49DT2P21NEnSxG67vl5NANs9Y8mE8bmemLQh6u3W4VJNK9fuMC0vyNE46Ml8MQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1727608270;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=9OTTrBfB9yKk3re56uatFDd3pNVZaxB5QXQbah8W5+o=;
	b=aBnp+SXF3eeneFdk3wbfCoaJ3w0XBluI6pV6tYDqIAuR+TjGLsOXGjRBezvnIcQT
	pUMi+ceFoazrTErgdVeHIJKlLORfavUg+rpjSuQQe2w44BQytHY5oxwrf+AU0ddYcMO
	np12ojr6DYJThWIp1rjlEQuX4bdKTHkQtXLH9eDk=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1727608268738263.1733996401289; Sun, 29 Sep 2024 04:11:08 -0700 (PDT)
Date: Sun, 29 Sep 2024 16:11:08 +0500
From: Usama.Anjum@collabora.com
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	"stable" <stable@vger.kernel.org>
Cc: "Usama.Anjum" <Usama.Anjum@collabora.com>,
	"patches" <patches@lists.linux.dev>,
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
	"broonie" <broonie@kernel.org>
Message-ID: <1923d7a27a2.dce77ca11210391.6924958602918999301@collabora.com>
In-Reply-To: <20240927121719.714627278@linuxfoundation.org>
References: <20240927121719.714627278@linuxfoundation.org>
Subject: Re: [PATCH 6.6 00/54] 6.6.53-rc1 review
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

On 9/27/24 5:22 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.53 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> =C2=A0=C2=A0=C2=A0=C2=A0https://www.kernel.org/pub/linux/kernel/v6.x/stab=
le-review/patch-6.6.53-rc1.gz
> or in the git tree and branch at:
> =C2=A0=C2=A0=C2=A0=C2=A0git://git.kernel.org/pub/scm/linux/kernel/git/sta=
ble/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>=20
> thanks,
>=20
> greg k-h

Hi,

Please find the KernelCI report below :-


OVERVIEW

        Builds: 26 passed, 0 failed

    Boot tests: 528 passed, 0 failed

    CI systems: maestro

REVISION

    Commit
        name: v6.6.51-145-g3ecfbb62e37a
        hash: 3ecfbb62e37adaf95813d2e47d300dc943abbdc6
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y


BUILDS

    No new build failures found

BOOT TESTS

    No new boot failures found

See complete and up-to-date report at:
 https://kcidb.kernelci.org/d/revision/revision?orgId=3D1&var-datasource=3D=
production&var-git_commit_hash=3D3ecfbb62e37adaf95813d2e47d300dc943abbdc6&v=
ar-patchset_hash=3D&var-origin=3Dmaestro&var-build_architecture=3DAll&var-b=
uild_config_name=3DAll&var-test_path=3D

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team


