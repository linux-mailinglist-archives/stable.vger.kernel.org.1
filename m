Return-Path: <stable+bounces-196989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6EAC89268
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 10:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C28B54E7E0B
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 09:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A642B302143;
	Wed, 26 Nov 2025 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aaDQnlJl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JJJav6Do"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794BC2E7BC2
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764151063; cv=none; b=fsAr0f1tsaxhGC0zlCZueB4o8p54CU4fVz/G3UuvMnpQ1LL+LRnaZKy9vUsxjq8A++YfViKDypfE+38JAE+k+hyz31A/MzOPIegYjeJmWFucSspWwg72EfMqS4OjHSudpFIubTHJXjqFTCeI4TpawWghMix7rfT7ozTa1U5fyOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764151063; c=relaxed/simple;
	bh=K5DpPBXllEUbCmHPdCpV+GqoqwQPYfD1JefHZdl7Xsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a67FARZK++piCTqnS7OyKOXmlBIUrjDYHxOIe7/fDWncCho6W/yN6+BJaR4sBdTWkcrkIdxiIKZO2laF9wPY2C4NIIyOCiodTH96QvuGGkw3JHzE2/g+aygaCwL/9sxemTbqjW9bKNOKf1T092zPGcenWxEGLgTMXUnrvGJrv4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aaDQnlJl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JJJav6Do; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQ6FJqs3738573
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 09:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N/DvEzmiar/kChGL+cYmVWR5wIq/K/ckt6hzxuZXY7w=; b=aaDQnlJlu6R6TQln
	VrLD3mQ+DzQ1MJRRa2TtRJxr+S1rGcqWZSomoUzeYvGVQWH4DCKrXcbHldRcRTdE
	phcqfpuUrMrQ0rfViUzsVjaQK1uqeiaLtnkY9klyYgZEpNRSapXYPfkLHreVdJ8g
	IWCliMEsKMWmcL+CuVCZpvlq6/3uGUIaE7kiYc9DtDvPapeUGWFQoLWXhPNk/ndi
	1a7bkvz0dQ/6AzYlju2Z9N3u25LShXF1t4spYVNSgax79P7WkjmQxbX1C5TWkNPK
	R05e05hKmqB7Pm14tyZflsOcuV9O/JerH8cnbrSikUOPHR/GojO0xNRuBdjwcZzj
	RWfF1g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4anggyjd9p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 09:57:40 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3437f0760daso14500038a91.1
        for <stable@vger.kernel.org>; Wed, 26 Nov 2025 01:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764151059; x=1764755859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/DvEzmiar/kChGL+cYmVWR5wIq/K/ckt6hzxuZXY7w=;
        b=JJJav6Dofz8/u3MPMwgLW4WFV/nC7UA+MeaHlTFNgvXYZcN/lIBk7ROdSDruVMRu5b
         5NsBuzUd6fXz2u5vO3AxZecwsXVqCBcyktdf+cpDRjoqGfuozD2t3njyzuz2cclOJ0CB
         3dT7CW2iI8wIAFHwjXgc1LAFTHyWoyCppAYF5fkBZBHHhhzv22iWCLKyfryhIVWSa9bT
         BMQ6hkXFrSjpsF3xeT8hOkL+L6GMtsj1pLppjPKP7QrNF39WiteesFfhpMgRt3+1Quk8
         v/sGmXVkMzxgGAprqMjoFK3CWRAfZCI/Kt75y+zU6E1mERFqpYdMGtSUa7oosWyDNIVR
         fzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764151059; x=1764755859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N/DvEzmiar/kChGL+cYmVWR5wIq/K/ckt6hzxuZXY7w=;
        b=U0KF3mPFWPA1KrVMBnzEwMWikHRuIy5s3KaGdKwVbJFnx3eBfGa4JEjwFatClmCLrh
         e78LzJlyXVNR+XjtuEFIEoQgr4+q+rHiO+KGUwYLqWuEE20VFsu2Dv5vA4O8dMGBIM5q
         fI0l3i3gJ8WCIY0OnEd6PJP2Ix4V2YxyCvbWFvkrr6QZpSw0qpCROhuY4uBj7fGJ8ef6
         um5i6OtCiFmrdtK+eWJANVTRthMzcJ0lyJaC9dvqVX25oAZ1hgNzaB7PK72Xh43IQEgk
         jaMyNaESYaCGMIBskqMAH1+8EyzJ0K3xlib0cMn4Q3GJNoy0414uYeVhed7xtqmv2jE6
         8xKg==
