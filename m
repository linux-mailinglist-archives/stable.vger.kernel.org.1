Return-Path: <stable+bounces-192442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E3DC32998
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 19:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D89894ED328
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 18:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425AB33DEFE;
	Tue,  4 Nov 2025 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="cFZRyH6C"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB6A333434;
	Tue,  4 Nov 2025 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280228; cv=none; b=bD5UBapVdjzYmcvUns8jIol5RBECCdf5IkwrdDqhk8KPYjnEES4UnZka0+aGfZfSIpISiUrr0WeA/dj1iAlVnvY5fAWRAh5HabyfI60lP6nA8LaTFdfhM7N7ujGGDXUcUTnEACRF2+Vn/kAM8iDgb9ivqWP1NcTy9CanGmgKoyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280228; c=relaxed/simple;
	bh=jFGRPSp0E6tZSdxd/vYW4VCIS+7jN6OBfe0/753lxb8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=MgXHpGJnaL1lMr6rlmyFIKCmrtDTWaNf8cB1whRCdSOENVMwEe+cUf73ic6wLW0xbVd1UUxsB1rDEhUf2cmj9lRiqxK2ELp5sQBn7eylsvmqzsCOvB01JzjKS4SsHETWI13sJwCbNGlJUbcWCVEDEWCFlH1xit879+9ulIFGgHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=cFZRyH6C; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762280213; x=1762885013; i=markus.elfring@web.de;
	bh=jFGRPSp0E6tZSdxd/vYW4VCIS+7jN6OBfe0/753lxb8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cFZRyH6CF431K4d+vhiEPwu5PydRKxpPWRiwlKCScuKc77TMEsOope2hzrHrWWMZ
	 P7mrLHOSd+L0YUveXax1ws/uEPoChURc6UOj1St8clrTUQ0vvEzQjt/Nlm9Np45m6
	 HZReXkDnAihL4AN6GonqGp26ZVx6ltsLhd208GZY4mxs0AHf/WkbJ8OnBsTuYwWoc
	 6h3P444Q66v42Jd6Mcaz6fqQXpSFhXd/7BwoCgAU86pT2d/mG1Ky4YRFHCRH3gDOe
	 TQSXpS+HCbflOY8RoQ/ULfjavmi3YyOTEgAOOBBTiJHeZCCuSznlS5hv1NA2a/HeX
	 OSEaW/Sbxpg+1FdAGA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.227]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MidDR-1vuvSc1N15-00qhmo; Tue, 04
 Nov 2025 19:16:53 +0100
Message-ID: <5adcee29-13ab-4699-86cb-19ad2b05c16e@web.de>
Date: Tue, 4 Nov 2025 19:16:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, linux-clk@vger.kernel.org,
 linux-tegra@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Peter De Schrijver <pdeschrijver@nvidia.com>,
 Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Boyd <sboyd@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <20251104074229.543546-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] clk: tegra: tegra124-emc: Fix memory leak in
 load_timings_from_dt() on krealloc() failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251104074229.543546-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eFvH1K5eBGJldTUdU0Y5SzRdsQuBGqxgE8P3m4hl3xfHwDfiiqP
 xfNWeWCYtgyLvXz+LnnuPFJ5A0b7V0iy5UseeVWhpMMkISho2DSIpyNnc2J5XQc6oAi88LM
 Gd50NUfV88pVgVQg0s+9zig9fSFuZYwXPpKvUwFv6JUjdz7GdU+j0u4Pqg6kBVmGR1ylxza
 0sxtw1wmVUgLl86wIKS4A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nT5nKGbYuLc=;etWp9a+vmJw4dc42m6lIHeh/DgQ
 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
 TmMSbIVHFZvTQ+AoqSdAEL6vZI=

=E2=80=A6
> This fix uses a temporary variable =E2=80=A6

Would a corresponding imperative wording become helpful for an improved ch=
ange description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.18-rc4#n94

Regards,
Markus

