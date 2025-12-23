Return-Path: <stable+bounces-203307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EFACD95C7
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 13:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34FEB3029C4F
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 12:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DEE27F4F5;
	Tue, 23 Dec 2025 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IjOkuFb6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DrzaGE8Q"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC01833C1B7
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766494130; cv=none; b=ocP0Kz+3UVICzqVBrCb8eiV0lXpWa8ldMiB4DkArhDjyPpytsoOqkq8NwHZRgt9ESdE7Yk7cUEABLVOxMkHqmDLGKPxy/PpBqJBzC1D2FKuX2M11Lc67OsF4Db3dv/cOcKYfwkueXaxpUc0PMr8NR9hW4CSC4qKfJte8yJU+JX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766494130; c=relaxed/simple;
	bh=i59QBVjcipThG8DPnC9H8UaFM7mf6swYhObM6DGBW4Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nAYaE/DHUoA8EKUaFuvjU+Urllgu++O3GRMR599KqW5BfGCXdWQbeReKSiGKM+PNyuZQo38CrG5BsOF0Er8A0Fki8abpmwKGcvh1gSMJELDLii1rsLDaezVrPjCS/VvCcj3Vfz26Ym0MYsoLWdUCtbFu8Bt+s4Aniden8FxTEv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IjOkuFb6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DrzaGE8Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BN9uY7M1530068
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 12:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VpdOzjVXXo3ABXz2GAYCU15x+ZuTtI8ZVsD3AfJvyfo=; b=IjOkuFb6Hd9Bm2lF
	Tx/CjUBLnLjHnlr1iSdnrGWhbjFmroGVoRtje0NDq6O7O3VzB6z1HppO6kmHP4LJ
	bVt594axA0kQ9SvzXyizUby2zwKZa3nTfd0OyproWavPFn0+KgRtewYske2dYYYa
	kihm5XTTi+iQ6nFXy/bav3JAB3M9W6TBdX7tY9VILo/pBAH2pZbTcEoEtWiAhJMp
	AKQLb3/b9NUysOcg0mx3EMjXuy2r+XefoZpEyUH7zK23SFGX0bsyOrnWRQKtcScP
	8buJIYz/YNo5b1OZLMe+C9JbR37zY5s5X1phCpbOYxEsmQNDWFeVPQvHltJjgsLV
	BFUmBQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b758y3xqx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 23 Dec 2025 12:48:45 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29f1f69eec6so61807895ad.1
        for <stable@vger.kernel.org>; Tue, 23 Dec 2025 04:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766494125; x=1767098925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VpdOzjVXXo3ABXz2GAYCU15x+ZuTtI8ZVsD3AfJvyfo=;
        b=DrzaGE8QWg/0Gh5/I1ng1cb0YAMEnvM9eTA8BmULTh0zU5nTJ1G0GkE6r7jwdVg8qq
         /+MpiY7YsYXDH/Q+GX2BlI6hKHohJsI67dRSyCvXBirwLxl1m/iyX5HbKGr7V7q2cmmT
         flmhjV82h+z79l4ERc29ONPxtPfqiBHuX33LieZe+5nFnutmr/oYyFzpmNSTmpYRsxF4
         woIFzHs3JMGpOEshrhQ5CqpCgUXpPnjMHOsJJjm1u/ol9W/e/qy7m2G9DEXdeyLDeoOA
         Hk0IMcOqxNCo9BtKAI6UsTiVQiEEt3nOtPt5GnWxCOpIPoGX/Adw43qAUHdumwudHdUs
         gPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766494125; x=1767098925;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VpdOzjVXXo3ABXz2GAYCU15x+ZuTtI8ZVsD3AfJvyfo=;
        b=l7qphxt0zdRxXiyoZ0pu48vciHTZLSSdacVHTxqN2uqadFO2SYVCmksySCOeFdk5Yb
         EubKLjSWSZgHSFtkmY8eGpN6QozOA8Uf4fHMkaql8TNSMBGwaRY8adeV579uQQW1FIwI
         iGiWmBClAJcBGaEO7Lp25R/IKLZp7PWEOcyRdfoH/dZL7VIaknssLmYl/Mq9itfkMAil
         yo1Wz4BDI6yRLVaxw8UHhX5EYZ0fVuS8+s7PwH2xQLoNcBI9NdkSQAzPTdcKktH/gAxY
         8aFoa1Xy5dNrxftgIbA1Jjs5Mi/7sb9SgCXjB3IIUCrSWLRr5+grdCdUi2leFrZM0ZJ3
         24VQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7pCzDH7mS7yhxP3Nws2BP/kDOP0d+lh62CUMXoWPofHuNleGZQGoS8RxKRhAcpgv3GIF8MVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVDBuUgKvdZ50TedQ/bxJ4lLpIFOlIAr7KAcrkMlnSx5itgllD
	Ts26nGAKRZG5UZAgkmvSocZka9xt13KmGj5G05pSMpjUowR65nN84GmpZRE2Ue09gzjdwbqaVmx
	Sxv0qG4UnbVr9NKiqjDT2uIW2W5ZUXXswATWsDoYAMaCVc043oEf2omvKBH8=
