Return-Path: <stable+bounces-55952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 985FB91A566
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 13:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C41287533
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 11:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2C1149009;
	Thu, 27 Jun 2024 11:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="bWfhjKvQ"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC541411EE;
	Thu, 27 Jun 2024 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719488047; cv=none; b=U6zLd0+px8T5+x7kASM3GucnoSrMO5eXmr+G96kmxm+E+4MgEA1EkVHWXuOGUAOiORMVFTx7IGtokkXtskOEkRD6BvprfgRdwfGDVA8Q61k5SrDozM+n3lJjoN7m5O37jvxwlasd9hlBBo5QgNq1bue/If4lWMbdAXoKDeXz3oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719488047; c=relaxed/simple;
	bh=uhXbGazcXeqkxXjBouKM0MQuQ3CTfNGpf2RScCZD55M=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=apuzxgPN68Fef9V9vx1JtOSm4jWrj2KE8VfS6cJ4F82GJz7Z9Ug/xebsEcOdBgPvUcGkL9DwVbw/Rhb3FSGWxR6LU+k0mWkq7oRl/pnGUz/hXt2DUGbDejaZLNY7q5zhJ8orCPHCT6l0/WJqLJB+Y/19PVQg+KIPcZCCILxSlkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=bWfhjKvQ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719488022; x=1720092822; i=markus.elfring@web.de;
	bh=A7rM3y/OMnB34PKR/RnqFiGJ+fS+Qyq19jgyL7mRwdI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bWfhjKvQNMn2j1KF83zywHnz+eoZxC6KaKuZxFmkweB+9RqypJ1Ah6Ia+fGBWyUc
	 wv2ZVxfjRKCUldkP+B4V7a8eytwO9I49N5dDLv8Z0DbspzNOW7v6nR13IJMbB1RnS
	 kiZm9647+hc4Nd4WkG7ak+v1XNEyo8FrHIudpjqbgZBPkt6q4UbrcJ3c4tJzTjGu2
	 q9URQkqRnqAMqhx8OIKYUJult7ZEjOz0jyTMFdRttKZEmzyXs7Pde6/UtgIHcktLp
	 PdtQyzTL0WNthjIl6kPn+Jphf5Kgo71LXqm65TO2Rf6XKf3X+NcpFME7YyUPYxACi
	 FTgaA0+vys9tcV/XGg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MnG2Q-1smGJO2SPs-00cmj0; Thu, 27
 Jun 2024 13:33:42 +0200
Message-ID: <eb14ae3b-7a4f-4802-b9a7-9ffec3b951f9@web.de>
Date: Thu, 27 Jun 2024 13:33:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Ke <make24@iscas.ac.cn>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 David Airlie <airlied@gmail.com>
References: <20240627063220.3013568-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v2] drm/gma500: fix null pointer dereference in
 cdv_intel_lvds_get_modes
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240627063220.3013568-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AOehDKKFPtxRHQPkx+LUzANkyLhTBUvzpw4KeRmCd3rgH5fsgxR
 4hB57cBBQdjqt/ClaW4nBIog+T3Iadd5g5BlQPDYfJxlRtY3+TphaqUqIwXuOaBgcZa14VW
 vwMQmNT62qmSdaQH/4h5xTD/ZEE1kdLUYZy0U4cXKdxNpOEvVoz29cuP12WOzg9ha7023tX
 fSddlKToMHvRrbkMH+QbQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JG+JqApF6Yc=;luGoJh8GDXk11DTuBXjZEvPBHkd
 ixtgHsNKOZX0DvF+p189t6tpAq8fTCFLkM8GQaKiPdUFZWMFof0C3W1dx4dARME4ukLKR1pe2
 wbmQuRGMbppG3tKXuLIdgjWsi+hrNY2jWcCaIPOZgP++KRFWMc9Eub/Mku0q6s615bAEr2110
 1UwtrJ8Gjf+Qc3Lqn6iLIb3XHp4JFPJgbsgXKiqsPtJQqsjTfJ1+aEimYnmfOdZeZLOHp3qtK
 FQr0o7xtcGnw3aVWWqi6GCbsdiCkVs0anW3WwRMkPuTWhWel0AkyAqvmyp9kq4i9of74nQNxM
 sDaHBQ4DwM4kgYJmVFh7RRiG2pnLL4c8ZPtbJkPzb+o8jCJkrEgz04YqGduIeUcbYobBwzL9v
 OjTm6hJ9QfnFQPi/De7zjiAaoAVnCwIMErYQOhdC4Kd8wt0wKl8bPybf5XDasS+r1l71oY2a/
 Q07IBWEnaFWVp21tTOSVTbNMPdtNLkr/muzQ6dX20xAaRikGiz9zyheNOCyJBvLpx0icKW25m
 pGJLMGX9FzAVTlwVSVs8wwuCxHnQz+jsCOn32KEayKGbl5nHDDx5vxmX1KofAR6ECRrRIZNl9
 IcOWdBnZsXkmCbpUPrQ2ICXhKFaMmx+IG+I+iZRyP8HFmlfxp4igmSX+fgVxXO4sjV1rgYl1H
 2uj1VWk88o6zIzmXXo/cDNzmGNRWAKBVHv4Typ+M2Q87VMLqEmg07gQGDOpRd/sSXGDndx2/Z
 YLNCn2mvqiYNNvxZoiokcMSsOiltY5kEA/RnrJ7BwIEtRUj5b2KDPLP7WjWe1BL2U2SLLk+tr
 kI9ozjveIVyvrDXhppRPlI22vu5gyFjXudWSg+0FCqvjk=

> In cdv_intel_lvds_get_modes(), the return value of drm_mode_duplicate()
> is assigned to mode, which will lead to a NULL pointer dereference on
> failure of drm_mode_duplicate(). Add a check to avoid npd.

A) Can a wording approach (like the following) be a better change descript=
ion?

   A null pointer is stored in the local variable =E2=80=9Cmode=E2=80=9D a=
fter a call
   of the function =E2=80=9Cdrm_mode_duplicate=E2=80=9D failed. This point=
er was passed to
   a subsequent call of the function =E2=80=9Cdrm_mode_probed_add=E2=80=9D=
 where an undesirable
   dereference will be performed then.
   Thus add a corresponding return value check.


B) Would you like to append parentheses to the function name
   in the summary phrase?


C) How do you think about to put similar results from static source code
   analyses into corresponding patch series?


Regards,
Markus

