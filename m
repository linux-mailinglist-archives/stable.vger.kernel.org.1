Return-Path: <stable+bounces-136850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCEBA9EE8A
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 13:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F843BF795
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 11:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D812638A6;
	Mon, 28 Apr 2025 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kbvv54UE"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2257D26136D
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745838451; cv=none; b=Wfo6ObX7f186T0vg/EV7pUaCxLyrTxGoNpFnN5ydSSw1CnwxJexamDglKZXBrBzZd1Y+TXe8cjpXTdQSXrZcX5xzb1j01CeKU6v2uYcqION7TcZTU3jCCyj3NWF7F7CJZQRHSkmHLLD+NgvhWcLafnKkzUDiQukoztcrBJbxEMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745838451; c=relaxed/simple;
	bh=M5a72SnLmxLgt0pLFP1RNooL8qkaeK85AvCHuLBnTl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2q7JNrRzUhUfCASSeL00sv45Z2QwH81rBRoq9ndIDoj9dRMxUyDmbHJ+G9QZ6a9Yo0QHQcX8O+QYa0z0+t70R++DK3Do0kXUFAgdrmJRmuiqxtIvXYWwEwbsl+V2G20srH+eJTf+UZVk4YViaZBGTTta4USzXz+yJDbc8wDo1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Kbvv54UE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S9ltV0002905
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=buw62CaYGeBn0LKx/kq4sImv
	JakRZXfLy3TgDiC9P+s=; b=Kbvv54UEjTvLNJhpDdXJOqlFLCJSy2RB3gPAICCX
	am7GgR5U3j4QaQy2R02XG0l7nstpw7IQez8PmVQJQi+cV7s6qYlmvZ3vonZhvRUK
	UXoGvnIk+A+8VzKOs5xHUZSJrNVAmR3QBKohQlr1s6KRgC1luYQS0Rwn61TDKm8m
	d/u3YGsOfKfZfJg0n0xEZUUZMNDG5aAx6qQVdIDAbzh/WUwkbvZ6Pb4o/mIMsGzx
	jAsCOwSwYeL60cKy+aPm3Gw+ilr5k3ma6V5kb9Whr5mRq2y5wnH2iN5HFDBMn4yu
	FMbrwNktL0quZ1Hxmbj/L44aoJMNzV6d+zadpR70LkSD8A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 468n6jg5w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 11:07:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c544d2c34fso691541885a.1
        for <stable@vger.kernel.org>; Mon, 28 Apr 2025 04:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745838448; x=1746443248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buw62CaYGeBn0LKx/kq4sImvJakRZXfLy3TgDiC9P+s=;
        b=Xc5kKwD0ErmJAVtv7EOTig49SpcU4EkP/+oDbCw5rQKi09oP9cV9dEgtd/q1ZEPElY
         Rf9/qz7D6ShZNDNUQxU8mE6K4epgeYvuwZF/UYxN/bUDRNprGN5IH0igdaTvpoU96uKS
         rqiHWBnwIJRDTGtDdMTUDtKlnf6gfmw3fvTj6vx/3/Do1zK74cZq9tnBwvEv7WbuwFYJ
         WaMabTRJDHRLZ23LxOs0dVa9saB03hwT7JHIXPNWMkolUfxM1IkwYPLpdILj50Rc45xb
         F8sDK6m5H3J5aiaecwwKny/Srr0vM53xn0OH9EJmxf2BwP+qNJDSz3YUdmNbSFqAdXXC
         nGNw==
X-Forwarded-Encrypted: i=1; AJvYcCXyfH7R0fp19eWBopShDp75s5H7/rZNJroyHeVk7a/TvzeEA6bIAVe6d23TPTLfD3w0M8TXyPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGR2cMb9cFiNla0tcDuLlq3zvkv35L9DEnRbc3p25vdY8rFHH2
	osABe3iAzSWUWv4IlJXFFF9kVQqeAE5L0fGPq7w67gWe9FGoNaWFKy4K3Eq1gIm+UfWmNU0cnJW
	6EI8qW1U04Rnd5eqI7TdEWKLZjM2UHwjEruSknGPJEhdzCAN4uPG9ibA=
