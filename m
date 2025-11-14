Return-Path: <stable+bounces-194783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4018BC5CC34
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 12:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB0774F1AC1
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 11:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EC5313293;
	Fri, 14 Nov 2025 11:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="peHLjbff";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SwO60L76"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9B23016FE
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763118018; cv=none; b=aAkbiEoYZefXCyqNK4dCxG0xc5jBHvxCNj9cwLtk+N2wFjeowZ2zjPZLfluLZ0z6zKlDslj0+nHkvgd6bPJsPRxhXDSHrP6Nt8TwSSzxhAbWeG6sE/upLLW7fDeVzgpnWNK0DEew8Hw2XagA1SVRKnelBNE3EhPkc/leuU1ObE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763118018; c=relaxed/simple;
	bh=vAX3cH484f0Xbv8QD14BasTU9187x6VcSFaXgvjGKOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3NFYAaizqcZ0OXRr59/gu2vSwKEjIn4fJUZvIg7O7Sh+jiTo9alOHDzF5YaOeYs6MVrAi9Yr85QwHIgwsNYfeYZA3Rn1l7cUtWcOPkoSHDDqLgGy53vCO8WSRfJh6vYRQ3N4tfKyzcFdde5S0m7EbRS6RbE7K0ggyaQrqIa034=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=peHLjbff; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SwO60L76; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AE8WWC41699400
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 11:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kPNCH1KIyuMKSzzu0N3tSegw
	ZHyq1JgT9YSoRKEcZvU=; b=peHLjbfftxZaWeENIAPfwRU9rhko/9nYruFjSrmj
	hkxjXR3fn1dbklebmPaUI9WbrHjDbzE+rFSltK6bN+2u+hg/DbTshrOyXJ8itVMH
	vgF8s7m7xeXO17/BAdei1exJj2zMXub/ykD5pvL6E8fmxkmV72uTEBZNTztq0lS7
	Hx6bxF4s4KYhJUvkO+qS8ZRtNe5YLxgYZPhHIYM5VmdZKmEbrE5oB2TimCmNEkoJ
	ZJ+CfFV1hds7j7vhpUgxb0VHL2m+xjRudCi8KGvR33fMrwTEhMkdLF4vi1epGDBT
	e6Gnf9iEP64Mab0Ice5DhXNGg0jHMEFmZNxRklFzWAYUrg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9e1x3h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 11:00:15 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed846ac283so69046691cf.0
        for <stable@vger.kernel.org>; Fri, 14 Nov 2025 03:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763118014; x=1763722814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kPNCH1KIyuMKSzzu0N3tSegwZHyq1JgT9YSoRKEcZvU=;
        b=SwO60L76Bfr4p//Nczel1AFtoZnjkzqDH4gQFXx1dHZ3JO8/eqbufsw69VYIg2LS7N
         O8Qg4A9KAPMNnT8HOe56wTH5PyFefeQ6lJW2KKtHRVyAJHI2wQekZOY8imXi/XjXRzfa
         MF5FdVWVTTgn1GcAwZi2gwCtoaVciFM7DVtBvib89h4jD7ZEnZq/GCKnlPBJiiYgJCxt
         vjnNbnzndz8p7c9qea47FI+wZbRnp1LFXiQbuwAogcuZb6VdmQEd5dK+Ey20aXNkSMU/
         Nc9fwsKXKUb2v7sj1cXVphY7mvcPgmyb6yMe5FPZQXCGfDLciT9ip8sn/Wozh7mNfh4U
         QXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763118014; x=1763722814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kPNCH1KIyuMKSzzu0N3tSegwZHyq1JgT9YSoRKEcZvU=;
        b=BAX43pc6qnZRiPEp7Ty3RVY3FtJfakgBZWl58R8ACMypfSsvFuUdFci3N4qzVAiwwX
         Uh8oODQK1VSJqLY2yh1o+LzymykuNRuP/zxsNF7akzfwQjWW9tBLQJ0cfSGCKRUQUt2C
         A3+sf14KnTNNsiXmDLsWAWiPxZgL/XoTP4yCYw5DotGGbKkDQifl2vW1IELWgNHuJg86
         PfSV4n24ijyS/DXWXmO31QWLydQPHbjGQVhUQ8dZmlnoU0Hn3EuAfEMk+Mo9BAE5cv7J
         E4lIFAw71/WVZkq0fqJTyLNvlvxtJX41+iP/tiaJwfweWpAzpsXEoULT4Sc+Tsw1lugi
         4ShQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGuqcGuQiMH5GgvGoI/pB9BGo6LqNjevdrjFL/gNtMUfm+WL92aoFghTq5JUghKc2Ar2fmzNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvXaIiyhilHuoshb3sbPt2F2vUz3nheZZLkpYOWRwh7s13e+W6
	fY2vFnVFMrjvO4KGqeYcCZfQ3KAPLP1DMB7/4x2tu/u9R6eWlWX7FS7DSIJDnJXc+b/Q0BWqh8J
	J98KpUSY+HxRmSLHPkz0oRQyGJqwtmmJro8g3BmUlH19VTluBb8tBFe4gO0A=
