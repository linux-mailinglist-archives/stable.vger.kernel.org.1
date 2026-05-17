Return-Path: <stable+bounces-249124-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEpnA1H7CWpPvwQAu9opvQ
	(envelope-from <stable+bounces-249124-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:30:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACD556290A
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 19:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D84D3027688
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAF83C73D7;
	Sun, 17 May 2026 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a2zaxeiV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J4sJ6gmH"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E542C3C6A39
	for <stable@vger.kernel.org>; Sun, 17 May 2026 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779039002; cv=none; b=i0jOyAuzX1zde0qdczVh0vSkmr0LkpOVOStqF3FpC2qEVejVbUmaqPM3ErCK10ZRhg9c4jBWcZAenjL0sC7VkKVqXqFmITgbZz2E5OAaag82D7B42mKAkQASV4hrqC+FYsi97F8PyYVW0UTYozIyx3Zuzp7zYrmMNx9RfrsVbVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779039002; c=relaxed/simple;
	bh=6py1zoHaVdRk/ukIHqAdD7V61Ikdrr3sm0apl9nG3Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INqqxfU+h575Lwlq6DWL4n3OJSaHnAsNZCA91QcvvJTR1Q8nHwq1Img3JwnJ1rd/SNGYKGMel2MYATEJJ4KojFDgDKPf2P8BfmRq1duPDeCDmfgfjSmyrD+4287OFgUzydpmnoMhDZBiw3gXNPh/G+esMUQrs9v1FfUgDpJvKko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a2zaxeiV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J4sJ6gmH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64GK9cvl1066514
	for <stable@vger.kernel.org>; Sun, 17 May 2026 17:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JpdeiS1uA+pl00HV/TMDS+WW
	ayMzmhtr2xGT+L36+54=; b=a2zaxeiVGVoq4L/MfYoLpjoCw8rrZVrcuElfi8G4
	ZPiOY9VgXyJAAtkRo0RXWEk/6IcJuerIyGVgycOF7bkTaYBUqRrS8B6xab2MYQO0
	+o/Tvg5gLaE3cd5d616BX0HBzo8TSFV7/klc1j6cWjoP3ogVWVPxE0dmRkGqnQDh
	CG+AqgeZqzE6Wvif5h/Mu9wREMoemT3V2TKxVBs3MCuLzrNHYgVo7ofLsVDyNf5n
	yYNqLXqc/+mU3QoWIQ9bxcQZJwo+QyiojF9HK8lYGVq+GEC1pF0rPmBMZRhLS1Vb
	fVHd5DOmWDWql7Um+Dwrmw4Z7As9t3zr0DtTWb8y7cxjdg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6h0g38kw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 17 May 2026 17:29:59 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d890580e1so38343601cf.3
        for <stable@vger.kernel.org>; Sun, 17 May 2026 10:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779038998; x=1779643798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JpdeiS1uA+pl00HV/TMDS+WWayMzmhtr2xGT+L36+54=;
        b=J4sJ6gmHM6v+w/CKOElgTF/RFsvztbXrrDv3bR7HSNaqBA17aHQl01kv+tYe0IbrV2
         d9IKHbDKnxrZXjC/aZSaBENKt0ffYBUNoxAMXmvDqTH1j/931z7kiwwHgWqWQjNZVW8D
         TIU+qZ1eRPggG3CxHAmlZliNw3+/yf0rnJvHCqdxCRG2avB8HUV6oaRsvn10V9FrcY6c
         FJxFak25gwcMSzSX7xutVB0CberTmpVLqME2leXO6wmvf7LWlEdarGYG7TqPnY1Ewty1
         i40cd1n45TCu6BYmjej9Dnom+bFZS4Esv6MdoteImktqcGQyikyDbbn/mVxljtCvShDg
         VS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779038998; x=1779643798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpdeiS1uA+pl00HV/TMDS+WWayMzmhtr2xGT+L36+54=;
        b=TTM9YCDg5LNSWgyX6asvGWva+2GuZoptMPuLP1iCrnKMcdsl+OXkbzl9iOQgJc1cFH
         SWkwuGphGg8V3FORlB5AQoIWH6kCOtpPRmqsfampClWFG2E/+bw0iAJm1HVjyiyulBRu
         YamjQqFCG/rhk4XJ7ouuYyBRwql22CxCmllATM5kAxvhkzBRabrsKNQh0hiC+K77UBG2
         JFRJ/i01nhYFwbymFtVg/GZ6UUedHnbqFKNXOISiCRXVkupKyEOKh8J5N0B6QC/xL0uq
         KhQszOOVaOg//fIS10mGXpe+mhIRWKn0ffd72lCpHvcJA/5/vNuCXz+SOEgqXMCqMu69
         prhw==
X-Forwarded-Encrypted: i=1; AFNElJ9hyfqj1y/PyJOnl+opGAD1+zRFqRmza0FT0qv1HU8dvofkVmSYV7JM/TpUd6tteKT6zHe3Ko8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc4z1g3+PwVnk+NpdJAki4VfOlsjBtXNSTa8Qp79+yqW67yerc
	bqr9cY/QWCqw8f51cDfKw7wQxMkG6qmA59UludNkW6Sks50mSaXfy/AfWTxlm3vCReHdY7TXrMe
	E1gekkI9Un68d9Eb3XGsNKUUS8y6+PWToAoc7r3s8cpHX72Sjtb3JM5SG6I8=
X-Gm-Gg: Acq92OGiwXDI8p3O5oy711hGyKKb3jZP0vpMzWWD64g0EBJ2DR/eLiH5jyJ3KnFXsK9
	HgxpkhsbCHh7LSFu9q7nM5GyoiVX9sWfjg3eosbReAvK9FmTVfgF+64UJkm5b7dnUDtKlq7NLBV
	CTco1A+WRh6L6zVYvyl1Gf52cyH7CYX+vAyMCIxea+dJrHAVT3U7scayFpbH+LuUamN4Q+g27nO
	9thnKsqhoTI9e4Jh6sBEifIeBHfE5kM8FqOyKd6nBRyEseTvLuH7d9ktDlpuWNNSEXpH7W/swsa
	x7lMFvzpLvMJD9e+CrVRW48M3Vo4vbJfODOqdBep46vt82XtHmCIvRh9SGu0zSgBPx3M/R6o3Wu
	5nSRKIid10Howi79KbPacG7k+pxRQEbeOwa98gtuxHXnQy15laoP4FULutpyIteezBXp/986foY
	R/8ygk2WjfL8lqhifvjJNDNDb3UmY6DGaYGeo=
X-Received: by 2002:a05:622a:6bc6:b0:50f:b3d2:6ee1 with SMTP id d75a77b69052e-5165a1eadf4mr127697261cf.31.1779038998129;
        Sun, 17 May 2026 10:29:58 -0700 (PDT)
X-Received: by 2002:a05:622a:6bc6:b0:50f:b3d2:6ee1 with SMTP id d75a77b69052e-5165a1eadf4mr127696841cf.31.1779038997655;
        Sun, 17 May 2026 10:29:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395882c4683sm6281841fa.13.2026.05.17.10.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 10:29:55 -0700 (PDT)
Date: Sun, 17 May 2026 20:29:53 +0300
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
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 03/14] media: iris: Fix VM count passed to firmware
Message-ID: <izj6zy7c4ec2cjbsznkaxa4q3hupwteqprjzpajjquwchwa227@mplk7d7uccz7>
References: <20260509-glymur-v5-0-7fbb340c5dbd@oss.qualcomm.com>
 <20260509-glymur-v5-3-7fbb340c5dbd@oss.qualcomm.com>
 <zfh3hb4gowxejxeip3l24jub2z3xh26pzl5xmjhjos634c6e3u@y26yubeb7v33>
 <11c63862-5e8b-9f3a-5479-706e672879a5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11c63862-5e8b-9f3a-5479-706e672879a5@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE4OCBTYWx0ZWRfXwwI4cE5MZ0Lx
 Aoc3y9JaPyghnGf/AmYcy2hvzpUD9iIRFMWvhOqNTOo7ohVh2y1ps7dCO7InBDOzBbgbFZH+UV1
 zia9rnZbljpClbGWHkxzqPCTBkfrwziBRdKiGOiWIl6+VZZZs5gvXxq7YoN8l0spOSzY3qbAZFB
 F7BlnJCmhoGzvIqoYDoLRiO/6Ju8F5tUblUtONZpZKy3tLVmhfNlC/PgIhGKYubjmCYm1OYl6NE
 ZzVybzpeoGzyp6n+aCXGPl0xDyKCpXbfkFSVTC+oryCQwUjg/5mb4zvW1gNpy0kvgMj0R1yhNP8
 xEq7WHzSmAJYx3jHKLo2T7YseVKFQtvDbYTCoZmI3PHgdpjpG3MPM2E7vWhqx5hll4Yf5wEVJ4P
 9HxL+IYbYePP1ZhSaKv55VvKoYyE5iz86+rbOgIIx3fsxRSkMiECikqO6zRdH7TWTknJ9pi7rI7
 aY2BiTvrctjDlJ2L4hQ==
