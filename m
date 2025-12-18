Return-Path: <stable+bounces-202939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB27CCABEF
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 08:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDBB23020C45
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 07:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB81B2E8897;
	Thu, 18 Dec 2025 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pk4hcSOo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="S1F/E2uG"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B4D2E7199
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766044634; cv=none; b=iJAqOKRos6q2/vULyzuRU2qaujkHBaWSKQ6Hq8vh5kxtQ6eA7rGjwFF0jxYVdB0hpn43n2yp0zypOAwt2Z2mEZK/AZdDIlaWWni4UBz27Y1CarqHCxNNFD3Wf/6UJfwbTrGd7mFy49dEwuISzMocJzCaDGLCQ4EGBu40b1XjLPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766044634; c=relaxed/simple;
	bh=NNiKMdTfFvhd9nsJPGJ+/oDRXJQO0LbyaPUuhw/87rA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aALD6uAY4VuqsxSs+o1fNr5mGyDIBA4GmjEwLnPYDtWYpUt/FFukPa1oAOUK/wI8aZmcvepzV9Hd79LdGx7USYPSR2M9FIfR7N+rvO5+bY3nIa5l0dnmnZR6iUIizKL8KFtEZyk40/HnX9LQzipo1FWVwLNDPxYWTb2XiTIwtAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pk4hcSOo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=S1F/E2uG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1Yjlv167749
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 07:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tmr9S6sDpiWNapvnEXdAgWurpJJXjWMVM9sn6AYEorA=; b=Pk4hcSOoAk99j/Sj
	sNaMeI/wKAqHnfCZBwAjsb5L1HiBX8rfrOh0w3N2bs+NYuxgZ1Ro8oqekKhnGsRo
	l5ylrB3YzB7tDFeTB2N12+txfdtsyzu36k1w9mEOdy7wGF+dB5ELEzFiH1l2Ptwm
	J0QFnXtK4xCZ33D9rCWA8UBmhL4Ua2Y8a1UlvMUObZ6+2H52zCPX+inO3aWiaCZ4
	On4d0M+HXOkeKOhelj8jtF10YS4z8XBnweqjpOZgH0SwCtxqmoo/Y6VnR0XdBY5c
	dojGWB3xTUiNmg2OcyHPH89E4UDArlDZXTNt26R5QIDFBh1CCs6sB9snPpqYwABe
	e/7NiQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b45w51a2x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 07:57:11 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a0e952f153so11473035ad.0
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 23:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766044631; x=1766649431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmr9S6sDpiWNapvnEXdAgWurpJJXjWMVM9sn6AYEorA=;
        b=S1F/E2uGdMAwt452KC0TCmeavkJ5l/qsAbYWkvOJTOzF+TYEelGpM0en0zzdLyixmb
         AI+cXR0k5jWxUP3AL+OCbtuA7/i32JAVKXxd9SsjywXrkfwPs1gThXDbbqlgk3eNQWE1
         97gCwjmRls9j047daKgu/fm90fdgrVbC+atAfNwgGB/sl/gKBWGmUbRHDIcnGACtjr/c
         n9UpCf555VrjBDVRJKT1FzN6NRp5M4qU9Lf9sSttUQNa4zqqIMMyTaICYeiaF+AHPnD4
         XGsi3aboK3l5qvjxL4bcBMThPWVx7JN8ULauJ4ekiAF8mtm/D9wMXXf2d0ChvLs9B06Z
         Zxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766044631; x=1766649431;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tmr9S6sDpiWNapvnEXdAgWurpJJXjWMVM9sn6AYEorA=;
        b=OITb5Zqaww6t/uNfRXdA4jG+nTI49oL9842nTcTsTGasHV5nYOdGMCBSqLQKVx3FM/
         Xxgpw7F151gQVvNTvzpCKpx7o/wf4MTWe0l2FhdkpAvA3FF/mYZQSvxDlcD2y60oXi0C
         ZE3nfV0fCvwTwpd68KIfSl09Yd2LnSQ0VWA6XQYUgtYC6aYabIGY2CuJvHVfsZFBqKSU
         pI4Q7C/TbeoZVHFNVVHi5EoeXgdoUog77IYCW0HqhsyAxRlcNVP8xqYXUxbVldmY0cPf
         uQF5PPB8WGwss2PPRS5MHv4pEEqtWGOkHS+Ma7yDQVfEnGd+Wtt+TWGlxt2x9XZD6R6B
         01lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUmF53KNBGp9bPzCRDAsm3UgmCjZGx2KIC3l+Ihrc7qk+Ktxa5yXMLb3vgnmpAcYC2BUPh7Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUhawOAjqq40dO+UAmbt6VHI1b/OQSk/tQYZqM3wWvlM0Ve/11
	8Q1jGjRyLewmQO5XPRu7xyIF+OreT3z0+9cNdxnOlW0MDSlsWZiFCunjcDKX5nXj+wU4OKFZDAv
	11snkkGdWWpjEzVRtZh2y5sTNUDrfUW9O3KIjJo7x7qxiuoEzQJ9/htQR4FA=
