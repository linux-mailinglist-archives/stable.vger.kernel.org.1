Return-Path: <stable+bounces-55834-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5AF917E40
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 12:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12A01C24DEB
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 10:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EC517BB19;
	Wed, 26 Jun 2024 10:36:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F1A17839B;
	Wed, 26 Jun 2024 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719398200; cv=none; b=Y+rx58kX/P6NJWuoL9laGqZxWdI0M/16VYSobG/A4wfw6EU5ADk9MJRJCZLp09zHw1d9Dw9EDoLJf9Xt/asSz2mnjR4FpH7eRXRZNlwSVGajreBIaaKqjGBHSzi8RA/DDOgTTpXsgHJcgRP5YpzmjDQcjMM5bWFbNiLsPnKgmZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719398200; c=relaxed/simple;
	bh=IuF64xcggOf7VnsuzBkF9RmSIoJAc2M3Z7hOGiWRSH8=;
	h=From:In-Reply-To:Content-Type:References:Date:Cc:To:MIME-Version:
	 Message-ID:Subject; b=ko/lth9aKlTK0Z27C69ncpoU8ROByAyx4l5OLpTQQWhzWF0fa6LK8BARtw5gBVamxYN540HF2ur8XfrpM48/PJjEYTJFpRrywr1uJvqssoxe3AxZgHLHQI74cADzmYlj4PzPDg4A5s9W69M+z5ZG5UhhF6m9lJ9CRKK87ry/CBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from harlem.collaboradmins.com (harlem.collaboradmins.com [IPv6:2a01:4f8:1c0c:5936::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 338EE37810EF;
	Wed, 26 Jun 2024 10:36:34 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
In-Reply-To: <20240625085525.931079317@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
References: <20240625085525.931079317@linuxfoundation.org>
Date: Wed, 26 Jun 2024 11:36:33 +0100
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org, "kernelci-regressions mailing list" <kernelci-regressions@lists.collabora.co.uk>, "Gustavo Padovan" <gustavo.padovan@collabora.com>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <30762b-667bef00-1-529d9000@215728879>
Subject: =?utf-8?q?Re=3A?= [PATCH =?utf-8?q?6=2E1?= 000/131] 
 =?utf-8?q?6=2E1=2E96-rc1?= review
User-Agent: SOGoMail 5.10.0
Content-Transfer-Encoding: quoted-printable

On Tuesday, June 25, 2024 15:02 IST, Greg Kroah-Hartman <gregkh@linuxfo=
undation.org> wrote:

> This is the start of the stable review cycle for the 6.1.96 release.
> There are 131 patches in this series, all will be posted as a respons=
e
> to this one.  If anyone has any issues with these being applied, plea=
se
> let me know.
>=20
> Responses should be made by Thu, 27 Jun 2024 08:54:55 +0000.
> Anything received after that time might be too late.
>=20
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1=
.96-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
.git linux-6.1.y
> and the diffstat can be found below.

KernelCI report for stable-rc/linux-6.1.y for this week :-

Date: 2024-06-25

## Build failures:
No **new** build failures seen for the stable-rc/linux-6.1.y commit hea=
d \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


