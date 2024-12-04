Return-Path: <stable+bounces-98226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E02709E32C6
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 05:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9172167E92
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 04:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42C9175D5D;
	Wed,  4 Dec 2024 04:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KebMb7UL"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70CE502BE;
	Wed,  4 Dec 2024 04:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733287860; cv=none; b=J4k6KofVx/wBmTdynTK0pWv/ynbPfnhpsesgZrokeztYU1zDdfnWlgQ5xKxonryG02icQUgQkxtHLyz7bhfKWb40f/LkxaQKJpjwQdJXz5qW0J/cQFBazbYuZs9cpJOWjL6yEHCJBhrLsucGA0Nv/MBP8wT6svisl+3/fjtokns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733287860; c=relaxed/simple;
	bh=jr6/2axKyMSR18uZ66Kb/g4i6DxyDlHZwP1V5vP7+pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cQJyp+HLGfwv1WlcC3enhtv1XNVxhn9pjINir3akXuGx3TA9Re3VdLVZVPK1+DJ9y/aJsvyLDlMIyWzjpCoHGGURqOXADgOLyXTyUEPDm9DMIL4AdNxdx5J0tTYVYacmgpd5GAJ/FTCGt4ChWWya8pkjbOB7iC3s17TWEWRfvpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KebMb7UL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3JNSf1027880;
	Wed, 4 Dec 2024 04:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HrT+ix17CMvRW4h/CZZjYHFfnbNWyyW8v5tETaJEQNI=; b=KebMb7ULABBC+0Ku
	DlM/hOuQ1YzmmaUhzDsiqS6F51v49PEV7oL+cSpPoAGn27/i67wla15Z1w/0RCAL
	gdz127wEY9Y6yPWS2c1HAOpIZ2aKXlPVrPgZZXqlTPOxgC1aJHwWlKHrtDzbroOi
	aWgfQjSerQVRKrU1A4T5s/XmCyHtRxid0/Nns+t0AsbJB69mogbfNHdc1ej7ua8p
	jErbKBb8R5HzDjQ44nPwHGmnuDrGKw7y26MaRGPxCGTuVNAhaePsQI7efN4tt5sl
	EqHJ9PCONzl2uHlCr7jvTTlZPflMoFSp0CL7U8oSgtN35mjno2oLIfX06TMvidGt
	csCcYw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437tstj85s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 04:50:34 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B44oXVS027878
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Dec 2024 04:50:33 GMT
Received: from [10.253.8.52] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Dec 2024
 20:50:30 -0800
Message-ID: <8360f26a-f384-4089-b50a-ae9751f503db@quicinc.com>
Date: Wed, 4 Dec 2024 12:50:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: Support downloading board ID specific
 NVM for WCN6855
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Paul Menzel <pmenzel@molgen.mpg.de>, Zijun Hu <zijun_hu@icloud.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Luiz
 Augusto von Dentz" <luiz.von.dentz@intel.com>,
        Bjorn Andersson
	<bjorande@quicinc.com>,
        "Aiqun Yu (Maria)" <quic_aiquny@quicinc.com>,
        "Cheng
 Jiang" <quic_chejiang@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        "Jens
 Glathe" <jens.glathe@oldschoolsolutions.biz>,
        <stable@vger.kernel.org>, "Johan Hovold" <johan+linaro@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Marcel Holtmann
	<marcel@holtmann.org>
References: <20241116-x13s_wcn6855_fix-v2-1-c08c298d5fbf@quicinc.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <20241116-x13s_wcn6855_fix-v2-1-c08c298d5fbf@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EJh6MI1RqT8UnI3hcLLEmYr2rP2v2RRo
X-Proofpoint-GUID: EJh6MI1RqT8UnI3hcLLEmYr2rP2v2RRo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412040037

On 11/16/2024 11:49 PM, Zijun Hu wrote:
> For WCN6855, board ID specific NVM needs to be downloaded once board ID
> is available, but the default NVM is always downloaded currently, and
> the wrong NVM causes poor RF performance which effects user experience.
> 

Hi Luiz,

could you please code review for this change ?

several types of product in market need this fix, hope it will go to
mainline as early as possible.

sorry for this noise.

> Fix by downloading board ID specific NVM if board ID is available.
> 
> Cc: Bjorn Andersson <bjorande@quicinc.com>
> Cc: Aiqun Yu (Maria) <quic_aiquny@quicinc.com>
> Cc: Cheng Jiang <quic_chejiang@quicinc.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Cc: Steev Klimaszewski <steev@kali.org>
> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> Fixes: 095327fede00 ("Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6855")
> Cc: stable@vger.kernel.org # 6.4
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Steev Klimaszewski <steev@kali.org>
> Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> Thank you Paul, Jens, Steev, Johan, Luiz for code review, various
> verification, comments and suggestions. these comments and suggestions
> are very good, and all of them are taken by this v2 patch.
> 
> Regarding the variant 'g', sorry for that i can say nothing due to
> confidential information (CCI), but fortunately, we don't need to
> care about its difference against one without 'g' from BT host
> perspective, qca_get_hsp_nvm_name_generic() shows how to map BT chip
> to firmware.
> 
> I will help to backport it to LTS kernels ASAP once this commit
> is mainlined.
> ---
> Changes in v2:
> - Correct subject and commit message
> - Temporarily add nvm fallback logic to speed up backport.
> — Add fix/stable tags as suggested by Luiz and Johan
> - Link to v1: https://lore.kernel.org/r/20241113-x13s_wcn6855_fix-
> v1-1-15af0aa2549c@quicinc.com
> ---