X-Gm-Gg: ASbGncvZheT6/PXsB6XHZqtrhDEy9mdGLPkWB9IV/B1skfnY1EADMpKFMVimY0fqjuW
	G83aWi7KQZRKErtvkjep82ejTpGgL7/fVU+DxJ0KlMewWFw0Ht4lPusGCd3D+5x4cS6rKyZqejE
	anCJTRVUbyzVL4rGuCMwilFT3zgh1pW/zSPAiJNmxEjrmz9sCKIuqoWgCW7z03JFEd8LlGukRo9
	bMY+JL1hmpiYaSGOlkBECemkm4XenBWQ+T8CUZULCJTPsp5Bo6hMA8x9jkRgfiniudX72vqQM2Q
	mYZ+Hjs6wRJ9tId1wJ0QAQlet5XAWMsZWt3VA/I0qQXIWHJ+rtGRzXQ7B8A2JVTlFcO0iROemox
	Y6Ec6dEH3OTWLofwHBHiu3zjlan8k/aVZxILUOAYppcB0iIpAnfHs6/JuzFbNDim8kfhZrAZK/T
	HDEDo3SLIdaemb
X-Received: by 2002:a05:622a:290:b0:4eb:a715:9aee with SMTP id d75a77b69052e-4ede6fa96a4mr79266891cf.4.1763118014037;
        Fri, 14 Nov 2025 03:00:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqcELlDzNVfefFwEEmyDZ1bOQXUV2ZPpENl2EwKnKEZ/1vtc7VhUm8EH2a23gJ6cxtM4wSWw==
X-Received: by 2002:a05:622a:290:b0:4eb:a715:9aee with SMTP id d75a77b69052e-4ede6fa96a4mr79266411cf.4.1763118013407;
        Fri, 14 Nov 2025 03:00:13 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5958040053fsm1005616e87.55.2025.11.14.03.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 03:00:12 -0800 (PST)
Date: Fri, 14 Nov 2025 13:00:11 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheng.jiang@oss.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Bluetooth: btqca: Add WCN6855 firmware priority
 selection feature
Message-ID: <awavyn6ol3lvfz5kkxqz3nizasjwkjvjz5tpbqgizsykugtrqv@7cvmfwvpzgpa>
References: <20251114081751.3940541-1-shuai.zhang@oss.qualcomm.com>
 <20251114081751.3940541-2-shuai.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114081751.3940541-2-shuai.zhang@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 4YopTnLdkSMaVEdjenZnmzNu0Q9yWP2L
