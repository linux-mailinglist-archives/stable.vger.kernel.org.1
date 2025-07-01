Return-Path: <stable+bounces-159148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F095AEFB97
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 16:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694294817A6
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 14:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626D0278E67;
	Tue,  1 Jul 2025 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="PorNfJM/"
X-Original-To: stable@vger.kernel.org
Received: from proxy41133.mail.163.com (proxy25213.mail.163.com [103.129.252.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FE9278750;
	Tue,  1 Jul 2025 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.129.252.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378354; cv=none; b=M2vEoEEOKcRpacEbU3UKzKoLQrHjP4N1a+F140lhax1lI9vsenGFo23RZRmOD0o3GO8/iqoNI4Fwk4yKP/aVnz/bm1OEPGlaoRpZpPkkNOormD036f0/rXSETne8ZspCkx+foL6zjadaS9mbcVUkNQi1AwLSM8Pqtj/MyfORs4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378354; c=relaxed/simple;
	bh=Hn9XQxoi9xC5gjKbLwAvdgsOFA+fY9zgUdj+ZK/20pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZTSxld2TUxg6nfhHHPdwSfryskAj9vy+gdr240Llx63dK1EMZfJGbfS/V2B9UGH7/a7r+xbEoFBXSy9WNDdKn5xwTFPWA1jha0FUNHXBidsRRMoV/GSEc0M0tZ/VXXUqy1yMNlSXn1IhlKtVnjs8AzGxrqB2IxA89fOfBs6jRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=PorNfJM/; arc=none smtp.client-ip=103.129.252.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=beNsCZKtnDZ/kCW2/aDDl5S4J3i4rAjENZyUI1MLHbE=;
	b=PorNfJM/z8Oohl/eipl/U2KBmvOtCwwdC+ghH6peaAI1r7Wj/qX4co4UQC5Gr0
	s+UHkcaitA4IrawjNkgPUH7Wxj1QAUZcSvEK1V8N9kWHnckdfPGTpOQvpK7/gk11
	MFBqku7U8r0RxHwZBvpO533jAH2hzHV0d2kTQia6/iaWo=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgD3V+YQ52NoT3cBAA--.3737S3;
	Tue, 01 Jul 2025 21:48:01 +0800 (CST)
Date: Tue, 1 Jul 2025 21:47:59 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Tim Harvey <tharvey@gateworks.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] arm64: dts: imx8mp-venice-gw71xx: fix TPM SPI
 frequency
Message-ID: <aGPnD7J43tjoHYkM@dragon>
References: <20250604225630.1430502-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604225630.1430502-1-tharvey@gateworks.com>
X-CM-TRANSID:M88vCgD3V+YQ52NoT3cBAA--.3737S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF18Xw4DAFWfZr4UZry7Jrb_yoW3JrX_Ca
	y7K34xJw45X3yUta95trs3XF97K34xuFyIgrWUtFW3Jr9a939avrn5X3s3Aa1a9a1UXrnI
	grZ5X3y5Krya9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1iID7UUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiIBLwVmhj5xK8AwAA3V

On Wed, Jun 04, 2025 at 03:56:27PM -0700, Tim Harvey wrote:
> The IMX8MPDS Table 37 [1] shows that the max SPI master read frequency
> depends on the pins the interface is muxed behind with ECSPI2
> muxed behind ECSPI2 supporting up to 25MHz.
> 
> Adjust the spi-max-frequency based on these findings.
> 
> [1] https://www.nxp.com/webapp/Download?colCode=IMX8MPIEC
> 
> Fixes: 1a8f6ff6a291 ("arm64: dts: imx8mp-venice-gw71xx: add TPM device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Just to be clear, "b4 shazam" was smart enough to pick this v2 instead.
Still it would be helpful to leave a comment on the old version saying
there is a newer version superseding the old. 

Shawn


