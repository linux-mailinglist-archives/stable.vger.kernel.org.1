Return-Path: <stable+bounces-78218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1141998950A
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 13:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99161F2155F
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 11:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7081157488;
	Sun, 29 Sep 2024 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="FNG40DEj"
X-Original-To: stable@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE9D184D;
	Sun, 29 Sep 2024 11:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727608978; cv=pass; b=QOYo5co2K5C29k5ojJlPAggcGeTrySpqFpvdrv727SSC3/pRweXYVmPsmqixQotWCxWxnKVkVLuhuk73SlX4pa3XgWxKmVQa860VgqPpFTXkdFTIT8NNtiTtWZ3q4QymVb3qPcUy3I9RqGwUz6lEC04OdcKeQQFZ/SLJIDZWl8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727608978; c=relaxed/simple;
	bh=7SR8EDGWdt5KnaE3/3oN9EG+UWNZBaFbRmPoJdkSicI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=dg+3p+i41sRTEfosp+8PJX/wYIW1h72D5tL4tBgNfwvK/N35f63XBuyHVLhDudkVUMu0w0bS+29DA5Hw6NLiCIZ030zl2qEMaLY0WNJhNECsnoXOQxsf8aJB9J5PAkYOQZ2ZjM64VynprbdzBbgzQuT1Ci7nf3NiHXw78j6A7Ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=FNG40DEj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1727608948; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Lfc2Ivue10/ofVjNSUS8AkiXYudbppWh/yWhC+0x08qTGtgxiVjghnBo+gCAuQJJgE/VgSuIefvt5OHUiUSyfdp+4aRKzstikSlZ3G5TMdzOG333sS0m2aSMmnPO+XA/RhQlLGtUp2wDtEqiRkcXNMeGwzdaGySn3sWaGdTuKUs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1727608948; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=O+oKcC9AieVtIDSiwFKPdjHgbR9FuNeDNcJQEoqg/o8=; 
	b=YnbH/1yyikM8uNbXmQaIOepQ/5Hv/f4LCLpb6TY6TTy40G+o+Gw3yRM/XSBNkN0nRVSOiGHGgVq9gipY65mgjjTdHVtmeAerY2kbGnsuAjHueaBLdNzlPORwUfUIzCVfZ4hGWgwrMurmaQLXXrhKwZrngLefXO/n2R7kIhWoJ6o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1727608948;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=O+oKcC9AieVtIDSiwFKPdjHgbR9FuNeDNcJQEoqg/o8=;
	b=FNG40DEjGowsQACv+GQRL+BcPhtSZVpYYPYOl8j8tRMRYrDFPbVBsLnlDH1ZQTjE
	lNXU447X3K1ryGcZUiNG3A9ZfPV7Z96RA3sqtQD6peQoWQmhCsyJk8GKrNfcyuu/F3o
	74NKZ8tI1/KfiomDKE8L1P4GhRcmuF96UJB3GsWY=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1727608948227773.5763382634664; Sun, 29 Sep 2024 04:22:28 -0700 (PDT)
Date: Sun, 29 Sep 2024 16:22:28 +0500
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
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
	"broonie" <broonie@kernel.org>
Message-ID: <1923d8485e4.ce351fbe1211392.9064870993661059104@collabora.com>
In-Reply-To: <20240927121718.789211866@linuxfoundation.org>
References: <20240927121718.789211866@linuxfoundation.org>
Subject: Re: [PATCH 6.10 00/58] 6.10.12-rc1 review
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

 ---- On Fri, 27 Sep 2024 17:23:02 +0500  Greg Kroah-Hartman  wrote ---=20
 > This is the start of the stable review cycle for the 6.10.12 release.
 > There are 58 patches in this series, all will be posted as a response
 > to this one.  If anyone has any issues with these being applied, please
 > let me know.
 >=20
 > Responses should be made by Sun, 29 Sep 2024 12:17:00 +0000.
 > Anything received after that time might be too late.
 >=20
 > The whole patch series can be found in one patch at:
 > =C2=A0=C2=A0=C2=A0=C2=A0https://www.kernel.org/pub/linux/kernel/v6.x/sta=
ble-review/patch-6.10.12-rc1.gz
 > or in the git tree and branch at:
 > =C2=A0=C2=A0=C2=A0=C2=A0git://git.kernel.org/pub/scm/linux/kernel/git/st=
able/linux-stable-rc.git linux-6.10.y
 > and the diffstat can be found below.
 >=20
 > thanks,
 >=20
 > greg k-h
 >=20
=20
Hi,

Please find the KernelCI report below :-


OVERVIEW

        Builds: 26 passed, 0 failed

    Boot tests: 510 passed, 0 failed

    CI systems: maestro

REVISION

    Commit
        name: v6.10.10-178-g8b49a95a8604
        hash: 8b49a95a86047813f754fc406afce23ef0458caf
    Checked out from
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.10.y


BUILDS

    No new build failures found

BOOT TESTS

    No new boot failures found

See complete and up-to-date report at:
 https://kcidb.kernelci.org/d/revision/revision?orgId=3D1&var-datasource=3D=
production&var-git_commit_hash=3D8b49a95a86047813f754fc406afce23ef0458caf&v=
ar-patchset_hash=3D&var-origin=3Dmaestro&var-build_architecture=3DAll&var-b=
uild_config_name=3DAll&var-test_path=3D

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
KernelCI team


