Return-Path: <stable+bounces-180588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A1EB87691
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 01:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29350581BF8
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 23:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034072FE077;
	Thu, 18 Sep 2025 23:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RgKoZmHI"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5861E2FBDF3
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 23:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239251; cv=none; b=OxbO0g19TcUYqztfjpBwAXl9sOTcV6VpzGcDoV1WuYgT+eEPx6mMJPgEIZSXTsXLHX6EVXLVluXPznb4a5HPuVbAO2GrgsrIOu3euGl6BejIqybicvEWddwYjYpLtfRmuR9gLSUT5xM+vx9M1rHSMJKM/8tbytW7Y/0VsipwciE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239251; c=relaxed/simple;
	bh=KIjI1RO8mAvB0xu/RUl6nnERV2ejU8oSY1onvNolHV0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DjnxH/9SAiJ80Erq+eHalAy9hrE3EJaNol9B4swdC58EAl6KRrSSYuVonzlsLyejklRBylekT35J9o1g9iJbFh21kdbOm30g0Cmqib06D8fNvI7NVRQFslKJI1xVNiG2hdF4eXSeSNur5/DB+mBBL4jNnQFhNyI3KekF2Akffm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RgKoZmHI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58II4nW6026793
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 23:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kqH34T9ABP4xJGwUQgNeZtZ1hEP1XtvVs9vYhgoytOQ=; b=RgKoZmHIz5CSMrfi
	RbMcBs9Ln9BAt1IzebjazW6puUjSfAwl33VRXOllBsVjsmooXGGEOd4R2V/5almS
	uEyRyNvqRT4B6hLAzTjG2gOzHrdGTV4jSV+VsBs3rKG7bSvFym7/qfE6z2b0Y/b9
	nR6pl20K/Z5eI1nR9BOtDag/hmDgohntnDmuHDfGtTwN8nFsDaT7x6yxAVxiC+7w
	n+xtQJr0yEGyligBWnLSU9T2NildDhpjVc366y5OsOU/3VZz+2g3GgSMPBvSUmTC
	tNOGwBfj/VHFPcynLINI8t4UjAG9Fcf5A86NPYndm1nNpEB5We2NPbCbNzydoCSJ
	D/+EyA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fxt8ear-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 18 Sep 2025 23:47:29 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-269939bfccbso12988645ad.1
        for <stable@vger.kernel.org>; Thu, 18 Sep 2025 16:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758239249; x=1758844049;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqH34T9ABP4xJGwUQgNeZtZ1hEP1XtvVs9vYhgoytOQ=;
        b=ny8EFWGHSp6nidL5QKoWi+xQVBwMKco7QDrf0is3ibEcfb50dinII5Z91+lKg2ZWCb
         5kVS4jRY1/4rh/pADAjZqpMYe8yHH2xPdFdnE+2o+2WbiQWXC//Kse0cQnj10yCZJPpj
         9X9nlCTSYDQSfdWQTd/k5h+RHtAmp29ook5as7z8MCXw0M2KozQ01Ctrr9IyIST3dC0z
         eJscVPo2nVryJQ1PONVxkyShUT3RfOPYpPGY+cGWBkWZljj3ccEihT3Uy7XOdm3qbYwL
         itB7+D4P9WG1kxP7IN3W5pPQEdisC2ZTKjfgcpl2UxcyrGuL0We0AFtBQLq5Yx+VvkN+
         dvzg==
X-Forwarded-Encrypted: i=1; AJvYcCWtTmSLNhKYpqyYwHQaELUcS64jrM0Um0IkqwlOGDXxCkTCnGmeRw1ZLxQbtvsMdSQQUnDsxFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfcBIb6RV3dW1n4NyIVjtrxJN7Plsee3Y8nv/cOtIDOWdVtOVA
	ICHokAwKa+pf+D/FEg+1uBUaRBahIdKmv7A2nZluxShZVivGV2Uu5cpXlpzSPBBnSamhpiYB00w
	5lCNN2J2yGBj5rzjFc0MTggDRqEk3X9TTV4SIoU6AhmLs8hWgFgiYRt1ugz0=
