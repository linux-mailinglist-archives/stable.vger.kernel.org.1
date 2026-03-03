Return-Path: <stable+bounces-222819-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOQYO26apmnfRgAAu9opvQ
	(envelope-from <stable+bounces-222819-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:23:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 558111EABA9
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A00C330CE460
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 08:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630CD386C24;
	Tue,  3 Mar 2026 08:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A2GpSR/Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iVIDzOgI"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57226386C39
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 08:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772525980; cv=none; b=SuxMNBL24RycLe1R2oQ208EE28GN9jrTcvWnRVtwhPlREPNlwXfOzIYsihHyJGdowsYyjVZlRAZ8ExrTeccQSm2vpJjvJRsXkaxM/n6NFvoop3NTbxpOnKDTYh/ws3FkMEbKsOz6EohK20gbxmCBm7CeYvFCeQ4PNMg4TRwDuMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772525980; c=relaxed/simple;
	bh=3kTC24SI6aT+LaTYEQI2ode7SdCC6mqXZ2wYGz8MF20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rtol6Ig7Wzq4/qMwkxmHtP9Ss5FvN/Ga4MCmMnbpu2TnJS9JgWBFFOJ5QYInTZ3zhb5sT4x8cP++y2WRMQP4iYy70XH28KDYtbIsKwYmDm88I8UfFV2f3brb7+g6u7gjuJ85ILPYkvREm+7a+kJIDAzcXVU8NHx4SdKt2HckVlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A2GpSR/Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iVIDzOgI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6235Yk642996210
	for <stable@vger.kernel.org>; Tue, 3 Mar 2026 08:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4N213Yy/tErC/qPxFB4Ckztq
	tBqutFx9DF1gTLrNKsE=; b=A2GpSR/YSU35p94ku9bB8xdmQIUe8J9wM74m1FoJ
	Ab8sgMbTptb3ppeypULLoSNUO+hqRKRH9/5XfpTbcSp8FfTvAZCONmN82DXRt9Vc
	LZrmJPmF+cBXeXl9GOQNz3N0GztUcvmv40l3vzajboP4X9L7CRxRiIlhqymXS8Lm
	iIgZAi65R4c8ayKRhNz4B10ZB4cC8kBzncxjbT9n21STliZ0ORmPVxYcWbQhmBAK
	WdB8rjk+f5mwzEcEDk9Gefyu8lRqLrRHm0vShUWUPnnKoS4/aRdq5e29XbNo82ML
	aJ02rY9h4XiShDY+N7xJlFqV04qoYEGMqMJ7rC5gKRw37Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnh6ua3ns-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Mar 2026 08:19:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c70ab7f67fso6162465585a.3
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 00:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772525973; x=1773130773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4N213Yy/tErC/qPxFB4CkztqtBqutFx9DF1gTLrNKsE=;
        b=iVIDzOgI9x2VTPlZbZircit0VSXJ/CKaQrxa3ZmTYgqE5jwBFsFXnD8L8WECAHDs5g
         7i8xItu8+tKcL0o/UkHw6F89XDT2qOWNQr1elO9x7aYG/15dsKeDe+3hWWhFQWvptF4d
         aPPQYcfftspbTcqqoq+zE8IoSWROar7t0I55zaRUGQLqrbrX7EIev1Ea2HSnh7bjNst+
         8Cs3t+c9bsHyzwhwWMpqLFRgmM3cJsmUXyEDixt191eeC9SZ3ptGvh+lO3yIiAGB840E
         5x+mYrNe33JcyXVXIf2s9V+leu7UXEFpHc3BfeZm2twUMT1AhxbLzExtUJqpr+DNddBO
         E+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772525973; x=1773130773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4N213Yy/tErC/qPxFB4CkztqtBqutFx9DF1gTLrNKsE=;
        b=eoa5T9aO+L4WeXX65W6Qz8mL1lkdLuYKeq+xt3MraGR2F8pKtoWPK0dNE/S0C5QxTE
         odabo+j6tq6g3sfUlE92AsvlKhuaAyxgBArM2Uvr2TKk6QrPKIrTiTh6D1CyIfXNfyOL
         gfsZX2yAZjO9i9IxfNFihF3MvF4MycXzEu1KP7/Ig/bowvPrqDvDSlIXnKyIVIIxrDp7
         Ri2mjZYfrl8e0LGdi22TnkLk4XrlMVwvBkaCf0KdVAp93TQeEYJUtCE7isDkwmT1mlAv
         kBpT8huw21F2OKOF0vxQefWWnZBcp/vyRSkXHx0b8RL3ArSaWy2ulCjD9KHwXKlTjhkP
         XLBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE/x7CHiZ3VI9zBSvClm262lklvyGoKPY2gwp2dOqJYZZkcQ9NTe2kWmL4Dlm+m64Gn+FsdTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcA9+fUK7d2OgkF6T9+S6pqqdyEwvOsPdwCX3Uakf436GV4dtt
	wXq91aisZLGwnz8pS+TwuHR6wyN4U0hkrkv0qMA0z8x4FBVrOtsNt/u1pLbPOqGxOUga83VhDTV
	otMCfqmUQqfnY3GxQMK0dUs0zdsP2GDKEzqHnDkSKi4U3cdsqhlrJ6w6eJbc=
X-Gm-Gg: ATEYQzwhM2zaobSZkRLTqOgtfKtwi4xAY04foXt9dVvtw/F/prNN3YdiC+RLnHcG3AM
	Q6yaA8HgG3W00s54kaSqf9yzLEfmWZlEYxoGIhgmVE2md1rIRSXbZ00Oi9mv0IcR6rTCsztu56O
	1BXfUB7DWakn/q/3bu/S2IDaYpCmL3XZ9v3O8nqW+dA7umYVseJJXSu01dyq5ALu0VRV/R9B5Dk
	MPdQ9vtAkvKXoaZ7fo5MO7phim4QJqe4wRrlfDQ5gw1wdc4fH4UajRHjgZOoouIA4erVrIVljcA
	tk5+Gj3WMsVeIv8QwBnElJvOsg5rnF5MPUxo6ZbWW2VAoLyddKNiP4C1TELw0pZLoFUutMfQ8Gv
	xm4N7wGSjGWdM3P5zo7qQaTWEzqYoD0AdiHzU
X-Received: by 2002:a05:620a:4004:b0:8cb:7ad9:65a9 with SMTP id af79cd13be357-8cbc8e79948mr1962844085a.59.1772525973139;
        Tue, 03 Mar 2026 00:19:33 -0800 (PST)
X-Received: by 2002:a05:620a:4004:b0:8cb:7ad9:65a9 with SMTP id af79cd13be357-8cbc8e79948mr1962840785a.59.1772525972438;
        Tue, 03 Mar 2026 00:19:32 -0800 (PST)
Received: from oss.qualcomm.com ([86.121.162.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd70e692sm486645545e9.7.2026.03.03.00.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 00:19:31 -0800 (PST)
Date: Tue, 3 Mar 2026 10:19:29 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: display: msm: Fix reg ranges for DP
 example node
Message-ID: <tzzwpymjwwqem7zph7ecjvwsfhmylvgvgel7jpr7zrfcdaevzi@aggighjasjac>
References: <20260302-glymur-fix-dp-bindings-reg-clocks-v3-0-8fe49ac1f556@oss.qualcomm.com>
 <20260302-glymur-fix-dp-bindings-reg-clocks-v3-2-8fe49ac1f556@oss.qualcomm.com>
 <20260303-resilient-bouncy-anteater-b4cf0f@quoll>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-resilient-bouncy-anteater-b4cf0f@quoll>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA1OSBTYWx0ZWRfX/r+Ze8hqMGj0
 e4RSCJPyx00gDZyb7MXxvWNiKmsPLKXigW+0laVvQ8sy+o/+R9Q6qUYRFTlQRr0RYDHWJVkrJ83
 VeWbqGczU/8zbPAxE2yFmiEz/gB0uiF6Mgbh8CfJJ+P6I4J/9oUrJlWum2n94MFZC0uWR4E0x6w
 rTqDaBK/mS063anzz13q5+oH5odjG2kmimy2i1gTytZnWEIy/Ocnj+OPeK6owXBmleLsolN5R6C
 u3rTNJQmIYe94fR5w3WOBhKs/jmfNZUK/pjzymDyUr7PP/MzSd0mvA4bPEV4VLWwF0YEb8FoEav
 JoLCwgqWs0aXl/tflF7SKFuXCdwX2/NUTmfZl++0obbKKBXISFFoRKcIor2VXxPEOKDkOVuRUKm
 ZJ48U/v7Piv32EcZbM/7n9PCsyYaRO2/zMFeQwut/XtxJY7rOlhmTablqnbjhbFwieHF2qwFH1U
 eKNmxK4i3cw05SapXgA==
X-Authority-Analysis: v=2.4 cv=MuhfKmae c=1 sm=1 tr=0 ts=69a69996 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=oauzzCmhM186DRC0Y2yWPg==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=hwl0D8rbNs11RpkTeDcA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: -_2WgtTNZBYpPPD7vjKsWnBh-V5NOyHm
X-Proofpoint-GUID: -_2WgtTNZBYpPPD7vjKsWnBh-V5NOyHm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030059
X-Rspamd-Queue-Id: 558111EABA9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222819-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,linux.dev,gmail.com,poorly.run,somainline.org,linux.intel.com,suse.de,ffwll.ch,quicinc.com,vger.kernel.org,lists.freedesktop.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 26-03-03 07:31:50, Krzysztof Kozlowski wrote:
> On Mon, Mar 02, 2026 at 11:58:36AM +0200, Abel Vesa wrote:
> > Add the missing p2, p3, mst2link and mst3link register blocks to the DP
> > example node. This is now necessary since the DP schema has been fixed.
> > 
> > While at it, use actual addresses from the first controller instead of
> 
> As pointed out by bot, this must stay bisectable, thus should be
> squashed. You can keep two Fixes tags, if both are applicable.

Will do exactly that.

Thanks for reviewing!

