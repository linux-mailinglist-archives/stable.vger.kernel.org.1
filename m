Return-Path: <stable+bounces-66258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03E594CFAD
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 13:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06F8AB2228B
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 11:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD379193088;
	Fri,  9 Aug 2024 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=shreeya.patel@collabora.com header.b="WuQIpQB1"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CF5192B9F;
	Fri,  9 Aug 2024 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204749; cv=pass; b=jlUWTaESaxEvIpp50HoxniUvLURnDAsM0OaYqotveurmOeEfoOG63HFv2avFCoX/ItO8NYVTrwOGMF4xII1OPmx0ZmrnUs4/l0nBM1Z0y+RljRMXxuSVTfIPxKhBYfnp/Rk2G3JvMzmN4OaDCQbKlbC98V4jSvUHpFhvX1SaI2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204749; c=relaxed/simple;
	bh=ian4pHvk/Ysor0BQM6WTFZw5Oc++xZLQ6te4Io7dcYE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Z0SfhS5zTA/uv4liRmYkyDvvr2YLsStKYrn7uYXYAazAUQBDlwDObUnz94a9jtWQYBQglh2Iaz2lCjDcwFJ0Q9UL07xNGjtDaWoeoBZ9j2hoSyg2O9x0lwRmOGrsDs0KvD1yCj0pKenBGkNxw9MgFGw+/daox7thdaURSjzk/TM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=shreeya.patel@collabora.com header.b=WuQIpQB1; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernelci-regressions@lists.collabora.co.uk
ARC-Seal: i=1; a=rsa-sha256; t=1723204703; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZEIwY7Il0tDeAjVOIkaINZxY95P4A2AZseUheeCfd2GFc04P6gIHL5AQKkdoZK0Y5rplZyZBVBQnCRyxAiME8Sxea7RHv5ngToPVGclAaBJe/Q3JiwEzMJpl0eC6x7AZV/AlrKN1/1r6aj/OqZhaV/wvHy+TYCXTO1zPANrFJ1M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723204703; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7l8Pv9yp1aCfjnBqdkcyjr7Ggfd/MK0caBdzX+atJXU=; 
	b=ZwVoSrlN9Rea22V95PVFar2T/l8kaVm9xLQBs83xCmXcf1mubzoaJM7u4TjsnI0CpLml24qB8hk5EjINegvvdm0A8nIWrHLuZveLBzhsRNNoh7PlmuaeXKJO92yHR32ZorPl34fPnWxqqYYzP1rFXXdGTpSDWY4tbu617G8UEFE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=shreeya.patel@collabora.com;
	dmarc=pass header.from=<shreeya.patel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723204703;
	s=zohomail; d=collabora.com; i=shreeya.patel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7l8Pv9yp1aCfjnBqdkcyjr7Ggfd/MK0caBdzX+atJXU=;
	b=WuQIpQB1FG73qz70zwJLLcqMEKUMAr9KKAaC079Biri4eUd27lTGe9Opk8Xsb7js
	JNoeJpz8T/tqcX8ciID6gkZueJjWqmXyAC2+xayHXbukZaoIrIJlfAc/tb47b0b6rvI
	f8W4HompVrhXyR9su9Wyfpv9MtuFdwQjC69WHu5I=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1723204701719951.467106810877; Fri, 9 Aug 2024 04:58:21 -0700 (PDT)
Date: Fri, 09 Aug 2024 17:28:21 +0530
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
	"Kernel CI - Regressions" <kernelci-regressions@lists.collabora.co.uk>
Message-ID: <19137010dfd.e10dce2c1574702.3469505847442580482@collabora.com>
In-Reply-To: <20240808091131.014292134@linuxfoundation.org>
References: <20240808091131.014292134@linuxfoundation.org>
Subject: Re: [PATCH 6.1 00/86] 6.1.104-rc2 review
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

 ---- On Thu, 08 Aug 2024 14:41:49 +0530  Greg Kroah-Hartman  wrote ---=20
 > This is the start of the stable review cycle for the 6.1.104 release.
 > There are 86 patches in this series, all will be posted as a response
 > to this one.  If anyone has any issues with these being applied, please
 > let me know.
 >=20
 > Responses should be made by Sat, 10 Aug 2024 09:11:02 +0000.
 > Anything received after that time might be too late.
 >=20
 > The whole patch series can be found in one patch at:
 > =C2=A0=C2=A0=C2=A0=C2=A0https://www.kernel.org/pub/linux/kernel/v6.x/sta=
ble-review/patch-6.1.104-rc2.gz
 > or in the git tree and branch at:
 > =C2=A0=C2=A0=C2=A0=C2=A0git://git.kernel.org/pub/scm/linux/kernel/git/st=
able/linux-stable-rc.git linux-6.1.y
 > and the diffstat can be found below.
 >=20
 > thanks,
 >=20
Date: 2024-08-07

## Build failures:

No **new** build failures seen for the stable-rc/linux-6.1.y commit head \o=
/

## Boot failures:

No **new** boot failures seen for the stable-rc/linux-6.1.y commit head \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

