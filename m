Return-Path: <stable+bounces-128453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226A0A7D565
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 09:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC5C171DF8
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 07:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EBF225771;
	Mon,  7 Apr 2025 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RXDCWCMN"
X-Original-To: stable@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F5F21D3D1;
	Mon,  7 Apr 2025 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744010234; cv=none; b=rKaj0+kpBm5jaWFVifuaS/kIp5kFZfSy9UvOZSOAVSDPy+9bcd104Yzb2kj5jvpZCy49N0FbP+bJMk0TkuuPAefXDUz7tZYuvNnMgzM0sNixZDurlFujJAiFJYEoIMFBWL5dRLgIIAfs/LYi1r3xaigaiZ4+S320gGx4p/wUQsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744010234; c=relaxed/simple;
	bh=zKwzOYh8aAJuS+S3TkD57w5LMO2QhltXuYUO7CZQNWM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SDi3Vopa1uJtxzDkSezu3Q3jqsdiYBwS2yiOo/Y5WEZCeYv9ahrc9V732xcJS40DTFFZrqkKE0Fiey7oVooIvwwLBnLDQ5VaupUCoQGX4XNVqRZsosvw+n0DxZcgXxaT2V56wVEOz7dh9wj3WMDItu3fOAy8HoY9hVIk0OJRN/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RXDCWCMN; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 84A8820579;
	Mon,  7 Apr 2025 07:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744010224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zKwzOYh8aAJuS+S3TkD57w5LMO2QhltXuYUO7CZQNWM=;
	b=RXDCWCMNUclxLzRL6AiK1Fmxi79I2R8O37PVEhcp5lNPDKqaT2r42YJRp2/v6lyOzf7QvT
	Poqw1OEyv/XO2jhlihzZshc2WMeMl7V4OOVUlEQNW5c7VVdVuhAEUy4ZkefKIl9703X1Lx
	aAi1UzRmliogVdI/Dzk5IgeFfmxAWEkSE9Kw0iXCYDiRyFV4nqEO1cGUZiFM0IWD5b7G5o
	DU2u9aAZF+fuxVjmSuQ9BSlPVAT+BkcQ53Xvf2ODYFcAKdiGeaAGrYC4gKCtMlUnUXrwXJ
	ZKOPY2qIfBOv/d9TlmMIKVrLwer5cQD1ax7aZq/lwXkJYaybnVH5MuItoHd4cA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Pratyush Yadav <pratyush@kernel.org>,
  Michael Walle <michael@walle.cc>,  <linux-mtd@lists.infradead.org>,
  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  <linux-kernel@vger.kernel.org>,  Steam Lin <stlin2@winbond.com>,  Jean
 Delvare <jdelvare@suse.de>,  kernel test robot <lkp@intel.com>,
  stable@vger.kernel.org
Subject: Re: [PATCH] mtd: spinand: Fix build with gcc < 7.5
In-Reply-To: <20250401133637.219618-1-miquel.raynal@bootlin.com> (Miquel
	Raynal's message of "Tue, 1 Apr 2025 15:36:37 +0200")
References: <20250401133637.219618-1-miquel.raynal@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 07 Apr 2025 09:16:59 +0200
Message-ID: <87ikngh250.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduleelheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejgeeftdefledvieegvdejlefgleegjefhgfeuleevgfdtjeehudffhedvheegueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeelvddrudekgedruddtkedrfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddtkedrfedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehtuhguohhrrdgrmhgsrghruhhssehlihhnrghrohdrohhrghdprhgtphhtthhopehprhgrthihuhhshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhitghhrggvlhesfigrlhhlvgdrtggtpdhrtghpt
 hhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

On 01/04/2025 at 15:36:37 +02, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:

> __VA_OPT__ is a macro that is useful when some arguments can be present
> or not to entirely skip some part of a definition. Unfortunately, it
> is a too recent addition that some of the still supported old GCC
> versions do not know about, and is anyway not part of C11 that is the
> version used in the kernel.
>
> Find a trick to remove this macro, typically '__VA_ARGS__ + 0' is a
> workaround used in netlink.h which works very well here, as we either
> expect:
> - 0
> - A positive value
> - No value, which means the field should be 0.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503181330.YcDXGy7F-lkp@i=
ntel.com/
> Fixes: 7ce0d16d5802 ("mtd: spinand: Add an optional frequency to read fro=
m cache macros")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied on top of mtd/fixes with an unrelated conflict resolved.

Thanks,
Miqu=C3=A8l