X-Gm-Gg: AY/fxX5v40FYpTdY1loCjb86r0qQ47IXmaZrYhF2gqKwrI09hYXAkW+1akGJvofisZo
	xQLyRvzyCKRegjiG8S2IxqW1IH/qQsryA3XV0KPLak85KMWQPIVwjMe8sv1vKiN9ikfyOMQij0l
	JvxHqvgH8p1OoLTXxKsr6M7VqMc7sTzqHWSW5WnbGg6Lh7Rgk7Fvx5M5J8RR7RghFyVS9PdHLg1
	VenihwgD4scjfC73YQut3a4AGt27GcMRIosIGULWHYfkcdgyP+ld4BIAw0M4aoOnRMe7gIW/g1s
	MJMo5Y+xkox0HFwxwNTv6KjMJe4Sjd5Ywx0KxgdSBmh+6QMtqDg+JUFotGUeCZWFdh8KTe9TeWX
	M8EQhRmUo
X-Received: by 2002:a17:903:b8b:b0:2a1:243:94a8 with SMTP id d9443c01a7336-2a2f2a4f102mr148061985ad.49.1766494124675;
        Tue, 23 Dec 2025 04:48:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8YWs/Lrk8D8Qax6Yg5cm74s9TOxV44XYaEydl2Aosk2GGRg9fclJgfKsjM+Tlt+pRR6geZw==
X-Received: by 2002:a17:903:b8b:b0:2a1:243:94a8 with SMTP id d9443c01a7336-2a2f2a4f102mr148061735ad.49.1766494124140;
        Tue, 23 Dec 2025 04:48:44 -0800 (PST)
Received: from [192.168.1.102] ([120.60.139.28])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a322d76a19sm80283965ad.101.2025.12.23.04.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 04:48:43 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, macro@orcam.me.uk,
        stable@vger.kernel.org
In-Reply-To: <20251203-ecam_io_fix-v1-0-5cc3d3769c18@oss.qualcomm.com>
References: <20251203-ecam_io_fix-v1-0-5cc3d3769c18@oss.qualcomm.com>
Subject: Re: [PATCH 0/2] PCI: dwc: Fix missing iATU setup when ECAM is
 enabled
Message-Id: <176649412094.525930.11885393958582645087.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 18:18:40 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=TOdIilla c=1 sm=1 tr=0 ts=694a8fad cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=wbxd9xFQoh2bOL7BUxlcyw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=dOtSmj_QbqaLots3hlYA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 9Qf5vkrGTa-ImMjQhsH0gpFN0wMhW5UK
X-Proofpoint-GUID: 9Qf5vkrGTa-ImMjQhsH0gpFN0wMhW5UK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDEwNCBTYWx0ZWRfX9ba9s1uJ9nZo
 EyEJ7DGUHi6FP7NOrTtcGT1LOG3ubpzbuOgSzhoJ/QYRvhTLk8aQYCDQZKxv94KNBU3oCyZH6/A
 8BsHSuAUoKVw+1J3GbP7C42hLIevdl5a+EoRuHWueVg9dBI+2VAWqzskyYPF1oMQBV77auc2VCw
 Q4U4tPz+wrODrCBNxjG39ubVhqcbiqXacE76flJ4QGu4n5LoCglneBumK8lYDdFYzYMsp8LXzDA
 2DucqPZ9ko41MLZ9kkS2HBK0viXvOlgP19BUmHq6lfJkDshHbfn38wQAZBbF+LbtfQPdSyOSfi4
 ZfVVNP56VkMeJNc4xL3l2QzgaDDRPvzlEA5ToHCenJTZjSyJiwkGL9lQadpdW8JmJNvvRYT5x3B
 XkDotmNXl+0pSxYsYaG7GizeI+0OZwdHcML+EMcI1JgL24IRAxFr1kM5fVXKmr1WBk/BnTRmjdR
 RkHuXYkqz/Pfue/05qg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_03,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230104


On Wed, 03 Dec 2025 11:50:13 +0530, Krishna Chaitanya Chundru wrote:
> When ECAM is enabled, the driver skipped calling dw_pcie_iatu_setup()
> before configuring ECAM iATU entries. This left IO and MEM outbound
> windows unprogrammed, resulting in broken IO transactions. Additionally,
> dw_pcie_config_ecam_iatu() was only called during host initialization,
> so ECAM-related iATU entries were not restored after suspend/resume,
> leading to failures in configuration space access.
> 
> [...]

Applied, thanks!

[1/2] PCI: dwc: Correct iATU index increment for MSG TLP region
      commit: 3c364c9b96f1a0629a29363cdc6239c1ad2f68ad
[2/2] PCI: dwc: Fix missing iATU setup when ECAM is enabled
      commit: 37781eb814e16c75abb78dec2f9412d2e4d88298

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