X-Forwarded-Encrypted: i=1; AJvYcCU0RnflTFu4mpQOF3abdNOoNWBYh9VlnNJgXpRZ9PAF1yhpmO+H/lsw8jgud1yBxigugBrVUB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQaLLvq/wKHo6tXCpPeCdUHYNwEcVo43WiLijr7psdHlLJSCHJ
	TyAwmS2nf8yrx0ZkholwA3b5xjdH8g6MTO3KEiz7IPoGY1lphUBtCCJbUxBGiDXkcxge2OsZokw
	7xG1qtRFVl2ucswuZqqpjtXF9rkpKyKE9QhPHLoW/dC6jY7MQdXeBAPSAFM/D7iWYMpkckjrC3T
	s9U1/x7UuRPDnMEsfv3yHxJCJ9rmfe/mld5Q==
X-Gm-Gg: ASbGncvH+f+hZ6iCymis2Z8Ykl05VamedSpfpN/A3HK880c7BrB26EeVrnxiFWU/a6O
	pr67HfJM87QWbW4crOvYG/QMWQAUGdTDJk9bktzBICu0MzjuxwenCFkvjrQbuONobrcmGvpmmiY
	cn/jJ6Jm/xIunGQ8f0VQozq4FL8Zh0EtJNxNbzitYShXlz4N79AnlwxrqAZ4Qd5N+6bsb0Pqk81
	jLbHtIA
X-Received: by 2002:a17:90b:254d:b0:343:cf66:cd9a with SMTP id 98e67ed59e1d1-34733f258e7mr22093894a91.17.1764151059097;
        Wed, 26 Nov 2025 01:57:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPm+cEItO9Gq6mDuNnt0G4fXjfNfzDsFKLjy7ZZVK8amDDyHii2qxTsE36b04VrlBF/MSge4R9EyjVNs7Wa8g=
X-Received: by 2002:a17:90b:254d:b0:343:cf66:cd9a with SMTP id
 98e67ed59e1d1-34733f258e7mr22093856a91.17.1764151058554; Wed, 26 Nov 2025
 01:57:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125-venus-vp9-fix-v2-1-8bfcea128b95@oss.qualcomm.com>
 <wq7kaelokxqxkxxi5cvp7sz2az5hlam4nyyt4v55zrgei3jsyo@yyefysdsw3co>
 <e2b33a10-819d-df49-0687-74f6db4c5a05@oss.qualcomm.com> <CAO9ioeVKDjKMh3su2XVwXPxjfZNbVSan73d099C6_vkCqjkJmA@mail.gmail.com>
 <74bcf345-06e5-413a-d8cf-d87ba769e886@oss.qualcomm.com>
In-Reply-To: <74bcf345-06e5-413a-d8cf-d87ba769e886@oss.qualcomm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 26 Nov 2025 11:57:27 +0200
X-Gm-Features: AWmQ_bmMrASZzQot8GHg2lJViLb--o25rTi8-weiRqO6zgH9z6KFU8r71PUOqOs
Message-ID: <CAO9ioeWViAMv5Q3La90qKYbLkuHbK2Ui1f4KVMhT-ZNktaOWUQ@mail.gmail.com>
Subject: Re: [PATCH v2] media: venus: vdec: restrict EOS addr quirk to IRIS2 only
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        "Bryan O'Donoghue" <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Viswanath Boma <quic_vboma@quicinc.com>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Mecid <mecid@mecomediagroup.de>,
        Renjiang Han <renjiang.han@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: LL_dlGufv30NHbZJXlF7jkx6QIaz9eW3
