Return-Path: <stable+bounces-144889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 292B9ABC5DA
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 19:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A3493AE461
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 17:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E57D289343;
	Mon, 19 May 2025 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ltm3QLGV"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77EB288C17
	for <stable@vger.kernel.org>; Mon, 19 May 2025 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747676894; cv=none; b=MJpDPbC+y5EVl/dUd0N5Z/+tOFln9Tdq74zTK0muv874w9z/TpzXObl0pnDxSSKsre61nAWlL53tIy2Lkl47s47iSd6SLeJAZkvWL9rzRMC8/VxQ1Fx2a7u/UU264jzxh3r/WrZ1hLTMyPjQuZfwuKSasKLC0m0pVGx2GM8cpoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747676894; c=relaxed/simple;
	bh=M97Y8x0YiuGxep1O7/I5Kmqnvcyk1X4uqJZFP7u86ps=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sPTrhpMCR/oexCcipMEscCZgTkBqRjRFzax4zeqAAa1gtTI4uBA9WsbzFxtcqNGRdZO1TqR4oVaJmZdaPO3bYKx0Bj57Apqht4gKCtApX3H2e3SimDBOnNyQFbLTnaSRUVbYxXqw0bW3K9vmkL9Ua9LjThT+lpzgX6st6mQBKiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ltm3QLGV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JFkMoR023215
	for <stable@vger.kernel.org>; Mon, 19 May 2025 17:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ki30LBVSh/m/cS8iJTZ5EjzlsryTFaBrVqN1bd9yR+A=; b=ltm3QLGVTYC6ZrI1
	gat0/SKJENLXLXzsmaHfWlLAJ5pZWxoHQ2mKoTva0fZLOgjGWaExNR94M2xru+r1
	c9dBAaXiYZcIbL6Ll+ex5cM7FoqRG38r460lVdRhVI7rkz4tl62kOht3KF480a9D
	hIkCXeFdNAoNc8SwwVxmoA6Dsrss0qb3uX1i5hDkWEFSBTwq7Bp2SVY6K9ZRUYi+
	LaDvAsKNK9un9dbneTJnuzb508vpX6T2SeidkrxhnKiOeqrF57e4uhR9SGVqHtDo
	7wxu7YSz/RoqC5IpX2WLPbkc1Ia7oUxJXRSXKPMrdhG0jZVCMNE/XuwOd5qWLo5D
	XoF1TQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46r041srkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 19 May 2025 17:48:11 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-232054aa634so17987875ad.3
        for <stable@vger.kernel.org>; Mon, 19 May 2025 10:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747676891; x=1748281691;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ki30LBVSh/m/cS8iJTZ5EjzlsryTFaBrVqN1bd9yR+A=;
        b=uXFKVxv15wW0HIDhpsGGWiIPTAFemoqig7Pvww5A41/qvHhnRlipuvGe6Cy+dfWpCW
         Ef/MlBLGqjuQ/FtrFuiGb15pz76nAJ4D3fxnMvN+qgszfzvaOG6cR12syTE49N9d1Ryh
         BcjZ1siBGZ/DKXyika/IYwP/pcTSb6ZA4dM8Dbopvfjk48qAPCOlpuU6L9OQE9kkP1UE
         OJdsTpn/r3F+XKehsDLMw3P35aSyakQZbii3TX1qsUr2Y7k6L1CNfto5CijetN+kdFZN
         Ud7iGqSDrtSBD8CZ0XOBEBHAj9S7lk+EUwETEmtzvXmQDC4wDN/P0VMlaruCcCE8oPX/
         fBcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIkQ8BjuDMlHNzBzdMV+0aqcDvN6llTgxl7Pmidu4YzbG+HI3JFpEWJqBPXAQBRreppgxgPkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIAWK7n32MxYVcsaS8lBwuDJPocOL/kZFrILPYObV1F3cf52M2
	s8NBMfyyrN7U4sQDQJ3Yh7T90n4aNnWBOujMH0VHUrVNs2nEHXrFw6RbQXi+1x0huLEJax9IfDp
	XIs+CK5BhtuQD90ziEai9Zc4pGBauLShojlmgyPbjQZNRXtBDUmMaaCppOV8=
