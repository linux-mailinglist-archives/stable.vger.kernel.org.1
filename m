Return-Path: <stable+bounces-116387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 153A5A35984
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 09:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1203ADD75
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 08:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BFD22AE4E;
	Fri, 14 Feb 2025 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gSd9bn8b"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B176222A7EF
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739523419; cv=none; b=WJbr7g7mZCNNTsLkivEuP6b67rWbyoVlJEIQaP22W3lN7/XYPW8nN7DZr9+3Bojh1kv12ffwzXyB2ilYjnn4HRpogKjxYFc0OF0tGpJElU5xLxe6uS5ngV5x7VwRGeHRayjLNW92HNXalzlk2meUcznZWTycmawVK7EnxbaVAL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739523419; c=relaxed/simple;
	bh=N2oMEh6KNf6wBuiHWeggrzEjBJybpqlqwqAt7hY3EyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MRn6aFOj5qGISEVpYNS4tSZM9SyJts98GXSh/e6n78EUHKhI6XJrKHS3chjmcyLuDWLHyhHJW/f8ZSjE3/baI6x0XbM2MYJHchbbnryiZ9Xfu2mkCTmvij2jpYSnf9Azo3MhA+fPiqFJSchZU7XNYTJIFzRNNfvbAG00hUROJjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gSd9bn8b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DMCH8h002806
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 08:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zt82XTOmepbxt73N1eo4Gcxa2vbkGwf5dADu4EFFH+w=; b=gSd9bn8b7SfqRDSj
	62HWhD+6Z68T4K2/jUZoXM89ENZRZ1XYc51Gpgx721HbkQTibqoqYNNoPogrgsPd
	nCK0TL1AWA6hxa+3t5mtEj9VrsQ7QJfM70yrphUjDuBFB64TGmxEMGiT1dxTWVvQ
	irXeSyLR9UgVs6qASOxy7LAk8p/0Yl/6ccIC/s60c2xvK6VLhgISvnyfnPvQ8aFb
	/KdiDBntaVXBkDtyS+yso/HFi6tH69NkMHPR8AWGSmpSLi6UImVgAc7PKARznjUp
	b8GjSef86WNpPDG0AcpcR5ZbBblhDe5Bgme+3mHf9idWcsEibSTWjESao+UnmZD4
	nrE5ig==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44s5w4cd1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 08:56:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc1a4c150bso3505082a91.2
        for <stable@vger.kernel.org>; Fri, 14 Feb 2025 00:56:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739523415; x=1740128215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zt82XTOmepbxt73N1eo4Gcxa2vbkGwf5dADu4EFFH+w=;
        b=oiOnT5sEctJQ8CTVHnGi9rfMTdQNuKCMOScwxeF8EoJ0wVgclr9+aYGLg213+jmv6Q
         Ysf1WVvv4G3EGSlQjvIfmk75/ScNyH7ZWJGh5e+MeKPwjR+BduYdKP+tAlOI+zxNWeHt
         QXnJ1U+8vphfnpRvExq5J5AdaS6ias0PWVUtPLQfo0ct0MuKY6uCPVl/Nn7vYRL1sImW
         T/aS+7lwX1t5fpbb+/8o62j0TDf6RPbolVqfnogQ4R11VKUqtU3oldk2xvtu9rA+GrAu
         uc3UhcXh5cJig2fyD5eXZM23U8dsZM2AvK+llKBjvmmS1Z2VU5y0cBeQeAOACwer/YdI
         pvDw==
X-Forwarded-Encrypted: i=1; AJvYcCVR8Fm+D/S5Gek6ifl0KHuBR89bvbOE9Cn6Ecn+GCSBuI0RGthsRRu7zRQbkZqDrbZ9PgumDFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBzsxlAWmOhWX7qqoeD2lkRvLkjR3sz2Kt6Ciq8cr7fpQw29zd
	svAIUIyHb21iFUtDG5oNV4mDClpPSp/N0cRxJao+A9R4nzT38nrrCXMxcfZrwbIEaJ2RLqiQRoh
	kvuO+GU0SzWL1hp+GvTS8bt4Eom28Y3zgh9g/9BHeeAP0W5GsiuQu/7i/lczyuv8=
