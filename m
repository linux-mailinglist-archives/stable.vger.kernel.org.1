Return-Path: <stable+bounces-144630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B24ABA301
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 20:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5853AD1B0
	for <lists+stable@lfdr.de>; Fri, 16 May 2025 18:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD64B280011;
	Fri, 16 May 2025 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C1RRrQjR"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354AE27FB2F
	for <stable@vger.kernel.org>; Fri, 16 May 2025 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420447; cv=none; b=g6B2VjwQAeBeWuVyl3jcfgY7nRXm+L5VfgnL3N5OTIyGYmgkFNo6HiizwBrUhJ3VDfCtAsWeMJ5/kGBAiZvbbW/mH6gayhIaLmT2K1AN3wUR+xgX6NjOkBWzgi+ic5U+7sUsAWB+Ugl85r3i8XtRbB0du/ulfGQ0/sZ0p7yr5sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420447; c=relaxed/simple;
	bh=l7wfDBiV7fPwNluX/sbXVzXO2k5L/69mo0OWFXFZ0uM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QKT50PO76S1wxC8j0TYzzSDI/zBsojpWFQJGrr0FRl3i7ZUeaINRR40+OtwGBjqbb5ZyXUFmVQuf6fvFpWv5SEKaGKn4k0tZDo6vk+xRr+A64DscMhRYXSeAOuMeCH1PvXb3QRjrbydNy5DY9CIWjoz+7MmC/waQqA+Q3qm39yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C1RRrQjR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GBDpF0026140
	for <stable@vger.kernel.org>; Fri, 16 May 2025 18:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bMwJC17N0LZE/PF1Re+m8j8/ER7di5Fs7MKJCmuSolY=; b=C1RRrQjRL8kVmzyP
	LZlAkZBgprpLpZBM4LpXi1qGUPvJwia+ag+l4xyW3Eu9mfSc2NaiTQcl0cxwcP6W
	g74hyL+S+VS4ijJsngIh+2JGVP+yNwRqtmItbP42pkdNIPrOcfqW5YwIkSWdfG10
	6oU9TqL+HIFaD0U70Z26kPulz60Cj9LNad1cISjKRb9Ty6jSDnlhXs+gbSzpchUV
	y8QWiqR/Y/2Vbh4rNG3obH4fRNhf6ZhGDG8CJSecruAz5ukjI+7nsoVZ0MYIf6/R
	9cf/oJ8Hh9cWMl+47vF2kYRhZ/WSedt0QUYCEwn8MvZg/iZDOuwgdXINg/KWfKb6
	8/B6HA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcyu3m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 16 May 2025 18:34:05 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-30e74ee960aso1420627a91.3
        for <stable@vger.kernel.org>; Fri, 16 May 2025 11:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747420444; x=1748025244;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bMwJC17N0LZE/PF1Re+m8j8/ER7di5Fs7MKJCmuSolY=;
        b=AEpr13hAGixVrOcfRxb2BXpuwRPcqkFJVcUCo7FYnClDhNfFiQGfgvcStF/LPKX4z+
         SICOtIsrbouNdpdEsOEG6h7G+bbhqeJse2d3Gc9LbgqpoftXzm0/dWCkjEM1R6sKZNgJ
         aTWzwwpkL+HQ7SoKSZ0E3LPpi8tKPxpmDBn74MEkSR/wTxaAeP4dFTkLlsPqB7RMptTc
         xLTeokYHxSsvxvKkJ+ZbvqMigT2VinWs1datDfH+oiHu0V0TOHWaRM2m7+7NV1G0UGhN
         /VbL0UeJVZMIPqC897NoE9TUeR3y9DfYaVmRdJnOR7BS/V4q1vlPoJZ7oYrAh/AlmGUi
         s7pQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZssIjeAIchlBM3Ye6nfkBf1Q92/CW7QnRIFv3BYXQHYnJ/0L3Nwvj1X0bk9MTelQSLoFi1kM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Bd1Tzyfh3JcKe37w562yg+gfVvhofSjTUh7rn/dFVM3u0bqK
	izgEpS6UGKkWFTzkAMni72oVPkPdAoBlzgzYpOBwwMKMmvHWUNBRYyS9IFL4C67MODO5c/eJYy4
	fXw50AADiH6TH547Q0YvFjh2Qj8LQv0o4goWlpCKaMpm9otf0l9cTMayr6eY=
