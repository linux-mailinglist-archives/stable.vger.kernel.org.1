Return-Path: <stable+bounces-202928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3A7CCA67C
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 07:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00C9730161B1
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 06:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4E33115AF;
	Thu, 18 Dec 2025 06:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QxCecsCm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y2T0BkP/"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4276277CAB
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 06:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037972; cv=none; b=Z0nG5rXrxqBgxnv2mQ/mVAZf2WC8PR9uJNXbhcU2PuBDILfzSPRX/yJTCs8ywPAu+E+I/4XpRo/W8Rim8G+tuJQ2BpD5u4m8r6FemcyQkMmBu2LNxRK5T5DzIeihLyM9EeSbMr5wOLk5Pce2FnXgzbwTuxYHSBJsMshMuQZNJPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037972; c=relaxed/simple;
	bh=lg4ux/qXMXWcEAofVJDj5W7+6fuplHF5ggyU43Des8w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sfZQhGpONlnKBE4mMqXOLcwT4TFkC3jQQ6kIjW+l1H/1/iuZ8njRhx2prsHrl7ueJBlxxf+YUQE7NKGSg8VWRC9+0BRw5+gMCRwSzn0yZR0OWW3srWieDGTVyR9Gj+v0QuztLNTd5DPntcdmtougEnLAvNR2Cemsdsni85imyeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QxCecsCm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y2T0BkP/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1ZOc54191699
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 06:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MjYhNKTKp8oFFQ8K5luAyAyOx4SBt2zoxQ2yTKlGYwg=; b=QxCecsCm8onLOGsa
	iYRpZfZiryUV3xxJbjbOgke0QbM4opxOYcPEVwXZJV+J6iQ5c97vIfoDKSbkI1Lt
	PUXNwL64GTt59o5LufgUq6mId4uitv+4lZG3M2yFQTpMh92fOQRIpfCNhUjUwXmY
	OYYqlDwA6dz5gZ0iY/H/SIUldhAK2wEHE9UpBtxf2ml4sECXDmk//C7vfztHgOt4
	zcGfiXqtvMO2cdgttRbkzci2Fl7b3xK+RhKuNIzFU6eMiyq4SHd/3rdwilaG96FD
	HqMadCIPCzg7+MgNBYuMMymq4DWITBUljMrXgJkIT4hknAFMA8cGLyDZGTcW1HiE
	ZxiLmA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b47pkgpwj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 18 Dec 2025 06:06:07 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-29da1ea0b97so7502445ad.3
        for <stable@vger.kernel.org>; Wed, 17 Dec 2025 22:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766037966; x=1766642766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjYhNKTKp8oFFQ8K5luAyAyOx4SBt2zoxQ2yTKlGYwg=;
        b=Y2T0BkP/E+FSa/X69D3GmzST6mN4CRQidain+iUfB1q/mF9R7gLB8D9K9Kcq4fLPxv
         ajeaT3tM6BW7sh8iuPvQEouHcn8kRrspcR+rygY/W/W2lPTjecn2ATfKNHOWmC6iujVt
         rE7pw6HXyOJoeX0EB2Y7cJQSJC7+Upxqt8zW79NOmgw2bM5v/p27HK2EV0ERGpaxakIG
         b/N5Nff16NcQxPsNRb9v4Q32lmGKtLBk/VaBv7emb7GKMPHTzt/6hOPny9r30r/RnRFd
         S35e2zCJZ3MkSqpsrnIBfDxqWlKoDCWpMq6W218KmI3XFQwBIGRIu/gWjtdho8mwCUZL
         5bjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766037966; x=1766642766;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MjYhNKTKp8oFFQ8K5luAyAyOx4SBt2zoxQ2yTKlGYwg=;
        b=T3s4knrsEX5mv9N6NPm6mgVZlRq8uejIiojPtdiW2HzYt/TjPeqDqIYbyMrbGMfhS/
         tCREV1W075bbsORDHIMQLfVsmnvyT87Hf5v873rXQQi7JHr+SenkGG9sOHNlQc3dMTtZ
         4Lu6K17igYrr8kEO1mx/SDXnc+Zdo6fraAxpQwLe5pgkMItQKcrvvJ4AklQzjuPdQxau
         Wds0JSbrcQ/JBZNOpRMcFjyooucegApWf31U8ClhPpZLRJUkQPENqlEV5C/c8tQ9CxP6
         AlNRZkMUcxnS60gy33R9FxKiTZyF5szVhGTjclWSlDQC7CxMqmak5YXAOsCrwj/x/JQv
         Qdew==
X-Forwarded-Encrypted: i=1; AJvYcCVOOqfkqKoOe8cZ1CdgvVUngTGofm8WIedIwyNRBG89bUUunWOPyARF0MptRGiJ4TXY/iy1xMA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1wn7icxc572//L5g9+lnvSm/qBdmf+z9ABZiW1tWknMBz4/HO
	+D4YMS0Cwllo7Yv2tCs97b8wPBdkuZB+Wh3HTRUqaW+8aLVRc0etphOkJWSk6A95l/t/XncdFEA
	Q8O3MHBEBIqqqmIXH2BbJjVE3r1vPzv9/gsiaATrsyQV29pHC4UuK38ttgb4=
