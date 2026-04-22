Return-Path: <stable+bounces-240361-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPN1Dmrz6GkdRwIAu9opvQ
	(envelope-from <stable+bounces-240361-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 18:12:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A1C448513
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 18:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58711307B4E9
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 16:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125392FD665;
	Wed, 22 Apr 2026 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WJSzYsvn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NMhDR8wW"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2F020ED
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874207; cv=none; b=EV+XgyKg0kTXCJP+0A4D4qj0EhqRt/UNcQEkRjyVAClsa+lTa4ezjreLlQm1cSZWt3aIvMjpt5y6cwq/FOFZvHgmI1l25XFzx/v0/Ib4UpxtTVgOYdQ6a85mSGLfLDH4keur0M8uCMYmRZVbAtiPowAl2dKQY6gTSeJNcvrIYt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874207; c=relaxed/simple;
	bh=NGkMHTPZYJLeqMwjwTZXzzwfHz39tIuW6sJcRjRDdeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aauSF6/7Mm+Iajn1+tYEiH20vwFb+nNDuAzB8tiehsMUVaJxwpDYNCCdTqHtvGLO+pzC8ys1ILUfs/CcQvHXH7UJUQtojaWgEofEy1zcIwYlKQdReKO6nF45Zki0jhqqkiirv9o2mlPKag+C9h3NNAreboxo034FjDOfwXiyN9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WJSzYsvn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NMhDR8wW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MG6abk872740
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 16:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uN/R6RRYtPTKnQXAfo7KnbOqKzy+JkBRYd6RhI8zV/8=; b=WJSzYsvntZfg9g8d
	8APE3nVEF+smcp6Nkp3+5rpg+DRzw7PHUUy7e+cJA3I8u1a0ztjmm1Scb72Vp1t0
	n8y81CSnQdCPtIHmEDkGgncbAscIiVG1eYGEbdzvB7oV2Syii20M3to2zG7Xmtlw
	grdA4F1MwI3FMQp0JaqU/TEYdMedJCKwjE9GUUaawL6+udqZqvuxp022yn90PUwh
	GpFKDfFWQ8fbHH1+s3JY1yIplxX1R9dewcTy+8lKrWlnp49Tncw4XmzTHmrTKxgW
	JiVeYkn0Q58wLy/3rezKCNbVo3F3SRjUDsKuqJcyDB9qHFBAoO//4r7/j8OAzVQC
	vLsD9w==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1jh00d5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 16:10:04 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-6101726c594so2609886137.0
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 09:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776874204; x=1777479004; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uN/R6RRYtPTKnQXAfo7KnbOqKzy+JkBRYd6RhI8zV/8=;
        b=NMhDR8wW3MbMxzFi3FWTL4m1doJYEElAjHNj7p+LMmXkrQvsLiO7Cw9f5rM4SVv/dh
         5FegsK3C+GpQwl3A7tmyMjuvloDT/DMmcBmLF4T8suCqOLK37aCT1FrUFFMZZQznb7gX
         ePxKb7DOQOwZzREKQGGXTUB9HR+12MnjHgjQM7eHwpUwnpY+oy0hk/QBSBfznwzcKJXY
         ie8ODgCVXNKbu961aHHXx6LR286qyJE6UuENrcNt4iW8sH5TzB0p6fgPOBH94D6pdol9
         uyO003ipW9Sk2M0WfnbDuYx7ufXGcZYQDMNchSijRNHtKczK1DByaMp6CI00iOR1pItA
         yOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776874204; x=1777479004;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uN/R6RRYtPTKnQXAfo7KnbOqKzy+JkBRYd6RhI8zV/8=;
        b=lPdOeOsST7uqnqVdTmL92GfKTUgPGyd5kzZ/7CXz9vxLHymliHE5Lb7aeRAnfRGCH1
         Ij17iwOlTVIVRXTSg5EB1Pk0r+op6cfxq4v/E0E4KJ4te/sNwa2zXbN6QSrghIgFT80n
         hf8uzWqgyJ5UaBT0DbpUFVq5kXKshCo0gSJ4OLq4j4MSi6Smwl/WHVsSzvkM254vkAYc
         L95t9LcDvaNn2796/KfXED7AMFK8KQVmxs0D6Orx9e1rwcJDwLhcOkFZ5oBkSgYgUiWF
         0IfinIVw/bQ2tYwtnwsVUxhkZ2B5rvHpuG6QjcZg/rwEPuow3gYB3GsmJMvkrYBxXStk
         VXeg==
X-Forwarded-Encrypted: i=1; AFNElJ+QzAg2VmZDDebe+O55/BjIoF61Ivho4dqgyvL3xDpnsrH2en/oVznz6VTUzFq/flXpkoOYrAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz99wYvWH+UkyJZp7d2zvN7ZWf7tW8iYekWvyP+PE4JCygfBZkN
	PJ+Hv7WhpsJKfJcCa8zNgCDM4N4L8jgXTJTxOruPdZrezQGoZq/H17oSARNp5Dm3fyyqocvNM5y
	wno53DJzWCANtApTFnCeUnKBmG5+STSOQH0D0LJYaGfzDtJh2CB5efZM2HiU=
X-Gm-Gg: AeBDiet1BU5mzcKnMJjggO78dOLW3Y/DjVq5ontwZ+9VrLYlFmrYGnCZUIXuhHBop7F
	UPlCIbgYANIpSlrCYHoDdfq5K+qmHC09gvGMmySavYAUM30HxxHqvTjIuq7mqs02tcI+a8LTL1e
	tTc6Hmkm6pfNGCGTPdNHCJqfb0TMa7Bu3buwSWO7iSt2tvcUdme1ZLfWktcDKoJDJN7g6OFLbI3
	zYF85CJOYZxoFkhGnlZ8DDj2OJLcFkaDWQeEc3M44EBW8lymynttwO4yBuSjhPUj/7I2DA3yYji
	0YGUaeQuMDuaDuo7RJYOzcNLB0Z51bGwaoevJ9hIGC7lHkZlO+dP+4XwKoTcfnmq01LuWXTxf21
	fBvrJLXdN0F5ev+RF7M1csedQYK39DmUPN0bJGLsbY5gIIta4GrrP+f+ueogpjG3oCp78yTq96A
	OF9W9vMcL95mxHVVTzOzyr2EgJkQz4zuqtyctB72bO6lBAEA==
X-Received: by 2002:a05:6102:2908:b0:604:f29d:84b1 with SMTP id ada2fe7eead31-616f8592680mr10358133137.20.1776874203720;
        Wed, 22 Apr 2026 09:10:03 -0700 (PDT)
X-Received: by 2002:a05:6102:2908:b0:604:f29d:84b1 with SMTP id ada2fe7eead31-616f8592680mr10358063137.20.1776874203181;
        Wed, 22 Apr 2026 09:10:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb5f669dsm37191801fa.14.2026.04.22.09.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:10:01 -0700 (PDT)
Date: Wed, 22 Apr 2026 19:10:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/5] phy: qcom: edp: Unify generic DP/eDP swing and
 pre-emphasis tables
