Return-Path: <stable+bounces-61261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8032F93AF22
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 11:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 279DE1F22C46
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 09:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A3B1442F7;
	Wed, 24 Jul 2024 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="YTZPBjrH"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD8E5336B
	for <stable@vger.kernel.org>; Wed, 24 Jul 2024 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721813825; cv=none; b=Gf61qbA8hrfuyxzpr2QSs7nnJjrUSfSkHamcB1NLyORd21bUbWW4geIWD7lyZcN/Pk8zFtayY9uOTwcaWLnwVDqMhZkgJRuiSIOdL2bMSGdcp3EeEjq2YdWa4lXXSx8gZADr0sziSxurtm4tcG9woNHJ2UkL0gXzjXGHNejqVUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721813825; c=relaxed/simple;
	bh=LbkZuyC9NHOjVrBo/a9v12af2aeV4Mghm2/bVGJlZuE=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=aB8c4jIb9Yo5G27xZWw39fZKB9DWHmtoIUGpm2NNcR0PzmThXhbFT044P3e8eTqbWx+DDozbrFww1pHJt8Hmq7wMme2nRD3GMTrqaUv4SLog1ZRe8zrLY7gIo/J0wqc2Qbt1ixzTmHNeaTy3373xY7UwgELK/M7lnxWJ21GIvdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=YTZPBjrH; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O6qcAg022047;
	Wed, 24 Jul 2024 04:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=XknicDZSpj79uww7IWUoEeP2hv2B06Rfq4KdddetqHQ=; b=
	YTZPBjrHFmXCUuV+RPCtPxNk2kROP7hvzSwbdkMggGQyREM8eR6TndUZIZA5JYwt
	eGYg8PptbeVXMuVDpvOW+2pUmxMxh9Pzk6DXeNspfacgydf/5SSuIXmPJMM6896r
	RpQHKxv4j3jU1LPUzGap0iXgWz+aQhcYf0TjrVMsKeziIgWqPkKQp0D6Dz6mWpWh
	Uaw30dpGT5t+4VdAugyarIl+07RBhI3J78HHUhoaJMTm1UYMLPRYL5KvvSVFcMUn
	4U0GEIJYfc3vvLN4xnD0prJsUPAj1ErFE5JGs8lhHsGPCn9Jt7gF3lR6sgJjfiVk
	Bx82vcw99S7ERGOsdrKBQA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 40gamx4b5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 04:36:55 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Jul
 2024 10:36:53 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 24 Jul 2024 10:36:53 +0100
Received: from EDIN6ZZ2FY3 (EDIN6ZZ2FY3.ad.cirrus.com [198.90.188.28])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 66A3C820244;
	Wed, 24 Jul 2024 09:36:53 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        <stable@vger.kernel.org>
CC: <patches@lists.linux.dev>, 'Takashi Iwai' <tiwai@suse.de>,
        'Sasha Levin'
	<sashal@kernel.org>
References: <20240723180404.759900207@linuxfoundation.org> <20240723180407.143962331@linuxfoundation.org>
In-Reply-To: <20240723180407.143962331@linuxfoundation.org>
Subject: RE: [PATCH 6.6 061/129] ALSA: hda: cs35l56: Select SERIAL_MULTI_INSTANTIATE
Date: Wed, 24 Jul 2024 10:36:53 +0100
Message-ID: <000201daddad$047f1910$0d7d4b30$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQHk4wAjmeYr4l5M1d/u2hFDB5sLMgIHoZLhseFW1SA=
X-Proofpoint-GUID: uqOrF1gj5uTqUXpqTa5Htw2dGRu3rXTb
X-Proofpoint-ORIG-GUID: uqOrF1gj5uTqUXpqTa5Htw2dGRu3rXTb
X-Proofpoint-Spam-Reason: safe

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Tuesday, July 23, 2024 7:23 PM
> To: stable@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> patches@lists.linux.dev; Simon Trimmer <simont@opensource.cirrus.com>;
> Takashi Iwai <tiwai@suse.de>; Sasha Levin <sashal@kernel.org>
> Subject: [PATCH 6.6 061/129] ALSA: hda: cs35l56: Select
> SERIAL_MULTI_INSTANTIATE
> 
> 6.6-stable review patch.  If anyone has any objections, please let me
know.

Hi Greg,
(As remarked on 6.9-stable) Takashi made a corrective patch to this one as
there were some build problems -
https://lore.kernel.org/all/20240621073915.19576-1-tiwai@suse.de/
Thanks,
-Simon

> 
> ------------------
> 
> From: Simon Trimmer <simont@opensource.cirrus.com>
> 
> [ Upstream commit 9b1effff19cdf2230d3ecb07ff4038a0da32e9cc ]
> 
> The ACPI IDs used in the CS35L56 HDA drivers are all handled by the
> serial multi-instantiate driver which starts multiple Linux device
> instances from a single ACPI Device() node.
> 
> As serial multi-instantiate is not an optional part of the system add it
> as a dependency in Kconfig so that it is not overlooked.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> Link: https://lore.kernel.org/20240619161602.117452-1-
> simont@opensource.cirrus.com
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  sound/pci/hda/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
> index 21046f72cdca9..f8ef87a30cab2 100644
> --- a/sound/pci/hda/Kconfig
> +++ b/sound/pci/hda/Kconfig
> @@ -141,6 +141,7 @@ config SND_HDA_SCODEC_CS35L56_I2C
>  	depends on ACPI || COMPILE_TEST
>  	depends on SND_SOC
>  	select FW_CS_DSP
> +	select SERIAL_MULTI_INSTANTIATE
>  	select SND_HDA_GENERIC
>  	select SND_SOC_CS35L56_SHARED
>  	select SND_HDA_SCODEC_CS35L56
> @@ -155,6 +156,7 @@ config SND_HDA_SCODEC_CS35L56_SPI
>  	depends on ACPI || COMPILE_TEST
>  	depends on SND_SOC
>  	select FW_CS_DSP
> +	select SERIAL_MULTI_INSTANTIATE
>  	select SND_HDA_GENERIC
>  	select SND_SOC_CS35L56_SHARED
>  	select SND_HDA_SCODEC_CS35L56
> --
> 2.43.0
> 
> 



