Return-Path: <stable+bounces-196498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBA0C7A698
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D383A35F8
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76DA25EFBB;
	Fri, 21 Nov 2025 15:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lm8OnJDB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066B9155757;
	Fri, 21 Nov 2025 15:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763737431; cv=none; b=VpcemZFqPE30rr0wIHLqkZ/9nHE7a6sdOJ/e6tSUt3BBOfzCua9bNm/knY7D9G/zqOHCg4nuKWkivWFlf6xceKvdVHHjYOHRPwliQ/NBW3x4m4L8rXE1lZArWvs7c4S11Bw7lZkXyOuHTjnpLZuUPqeV4Y5hb48r3K+usB5teOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763737431; c=relaxed/simple;
	bh=4Y010r8OP+aEQDTrEp6aW2CR91SGZ7aMkR2g+id02+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDX8LqexBBg83Bhu0wlu4/00dbVgSujgHH35U2g9kf+Bh+03oO1QdAljQrcrwt6u0WAphx9tL1TNr31X1F3t0Y0UiH2qC8viXmleeZmJU3xOu7G/RZAp75j1feEjeisAToVAfG9TNKT4GSSS47RE4h/oBrkizKhNPQBsB7STD1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lm8OnJDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B61FC4CEF1;
	Fri, 21 Nov 2025 15:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763737429;
	bh=4Y010r8OP+aEQDTrEp6aW2CR91SGZ7aMkR2g+id02+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lm8OnJDBehbBmGJ7X1hIZnEUh4EB1eHF3gULcLdzDXoj0YrwTLRJbREcyOm9KRboX
	 GGaKW9c7UJBQj0qE9/fxthktOvss2pKFWbKeTwAfxnvW8Rz7vKiKz9deAOqLau0+ul
	 U8WUJukFlMRs/Mv2Ay1Wk1/44ZTCO+EN9SeDmuTK37IRuOfl0JYzaUN9UZvDFlWbn7
	 oXFdw04ARCldxMd0Y+X1er1JS+Feu8Brnp7h5LN3f+S0YXDDpMs+xyqu+jcxhV+4xU
	 ZeDzuIvK8fvV8ufLw0tJpeHYtE1tp/SQiz3lOUT9XRCj2bkEg4YKDkRt0lfJfKcOuE
	 yk9Kwb54bF+RQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vMSfu-000000006be-1iiH;
	Fri, 21 Nov 2025 16:03:50 +0100
Date: Fri, 21 Nov 2025 16:03:50 +0100
From: Johan Hovold <johan@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] soc: samsung: exynos-pmu: fix device leak on regmap
 lookup
Message-ID: <aSB_VoKvDUHDbNDb@hovoldconsulting.com>
References: <20251121121852.16825-1-johan@kernel.org>
 <fb573584-4027-4988-a703-7f619fa830fc@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb573584-4027-4988-a703-7f619fa830fc@kernel.org>

On Fri, Nov 21, 2025 at 01:59:59PM +0100, Krzysztof Kozlowski wrote:
> On 21/11/2025 13:18, Johan Hovold wrote:
> > Make sure to drop the reference taken when looking up the PMU device and
> > its regmap.
> > 
> > Note that holding a reference to a device does not prevent its regmap
> > from going away so there is no point in keeping the reference.

> > Fixes: 0b7c6075022c ("soc: samsung: exynos-pmu: Add regmap support for SoCs that protect PMU regs")
> > Cc: stable@vger.kernel.org	# 6.9
> 
> Fix is fine, but unfortunately the code in v6.9 was different and I
> believe keeping dev reference made sense there - driver was relying on
> drvdata. While the leak was there as well, it was intentional. I think
> the leak can be fixed only since commit
> 35d6b98c625867209bc47df99cf03edf4280799f .

It makes no difference actually as holding a reference to a device does
not prevent its driver data from going away either.

Johan