X-Gm-Gg: ASbGnctuW2LhiS59kMaCT6lZnRKeE+ImzRKNQO1NC1D7VdHs9TpD6Kj27TP9ZTgec6f
	bPOLFoRzLTcd2jkpyDzUqgFaBnlnECYvjFemfhlXzb+J9xTSTtol00zLZoXLfSxd/0tvhfOoacB
	BUiTUXcxvpobukQirKdTJ9ImL3Pthuqdhd73HbRh+EUMqV4Sa79istJ5uzxcMz7RR2qlA2ZEVFG
	VjK+KaNKkES4scJ43UrMeVrSGgRnZAV3wQAGladAwrIfXvN8i7ZAHOfIk6H7uFzxc3NV52sMnO2
	939L5kJnZ6xr7mhNQXbauuYozvjrPQ6tOoXgvVFEAjhdA1Lca5zVRN+YBTarNTordV5E/RiSzZA
	=
X-Received: by 2002:a05:620a:1905:b0:7c5:4913:500a with SMTP id af79cd13be357-7c966874947mr1304931585a.19.1745838447627;
        Mon, 28 Apr 2025 04:07:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVA3Hl/avCQTsqMNZ8CMfA9OXVQUBDuWJdpUdGcqx6z2ID2F9p8dzYZ8mAe5+uThpCUReWxQ==
X-Received: by 2002:a05:620a:1905:b0:7c5:4913:500a with SMTP id af79cd13be357-7c966874947mr1304928185a.19.1745838447239;
        Mon, 28 Apr 2025 04:07:27 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-317d1b96d85sm21216121fa.97.2025.04.28.04.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 04:07:26 -0700 (PDT)
Date: Mon, 28 Apr 2025 14:07:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        20250417-topic-sm8x50-iris-v10-v7-0-f020cb1d0e98@linaro.org,
        20250424-qcs8300_iris-v5-0-f118f505c300@quicinc.com,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2 00/23] Add support for HEVC and VP9 codecs in decoder
Message-ID: <dwslruo5gzaiuag7utvrtysjfkisvudnxd6qvzezkpodw4xul6@55ei2zuuiggx>
References: <20250428-qcom-iris-hevc-vp9-v2-0-3a6013ecb8a5@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-qcom-iris-hevc-vp9-v2-0-3a6013ecb8a5@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDA5MiBTYWx0ZWRfX9mO6NWrBYAp0 4eDooU3LTPO5/x7g7e8wJSBqdv48FGJnBD4hoMKUzzFmWzno9CJrVvYva3Jukw2Fh5SRjoGiLZb GHo50QzTQaKkrI6EfeYtAhPEtD6oXDNn4MX8yjfrUAUj/6Wj43D6xRrpIQnfH5q9GbQUkkLMElb
 fIoS3f++tPiZRunAX2J3i8ItyBBqoYrrbmtMk1C4PHIt3QwHQ9gvaYW/42RiIvDgYkVISTNPTRl 41pqPC/mko1wOHJrWB9LB/Mql2v2sngZUc8KORRdlvJJLRuguLuLyy+vBeiaUHgFt8XHySfhtzl nfyYNX6ZUf5LMC+NZOoBs3hHsLYe1gtd6E1oRvYMb74pMzayisvNXhrLDBMf0uon6ewBnep0+DQ
 VUoMrI2d3WAAKRFUyaER70fR+HtRs+X7HvshVWrpIeN8C7VtngdhzEAnw4J5Kr9JkS4jhxYc