X-Proofpoint-ORIG-GUID: LL_dlGufv30NHbZJXlF7jkx6QIaz9eW3
X-Authority-Analysis: v=2.4 cv=bNUb4f+Z c=1 sm=1 tr=0 ts=6926cf14 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=RyjZ-WcuOUbt_wwOA4kA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDA4MSBTYWx0ZWRfX2RWtXFht4mfJ
 1BSnjGEGFBqrXMwTubEkGvIf7KO+hHlZpCCgXZN9ZR/ywczc69ioa1vT8o/p+0f+eIMao1kbAMk
 QRpbgdOt5KK5FxIR4uTrZglUTu0HH8Jgq0Vg43qvIGUZgoNdvR27zh7StjS8nB7sQ80k2FPKBpo
 0nW7AQ/oIZq9ZChMd0Z6Raf/KNcG0rKiqr4WDlqnMk3XOoG/MCKc+EyS6H7QInOSJeks+uL0IWs
 2EHPU93qX0eJOh6QDpGRbzlGy4gdt6xEfl5O/s56oyDaFePepfTysgUQcoc6O5zIOkxDxyZsuDh
 iMtpb4njRzsEPBR3XFOgFm9AZ8Kcl5MCntLtGj1ZpGHsTlpn4fbNijqMzrCac04k9hFiEi2K38V
 m0gNlwdVH1LZAM+2sOPxsYjuJnyHOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511260081

On Wed, 26 Nov 2025 at 11:49, Dikshita Agarwal
<dikshita.agarwal@oss.qualcomm.com> wrote:
>
>
>
> On 11/26/2025 2:13 PM, Dmitry Baryshkov wrote:
> > On Wed, 26 Nov 2025 at 08:02, Dikshita Agarwal
> > <dikshita.agarwal@oss.qualcomm.com> wrote:
> >>
> >>
> >>
> >> On 11/26/2025 6:43 AM, Dmitry Baryshkov wrote:
> >>> On Tue, Nov 25, 2025 at 11:04:19AM +0530, Dikshita Agarwal wrote:
> >>>> On SM8250 (IRIS2) with firmware older than 1.0.087, the firmware cou=
ld
> >>>
> >>> Hmm, interesting. In linux-firmware we have VIDEO.IR.1.0-00005-PROD-4
> >>> for SM8250 firmware. This version wouldn't be parsed at all for SM825=
0
> >>> (nor does it follow the format string). Why? Would you please fix
> >>> version parsing for this firmware?
> >>
> >> Right, Seems this firmware doesn't have the proper version string, I w=
ill
> >> upload a new binary with proper version string soon.
> >
> > That's fine, but also we need to fix the driver to correctly work with
> > the firmware we currently have in linux-firmware.
> >
>
> The current firmware with version string VIDEO.IR.1.0-00005-PROD-4 works
> correctly with this logic. Since VIDEO.IR.1.0-00005 is not a valid versio=
n,
> it is parsed as 0.0.0, so the condition is not met=E2=80=94which is expec=
ted for
> this firmware, as it supports EOS using a dummy address.

The firmware was there for almost 8 months, e.g. hitting Debian
stable. Please send a patch, fixing parsing of the version string.

> >>>> not handle a dummy device address for EOS buffers, so a NULL device
> >>>> address is sent instead. The existing check used IS_V6() alongside a
> >>>> firmware version gate:
> >>>>
> >>>>     if (IS_V6(core) && is_fw_rev_or_older(core, 1, 0, 87))
> >>>>         fdata.device_addr =3D 0;
> >>>>     else
> >>>>      fdata.device_addr =3D 0xdeadb000;
> >>>>
> >>>> However, SC7280 which is also V6, uses a firmware string of the form
> >>>> "1.0.<commit-hash>", which the version parser translates to 1.0.0. T=
his
> >>>
> >>> I still think that using commit-hash is a mistake. It doesn't allow a=
ny
> >>> version checks.
> >>
> >> Agree, we had this discussion with firmware team sometime back and for=
 all
