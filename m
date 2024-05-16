Return-Path: <stable+bounces-45338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CF08C7D80
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 21:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0C6F1F21522
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 19:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4CE157480;
	Thu, 16 May 2024 19:53:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EF6156F5F;
	Thu, 16 May 2024 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715889219; cv=none; b=DiKKX9U/BFqFIhMZYb1zTpVsThWLjJ85bXJUcCLCFDqTQG5M+hGlvjiM10cPSkBRoVkdv09mEkBTwq1hJz2iqagIckaykBuuLcB78r1YzKFqsCu9aHKkFxYHwuGacoGO1kScKsoh6VCEoNKOs6sJPY+uQxSWiA0G3fpZfnXq1Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715889219; c=relaxed/simple;
	bh=u/X9mTE0RnR0jAnqMb7OrzYVD/mhPsMuXwrlI1sa3pE=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=nFbkasDoYAA/54BCFWdbNShoiJ0Qk7i5xlmOGh3WSDt7y5cI16VPYneAIxbNWUlzj2PvjlFRIT5tn4gZYscXVw3iOHysDMvZ9NKmD5j/LwS3w/2BuM7sSBsDziOv1KWFz3xM+eT3j5rIxpkr1xvIzJfnk+pHsZK8P6rTHcm5mYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 3F6E737821B2;
	Thu, 16 May 2024 19:53:34 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240514100957.114746054@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240514100957.114746054@linuxfoundation.org>
Date: Thu, 16 May 2024 20:53:34 +0100
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>, "Gustavo Padovan" <gustavo.padovan@collabora.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <15786d-66466400-1-14833a60@186321255>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?5=2E10?= 000/111] 
 =?utf-8?q?5=2E10=2E217-rc1?= review
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Tuesday, May 14, 2024 15:48 IST, Greg Kroah-Hartman <gregkh@linuxfou=
ndation.org> wrote:

> This is the start of the stable review cycle for the 5.10.217 release=
.
> There are 111 patches in this series, all will be posted as a respons=
e
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Thu, 16 May 2024 10:09:32 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.1=
0.217-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
.git linux-5.10.y
> and the diffstat can be found below.
>=20

KernelCI report for stable-rc/linux-5.10.y for this week.

## stable-rc HEAD for linux-5.10.y:
Date: 2024-05-15
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3Db060558757cd289ee28acda55141de096e699854

## Build failures:
No build failures seen for the stable-rc/linux-5.10.y commit head \o/

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-5.10.y commit hea=
d \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


