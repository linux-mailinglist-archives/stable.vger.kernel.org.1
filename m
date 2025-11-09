Return-Path: <stable+bounces-192858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BED3C447A2
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 22:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119993B0704
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 21:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA9D268C40;
	Sun,  9 Nov 2025 21:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fOQyAIom";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iQmaMnr7"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E64317D
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 21:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762723003; cv=none; b=lP/41WaDIBUU8kKlcpM1ztyDBl4rKZa7Q4qy4OQPgW/XWAocqUme0jh6Jw4rHflIWmvOpiRdt5QshxGM2XP0t91BNCWNGXcYGtLe50WzLjT6QeZKFFCyurM+qlcDTYQoulF5pD/mAQJ8Ww1cOyCHr5GG2t+2UMKtgb5jNnb1HlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762723003; c=relaxed/simple;
	bh=YKRFzAQU2yviHCep6w9J7Yc9MhUTG3/YbYdXnwDQk1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byokL/9KBl8Od/U5FTfc4PWhxwFtnE7AR1tJ9gpuhr68igyblKuHwHs2VNIyW9kaHvO8cwFxHtUOyhH28AS92TXDAV0ts8PD4FTrSzit2LAwCDLm0WvogEBQfe8b/Jl4juVeMy2jq02H972tUmddvXltMm+BR5QgmenWUFhilLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fOQyAIom; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iQmaMnr7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9L3JGO1634683
	for <stable@vger.kernel.org>; Sun, 9 Nov 2025 21:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=y9+qULSDBdRkc52X/nmwRInE
	9RrGB/j6DPLmA8vUbxc=; b=fOQyAIom3Rs8eKzkvAyIAobupLsvhG2DgBKYl5jj
	z0gj/WYngV3/dgTvFnFIlPiOFsjUzRn40M1lMNg75vO2nkFuA7S2wBEkqCYEJtXq
	nF02lSodMkyGMIYbpG9OLMJIfmOjYDQPz/AWeYd2kldA/0FzvYr48uE5cVm5sKJa
	tZCTsHs16Q+wq8CzEEeyHADXRLlsAVxghNPWiwbyJO4CUH96+zZ0j7tlLDpaQqf/
	1NJrB3VW2c1YNNcRp6quF1Iu7X8o04vft2nLIS9Fp55B8hoICKzSNWRkq6w/BAx4
	wWQcVnVYwNkxtovA9q6k3u3ovphesBW/XT4xn14PQQPaKw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xuejny3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 09 Nov 2025 21:16:39 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4edb31eed49so18602211cf.2
        for <stable@vger.kernel.org>; Sun, 09 Nov 2025 13:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762722999; x=1763327799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y9+qULSDBdRkc52X/nmwRInE9RrGB/j6DPLmA8vUbxc=;
        b=iQmaMnr7SI7Hcc92iAMFbfUYr7aXYpt30bH/c7ub0AX5URpvmxsBh8WuHH4eFxx+sH
         XW0AJRQkFtHh4ljt47mHyps8hCA7ryRvY8T3HefjW+UDJ/BEairxUNSMpAC3FCP7trmg
         oHw8CbRPjDN63ihPN0+TH189ykdXwBsONDqYVFHIFIUTkZg6TsS2+SCgm6qI1ktEl8dY
         Z9/DUncX71TKtUjNEtudIKba/1RaQVM6xsDjBBQGT2msbvLnH1cnouirHmHhWFoSW/sE
         3UPVG5X86ibTlhy8syb0aGof2SArC9KWhHlgZtI+gEnR+KoB9KyvGge5J41irLXP/5Jh
         DmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762722999; x=1763327799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9+qULSDBdRkc52X/nmwRInE9RrGB/j6DPLmA8vUbxc=;
        b=cfdi+YkbnyuxDLap8oEJxYI/Hn4CZShCKkyjzzCq/vxgkBFZFQAawGMwrUjdbyywJk
         XjFOLM16eOicHFMqZSdN/RftJjOjp9jEgefdX1K0V1aH2ZKlP0GmQrmFlG0C3HEoHvsv
         nvFbG5tY75eqlvkcuP24bNqon4BdjCJDdF3pzz8mrwK359pqQtETHtUXwIEqvpjkgQ/g
         eJpB3+EjQYtjru9XQJmY2J+JSfigjh3/jdl1NLuDxwLKnh8486VEvYLH9T4kYv6mvNiv
         IDJan8J+AlDjuMlENAfgr+mPSmm1aXJiX4H4BQh6fJthgyWy4prQjA1IrPyxDAmcjhKt
         i0dA==
