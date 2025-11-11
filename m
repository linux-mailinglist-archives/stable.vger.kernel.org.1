Return-Path: <stable+bounces-194473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5971CC4DDFD
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 13:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AB434F3E64
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 12:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28447328270;
	Tue, 11 Nov 2025 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hYPM6PqL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jtGIjSqv"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7434F3AA184
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 12:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864858; cv=none; b=Xr4gHbDLjlFQCl8mKrLv9aGVQDUrqTdeBZVPNXLnexQBunQecXZewKGgXgspHtqUaBtQY/tfh4HnWAUUn+Wuoy6jQ35LFdsQJI0RX0wrrld5hE274lE9Zdz0YAoMvZON+Nou2Ke8zcb4MfPn6TGxHSXlVPfDuMqptlDREW4dzZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864858; c=relaxed/simple;
	bh=LQ+oitKANKLBtDaXHdc94NsTiFvhP0RyR81S0lGkgIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+tZiV7vcsVFtL7CZ7iE95InEK3+rKB7hgydztuRzjAe5OvleoPTZBRE7l8TNuszrL/+ELQ4DGjzNAhc2QlEKAwcJWHKE+PuYw/Pmq0Ocl0rg51GX+E6Jaig8P4fKQm0njjfs7sxRHx0aiu0rqWQzHEsxqsPdsRKot8jzP0YiYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hYPM6PqL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jtGIjSqv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGYn51937345
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 12:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=thY8JpY4WG0U4x5IdP6IL3ws
	rK/h8ku1aY3ImVMowUw=; b=hYPM6PqLNY/Ll9CBjHos/+7JIxsqLpMnNb1qrjSK
	EsekTfN1H66I0O/8tCNhjOMyw9tWyZ+mLumesAcUxJKLJSJy0ri8BUQPnEoZufa6
	Vgy5YHa/OnI4n4O5Xe9+CWv6AW2eYFIXMd03W/S1LwJ7ZnHE9E/T2v1z5IFvuBXM
	27BaeF480zK6fQYld4YFrjuKnK3jhgRNy3OVaf1+fJv+peEDGAGfgBf3Swu8AZW2
	6UcyDWOCcLyakoEYVJWbywpAjqtxMkuk0NDN71TT2y24fhoO0Vv4CJEPjjmz1hPh
	8M9S5Z4bmw4Y9rpdu9N8rvn5eEO5SQdIzED3C+bdgS+nEQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abwtj9dfh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 11 Nov 2025 12:40:55 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4edb31eed49so57446201cf.2
        for <stable@vger.kernel.org>; Tue, 11 Nov 2025 04:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762864855; x=1763469655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=thY8JpY4WG0U4x5IdP6IL3wsrK/h8ku1aY3ImVMowUw=;
        b=jtGIjSqv4zlVsYNp5UVDNBJl1i/tN1g7PhGBK425+pTjOgYEwQ8OATrS1PKgIDpruv
         YE9yyokN2cWcSiXfchrgmB+qudLAG69iL9haabUVibHZjDePhjW9wt2YFqkMSEZU4DMX
         JPf0eACaMnB+gmfFnBfv8Ep0Ma+a8B0UN6vzG8VbLy+o+2ESblyPKMyPBXFnDG7YFtkI
         g314eu5wl/OAlirl8AZFMCHwE0phbYAUWKOqCCMdDRdK3YIJcMSEmmv1PRI+mzpw03nw
         7rQfq4wPZeB4cjgHMW3YIkrGVivktxO7eb2hD8vKSfGOQj+HIXrbAeeUZDqbCwar1bm9
         k+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762864855; x=1763469655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thY8JpY4WG0U4x5IdP6IL3wsrK/h8ku1aY3ImVMowUw=;
        b=DzI7oQ1kP6POLKg3xVqCLnivprqeAAEhevJfGwWoy30zv4k6gBU9JjZ7hZcD2zUBdy
         Otvuaz2+T0CHK2css+VOl5R7jr4qZjZsVM4z/ZqAXkNTlUcR7sBRY5W9LGqdyWIOIRGI
         IiO5cRuOcgMp7ZAGzhp7jYcsrNaBYHTmZNvziBJvJs5pJQ/ykgevhYWwizt6LEOC6GEh
         7FRmJeyTn4jwnK3QGXKRrVR843V9tvGOvFaYAyrdrAWJ4OSLfmKRVniV5UFKucV1KRcm
         5qDnOJ4DNbKkGRo6Q8OuagZY7DNNaYgGYnW81Jmti+wNpUxDzjNRyX7cARC9cy2UUCnA
         asNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCsYe2Av40t0wGT3WSmqjZi4YEZ/mTA0iq2jx/ZkJTDM6Jooe51h1F7KQFrWuSCexsTZ2j+ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGh2OiCbDJx4mmv83s6We6lg+5zqarQuDU16pvM+uJA52O+nVO
	7BsBjPgLefB79Kw1jnxM8/WuqmTkpagr5kstxKvgqmPwB1tU4nl3xSu3YUlDX9LZE/RWC98YPZg
	aP1NObkN7c1NQjV8KneXnh6+Xu4qH22coCYY0day5GtvzMvZQbX1pBXhQ+VA=