X-Gm-Gg: AY/fxX5DhY6x4dC3cAde2uNRNAnCtaBhCU7/TpssymLIS67XrzxNIzSig9h2o4WR3L2
	ENoZzUfgSOQ2KU730qw8tNnI++EzF1y/APkQ2FpKj7yOJqgJGMXfsAU3tE7FfFmV+FoOVEqZ9LR
	7jNqMAFyedEbGhmjPNX6oJKep1aTHo7rnsVOlcvQF0II3b8XGWy0G5/KzZrhDIB4AxpgfvBGOcx
	4b9SRB5jC0aZu51FqYg7apzIP0clCCbW8MuJj8Md41+zyEwzMzNNZ31+kGYVIWnAbHKhKhNkInR
	6r08xueZ1/lNV/dEhccDFs6SPelHJH8DEa6Usqg2WQwgBOut3z4tQWZh92z7zpulFJ1BcAO9ipB
	4GUSEGIMIfIU=
X-Received: by 2002:a17:903:1a2b:b0:297:e3c4:b2b0 with SMTP id d9443c01a7336-29f244aa9e9mr223285705ad.54.1766037966505;
        Wed, 17 Dec 2025 22:06:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXtU/Jq12UVhDJn8i4aPL9g1mtUoYuWCktraOpSdZBnZjjtbDml3pnPWFQ9a/qS+c2uVRDxg==
X-Received: by 2002:a17:903:1a2b:b0:297:e3c4:b2b0 with SMTP id d9443c01a7336-29f244aa9e9mr223285465ad.54.1766037965984;
        Wed, 17 Dec 2025 22:06:05 -0800 (PST)
Received: from [192.168.1.102] ([117.193.213.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe13d853a9sm1307489b3a.42.2025.12.17.22.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 22:06:05 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Yue Wang <yue.wang@Amlogic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linnaea Lavia <linnaea-von-lavia@live.com>,
        FUKAUMI Naoki <naoki@radxa.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        stable@vger.kernel.org
In-Reply-To: <20251103221930.1831376-1-helgaas@kernel.org>
References: <20251103221930.1831376-1-helgaas@kernel.org>
Subject: Re: [PATCH] PCI: meson: Remove meson_pcie_link_up() timeout,
 message, speed check
Message-Id: <176603796183.17581.9416209133990924154.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 11:36:01 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: DJ6-Zlwn0y5xSEjt8N2OBFdWHBiuhzvd
X-Authority-Analysis: v=2.4 cv=Md9hep/f c=1 sm=1 tr=0 ts=694399cf cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=PLOdWElDzbaVVj/XHNhp9A==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=zrTfyjHbw98hyAFYeIwA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDA0OCBTYWx0ZWRfX6eyhp2vvLlu3
 fgnHs0jFVFGW4dXG87knDpDh5MAvvtSwVKpC+I1929uMuPYL5irKgVGAuxOZbHA8WP8Brx8bH6h
 iHB/1gDXh/zIOIiTlw7jI1Gnt5C92cxkpduocvtxAiRhhUFI2HSSu4W3klRx6aDBWlr4yQL4Y0M
 pUtP7PwnDmEqausgnLUbRXQwUQQZAqzp3qEk9HLTSO4KY0nWgxH1zC/GGP40wv8xaQptPEjIXHZ
 hpDAk7jWf4yp4R5be2AhnpyYJPSdYOUiaLKccltt2rJOGAM17I4KtFSB9wvSM7/S6jv8av+Dfa6
 FuYGZJXVUbaM05yxwXEhYyfnBP09mlyslB8Aa+HKkeA11/I0Q4lNcA7oMbYX3aEBKqaY7KyfjOp
 bP+N20sxrBKz3S2HgcZmhLbGmQB0pw==
X-Proofpoint-GUID: DJ6-Zlwn0y5xSEjt8N2OBFdWHBiuhzvd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180048


On Mon, 03 Nov 2025 16:19:26 -0600, Bjorn Helgaas wrote:
> Previously meson_pcie_link_up() only returned true if the link was in the
> L0 state.  This was incorrect because hardware autonomously manages
> transitions between L0, L0s, and L1 while both components on the link stay
> in D0.  Those states should all be treated as "link is active".
> 
> Returning false when the device was in L0s or L1 broke config accesses
> because dw_pcie_other_conf_map_bus() fails if the link is down, which
> caused errors like this:
> 
> [...]

Applied, thanks!

[1/1] PCI: meson: Remove meson_pcie_link_up() timeout, message, speed check
      commit: 11647fc772e977c981259a63c4a2b7e2c312ea22

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


