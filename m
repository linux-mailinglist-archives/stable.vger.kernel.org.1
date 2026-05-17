Return-Path: <stable+bounces-249125-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JfjNWz7CWpPvwQAu9opvQ
	(envelope-from <stable+bounces-249125-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:31:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 737F9562921
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1CBB3003373
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D223C9888;
	Sun, 17 May 2026 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AF9oZJxh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dec8j6hT"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7D13CA4B8
	for <stable@vger.kernel.org>; Sun, 17 May 2026 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779039082; cv=none; b=TeiLVZV48QZk2w5xrnYcSqvSAJDf+WizXwJbEIvWx5xwRqQqaaAI/aufEmGvZFPQFC7QcDXP/YgNJLvug/Hu6FyXKP4ISuXXsMp8WXQf2sIpdjhYgEqbHmOiafswfXB7g8s7FJiOyK5m1xWURxGWNlAB6nubECCrQ4f7WhsW3g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779039082; c=relaxed/simple;
	bh=ddpK/1fQ1/ofrCYfSocIFVjNulkretdPKH0F1topeuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Omf0mEnDehoRfap5RoDaOCVJ2BSvPrg14kDXaG7zJ3VI73LTpl/TbbVFOTHhotnyyIkDwCfTJ0bjrGDJasNv0KK1X+pNtliD0NMtYzIUWskeLuWSq3DyUzHRH4HIy6uW7Wz4zPLkQWOBMsV7ZAX/IPyGH20zut87cJW6PUIhItM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AF9oZJxh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dec8j6hT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64H6jtfX4083010
	for <stable@vger.kernel.org>; Sun, 17 May 2026 17:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=KbfQWTa4JGz2bP3xz67UN369
	baMaSiTTAvAd+IsVkZc=; b=AF9oZJxha6L/fXzvJoYafBp2qJZybWVLfVy3/Ief
	Alzi+ZUt+mYo8hKNWfyOamZ70IvvKBJoegHSxV5n2FmZcMB+ORPHumXogHV5KKQ5
	gpwXQ9k1OFaJkQYXpeJqf+rhV06Ec8B1EpIbVvgPV65XQhGXBGp+EmYyBx8JMOoI
	IYuX+RMACQCwIvWtpv1cxDnZdLbXwRwCY3PKCXVodKbWKrwTZlWJe3Aq3Gx8pU4J
	80Xoep0rqA6NjJxj7Mx1aIFc6jMLDBZwtIGe7EtdGwFR63SBkZfRj2HE9GZz8NUt
	OYEYHh75aKt0vr94gplsDeyppvrzm69du2WSQJL1DpyjsQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6h0qb9jr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 17 May 2026 17:31:20 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50da529ff48so48880611cf.3
        for <stable@vger.kernel.org>; Sun, 17 May 2026 10:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779039079; x=1779643879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KbfQWTa4JGz2bP3xz67UN369baMaSiTTAvAd+IsVkZc=;
        b=Dec8j6hTTjAOjV7iUQDQa0mP7OTdRejM058NAZMfwyBNveTBm2K/fiHivC2kSUla68
         0+1aSq87Yf/3+MEm49ArMGXcthLZbPI70KW1+3EKwwwR6dcRDa5FTPA6FakUkoOEqbtl
         JQwTOTBa50q7QDmSsUpnXKz6BQdI1S9rr+BMmu87AZVeZ+3RC1yBeoY0y1pF38aOz6iR
         fJmhuxOPiagNYZJX8ZwDJK98PeygF+Y+nj6hqAUydx0seFr0KbkMsIwNUCqCgoa6SbPS
         HjcXcMXzh+ShJWebRWWluA6Z1WsKV9gcgKRc+JxAjLQNnXkS73RobAD2LBPH1L9dTzok
         4+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779039079; x=1779643879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbfQWTa4JGz2bP3xz67UN369baMaSiTTAvAd+IsVkZc=;
        b=Zx1I2oxGsjgYHRro+hMnm5GpFbSK7g+YVeleEe1+u/nIv3KARGzI+Cex6vQfQxVWgu
         IOkq2egCFHSsQH/8Gr7VDSsSPr7f+8VbC+ZmncWqqWSMa+chYJddOZJeB9K1v4mbB8ra
         /Bf2f4jOj4Yv+kg5lTetjMpzvl6vdDaqwYEZFkRkSwTH1WcHELNiGHe9AWgxccmQ2mQe
         z4M0ALysEDf8VPsI34oFUAk68IU7ssOmgiEVcRS0VaZlnJVwjr3mpSjH/MnXEwEGgVNo
         7+GvrZoqOGLOxFv3im9ZzVvJxroY5f1XaetanmSNsjBgG8OgMP005Dti9ZgahtxZzTGY
         A85g==
X-Forwarded-Encrypted: i=1; AFNElJ8zfOA1A2ZqqpFEM8f78pXFofzG0ccSWwf86Y1sJKXgOGptuhSuwMrMDpYTFgVVmvkyJQGU3Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj9tnDJSZAicYVlQNJ/Qz+Px8b5A9/sj/N0y9FyqaNy4C2wwae
	f9m1q+OnzxW0ozewVPyiQ4klaSFegL8RRP2bzTgUd8aMGTQY2jazcx7Cg7rfWb77QpgeoRMEJP4
	ucEFhsC+ZiKqfpIF+04/i3/OUk80BKHhe22PCJPt/7mrmed+XyAXeL6J0YCw=
X-Gm-Gg: Acq92OFX96rfbZyih1inN5GKJ7QWeE9XwR8O86iX7bzEC7CM/EoXWnsjnMtK3BTVPLm
	URfD13pN6+n57X4CawLVWA5M+YKOGjZNCbun1Zcz3SCv7TW6C7JIh9pXqPaNRXCBZAhYV5wEL2H
	EpJxNMbRpZMnEMSzCzgBk4Ywy08KjP+3EO0AQWwqRcFVGvt9osp2Ge5EbTUnqhYVMxpwU+viup6
	r127NrcvK+s15EutqppPrTWQImNhlgsb/4SFYSXZ/aLEvCrjK6fSi/iQOhYqlywx2v3Gd6pDTRw
	CdsCIdgxXvEZCtGzr2uE8/WcrqZ5pstKnQknRdlbkfzDS2gifOKgIZIb0SesYM1xqbhvqesGmK3
	vLkdBXQ/uzBj7bJpOiHMFEVsysuj1hiIUbpuPq2NzIytQPt96yZvMrG8QNEfpPGuDew2o9ykYhU
	lj9D8lUBSVhZlQx7ELKfM2x5/cIp98dwE54svYAJ+1uhCZtQ==
X-Received: by 2002:ac8:7dc6:0:b0:515:875a:ec22 with SMTP id d75a77b69052e-5165a0022cbmr183435411cf.10.1779039079330;
        Sun, 17 May 2026 10:31:19 -0700 (PDT)
X-Received: by 2002:ac8:7dc6:0:b0:515:875a:ec22 with SMTP id d75a77b69052e-5165a0022cbmr183434871cf.10.1779039078744;
        Sun, 17 May 2026 10:31:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395887b6cb8sm6534341fa.37.2026.05.17.10.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 10:31:17 -0700 (PDT)
Date: Sun, 17 May 2026 20:31:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, devicetree@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v6 03/14] media: iris: Fix VM count passed to firmware
Message-ID: <gabnkc3nmsat7bdevnpgpba2fwvv3juzwut2n6emmyudrntht3@poynzfrdwjmm>
References: <20260515-glymur-v6-0-f6a99cb43a24@oss.qualcomm.com>
 <20260515-glymur-v6-3-f6a99cb43a24@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515-glymur-v6-3-f6a99cb43a24@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 5b_YLlUqw57K9cCDvm90thlja5o5Lqlc