X-Proofpoint-GUID: GRKQUvc5lTy8SnrBOKh--vW1s_vZi4zy
X-Proofpoint-ORIG-GUID: GRKQUvc5lTy8SnrBOKh--vW1s_vZi4zy
X-Authority-Analysis: v=2.4 cv=C8fpyRP+ c=1 sm=1 tr=0 ts=680f6171 cx=c_pps a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=KKAkSRfTAAAA:8 a=Y7auG_7NL3QQPu7xwnEA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280092

On Mon, Apr 28, 2025 at 02:58:48PM +0530, Dikshita Agarwal wrote:
> Hi All,
> 
> This patch series adds initial support for the HEVC(H.265) and VP9
> codecs in iris decoder. The objective of this work is to extend the 
> decoder's capabilities to handle HEVC and VP9 codec streams,
> including necessary format handling and buffer management.
> In addition, the series also includes a set of fixes to address issues
> identified during testing of these additional codecs.
> 
> These patches also address the comments and feedback received from the 
> RFC patches previously sent. I have made the necessary improvements 
> based on the community's suggestions.
> 
> Changes in v2:
> - Added Changes to make sure all buffers are released in session close 
> (bryna)
> - Added tracking for flush responses to fix a timing issue.
> - Added a handling to fix timing issue in reconfig
> - Splitted patch 06/20 in two patches (Bryan)
> - Added missing fixes tag (bryan)
> - Updated fluster report (Nicolas)
> - Link to v1: 
> https://lore.kernel.org/r/20250408-iris-dec-hevc-vp9-v1-0-acd258778bd6@quicinc.com
> 
> Changes sinces RFC:
> - Added additional fixes to address issues identified during further 
> testing.
> - Moved typo fix to a seperate patch [Neil]
> - Reordered the patches for better logical flow and clarity [Neil, 
> Dmitry]
> - Added fixes tag wherever applicable [Neil, Dmitry]
> - Removed the default case in the switch statement for codecs [Bryan]
> - Replaced if-else statements with switch-case [Bryan]
> - Added comments for mbpf [Bryan]
> - RFC: 
> https://lore.kernel.org/linux-media/20250305104335.3629945-1-quic_dikshita@quicinc.com/
> 
> This patch series depends on [1] & [2]
> [1] https://lore.kernel.org/linux-media/20250417-topic-sm8x50-iris-v10-v7-0-f020cb1d0e98@linaro.org/
> [2] https://lore.kernel.org/linux-media/20250424-qcs8300_iris-v5-0-f118f505c300@quicinc.com/
> 

[...]

> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
> Dikshita Agarwal (23):
>       media: iris: Skip destroying internal buffer if not dequeued
>       media: iris: Update CAPTURE format info based on OUTPUT format
>       media: iris: Add handling for corrupt and drop frames
>       media: iris: Avoid updating frame size to firmware during reconfig
>       media: iris: Send V4L2_BUF_FLAG_ERROR for buffers with 0 filled length
>       media: iris: Drop port check for session property response
>       media: iris: Add handling for no show frames
>       media: iris: Improve last flag handling
>       media: iris: Skip flush on first sequence change
>       media: iris: Prevent HFI queue writes when core is in deinit state
>       media: iris: Remove redundant buffer count check in stream off

Please move all fixes patches to the beginning of the series. This helps
maintainers to pick them up for the -fixes branches.