X-Gm-Gg: ASbGnctqCK8wbK+1uH5wMKy8/T3UD0vrwSuA67fSJvsqkVkDm991WNSkNWUaNNOBMNX
	l0gml1x3VzdPfunJRTwthUYnw/42S/EfRb8mmlTut0P/rE0bHHMAdbK1KCSFFOTHkvREpfocxBU
	f9Or524uxn7ukQI4/TUO4CBFzDE4/loKrzmE+/MvpQpYjlL1MTMx0VUe++FZwR0NKUlSZSir7aT
	IkjCOEhq5aVjgtLfbCM+xIYnPAnPBlahIWny+WD7AEL4JIoKK30CuxPUZ2izYaBAx03HMujtVK/
	FiXTqwKM7dCDcXDUDzCjN8qqjjXtXics7eZiAGFOEwgOCax4
X-Received: by 2002:a17:903:258e:b0:22e:50e1:746 with SMTP id d9443c01a7336-231de370ec4mr146663965ad.36.1747676891028;
        Mon, 19 May 2025 10:48:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9IhBjayy6fKJrsILI/AjgXlo4kjWAqCWZJbGImLRI5GukGOA1+tI1EeTwEv6Rxm2rDl08PQ==
X-Received: by 2002:a17:903:258e:b0:22e:50e1:746 with SMTP id d9443c01a7336-231de370ec4mr146663775ad.36.1747676890682;
        Mon, 19 May 2025 10:48:10 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4afe8b0sm62651425ad.89.2025.05.19.10.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:48:10 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
        Steev Klimaszewski <steev@kali.org>,
        Clayton Craft <clayton@craftyguy.net>,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
In-Reply-To: <20250321095219.19369-1-johan+linaro@kernel.org>
References: <20250321095219.19369-1-johan+linaro@kernel.org>
Subject: Re: [PATCH] wifi: ath12k: fix ring-buffer corruption
Message-Id: <174767688965.2567051.14391115791572763254.b4-ty@oss.qualcomm.com>
Date: Mon, 19 May 2025 10:48:09 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE2NSBTYWx0ZWRfX/u4lgmPZWXcx
 jAzC0JBA2L1pbwAJNclsrQNJkCaPdtkvuVbVKnhS5xcugMm1ov2SLxfBptGYv/KAsl8QsyrBL78
 96eptNxc1lyh2kU6OXSjNiY7eD7JVyNIvC8FOlaVRqEOgg8aMcy86NtqzucBFbknLqUOF/GSxET
 6T7VfQxwnJAXOadb3JbVsKw98Tod5olMshEPwIL5zWysmvolBkX5z2L55jim6MBmFlno2UPHrOW
 jMxsWpyB+bNgcrpmckjOFILDzVD7Xa0zZyYdp6IuthIxnxEg7Mu57scGIYUXDlLMP0fhDeMsPJX
 eAMeA8vAIWcVh14RUl8C+HDj8z43SHAABiqR74UKaAju8LjF42hWjsaOQ/nLagjZiuWqE/dxiB+
 lmvL4g6j5V4XzL1YSfRoXjqNWjBnLsrsQNcfXWKG5qQSsw+cDYgXGJ9j+CwMD2x+I1eyxiGQ
X-Proofpoint-ORIG-GUID: a-XRtuLxW4ySFadpDG72nwZVqMIx-MKc
X-Proofpoint-GUID: a-XRtuLxW4ySFadpDG72nwZVqMIx-MKc
X-Authority-Analysis: v=2.4 cv=HIjDFptv c=1 sm=1 tr=0 ts=682b6edb cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=R867-RJU_ElmTgWIOUYA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_07,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 mlxlogscore=646 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505190165


On Fri, 21 Mar 2025 10:52:19 +0100, Johan Hovold wrote:
> Users of the Lenovo ThinkPad X13s have reported that Wi-Fi sometimes
> breaks and the log fills up with errors like:
> 
>     ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1484, expected 1492
>     ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1484
> 
> which based on a quick look at the ath11k driver seemed to indicate some
> kind of ring-buffer corruption.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix ring-buffer corruption
      commit: 6b67d2cf14ea997061f61e9c8afd4e1c0f22acb9

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