X-Gm-Gg: ASbGncv8jtD8/+E1sy4ypin6Q2m9MZyCuuQaJFoC0Tdry30tf+MHIQVIbEJUD9z/x0o
	DV7EW5dzOG5FvVDgL+pszQ6u7YqkwxjD8o/7HXOgYCG9ifOS7p5N4BabmrtdFKbl1aa6e8tS3JU
	edH6w02wN+hG78vb7vvMdHHStgPODmzveQGSfph0Nn/fbqDF301ASG0cxlaVNKepWq8LIvjlhsk
	ncW93RFBkrSjaj6OJ94YGjRzjG0yJpYkoFdcEaxN6OHaHpnX8ixAs3K3wFSvuz0t+Na8uBiHwQu
	ujz64TfHaUH1timDgMq77KE9ctq88IMAQBfAmS79iSDeENbEjPHq4f6mGnrZlkX6YO4FMIFLoOF
	R
X-Received: by 2002:a17:902:e946:b0:24b:4a9a:703a with SMTP id d9443c01a7336-269ba42b2a8mr20343225ad.17.1758239248784;
        Thu, 18 Sep 2025 16:47:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/6dTbkLUp3A7b22kFC4mdhZ/7BtHqoap1xG7tY7v/Dt0BYlzLBuVlVJrxzIJMbJOcsmXrug==
X-Received: by 2002:a17:902:e946:b0:24b:4a9a:703a with SMTP id d9443c01a7336-269ba42b2a8mr20342975ad.17.1758239248362;
        Thu, 18 Sep 2025 16:47:28 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269aa71c928sm16474705ad.107.2025.09.18.16.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:47:28 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Matvey Kovalev <matvey.kovalev@ispras.ru>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
In-Reply-To: <20250917192020.1340-1-matvey.kovalev@ispras.ru>
References: <20250917192020.1340-1-matvey.kovalev@ispras.ru>
Subject: Re: [PATCH] wifi: ath11k: fix NULL derefence in
 ath11k_qmi_m3_load()
Message-Id: <175823924766.3217488.6109469666821383356.b4-ty@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 16:47:27 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: iB66LsyILMzHWk_2SOVTT0Y-EtrXBmLU
X-Authority-Analysis: v=2.4 cv=bIMWIO+Z c=1 sm=1 tr=0 ts=68cc9a11 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=HH5vDtPzAAAA:8 a=EUspDBNiAAAA:8
 a=nfJR6hy_ZLdhEb8FW4cA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=QM_-zKB-Ew0MsOlNKMB5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX6TTyx4f5XDb5
 KkwhnLRw9Iu5LBBgOUXQRCNqI+Zbp18Hu76zUY64jZTqVXXpEWgerSQ/vfr93XPmggRpMDNqylf
 LanC6qn4kL90fhfn8gOmasWVFhezwpp9BFeWjXlDbUnl+5I4fqAv66+acDiZMg6akTR8RMlehNm
 NbJLsoo1FHGcF/h7ebMIduFrebxCQEeO94rA1Hv+VE5n2mfKMbtOPaE6HEheVlVPBtQTCDyv6jC
 V4M9jmStsWTU+u32R0MTT69UlTPia9iLlFXSb7vTiV345iEctQ7maNaEu10rbh3gi8O0P+OyDpU
 olLRKZwTSKLtzbEflV+pPDKq0MIptfxvvSsYaedtgZBuItIIwaZw5eQw1Cj5XxzYMn+HjMn3Y+A
 8sdmoqyO
X-Proofpoint-ORIG-GUID: iB66LsyILMzHWk_2SOVTT0Y-EtrXBmLU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202


On Wed, 17 Sep 2025 22:20:01 +0300, Matvey Kovalev wrote:
> If ab->fw.m3_data points to data, then fw pointer remains null.
> Further, if m3_mem is not allocated, then fw is dereferenced to be
> passed to ath11k_err function.
> 
> Replace fw->size by m3_len.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: fix NULL derefence in ath11k_qmi_m3_load()
      commit: 3fd2ef2ae2b5c955584a3bee8e83ae7d7a98f782

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


