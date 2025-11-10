Return-Path: <stable+bounces-192952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC2DC46AF6
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 13:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9521890C91
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 12:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F8430F819;
	Mon, 10 Nov 2025 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="audW4yck";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cVbC36I1"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C635830EF71
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778562; cv=none; b=uFidEEalfVXps/kjEsmR5F4idqeKmjCDOBPWQoN9Aam3UofiDinrft1kUbdR/gZONlZsN/JRviH5wwoHVFSMjZyIG4tv9Alwl1h5ih9SALY6y3qwOiDd4klceUATrWIytagtlPf2eQTQcGjXP3t3R0j5cjvT14RBLXsTWt3uMBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778562; c=relaxed/simple;
	bh=oycCGrJnIys6pRkKgZL7qnTNFiPgdJ8eOZ85qTOqp34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUbYpgMyUqsspRXduDH2Woat3XnfD/czUcj7yJ8w64KxhITcAtE6jshtHkzqZOiNANUHme8uTZufZM2yX0DeOkZugNWRVrcvrQXeh75oPOaU4TI7DX3mDS6R2cxrC/2a0NL3/YCKGnVWPmLbsyNFQbM7k/3DYngJfS+k1J4XIrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=audW4yck; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cVbC36I1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA6SY2x2407943
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 12:42:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Szk5oQu0JKW4WvvkHevPC12l
	/Yr8odd2nrlXcJxADTI=; b=audW4yckeo0wqh+AJZjiTxCg7F/UhqXY05X88YPf
	9no+NBEnjCJfkDUdXK8AcHfS6DETCyDMdzMZ8il8GcwZcHglTKCHJUr1bGaa1nNy
	So1707lPFWixkzktIb7+quL+AuQvc+n0/wdoVtJ5YbR6VTVrhsAiXPGeT+jSG/BD
	7LmGvMOh4VzwVOjKXwtifxs7V6EyrU/B2pAYWTSnjDBw+udssJHMnjgFjCtUkGE7
	N3ckxKxKCq0rcWZwsm5HaaQQL+eQuuUyM/IDoEASUU+o9ftiYlMHKb3V9KG9Qei0
	owybqnBgH4hGBLpKHLjhv2BM27m9f6quZiL1DqgfiVaQww==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abatd94hp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 10 Nov 2025 12:42:39 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4e884663b25so75344071cf.0
        for <stable@vger.kernel.org>; Mon, 10 Nov 2025 04:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762778559; x=1763383359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Szk5oQu0JKW4WvvkHevPC12l/Yr8odd2nrlXcJxADTI=;
        b=cVbC36I1a3rZ7LW9nbyBZ+OQZfHmiPf84+leq40dg0TfhZ5Ql4z84W9sKAloA1erac
         75JCETO+pIS3lsVFI1B4D/D6mBFDZRFJFMDJleoXrrfxUyCEKkUUzS3Abrlg+hGdeXmt
         j8jTQfbex1iSBxBSshykeSOMNPqDb4Xjz9Ds5JCYdPGNWy11byZP/18HAJXHKmdDRfvj
         vNZswcPofTZ96q5vGMej6AyK4s2KJpr4rQoiDY3e9DsoGshPfaK28v9mmpyanS9WCSY0
         EH0E4KN+SSGvCbPwaEtNhPBdDGzt+4aG/qdnIwT2nr24tA1mnHY8aTr1CtBCvJC8p69I
         1YBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762778559; x=1763383359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Szk5oQu0JKW4WvvkHevPC12l/Yr8odd2nrlXcJxADTI=;
        b=nAoJ1pmHtRNZbyPv5/pR2BkF0FoJylAb+ak+ldpZqUUmmZX6wDGWnysFebZb1/9MqG
         h3H2O9cRxzH7bwrHnP2b4X895Hp9aJOlgkFHE5M+DPSMtzBRCDJbRy2wzKOsW4gW/hIv
         69i/kDg+RuJLgnukkntF8qiL+u8tGAaheV0+iQEbX5W7uUYKDQX+R3vb+k1iRAIs29up
         UyyIVEEvYe8P1PiKQLyZj+aOXv2VvyJPAWXnM5euSXk1GgCdxBECwoGuv/DZ18BhYAp0
         MSXRXbazZWsB0JZAjwaEebLYKof9ZGXlLL40ysEUtsdHAVHCYzdqa7lWpZCmRNT52DEL
         rkNg==