X-Proofpoint-GUID: 5b_YLlUqw57K9cCDvm90thlja5o5Lqlc
X-Authority-Analysis: v=2.4 cv=fIMJG5ae c=1 sm=1 tr=0 ts=6a09fb68 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=NngpiPSqF1r_w6X9nHoA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE4OSBTYWx0ZWRfX6MHxo2OpcJGA
 6wQT2c7fORUdBFwuDIVxjha/L71soGlri+KQdH/xdK7pwVki5JvWR/wCulWQOeepRz0o8qfsYeK
 e6hQbzzKMvB1E31UG5p0ZCeM3UPPhBtLhU0FFlgKbB36TD5LioM4LGt0w7lJpqLmv98cH85WjUN
 dSkM+6AAvqmCcTXLtllhvH0BAqKE5FpN9dEJO4W/g7q/oiTlVvvFen5Nd/+m6f1nyUSz04xB4LP
 IKG8rcQh4iiQfMMtRX9kD9TWs7bZpWmHeYGKCO5v9VOjSkvbyuDDLQSi99Lk5mNw0Kqyk1ccXkv
 cJLUpFvHc9dVpvwaCXubcEx59H50sMuxkUVhWWHokAPBUEy11kOarMkWvQjj2Eqv+HzgOyRTSwT
 grF7G4XQWoTZ1rUvM10m1s6eBlkc/mH51kosqyBvh/g1ZtHSEcs62U7ZwCtrYxyEqHGmObvKJKN
 mr1dixJ49xNv1tAp6xQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605170189
X-Rspamd-Queue-Id: 737F9562921
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249125-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,linux.dev,kernel.org,8bytes.org,arm.com,linaro.org,gmail.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 04:51:18PM +0530, Vishnu Reddy wrote:
> On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
> the number of virtual machines (VMs) and internally adds 1 to it. Writing
> 1 causes firmware to treat it as 2 VMs. Since only one VM is required,
> remove this write to leave the register at its reset value of 0. This does
> not affect other platforms as only Glymur firmware uses this register,
> earlier platform firmwares ignore it.
> 
> Fixes: abf5bac63f68 ("media: iris: implement the boot sequence of the firmware")
> Cc: stable@vger.kernel.org
> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 2 --
>  1 file changed, 2 deletions(-)

Please settle the discussions before posting new iterations. Just
providing a response is not enough. Get an agreement of the other person
(or a timeout).

Until the discussion at v5 is settled, NAK

Nacked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 
> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> index 7bba3b6209c2..df76530be809 100644
> --- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
> +++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> @@ -26,7 +26,6 @@
>  #define QTBL_ENABLE				BIT(0)
>  
>  #define QTBL_ADDR				(CPU_CS_BASE_OFFS + 0x54)
> -#define CPU_CS_SCIACMDARG3			(CPU_CS_BASE_OFFS + 0x58)
>  #define SFR_ADDR				(CPU_CS_BASE_OFFS + 0x5C)
>  #define UC_REGION_ADDR				(CPU_CS_BASE_OFFS + 0x64)
>  #define UC_REGION_SIZE				(CPU_CS_BASE_OFFS + 0x68)
> @@ -78,7 +77,6 @@ int iris_vpu_boot_firmware(struct iris_core *core)
>  	iris_vpu_setup_ucregion_memory_map(core);
>  
>  	writel(ctrl_init, core->reg_base + CTRL_INIT);
> -	writel(0x1, core->reg_base + CPU_CS_SCIACMDARG3);
>  
>  	while (!ctrl_status && count < max_tries) {
>  		ctrl_status = readl(core->reg_base + CTRL_STATUS);
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

