Return-Path: <stable+bounces-182872-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F81FBAE6A0
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 21:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C54D174CB1
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 19:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFAE2848A7;
	Tue, 30 Sep 2025 19:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lN1CLLIy"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107311CA84
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 19:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759259653; cv=none; b=s88sLMVYQlp8Kg7xXJcLwM/B+95PYUa8MHO8LMYz5do0g0XGP3l6N3g3cMTCcM7A5NxQ8ZWh6chl8aQApSA65cMpc/chdVohex0nzxjI2AvW3t1ou/VylC3XAAb/Kift/2PUBQ3TDUfnulN0DhAbvq8BdKrLXWvvD2DEbwBUUXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759259653; c=relaxed/simple;
	bh=PawSnYt8WmMj8SZdGcAwqC+TWH/Zc85+nywQIoFiozQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljJz6oR0zrotiEOI6a6dZwC6fDSSeZrP9ZDZrLr1dqX/w0RybaIhK+d7eDfXuegC1YIRMlEQkeOJ7R6gBOgyfKYG2c5xagh5AsBFUqtQ2OeFPvwkOFqUJFuFlribI7sQqVhdwoOmnLXGqbKQjFPYmuGBEulNMJukSIm6wKuJgOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lN1CLLIy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UBQh0H015470
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 19:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=goYALe8rxnHCGdz+Re2W+Iqv
	KOXN11Rt4Lm5Gbd0TUY=; b=lN1CLLIyEBzJH2h//vLM/tnqcyL/ZTqyB8jJGtz+
	nKuSzGK8gPGsen3+t8npQOsros3KwkhLFekmnHgCT94weutkC3wlwz8Rn5zucHFK
	tvALcGzJ/YeuVG+8J5C6j7KttZb8iDMf06eW766+vFsSno5mL7z2cfOCCSrRK8gX
	uba+ufvKMHQbvb6elYfGG5vnRijU+GLrdzhuzKh1qmZf7ueCGTwNpBjR12UI0h9U
	Le9jNSfn2tInM6VTQ8o8w8vUenQwzfH8CW1dGOXIHSHiANiK6NDqBzmpgmTzl5IU
	lOu2lfdFfVFfQPlhJAC0gS3AJt1lXxJ7Jn9b/iFM/RsNfA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e6vr26n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 19:14:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4dec9293c62so100144441cf.1
        for <stable@vger.kernel.org>; Tue, 30 Sep 2025 12:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759259649; x=1759864449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goYALe8rxnHCGdz+Re2W+IqvKOXN11Rt4Lm5Gbd0TUY=;
        b=pCBXI07edVqHVg67nRm28YnnDQxI8mLq0Cz4eA1xvLnyGJHaRzLGzZciS6ngKySdoF
         0dyiHN1xR8BwuN3FWZtYM9CjuzWDDvHq9zcXiQoFRu4jnw8QZYn+fd/4j0loHjqRqEvq
         exLxS8o7i49W9X6oE/ncM+8Xmn3ubmhZ66w3ssiZM2mUjtln0ufY/0KsJrfATm/ciLM6
         PbnZquE08E8Fg8Xqzbqbt1ZPeMCIBBDCEzFWyd3ELp1IFte/BONDma7zSLDLT40hoBnd
         1aMDn1ldy/AegMGsPw2+e7x6soIjZ3PKRlNrZtfPORpX08EvNDOT6CiBoBLNip1wOTOA
         gGqg==
X-Forwarded-Encrypted: i=1; AJvYcCVIuSI9w2Yr/tpYHLcXdPiP/2JRxz18wD8lUbU59M6nIqUlMmUbhmg5cz6CXRcVNQxDvTSQWt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVkV8I4fsgVaCPoeRm/aSe2mE0oCeNSwjs+9todtGLL3dIS0Nb
	MF77OqVYuq/2080/yMS9kX31GEuAHPYBa80LrZqzNShbvonf0yg6hGakFYYsOHhAoTyLR/af4Iw
	9DJdtco1Fk6suj+wZrsFW15HnVSM2Enh0eTs1iKTZ6F1JjqEyOLMKWhWzzs8=
