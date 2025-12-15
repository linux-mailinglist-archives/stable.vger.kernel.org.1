Return-Path: <stable+bounces-201004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6A9CBCF02
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 09:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42A05301338F
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 08:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B81261B8D;
	Mon, 15 Dec 2025 08:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cTZ8/drU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YhvJrg6A"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E5E23372C
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765786522; cv=none; b=GH0E66jFaFBvPDDD+kr+1MatoUM9Tz89zG0fQqI8u7zgy7XTpTyGlZJboV9tZvw9jgXWxCmiTmn7G0nY7wESIvYahRGG8LjIaMjbyl6SE7yFU42jCjZ3Zlhw29wE9eONivD1IT4igav2iI3c0/JxSg1uxLO7OsHVCkhcDEodlpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765786522; c=relaxed/simple;
	bh=PH0Mkgd0hXxjWs63tOgcIWNhGMn6Z+snoo0Hm3OeoVs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kBOzHiCe2y3byN/EWW5uVhQNBnKqdcr+foTvAw5XjCMDUYEMLQs8uhy7hCftscY6FaO1Ux4C4kElGVaewninub7acbnGVFBWPNsTqidAzmT7r86NMF9+UG0sZWxak154y2bptUrd5G2XkaEg8HxmBZC0BHCBKOoB181m/xvlnpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cTZ8/drU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YhvJrg6A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF0P89k3003528
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 08:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QtB6NVX0tQTDQSGjdfGQV96hC4CJqucWW+mRBRXhmM0=; b=cTZ8/drU+sw8/rkk
	MWJhReUk+/Ih3VAluyY45TRQIy8t3W6KDzZWvRy7w2Il6Z4yBqmJaa2F0xeQ/Q6W
	HBOcdK2qu3Ojr1yto/YPf5SBTq7L+3GLBH7qqeq2ZfGwSCLPLJ5rF/ugWnKIehA8
	2ZF6SSI/kmbYuSdiZNYcQ7ktBXkAyJ5sIcPLpVDTy7M6Hdx1BrC4P338IcMJpPlk
	UahXpdUb9KwGLHl9FvyyqC9D2Vv9uEixGVFE35maT0R6HXzcLGv/zW9yb4ocQiDo
	EPa8wAj4TaBNzUOXryVFqZRhilEMLtWGjRaB8GIgOr+gYoAto0wvlt2njCAc4Otk
	q1VHjQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b119t3pym-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 08:15:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8bb0ae16a63so389695385a.3
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 00:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765786519; x=1766391319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QtB6NVX0tQTDQSGjdfGQV96hC4CJqucWW+mRBRXhmM0=;
        b=YhvJrg6AaYS9UIx3GGs+db7/wuO0X0hGnhWmdweZzpZ0trtnRMTyyY6bLc1ea2tgPm
         KLEwYhDoztwYl48OprivQ7Dah5rcX+R0aGUhjhDfSgSzEUV2wWbIYemfRhMlCjZs2B7C
         Uz48gVZm3ta4hB7UtmYUuSiawfOh03ypq/ug54gLoer0YsGsqfRlO3KDV5ydUVs/Hz2J
         lPacfJmE0SKi+P7+5YrXREguqPXHXUky+nIRotsPlX4nq0eQ1z3YgL0fhZ+e8WjXRAcZ
         vuiei5pg+GHbo/5s1HANU8pXBEOoJhWgBNJ1mKbCKdg7OgKT3bexuHh7BEB586ZLGQCH
         rfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765786519; x=1766391319;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtB6NVX0tQTDQSGjdfGQV96hC4CJqucWW+mRBRXhmM0=;
        b=q6an9qCN70ZdFxLPe5IFgbOQDvdt0NXGM/4TFTaGUjFvZriVG0fCQ6NmZcsy2cRN86
         kUKyl8Qz7WneQggHqNDcSE6Nr9V4I2sRbZhPQ0ln2VQdFl7gbylqW7HizG5JM+eZJOBI
         wN+eJELWZoS59o6+rs2RWjspoiVrdPUWSWW5ak6Pu49kzaYm4rDM74gMIK4nu+ZTSEYR
         xw819aVo/5qpP7XG5jLdXA0SzMsGE5vucio2QmUo5iVhyK/13q7TOPeF4yAf/Cz9lm2x
         cChEdYwuNxOYrPfqilCRjyHGmgVMtXOZFXctA+h6p3+EKoZh5HOsG1av/hMTyyEMdhfF
         7P0w==
X-Gm-Message-State: AOJu0Yw7AH1sJ8sTPuNHCajw3JAP1Wwq02LTAa2zsRtMpTnVJo8PNH7B
	E8CL0OYByzwIiVi8tpSdEN3TC4VCt5qTNw+VH/mKAlBnFdWmubPXnaJ/m3Uu2axFj72Fw1OeyyS
	3AeXIWRqW7MvngmtaYv7D845WnYYtRYzCiIKuv+MTTOEhqxbrNPBBATrzZTk=
