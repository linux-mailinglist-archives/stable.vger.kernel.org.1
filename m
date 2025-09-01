Return-Path: <stable+bounces-176781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7DDB3D68D
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 04:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E94D189892D
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 02:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764FB207A32;
	Mon,  1 Sep 2025 02:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pm3wSN5m"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCC02940D
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 02:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756692573; cv=none; b=H57ggmbqEPQ4Bp7dhBoYE6LCSrwU+nGqnEF2LFfslmAfe5wyDeR006ar18gJDEI+Ico4DC295v4IpdxRaGzFQLrQHzFtEDe1E5aNtD43v9/trzIbb/Bv8js8fFDi8qOWGSpOV9tDVYmMDSiw7COun2zZgrqHOksDTms4o7tRtHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756692573; c=relaxed/simple;
	bh=FOP26zaTOY1xrPxkZDwQuusVzgnNln+P8abj1VM1Wic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bePYpOMgqR8jbQzHz9emS859lhJYY+Os/KAgQzPt+PiysC16ksSalvn6eKupG6DqXdNMiSI10NbQof6krQELfW94VzZhzFRJWAb8tRc734WEB5DQS7VOfIxASRo9rcAzbF726OPqS9VsAEFIIwwFfFbknCrE4S2idhNOIR7ENwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pm3wSN5m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57VNSkjt003705
	for <stable@vger.kernel.org>; Mon, 1 Sep 2025 02:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HJFTJhiN+4hmB6UylAdee9vnnn/inlLMUCHrFPbCUQY=; b=pm3wSN5mnW9lMLaI
	66RbTvLssLk0CyWIYOHVGhvzRPbj3mtLll+6fRFFAwNmUslJfGGlnpmmJ4zMAvJw
	fb1d9U6wnZ6rHtTVKaQ2NV5UtP+WWbaGkW766SrVmDhyqGYrwpYT5ZKCpMryQjpI
	wPdrfb9BKhKlo322E4dCNz5xaggl1OhTDOwuaI/Js2Es0b/qOC+c6NDp6L9xdQT2
	oDW0jGdFdGJ2UGF/imVwB8DRXrnkAULUTlAkPaAiStx+wtGK5WolUtakd+rhw7fT
	ZTRLE12IGEq+UB6uIYuFEWHd2bEW8zGk0lrivxRYwdT4wLkYg2SjtLGdls6L4oXR
	Hn39jA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8rtybt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 01 Sep 2025 02:09:30 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7724487d2a8so2010230b3a.1
        for <stable@vger.kernel.org>; Sun, 31 Aug 2025 19:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756692570; x=1757297370;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJFTJhiN+4hmB6UylAdee9vnnn/inlLMUCHrFPbCUQY=;
        b=VgK8K6w2FJ1L3iUsA81EMd8rqrveBevp8yz8hytaScQVvKf4uNU7ZPIvl+BQbavGPz
         T0FxyWT+6+FjJ+aCjXlhDtZZnXlXFtgWkr9Kkc5cJdD5VSp/3WcL1HzOJzJjxnUQfCkP
         AxaA5Z/LogkXI4IQxZIwKqMdru6P3UV6FPIWfuNppTBS/FeG7Ks3j3w4UU4Ic1vW08xQ
         6hpXvSUPfbWqbt1yuWyLbw7K2Lm24wHdmlKOaq817LEzEHSyvU9Ry3nNNCP0z3oPiZ0D
         Af6zZu00gA3Wo7B5lyz/xPD/UJLNtbvGRU2mdm22Ln4aZnrUUm1Dax+Y55W7GMYohWGF
         +I5Q==
X-Gm-Message-State: AOJu0YyqBYzLRxXpoK6i5+EdLbB4E9L8J1paoHtteNcpmsQtbNN6EixR
	oAY/VcVrAobLRPhfo8YNZtySG+yUvecuSfD/WI33f8OwUNxDxxQjpt1K8aB2HktdCkL+1Cr2mPg
	wNy6BzTRePrW8J9SedHYdcJIe8bZU4tLyQ+X3lXIsUmMH7XvK5gJlh4TiFpM=