X-Gm-Gg: AY/fxX6Mg4JjxQMOykBsujbqDR/ZtREb2HGqDxWFZyTe0GUnf5r9rNN4FnoZBJi0A7j
	ShHIv1HqkkWsglklEjIdlb1KDOuAiU2EdE9I1QGczl3U05GOcwBHug4ZEOeZOfoKGYA5SqtOj8q
	xlWvI7S8hVCDxOcRjuvJTHNgvvotvToa0FfCvhNcnrnQH6YJeiNjxErFkUXYhOY/vfCe5WzcvH2
	5LzafWi3mmmFgFyUx01iMS9ukr35VjxIJdyD07212Qlt3lZBwaLgwHEC21ZfGxkFNOKSEmQhyPY
	K2VPxG95YNpabVpGbv1c1/aPs2J/sG7hvzK4rYE78TTJajsXR49C7deJFGysy75XRP5/zF9bLCW
	VBDTaRMug/A4=
X-Received: by 2002:a17:903:380f:b0:26d:d860:3dae with SMTP id d9443c01a7336-29f23ae4459mr204531195ad.3.1766044631267;
        Wed, 17 Dec 2025 23:57:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ4mc/QATeZuw9YBw4cP2ebniDT5Eu2c+gkPaPmLvI1fTyaBUfHNC4rjrrKOsKVUvRNrFoUA==
X-Received: by 2002:a17:903:380f:b0:26d:d860:3dae with SMTP id d9443c01a7336-29f23ae4459mr204530955ad.3.1766044630863;
        Wed, 17 Dec 2025 23:57:10 -0800 (PST)
Received: from [192.168.1.102] ([117.193.213.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d193ce63sm16086545ad.91.2025.12.17.23.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 23:57:10 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: vigneshr@ti.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        robh@kernel.org, bhelgaas@google.com,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: arnd@arndb.de, kishon@kernel.org, stable@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srk@ti.com
In-Reply-To: <20251117113246.1460644-1-s-vadapalli@ti.com>
References: <20251117113246.1460644-1-s-vadapalli@ti.com>
Subject: Re: [PATCH] PCI: j721e: Add config guards for Cadence Host and
 Endpoint library APIs
Message-Id: <176604462693.840440.17361297043510952220.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 13:27:06 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: OuX0Zh_STNZ3KUKqaTc-vk__9_iHdo92
X-Authority-Analysis: v=2.4 cv=eKceTXp1 c=1 sm=1 tr=0 ts=6943b3d7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=PLOdWElDzbaVVj/XHNhp9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=XNqfoAmXSU-mxqL4qO4A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: OuX0Zh_STNZ3KUKqaTc-vk__9_iHdo92
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA2NCBTYWx0ZWRfXwYTizclKrgmu
 PKAlFUyv9wwxWcjFYZ00cW425pIiaFmyfKlsCYcBniakIpU+g39urmjlOGa/7kAqFy3ayUCuIMD
 cZ4cn+SqdUguIYkgiTY37qoyxPDOw7SImHtpaQiWV04WU75CuF2hdulOvc5Qx97EdhA1MytEqA2
 NltKCxEx2NBedCmLuE8mOZsqgIRKVEZ2VJi3jYovVzeifpZE8JiRtAPOCPid9pk5fjCvr+GD3v0
 yHx988XnzYPKdzMHnbr9vthM9ZHc6+GqoJd7YZGrWvSzJinjqo14UUonnI8x+LIzOGkAAeQjhTf
 A7PcYnBAb6/uotlRefxdkr2CLd4Z+TefdnJqO0ScrjVNqA1fXRfm2ZJvbm6RBV0b/x3gvVvPAt5
 N8tC2Y1qgDfFXRcMbF6TqF+E8hBTaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180064


On Mon, 17 Nov 2025 17:02:06 +0530, Siddharth Vadapalli wrote:
> Commit under Fixes enabled loadable module support for the driver under
> the assumption that it shall be the sole user of the Cadence Host and
> Endpoint library APIs. This assumption guarantees that we won't end up
> in a case where the driver is built-in and the library support is built
> as a loadable module.
> 
> With the introduction of [1], this assumption is no longer valid. The
> SG2042 driver could be built as a loadable module, implying that the
> Cadence Host library is also selected as a loadable module. However, the
> pci-j721e.c driver could be built-in as indicated by CONFIG_PCI_J721E=y
> due to which the Cadence Endpoint library is built-in. Despite the
> library drivers being built as specified by their respective consumers,
> since the 'pci-j721e.c' driver has references to the Cadence Host
> library APIs as well, we run into a build error as reported at [0].
> 
> [...]

Applied, thanks!

[1/1] PCI: j721e: Add config guards for Cadence Host and Endpoint library APIs
      commit: 4b361b1e92be255ff923453fe8db74086cc7cf66

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