X-Gm-Gg: ASbGncuY4ur+cSJK24HdpGb9NeUqQN9/mWg5NXOKoLyoGrZCPofwiz6C6N3p8g+1obf
	OJ7HrOxLLlGXtUS0rJ5BdZnAjD0RScGhHiYRPsMiIXyx65B278FBTVevpRjVsIa1Cttm9Oofz59
	MU+erA8Lnbg8sY/jhSQwxvo+tetu9qAQtlGQ4pBPgGBC+7iQQMoE6OQelBccSNGtwpEhhMD8iPT
	h1zS6nCUZ2TVXKOFgu4c96D2RZHTgvmC7BzyZL1//d7IOV/qne2ForQKrAfvEUqOIZ/6vT2m8fx
	Ul3gA+8X1ygfbN2J4hnT7eHNzhX2U0bkDYT7R12wmP7rfjqPHhgDGmFsGUGdjru9ISujF0VKQjk
	v49UEDtrgZqejOeI4sSUJbIVzc4kk7j1AOjUe94H47dK2JKpT/t9G1IqH1q2gHdATcmkVOAQVS6
	83ZJtgRvuhbmtz
X-Received: by 2002:ac8:7f8a:0:b0:4ed:3d24:9581 with SMTP id d75a77b69052e-4eda50187edmr150666561cf.83.1762864854760;
        Tue, 11 Nov 2025 04:40:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4xqPrtA5f2hoQPM4eKGkOSTFok8KYmyA6XTLWJcrYJQwoqiMBmQu5PmYefTtm3ql0EcPybQ==
X-Received: by 2002:ac8:7f8a:0:b0:4ed:3d24:9581 with SMTP id d75a77b69052e-4eda50187edmr150666241cf.83.1762864854262;
        Tue, 11 Nov 2025 04:40:54 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a03459bsm4897371e87.48.2025.11.11.04.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 04:40:53 -0800 (PST)
Date: Tue, 11 Nov 2025 14:40:51 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <quic_shuaz@quicinc.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
        stable@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chejiang@quicinc.com
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_qca: Convert timeout from jiffies
 to ms
Message-ID: <3xsuxm3jy3lvpjaahyrp4qsjcqyrxbchglaszx7ccyu4eq4mmi@557ienshr2ki>
References: <20251106140103.1406081-1-quic_shuaz@quicinc.com>
 <20251106140103.1406081-3-quic_shuaz@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106140103.1406081-3-quic_shuaz@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDEwMCBTYWx0ZWRfX97ycPihr9Xzm
 ujo3td79K5nqx1ftAn9Br3J8Ua3pxUcUrgkWn1iEDELr93NOjm0r+VHMYpRSL3zsArcFxV1jhXk
 VastdqBTRGs+GuhuzIHMBjsky+F7zx7Yg5QqT7ZulI69tUTPzVE6B+YGYki60loCGjT3HrcF7pn
 Gpg5+id5fGXpXSm9jg/14oJhfhkFbzQqmw/oYHzElIf+0z5N2Du0PY2WbfNN4M8Mpizn1D4lVX3
 4zH8iWLQwa3HCN3/yYAx2vPu5T2UJe/J7v6Gt6SQtG/27/Lj0XbjJXIFf202ebHZLm3bTjIsBha
 EdcY5ew5HHQTMHbnHlGscMdWC2LqXkjWEjDF3IKwkZJVhg1fiY80avmSFearlFLPMyqsHxawyu2
 LxacpQC2Boj6hg7/TjzleW5l2W2xWQ==
X-Proofpoint-GUID: vbo8AEhrEDT5YReGtO-2Hk_6J2q2SLKt
X-Proofpoint-ORIG-GUID: vbo8AEhrEDT5YReGtO-2Hk_6J2q2SLKt
X-Authority-Analysis: v=2.4 cv=UI3Q3Sfy c=1 sm=1 tr=0 ts=69132ed7 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=w88ekMslnmeFjZ9C8RQA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110100

On Thu, Nov 06, 2025 at 10:01:03PM +0800, Shuai Zhang wrote:
> Since the timer uses jiffies as its unit rather than ms, the timeout value
> must be converted from ms to jiffies when configuring the timer. Otherwise,
> the intended 8s timeout is incorrectly set to approximately 33s.
> 
> Cc: stable@vger.kernel.org

Missing Fixes tag

> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> ---
>  drivers/bluetooth/hci_qca.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index fa6be1992..c14b2fa9d 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1602,7 +1602,7 @@ static void qca_wait_for_dump_collection(struct hci_dev *hdev)
>  	struct qca_data *qca = hu->priv;
>  
>  	wait_on_bit_timeout(&qca->flags, QCA_MEMDUMP_COLLECTION,
> -			    TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT_MS);
> +			    TASK_UNINTERRUPTIBLE, msecs_to_jiffies(MEMDUMP_TIMEOUT_MS));
>  
>  	clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
>  }
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