X-Authority-Analysis: v=2.4 cv=W7gIkxWk c=1 sm=1 tr=0 ts=6a09fb17 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=oM8CjG1BZR9KsnUa8EkA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: uBncpL5WRN8ACcmbdhXkaao-QNSo1sAL
X-Proofpoint-ORIG-GUID: uBncpL5WRN8ACcmbdhXkaao-QNSo1sAL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170188
X-Rspamd-Queue-Id: 9ACD556290A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249124-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 04:48:44PM +0530, Vishnu Reddy wrote:
> 
> On 5/9/2026 12:50 AM, Dmitry Baryshkov wrote:
> > On Sat, May 09, 2026 at 12:29:52AM +0530, Vishnu Reddy wrote:
> >> On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
> >> the number of virtual machines (VMs) and internally adds 1 to it. Writing
> >> 1 causes firmware to treat it as 2 VMs. Since only one VM is required,
> >> remove this write to leave the register at its reset value of 0. This does
> >> not affect other platforms as only Glymur firmware uses this register,
> >> earlier platform firmwares ignore it.
> > The explanation is pretty suspicious. I can see this write in venus
> > sources too and it was added in the initial submission, dating 2017. The
> > driver targeted two platforms, MSM8916 and MSM8996, so this write
> > predates Glymur pretty much.
> 
> Thank you for the historical context! I checked with the firmware team and
> confirmed that this register is not read by any of the platform firmwares
> currently supported in the Iris driver. Regarding MSM8916 and MSM8996, those
> are not supported in the Iris driver.

So, which platforms actually needed that register? The "currently
supported" is not strong enough. We are bringing in Agatti support and
support for SM8150 and SDM845 is in discussion. I would not be surprised
if we end up porting other older platforms too. So, you are changing the
historical behaviour. You need to document the applicability of the
change.

> 
> >> Fixes: abf5bac63f68 ("media: iris: implement the boot sequence of the firmware")
> >> Cc: stable@vger.kernel.org
> >> Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
> >> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> >> ---
> >>  drivers/media/platform/qcom/iris/iris_vpu_common.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >>

-- 
With best wishes
Dmitry

