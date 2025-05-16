Return-Path: <stable+bounces-144629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07944ABA2FF
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 20:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D27A272E7
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 18:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED83727FD60;
	Fri, 16 May 2025 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rm+x2Ptk"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ADF27FB2F
	for <stable@vger.kernel.org>; Fri, 16 May 2025 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420445; cv=none; b=RCW9d8uKq/89D9LFBuE2jxcgQXTKFX1986GRONQ87WnvBGWJ/yTtgYK3sYXoPqQyIcC0iHs13CK53cUbEcBRSzjqezCJLR0ysIPFkk4m+ATP7zQVVOubX5GfwFZY/MRlfu9f/eGpckDFT7ap2s5M0eovMthdE/tOCqpY8fXcVv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420445; c=relaxed/simple;
	bh=zXqAoR4EfuKOxXCq0A/698ZrHVDeCN37DGgjfTfOph0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bNkK5VNmE6Axelp3YvJPxu4bb2cBPs9iSMHPMvuR7Aqwb38muNKBDHhRUYIXwlXIUFpyJcklc1PKgAI9Dn5B3AWxd69VOfJKNf/SWBDemIVFpktKhVrlEsK4oYcVrNi9aSdF49g2V+l5d/zQrNFEZ4t960Sy2HS5znJr1+Ko9cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rm+x2Ptk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GCL81h026156
	for <stable@vger.kernel.org>; Fri, 16 May 2025 18:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9rKtKvHPlmBU35ct81LUYhk/RNfjmHT02ibJBXpyRmo=; b=Rm+x2PtkHYgN4Zf3
	vCRjB3HJ3x1aIuRWsvQ0kg/6YwMm63VMIf633xxpcnmK2Ehzt8vsMX1nQs0h6PZl
	Ht6cFjZvZOgONWb0KjWXpLigySFecrxTTB4So6g6grYSdA707SOQK3rqXZY9+2cT
	Ub6lm5gfazWKIZiRha+5cajGEpPhBoSyIlD0joEW9BHLeImcQ3jFy648Bz6lxeov
	f64BEm52jB9hSDNI+Hh/yhtbiF+lScLQPmRBgyGRdWU2rhG0sUeRrPyHT3nUeUJa
	w28eZcfQ7RNA4vY/KHDTq9QAIQ0dpTMj+0dk8Z50DN6TS8Uvku/ddh6oCUrig7Py
	IrXxlQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcyu3ky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 16 May 2025 18:34:03 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-30a96aca21eso2528315a91.2
        for <stable@vger.kernel.org>; Fri, 16 May 2025 11:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747420442; x=1748025242;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9rKtKvHPlmBU35ct81LUYhk/RNfjmHT02ibJBXpyRmo=;
        b=SrYjuzOJZujCMLOKiEPCrMBmQSnBlXYIUwnq4MGM3cigl+oB0dhcFB4aF2oxXkxl2M
         aY3gKCzfwX/A9YJ+QWsBfzHw/nuxWjrry3VOw6YwooINPi2tDAWF4rrUkCwWgGUTcXMD
         TeJCSaReuUVui3FYutbjmQt/2+TYn7L9InsjuTcbN2v+Fmqvp+biUtyD59ouSgazFSoz
         kGGPVNpt0iuggrw3G/Jy+4GH3+EynVXZVEPVqBwPRgQAY+UtT+LGjFZZMzfGjj/bIOj9
         WHsKTboH4OOK127lixeKpZowd9v7SajELjiNekCy0c/3ZU7qzZZBaJQ7VQeaoR4qHaw8
         5WJA==
X-Forwarded-Encrypted: i=1; AJvYcCUJdLROEwSzlgbTJtZqDz9SXhBkjKBd/Q0qWcTANJFeSYEx1Fb7JSEi/z8Nh00AJkSojeTxu3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1tSv/7NJZn250kJk2IMRiz0JV/kdgXwy/cgyGRTYY89N0i8Hi
	F88Mh16us0oeibfEiJoU4Fj0m0FirZp7pUHbmuePr/4ebJq7GIHI1xgqlLs6cvzG7g8Reul6950
	34j87qXLNR69wwkYbY/MH41FIwofDqGpaYekH/BponvgVkmDk/TNmrFRdcTM=
