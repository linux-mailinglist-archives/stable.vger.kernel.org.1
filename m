Return-Path: <stable+bounces-191519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0875C1605A
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 18:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718CE3A9845
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 16:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF173469FF;
	Tue, 28 Oct 2025 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SAqpgwYU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZnuR0Ek5"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D80B2848B4
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761670656; cv=none; b=X/l6mB7+37YpGlY4oAIPCc1hQwXGVLv5S6d3ST76rwnxe+88jyToTiWFbnu37cHPjoYlv1b1F5Ot2k0B5M7EkfK3iJEtZ/ONo8yHMkaGOBbeXZ//RN1bXNCeui69guOiwiNSPJq7fbb0sfwCNatvP8R3dHu3Sz+lmKiMETpRSZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761670656; c=relaxed/simple;
	bh=sQcuamK2+awSRDESFFKbrhanPd1dWv8v0lyezG99h1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKAi2SnxMFQcXTFNbpeVa5wobedoLeBDNkSx4AixEXZ8s1ArGEPed5lyTiz+ZL124wbA013tx/cK48egV15H5osKAmLP3+G8DMg7MAWZcLQOUQtFG3p4WLH6okWWV8Koy9xUKngee+GwEjVaZl7X7fqP32HNfgHmt9llNW1jnek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SAqpgwYU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZnuR0Ek5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SEnhl31866058
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 16:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=YYkj+iJzcJ7SpBqMq32UWLhN
	k8gutYq0DL5v9oW2oqQ=; b=SAqpgwYUc3zjk6u1uEABqy520OWkq1amsKuYoNmI
	XVSyCNxdU1M8GtOVGQTRxNEZwUxOE6vZujneS9LxSILX0hota84oGtqJ/nION0y7
	sEw5mgdh+N4Z0N20kBDmltrlhZhNBI+lTiOZTTmiuBOvfB8ZkPDkw8UA/Y5c6OZb
	V9eNhJ6FsI3dU7yVZ6bdFwKstDFYbKE6/0N0q315ycOHhE6RXMbiwyLrkH7VfHDS
	s4k905+HQnUAqNz9BQYdcw7qTrQ+3hdgKZ87tMujOQml3COJi+yg0CbQpj+GGBoc
	HRu3MqIIP/ZplpWT559hdN5E88ugOlx1Y2wF5L4jk7ffew==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2wsprw32-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 16:57:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e894937010so173855421cf.3
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761670653; x=1762275453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YYkj+iJzcJ7SpBqMq32UWLhNk8gutYq0DL5v9oW2oqQ=;
        b=ZnuR0Ek5KWeOfPibw0tbaLpfFkTS/j0YbaIdwd0Qt2no4z+osXxkDL1sm2QGGE7z1W
         nS+blK2VzzAey3viBPS4xjByikLiPdQll9KsDx/SPYBZj2BRdw5gnEFeFnGnvu6eGq+O
         PT+wtlR/pN0JKhBRJe1FivUy+O69fD2zFGLb1fo2NB6UFbmqhr/LesYez0gbc/flI0RT
         mCdNdjjgOwaDRzG9cpevu16GljBWyLGzAm541NeHqxKy8gG5GE/eToiOkUV2XvRGCr/T
         j6d5zWzR9f9Kw1wTj4enemEI1dUMkZc24Io0eaZQQdKBgvNMa1VDbca9pKGpBP5P5gXP
         NtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761670653; x=1762275453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYkj+iJzcJ7SpBqMq32UWLhNk8gutYq0DL5v9oW2oqQ=;
        b=We8sFtNVWWq1VEfMMUde02KzyFgcu5yHLg7sefYOyfom6ZaGui1IgSMj3wbAXS9mAW
         wV/7258OHV9eNpXjb6Zm/RwKt3HAqQy/EAzcGdWLNBLXBnFrV0F6V8ScRkbUwsKsSoX5
         FBSaOZPAeOU9F22eWi280sqiBFHpR4EHjlTYArBJ8TctZnditCkj8jx9Fe+41bxDGpOK
         vjiDRuQ4nLOa9f63ml3vrSkV4b5Go3Z+82ap/2WuF4vRZbSxeW9WeiwStEeqddnQefrR
         CQwm/o4a/RCAeOByQEHlMt87KP752VCSmm/ClhQOGCHWAofl996UT9Qo352wwPDQdy4U
         G+0A==
X-Forwarded-Encrypted: i=1; AJvYcCXcs2MZkzVaNXD5Y4FiFRatWNs9T4TRxDTM3s9DamI7akRsu5OSVKSnHTMdYwsO8oqbzMQ3/rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVBRFfB2rhSzFOKhjgkLcoz7oTJYJQMrQSzPr84pyZvxOpWnp4
	7aI3+VdYcq+a2yrkBPJqHy5LzEo0oGekQ2kzePGMtm28G+i3W6RKE6n+T9k9l/fH7ERAMxZGz/B
	fltqSrqd21XrNviGz3pPIB2+QMWZF+NKx1XC0sgNwQ31I+bTZmY4emsw1qaQ=
