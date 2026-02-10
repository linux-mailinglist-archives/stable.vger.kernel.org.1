Return-Path: <stable+bounces-215651-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP7+KMofi2lBQQAAu9opvQ
	(envelope-from <stable+bounces-215651-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 13:08:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC3811A8E2
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 13:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D6F830398AC
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 12:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED0F328B48;
	Tue, 10 Feb 2026 12:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U5hEFujF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FJTqnn90"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4573328253
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770725302; cv=none; b=OKBkolA4rh21h9WEHQdyDeHIxX5n1fObxu3alUKbllLVzRMoyz5mjefYnxWa1guuega7dBDCKzPVPqxlmaiB0dhlQHO12U5xIGXpwvMmma8fhhNZTNSH7rAJCqPvNxqout8Bcm5MyraFCX9b7x0/J0NDiWsxWdcKtiCZtZgnAQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770725302; c=relaxed/simple;
	bh=5UT2E8ZZlh13a8f6t1/M9YfC2QQX1bYYDvLcmDN5PoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRvup7IKuh2+YePGbav3Kk7FTVIp0dOJT3mq+KkNTi+9ddPya93C0HixGwoVNYdANjjDIesRqNwkNNYECaayS4yMooLgIlDnIk4Q1/MXRJgdW6c8ut1I484/kneJO6a+8bdqhDvn8ViwM5IK96MDCwAlI2kXmMcxbFISvzLH+vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U5hEFujF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FJTqnn90; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A770RI1151743
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 12:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fWHE9U4c8zXdsFbS55+J+Lip
	A5jF7lK6n2fI5kcxHAE=; b=U5hEFujFHao714hvYHxeDvR3IYZfLHShlYlri1/5
	gbcu3cDen0ujho9WLqBRuzizwkAagw3xB8+0p61+8jWJ8oCbglfdRg0VrwnDVmDJ
	H6FfB3ZI1pQDs8bMo4E/xiDpS3s2dTdNQ15nU4RUm5ed8lya4ciR1vRk8W6TOXth
	vyyVTsDb+d/IeppPSo9i0vkzm181XuqiMKJcMqJMw6UU2hyC0yGuMrjMqfyhydb4
	RSzlVcV7LNt6xSlsi6KxY6AeG4G3haXuP/mYr2Re+GkWIxwUSFlXJynpLQkq/Dis
	PIHAmCprEdhuFwBV86BRqkPVsNMMDdE1Bjzfz58VLKY3gw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c800j8y9n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 12:08:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8ca3e7722f1so1799256685a.1
        for <stable@vger.kernel.org>; Tue, 10 Feb 2026 04:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770725300; x=1771330100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fWHE9U4c8zXdsFbS55+J+LipA5jF7lK6n2fI5kcxHAE=;
        b=FJTqnn90CP/UdqBkcHjzhFX1AJRW1WzHeB7ayBr6hmhkMbDk8flcrjA3u3Q6nWpilU
         dchYGfJQZ1/Zs4J/lmkxE1dRQR2u8qODR1sKLM3MKAhutEiTIQPkGznBekyyrwswAFut
         u5Aiu00XFoOeO8SYDB87f1l69MZoBwaT8YuLjjdQVGaxdgMpqj58Ef0sbk+jRow9MUpq
         VxfxewgGymiyvWcSM1YxZ9/gTDMmni0cmURGfCs0WXEM1hNrFJUp6tT0GroS7/FY5nn6
         udhd353OJQ2HPf7+r9M0k6eg59CeRzM21YgT1C/DDaYFTgdcVSxukZRelb387DD/1842
         4Tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770725300; x=1771330100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWHE9U4c8zXdsFbS55+J+LipA5jF7lK6n2fI5kcxHAE=;
        b=nnXRcHOkuT1fZzGTnCJSGXZ7MBwFGNOTP5eoAfcEw341BfVu5PqemWOQmfpy5U2JoJ
         EX1vhmyVtw+Dwuadh386FomnYwe+EXH/3Oi+P1Y99AIIv7nYPErWXpl+j4qBo3IlueZK
         lUb/adSg7Cq5mrJ0ezNdUNP2LFds+6mzEjcW8TwYL2czhua9SaMmYv5tOukircpQehw1
         H18gzSqnodEw+dTZb6pblNguZCsz5vN5dl9IwKZx+JL9H3req5VRKxA+SfDV7TjCuJuv
         wGw60qX/GpaS8Yi7ko7zlcLcPZem2jc5GyOJZprAy/gDCsh5wHHTptd2YdZziltfKTHa
         YiCg==
X-Forwarded-Encrypted: i=1; AJvYcCVfWcKOf7Drj1cl9Khdu8jTr8vLoV/ke+l+cTMkoxssLGqYxeIyvlPc8nAEwBbcKSP8y7yUWow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd3vPpiS/W64oA9nswjJxP+ljppRBvFZg5dOLRLc1PaDuz/uC6
	yTzHED3TPv5aPShf4gj0ruhoBIqD/BN/AKHphr6nBx9XQx2LhQf60yKbvtes9dcBTSqNc8aM7c/
	nJo80gfGAM9c1gs5wLbWJnv1XLeIIgbsXL/Vg+p3V5horXq2l9IY3CR8SgKk=
X-Gm-Gg: AZuq6aKyyXi0ZHohGi+MPwCabzD0B9GWT9UTiPFIB/9NCVL2SsR9b5cjxn4L45Gx8+W
	u3iz09RZ9KAYGU6px3bTkH5gDmk+MRnuB1HPhZgHQgVNGtPocMzVy2zdzi2jd3kOzzxVNTsiZMx
	toryBYkKSpdBDTgBNGlLrPQSN8+Nd5bHXvqstEZcXgk6dIv0ZhN/V9hkD/N9LMdQfTp4sE+MMzT
	injNH0RzII2uWMy00xW7EVpAhQ+bVSltMDh0viBmQdU4LDJC2JCw9tnKAhmI8kWXZ1+nKrIOaLc
	F2kyub/9pI2lPXACr30TI6qILJ3YWoiTcliTqZ9xSzLUVyf0bW5M3Sjo4CaFM6MxCgdwzPOtrWR
	cKOZUcZ0Ty+Peb+9SWqf91GYvsPbOhgnALm5f
X-Received: by 2002:a05:620a:1786:b0:8ca:3715:eea5 with SMTP id af79cd13be357-8cb1ed7477cmr236204085a.14.1770725299732;
        Tue, 10 Feb 2026 04:08:19 -0800 (PST)
X-Received: by 2002:a05:620a:1786:b0:8ca:3715:eea5 with SMTP id af79cd13be357-8cb1ed7477cmr236199285a.14.1770725299050;
        Tue, 10 Feb 2026 04:08:19 -0800 (PST)
Received: from oss.qualcomm.com ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376ab6e4c0sm18572329f8f.0.2026.02.10.04.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 04:08:18 -0800 (PST)
Date: Tue, 10 Feb 2026 14:08:16 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org,
        Sumit Garg <sumit.garg@oss.qualcomm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] soc: qcom: ice: Remove platform_driver support
 and expose as a pure library
