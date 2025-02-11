Return-Path: <stable+bounces-114836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82494A301CA
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 03:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECBA1693D8
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 02:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D951EB18C;
	Tue, 11 Feb 2025 02:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C4A3iUAp"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7421E9B32
	for <stable@vger.kernel.org>; Tue, 11 Feb 2025 02:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739242427; cv=none; b=bYEVfHo4Yjx5hoM+kpHnjgs3/5jk/2oerMZSh8Fyd8p+NqqKx2aek06zvZfWjEsedmJ9ugaavIe2621iUlIhh9yi2eZ38CYzclJShfP0J8pN8Co2FPsk9FicYzhwaMXXZ2MM+4L916rNxWn1dRSTtrloI49vng/pMxKMoWag6oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739242427; c=relaxed/simple;
	bh=/HDBJrzz4qSqdvXBIG31xloW2ODyMpc5fTsf3ZIdBYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VvyB4RQCqCAIznGOY7ef/cC9ONBKnYbU1Q3nU3Jx2yl8twzQ8uR14kxzvBih2d+9zCI+lDM+p6uGK2UtAdjgi6mVhf9lt3Tezydmpt+i9lT4gZv2cKYJxIzJ8AzPJgmJdO9l6fIqk+L9gE7NMjdPcB0gZ2IJ0/zRJD8MKqLotIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C4A3iUAp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AJHqOa002834;
	Tue, 11 Feb 2025 02:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ofqZmAbxWAMZnAt6ooOOltCFIBPtKtrWj5FEYokKWro=; b=C4A3iUApLvWtUY+A
	BHl4kcdOez/RAvSz66GIwLZjMTMffn0SgyFmbIWv6El30+f2NkYDqRo+8UgszRGE
	4SUagf5xyAC27FRQQPgbVpwaESjkSfK1mAkS6rh3/AnC5ece4mb1n/EWCc8gY0Pv
	/biCJqWfSpAgu25zi2+MVvuIUbmswx2hTkULE++XPvbpBYkNnoN+FP3BdHEoeDPy
	+wXOHjWOcXlQw50+FAW3FdUWbf2FUtm8/hxrJxZfHuNVTRJVVJdp3tfuuIt6umAJ
	ag2dUkTrV0uJhnqtnjvmRSp2wOn5THp2r/7eF6svC+l7UGfRk/ALMqIyc5w8Qmr8
	G7Jkxg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44p0dyp99y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 02:53:41 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51B2renw010641
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 02:53:40 GMT
Received: from [10.133.33.10] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Feb
 2025 18:53:39 -0800
Message-ID: <5f56b34a-36cc-4eec-8895-620dff85b359@quicinc.com>
Date: Tue, 11 Feb 2025 10:53:37 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] Bluetooth: qca: Fix poor RF performance
 for WCN6855" failed to apply to 6.6-stable tree
To: <gregkh@linuxfoundation.org>
CC: <stable@vger.kernel.org>, Johan Hovold <johan+linaro@kernel.org>,
        Luiz
 Augusto Von Dentz <luiz.von.dentz@intel.com>,
        Steev Klimaszewski
	<steev@kali.org>
References: <2025021050-canal-limeade-cac4@gregkh>
Content-Language: en-US
From: Zijun Hu <quic_zijuhu@quicinc.com>
In-Reply-To: <2025021050-canal-limeade-cac4@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: XBFOw-xQ_DqB0q3QOl0OLCujv7qeQrVF
X-Proofpoint-GUID: XBFOw-xQ_DqB0q3QOl0OLCujv7qeQrVF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_01,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxlogscore=968
 mlxscore=0 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502110015

On 2/10/2025 9:15 PM, gregkh@linuxfoundation.org wrote:
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x a2fad248947d702ed3dcb52b8377c1a3ae201e44
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021050-canal-limeade-cac4@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> 
> Possible dependencies:

let me solve these conflicts for 6.6 6.12 and 6.13 and make it apply ASAP.
thanks