X-Gm-Gg: ASbGncu72HHR/SQTksH0y2HXYE/Tun3xql8dU0lRiV9c5jtlc46bTPUes0UDyi+38X3
	WggkG/4VTlMUO3vdc0A4Nv2DpkjvpFUZ4qyRmWz/PrOmCDI7yUkWErLQHQJvcphESSEzY8WwKMt
	PiMScbmYdLo9MssGdrP+Rim2041gOg8BkJSY+oOAw/jeQjR9ZmxiTTXjbtDPs5Xj0fPkSya+Ave
	S/c6nM01VzSVFGsIDTLj1ePZhnzyfi1KslrW7QvEunqx73qgsclHCsKfAeuLsTxVpye5wkZU5hR
	zRcjPJrGx2od5j9GMm4ylw0J1QHD9I5sOLaNCbLEV0ZrSA3W
X-Received: by 2002:a17:90b:55c3:b0:2ee:cded:9ac7 with SMTP id 98e67ed59e1d1-30e7d548c5amr6293559a91.20.1747420442435;
        Fri, 16 May 2025 11:34:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfU/I+VS8P3Y2hHITlYwiE14XuPxHWro93S4ypSGLKOx03F5dtPTXcGPNIj8o550YK/qnMUA==
X-Received: by 2002:a17:90b:55c3:b0:2ee:cded:9ac7 with SMTP id 98e67ed59e1d1-30e7d548c5amr6293513a91.20.1747420442026;
        Fri, 16 May 2025 11:34:02 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e7d576babsm1886299a91.33.2025.05.16.11.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:34:01 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
        Steev Klimaszewski <steev@kali.org>,
        Clayton Craft <clayton@craftyguy.net>,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
In-Reply-To: <20250321094916.19098-1-johan+linaro@kernel.org>
References: <20250321094916.19098-1-johan+linaro@kernel.org>
Subject: Re: [PATCH] wifi: ath11k: fix ring-buffer corruption
Message-Id: <174742044076.3092151.12237526642580787341.b4-ty@oss.qualcomm.com>
Date: Fri, 16 May 2025 11:34:00 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: dNZ5j7gRo1MDcThykfpN9WZLpEgr-BNU
X-Proofpoint-ORIG-GUID: dNZ5j7gRo1MDcThykfpN9WZLpEgr-BNU
X-Authority-Analysis: v=2.4 cv=JszxrN4C c=1 sm=1 tr=0 ts=6827851b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=9x3tSbx4FoV4MKPCUlEA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE4MiBTYWx0ZWRfX/ydKH4SHdA3M
 WnPRQZFRx0eqTWt5cpBy3I+mPh+raPUqJWVY/JoNs6tSBEz2lQyGfEOzgNEsoq6DIX/eLTWrQQH
 3BDtZ8/BHjVtPBGZYwTCaiFzHIM1z/gNhRQbxiJ4FdfzCBm+TOiGBQb1nJJIYqMCZFZdZJWhDdu
 fuxXNP+M0/AZJc0wEu+82lU/YR35EQ3/K5+QEugZ1xuwIm0/2SNyhUolsEmANw7LrWh5ePLfMm9
 qg/jfYfZOyBF/mEophBVo7RcPD7nO8twI7wCcjmS+JHQACWlUd+hGb37DXfLUXTdWRl8JM1u5S8
 52X+cMpSPNlum6vKwmzrIcXDJiIH3d7MEPzOPTV4drBYcWrCo6tJhRrAZ6YQBEbLJf1ToYtct6m
 1qGO8UQNAvSdrtkY7ekI2+CHEC7rKCmQEhXv9XtOeh36kViBSVawX/RedvLzndcYy03nILfL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=669 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505160182


On Fri, 21 Mar 2025 10:49:16 +0100, Johan Hovold wrote:
> Users of the Lenovo ThinkPad X13s have reported that Wi-Fi sometimes
> breaks and the log fills up with errors like:
> 
>     ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1484, expected 1492
>     ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1484
> 
> which based on a quick look at the driver seemed to indicate some kind
> of ring-buffer corruption.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: fix ring-buffer corruption
      commit: 6d037a372f817e9fcb56482f37917545596bd776

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