X-Forwarded-Encrypted: i=1; AJvYcCXHacOr1S1vIIw5ooOtYo9mDo+uk0YheyUfaOvetJbzDphMGMH2aWUw1JbbiqED/UJQ1Iowgjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWA+vYmkmqo1TRZa43K/mrDL64ji7P3NSIu/R9+41JYlx2sqe1
	H7VDtOjrenzUVlkz5qSwtQeiitYd7dgw/v6vwB8Q+sEE4G+8YjBWNkoZ8kHMfmrTKEtEieYvJ6j
	9C4SBtb9y0VxAn5BIQ7g9hCrWilx3xcpquRU3xsT43VQzePbSm6COuGo+xkE=
X-Gm-Gg: ASbGnctO0h24d7N55IJqsB5mu8CVKHTYg5YMnw9/IARTU5Rt5M94n1uIqej8KlD4fVX
	F+2ik0fbzo5nYzFAAoYPF1EH63usmItjq8QRYjSAFyz8xg5TtcCuRnzUd5fYJhRo5tJcewh3Gzi
	eJZO6IkVOWAck/Y+E+ij3KwGnW5sxNyeCyQmaaWkU47zryfbjnD0RB2t9lWKNFNK/ga6QZrZo/c
	mJP6naNUUf2dXlaOJ/GJTDoLDzPXhxfFOa2PTaJpwfGQxKtdKRPlfJ81q55SxusIdSVDiWLEqj5
	nQa5smNbB6EU5uoQEK8CjI/bRu/v/mvTJQ6meDVV0/fceRQXKoQE2xSB/s60vgeXLGNHJeWyJZf
	MJ+V6NeC0OsymWr3pi/kWSWYxuekYOXwOSQjXL2/5CXeu+xOthdQUC3aX7XNlNiovOLsZ4QFCuZ
	KbEJ0z/JWmphAl
X-Received: by 2002:a05:622a:201:b0:4ed:b55b:674d with SMTP id d75a77b69052e-4edb55b6a65mr26511541cf.59.1762722999272;
        Sun, 09 Nov 2025 13:16:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEH8BiFfw+ts2f53C6zCXeNgfkClVAFT63zGR6OYEJ0OIG9wp5dnSJCliqhgGeg5aYM484U5w==
X-Received: by 2002:a05:622a:201:b0:4ed:b55b:674d with SMTP id d75a77b69052e-4edb55b6a65mr26511301cf.59.1762722998839;
        Sun, 09 Nov 2025 13:16:38 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a01a029sm3324582e87.35.2025.11.09.13.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 13:16:36 -0800 (PST)
Date: Sun, 9 Nov 2025 23:16:34 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Val Packett <val@packett.cool>
Subject: Re: [PATCH v3] media: iris: Refine internal buffer reconfiguration
 logic for resolution change
Message-ID: <2uvinljz3gevbusjrz3bzi3nicelv3t6a64gliv4mdv6cbllvp@fz3qbyukypho>
References: <20251105-iris-seek-fix-v3-1-279debaba37a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-iris-seek-fix-v3-1-279debaba37a@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDE5MCBTYWx0ZWRfX/gbOdy8onZmW
 0Pb+QozbYi7MEHOefDmWYkVvhPUbnjUpPw1/0E1ib/iN24C0BfXzc4t1Tf0RUijClSSP6C3onyA
 yzXXMKWMLOcQF34jnhbSY5/mc+hoJDiR71spdppM6cPTrf7qJo2IyFrvnbSWxOSuHMB4QM3Rvdt
 rb1LHLowOeeb5cfGWMZ+xk6OXS2dHR+IYbEju9oeyxgtX1wCPMoFaXMHe8kXvR3T3e4EFWAols+
 ljz/1jjWnWPSDyOCG+PlMEJTg//2APLbgolLiRbr2BSlzYGWzyNhYi+GxsdsmHLBFLPpLNzhe3O
 TyTAx6ZDqAUZHpgod8W9IeWDnI8l51QhOZ14vsQyz1r6z9Y76n+eAtBf1v3vjNe4SVVKjh72rcu
 mqBU62vfWQil/ZKr3HJg01pKW+KzCQ==
