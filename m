Return-Path: <stable+bounces-118296-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B625A3C37C
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 16:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5BA81882BC0
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 15:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EAD1F891D;
	Wed, 19 Feb 2025 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="epKGMJ56"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDDA381AF;
	Wed, 19 Feb 2025 15:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978321; cv=none; b=ZqnBSpmBq6FVhF6ZQE/Oi+3wWHU78snefKvXtiMt4FrsWHldQCAW3A0eaJb2umEemewMPyyBjbB2OxNbgE9H823sexBJN3/qUxOrTbtTcdKxHEfRsVznZQ2aWdG/xTwf2gu0pSpTUjzBBHK5anFmip/ro/nAEv+MgTKXb9GcEZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978321; c=relaxed/simple;
	bh=N+uSn/8nCGKQ8qivT7nk7rE+toQsBlzw6bxxMBCQAEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ivmJND79OU3PZv6Y7+6foXbaDeVCC+obdhIZIludbS8b89O7bPYkR+k3CQqqhaj9s5/tBtb2eqwokQfNJAg5tVADRxgpAUnWAg3loXanwXWfbUu1yhCZp414WBOuuDSDxI/nk0q3J7t045CdNjMIYLUY465OPGwu8/9Yp0jD7g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=epKGMJ56; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JFH1Qm022119;
	Wed, 19 Feb 2025 09:18:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=jkjcggGWrNZ/iXb/3ceRHdKS8e8cSlNrQV1UXrkbLsU=; b=
	epKGMJ56EdvKQBxs8RLWrgS8qgnntWA21WqLcv3U8snEH76/+UDGzrfP+ZnfIqTy
	2Ajx0E766SEr3HarEy++CeZObl/LBPFToE/MnHVoruf4hb+qMfggg+06IAFvmzP6
	lw9QscYqSaPHo5lVyFY83kDpXSuuAVAgy5UnqM1gPGuoke/V0OSuVmlLuG3l0tLs
	E1uVx/vQH9ffEMjFOAs3ena98mD+NczNLYtGc+2WO1Ll9NeMZztDz1Nek2w9/8wo
	l4gz2gma0o/dchb8LrAK5vnSoZHBZJPBu8GrSBNa6l7qf6msjMqISRIVLgx7VgnG
	FXTb3NQaMTFCIil4DmJ4ow==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 44vyywt38b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 09:18:17 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 15:18:14 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 15:18:14 +0000
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id A0F6182025A;
	Wed, 19 Feb 2025 15:18:14 +0000 (UTC)
Message-ID: <695e7853-dc6a-41f6-85c1-47aa78085048@opensource.cirrus.com>
Date: Wed, 19 Feb 2025 15:18:14 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: cs_dsp: test_control_parse: null-terminate test
 strings
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        "Mark
 Brown" <broonie@kernel.org>
CC: <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250211-cs_dsp-kunit-strings-v1-1-d9bc2035d154@linutronix.de>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20250211-cs_dsp-kunit-strings-v1-1-d9bc2035d154@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: IQxgJ7Pe1iqm0QDtCdtXDw9Yen8MUrmi
X-Proofpoint-ORIG-GUID: IQxgJ7Pe1iqm0QDtCdtXDw9Yen8MUrmi
X-Authority-Analysis: v=2.4 cv=WOSFXmsR c=1 sm=1 tr=0 ts=67b5f639 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=5WolietwVMrf4Qt7vzEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

On 11/02/2025 3:00 pm, Thomas Weißschuh wrote:
> The char pointers in 'struct cs_dsp_mock_coeff_def' are expected to
> point to C strings. They need to be terminated by a null byte.
> However the code does not allocate that trailing null byte and only
> works if by chance the allocation is followed by such a null byte.
> 
> Refactor the repeated string allocation logic into a new helper which
> makes sure the terminating null is always present.
> It also makes the code more readable.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Fixes: 83baecd92e7c ("firmware: cs_dsp: Add KUnit testing of control parsing")
> Cc: stable@vger.kernel.org
> ---
>   .../cirrus/test/cs_dsp_test_control_parse.c        | 51 ++++++++--------------
>   1 file changed, 19 insertions(+), 32 deletions(-)
> 

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Tested-by: Richard Fitzgerald <rf@opensource.cirrus.com>


