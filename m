Return-Path: <stable+bounces-212828-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPqWIy4ZfGlgKgIAu9opvQ
	(envelope-from <stable+bounces-212828-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 03:36:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C008B67F5
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 03:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D79C301A7CB
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 02:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6E53314BF;
	Fri, 30 Jan 2026 02:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X1yv4IdO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AMuiNigR"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EEA332EC1
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 02:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769740581; cv=none; b=S91ms/2JyVoHIDmmYSBnvoIWXla8up1RASNeWORleoIpPO/pq7epVwZGis1fr5wnwEeebI1ka18yIrExER/Aq+Zw3VqXPJW8K5KXLl70rPZVgoQAfRN6sn/qKp00pCrePX5dRj5HGx1Tbxhao4EHooIBuhMDnS58Kv0Spi+ldnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769740581; c=relaxed/simple;
	bh=sNxkkwg8e+L3ZfLAzXjjQsC3Ixos8TiaadGrkPPZBuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oI4tCAq2W0THbhIpfMlYFgbfwfSqxeai3zn3bhUIxSZt6DACSav9Fi2x08Ca41Eh/BEgQfasKu5XPEhN+HCMZb1/8C4RiTvwPFmgo4kZyMgAMyD3gbCnARWf3a7SiBxR+jo4TdymtxEaLkGz4xnsH/qdR1J9iV4vgkg0h8xs6j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X1yv4IdO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AMuiNigR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TH3XcB027582
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 02:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0awdT6874YGtHlqtAyniXTK9
	kMRgr3FTTfRaGKb2iHQ=; b=X1yv4IdOyKB6PET67d45m3p9Yb0f9qcHDyx5XP8A
	5xWePmsQ44fIKbvBqgHHl9zUpy2MFiFthrC2IfcpFQfvLXkAT0QAodAC/IHitTNL
	wOOZ2BGXcWklP7BmG/f4IYb0hpW8pxLyWzb21hCrEXTScir1KsBwjtiGrcJhctri
	kZIra5UEPLd3jITsuwFBw4uv45O9aC8g9cqPVHl/rY+5RrV+D0UP3CupHAM9Tlp3
	XfaciA0EmC7vBgvTHZf6WgIqL78L5I/qbJZ9TFEWeCj4K66yS4r1gU4o+ezYlZUM
	t4JUuczbfDoYTzkxd7m/69mthmDXyweEJ9uBeEScEGAByg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0bm59g1p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 30 Jan 2026 02:36:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6a291e7faso677676185a.3
        for <stable@vger.kernel.org>; Thu, 29 Jan 2026 18:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769740578; x=1770345378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0awdT6874YGtHlqtAyniXTK9kMRgr3FTTfRaGKb2iHQ=;
        b=AMuiNigRyLAwyaBon8wwvD0+iB/6aEtv/7NwNMVvw8Nz2bu4sfbsV609m2M4fJEKGw
         BySNlNdgHdeCKx48P+GUq8QPdGCDDq6QdXpci4NkW86BpvIwfQMcP7R8/290Vip1uyyw
         /Cim9v4PL8T4y36zoWCPqLk0HY1MsOur610d0shhHFjhnkAO8W/KeSPO55rlPBDi9HTX
         cmDMgPXyVMRbKkx+1XpcT/BVXfunq4BWQpjtlL6I2tE/0qxkjFWW1HHzEe3ZTgiNdHvT
         IBwdQCUsbNmfp+z1wrn4pSITDeU/fHrRlhcYCg5zPig3m9nW9WEVa9LS2tQk5Oot6Szc
         J51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769740578; x=1770345378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0awdT6874YGtHlqtAyniXTK9kMRgr3FTTfRaGKb2iHQ=;
        b=bKhSvyhbv1+YKecdT/Fbdg4/LKN1KHgjCnKWJhUn/0R5Lpb1dxceY88iXjib5XDAf2
         Q29yxOhLms406pLBcgKe/yykk68Wm9QeSBeH12PTf/ZEwGuWswz7Valas9tH4imAXO+b
         YqYQhIRs7AScoYmaQ6XkhCg5pmFm/3U1Zmkdp8tuAACqDYxE0W76EIACpOZne4ZVxgq5
         TQBDYN93d0JuLfSQjo8lgmqgHiuJmemwpfXNew2OkQTv2yZC+ueexdLBSTiSYFv79qYV
         ZLHD4o4+mVIfmStWH92frbRmJazNLZEk8YQ99eTmwmqxLohyotn9bVAsACubBlaso8Hu
         VPRw==
X-Forwarded-Encrypted: i=1; AJvYcCXOqIpiV6hmXsEb69XNaSYlW0aNxZQgwPHfhpbxFo25hV3mg/N+U3gXgRP+fQeC1xeF6LCsAs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxolrZFBWdkfwGbuKNj0Jlge8L8zT5+yw15qW0N1Dg779Wc1UgW
	oudocGsQBCRdUJBJi+0HLgOxuS8xM96rAO/vo274g5bvl3rd0t2aScTta88OyYG7gPU6EIBqMND
	Epd1SD/T/HN9DLQNh5LUe+XSK4wZOUFpnMyVuXz856jea6P5/CcHgVWaZ+KKkShAFo1Y=
X-Gm-Gg: AZuq6aKm6fhW6fUJr7GEBau/w/FKsUEjL5HVz1b/qamQRB8hF1epEGDJIFAt3KJwFae
	IXO6RSHt7I81PFNY6uPRajkrraZUqAph7Wie2qL/1msKS0Ui10MncKFdAq16tTQSLa2MFdQktcG
	EMDEtV3wL/CtBipOxfHVu4aN1h6+6uwT7GFCGrcQDKMhdcIp8svU85GiqqJIvNWSh97ciKN8y8d
	+DouIkhJG+bFolhdgBUFxgZGLg7UP0k8QGKUkZDYCTXmW/bLBtSUlf+phQIjdlhk64/PMB6PnI3
	p/FnZpwtix1sn1R15nHX8xpllRb1IpVI+fiPcucm2AgPOwt73NLCN0kQnCzjLWRDj/Si6ssUGIe
	0gBCKa0jeBM66fsILSx9bLTX0OtXwB3r41JoK6n1oazoNpwY2KQC7RrmMBoPrc286eeJJMMZ7Rk
	TjLIl4Krv17RNxPXzeQAsm7Z4=
X-Received: by 2002:a05:620a:254e:b0:8c6:a034:9226 with SMTP id af79cd13be357-8c9eb34e749mr228383585a.82.1769740577645;
        Thu, 29 Jan 2026 18:36:17 -0800 (PST)
X-Received: by 2002:a05:620a:254e:b0:8c6:a034:9226 with SMTP id af79cd13be357-8c9eb34e749mr228381185a.82.1769740577160;
        Thu, 29 Jan 2026 18:36:17 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38625c61882sm11991331fa.12.2026.01.29.18.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 18:36:16 -0800 (PST)
Date: Fri, 30 Jan 2026 04:36:14 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xingjing Deng <micro6947@gmail.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xingjing Deng <xjdeng@buaa.edu.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v5] misc: fastrpc: possible double-free of
 cctx->remote_heap
