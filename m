Return-Path: <stable+bounces-192694-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A13DCC3F0AB
	for <lists+stable@lfdr.de>; Fri, 07 Nov 2025 09:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BC794E3212
	for <lists+stable@lfdr.de>; Fri,  7 Nov 2025 08:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBC12FFDF4;
	Fri,  7 Nov 2025 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="in7UIMfR"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424FD2FF67A;
	Fri,  7 Nov 2025 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762505795; cv=none; b=Uwqh4rEOoPd6o57IUFK9TjIrhHegbzoCfkbeux4hVCT8E1oyCjUxsWGOA/k/xNrLss8gfSjQRm/7YD6dfsdcPDpd+wAQSO/niY/8n0U34WbhKiYTx6yM3273xwEef6OetkUkDpRPwrO7W6a7q7lIFIIp6Hw7krBg8SWdKHN+oSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762505795; c=relaxed/simple;
	bh=uSPsDwjs/VlJo9Bkwg+iwk1erlOi+W1GRSg8geucLns=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Q10xk1UEUg+yqr1D5mBTu1Jdao8tBJWvyBPedDLpRO0u+LO6zF1vqjf8559L4JHgds2B8m96IZU7OdYjxVNGZdNIvsW7fp/npTDFeojCSb/7Cswu/E9JLYMxdYlS3eUTgdrCC5XoZWKCFLLsa2FKyZi/CKd/enMEs2lktLcy4D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=in7UIMfR; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762505790; x=1763110590; i=markus.elfring@web.de;
	bh=uSPsDwjs/VlJo9Bkwg+iwk1erlOi+W1GRSg8geucLns=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=in7UIMfRJ55PAg/WCT9a47evm5S9D6ocm5Me5IGeAlwPkr/RLg4OXveSWL3xpCzL
	 BnH1y3XsRkS/mmI3CHY9Gq6lHmaKzH8HNOL2m532iHtyCdhmmiP7XBNQI3swhsE7k
	 bGiNESWgMDUZ+by3S/Jfc0r1Tfcj2THrXFksViFPF2wo/+8GLCNkbp+QwlklMqabx
	 RaUlT0oGY/YntDUQZyMRhhDZhMbAO0944JOmtK42PilTRUtLchVta+qhSc+9UQHTc
	 q95WOfa3cSRLFK6Cjv3wJEJFT4EQe/S8JWCkkjLpHYZmWOYZIdfm48I5+gq8VgrV5
	 uMz4pJx9ArqIYul3Dw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.187]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9qgz-1vKIzI1PBF-00DhCw; Fri, 07
 Nov 2025 09:50:45 +0100
Message-ID: <0bc22da4-8e86-4e15-9aa6-38cb9d9f6b4a@web.de>
Date: Fri, 7 Nov 2025 09:50:43 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make24@iscas.ac.cn, linux-fsi@lists.ozlabs.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>,
 Ninad Palsule <ninad@linux.ibm.com>
References: <20251107032152.16835-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] fsi: Fix device refcount leak in i2cr_scom_probe
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251107032152.16835-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hQlNR4HZb+Gv963lIV7N9a2BYh1GW/Duiojj8zNB5pyxQk0PNA2
 FqYNTAkQGM8D0IT0dwSefK0eslcDH+TYzwd+WZAdm9aOStPbYxGxJiOPbSSXzwMD46aP/q7
 SEslRVUzw0zYqLgpwQIgm9oOW1jwg2vWvp3odVPoNwW8EVF3offCgFDxHb8Jumiy07iC8c5
 gCTzZhhfbfU809+9M9ABg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5ebwiqZlpgw=;+nxQip2PGsS40uL4saz3C7BqCej
 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
 mZ5f2lgPSDnAxzuUlbxrD/dr3UVoVCyaM88=

> This patch fixes a device reference count leak =E2=80=A6

Would a corresponding imperative wording become helpful for an improved ch=
ange description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.18-rc4#n94

Would a summary phrase like =E2=80=9CFix reference count leak in i2cr_scom=
_probe()=E2=80=9D be nicer?

Regards,
Markus

