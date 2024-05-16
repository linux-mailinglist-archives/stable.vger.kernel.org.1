Return-Path: <stable+bounces-45336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0738C7D50
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 21:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1001C2117F
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 19:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B71156F47;
	Thu, 16 May 2024 19:35:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D2914533D;
	Thu, 16 May 2024 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715888128; cv=none; b=LIYEOPfxI1Zmf33L+Jappdn5VDjEtp1ysM6q/2jmgotEgC1/9O3+Xq1q3zf4iTPaAfk2aAfVBNNYnBrrSX7+PN2NtmRc1xEnDRRe2tRR/BF/bYMILRPlynLyrmlJdB/GS1iy6V0f0ES5cRlvxlIjONI6dOg0qAvTw4Y4vtZlFsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715888128; c=relaxed/simple;
	bh=HxNblr+lYujUV+sllqgJgz9/ijNULWiVGYBx4hGQjQ8=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=BPhE9lbuZKP04yyoJJsO6GgdkPXtaNYHh5KV13OEKxjYEeyGIWdgJ0V9YWgaSrFg9dv7LU9ooH4HiES6TNPqIPhy6DHOy+5mwaublrCy98EgWtD4C628Zm1U7s81GtQ/AEWziARevZjU2da81H0CjrZBd/aVHRSKIp4HxfbT+v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id D3D1A37821B2;
	Thu, 16 May 2024 19:35:23 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240516091232.619851361@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240516091232.619851361@linuxfoundation.org>
Date: Thu, 16 May 2024 20:35:23 +0100
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>, "Gustavo Padovan" <gustavo.padovan@collabora.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157562-66466000-1-644d3600@98121497>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?6=2E1?= 000/244] 
 =?utf-8?q?6=2E1=2E91-rc3?= review
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Thursday, May 16, 2024 14:43 IST, Greg Kroah-Hartman <gregkh@linuxfo=
undation.org> wrote:

> This is the start of the stable review cycle for the 6.1.91 release.
> There are 244 patches in this series, all will be posted as a respons=
e
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Sat, 18 May 2024 09:11:43 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1=
.91-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
.git linux-6.1.y
> and the diffstat can be found below.
>=20

KernelCI report for stable-rc/linux-6.1.y for this week :-

## stable-rc HEAD for linux-6.1.y:
Date: 2024-05-16
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3D68f58d77e6715a5ff610e494b147f4111109355c

## Build failures:
No **new** build failures seen for the stable-rc/linux-6.1.y commit hea=
d \o/

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-6.1.y commit head=
 \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


