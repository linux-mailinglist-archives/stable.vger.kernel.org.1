Return-Path: <stable+bounces-151571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E37EACFB92
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 05:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F7A172175
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 03:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C7B1DF269;
	Fri,  6 Jun 2025 03:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GLK+HJHh"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B1D61FCE
	for <stable@vger.kernel.org>; Fri,  6 Jun 2025 03:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749179933; cv=none; b=IOZI9TuTOlhR5zad0YUwG7RQNRCK/bW9j8hB+EsnLEnZ0Q6swD63gWhfHQIUTKcdjIr3bkC42i28F8exWuqN9UjGUDP4hut/AcTxbIZ1cs+CQzjrOB0Xt6LVZbqHpJJpFOiAAxs3jgSjp6rNJHVH6s5PRZhw8NwOZrKicjQzhPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749179933; c=relaxed/simple;
	bh=2i5oAtsOhCfuVkh3RFLLkb69laqFzI3eanFQVkoVsE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzrjrHFkEuPwWOtjrA7dXIO5Z/PQnjgCRYFgg/1mlDQsIjnO2O+rtJZsbAiBWGQij1NQ/8cjAz2arfmkbUwmHaqEKbW8xvu039a51PJLLSkZFM43atO7k4E+8nCF11Vq/VLGK+KZmuVtvQBXGKu8KfEf5b35QAGOfxxNetLiEuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GLK+HJHh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555GqxE1000692
	for <stable@vger.kernel.org>; Fri, 6 Jun 2025 03:18:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3++GTe67hezLZxTd923ZZK6/
	2HCYgNl/NqmTLv8mn6g=; b=GLK+HJHhTMjunX+8wZrkV1MHVFeOYyzomtY3fzTc
	YfBbj3zcxQdBiwlYO5lUA/fdID7nv1x9tsBDSySDmgKfPJAUbsW9rnCaGhadcKFm
	yGriMz10lMh66ygUlLQBhbDVK17ObIzL7/1JPgHoqnqUwizzQRiQzzWQPpFeO76W
	8iopsW9+hlXG6dqxZUU5ydUcDZJFXZH+4/W7g5LiCbnwQLt9C3bo/+zrXsuV2CH7
	Y8YE+Ixf4O9KJzfxs15piC5urKt9d8BrBep79bv6u9iDBxbx//2BzvyBl+LFf65r
	4hfdUZLgWR4aQyDErKIPp4FhAdl4QMUfUtmvvcI08j/I2A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8qbaxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 06 Jun 2025 03:18:50 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c9305d29abso268024785a.1
        for <stable@vger.kernel.org>; Thu, 05 Jun 2025 20:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749179929; x=1749784729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3++GTe67hezLZxTd923ZZK6/2HCYgNl/NqmTLv8mn6g=;
        b=IUbttj/GogELjhlMT5uRxtSjHcW9L9KorroA7T4v6jLKCmxiyBwxa8UFHm9a+Vn+4z
         S518gdOrFTo7gMPZ70mfPj5oFyoQUIsI8KK7o5DZqh7O3j6wx2x30XinKZsOBhqfERZr
         skwtxXwzZ0wpP/qUmOF55znERPTn1LfKFawT5J5ZiMSHvzGkf2PHADtcyZu4GeImMzb8
         AD6qhBOeXaBcNhK4xRsBHjTCj7P6SNUj/nw+iSFIVxZTst7/yyksdQhYlwvXaVoE/btO
         34SkIGFfshw6xofRzLqMhIXPaRCICHti8xFVByXcTjLIeJvttwzAPMYwbcmtWE7AFNhn
         tEoA==
X-Forwarded-Encrypted: i=1; AJvYcCXAlYYE4tYiQ1uNXd9nZbYABKzY6bzUGrAv1fzYIxhKRgJ5+DoU+ZlsTArz+XRFy2Xv7XFZpI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpb7mlUgxta8DpLjtP1ZobAqinLcClVbq+Bk7wyhKCzWjBfM1c
	5DdLPvC5yKjAj/GTsGsXMwX3vq71xYi56baTuS3RhRr+hEuwsj+BCRAB/GY7ouDNNPaNU0Pjv1d
	KfQW7WBWLHI39zR7FFtrDt4jN0dDSqkOEHRLPl73wsZ+XTczADfV4hT0l7I+OjoyrzOEKkA==
X-Gm-Gg: ASbGncsckwFzY9IorSpoFlapPTAyYw9Nd1iRIc4qKayBqz99UGrRXnVjJ29gAPlIJK4
	Ej5dL0S/MwOPLxlHFPrBNuNTg3ewJLh4WRoMlHPkSRz2Mbuu1zHUhWC8HywyUuqsbtM3VL67b1C
	tR5qR/x2S7qZyxTb9DWqxe2mfyPP+fR0L4r6G+5BQiH4D5R14GfTR7CxUyyNE2V7KbOvmOfWvfr
	vQ21Z1AtmPx1JFiEcqDryZm5reDcK6p3RDVNRPopdI2KBsem5xX03XxRO85anKrFWXUS60bWlic
	XqYw+Em+Upr5op7Ulnh/DSzs+9VCMhn/0h+VPUbakv5rIHU8V80f90sa3AjcomZs0GsJeIZwd08
	=
X-Received: by 2002:a05:620a:4626:b0:7c3:cd78:df43 with SMTP id af79cd13be357-7d2298e0a5fmr274081885a.58.1749179929195;
        Thu, 05 Jun 2025 20:18:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8Io/sF3Ee5QrYXTVtaN735LCcylkmkYl4+zwncKIv8c1TCaxXx167NJ16erArYsEsd/Wl+A==