X-Authority-Analysis: v=2.4 cv=SvidKfO0 c=1 sm=1 tr=0 ts=69170bbf cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9Ucak9yj36P6dMCT-N8A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 4YopTnLdkSMaVEdjenZnmzNu0Q9yWP2L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA4NSBTYWx0ZWRfX8G+xrbYH/Ljd
 o/LBVO59+qsN3aGUvttYPN/YbCWoHr/Sqn3t6IPNaERbBGVFSrTJONGrVeka1pyBJIXWVQS+MrP
 GGOlIGJj0rx7IfocwQxD29LQO9R0Yy1JTDr7jDJAhFOjebCvxN++pZnlngWZaZjZcoQaen5kJC0
 LljQBmSxmr6L2L98stLfIdPugWmKh6KgUdEDYc3uAElSMcNBisVz/u7xYc43mQVSkEJwGosG1Ld
 gK6CP1V9LqlDdWkIClGtGwXbu1xJLPegy+YMeAKrIZ1BnLHivElgWk6ohzzr3pM8P8CFgizy66b
 4ierqYzeg2rV4vj6A8vflcE9l2EzPkPwm44DyrOF8gsh0/syc7yr9uMa6ihZ7DeYygAu0f3jpIS
 Ny0nx2vyC1TxOogSQqhXod1coMEFtw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140085

On Fri, Nov 14, 2025 at 04:17:51PM +0800, Shuai Zhang wrote:
> The prefix "wcn" corresponds to the WCN685x chip, while entries without
> the "wcn" prefix correspond to the QCA2066 chip. There are some feature
> differences between the two.

It's not that it existed beforehand. Please write your commit message
logically: historically WCN685x and QCA2066 were using the same firmware
files, you are planning to introduce changes to the firmware which will
not be compatible with QCA2066, which promts you to use new firmware
name for WCN685x. 

> 
> However, due to historical reasons, WCN685x chip has been using firmware
> without the "wcn" prefix. The mapping between the chip and its
> corresponding firmware has now been corrected.
> 
> Cc: stable@vger.kernel.org
> Fixes: 30209aeff75f ("Bluetooth: qca: Expand firmware-name to load specific rampatch")

No, there was no issue in that commit.

> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 7c958d606..8e0004ef7 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -847,8 +847,12 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  				 "qca/msbtfw%02x.mbn", rom_ver);
>  			break;
>  		case QCA_WCN6855:
> +			/* Due to historical reasons, WCN685x chip has been using firmware
> +			 * without the "wcn" prefix. The mapping between the chip and its
> +			 * corresponding firmware has now been corrected.
> +			 */
>  			snprintf(config.fwname, sizeof(config.fwname),
> -				 "qca/hpbtfw%02x.tlv", rom_ver);
> +				 "qca/wcnhpbtfw%02x.tlv", rom_ver);
>  			break;
>  		case QCA_WCN7850:
>  			snprintf(config.fwname, sizeof(config.fwname),
> @@ -861,6 +865,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	}
>  
>  	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> +
> +	if (!rampatch_name && err < 0 && soc_type == QCA_WCN6855) {
> +		snprintf(config.fwname, sizeof(config.fwname),
> +			 "qca/hpbtfw%02x.tlv", rom_ver);
> +		err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> +	}
> +
>  	if (err < 0) {
>  		bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
>  		return err;
> @@ -923,7 +934,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  		case QCA_WCN6855:
>  			qca_read_fw_board_id(hdev, &boardid);
>  			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> -						  "hpnv", soc_type, ver, rom_ver, boardid);
> +						  "wcnhpnv", soc_type, ver, rom_ver, boardid);
>  			break;
>  		case QCA_WCN7850:
>  			qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> @@ -936,6 +947,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>  	}
>  
>  	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> +
> +	if (!firmware_name && err < 0 && soc_type == QCA_WCN6855) {
> +		qca_get_nvm_name_by_board(config.fwname, sizeof(config.fwname),
> +					  "hpnv", soc_type, ver, rom_ver, boardid);
> +		err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
> +	}
> +
>  	if (err < 0) {
>  		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
>  		return err;
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

