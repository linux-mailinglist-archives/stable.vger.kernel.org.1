Return-Path: <stable+bounces-116693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA8DA397E6
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 11:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D7183A2096
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 09:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2B1233157;
	Tue, 18 Feb 2025 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="N5zQMtti"
X-Original-To: stable@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2770322FAFD;
	Tue, 18 Feb 2025 09:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872389; cv=none; b=BmRvbkvIYMIvSPCtu76EgpJhkrApVSKb1MzSusOweQ2NEIsYzn3EPr5xX0QAKg9aaK2GRki+vyEY7lyWPE9zcMut6+J5yva0URfMY5sXcZy26PN8U18jmcdNgGPb5jgq3U8nCIx388GcNkX/VAHXyLYNNr0s3k+LcSrG9RD29TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872389; c=relaxed/simple;
	bh=h+2PNpWdm302meQLu62UOxtxhiKhPwOHpiRCly9oUCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A42q/6Zo9P3KTQ2g1H9uvgcguZR16vGSCfMiif0AwOo+02wlKgB5GyFT7t3RsurAy0LwYjUtYtfRFIhxdo0FfoC4YGSWLG/t/O3mfRUgIs0LSUe4rubkv1X5lAQF335utIkQUOamtxkjmVDN3VezJ+3PF+zs1JoK+rUovpA6IWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=N5zQMtti; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=alsVGP82I8tUPKjw6ZLez29MzizoXC6KfuvyinlS+/4=;
	b=N5zQMtti6LqtMCrUtZFWLRifSuyRdSq9eUreMR1Y+Nib9dyJtawrjwWt23acGj
	15+xFh2eZH73lC3RLBFpVlRo5nzw8QGSZWvD1iXBUg0mxiXnpU+noyFNirFZ9kT2
	+zHn1d2pPwmFQ5YuVCWmy70Z/Ju7lYlijete4/UdU/Z+I=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgBXDlplWLRnXD06CQ--.18498S3;
	Tue, 18 Feb 2025 17:52:39 +0800 (CST)
Date: Tue, 18 Feb 2025 17:52:37 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, max.krummenacher@toradex.com,
	francesco.dolcini@toradex.com, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] ARM: dts: imx6qdl-apalis: Fix poweroff on Apalis iMX6
Message-ID: <Z7RYZbBagvnMdy0i@dragon>
References: <20250110151846.214234-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110151846.214234-1-eichest@gmail.com>
X-CM-TRANSID:Mc8vCgBXDlplWLRnXD06CQ--.18498S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF1xZr4ruF4xZFWUuryUJrb_yoW3CFc_Ga
	48CF1xJw4fGF4UCw1qkF4a9r1S93y7Jr47XrZ2gFWav343Awn5AF1ktFy8Zr17J3yfZFWD
	Was8JwsrAF1fujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8H5lUUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEhL3ZWe0S-IzFwAAsc

On Fri, Jan 10, 2025 at 04:18:29PM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The current solution for powering off the Apalis iMX6 is not functioning
> as intended. To resolve this, it is necessary to power off the
> vgen2_reg, which will also set the POWER_ENABLE_MOCI signal to a low
> state. This ensures the carrier board is properly informed to initiate
> its power-off sequence.
> 
> The new solution uses the regulator-poweroff driver, which will power
> off the regulator during a system shutdown.
> 
> CC: stable@vger.kernel.org
> Fixes: 4eb56e26f92e ("ARM: dts: imx6q-apalis: Command pmic to standby for poweroff")
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Applied, thanks!


