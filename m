Return-Path: <stable+bounces-181503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E95B9609D
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 15:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B1F2A1C11
	for <lists+stable@lfdr.de>; Tue, 23 Sep 2025 13:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBBB327A10;
	Tue, 23 Sep 2025 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XhrPSTys"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508AC327A35
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634634; cv=none; b=FXeWVgI4Hg7gci3/y8tFgm9VjsmD44CMf5cBIuLYvIaRuN+JLfMUQLoB6++YRRH68HvdUMD7IN83S/5/pZHIO+8U2aRP2WgAzLPnEQOgBYg5LvfaSX2Y5BwDQOzJ6gfpHgT5kE0pF7OhFZqa+QVIPzqCscaGWQOttKLNSDpdvlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634634; c=relaxed/simple;
	bh=zvHGvQKBYJapST6CV/r0N2vkS7ZLXI5YIDtIr8gQL4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E5/Mdrpzv9kmqyxb8LpF6gZb9Qms9GttIUYOYebdSLfs6sVSGHUMjUc1E38bo8rB0fILh7Rge5BcmZR/Trx4ArF1EfO8JisEnoYioO++T76ARGdv1SEl/nfZGNN2I4AksWGBAHWDL6zvXxPV7Z9YxylUGzhBFHDDNiuy9+BWMUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XhrPSTys; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N8HAv0020648
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 13:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V0/gdAHuFvPjc2WY/tcKVRQAXm8u+8MHfW7f+1g4ghM=; b=XhrPSTys0ozGlVGB
	9vzLpj4nmLa9SOecG5AFVCDl2IUsch8+c/ysZAyr3bHVs7PEcmwMELji6ZfFEHB6
	1VI3ENhxRLGF9Vvi37abJZ6lCZ0ZVu76TSp7LGBShgjgVdq5v/yI7z1OKHrJkelY
	O0v4KNqBfntiBzqT8AVrtM2qVtAG0drLvINPcQPt8DFlPgRdvt/psKQ+ZbNZ6Ukr
	GQE9bBHouJnSDEx1sl7Y/DeSKGHjw/SvpA8EXtqJjy0Ia+1b6izPKyrsEK8OQcKS
	sbEIq+b0OzfVB5SR7V15kfN2Xe8EfvbIBan3BGuqV/SmMgz+ptlidK0uIXUxWHa2
	6jhtFA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjt04c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 23 Sep 2025 13:37:05 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4f86568434so4077484a12.2
        for <stable@vger.kernel.org>; Tue, 23 Sep 2025 06:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758634624; x=1759239424;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0/gdAHuFvPjc2WY/tcKVRQAXm8u+8MHfW7f+1g4ghM=;
        b=d74QoDmM3byycPrpcpvGKgDHPW59mHHwsUPmFlKUGvYgqnvSCHVDRUblBeVy/2wnIL
         /TH1zc6QZIKCoS9mQCLG4+mwuxG2DTul5uu0lUuvmmRO22aQGGlZiIY63KGMCoKS+U0x
         1qY1FFt6tsN+HGlzSw5OjuH4523mpieUf4u3JwIgvb6sVVgPaGYoBsByfmLJ52u/q6QW
         dwYnW/tC9e22npERsCjI5DOuJ2z/TdXPdBlhJzCBZR5R+sgj6fz8KmTnpeClheThnYhT
         KRJf5TIH3FEpLcCZMUvV6UJDMCbfwPV0E520XW3p4nA5XSMDpxQ3BKrDpz/ufgZN/d3g
         2zMA==
X-Forwarded-Encrypted: i=1; AJvYcCWNpkXyCNqxOhnRSHIMVq/wSn4jmAwTyEyxa96hMP7RWacyc5/ZHF1oKAgDaFTF/sGgmfuLNX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWeAoiX8/9P8J8C4eWyZFd4YIp1ACT6P1qFbrYdWL7fUS6b5S4
	SeUsfujiE69u+i/yQwYFeODT4FzlaBY6qMEEIoFH1d7ShhEPbRwMj2nCS4AIY+27kMwHw9l/4RR
	LP4YxTdPNTr/0q0DzqMlzZ23rU79niU4qFulfvFx47ulXthjH7pTwEFPQGRY=
X-Gm-Gg: ASbGncv7GIM96m2KdwdAS3KrgmvYcmZ9BaP5M9tSfKPC3m2nAS63D+ldGnRSCWbJFVi
	WzsU5I/E8EQQ1DVuAE5Iw0AkyIi9LuVlhcjgFn6Fi+VJtymHGkzy1ggFc0sDwQ92q67xuE7s9VF
	c0ml4WNoAie+KegW/A2Q3e6yu/cKEshJuX6v0CoCJ4H1s/udX5Rmq9KpWQAp/Q8zBCpcPyH4m+q
	g9S/R/tHyJEBzsK9kQpGxIvHvUdrNzXWJ4BJdybwpCgGAKFCvOcpK1WJQk6ZGFMOk87+KhBcwk9
	53e7K4Wmmrpg7ccGXhzrWDNpRy/bP6ihxDobRtnFPE8dAoiN8C+WFFjuq9WcYkaV+I87aLYvWOz
	p++MR3RiooYt4F6oZ5vq4BCkuT+HhU4Y=