X-Gm-Gg: ASbGncvMwnEi+x8tZq90orZePJpxZQMo3J5tp6aHYfZouWDnvI2j3CHthEYPGwx2a6T
	1+EfQZrfCCED5yiC2yLlGyY07Npb9rx5tm5NduzE/mTmWxKhmmafxVMNF7cx8XYt2kuyAudEC2w
	HQGE2QMA8I3nj1sMn2HgGox5/z5vfSj8ce3cU+TWUKDPGLHFk9JTBeOOGDM71CG+77eJhf7ShJ0
	S/b73Xaow9Tqh+H8NzBjERSSC9VMrEU3KhVcXCSPc6XDU2CtTHgECIEK4rPAzKVnCjQC5dl+fGq
	TR8EiZqmK2J+qVQUaGjVVwg4CdnEqg==
X-Received: by 2002:a05:6a00:3989:b0:729:a31:892d with SMTP id d2e1a72fcca58-7322c591baemr20039226b3a.8.1739523415562;
        Fri, 14 Feb 2025 00:56:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0xCy3CGTXSILQ1bj4llABzfBeQ7obxgJnQtk/CYwRAuzAyy2KgJQVQxxN2Sx9fbn0eu/yyw==
X-Received: by 2002:a05:6a00:3989:b0:729:a31:892d with SMTP id d2e1a72fcca58-7322c591baemr20039209b3a.8.1739523415219;
        Fri, 14 Feb 2025 00:56:55 -0800 (PST)
Received: from [10.218.35.239] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e438sm2728749b3a.94.2025.02.14.00.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 00:56:54 -0800 (PST)
Message-ID: <b7903b50-4213-41d5-a7d3-5dded5f38994@oss.qualcomm.com>
Date: Fri, 14 Feb 2025 14:26:51 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] usb: gadget: Set self-powered based on MaxPower and
 bmAttributes
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        Sabyrzhan Tasbolatov <snovitoll@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250204105908.2255686-1-prashanth.k@oss.qualcomm.com>
 <2025021435-campfire-vending-ae46@gregkh>
Content-Language: en-US
From: Prashanth K <prashanth.k@oss.qualcomm.com>
In-Reply-To: <2025021435-campfire-vending-ae46@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: PI78ABw0newGJ_elc9y6XM14h0miLggF
X-Proofpoint-ORIG-GUID: PI78ABw0newGJ_elc9y6XM14h0miLggF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 mlxscore=1 spamscore=1
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=207 priorityscore=1501 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502140064



On 14-02-25 01:32 pm, Greg Kroah-Hartman wrote:
> On Tue, Feb 04, 2025 at 04:29:08PM +0530, Prashanth K wrote:
>> Currently the USB gadget will be set as bus-powered based solely
>> on whether its bMaxPower is greater than 100mA, but this may miss
>> devices that may legitimately draw less than 100mA but still want
>> to report as bus-powered. Similarly during suspend & resume, USB
>> gadget is incorrectly marked as bus/self powered without checking
>> the bmAttributes field. Fix these by configuring the USB gadget
>> as self or bus powered based on bmAttributes, and explicitly set
>> it as bus-powered if it draws more than 100mA.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 5e5caf4fa8d3 ("usb: gadget: composite: Inform controller driver of self-powered")
>> Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
>> ---
>>  drivers/usb/gadget/composite.c | 16 +++++++++++-----
>>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> What type of "comments" are you wanting here?
> 
> For obvious reasons, I can't apply patches tagged "RFC" but I don't see
> what you are wanting us to do here.
> 
> confused,
> 
> greg k-h
Sent an RFC since I got some comments last time while changing few
things on this path, was expecting the same thing this time, Will send a v2.

Thanks,
Prashanth K