X-Gm-Gg: ASbGncs/f+aRQ1g926bB6fEff9y5oNvAGBenQRNqjZ0yzLTwiq9u/CQwknHvkF3KPp4
	G5/YhVX+pAs8htz3CzF5DoH1hgxDNrWkBA8hIKggZBfoSirIQ15oV4I6vs3Min56VoKtaRQRHIP
	uuIjeQNEtGA5Nk95TY6jdE5wSE1hldVWgZ7nLHz0fuRAL1UM9doE/6Osc0OCo1JAUh4O/U7xBOV
	dV2mWh2+HK3xxFhoiL5uGpLWVS9ZjQBcGzmNbytR09f1SkFOHYuXa3lAVcj6K6w3A+/dI46k5Pk
	Vyhqsirjb+mBWw3be1M8lz7XoJmAdEQr9SF1FiNAI3dHwfk3iQLOwg8KjwhwJmfyMZhJ/t25JPu
	YLyvCnSpe/1w6ryUQ+7w4NNTFIoB4Ng==
X-Received: by 2002:a05:6a20:7f8d:b0:243:c081:b4a7 with SMTP id adf61e73a8af0-243d6f85b56mr8491249637.59.1756692569898;
        Sun, 31 Aug 2025 19:09:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv7jJ40IozONRbSG/trocPvA1w/awpQsGYUiMBvP2awE0A/DyTnHq/4z0XXj5ICaPVOFmkcw==
X-Received: by 2002:a05:6a20:7f8d:b0:243:c081:b4a7 with SMTP id adf61e73a8af0-243d6f85b56mr8491228637.59.1756692569368;
        Sun, 31 Aug 2025 19:09:29 -0700 (PDT)
Received: from [10.133.33.253] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7725f9f7b50sm568901b3a.68.2025.08.31.19.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Aug 2025 19:09:29 -0700 (PDT)
Message-ID: <62773a2a-235f-4894-a570-3496bd8c1c15@oss.qualcomm.com>
Date: Mon, 1 Sep 2025 10:09:24 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: trbe: Fix incorrect error check for
 devm_kzalloc
To: Miaoqian Lin <linmq006@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach
 <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250829120847.2016087-1-linmq006@gmail.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20250829120847.2016087-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX/Jxvsge35Bil
 qCwdrlW8Nyd9HcHsBo8Xul5qzj73DwUmMsXDI7T2sTZ66nSkWcAq0KjsyXaKV52ZViO37h3VqA9
 l8rJXPU5CVKQLFbliRhVZFRp0hV21uJySe/ez/u/SQHhK2pca08ZFeZnzwoVJh1/V47N9eX5bO+
 fjIusIThBKe1w4rDAeUTy1Rj0wKxrzbXO0hu2jqhrlan479XlFFnPafrv0e2fJVfzDKaJnaci6+
 lLk8gEPrpSH9qea+nhGYUY/t4A/GuhNY5fCPs470Ehe+BcdUvsL/uXndag1HoiFn5pwkEL3IFTE
 nlkREG+mU8nqivNRDUIqafc4PYsAKvp7g82eGqr7sVYmst1Ul53OBEnCujuLZtUVNLmotDuksMG
 MyotkEKn
X-Proofpoint-GUID: OieBeklAXkAj0CHp44w-G80C0tmjHO-u
X-Proofpoint-ORIG-GUID: OieBeklAXkAj0CHp44w-G80C0tmjHO-u
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b5005a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=kMyzGuzSTzuwxu01R-0A:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1011
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019



On 8/29/2025 8:08 PM, Miaoqian Lin wrote:
> Fix incorrect use of IS_ERR() to check devm_kzalloc() return value.
> devm_kzalloc() returns NULL on failure, not an error pointer.
> 
> This issue was introduced by commit 4277f035d227
> ("coresight: trbe: Add a representative coresight_platform_data for TRBE")
> which replaced the original function but didn't update the error check.
> 
> Fixes: 4277f035d227 ("coresight: trbe: Add a representative coresight_platform_data for TRBE")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>   drivers/hwtracing/coresight/coresight-trbe.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 8267dd1a2130..caf873adfc3a 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -1279,7 +1279,7 @@ static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cp
>   	 * into the device for that purpose.
>   	 */
>   	desc.pdata = devm_kzalloc(dev, sizeof(*desc.pdata), GFP_KERNEL);
> -	if (IS_ERR(desc.pdata))

IS_ERR_OR_NULL(desc.pdata) would be better.

Thanks,
Jie

> +	if (!desc.pdata)
>   		goto cpu_clear;
>   
>   	desc.type = CORESIGHT_DEV_TYPE_SINK;