>       media: iris: Remove deprecated property setting to firmware
>       media: iris: Fix missing function pointer initialization
>       media: iris: Fix NULL pointer dereference
>       media: iris: Fix typo in depth variable
>       media: iris: Add a comment to explain usage of MBPS
>       media: iris: Track flush responses to prevent premature completion
>       media: iris: Fix buffer preparation failure during resolution change
>       media: iris: Add HEVC and VP9 formats for decoder
>       media: iris: Add platform capabilities for HEVC and VP9 decoders
>       media: iris: Set mandatory properties for HEVC and VP9 decoders.
>       media: iris: Add internal buffer calculation for HEVC and VP9 decoders
>       media: iris: Add codec specific check for VP9 decoder drain handling
> 
>  drivers/media/platform/qcom/iris/iris_buffer.c     |  52 ++-
>  drivers/media/platform/qcom/iris/iris_buffer.h     |   3 +-
>  drivers/media/platform/qcom/iris/iris_ctrls.c      |  35 +-
>  drivers/media/platform/qcom/iris/iris_hfi_common.h |   1 +
>  .../platform/qcom/iris/iris_hfi_gen1_command.c     |  48 ++-
>  .../platform/qcom/iris/iris_hfi_gen1_defines.h     |   5 +-
>  .../platform/qcom/iris/iris_hfi_gen1_response.c    |  39 +-
>  .../platform/qcom/iris/iris_hfi_gen2_command.c     | 143 +++++++-
>  .../platform/qcom/iris/iris_hfi_gen2_defines.h     |   5 +
>  .../platform/qcom/iris/iris_hfi_gen2_response.c    |  58 ++-
>  drivers/media/platform/qcom/iris/iris_hfi_queue.c  |   2 +-
>  drivers/media/platform/qcom/iris/iris_instance.h   |   8 +
>  .../platform/qcom/iris/iris_platform_common.h      |  28 +-
>  .../media/platform/qcom/iris/iris_platform_gen2.c  | 198 ++++++++--
>  .../platform/qcom/iris/iris_platform_qcs8300.h     | 126 +++++--
>  .../platform/qcom/iris/iris_platform_sm8250.c      |  15 +-
>  drivers/media/platform/qcom/iris/iris_vb2.c        |  18 +-
>  drivers/media/platform/qcom/iris/iris_vdec.c       | 117 +++---
>  drivers/media/platform/qcom/iris/iris_vdec.h       |  11 +
>  drivers/media/platform/qcom/iris/iris_vidc.c       |   9 +-
>  drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 397 ++++++++++++++++++++-
>  drivers/media/platform/qcom/iris/iris_vpu_buffer.h |  46 ++-
>  22 files changed, 1154 insertions(+), 210 deletions(-)
> ---
> base-commit: 398a1b33f1479af35ca915c5efc9b00d6204f8fa
> change-id: 20250428-qcom-iris-hevc-vp9-eb31f30c3390
> prerequisite-message-id: <20250417-topic-sm8x50-iris-v10-v7-0-f020cb1d0e98@linaro.org>
> prerequisite-patch-id: 35f8dae1416977e88c2db7c767800c01822e266e
> prerequisite-patch-id: 2bba98151ca103aa62a513a0fbd0df7ae64d9868
> prerequisite-patch-id: 0e43a6d758b5fa5ab921c6aa3c19859e312b47d0
> prerequisite-patch-id: b7b50aa1657be59fd51c3e53d73382a1ee75a08e
> prerequisite-patch-id: 30960743105a36f20b3ec4a9ff19e7bca04d6add
> prerequisite-patch-id: b93c37dc7e09d1631b75387dc1ca90e3066dce17
> prerequisite-patch-id: afffe7096c8e110a8da08c987983bc4441d39578
> prerequisite-message-id: <20250424-qcs8300_iris-v5-0-f118f505c300@quicinc.com>
> prerequisite-patch-id: 2e72fe4d11d264db3d42fa450427d30171303c6f
> prerequisite-patch-id: 3398937a7fabb45934bb98a530eef73252231132
> prerequisite-patch-id: feda620f147ca14a958c92afdc85a1dc507701ac
> prerequisite-patch-id: 07ba0745c7d72796567e0a57f5c8e5355a8d2046
> prerequisite-patch-id: e35b05c527217206ae871aef0d7b0261af0319ea
> 
> Best regards,
> -- 
> Dikshita Agarwal <quic_dikshita@quicinc.com>
> 

-- 
With best wishes
Dmitry

