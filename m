Return-Path: <stable+bounces-93891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7F69D1DFC
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 03:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70F54B214F6
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 02:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3075A13211A;
	Tue, 19 Nov 2024 02:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G2dnsOJ1"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7093FF1;
	Tue, 19 Nov 2024 02:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731982498; cv=none; b=SGJE+YswprrhgRatAvRNdatIDBTtpnkjfG08m+UAA+UsTwjAZ8Jx0xdYR/saBk6b5yr0v4XlXHEwIxAPEv1MYRum4caBw8wZo4yteychj+07m/4CHghWsYsPugx7LiIrShqMZAthmjfJQOw5SbcedEztmvyPKk8/gIJM0Cvvg/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731982498; c=relaxed/simple;
	bh=BedYYDpjc/af53IHCSEAPMTd8HnUhH3pfXCO6vleV4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sVLP0yDlBGY7uVXcoa/043dadXvDGBoMmdjWA7XUVEalBP2NoAZsafQggxw2oEt6aJOkJU1CqqQvZ3ppguz5G+vFaUiCF9epPS8yogLExtkzPd2PXYxHzDYaPkREPPYPrDDgsQycMw/lgRIOWJLg5r9fEuMCYCNWKXY+2L1o8ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G2dnsOJ1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIGGdvj026837;
	Tue, 19 Nov 2024 02:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BPcr82EtHYQQGwGC3z55Hjcvd38ESCNNpseVzITcESM=; b=G2dnsOJ1j+aR+zNv
	LhSdQsvmYwyirUZjsTh8pxWSV9JlwzRVThK2Wa6QAz+Iv5YwIOGHII3ax/qDycAr
	CvtQMCx+1ONmkzhK99fQWmnu8P8MjaXxv6K1BNuHDBe63+RZyXxMtDSJVzcuvCZ4
	9acaaW2wNBHhpwwSFQl6jGA/7pr4dKvXyUDGFSLdrQturAgcc3NNH9T7K5nNGiQr
	jw/9EHBUWI7bftZjvpZIx1UeecteT64QQ7bDnENGTHc4j5sosAcaikye4vspM9rq
	SYLVxyK2HSKFGaBaVSvg3vhaGSWwksA4KWcLVCl2ikHUMD+6s45oqFHnHrQjrPkj
	l3ofug==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y7s53g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 02:14:20 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJ2DJ28016969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 02:13:19 GMT
Received: from [10.253.8.237] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 18 Nov
 2024 18:13:13 -0800
Message-ID: <d382b377-e824-4728-8acd-784757dde210@quicinc.com>
Date: Tue, 19 Nov 2024 10:13:11 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: Support downloading board ID specific
 NVM for WCN6855
To: Johan Hovold <johan@kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "Steev
 Klimaszewski" <steev@kali.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>, Zijun Hu
	<zijun_hu@icloud.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Luiz Augusto von Dentz
	<luiz.von.dentz@intel.com>,
        Bjorn Andersson <bjorande@quicinc.com>,
        "Aiqun Yu
 (Maria)" <quic_aiquny@quicinc.com>,
        Cheng Jiang <quic_chejiang@quicinc.com>,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        <stable@vger.kernel.org>, Johan Hovold <johan+linaro@kernel.org>
References: <20241116-x13s_wcn6855_fix-v2-1-c08c298d5fbf@quicinc.com>
 <Zzs2b6y-DPY3v8ty@hovoldconsulting.com>
Content-Language: en-US
From: quic_zijuhu <quic_zijuhu@quicinc.com>
In-Reply-To: <Zzs2b6y-DPY3v8ty@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: a0D1d30FwmA5Gt0yuqebd2TdZpImMgqD
X-Proofpoint-GUID: a0D1d30FwmA5Gt0yuqebd2TdZpImMgqD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411190017

On 11/18/2024 8:43 PM, Johan Hovold wrote:
> On Sat, Nov 16, 2024 at 07:49:23AM -0800, Zijun Hu wrote:
>> For WCN6855, board ID specific NVM needs to be downloaded once board ID
>> is available, but the default NVM is always downloaded currently, and
>> the wrong NVM causes poor RF performance which effects user experience.
>>
>> Fix by downloading board ID specific NVM if board ID is available.
>>
>> Cc: Bjorn Andersson <bjorande@quicinc.com>
>> Cc: Aiqun Yu (Maria) <quic_aiquny@quicinc.com>
>> Cc: Cheng Jiang <quic_chejiang@quicinc.com>
>> Cc: Johan Hovold <johan@kernel.org>
>> Cc: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
>> Cc: Steev Klimaszewski <steev@kali.org>
>> Cc: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> Nit: These Cc tags should typically not be here in the commit message,
> and should at least not be needed for people who git-send-email will
> already include because of Tested-by and Reviewed-by tags.
> 
> If they help with your workflow then perhaps you can just put them below
> the cut-off (---) line.
> 

thank you for pointing out this and sharing good suggestions
will follow these suggestions for further patches.

>> Fixes: 095327fede00 ("Bluetooth: hci_qca: Add support for QTI Bluetooth chip wcn6855")
>> Cc: stable@vger.kernel.org # 6.4
>> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> 
> When making non-trivial changes, like the addition of the fallback NVM
> feature in v2, you should probably have dropped any previous Reviewed-by
> tags.
> 

make sense. will notice these aspects for further patches.

> The fallback handling looks good to me though (and also works as
> expected).
> 

so, is it okay to make this patch still keep tags given by you ?

>> Tested-by: Johan Hovold <johan+linaro@kernel.org>
>> Tested-by: Steev Klimaszewski <steev@kali.org>
>> Tested-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> 
>> Changes in v2:
>> - Correct subject and commit message
>> - Temporarily add nvm fallback logic to speed up backport.
>> — Add fix/stable tags as suggested by Luiz and Johan
>> - Link to v1: https://lore.kernel.org/r/20241113-x13s_wcn6855_fix-v1-1-15af0aa2549c@quicinc.com
>  
>> +download_nvm:
>>  	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>>  	if (err < 0) {
>>  		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
>> +		if (err == -ENOENT && boardid != 0 &&
>> +		    soc_type == QCA_WCN6855) {
>> +			boardid = 0;
>> +			qca_get_hsp_nvm_name_generic(&config, ver,
>> +						     rom_ver, boardid);
>> +			bt_dev_warn(hdev, "QCA fallback to default NVM");
>> +			goto download_nvm;
>> +		}
>>  		return err;
> 
> If you think it's ok for people to continue using the wrong (default)
> NVM file for a while still until their distros ship the board-specific
> ones, then this looks good to me and should ease the transition:
> 

yes. i think it is okay now.

> [    6.125626] Bluetooth: hci0: QCA Downloading qca/hpnv21g.b8c
> [    6.126730] bluetooth hci0: Direct firmware load for qca/hpnv21g.b8c failed with error -2
> [    6.126826] Bluetooth: hci0: QCA Failed to request file: qca/hpnv21g.b8c (-2)
> [    6.126894] Bluetooth: hci0: QCA Failed to download NVM (-2)
> [    6.126951] Bluetooth: hci0: QCA fallback to default NVM
> [    6.127003] Bluetooth: hci0: QCA Downloading qca/hpnv21g.bin
> [    6.309322] Bluetooth: hci0: QCA setup on UART is completed
> 
> Johan