X-Gm-Gg: ASbGncvYoSHJJ4qZ3sIc6u7XLXZSYMnQGxDQaeC8bIunNRGS4pYbJKuFjGuECqBkPoD
	2Ua7FEGfkPjixZxRoSwiqhdkRzc9CsqEuxAyK9WbSWYhuxd0ijLN9r1s9dPBnE1EoQKV2l8EGVV
	sI4m7VMvOmvg2KSElzcOIPDKefdrzEW8cb0X1//jI0KFRJU1KLgOeiBote+VxIdzpUBcqXWdG2O
	OKRhFMxQDIE8kY/LNssPLB00VsZ3wYukw2nS+LLcMPnZeHehLxudR122msbHBLS1ItDfHY9EclY
	vGLXFTvOTCqUqBAg9wbHUnzWRXBycXhsRgtyZSpQ9wGyd/4GM/OQNK3KHIOPIXehEXG3LlBWL/7
	hPdXbe2jHVp3OPfo7cPM/biwyvlYzzJvdP9yVuUwVN1TJuhR5owEUkmiE/QZKU042zVpvxydgtB
	rzC8mmbvS9ZSk+
X-Received: by 2002:a05:622a:5c9b:b0:4e8:afdb:6f56 with SMTP id d75a77b69052e-4ed1509426emr4337751cf.74.1761670653264;
        Tue, 28 Oct 2025 09:57:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFjwC9xxcgo4Q0PgTNGfYV9nhPktWWK4tZNjpIa3klhG4u7NhRCwCj9sGWBrtzYDgjAEemnQ==
X-Received: by 2002:a05:622a:5c9b:b0:4e8:afdb:6f56 with SMTP id d75a77b69052e-4ed1509426emr4337191cf.74.1761670652636;
        Tue, 28 Oct 2025 09:57:32 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f482fdsm3125844e87.31.2025.10.28.09.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:57:31 -0700 (PDT)
Date: Tue, 28 Oct 2025 18:57:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
        stable@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chejiang@quicinc.com
Subject: Re: [PATCH v1] Bluetooth: btusb: add default nvm file
Message-ID: <3fluuwp2gxkc7ev5ddd2y5niga3tn77bxb6ojbpaoblbufepek@owcrah4exoky>
References: <20251028120550.2225434-1-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028120550.2225434-1-quic_shuaz@quicinc.com>
X-Proofpoint-GUID: RuAJW_pR5pJpEJZW_J_n7Zk3k0V-nR9w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE0MyBTYWx0ZWRfX15sFrq9KajXx
 SJGZoLZVN14jIgWCOUjtHZybDmEgfku8aHGVnn5GkHoed4H4b7o099h4RgF8gDhA3SjDqrQyUSi
 yZvG5/Qi1MAhIrKyEqigUh3+vlUr1LeT93Fva077k1513cNew3awio4+UXK0LyWWekwSxAnGIPU
 yrbmPltKnN2kB03ll626JhFIdCW53Wpc5GMoC9dh9So+fwDYFh7kzBcTSe2j17c3oyyXx3rlPfj
 k+dFKt/L1z7pjcT4XJyTnoHlrlqnVOwmXg4j70czv+vOdAt67EneJoo+RQLhhfjsApLRmdx/SWd
 aESubKE7DRqnBzDRkvPmzfPQZiZ2UYdbEQxP9RQPj9Xx5yJDTxaTrNEl2Zewk7mkQUNtO+xomq1
 azz4FeIO9k+PbALCTb2JOps0+KuY8A==
X-Authority-Analysis: v=2.4 cv=aIj9aL9m c=1 sm=1 tr=0 ts=6900f5fd cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=_esQDi1y6y9LiqYhBzgA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: RuAJW_pR5pJpEJZW_J_n7Zk3k0V-nR9w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510280143

On Tue, Oct 28, 2025 at 08:05:50PM +0800, Shuai Zhang wrote:
> If no NVM file matches the board_id, load the default NVM file.
> 
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  drivers/bluetooth/btusb.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index dcbff7641..998dfd455 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3482,15 +3482,14 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
>  }
>  
>  static void btusb_generate_qca_nvm_name(char *fwname, size_t max_size,
> -					const struct qca_version *ver)
> +					const struct qca_version *ver,
> +					u16 board_id)
>  {
>  	u32 rom_version = le32_to_cpu(ver->rom_version);
>  	const char *variant, *fw_subdir;
>  	int len;
> -	u16 board_id;
>  
>  	fw_subdir = qca_get_fw_subdirectory(ver);
> -	board_id = qca_extract_board_id(ver);
>  
>  	switch (le32_to_cpu(ver->ram_version)) {
>  	case WCN6855_2_0_RAM_VERSION_GF:
> @@ -3522,13 +3521,25 @@ static int btusb_setup_qca_load_nvm(struct hci_dev *hdev,
>  	const struct firmware *fw;
>  	char fwname[80];
>  	int err;
> +	u16 board_id = 0;
>  
> -	btusb_generate_qca_nvm_name(fwname, sizeof(fwname), ver);
> +	board_id = qca_extract_board_id(ver);
>  
> +retry:
> +	btusb_generate_qca_nvm_name(fwname, sizeof(fwname), ver, board_id);
>  	err = request_firmware(&fw, fwname, &hdev->dev);
>  	if (err) {
> +		if (err == -EINVAL) {
> +			bt_dev_err(hdev, "QCOM BT firmware file request failed (%d)", err);
> +			return err;
> +		}
> +
>  		bt_dev_err(hdev, "failed to request NVM file: %s (%d)",
>  			   fwname, err);
> +		if (err == -ENOENT && board_id != 0) {
> +			board_id = 0;
> +			goto retry;
> +		}

I'd rather see here:

  } else {
	bt_dev_err(hdev, "QCOM BT firmware file request failed (%d)", err);
	return err;
  }

>  		return err;
>  	}
>  
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

