Return-Path: <stable+bounces-210297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAB9D3A3A4
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 10:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B569E3008145
	for <lists+stable@lfdr.de>; Mon, 19 Jan 2026 09:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7050B3043B2;
	Mon, 19 Jan 2026 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="CYALNxpH"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBA625F96D;
	Mon, 19 Jan 2026 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768816138; cv=none; b=UGpx2U0+8gy0MCKtp258Z6lR0NQjLWLUv/RXH5K2ro3Gu2Da2dZq1/8VF6QNoG58SI6KIkTzgVnW2lQPEdOVsMIif0/+IT2vTUv91pm+wtTdGbvGZjI2Fe3pf6i+CcyAvT4Ru0oCzrOHMUpf3lpwNy+IsAP8LioyZNSyqaBQPI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768816138; c=relaxed/simple;
	bh=T/etBDt1Cvyoo1z8f8kYNrCNIDPMKTCHWa49/n7ax+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbq2Uf3fBiKNEO/e/altYXDAtfsECTVrYDKyTI3fdul2l7d4kP9spFkgNW8b3PeLrtT6sEQrXxc6gGHvmc49+Z2cCj/DP6kfKFIUj21j8koxghXaINc+he30/MO11D6e7CrLdLuLXTD0LVT8NHNuxE5BxCxK2VLs5kQUQpchavI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=CYALNxpH; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768816128; x=1769420928; i=markus.elfring@web.de;
	bh=iSLlWQrTFBWaYZULmHbBaFIUgVW48dtHw8buHZr8KbU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CYALNxpHlXKsH+OIdAgBPuN687PQuPH1EY8Qwy0hveMtUhere9yHTyc8tUlj30La
	 9ALXHWBIJ7PL5QvwyUZFbZ/ngzBZIB79FQMV79YgwVupQ0nSVZHvYPDCrcI3yyaSx
	 jW8ec/FpirJrp3BF7eUUGtSNk0v7VG5mmhF5dMnNueqh2s1aXTGp/IVqvk4mRR8ba
	 qfs7iugYt8lJjcsJaEG3AP1DNfFQAlWF1xo5ccgISbepc5sJs+c+CQX+JfZ6W6liL
	 1Wz8oKi4PFLIpxtmDNOtRF5rbY04iqD2DQtRczEy7koYw5Msx25miBHCt0YYKtu1Z
	 RjlvpkI6Tvu46+/jOg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.178]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6JxT-1vsEOn2a1x-00sWA6; Mon, 19
 Jan 2026 10:48:48 +0100
Message-ID: <3a4eaee4-ff01-48b7-bfdb-a127c60d5064@web.de>
Date: Mon, 19 Jan 2026 10:48:47 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/ntfs3: Fix infinite loop in hdr_find_split due to
 zero-sized entry
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>, ntfs3@lists.linux.dev
Cc: stable@vger.kernel.org, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
References: <65bf90b1-8806-4f8c-b7e7-d90193d28e88@web.de>
 <20260118190145.41997-1-jiashengjiangcool@gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260118190145.41997-1-jiashengjiangcool@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R0rSAPIanfBLHE9swb+GMT5Iuq+/gvUQrgN1sVjOC7GDOj161Kc
 Je6uOv34ic4+iYP5QKLbG+Q6uz3KKUmD6+JY9ArVefdPb9On0MKLcw+P7QgnLtkCGEq6FBp
 /ezNgThEJcZp+osZrl+vXSEL5K/5ETStFuu7MQmFvQAv9qiZ4+OqLzdbwwUZDkfI8nCOUtM
 LVkRhWU2++5AnXQ/yBCHg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IjoQfmMCE6g=;zp3D9OWE2i3B9RNBH8/5pCXKQ1q
 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
 QiS1C57E=

=E2=80=A6

> This patch adds a sanity check =E2=80=A6

Thanks for another contribution.

* Does anything hinder to follow a corresponding wording requirement?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.19-rc5#n94

* Can it be helpful to append parentheses to function names?


Regards,
Markus

