Return-Path: <stable+bounces-127039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E41A7636F
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 11:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83B2C1888EC9
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 09:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CB21D5173;
	Mon, 31 Mar 2025 09:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FevU2XEL"
X-Original-To: stable@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0B413A258;
	Mon, 31 Mar 2025 09:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414275; cv=none; b=FYtx0Zzs10wIbFmeIxemusMc9AtfnX6rIkgU0baVB/uq5skjg1jp3gQFo827qC9wSCssNBhmOerX/17jdDV+0/KL4lH4SvrVs+Dod67R/KOFhJ4u7ypVfj94K2gUym5ThJBFs0azAIOjIQl47L7+mCJlsAn8vUsmicUml3kv/4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414275; c=relaxed/simple;
	bh=tN6etfzxU77e6hXydd6b4k5v0fg8n79AGyUaCxasxw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqNIxynsw4oscVuJ02e/cDXiNAeX3DKcauoxFbbVdHmoVpR14+rn9Xk3k8tRVcK9bPyrWhkiQQKia0zlMagVK2gsuxf2S3LZYauIvqASkRXzAbA7yjtDnfYU9sdgCtVx5mHvLmMvTp2ybdsJshxyo54ryyHOVp/esvDIK8BXqyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FevU2XEL; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0176843349;
	Mon, 31 Mar 2025 09:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743414266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n1haYXwSDfLoyUzdskKRx546yxBk0+SAnC6Wt/ZsG0Q=;
	b=FevU2XELa05ufzVSvCVRwpM2ooN3CCusOtTsHKdk/4fJkAFc1TicFKMPBOsqm0PrgN3bs1
	XqNQing+Ht1zXLTvWYaRAyPS1/mqTYiW8c7LWGxltD0GnMp1wE2WXmGVYwuzHZXBW6zjq5
	7/0dcV9aMI1mMnNLSpqhxby2GaLFHwsUfpxXiaejSpFTd365FTJBe19c8Hti/P3oC5Gtk5
	gRYiQ9NhUSqUvFhTWsqxvuhIal0Vcm+f1q7gkT94Rvgg3ilycR5ykfuVzOg3tQK1hNLWLM
	Q95PKVWXlezSVs9eKFmojuErpRH0sEqUP6DP5mBF/i9lfgRVDJV1sTJUgrB9Rg==
Date: Mon, 31 Mar 2025 11:44:24 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: arnd@arndb.de, gregkh@linuxfoundation.org, bbrezillon@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	frank.li@nxp.com,
	Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
Cc: rvmanjumce@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v6] i3c: Add NULL pointer check in i3c_master_queue_ibi()
Message-ID: <174341425769.1100556.13422322396999492211.b4-ty@bootlin.com>
References: <20250326123047.2797946-1-manjunatha.venkatesh@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250326123047.2797946-1-manjunatha.venkatesh@nxp.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeeliedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheptehlvgigrghnughrvgcuuegvlhhlohhnihcuoegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedviefghedvvefhheevjefghedujeekfeeuvdfhgeduffduveehgfdvgeejheejvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemugekjegvmedusgdusgemledtkeegmegttghftgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemugekjegvmedusgdusgemledtkeegmegttghftgdphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghlvgigrghnughrvgdrsggvlhhlohhnihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrt
 ghpthhtohepsggsrhgviihilhhlohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhifegtsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrrghnkhdrlhhisehngihprdgtohhmpdhrtghpthhtohepmhgrnhhjuhhnrghthhgrrdhvvghnkhgrthgvshhhsehngihprdgtohhmpdhrtghpthhtoheprhhvmhgrnhhjuhhmtggvsehgmhgrihhlrdgtohhm
X-GND-Sasl: alexandre.belloni@bootlin.com

On Wed, 26 Mar 2025 18:00:46 +0530, Manjunatha Venkatesh wrote:
> The I3C master driver may receive an IBI from a target device that has not
> been probed yet. In such cases, the master calls `i3c_master_queue_ibi()`
> to queue an IBI work task, leading to "Unable to handle kernel read from
> unreadable memory" and resulting in a kernel panic.
> 
> Typical IBI handling flow:
> 1. The I3C master scans target devices and probes their respective drivers.
> 2. The target device driver calls `i3c_device_request_ibi()` to enable IBI
>    and assigns `dev->ibi = ibi`.
> 3. The I3C master receives an IBI from the target device and calls
>    `i3c_master_queue_ibi()` to queue the target device driver’s IBI
>    handler task.
> 
> [...]

Applied, thanks!

[1/1] i3c: Add NULL pointer check in i3c_master_queue_ibi()
      https://git.kernel.org/abelloni/c/bd496a44f041

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