> >> latest firmware they are having rel version in the firmware binary, bu=
t
> >> SC7280 firmware binary would still have commit hash in version string.
> >
> > What prevents us from updating SC7280 firmware to also include :rel-NNN=
 part?
> >
>
> We are working with firmware team on this, future firmware releases for
> SC7280 would have video.firmware.1.0-<rel_version_number>
>
> Thanks,
> Dikshita
> >>
> >> Thanks,
> >> Dikshita
> >>>
> >>>> unintentionally satisfies the `is_fw_rev_or_older(..., 1, 0, 87)`
> >>>> condition on SC7280. Combined with IS_V6() matching there as well, t=
he
> >>>> quirk is incorrectly applied to SC7280, causing VP9 decode failures.
> >>>>
> >>>> Constrain the check to IRIS2 (SM8250) only, which is the only platfo=
rm
> >>>> that needed this quirk, by replacing IS_V6() with IS_IRIS2(). This
> >>>> restores correct behavior on SC7280 (no forced NULL EOS buffer addre=
ss).
> >>>>
> >>>> Fixes: 47f867cb1b63 ("media: venus: fix EOS handling in decoder stop=
 command")
> >>>> Cc: stable@vger.kernel.org
> >>>> Reported-by: Mecid <mecid@mecomediagroup.de>
> >>>> Closes: https://github.com/qualcomm-linux/kernel-topics/issues/222
> >>>> Co-developed-by: Renjiang Han <renjiang.han@oss.qualcomm.com>
> >>>> Signed-off-by: Renjiang Han <renjiang.han@oss.qualcomm.com>
> >>>> Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> >>>> ---
> >>>> Changes in v2:
> >>>> - Fixed email address for Mecid (Konrad)
> >>>> - Added inline comment for the quirk (Konrad)
> >>>> - Link to v1: https://lore.kernel.org/r/20251124-venus-vp9-fix-v1-1-=
2ff36d9f2374@oss.qualcomm.com
> >>>> ---
> >>>>  drivers/media/platform/qcom/venus/vdec.c | 8 +++++++-
> >>>>  1 file changed, 7 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/medi=
a/platform/qcom/venus/vdec.c
> >>>> index 4a6641fdffcf79705893be58c7ec5cf485e2fab9..6b3d5e59133e6902353d=
15c24c8bbaed4fcb6808 100644
> >>>> --- a/drivers/media/platform/qcom/venus/vdec.c
> >>>> +++ b/drivers/media/platform/qcom/venus/vdec.c
> >>>> @@ -565,7 +565,13 @@ vdec_decoder_cmd(struct file *file, void *fh, s=
truct v4l2_decoder_cmd *cmd)
> >>>>
> >>>>              fdata.buffer_type =3D HFI_BUFFER_INPUT;
> >>>>              fdata.flags |=3D HFI_BUFFERFLAG_EOS;
> >>>> -            if (IS_V6(inst->core) && is_fw_rev_or_older(inst->core,=
 1, 0, 87))
> >>>> +
> >>>> +            /* Send NULL EOS addr for only IRIS2 (SM8250),for firmw=
are <=3D 1.0.87.
> >>>> +             * SC7280 also reports "1.0.<hash>" parsed as 1.0.0; re=
stricting to IRIS2
> >>>> +             * avoids misapplying this quirk and breaking VP9 decod=
e on SC7280.
> >>>> +             */
> >>>> +
> >>>> +            if (IS_IRIS2(inst->core) && is_fw_rev_or_older(inst->co=
re, 1, 0, 87))
> >>>>                      fdata.device_addr =3D 0;
> >>>>              else
> >>>>                      fdata.device_addr =3D 0xdeadb000;
> >>>>
> >>>> ---
> >>>> base-commit: 1f2353f5a1af995efbf7bea44341aa0d03460b28
> >>>> change-id: 20251121-venus-vp9-fix-1ff602724c02
> >>>>
> >>>> Best regards,
> >>>> --
> >>>> Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> >>>>
> >>>
> >
> >
> >



--=20
With best wishes
Dmitry

