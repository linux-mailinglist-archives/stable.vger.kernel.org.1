Return-Path: <stable+bounces-124508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E763FA62FFE
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 17:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02ED23B8A9E
	for <lists+stable@lfdr.de>; Sat, 15 Mar 2025 16:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419821F8BC5;
	Sat, 15 Mar 2025 16:25:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E365A17BBF;
	Sat, 15 Mar 2025 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.53.165.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742055927; cv=none; b=CcCwmb3N6+RigmldxpgCLwrEUzePiklQf88h8brMOz8SJ+9/+WnnMyniU8N8sDLA1eMqkwuWSqI03VnQoHM51DsgZx2kb6XfoeSrl2YpxUpir1slIgbUiEGJw06NgUynm08p9+apvUyzdaIB/YcGEiwg4svRIniW4R+km417P7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742055927; c=relaxed/simple;
	bh=OooLUublWM4AUomOTlrzjkR6hDHsebd4acX2bYkjReA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qV7J6Fv/M4wR8c39c7MyjqZsl7cGwhrFpLPEdMeZ1GgV5n2IE7tWbOLYwfV/DIYnpENYEZcogEKNT5S+dLrZ9ICE6Zfylc9IGzr7nrJF86ABSzckQ9StAn2iSv/loslwbS8SzmNSNiG2Mb2iVTwKPxXqsX4xJi/2hbyRkPxLP5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr; spf=pass smtp.mailfrom=skole.hr; arc=none smtp.client-ip=161.53.165.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
	by mx.skole.hr (mx.skole.hr) with ESMTP id 4E5CE830F8;
	Sat, 15 Mar 2025 17:19:32 +0100 (CET)
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje.mihanovic@skole.hr>
To: Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
 Karel Balej <balejk@matfyz.cz>
Cc: phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 Karel Balej <balejk@matfyz.cz>, stable@vger.kernel.org
Subject: Re: [RFC PATCH] mmc: sdhci-pxav3: set NEED_RSP_BUSY capability
Date: Sat, 15 Mar 2025 17:18:30 +0100
Message-ID: <12652295.O9o76ZdvQC@radijator>
In-Reply-To: <20250310140707.23459-1-balejk@matfyz.cz>
References: <20250310140707.23459-1-balejk@matfyz.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Autocrypt: addr=duje.mihanovic@skole.hr;
 keydata=
 mDMEZokhzhYJKwYBBAHaRw8BAQdAWJZ0hsI/ytTqHGFV8x6tzd5sB596cTeeDB4CQsTf+wC0KER
 1amUgTWloYW5vdmnEhyA8ZHVqZUBkdWplbWloYW5vdmljLnh5ej6ImQQTFgoAQRYhBG3/QdYN8x
 S1t2umMK0xk1JFj60DBQJmiSHOAhsDBQkJZgGABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAA
 AoJEK0xk1JFj60D1GABAJVSorZdMOlrp/oQtCSH/G53NE56x/JHA8VX+ZQBd/H3AP4/EcUf6eef
 DUxVMh2bdkmuQKsVZGgOGiXpMksrVntWBrQpRHVqZSBNaWhhbm92acSHIDxkdWplLm1paGFub3Z
 pY0Bza29sZS5ocj6ImQQTFgoAQRYhBG3/QdYN8xS1t2umMK0xk1JFj60DBQJmiSH/AhsDBQkJZg
 GABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEK0xk1JFj60Dlw8A/i4lPOL7NaYoYePDq
 l8MaJaR9qoUi+D+HtD3t0Koi7ztAQCdizXbuqP3AVNxy5Gpb1ozgp9Xqh2MRcNmJCHA1YhWAbg4
 BGaJIc4SCisGAQQBl1UBBQEBB0DEc9JeA55OlZfWKgvmRgw6a/EpBQ8mDl6nQTBmnd1XHAMBCAe
 IfgQYFgoAJhYhBG3/QdYN8xS1t2umMK0xk1JFj60DBQJmiSHOAhsMBQkJZgGAAAoJEK0xk1JFj6
 0DG5MA/iuo4l2GDEZ1Zf+XaS//8FwdXDO9nHkfbV2MHjF4NZXwAQDroMzBdMcqVvc8GABFlTTgG
 j7KrRDz2HwWNyF8ZeprAQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, 10 March 2025 15:07:04 Central European Standard Time Karel Bale=
j=20
wrote:
> Set the MMC_CAP_NEED_RSP_BUSY capability for the sdhci-pxav3 host to
> prevent conversion of R1B responses to R1. Without this, the eMMC card
> in the samsung,coreprimevelte smartphone using the Marvell PXA1908 SoC
> with this mmc host doesn't probe with the ETIMEDOUT error originating in
> __mmc_poll_for_busy.

Works fine for me on the same board.

Tested-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>

Regards,
=2D-=20
Duje




