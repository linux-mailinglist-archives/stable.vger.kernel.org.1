Return-Path: <stable+bounces-61260-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CC493AF1F
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 11:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CDB0282DB9
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 09:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7BF14B972;
	Wed, 24 Jul 2024 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="LIrf7iDl"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF7013DDC2
	for <stable@vger.kernel.org>; Wed, 24 Jul 2024 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721813781; cv=none; b=A/63Fo5MRYLTWCJqLk7lMaKvXZ4NuYQBz1Nw3p6Is3ZYG08nhon1PTBiP2UELP9OjsX1NzFDIww139fwNnd6hzTgK0S7rJeubx5HzAdGQ0nyNfVgNIhN56tG+NYEoSPZ9dZcY5bWk3wdbfNpR+Ji5qhUrQ4SchaRApBuRBuyqJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721813781; c=relaxed/simple;
	bh=70MbAotIg2n6fKHVBx0IvON0z2Mub1N9tDFL7B6d3Zc=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=NnnV0KJ4dbkgqCzFQnJmt+gGPcxS351WKh8FXwdcv38jEJBlGYpWx1wZfJ1KPY2piF10Rs00czt7WXmHp5v/MlY6m8ZV/CuaxGWa6SF0koBQ7ioAIWrPpwWu4zg6seRUhCkiSLW2qOcrJLNV9qW9LCzyCOrg6YvXU+67PqLLDfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=LIrf7iDl; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46O4RPpW026286;
	Wed, 24 Jul 2024 04:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=nNDlXaQWF/NJ8+SaBTuXFMSHm0PeTqDtX7d7N2/bZTA=; b=
	LIrf7iDl/IEPzpWXK6VBT/Dgx/ht4aA+G1v/bpMjItNdum1PObjPkFtrQHNniC+P
	DH3UlIfKY2RcSVNcUmw8lor8yyfDNyY9PprMk0JelRo6Jb7dqP3HkVqRcccYKs/w
	oD46v3N/FBTPrxEFmwjfUTcwgS4RT7z0XL/SBl+EUDh1FBWtUXW9VQjkBaJHDwj+
	1ymJVBEW/Rmp/fWlg8IzBPHN64FxohRfmOizGvpLVc6VQ1OKYlH6IDJrp3R4+Ld8
	wRXxZ++GJIhpSyfSgEKLFQxiiZP2JjYo3eJkwXck52FYLYKG5Xcp3PwjZOafniNV
	Umh5RLh3Z/LibJMUAhxUcQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 40g9nj4d6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 04:35:59 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 24 Jul
 2024 10:35:57 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 24 Jul 2024 10:35:57 +0100
Received: from EDIN6ZZ2FY3 (EDIN6ZZ2FY3.ad.cirrus.com [198.90.188.28])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id BA204820244;
	Wed, 24 Jul 2024 09:35:57 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>,
        <stable@vger.kernel.org>
CC: <patches@lists.linux.dev>, 'Takashi Iwai' <tiwai@suse.de>,
        'Sasha Levin'
	<sashal@kernel.org>
References: <20240723180143.461739294@linuxfoundation.org> <20240723180146.679529179@linuxfoundation.org>
In-Reply-To: <20240723180146.679529179@linuxfoundation.org>
Subject: RE: [PATCH 6.9 083/163] ALSA: hda: cs35l56: Select SERIAL_MULTI_INSTANTIATE
Date: Wed, 24 Jul 2024 10:35:57 +0100
Message-ID: <000001daddac$e3525c70$a9f71550$@opensource.cirrus.com>
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
Thread-Index: AQLyD8B3yh8i0hgv7tpKHZqoLGh8kAIJjVwZr8btJqA=
X-Proofpoint-GUID: e2_sIfNmPnRLRs86bytQPqSOObwqfkfK
X-Proofpoint-ORIG-GUID: e2_sIfNmPnRLRs86bytQPqSOObwqfkfK
X-Proofpoint-Spam-Reason: safe

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Tuesday, July 23, 2024 7:24 PM
> To: stable@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> patches@lists.linux.dev; Simon Trimmer <simont@opensource.cirrus.com>;
> Takashi Iwai <tiwai@suse.de>; Sasha Levin <sashal@kernel.org>
> Subject: [PATCH 6.9 083/163] ALSA: hda: cs35l56: Select
> SERIAL_MULTI_INSTANTIATE
> 
> 6.9-stable review patch.  If anyone has any objections, please let me
know.

Hi Greg,
Takashi made a corrective patch to this as there were some build problems -
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
> index f806636242ee9..9f560a8186802 100644
> --- a/sound/pci/hda/Kconfig
> +++ b/sound/pci/hda/Kconfig
> @@ -160,6 +160,7 @@ config SND_HDA_SCODEC_CS35L56_I2C
>  	depends on ACPI || COMPILE_TEST
>  	depends on SND_SOC
>  	select FW_CS_DSP
> +	select SERIAL_MULTI_INSTANTIATE
>  	select SND_HDA_GENERIC
>  	select SND_SOC_CS35L56_SHARED
>  	select SND_HDA_SCODEC_CS35L56
> @@ -176,6 +177,7 @@ config SND_HDA_SCODEC_CS35L56_SPI
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