X-Proofpoint-GUID: Wo1eydZtnf5xhJ2spJRQN-jahWXJ01gD
X-Proofpoint-ORIG-GUID: Wo1eydZtnf5xhJ2spJRQN-jahWXJ01gD
X-Authority-Analysis: v=2.4 cv=BOK+bVQG c=1 sm=1 tr=0 ts=691104b7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=K7FOPutcZWfKzoRN3qAA:9
 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_09,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511090190

On Wed, Nov 05, 2025 at 11:17:37AM +0530, Dikshita Agarwal wrote:
> Improve the condition used to determine when input internal buffers need
> to be reconfigured during streamon on the capture port. Previously, the
> check relied on the INPUT_PAUSE sub-state, which was also being set
> during seek operations. This led to input buffers being queued multiple
> times to the firmware, causing session errors due to duplicate buffer
> submissions.
> 
> This change introduces a more accurate check using the FIRST_IPSC and
> DRC sub-states to ensure that input buffer reconfiguration is triggered
> only during resolution change scenarios, such as streamoff/on on the
> capture port. This avoids duplicate buffer queuing during seek
> operations.
> 
> Fixes: c1f8b2cc72ec ("media: iris: handle streamoff/on from client in dynamic resolution change")
> Cc: stable@vger.kernel.org
> Reported-by: Val Packett <val@packett.cool>
> Closes: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4700
> Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> ---
> Changes in v3:
> - Fixed the compilation issue
> - Added stable@vger.kernel.org in Cc
> - Link to v2: https://lore.kernel.org/r/20251104-iris-seek-fix-v2-1-c9dace39b43d@oss.qualcomm.com
> 
> Changes in v2:
> - Removed spurious space and addressed other comments (Nicolas)
> - Remove the unnecessary initializations (Self) 
> - Link to v1: https://lore.kernel.org/r/20251103-iris-seek-fix-v1-1-6db5f5e17722@oss.qualcomm.com
> ---
>  drivers/media/platform/qcom/iris/iris_common.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_common.c b/drivers/media/platform/qcom/iris/iris_common.c
> index 9fc663bdaf3fc989fe1273b4d4280a87f68de85d..7f1c7fe144f707accc2e3da65ce37cd6d9dfeaff 100644
> --- a/drivers/media/platform/qcom/iris/iris_common.c
> +++ b/drivers/media/platform/qcom/iris/iris_common.c
> @@ -91,12 +91,14 @@ int iris_process_streamon_input(struct iris_inst *inst)
>  int iris_process_streamon_output(struct iris_inst *inst)
>  {
>  	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
> -	bool drain_active = false, drc_active = false;
>  	enum iris_inst_sub_state clear_sub_state = 0;
> +	bool drain_active, drc_active, first_ipsc;
>  	int ret = 0;
>  
>  	iris_scale_power(inst);
>  
> +	first_ipsc = inst->sub_state & IRIS_INST_SUB_FIRST_IPSC;
> +
>  	drain_active = inst->sub_state & IRIS_INST_SUB_DRAIN &&
>  		inst->sub_state & IRIS_INST_SUB_DRAIN_LAST;
>  
> @@ -108,7 +110,8 @@ int iris_process_streamon_output(struct iris_inst *inst)
>  	else if (drain_active)
>  		clear_sub_state = IRIS_INST_SUB_DRAIN | IRIS_INST_SUB_DRAIN_LAST;
>  
> -	if (inst->domain == DECODER && inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE) {
> +	/* Input internal buffer reconfiguration required in case of resolution change */
> +	if (first_ipsc || drc_active) {
>  		ret = iris_alloc_and_queue_input_int_bufs(inst);
>  		if (ret)
>  			return ret;

I will repeat my (unanswered) question from v2:

After this line comes manual writing of STAGE and PIPE. Could you please
point out where is the driver updating the resolution in the firmware?
And if it does, why do we need to write STAGE and PIPE again?

-- 
With best wishes
Dmitry

