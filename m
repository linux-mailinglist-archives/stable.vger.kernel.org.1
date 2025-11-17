Return-Path: <stable+bounces-194972-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F33D6C64EFC
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 16:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id AB5AF28F80
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 15:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337F027F163;
	Mon, 17 Nov 2025 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="GaOpkWBJ"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5DF7405A;
	Mon, 17 Nov 2025 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763394397; cv=none; b=AaLFJ7OVqnMQ0q9XxhglU1Wy0OxzfFAIhpvkgQj2So+qEkfb/qmtmEZWesVPOEZcaBKyMj6VplOqIOwvnX1QaWwgLiFbr6BrsVJqnPcDMnIYbMIcYGSCyq+/VnKqqqpcUaGyW1Vto5RKqMl+iLFElgCKw4MQsRfp46eztL3JJqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763394397; c=relaxed/simple;
	bh=RSfwycPa2lRzQ6UKFsIpD/D1F4mUKT2Hrf9ddoILY90=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ONw+G3sX6PnEHEjofyBKx3m6mUNMlQA5uLhs/ElGF+orRpnGoEeKNyuaNZQNOizhp4V0Bfm6vBg72TPO2CJuGRerwefdox33mtEdO7VWs7izgbZP06jvCNctP+GmQKhyp7zTYpGNQFVJhI2wk0kV8+SUUqF5hHBDS5xkYV67nmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=GaOpkWBJ; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1763394374; x=1763999174; i=markus.elfring@web.de;
	bh=NcpdU1qcDj+cfUSYRyOeyIiwyTjdzC84+9966PNtqIE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GaOpkWBJNR2VCseSgR1tqBzLSorABLRZCMRobQsG1DF4lXghZHvLvHStwoYl1fdi
	 XMkC/IvuLg6tkLjMxjPZjQKxwKU3944pWZgX8G0XHQjHNFdj2JC1xcwXOdX42E8mU
	 VvSqQVomtqXGx7AmEuUjP4n7QTA0AubBtYNp1xZ99A0ueOb3mpgziyraIESLQlhRZ
	 MJmRpE7JdVJZgazklzzYJfuhiUDN1KpKReYOZ23GiKhDN+BJH8s/wqrmgadUFzdWi
	 q/W1srC/rEsf06JZ66yY5zKeEmaQdEgKevKsRXX8wh7uErcxmc9VjhKRMPyhtyKgG
	 GNeut8hxg0dexrSzvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.218]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Md6tr-1vtWty44ZP-00qMkx; Mon, 17
 Nov 2025 16:46:14 +0100
Message-ID: <4ccf660b-9bbe-4f2f-8237-295f6d6f70f9@web.de>
Date: Mon, 17 Nov 2025 16:46:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make24@iscas.ac.cn, iommu@lists.linux.dev
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
 Will Deacon <will@kernel.org>
References: <20251117033943.40749-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] iommu/omap: Fix error handling in omap_iommu_probe_device
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251117033943.40749-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ho3EFzpVH+gfC909V4Csd03/RyWmnK7LU+NQxJcJlx5oBfyX4gM
 MkTcgNQBU9dgh4E6y2jc9nHULKJXrs7SZppJ0crsYMk/7BMWBFWAqmxD/3WrUpwcMBovnih
 /eOGEFXkXBX2XFgnU0Oj1ivuqMdtza0/zOXXQzLB35FfBLJHV+ea0Y1zYMtgc1lx9Mn6AyP
 8e+TE37eRmuehXJ2HOwyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ss4mWrEs37A=;9D/ybaFUXZ11Xxt2/X5YIlNsG1X
 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
 hisIjDHUE5m2E+ABA=

> omap_iommu_probe_device() calls of_find_device_by_node() which
> increments the reference count of the platform device, but fails to
> decrement the reference count in both success and error paths. This
> could lead to resource leakage and prevent proper device cleanup when
> the IOMMU is unbound or the device is removed.

1. See also once more:
   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.18-rc5#n94

2. May the statement =E2=80=9Cret =3D -EINVAL;=E2=80=9D be moved behind an=
 additional label?

3. Would it be helpful to append parentheses to the function name in the s=
ummary phrase?


Regards,
Markus

