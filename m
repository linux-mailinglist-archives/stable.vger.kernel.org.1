Return-Path: <stable+bounces-66259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFE294CFB7
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 14:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC210282DD5
	for <lists+stable@lfdr.de>; Fri,  9 Aug 2024 12:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994B0155CA5;
	Fri,  9 Aug 2024 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=shreeya.patel@collabora.com header.b="HqQLfbln"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A94142E6F;
	Fri,  9 Aug 2024 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204909; cv=pass; b=BxSd60HDFpgn4ftBa4fkPalCnjZsqVjED1HnxhrmUWLvGQjsnNGsXGxgvOIcBtxjFA6fudbYTbFiZeCwr3fapdaS9paDEhZ+CYYhCumk1KtBg0a3DjmpP3OlSo9COMA35PGXOp06qm/iqT7JpYckY2b4897HwkPL9ah/IzmuU9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204909; c=relaxed/simple;
	bh=Yb6RVH1GPgwrNKToQeW+Uavj4I0qavxiLgEj6xdHOXU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=uYE4h+4ADFwBkb2hxvzyT/FcYlHZ/BrLi3pPKyTPHacwbPKjy/Ggw2WFIl2Qj1R2aPcF/S/Pqc5eFfF9oizC59VxAmJBi8WU+aHJQDf3hgwuwNqOZBtbo03vyOSZJnIuAS1CiHkQMxWccOFnPE75HO4osW3pZ+qp74fEt7oHNyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=shreeya.patel@collabora.com header.b=HqQLfbln; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernelci-regressions@lists.collabora.co.uk
ARC-Seal: i=1; a=rsa-sha256; t=1723204879; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=g1Pgp8F1XxS6hFQYedRnDaaOURYPQFyO0T+a2U/ZiH0j3e8gDIKpyxmfzVZ9rHAjOwzAI+UDiffk2bEyydTs/0whj+lMyNBOpxcheEw0pBECWb7/U9Zj+SKHkwKF7IE7FLnH+JVLKnASYHbu3ryG7T+Y6Sh08W/z0ND9yWJClpg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723204879; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=N0qMPVBikYrBe7DSFxMdYo4dSDC/aDNuJoE8KMyICWE=; 
	b=B1lFiEdcXAYBKZbiWtwC8Jo1wyhBaSNe7ZnUiDZ5ohkDMuXAEQqbp3B1EXlahYNgQmCybR89YEteLblBeh9A9m/1XjEGGWeLB7WixKIa5UxA7eM2xTp8XJ83QnVuTsoXGud2utCf6G3Azlg9hCktXmkhJIIE8RCXznPiTaFAvIg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=shreeya.patel@collabora.com;
	dmarc=pass header.from=<shreeya.patel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723204879;
	s=zohomail; d=collabora.com; i=shreeya.patel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=N0qMPVBikYrBe7DSFxMdYo4dSDC/aDNuJoE8KMyICWE=;
	b=HqQLfblnDqwQE+FGdTGSWxGnB///COdsXy+z0abi7dDgQvQ+KNY6L52ufnAX3lpK
	es+4cwM4u5eXIhHXTtmIEk4mXeCsiB3cFiSAC030szyeiGoUeUM0ptFSbDvQYMntbrb
	t8MH3pKB0EX0ZhgZgJN3WBgaVSNbSRrvC/GhclVk=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1723204878331742.4144428333856; Fri, 9 Aug 2024 05:01:18 -0700 (PDT)
Date: Fri, 09 Aug 2024 17:31:18 +0530
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
Message-ID: <1913703bfbb.1194e228d1575686.7035047079283536787@collabora.com>
In-Reply-To: <20240807150019.412911622@linuxfoundation.org>
References: <20240807150019.412911622@linuxfoundation.org>
Subject: Re: [PATCH 6.6 000/121] 6.6.45-rc1 review
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

 ---- On Wed, 07 Aug 2024 20:28:52 +0530  Greg Kroah-Hartman  wrote ---=20
 > This is the start of the stable review cycle for the 6.6.45 release.
 > There are 121 patches in this series, all will be posted as a response
 > to this one.  If anyone has any issues with these being applied, please
 > let me know.
 >=20
 > Responses should be made by Fri, 09 Aug 2024 14:59:53 +0000.
 > Anything received after that time might be too late.
 >=20
 > The whole patch series can be found in one patch at:
 > =C2=A0=C2=A0=C2=A0=C2=A0https://www.kernel.org/pub/linux/kernel/v6.x/sta=
ble-review/patch-6.6.45-rc1.gz
 > or in the git tree and branch at:
 > =C2=A0=C2=A0=C2=A0=C2=A0git://git.kernel.org/pub/scm/linux/kernel/git/st=
able/linux-stable-rc.git linux-6.6.y
 > and the diffstat can be found below.
 >=20
 > thanks,
 >=20

KernelCI report for stable-rc/linux-6.6.y for this week :-

Date: 2024-08-07

## Build failures:
No **new** boot failures seen for the stable-rc/linux-6.6.y commit head \o/

## Boot failures:
No **new** boot failures seen for the stable-rc/linux-6.6.y commit head \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel

