Return-Path: <stable+bounces-66261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 692C194CFBF
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 14:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA291C21031
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BCE1940BC;
	Fri,  9 Aug 2024 12:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=shreeya.patel@collabora.com header.b="Hdw4okfY"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753AF194096;
	Fri,  9 Aug 2024 12:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204991; cv=pass; b=BI6QAjVPMZOLTxPAO/ghC8QbSrAYrih8gNA2L02R9VIJLEKANFSWZ6iJuKtrgSEdA2QLE99i6xUjsSf8ZTBrorkjw07PxNx4EpDIT0jusJgF1Nxg3eofzr3r2QM+j41VvJ52ffM9JA5qZxUKN+CC9JVAejBu2L3VYqRneGU8GNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204991; c=relaxed/simple;
	bh=wGkwUohVNLndbIamFN4xOX/P3GlwXTUpJSk0kQg1wkc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=iMvDgdlvojWqZv/VDodTcc+2FhOemDUAW/ajOoHXps+/iFmbi1wFlpaKPbmKptevLTwpC+0qZvJ1ArOT0zhmsELcmBJyuQmCh5FGRgGbnIUdcvEYkvYwxpIzzF9FBpqE1nUgKB7XHJG3p2QlVcDo521W6l0ESfTOcljwCWnY2SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=shreeya.patel@collabora.com header.b=Hdw4okfY; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernelci-regressions@lists.collabora.co.uk
ARC-Seal: i=1; a=rsa-sha256; t=1723204961; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PHs7oKJ3xrlYQwPA9nW/jpcIYnBUXQWwWmIlkox5nK72wKxy/e+YqcXrsCN+vo7IaTLzwert7wvRMaYtTOLCQGfn6xl9OH7JnLL604dY0qSB/v4YS32S7r9SDp93LDL5Vn25aVSL0smTgFV6g66gscfjdLT3ltfSx+MEBMJi1/o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723204961; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4HEIDREWE06W+7GY7sqDFMvOvx6ZF8VSqRxxHbTi0KM=; 
	b=S2XODdS1nFCdYOTO+bBYKeetBjAQc0OIOpFm2QEG9KmFJmxbUH7d0J+xZ5p6VKxuak52Mt7syxEwNaOOWtPtnMoDuw5wzGeOgtjgqRG9H9aOFEDXSkChiVKN8BmWABCMWkRiGMuvVPOCCG71nCwih4S/2Qr6/u8kQrOcoQ7kS0I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=shreeya.patel@collabora.com;
	dmarc=pass header.from=<shreeya.patel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723204961;
	s=zohomail; d=collabora.com; i=shreeya.patel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4HEIDREWE06W+7GY7sqDFMvOvx6ZF8VSqRxxHbTi0KM=;
	b=Hdw4okfYJcXc/TOIw8xuQI4hKkIfvKhYfmMqXALpesJ049MCL400EKkZ/FYjQ0NX
	HRYjThjLygBQi9Qlhud5mB6BnsVlgW+nJleq0o1fDNmbO7exzqKMeKHPMR3dORvuEwc
	aBcTdKQnNWWxWX3uJMRB2s/GTMolNdSDPXknAHig=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1723204957029167.3767237069119; Fri, 9 Aug 2024 05:02:37 -0700 (PDT)
Date: Fri, 09 Aug 2024 17:32:36 +0530
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
Message-ID: <1913704f31b.bb4acdc11576065.5566649589990419370@collabora.com>
In-Reply-To: <20240807150020.790615758@linuxfoundation.org>
References: <20240807150020.790615758@linuxfoundation.org>
Subject: Re: [PATCH 6.10 000/123] 6.10.4-rc1 review
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

 ---- On Wed, 07 Aug 2024 20:28:39 +0530  Greg Kroah-Hartman  wrote ---=20
 > This is the start of the stable review cycle for the 6.10.4 release.
 > There are 123 patches in this series, all will be posted as a response
 > to this one.  If anyone has any issues with these being applied, please
 > let me know.
 >=20
 > Responses should be made by Fri, 09 Aug 2024 14:59:54 +0000.
 > Anything received after that time might be too late.
 >=20
 > The whole patch series can be found in one patch at:
 > =C2=A0=C2=A0=C2=A0=C2=A0https://www.kernel.org/pub/linux/kernel/v6.x/sta=
ble-review/patch-6.10.4-rc1.gz
 > or in the git tree and branch at:
 > =C2=A0=C2=A0=C2=A0=C2=A0git://git.kernel.org/pub/scm/linux/kernel/git/st=
able/linux-stable-rc.git linux-6.10.y
 > and the diffstat can be found below.
 >=20
 > thanks,

KernelCI report for stable-rc/linux-6.10.y for this week :-

Date: 2024-08-07

## Build failures:
No **new** boot failures seen for the stable-rc/linux-6.10.y commit head \o=
/

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-6.10.y commit head \o=
/

Tested-by: kernelci.org bot <bot@kernelci.org>


Thanks,
Shreeya Patel