X-Gm-Gg: AY/fxX55dXUKtqRswAsZltt0pNcAANw6fcY3XAMVQw5f/Ho51rd8v+GM0yJ3sdSlFRW
	6le6TwjvsRkFT6S6UpO8NEqLBAYLCs5cOj8CS4csXDlwcw78jhDz8SCJoSGqRKQcmCTs2B8hL5S
	tj0plcjtaWGiAWTqVEChVyyfM/+9qAr6x1ybI0+tC8Td3XohwxWNu3+EpVbpg+6Of+FRP7xNyvH
	7VoNRe7wSRzFxCzjQLZ5PO1um+D/gJgXJoM0UonhCHgF3aeoD+AhBYqz9wrw4hLEaKR3l0URQ2I
	jCZ81H1loRhaQzHQ9+ZP+l4BzQzJP2df0+lSByks0ladw1+kziZjVtupcznnUz9wtJZqZ8uifEh
	P+Q3F2CoVfvJm1mc9IbNqIHjRbbXf
X-Received: by 2002:a05:622a:124a:b0:4e8:a664:2ccb with SMTP id d75a77b69052e-4f1d062a521mr119642561cf.63.1765786519466;
        Mon, 15 Dec 2025 00:15:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlnMOL2y04Gq+0GVoZ2JOy4+YBfTiwceLZ0Y2XDfulXkJ2eKSADeFoHGth+LWlcFJhxvKdNA==
X-Received: by 2002:a05:622a:124a:b0:4e8:a664:2ccb with SMTP id d75a77b69052e-4f1d062a521mr119642411cf.63.1765786518970;
        Mon, 15 Dec 2025 00:15:18 -0800 (PST)
Received: from [10.40.99.10] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-649820517d6sm12636784a12.13.2025.12.15.00.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 00:15:18 -0800 (PST)
Message-ID: <b78aadb1-d2ca-459c-8078-b1cd9a500398@oss.qualcomm.com>
Date: Mon, 15 Dec 2025 09:15:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH] drm/amdgpu: don't attach the tlb fence for SI
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
References: <20251214095336.224610-1-johannes.goede@oss.qualcomm.com>
 <2025121502-amenity-ragged-720c@gregkh>
Content-Language: en-US, nl
In-Reply-To: <2025121502-amenity-ragged-720c@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA2OCBTYWx0ZWRfX9RthAN1MuBFg
 5HRK7H471I6ZLVMULdeGWUpuTep/KMlNsFy6fPJ5NlDoeFu3VKw3Oa0GktHtQP3o3T5Pww+QTtH
 tF2YGgRTaMXB0morPjyQf8MK4h4EsigkOJdertHYAy61IrczUMaZIkSW7Y8UasUdPanNNF/9Atu
 vCa+YoUIlphukbiVeuNoAxDUWaZHWmtn7DDVi0AonWHqVxazKpiIjDF5MmnOuHQ0OA32q7Omjvs
 MxuSHx3bUAJ6nCG4lSWD7hLWgZN2jub4ZiZLK1zi81NwMT/0VvpnBD2AwzKSXpheF5j+okhRwh/
 1w84jOAd+KfSUpyGmVAJ/g9wmHDB67EoBovsUThzZFAsSUeQKzd6uqX0KtmdDtxHi2jAiY2WRQm
 x0F0XQHhRdmfV+lR0m5Xicb8TAYMkA==
X-Proofpoint-GUID: 8lYuHlOQ4QnVGSG6Gbaz841H3iBWdzOr
X-Authority-Analysis: v=2.4 cv=E6nAZKdl c=1 sm=1 tr=0 ts=693fc398 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=rrvG0T/C2D967D07Ol03YQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=e5mUnYsNAAAA:8 a=zd2uoN0lAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=qvFIrRrG3lAkoLfHr2AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: 8lYuHlOQ4QnVGSG6Gbaz841H3iBWdzOr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_01,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512150068

Hi greg,

On 15-Dec-25 9:12 AM, Greg KH wrote:
> On Sun, Dec 14, 2025 at 10:53:36AM +0100, Hans de Goede wrote:
>> From: Alex Deucher <alexander.deucher@amd.com>
>>
>> commit eb296c09805ee37dd4ea520a7fb3ec157c31090f upstream.
>>
>> SI hardware doesn't support pasids, user mode queues, or
>> KIQ/MES so there is no need for this.  Doing so results in
>> a segfault as these callbacks are non-existent for SI.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4744
>> Fixes: f3854e04b708 ("drm/amdgpu: attach tlb fence to the PTs update")
>> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> What kernel tree(s) should this go to?

This fixes a regression introduced in at least 6.17.y (6.17.11)
and 6.18.y (6.18.1). So it should at least go to those branches.

If any other branches also have gotten commit f3854e04b708
backported then those should get this too.

Regards,

Hans




