Return-Path: <stable+bounces-104131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B65D9F116C
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F3D16494B
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571111E1A18;
	Fri, 13 Dec 2024 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Clo9Ugdw"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94E484039
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734105264; cv=none; b=JrmVNyGNa7G7MDrjhM9AmK1KZzitOY8Ev2Lke0cGPJn5LUlV2UX2dFDgULuu1xU5akGuNPgNsEciuB0gVoKwg7VLoTtWPbzRdwhyjIfhceEKEQtFPqh1cdrk10Wv+kMpirowq8wTWJp5sioAcR6SfpORCFmHtuWJQg5BzoFebpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734105264; c=relaxed/simple;
	bh=YDOX0t7rA7DzcrhO8lKzG3JVXQEUwie1oBzTyjejceo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W7fBjWksJpFQmUyXyMaHxfwJzcxvztxVSl51oqwnrgw5Vny41EfpUdhO9vonaGIdnMnjnLb3efPkY7mmSKiMRseg5BsYGsd2J//FcghP7zSFyqnexZLMn8rWW5Y5iwXkaDh97mO1FvDDSo0JdmO0FYS1qFE5GYGkbrTZ7YUuvqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Clo9Ugdw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDBhkUJ017829;
	Fri, 13 Dec 2024 15:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YDOX0t7rA7DzcrhO8lKzG3JVXQEUwie1oBzTyjejceo=; b=Clo9UgdwYQ1NJc3G
	qVkecjhd40x/TiwVPoctU0DvCUVhpzIC4zZcOki+qZ7Wf2MOeorgiHY4/cq3qrHo
	OwsiBJqbtJoNhU4ZodAb/QlzXMPT8P4jsYmuovbMXoc782IBGX01a6DXDgP5cH34
	wCQ4R7MrcaROJc1G/GbKh6TmGJqs4sIwqG1e6bylg06dKPZ3taXPEt603vGd3uoN
	BxaZ2eJR2sL6TRA609oP7bDNKi0TMPQTP8U1SAJvUvlx4uypb0e4K/S6SUOhce1u
	pSD446FDa6oSuDbXQ8IbeBRtWn8sNHTh+YccehonME8tsQl8eKZMbzhq0ZsSoHqy
	+cB2uw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43gmac0nqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 15:54:17 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BDFsG9I013686
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 15:54:17 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 13 Dec
 2024 07:54:16 -0800
Message-ID: <7997da94-1cc9-27a6-e918-96af461efe05@quicinc.com>
Date: Fri, 13 Dec 2024 08:54:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 3/3] accel/ivpu: Fix WARN in
 ivpu_ipc_send_receive_internal()
Content-Language: en-US
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>
CC: <oded.gabbay@gmail.com>, <stable@vger.kernel.org>,
        Karol Wachowski
	<karol.wachowski@intel.com>
References: <20241210130939.1575610-1-jacek.lawrynowicz@linux.intel.com>
 <20241210130939.1575610-4-jacek.lawrynowicz@linux.intel.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20241210130939.1575610-4-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nc-1T3VsRyBnHfcg1yww6khCfnsCIZ36
X-Proofpoint-GUID: nc-1T3VsRyBnHfcg1yww6khCfnsCIZ36
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=902 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130113

On 12/10/2024 6:09 AM, Jacek Lawrynowicz wrote:
> Move pm_runtime_set_active() to ivpu_pm_inti() so when

ivpu_pm_init()

With that

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