X-Gm-Gg: ASbGncuLF7jXUsWqBNxR8OAYCG07nhqxaVWDZCh93xCNdIsFqolGLVkaOHcRRQzKHTD
	SI/LimDpXghlREyjxBNIf8mVvKUuxoGX446AUPwfe+v/gL69txdKZsogJOanZTPeb3kTv4+doBW
	EaSYmwr2xhb0i4VBxicaCwGOW43KUeQKMYYaT5/iUxMIR1DWnPuvZVFPuRmF0EVpc5jsiGoj8LT
	n/AqdMs1aJGErhFd9XIzEIzgjie8MGAznmVNRS4YZb05ij15u7DUrQyNzPKw4ks+vJMEmlX6kaB
	yHHLt3DzulmBRc2Vu/LnMwKOSFev+4bpMoRc6UnQng/xGguSQ6wjM8d74Xbb+22rfMfM1QITDzv
	53Itk8LchiieHAyvQ/zjB2HBvdWhz6MTItWco5iMfTuHm5f4F6JFXD/J99w==
X-Received: by 2002:a05:622a:5a09:b0:4b7:9171:7b10 with SMTP id d75a77b69052e-4e41eef7075mr9963061cf.64.1759259648957;
        Tue, 30 Sep 2025 12:14:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWaNA0ZDNYeL9wcUtcyeSgm1Kjom+qbg+3Fbj0RuE8VjgW7lsTtOWKRJ0PJ7Wa9FP7+7IEvQ==
X-Received: by 2002:a05:622a:5a09:b0:4b7:9171:7b10 with SMTP id d75a77b69052e-4e41eef7075mr9962581cf.64.1759259648498;
        Tue, 30 Sep 2025 12:14:08 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5879e9b81d7sm2043093e87.128.2025.09.30.12.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 12:14:07 -0700 (PDT)
Date: Tue, 30 Sep 2025 22:14:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: qcom: Fix SM_VIDEOCC_6350 dependencies
Message-ID: <manv5cazdhashfkduondlikqn4ut6q53dhjhyepu34tszrdsfx@bmnjqsrtcf6n>
References: <20250930-clk-qcom-kconfig-fixes-arm-v1-0-15ae1ae9ec9f@kernel.org>
 <20250930-clk-qcom-kconfig-fixes-arm-v1-1-15ae1ae9ec9f@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930-clk-qcom-kconfig-fixes-arm-v1-1-15ae1ae9ec9f@kernel.org>
X-Proofpoint-GUID: Obiv-EnWE9Tumsc5SAmnxcwZ--KerR3a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAxNyBTYWx0ZWRfX63ygPi+o2Suk
 JC1F86E3LtKqgBOSkAuMuY21p1ls62cqalnOHkuflfuzlV1DeLdaDVO14D5Ew9dw7cYXNrAZ7VD
 4aO7YiPDgvU5kMY9KpEuD9oI6g3WfNaJrAZmXWgVqZid9/WhoqMZG4cn1P6aHGT5nh3HLV1EJTu
 aSg/HWhw7ZdaaJDoKAmdJKhcrvuxzNhc7LDK04jKaXq7V3x/7M0NOnk+xG/mepuNMWniSJVWho6
 wyJzj9lLeH5EIXPSbvgV99HWjsCNpvuLl18CWvyepffxf/brEtp+qoLbC73aJ02r1/VNVSjINR6
 TJ5oehK28tpkqQxNtCw6NcSknqN08pzyDKECXmvI8sTQu8Jx+2xTAz1GB2PB3qKtIzwpT6O2hpF
 kbXgIBTdJmRRfIvCVtFz2fFOZvOL6A==
X-Authority-Analysis: v=2.4 cv=IeiKmGqa c=1 sm=1 tr=0 ts=68dc2c02 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=YvO9g5Z2dZ-zDM10cScA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: Obiv-EnWE9Tumsc5SAmnxcwZ--KerR3a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270017

On Tue, Sep 30, 2025 at 11:56:08AM -0700, Nathan Chancellor wrote:
> It is possible to select CONFIG_SM_GCC_6350 when targeting ARCH=arm,
> causing a Kconfig warning when selecting CONFIG_SM_GCC_6350 without
> its dependencies, CONFIG_ARM64 or CONFIG_COMPILE_TEST.
> 
>   WARNING: unmet direct dependencies detected for SM_GCC_6350
>     Depends on [n]: COMMON_CLK [=y] && COMMON_CLK_QCOM [=m] && (ARM64 || COMPILE_TEST [=n])
>     Selected by [m]:
>     - SM_VIDEOCC_6350 [=m] && COMMON_CLK [=y] && COMMON_CLK_QCOM [=m]
> 
> Add the same dependency to clear up the warning.
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

