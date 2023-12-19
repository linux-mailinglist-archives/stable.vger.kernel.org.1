Return-Path: <stable+bounces-7916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8338187D7
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 13:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F123C1C24195
	for <lists+stable@lfdr.de>; Tue, 19 Dec 2023 12:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461DE1BDCE;
	Tue, 19 Dec 2023 12:45:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2475D18EA1;
	Tue, 19 Dec 2023 12:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Received: from hamburger.collabora.co.uk (hamburger.collabora.co.uk [IPv6:2a01:4f8:1c1c:f269::1])
	by madrid.collaboradmins.com (Postfix) with ESMTP id 40B7937813EB;
	Tue, 19 Dec 2023 12:45:53 +0000 (UTC)
From: "Shreeya Patel" <shreeya.patel@collabora.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date: Tue, 19 Dec 2023 12:45:53 +0000
Cc: linux-kernel@vger.kernel.org, kernelci@lists.linux.dev, "Greg KH" <gregkh@linuxfoundation.org>, "Gustavo Padovan" <gustavo.padovan@collabora.com>
To: stable@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <7160-65819080-3-a1f6870@190077985>
Subject: KernelCI =?utf-8?q?stable-rc/linux-5=2E10=2Ey?= report (19/12/2023)
User-Agent: SOGoMail 5.8.4
Content-Transfer-Encoding: quoted-printable

Hi Everyone,

Please find the KernelCI report for stable-rc/linux-5.10.y for this wee=
k.

## stable-rc HEAD for linux-5.10.y:

Date: 2023-12-18
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.=
git/log/?h=3D17eb2653990e369bcef47f69a554147997ac4dd3

## Build failures:

arm64:
- defconfig and defconfig+arm64-chromebook (gcc-10)
- Build details :- https://linux.kernelci.org/build/id/65806f8b090acab9=
cbe134e1/
- Errors :-
   drivers/gpu/drm/sun4i/sun4i=5Fcrtc.c:63:37: error: implicit declarat=
ion of function =E2=80=98drm=5Fatomic=5Fget=5Fold=5Fcrtc=5Fstate=E2=80=99=
 [-Werror=3Dimplicit-function-declaration]

arm:
- multi=5Fv7=5Fdefconfig (gcc-10)
- Build details :- https://linux.kernelci.org/build/id/65806f2d8bfb9b6e=
d5e13499/
- Errors :-
   drivers/gpu/drm/sun4i/sun4i=5Fcrtc.c:63:37: error: implicit declarat=
ion of function =E2=80=98drm=5Fatomic=5Fget=5Fold=5Fcrtc=5Fstate=E2=80=99=
 [-Werror=3Dimplicit-function-declaration]

## Boot failures:

No **new** boot failures seen for the stable-rc/linux-5.10.y commit hea=
d \o/

Tested-by: kernelci.org bot <bot@kernelci.org>

Thanks,
Shreeya Patel


