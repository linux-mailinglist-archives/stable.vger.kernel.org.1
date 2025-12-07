Return-Path: <stable+bounces-200295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D9BCAB91D
	for <lists+stable@lfdr.de>; Sun, 07 Dec 2025 19:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91B8E30169A3
	for <lists+stable@lfdr.de>; Sun,  7 Dec 2025 18:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710CB24A058;
	Sun,  7 Dec 2025 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lIgsa5b+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VOSiGtGG"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F55222566
	for <stable@vger.kernel.org>; Sun,  7 Dec 2025 18:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765133282; cv=none; b=b49DKp2kogsIbzVqcLgSF1g4tHz8ExhaHg+O2k1OJbYYu29W98YlhkCJZMUVq0ZMhQhb2uBTMweyqRv9vQJXASj/GgvVKpWITOHJXTtk22p0PRZqW2W28a1d1RpHJgVonux6BaUBRLS29OJoVTKmwV0omGBl6N9MspLHpwVn0js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765133282; c=relaxed/simple;
	bh=99Gj2YbTy0YpE4/Veb809/fFjY2R3O18i4PyhLXjrZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LH5VYBSmNxaIx31GLWwujiW0s2efaXt0aky69DLtOGrfHbq+q4NXQlxwp4Iq0K1th5vkwhm56UEe6sCQl+cjEKmV/ojyryv5Mdcdg/QXj+pJ1go7LaccXRztCYwxb9YTvR6rbps2r7GiWXs/ljrmDB/rxQOdL2K2shGQqytwB0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lIgsa5b+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VOSiGtGG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B7Bh3PU1784323
	for <stable@vger.kernel.org>; Sun, 7 Dec 2025 18:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=881/hprY17FEAvnXnTzbVcRze90NUk4lmaF
	wZKgibbg=; b=lIgsa5b+TD6H6QRSbSjWaWZ6X5sxS8/dwOcvINLr1+qs6Bsv+2N
	2cUbGbC1cOzQrEjQDaGMwSALNbMJGGGYbkssViBj8alM/MuFBqnqSohFcL0J3EKC
	r/v/0AD83Rvwz2anmTMkI3gg/GgDGXaGaYBnbwGPQMAl6iLwl+wCtZD83BwVgDyI
	xk6Cfqg+8CAWNX6I/n9rLX82E2nCpQFlDJyY1CANRq4QcWiR6t0IgAfZ/uYZzgdk
	henSVmVd1Ab7+yqvHY1YvluBHksM8xUlViVI7DDsHXygbRzCYPBok0lOnjlidVNQ
	W7wy9nfAvWE3aEdozMFUzJiceZiuO3/sioQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4avd8e2rm7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 07 Dec 2025 18:47:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b2d2c91215so853137985a.1
        for <stable@vger.kernel.org>; Sun, 07 Dec 2025 10:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765133278; x=1765738078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=881/hprY17FEAvnXnTzbVcRze90NUk4lmaFwZKgibbg=;
        b=VOSiGtGG7Vu6RMF7vEXIGzroWyv+D0EachHktf25r+onmDEn+c4Glmtqe+yQceYPNZ
         H+7sWYtgjIpLsQPkGkD+9NkXpZaJcy6nxTLSvKG8PPus8+1cQRq2IiAvVgQ5gy4HQgth
         IjTzP5AQxOPcMFG1YjUfmpmwn8eODkuuEH77pObNX/KMbMjsHEv5HxX/VyAUpdlRvHE5
         o/dKrVIg6YFmGmFqR+VhEZOuNg9DtPzKvO7cQpJSV99jSaadtQy8HHa/fd7XfT0Dtkol
         RNajQ8Iqkt6X/h5DXc6FcuJstzDOXv01LdwSdw6oLxM8XWXI3ShcZ6dLB/K01vWuiHwe
         3DXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765133278; x=1765738078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=881/hprY17FEAvnXnTzbVcRze90NUk4lmaFwZKgibbg=;
        b=fqsZHgz5ogAHU+cmiz+ntdHpVaeCSLk+0dzU2cuYXtmz47RC0lY30bwW2qWxN/fqoJ
         Kl3iSBCyRCkVNDE/UYmcC31NZcxr7GcYy4hhY3ieTAd0DEHxL/mCEUJ4a4cRkiL1yZme
         sPgRpEklshg6jG1ytWOF4FQ3D7G5ELEVOnukqf7ZU74WnPdQ1SrKuqvPc0Q/8VkI0pIf
         xNegpgHTHozjyYfMQz9/LPqWe0jpLD5SR/AXJ22qN5bWgeEfMUMOWmjaOUSkfKO9zQPy
         /TLYjbEv7Zvs8TwKil079LX+59BFeU97ykqYZNqWEvFXPa38EZ2vDHcprVHVEcMJompe
         LGMA==
X-Forwarded-Encrypted: i=1; AJvYcCVsmmggpzorpiuA0bK/CYTG2ddqigvygsEISZrg5RwbBalVVa1huNbpi22g76/sz+whh4GiJf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZlmxMtUdeB6ZYfsUnQX5+zEct491b0PvTQrguJlOKQUsQiE+S
	MXTUw9FCtdy7wx5FOn8jwsGj+AUhVFnI/4HuTmHMLTxVRYVRaCcMiRwEwom1CQ6283B8uM3aP8f
	0KS6t9lrN74k4dsIkP21ej/G6xlMr6XwMD/aQXKmnTvsiELlQxKPB/pO0K7n9UEIeQMiFAg==