X-Forwarded-Encrypted: i=1; AJvYcCVpqThDlOe3qJHnx4G0PridRigI2HPd8VPTrlhONoCqP9hzSpr/bnnA3Bb2zFqcaTlfmcELLUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpfKONllx2n3/2pTZOFiczmxXYBdEQxvj5oyYK/LxUh/yAmeie
	CHvL7iPHVsq+/7aSKpOqQklhka0z+4RTBlKqhPVsRZmH06g6f5IP0oyUa54UJSOnHQd/ilZ673c
	3V5LVSeuOZBsb/LQgn/RAazsLMPEdS/69TY16ZvUbIfJlUgzx0ydWEIv6dcs=
X-Gm-Gg: ASbGncuyw2CX8eZP28PcGLWoJdlkn9PChtD0+1j5IXebNEpXMolq+9FZgGLredJ6/wN
	hANF1eyoTnEAfSy5T3f9M1m0UL3xiU0a9ybmmSqcWYNa3HobJ54HD8rO0JVpMNffidsHMfW8sSB
	7a64d4f12fyuCQbiuR63qTv2A5wgbIk4v2wegOBCdwhjs0r8AJKLnWu6ubHqumtJQ6t8OyyuHLS
	L6RgMiveBRll5GnImc/eoHEd2bylNwabfzgfzZ7kYeJ2AdzH85fQFkEuqIa3n5H1tG9DaNaG1zi
	GdEUVttwl0j7gXIOSdzYk3CYrJmHllC0Ryq4GUyylTifo6C8IOOQrlQVfL0B0HW61NhEcQK5Vs6
	Q4+ZLb6B7OkCrey9l6Tydk6Mmhg/tjuhtR2tULyC6KgWxIaix2Inwb6sijT0nGjijf2O1dRfC7I
	VONfX3G+SQjDGS
X-Received: by 2002:ac8:598b:0:b0:4ec:f1a4:5511 with SMTP id d75a77b69052e-4eda4fc3b6amr92542161cf.65.1762778558877;
        Mon, 10 Nov 2025 04:42:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVDggml7PAVV7SI4AjXNrlbgrxoxEoX+ZodOTGQvFGPNu6EQkyCxkyyGJCj9juxzvgZ2KRjw==
X-Received: by 2002:ac8:598b:0:b0:4ec:f1a4:5511 with SMTP id d75a77b69052e-4eda4fc3b6amr92541681cf.65.1762778558271;
        Mon, 10 Nov 2025 04:42:38 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a5964c5sm3925508e87.101.2025.11.10.04.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 04:42:37 -0800 (PST)
Date: Mon, 10 Nov 2025 14:42:35 +0200
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
Message-ID: <vt77gtk5fjwd4z4g5ppuwa7552y27nydnniikz64khzgif4qbg@rbzu3alfbg6x>
References: <20251105-iris-seek-fix-v3-1-279debaba37a@oss.qualcomm.com>
 <2uvinljz3gevbusjrz3bzi3nicelv3t6a64gliv4mdv6cbllvp@fz3qbyukypho>
 <220c9fe4-00b4-3b42-0e80-8730a6388bde@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <220c9fe4-00b4-3b42-0e80-8730a6388bde@oss.qualcomm.com>
X-Proofpoint-GUID: ir72vD5Cy1lETj38e9vm2qYAxX0Y_Cfz
X-Authority-Analysis: v=2.4 cv=eZowvrEH c=1 sm=1 tr=0 ts=6911ddbf cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bl5V-8u5B6lULHSYCfAA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: ir72vD5Cy1lETj38e9vm2qYAxX0Y_Cfz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDExMSBTYWx0ZWRfX918vt7TWCATm
 KMiz4CpZ+aiUelISK5lMmHVhcZ30ly+36ht0ku/F61sIDddRcvTDOJqgLbw7DjRv7dN5yj03Fcr
 xbJMQ5pG9yuPoEi8uJSDrI5GrvgfKGomqnN2ZiwaGLO+7wD68D1vKjgOfLbE7mroHWubWAI5c4V
 97mk8WGeEBxOUnMWn/jy5C/uSRjrqbMehRHFr1fwPZOCM3rrNYbNRlzpTVNd+hSVa12igaOZVtG
 vZI92f7JHL/0THem9vl6frVG3ThDYUj2bDzTeT1rWPV1BxRmSqN6TZG7yDCATWihXalauhJ5877
 SF1M64xXf0/oz6a9Upq6PxUpRDnF96wf20WBLESWNc2+w8sec5s5+RA8o/GT1xFLWH093Dab3d6
 3qC+au7VFtHDgW6Xs6Hu99Qm9wos4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100111

