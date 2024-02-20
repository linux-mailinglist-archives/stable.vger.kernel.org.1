Return-Path: <stable+bounces-20827-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D8D85BEFC
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 15:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645FE28876D
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 14:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EABD6A35E;
	Tue, 20 Feb 2024 14:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E1jmWDZ2"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC362D796
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 14:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440156; cv=none; b=mFf6FB2kUnaS58/YsJmaF7Wif/6kIu5k1jwu6T12j8mcYkbs8peaAUoX2eI6DZcsDd29VCYhghDE2zHwvCesXmAwyFD6SjvIG48ah+8X88KwmzvPZcQ+Zw64oo7/h7+rSDqxBNKS4jF4YAkWnXSvfvqh2Ybla/mAiRMyZVeX5Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440156; c=relaxed/simple;
	bh=+8Zvm4scTqbk79DoCiLyqAVsX8M9Hx3sVkocNGqvIw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bLKkATBBQpgg8F4jXVtPorEWR7Mwcjv+ETUvez/TAft7waCzbDGgg5uozfZtulXspc7gDSn6QSWboDTphcvtjwRsOv5pkeLX6ZWvg2npWSrhEh3cOyeDAo+kYkbC8oDt+8yVtXSFEJe44hUud8GbdcI/oIsKEyBrK90Wv+QpIp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E1jmWDZ2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41K8C5M5005901;
	Tue, 20 Feb 2024 14:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=gywO5KlRYoyZxLVBs+qpht4VcwEvojhEY7Lx5GCIaxE=; b=E1
	jmWDZ21s8KzqmG1cuJtOSN4xRZHByIpnHrr5eUTMKA/z6n2MxSz+8I6gKabV72Mb
	k2RrSxXKpY2kx+wOKaO/DZwJyPdXwO5pbes9vJo7c/R5nIb1vJDO/XIhfHUa2D0D
	t15aYowFJFAJuVi+kJ21cQyb+Z2GqtDt1RzmCZAAqb6FU2MNAshWksJJ0dQQ7MFy
	HyDPMapjTJ52u3N+s3QMbncAzHWizW3MsYGYWqwa/GcfZ/YZ68K/20AQbhi5VMnu
	U8kcoe+joRe/5LU+NbYA7JyvcuLH5v8j5OM52SOTDxKzC1+JnCrtzAbHLyR0V0tG
	fmnwuT6uXormQUiH5PfQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wcrc08sq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 14:42:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KEgRTk010817
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 14:42:27 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 06:42:26 -0800
Message-ID: <88cd6030-f8ff-40f1-51e5-d29939e0beb0@quicinc.com>
Date: Tue, 20 Feb 2024 07:42:26 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v2] accel/ivpu: Don't enable any tiles by default on
 VPU40xx
Content-Language: en-US
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        <dri-devel@lists.freedesktop.org>
CC: <oded.gabbay@gmail.com>,
        Andrzej Kacprowski
	<Andrzej.Kacprowski@intel.com>,
        <stable@vger.kernel.org>
References: <20240220110830.1439719-1-jacek.lawrynowicz@linux.intel.com>
 <20240220131624.1447813-1-jacek.lawrynowicz@linux.intel.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240220131624.1447813-1-jacek.lawrynowicz@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vEShbTYdwXxpQC0wHEC-hPozURu3YCIw
X-Proofpoint-GUID: vEShbTYdwXxpQC0wHEC-hPozURu3YCIw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=741 spamscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200105

On 2/20/2024 6:16 AM, Jacek Lawrynowicz wrote:
> From: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>
> 
> There is no point in requesting 1 tile on VPU40xx as the FW will
> probably need more tiles to run workloads, so it will have to
> reconfigure PLL anyway. Don't enable any tiles and allow the FW to
> perform initial tile configuration.
> 
> This improves NPU boot stability as the tiles are always enabled only
> by the FW from the same initial state.
> 
> Fixes: 79cdc56c4a54 ("accel/ivpu: Add initial support for VPU 4")
> Cc: stable@vger.kernel.org
> Signed-off-by: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>
> Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
> ---

Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