Message-ID: <72tlx2t6n46k53of4xxhihbfsce6qd4x35iwaavuspc5ma47rz@qs3bzn4bartf>
References: <20260129234140.410983-1-xjdeng@buaa.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129234140.410983-1-xjdeng@buaa.edu.cn>
X-Proofpoint-ORIG-GUID: y_ShgRiVXx8m1trNj4YK7wANhOAVFl2V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDAxOCBTYWx0ZWRfXxxQP1OM9ZVdl
 LGlPo8kZHRqgcPXefQCFFYadFA5J0DSM4q3eoLQbTBIdfKPFZNT+KwGdLmRZjkLnjx/FIo4DfY6
 qp/mD6HoL+GDhyj+bfDSfAI+JIc2r3vlqHSJc5eF0znKg+lxp04iZvn6r5/nk5zEPWxnxxGYzSJ
 6tpTcWPobF86YhSaRLmNiHEbzXa4QbRyObGmmUipRZqx/uWvowNrxl/TVhhFfNEhq/JvFOSObgV
 uT261KbpCeC4+bmdesf4IaVhSDjnCpV+U7BicUQdfSUOK48Z43/ISvhyGRAMYLl4BjxuMjvTkAT
 PC7ReeUdaAkiDGmwCYdxtYXnhMvrbTe9/V6Soik6HG5MSBb75yCjBhrjYXMnX9gJD+qFHC/NHuU
 yyZD/pfLiuHDa21CisjFPlFIuFND6IZ02vAMpzKXgew6tAEwpjiQUbRvQ02li5lv05ZOeeGdG79
 4A5HClpdOTkVsWgWq2g==
X-Proofpoint-GUID: y_ShgRiVXx8m1trNj4YK7wANhOAVFl2V
X-Authority-Analysis: v=2.4 cv=bZNmkePB c=1 sm=1 tr=0 ts=697c1923 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=W5TWiRnh0Z6joxywpxMA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300018
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212828-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0C008B67F5
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 07:41:40AM +0800, Xingjing Deng wrote:
> fastrpc_init_create_static_process() may free cctx->remote_heap on the
> err_map path but does not clear the pointer. Later, fastrpc_rpmsg_remove()
> frees cctx->remote_heap again if it is non-NULL, which can lead to a
> double-free if the INIT_CREATE_STATIC ioctl hits the error path and the rpmsg
> device is subsequently removed/unbound.
> Clear cctx->remote_heap after freeing it in the error path to prevent the
> later cleanup from freeing it again.
> 
> This issue was found by an in-house analysis workflow that extracts AST-based
> information and runs static checks, with LLM assistance for triage, and was
> confirmed by manual code review.
> No hardware testing was performed.
> 
> Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
> Cc: stable@vger.kernel.org # 6.2+
> Signed-off-by: Xingjing Deng <xjdeng@buaa.edu.cn>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