X-Received: by 2002:a05:6a20:939f:b0:249:824c:c620 with SMTP id adf61e73a8af0-2cffedc70bdmr3905426637.57.1758634624440;
        Tue, 23 Sep 2025 06:37:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv/R1oyJuEtuF7RPJLpNTrpa/RuVsTep4aUXBnh0RxbTPdowPzbrHSsK6+1YWt3ED91uRloQ==
X-Received: by 2002:a05:6a20:939f:b0:249:824c:c620 with SMTP id adf61e73a8af0-2cffedc70bdmr3905390637.57.1758634624018;
        Tue, 23 Sep 2025 06:37:04 -0700 (PDT)
Received: from [10.133.33.135] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f286119f4sm7814711b3a.74.2025.09.23.06.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 06:37:03 -0700 (PDT)
Message-ID: <3e9c7cda-5a73-4d98-b394-581baf144dff@oss.qualcomm.com>
Date: Tue, 23 Sep 2025 21:36:59 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] remoteproc: pru: Fix potential NULL pointer
 dereference in pru_rproc_set_ctable()
To: Zhen Ni <zhen.ni@easystack.cn>, andersson@kernel.org,
        mathieu.poirier@linaro.org
Cc: linux-remoteproc@vger.kernel.org, stable@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com
References: <20250923083848.1147347-1-zhen.ni@easystack.cn>
 <20250923112109.1165126-1-zhen.ni@easystack.cn>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20250923112109.1165126-1-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: A042GnVZxQKl9DVHP7hsfUB-Wgmv9y8o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfXyCUEgyLah+Ko
 FHvVlbzUIkaXcFfH0kqDL1cJxT2Zb36223iUyCHUm5GER+w877dfERObDpIl9xoqTJXg0vBoffh
 y1tnB8+gU2afmg73/rp+mtCaGilGuS1wP/WGlRf6n9lnAjvaaSwHrXu0QB3bUt9sS22EKi3qWXw
 MTz6kgySBH7lb9CgPRPtV8ORNYWcej/bavssbB3Pg2UScdFfzQbCsDiad6qaHFZgVp8wwXJl9hu
 4PPPxDlFTk8ULJVMg43FEe3sgEfLpUmCwVYTPNxHUOwVgp0ZpTciooZFmBcW/YMvljobPp2AcYt
 ULPWlNxb32ZhWBM+dN7N4IzIew+W2We4xNHwOI0vsD4eR1PXJ+2AugkEYAIx7LVAzSkiYG9QPQw
 LnFIrJLi
X-Proofpoint-GUID: A042GnVZxQKl9DVHP7hsfUB-Wgmv9y8o
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d2a281 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=BLr15FpE7PLhzqKsQ1oA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

On 9/23/2025 7:21 PM, Zhen Ni wrote:
> pru_rproc_set_ctable() accessed rproc->priv before the IS_ERR_OR_NULL
> check, which could lead to a null pointer dereference. Move the pru
> assignment, ensuring we never dereference a NULL rproc pointer.
> 
> Fixes: 102853400321 ("remoteproc: pru: Add pru_rproc_set_ctable() function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
> ---
> v2:
> - Changed "null" to "NULL"
> - Added " pru:" prefix
   - Link to v1: 
https://lore.kernel.org/all/20250923083848.1147347-1-zhen.ni@easystack.cn/

> ---
>   drivers/remoteproc/pru_rproc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
> index 842e4b6cc5f9..5e3eb7b86a0e 100644
> --- a/drivers/remoteproc/pru_rproc.c
> +++ b/drivers/remoteproc/pru_rproc.c
> @@ -340,7 +340,7 @@ EXPORT_SYMBOL_GPL(pru_rproc_put);
>    */
>   int pru_rproc_set_ctable(struct rproc *rproc, enum pru_ctable_idx c, u32 addr)
>   {
> -	struct pru_rproc *pru = rproc->priv;
> +	struct pru_rproc *pru;
>   	unsigned int reg;
>   	u32 mask, set;
>   	u16 idx;
> @@ -352,6 +352,7 @@ int pru_rproc_set_ctable(struct rproc *rproc, enum pru_ctable_idx c, u32 addr)
>   	if (!rproc->dev.parent || !is_pru_rproc(rproc->dev.parent))
>   		return -ENODEV;
>   
> +	pru = rproc->priv;
>   	/* pointer is 16 bit and index is 8-bit so mask out the rest */
>   	idx_mask = (c >= PRU_C28) ? 0xFFFF : 0xFF;
>   


-- 
Thx and BRs,
Zhongqiu Han