X-Gm-Gg: ASbGnctaK5qAsHOGw/z1UzA+dWokkDZ+fBDKcqzxM+kuhunUxO29COtnccEFl3EXKFT
	xpVTCBShhtDieKOW03cI+J7twVJuTCjYEieQIRQSVDErT8r8Nx8hhIfRRlZhkyVNxPsQrnVtAEa
	b0OsOr+IC8KYpo/yFf43ynK7UL2ihSve/v7K7gMzLHm85Om0/WmkPOhDS8LP6BwUaq0SRuqcXm0
	Nb+3yXg79Z2+HbpZJ44B2L0mfg33jj7TfW1L2ZeOv+XQ242TJx5GB3LHI9cPJHOKaz5mHp+paZf
	9K9yPKKEO0ltgkHcpGoy5mMtK5xji9s0aPKgWkRR7D9GR09x
X-Received: by 2002:a17:90a:e28e:b0:30e:823f:ef2d with SMTP id 98e67ed59e1d1-30e83216f6emr3390119a91.22.1747420444341;
        Fri, 16 May 2025 11:34:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKrnTa0VFLRTEBZCfV/Z7H4WzAhUIJOQQAV7WI7LhPnP/umk4KgcKmhJ1vHpXH01VjBGHX2w==
X-Received: by 2002:a17:90a:e28e:b0:30e:823f:ef2d with SMTP id 98e67ed59e1d1-30e83216f6emr3390085a91.22.1747420443852;
        Fri, 16 May 2025 11:34:03 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e7d576babsm1886299a91.33.2025.05.16.11.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:34:02 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
        Steev Klimaszewski <steev@kali.org>,
        Clayton Craft <clayton@craftyguy.net>,
        Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
In-Reply-To: <20250321145302.4775-1-johan+linaro@kernel.org>
References: <20250321145302.4775-1-johan+linaro@kernel.org>
Subject: Re: [PATCH] wifi: ath11k: fix rx completion meta data corruption
Message-Id: <174742044217.3092151.7410193996690738196.b4-ty@oss.qualcomm.com>
Date: Fri, 16 May 2025 11:34:02 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: HCoCPDRq8FzKq0ZbeWnGq_xV0Dg52qqP
X-Proofpoint-ORIG-GUID: HCoCPDRq8FzKq0ZbeWnGq_xV0Dg52qqP
X-Authority-Analysis: v=2.4 cv=JszxrN4C c=1 sm=1 tr=0 ts=6827851d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE4MiBTYWx0ZWRfX7sq31fM+lPdL
 a67hiXlVea8NUQbOtvomCNa/5++9qL+pmyV4iJ5yGstKeXPf9I+1YPEo3H7SAXUPH/SKVrWlYrH
 I2Wl+7HeeKAdjZNkGrmz7TaSxpOo4jp6YQ00wakeaGZ+jk7vVFSQt7vRKdcMs+bhNLW7cxpqfRs
 GEJ1GlMnz1/dJKInRwZ1xl3POKhCBHHbcxm5QXuv7ooF0g6/oYV4J8kqBBURWo7YCsS6h8wMqXk
 ryNDRfLNBTYXTlQSnfH0MdvH+L6ym8p1qwA5yrm0v37kKVL5aWliChIgBABesNibMVnWAMxJBj/
 LHnIo+K9qOFYVvNrSUHOTbb8Q5+r+/fBZRy5POp/aRSnWiYtvRh8KJniM4dYY3xIu7xUdW3jgjF
 NqydueIh9De3YF862+pvgM3KVjCx/F5e3DPI5VuFa1MgVlcd0WLiDrgBF+F/63PcH2Kyf3Rr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=903 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505160182


On Fri, 21 Mar 2025 15:53:02 +0100, Johan Hovold wrote:
> Add the missing memory barrier to make sure that the REO dest ring
> descriptor is read after the head pointer to avoid using stale data on
> weakly ordered architectures like aarch64.
> 
> This may fix the ring-buffer corruption worked around by commit
> f9fff67d2d7c ("wifi: ath11k: Fix SKB corruption in REO destination
> ring") by silently discarding data, and may possibly also address user
> reported errors like:
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: fix rx completion meta data corruption
      commit: ab52e3e44fe9b666281752e2481d11e25b0e3fdd

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