Message-ID: <cveqmbcdlpx2wb4r5lzepwircwksevqhtaywuajjaz36eqdbby@an6av2dgt5iz>
References: <20260422-edp_phy-v4-0-c38bef2d027b@oss.qualcomm.com>
 <20260422-edp_phy-v4-1-c38bef2d027b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422-edp_phy-v4-1-c38bef2d027b@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE1NiBTYWx0ZWRfX4RGrl32IHM0N
 v/r7ilXxbjw/thuM+83FwJhevCMlqL27HS/lJf6uwaR+euvjo+hS9gc+6U3QwwScvQK+YJ1E2id
 ULCngjMnvBgYjt4LGHEFaBJnD1aVSESoquWbh25vkVUewreOP7EL6wJwGm2ER0n8LI1ObFTK22i
 ROCraUobqD9GQqlQiAOamb04GQ9c4yUhS6kP1WHeopkrTMG/mk5lz0TXDRK+Df3KHxjnReX6p8V
 cp2uZMR/oyOPdcJBRW6T7pXmwuEpQRMX2X+oxxhOie4L+U88xoFVXOd0A9m4i1Nq7hNU4ZzqDbY
 mE1rFkTXrzFNd3qGSKD4pI3eQTBl6QlnLYUfHgfpWBZJ13Qw49KCaMqFaZWqcDYBeuHg9DBTqqX
 SLGx6Fue91MH0IfXko1I1orhUXBVmBroM8OJjeWu2mqwKqtqxO1sJjFXZn4ogrPGrfhedIkZCxD
 pA9zKAEquW5QNpPl0gQ==
X-Authority-Analysis: v=2.4 cv=OeyoyBTY c=1 sm=1 tr=0 ts=69e8f2dc cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=nGqt9DGlS6J5kdIhkV0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-GUID: njOToOSCI2YUlXAkxlQiQqccCe2RmHQC
X-Proofpoint-ORIG-GUID: njOToOSCI2YUlXAkxlQiQqccCe2RmHQC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220156
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240361-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D1A1C448513
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 02:01:51PM +0800, Yongxing Mou wrote:
> The current eDP and DP swing/pre-emphasis tables do not match the HPG
> requirements for the supported platforms, correct the table accordingly.
> 
> The generic tables which can be shared as follows:
> 
> DP mode：
> 	-sa8775p/sc7280/sc8280xp/x1e80100
> 	-glymur
> 	-sc8180x
> eDP mode(low vdiff):
> 	-glymur/sa8775p/sc8280xp/x1e80100
> 	-sc7280
> 	-sc8180x
> 
> The proper tables for SC8180X and SC7280 will be added in a later patch,
> since they need separate table.
> 
> Cc: stable@vger.kernel.org
> Fixes: f199223cb490 ("phy: qcom: Introduce new eDP PHY driver")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-edp.c | 41 +++++++++----------------------------
>  1 file changed, 10 insertions(+), 31 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