Message-ID: <etbknbm4fwcsejnu4cqcfvmdwmzlobgki5ynrbp2m5w4yiyw2n@ztz6wbr2shbb>
References: <20260210-qcom-ice-fix-v2-0-9c1ab5d6502c@oss.qualcomm.com>
 <20260210-qcom-ice-fix-v2-1-9c1ab5d6502c@oss.qualcomm.com>
 <7d61d324-0d26-47ce-aac6-d17abdcf05cd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d61d324-0d26-47ce-aac6-d17abdcf05cd@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDEwMiBTYWx0ZWRfX5IE85xJehaVh
 ueVsQuY3tSAIZOKspDZq5O4GBlW4++rv/bY1aR+Qd/WLCnhQKULDAxty6cQknHrxKsz5WiPegAp
 Vy+I0Q/WOs+ROILep+rQZFKtqQ9en9VerhwgDrn+7IlYp5gA/J8Cw7nspSrSw23zSsDXYMuvM2a
 8Kor9CMrVwiQNUMNT1D9CY7FQgMx1qooJ3APS+XN4tZ+SSFzI0ITMoYlbmu5gE7LlRDSTPmI2rw
 2cIBBBHeCfIFrSTwmvI+58oiyijODWm04FN7b/1RsS2Ns4XWg6Ojp8CkGlpXPRx0ho5nvrO3kV0
 SQKGJTWiSifEAXPVrF9jZ66nt5khNYgVH2DDZ2NxO78PMSxAUSw8iie3gT2UEslTv8RCGGoaSp7
 N9cRDUl/hamv2PIcI76IXjEcLgenMa+jqJ9ls6Kg35nf8wSTcAairGQ7fOllmMgPh+V8jH6KmGE
 WLJIKPAWRSXZSmpC5dg==
X-Proofpoint-GUID: XWNaor8c6vxr-SfOc0M_-fGwmohIxlro
X-Proofpoint-ORIG-GUID: XWNaor8c6vxr-SfOc0M_-fGwmohIxlro
X-Authority-Analysis: v=2.4 cv=b9u/I9Gx c=1 sm=1 tr=0 ts=698b1fb4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=sslwbFw0vO9QQOdamQ4A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100102
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215651-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4DC3811A8E2
X-Rspamd-Action: no action

On 26-02-10 10:39:54, Konrad Dybcio wrote:
> On 2/10/26 7:56 AM, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > The current platform driver design causes probe ordering races with
> > consumers (UFS, eMMC) due to ICE's dependency on SCM firmware calls. If ICE
> > probe fails (missing ICE SCM or DT registers), devm_of_qcom_ice_get() loops
> > with -EPROBE_DEFER, leaving consumers non-functional even when ICE should
> > be gracefully disabled. devm_of_qcom_ice_get() cannot know if the ICE
> > driver probe has failed due to above reasons or it is waiting for the SCM
> > driver.
> 
> [...]
> 
> > -static void qcom_ice_put(const struct qcom_ice *ice)
> > +static void qcom_ice_put(struct kref *kref)
> >  {
> > -	struct platform_device *pdev = to_platform_device(ice->dev);
> > -
> > -	if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "ice"))
> > -		platform_device_put(pdev);
> > +	platform_device_put(to_platform_device(ice_handle->dev));
> > +	ice_handle = NULL;
> >  }
> >  
> >  static void devm_of_qcom_ice_put(struct device *dev, void *res)
> >  {
> > -	qcom_ice_put(*(struct qcom_ice **)res);
> > +	const struct qcom_ice *ice = *(struct qcom_ice **)res;
> > +	struct platform_device *pdev = to_platform_device(ice->dev);
> > +
> > +	if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "ice"))
> > +		kref_put(&ice_handle->refcount, qcom_ice_put);
> 
> IIUC this makes the refcount go down only in the legacy DT case - why?

Good point. I think it needs to go down unconditionally here.

