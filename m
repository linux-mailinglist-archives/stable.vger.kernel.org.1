Return-Path: <stable+bounces-114932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A11AFA30F4E
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 16:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD1A3A1186
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 15:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5A0250C14;
	Tue, 11 Feb 2025 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="T8pnfREc"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED47626BD8C;
	Tue, 11 Feb 2025 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286668; cv=none; b=iResZLq+hyfLrAnOnCSh8zET/k9BgO9ju5Imc8kivpl/Vp8gL/Eb6uH9p61x57M5XH+8r+R0UT6eUpPnC21hAzsG0kAnJh9OHihz3Rp/c4tgYjVMdYscsXNQe5lxc0flKZwS7d63YDvoewGflDeO+N8YTJLx/4iA3jqF+piHe+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286668; c=relaxed/simple;
	bh=obWpRWXFO0BmcJk5O5meIK0OX3KFC/pPcUicI/GFgBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iyN+O/Q2IxUafcbOn4m9iomcm3K6u9Dk58Vhl1iWMd+7kc+rabJ5uYHFhjQHZsVwZ2Huq8lKhU2oZ5/+ynuPzkpI4v01hbd3EHA9SbJeLGg+NymvjjNRMNkT7TAfUTRI5eOhJTn/KyW5geigC8GYpDNeKd+9eMnIzNTxMbIiNL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=T8pnfREc; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51B4vo2q003866;
	Tue, 11 Feb 2025 09:10:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=yUrdzzly1HlXlFqlA9rB3BgFsAXXPpFRmV9em8w60ko=; b=
	T8pnfREcqgY9R2pNNte3IR4Dyegn4xNWjjV3UAVgdJ9C2uObMEiBI+NmQ25IE23j
	zmektAA5QnYXNb+hB2twdNvhhi0MtdefJUgcI19EcWobw5Q2qNRVkQXXJBN5j/iZ
	briN4aiaB4KAYSCYedJ+OLPdMRBXwBK+CePGn9x3PaiJg5ym58gEePeuZBKWEeQ7
	lOHpDzhuVUgS7Rso+ULVx0o2xqodKEeqHlo2WLC1ZKjK9kpm/Yatdut6gU96OkcN
	xCL/hzsrn54yWQQWexI/9r2c4/2MgPhJH5w1EOB1397ilz6CXYowCUfp/hzuOl/G
	jJm+ISVDjL5eFxM6v0y9LA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 44p4jmvwn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 09:10:39 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 11 Feb
 2025 15:10:38 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Tue, 11 Feb 2025 15:10:38 +0000
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3838C820248;
	Tue, 11 Feb 2025 15:10:38 +0000 (UTC)
Message-ID: <d1c9a0f3-5bc5-4b78-abfa-d17e90c36f48@opensource.cirrus.com>
Date: Tue, 11 Feb 2025 15:10:38 +0000
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
        "Simon Trimmer" <simont@opensource.cirrus.com>,
        Charles Keepax
	<ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
CC: <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250211-cs_dsp-kunit-strings-v1-1-d9bc2035d154@linutronix.de>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20250211-cs_dsp-kunit-strings-v1-1-d9bc2035d154@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PNv1+eqC c=1 sm=1 tr=0 ts=67ab686f cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=VwQbUJbxAAAA:8 a=hVoct8NOfsc9t3BWKfUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: _GsbeqKrF1tAwPzizDm-TvKdxzzwjbuT
X-Proofpoint-ORIG-GUID: _GsbeqKrF1tAwPzizDm-TvKdxzzwjbuT
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
> diff --git a/drivers/firmware/cirrus/test/cs_dsp_test_control_parse.c b/drivers/firmware/cirrus/test/cs_dsp_test_control_parse.c
> index cb90964740ea351113dac274f0366de7cedfd3d1..942ba1af5e7c1e47e8a2fbe548a7993b94f96515 100644
> --- a/drivers/firmware/cirrus/test/cs_dsp_test_control_parse.c
> +++ b/drivers/firmware/cirrus/test/cs_dsp_test_control_parse.c
> @@ -73,6 +73,18 @@ static const struct cs_dsp_mock_coeff_def mock_coeff_template = {
>   	.length_bytes = 4,
>   };
>   
> +static char *cs_dsp_ctl_alloc_test_string(struct kunit *test, char c, size_t len)
> +{
> +	char *str;
> +
> +	str = kunit_kmalloc(test, len + 1, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, str);
> +	memset(str, c, len);
> +	str[len] = '\0';
> +
> +	return str;
> +}
> +
>   /* Algorithm info block without controls should load */
>   static void cs_dsp_ctl_parse_no_coeffs(struct kunit *test)
>   {
> @@ -160,12 +172,8 @@ static void cs_dsp_ctl_parse_max_v1_name(struct kunit *test)
>   	struct cs_dsp_mock_coeff_def def = mock_coeff_template;
>   	struct cs_dsp_coeff_ctl *ctl;
>   	struct firmware *wmfw;
> -	char *name;
>   
> -	name = kunit_kzalloc(test, 256, GFP_KERNEL);

This allocates 256 bytes of zero-filled memory...

> -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, name);
> -	memset(name, 'A', 255);

... and this fills the first 255 bytes, leaving the last byte still as
zero. So the string is zero-terminated. I don't see a problem here.

Just fix the other allocs to be kzalloc with the correct length?