X-Received: by 2002:a05:620a:4626:b0:7c3:cd78:df43 with SMTP id af79cd13be357-7d2298e0a5fmr274079985a.58.1749179928795;
        Thu, 05 Jun 2025 20:18:48 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5536772ac21sm74495e87.182.2025.06.05.20.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 20:18:46 -0700 (PDT)
Date: Fri, 6 Jun 2025 06:18:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@foundries.io>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Doug Anderson <dianders@chromium.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] soc: qcom: mdt_loader: Ensure we don't read past the
 ELF header
Message-ID: <qnqbc4n2ijjtfim77b32xlz7iz2durauv4h5p5h37gmxfpk3gm@5ijes7mg3ahr>
References: <20250605-mdt-loader-validation-and-fixes-v1-0-29e22e7a82f4@oss.qualcomm.com>
 <20250605-mdt-loader-validation-and-fixes-v1-1-29e22e7a82f4@oss.qualcomm.com>
 <bsnn6xpkubifuwxz4kccvves3ifq4ocp53qmbobv6ilmnfuh7x@eejawp7thorm>
 <4ruhapzeti5hiufdkws27w2q3h4psfcpmcfsqrhsnyr2u4sktp@5itmiqxydwrj>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ruhapzeti5hiufdkws27w2q3h4psfcpmcfsqrhsnyr2u4sktp@5itmiqxydwrj>
X-Proofpoint-GUID: 4pVrahT3s8_ma_qn1wTQNyrqTDRri9j7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDAzMCBTYWx0ZWRfX71o/U+7ip5pR
 JDzjXql12TiPe/lRhvUKjXNee75QGVR3w+LYuFGkP3XtK2uS0HRNf7Mxxx4Fpx9INjjQOn9MQeL
 uQ+QHlyG5A0tmny7eaEEdb+Ydqn3ivaCr33Ma95GtiG1QRoU002wnpu8GgKB5ulRjHCyAHDPOpY
 xRpYT8CDruwub6ZrmQ6HqjrLUupFexmvLtfdOE0OM0iHR03Xw0lfCucx7wuxoUtQXm+dknp6gsI
 lyzwqdwsd5wtF4JIOZq886izsh7qon+uxIrxK54G57QrINNrPbUNhVdFESG8sP1SrKWEflaCH88
 MsoFV1I/cVcFXjHdPCaMengzlqMfB1e2YHs2z2zD6VVZCPqg+xykKglED9i8VpnzBarJ2P+AAAO
 RdjuQ0laBY/B8V2bgy6Uz8FIH3GzD6vrzSZz0KUTuLbKT8pGzBfxav7VDFlLzES9o/ZRj2Kp
X-Proofpoint-ORIG-GUID: 4pVrahT3s8_ma_qn1wTQNyrqTDRri9j7
X-Authority-Analysis: v=2.4 cv=PrmTbxM3 c=1 sm=1 tr=0 ts=68425e1a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8
 a=6v-l1fwnC9SIymP-7WkA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_01,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0
 suspectscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506060030

On Thu, Jun 05, 2025 at 02:29:53PM -0500, Bjorn Andersson wrote:
> On Thu, Jun 05, 2025 at 06:57:41PM +0300, Dmitry Baryshkov wrote:
> > On Thu, Jun 05, 2025 at 08:43:00AM -0500, Bjorn Andersson wrote:
> > > When the MDT loader is used in remoteproc, the ELF header is sanitized
> > > beforehand, but that's not necessary the case for other clients.
> > > 
> > > Validate the size of the firmware buffer to ensure that we don't read
> > > past the end as we iterate over the header.
> > > 
> > > Fixes: 2aad40d911ee ("remoteproc: Move qcom_mdt_loader into drivers/soc/qcom")
> > > Cc: <stable@vger.kernel.org>
> > > Reported-by: Doug Anderson <dianders@chromium.org>
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> > > ---
> > >  drivers/soc/qcom/mdt_loader.c | 37 +++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 37 insertions(+)
> > > 
> > > diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> > > index b2c0fb55d4ae678ee333f0d6b8b586de319f53b1..1da22b23d19d28678ec78cccdf8c328b50d3ffda 100644
> > > --- a/drivers/soc/qcom/mdt_loader.c
> > > +++ b/drivers/soc/qcom/mdt_loader.c
> > > @@ -18,6 +18,31 @@
> > >  #include <linux/slab.h>
> > >  #include <linux/soc/qcom/mdt_loader.h>
> > >  
> > > +static bool mdt_header_valid(const struct firmware *fw)
> > > +{
> > > +	const struct elf32_hdr *ehdr;
> > > +	size_t phend;
> > > +	size_t shend;
> > > +
> > > +	if (fw->size < sizeof(*ehdr))
> > > +		return false;
> > > +
> > > +	ehdr = (struct elf32_hdr *)fw->data;
> > > +
> > > +	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG))
> > > +		return false;
> > > +
> > > +	phend = size_add(size_mul(sizeof(struct elf32_phdr), ehdr->e_phnum), ehdr->e_phoff);
> > 
> > Nit, this should be a max(sizeof() and ehdr->e_phentsize.
> > 
> 
> Hmm, I forgot about e_phentsize.
> 
> But the fact is that the check matches what we do below and validates
> that we won't reach outside the provided buffer.
> If e_phentsize != sizeof(struct elf32_phdr) we're not going to be able
> to parse the header.
> 
> Not sure if it's worth it, but that would make sense to change
> separately. In which case ehdr->e_phentsize * ehdr->e_phnum would be the
> correct thing to check (no max()). Or perhaps just a check to ensure
> that e_phentsize == sizeof(struct elf32_phdr)?

I think it's the best option.

-- 
With best wishes
Dmitry