X-Gm-Gg: ASbGncuclfOXyd62eNZk/IHr58TSmhDb7IE6R8Du+0IM0ENxAY76yhfArI5cSOqX4+A
	l1Th4wIik/v9cQYNsoKdUW1EsgUxeCoTJ5bLUoNv2+O84Hu0TEn5XlQ2LNT/STM3cM4jWAfThu7
	kGzS3E+OsPx4KQjoESiSzavM4MIHaM6UZUZYszLgVpNDsgykSg89SJtyB+UC0OIf9+uP7il/CU7
	zLWfPERSW667mPDMQ2/yiLUYEs7XSQh1abyp7KRta5qFFr2UZeWiaw0WkYwYMUbdL7vSj/+h34Q
	5Q0l3S0Z8s184maeCaiXdRamux3InM+ub2LGndCGrEdx7ncm9cvOOdRZczWi1MxdH5iAzGjgCFY
	2BbW3KW8/PGxDRLRKw3VFMHy+HYqtXzguVvUhJxLCYvejyTOdhzoQPzKW02I+G5FAqZ04EQ5yA5
	Vqs8oJaDVAHWBrZQ/50wMh5jLI
X-Received: by 2002:a05:620a:461e:b0:8b2:e177:dda7 with SMTP id af79cd13be357-8b6a23f8a66mr820083685a.81.1765133278556;
        Sun, 07 Dec 2025 10:47:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQgReDwYNHorz6zJrslzpnkfHMnOvPOzPCOCqHUe8BRt+u7rtd5B4tRN/r64XQQxEvc4MdLA==
X-Received: by 2002:a05:620a:461e:b0:8b2:e177:dda7 with SMTP id af79cd13be357-8b6a23f8a66mr820081885a.81.1765133278117;
        Sun, 07 Dec 2025 10:47:58 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f4976732sm908585966b.43.2025.12.07.10.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 10:47:57 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        James Clark <james.clark@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 6.18 regression fix] dma-mapping: Fix DMA_BIT_MASK() macro being broken
Date: Sun,  7 Dec 2025 19:47:56 +0100
Message-ID: <20251207184756.97904-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA3MDE2NCBTYWx0ZWRfX0I3nsgStsliu
 AK89vLzDwZ952dBkkVnKM+Ou6SbOtdgp+mYtpNx9Vf+liXmYtPqFnr8blbE1BvKkpoVMDf8HH6o
 xhb1biiZuPTifttiOyAvOzUH1D6LajVYogu2Y7qoe1VVyR4pRZocpXF/Tsow2L0F0e0OkwDJf4o
 z/hok/AQUXcdlpRWrzGaOaJ3UtJEdtKu2ygkTi+TDzDJOdRuXFRisa82TEHG/bvCbZKbdg+heBU
 nJKg5EguOAgarOg9mGgl/u3NkPPqksTd5bNh+nmUdFugjHqe68C186Kj58cKD9tMQGzAsiOOsj1
 naDD5p29mU5lCD3hP3fJ4YtNViZ8sQ5H8rFkFXf3dToifdN0bTLGaKkfuoOGgaXckKYlcTMvHTC
 IVxfuGIR4bscz/q6prhDVl+JLrUsUA==
X-Authority-Analysis: v=2.4 cv=BqaQAIX5 c=1 sm=1 tr=0 ts=6935cbdf cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=MYcnY-1sr40wgOoaTGwA:9
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: aU43i_QsDuLq9iphbFgs65JdLmEiD1sL
X-Proofpoint-ORIG-GUID: aU43i_QsDuLq9iphbFgs65JdLmEiD1sL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-06_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512070164

After commit a50f7456f853 ("dma-mapping: Allow use of DMA_BIT_MASK(64) in
global scope"), the DMA_BIT_MASK() macro is broken when passed non trivial
statements for the value of 'n'. This is caused by the new version missing
parenthesis around 'n' when evaluating 'n'.

One example of this breakage is the IPU6 driver now crashing due to
it getting DMA-addresses with address bit 32 set even though it has
tried to set a 32 bit DMA mask.

The IPU6 CSI2 engine has a DMA mask of either 31 or 32 bits depending
on if it is in secure mode or not and it sets this masks like this:

        mmu_info->aperture_end =
                (dma_addr_t)DMA_BIT_MASK(isp->secure_mode ?
                                         IPU6_MMU_ADDR_BITS :
                                         IPU6_MMU_ADDR_BITS_NON_SECURE);

So the 'n' argument here is "isp->secure_mode ? IPU6_MMU_ADDR_BITS :
IPU6_MMU_ADDR_BITS_NON_SECURE" which gets expanded into:

isp->secure_mode ? IPU6_MMU_ADDR_BITS : IPU6_MMU_ADDR_BITS_NON_SECURE - 1

With the -1 only being applied in the non secure case, causing
the secure mode mask to be one 1 bit too large.

Fixes: a50f7456f853 ("dma-mapping: Allow use of DMA_BIT_MASK(64) in global scope")
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 include/linux/dma-mapping.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 2ceda49c609f..aa36a0d1d9df 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -90,7 +90,7 @@
  */
 #define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
 
-#define DMA_BIT_MASK(n)	GENMASK_ULL(n - 1, 0)
+#define DMA_BIT_MASK(n)	GENMASK_ULL((n) - 1, 0)
 
 struct dma_iova_state {
 	dma_addr_t addr;
-- 
2.52.0


