Return-Path: <stable+bounces-230784-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ah7JH3Kx2kLcgUAu9opvQ
	(envelope-from <stable+bounces-230784-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 13:33:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 233AC34E6A1
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 13:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA2AB302A532
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 12:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C55E37F729;
	Sat, 28 Mar 2026 12:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UjEH4Skf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PFZN2VSq"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3394D377ED2
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774701175; cv=none; b=bNXHyCavaaVh8m9bGQNpkCJFrKE6QwPiLWzloKaQsdtOtDEqocTMLxF/M58placUSdHdPiD2lZTqCVV0HDWRBQG+/eGUsC4x6A0CvTAVKYiHm+Ok97m2JMh1jWX+cJwkPd/9+Y0u7xB9GJ6Zfyn9r+ZtP+PHXJqobABAWqcaIW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774701175; c=relaxed/simple;
	bh=giZMbyB4TBmhjwN3fuaqoO9FFQ80IGzzaQKVLzkAGjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RH/Kvs12GSHI1+fuNpzlIoKBd07aH+mYQ9WpAdqRUroU1C607mcAkDV89rHwKnn13lfFQ6VuYqE7w68oIyW/B193HA9nmNbfwOjOvfmi6ygxzA0q/Q05N5+8P2A7VfuzDhd/CJe1jQkbGsrkWpBiwa5Ypm+QW7kOBEeSdNdRNuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UjEH4Skf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PFZN2VSq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62S3YlAr348677
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 12:32:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zLIE82aKADzB228U1GH9uwyA
	RHJTAmhtB/2IjfL5YW8=; b=UjEH4Skf9ZaoMJjdK+YZFva0Mr5jcaf3VeBd1hXG
	a1W4SjwioaxztUoW7FwkuGikzEBlBsj0UtlTdbZygeX5s8CS23qAPiCSbCvj5TdN
	xA2X7P4p4ObEb9z9iCTxECDcQri1+8I+uCwaJGKN+Zm4f2NwyfX2fNbLeFnTbLhh
	Ik6RZHJ7QlbH87IfsBliEUDsVKtyDyVL2i5QRet3XeQHzkxf1eYmOWDlD6vVtgOq
	xHBzmDEP0gQ80znQQh53b8XI+yU2wtqYK8kPHOQMONOzkJs6plC3GtM0hYJvAns0
	xYr8jJAvK7EhHn766szgP+fZTd55cfPoViPECHXZEgeDuw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d67710sjp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 12:32:53 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b802961ecso40282881cf.1
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 05:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774701172; x=1775305972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zLIE82aKADzB228U1GH9uwyARHJTAmhtB/2IjfL5YW8=;
        b=PFZN2VSq4BH2V8oVn7SO0Z1y3RL1IWtBzbWqLj0i6Tf0yOx8Trw6AD7TKswRcS8WqW
         Vtcxg5SySRtNKXq6LfdmLMAMk5V6kU2ZeXdDb8N6s7xu8EuDgcYCsix6VCE0vVJodBbI
         HNk9Z2JrTZ+tYjoMcTy4IQpfJVgV+SzXWB13aEQjcQOZgLtAC+oF9VbzXWt/VSx8ibfr
         Sxd91DntpIcl2PFiXHCQmdrR99z8h4chtLXz9iys9uAkgJuWhAaZPLOpwu5xAukPVzK/
         ETk3Wl/z/4BRc76VgX2Cs29AAlJwM3o6J1haXsxLwv75Zlk7pNdJ7HAb6kLM4QMZzWY/
         8+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774701172; x=1775305972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLIE82aKADzB228U1GH9uwyARHJTAmhtB/2IjfL5YW8=;
        b=eBrUCTANCx9IBdgJ43gaWdZHJEdUmAiWdusNo8I0AD/isrvoeImqGKPTdipw+H4FTI
         6LzoevQJeH7XiyFFf4RgNFIzmOh5SZANOgRQWtiWZN2s6dawnN3tAqNN4/BJghnTfVPb
         EZ6DzlaIldtQ3br2LCAUUk8VFDETDk/4XaTW2ov3nIgWaNXkSbMEN8oVKKdDfJPHl4Jk
         06HjTufeoiw8QK9u1+EzeV5AjecQ1wT/Dox9lROh3/bE2n3w9RiwXa67TDxUbb4Fb0Vq
         +21/cjzPlqjk41k1KNDx1cp9Y/K3R9cB8xroQInRMz5cQTi/dRykyQfqSzkaiAPTUI7s
         Nuxw==
X-Forwarded-Encrypted: i=1; AJvYcCVMXCGZvz6p6axOtEytzi4t7Zj6v+MaP7WioOJPTk/T9ySVEJhJyW6IMwSdTDzg5Vpj50f49Uk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx41sWbjTvosQJSYvpFijJuBwg3e7MPYgIbSTR2yXBRlF3pYTBY
	J7baCcPJn6fRZOXcRbwLEHcY/f1gYkESopCtS4kM5Jc3wspIvRA4DaOAzyYrUkVR/KWzAIZnhWg
	AZZ+zgHL6eunHhF+u1BnXIZkYQpQMimHCDCM85n9UESC7S4yCUI49C2siXRx/LH3mGcw=
X-Gm-Gg: ATEYQzy8RFBhW0PllJogvfP/5N9B4relEn6cqjSPm1wf/hXzAESNxG1tO4Baxti4YI+
	6EDi3pUunMVSeVDu2eSnMh0lSTOn2ZcKec+XifU7Tobsy4BRKh/3KOX6GLgpvp44hyMvgu2Rt+8
	nOcQkYUgUHqKAI/3vdWWnYzGuOGWNFvHfkv5k2QKicBT1DDND5YOXGbnMSBEbWaLxIN8AK2ejM0
	N7Y9k7m/N6qZo156nV1oU1rgfw8uMXfICrSlmcoC9XKqbYyp2HpUYO6pZkKLszg1EvEGxoezvIe
	ToGXFlxV1ZrOmZg8dB+3oxnrinHSf5NUCvhT1ezE8Inq6oh3PuDJ79tdaVcLXYmcdljiYpP0NhW
	MJFAgz6342nEGZAKvj4akOak+lo2IJhSozCIg
X-Received: by 2002:a05:622a:283:b0:50b:3f50:178 with SMTP id d75a77b69052e-50ba380ba43mr79328941cf.14.1774701171762;
        Sat, 28 Mar 2026 05:32:51 -0700 (PDT)
X-Received: by 2002:a05:622a:283:b0:50b:3f50:178 with SMTP id d75a77b69052e-50ba380ba43mr79328361cf.14.1774701171143;
        Sat, 28 Mar 2026 05:32:51 -0700 (PDT)
Received: from oss.qualcomm.com ([84.232.191.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e265fsm5125925f8f.1.2026.03.28.05.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 05:32:50 -0700 (PDT)
Date: Sat, 28 Mar 2026 14:32:48 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] pinctrl: qcom: eliza: Fix interrupt target bit
Message-ID: <gjld42tywuc7ggxzslcobwwxjr5uiwgukj5tj54ipavhpi65ny@easgpb7t7wli>
References: <20260327171240.3222755-1-mukesh.ojha@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327171240.3222755-1-mukesh.ojha@oss.qualcomm.com>
X-Proofpoint-GUID: 9D71CUp3QX7lZGQ9fjaPZQ6eFohNXFzg
X-Authority-Analysis: v=2.4 cv=efYwvrEH c=1 sm=1 tr=0 ts=69c7ca75 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=1UCgTMz9MQc3icybWezSFQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Z7K5_F5WLHyQu2uRg4YA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 9D71CUp3QX7lZGQ9fjaPZQ6eFohNXFzg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI4MDA5MCBTYWx0ZWRfXwY1oEDDRX+28
 mATmitV7KrMOIcJ2y14EzWzevHbDIjRKGlNe3l0GUuOmTQ858N+/aT6gBBCN1Pzx2SV5qVZ5TXi
 F2nEP42+YYOzH1tycBls8bTJUkfVtrk/UaJ7VxIyoeF50cTfxhwIsTspC2QwoGhtdLaH5VLwymC
 ccvIFDXCcPkF0USyWIkfIilg6dUzPzqi+Lbyd4X2q+PO3DCO4Bl1cEgi9onYaD9lK7lJpLURJW9
 ZeVHDSq841sk4WfbEn9Ye3KKLmGVVjgy+y6KTC7SkBEOmv6zVoUIXwaI1FNlPM6KkzwB6PJzuh/
 WUdRsmIIM5gNjk6+50sKD4MddF2iS4/r5y2YyNf7zQj6JpUGykvkLVWXcXHes0dXIdAWeb5yuGm
 WE45k8wvzeYBy5LEPUve7u/gZIfNXrZCWZT6bDV8q2xdWqlJ76+bXMgRb32id3zrPtQog8QkEXD
 YNuNf4KrZzDfVrwyMbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_02,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603280090
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230784-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 233AC34E6A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-03-27 22:42:39, Mukesh Ojha wrote:
> The intr_target_bit for Eliza was incorrectly set to 5, which is the
> value used by older Qualcomm SoCs (e.g. SM8250, MSM8996, X1E80100).
> Newer SoCs such as SM8650, SM8750, Milos, and Kaanapali all use
> bit 8 for the interrupt target field in the TLMM interrupt configuration
> register.
> 
> Eliza belongs to the newer generation and should use bit 8 to correctly
> route interrupts to the KPSS (Applications Processor). Using the wrong
> bit position means the interrupt target routing is silently misconfigured,
> which can result in GPIO interrupts not being delivered to the expected
> processor.
> 
> Fix this by aligning Eliza with the correct value used by its peer SoCs.
> 
> Fixes: 6f26989e15fb ("pinctrl: qcom: Add Eliza pinctrl driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

Thanks for fixing this.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