On Mon, Nov 10, 2025 at 02:31:20PM +0530, Dikshita Agarwal wrote:
> 
> 
> On 11/10/2025 2:46 AM, Dmitry Baryshkov wrote:
> > On Wed, Nov 05, 2025 at 11:17:37AM +0530, Dikshita Agarwal wrote:
> >> Improve the condition used to determine when input internal buffers need
> >> to be reconfigured during streamon on the capture port. Previously, the
> >> check relied on the INPUT_PAUSE sub-state, which was also being set
> >> during seek operations. This led to input buffers being queued multiple
> >> times to the firmware, causing session errors due to duplicate buffer
> >> submissions.
> >>
> >> This change introduces a more accurate check using the FIRST_IPSC and
> >> DRC sub-states to ensure that input buffer reconfiguration is triggered
> >> only during resolution change scenarios, such as streamoff/on on the
> >> capture port. This avoids duplicate buffer queuing during seek
> >> operations.
> >>
> >> Fixes: c1f8b2cc72ec ("media: iris: handle streamoff/on from client in dynamic resolution change")
> >> Cc: stable@vger.kernel.org
> >> Reported-by: Val Packett <val@packett.cool>
> >> Closes: https://gitlab.freedesktop.org/gstreamer/gstreamer/-/issues/4700
> >> Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
> >> ---
> >> Changes in v3:
> >> - Fixed the compilation issue
> >> - Added stable@vger.kernel.org in Cc
> >> - Link to v2: https://lore.kernel.org/r/20251104-iris-seek-fix-v2-1-c9dace39b43d@oss.qualcomm.com
> >>
> >> Changes in v2:
> >> - Removed spurious space and addressed other comments (Nicolas)
> >> - Remove the unnecessary initializations (Self) 
> >> - Link to v1: https://lore.kernel.org/r/20251103-iris-seek-fix-v1-1-6db5f5e17722@oss.qualcomm.com
> >> ---
> >>  drivers/media/platform/qcom/iris/iris_common.c | 7 +++++--
> >>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/media/platform/qcom/iris/iris_common.c b/drivers/media/platform/qcom/iris/iris_common.c
> >> index 9fc663bdaf3fc989fe1273b4d4280a87f68de85d..7f1c7fe144f707accc2e3da65ce37cd6d9dfeaff 100644
> >> --- a/drivers/media/platform/qcom/iris/iris_common.c
> >> +++ b/drivers/media/platform/qcom/iris/iris_common.c
> >> @@ -91,12 +91,14 @@ int iris_process_streamon_input(struct iris_inst *inst)
> >>  int iris_process_streamon_output(struct iris_inst *inst)
> >>  {
> >>  	const struct iris_hfi_command_ops *hfi_ops = inst->core->hfi_ops;
> >> -	bool drain_active = false, drc_active = false;
> >>  	enum iris_inst_sub_state clear_sub_state = 0;
> >> +	bool drain_active, drc_active, first_ipsc;
> >>  	int ret = 0;
> >>  
> >>  	iris_scale_power(inst);
> >>  
> >> +	first_ipsc = inst->sub_state & IRIS_INST_SUB_FIRST_IPSC;
> >> +
> >>  	drain_active = inst->sub_state & IRIS_INST_SUB_DRAIN &&
> >>  		inst->sub_state & IRIS_INST_SUB_DRAIN_LAST;
> >>  
> >> @@ -108,7 +110,8 @@ int iris_process_streamon_output(struct iris_inst *inst)
> >>  	else if (drain_active)
> >>  		clear_sub_state = IRIS_INST_SUB_DRAIN | IRIS_INST_SUB_DRAIN_LAST;
> >>  
> >> -	if (inst->domain == DECODER && inst->sub_state & IRIS_INST_SUB_INPUT_PAUSE) {
> >> +	/* Input internal buffer reconfiguration required in case of resolution change */
> >> +	if (first_ipsc || drc_active) {
> >>  		ret = iris_alloc_and_queue_input_int_bufs(inst);
> >>  		if (ret)
> >>  			return ret;
> > 
> > I will repeat my (unanswered) question from v2:
> > 
> > After this line comes manual writing of STAGE and PIPE. Could you please
> > point out where is the driver updating the resolution in the firmware?
> > And if it does, why do we need to write STAGE and PIPE again?
> 
> Sorry for late reply,
> 
> During streamon on the output port, the driver sets the resolution in the
> firmware. However, during Dynamic Resolution Change (DRC), the resolution
> update originates from the firmware and is communicated to the driver. As a
> result, the driver does not proactively update the resolution in the
> firmware during DRC.
> 
> STAGE parameter depends on the resolution, the driver must update the
> firmware with the new STAGE value after a resolution change to ensure
> proper operation.
> 
> On the other hand, the PIPE value is independent of resolution. It is
> typically updated to 1 for interlaced content, which is identified during
> the sequence change. Currently, the Iris driver does not support interlaced
> content, so updating the PIPE value during DRC handling is redundant.
> However, this update is harmless and will be necessary once interlace
> support is added in the future.

Ack, thanks for the explanation.

-- 
With best wishes
Dmitry

