Return-Path: <stable+bounces-238736-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AH1GHnoO5mkGrAEAu9opvQ
	(envelope-from <stable+bounces-238736-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:31:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2273C429F08
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BB2C304DC87
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 11:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9352839DBC7;
	Mon, 20 Apr 2026 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DpR26zgw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ESGhnY+w"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4208B39DBF5
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776684661; cv=none; b=fwsFfOC0HkUzz17jQdSD+MlEd8J1nrYh/UWKe9zILi18MeN3khvN0L9XVJLHyEoC3+pBgWhEXC6YqhDGKfCx60uLRQC+z/QWWHlzLULtuIxoZj8gqwipAxMhX8loXCkRwugiyTpAvhvk5aqDr8fXYpqGI5yqeWMr/RyWCOLUNwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776684661; c=relaxed/simple;
	bh=Mtcv4O+SsioZzYTwCA8bJTfBJVkqokYIJCvhBtq48UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kC2IJuqnpHCb1NJ/6AssEXo9DruNjf5iCtu1AOPzKEV/RB06SqQfz1avQRwSy8AMrctCUkYHFTToXbhb8U4qe1QvaERX9OleUYFTxkrRZqQBQphUVlqv9rFuJOmiwyzTU8mh8IheHfXbAkdv1dXc4iSYWqRytxTMdDziUqOFYI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DpR26zgw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ESGhnY+w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K97EFu2755817
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 11:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rJK3tyKKPOULevLlFyeKOFJs
	OKc285YnQNkfp8+aIFA=; b=DpR26zgwXBk7a2/d90F0Gx0wPwYlrBXd+AfxtVTx
	a61u/PudqIxo9PdozPWh8q2BUrmBgVZH6QD00xB1l80ia/JkU0DEFeMJVZbxTo+i
	GrB9cNcD2pU5QjKM461MDDosHl72ZrW4HtJYLQ3s0o3E4SiBxdQF6LicxNydxjao
	OLHQPT405ls2U3BgPhpg/dJ8fLWmV0QEb4hNnqVDf2xgRXyxJOxIlf8sv4QWrxkZ
	VdEWL8fTkZ3/o5Eb/LwKG36y+qYP2zOCDJapmBkFKRPMU+IQPLyABQPIAa1TJVcy
	UZBrMSmjsSfCTjjqKjgWoQaSqK/8pGcEASTx9V7Ch8mLzw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh7xgfub-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 11:30:57 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-56fa1c1ae6fso5048556e0c.2
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 04:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776684657; x=1777289457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJK3tyKKPOULevLlFyeKOFJsOKc285YnQNkfp8+aIFA=;
        b=ESGhnY+wNj/j8HMCzQbv+5eKTlHp62B86ifkEQw3FkjgXB1U8ssXxa5DO7gnm/ThmW
         p6dk9PvpBX5uPR+jrb/LF6hoT8Kw0BuaWlEsf8lQv/NT1jmBNbZGJctRf2H7MTXeN46s
         w+9y+UDJwRveBC3Lx777ZkPIvSXq0FWwuwqSSWXe9d5ldLpz+IHrHzrGaVuHDhae6UFm
         bFu72nY+FKedn30TNjspOad+OxzhqAyPhVT/a8FWgnXLS9n5ae/4wmGoAWg8tl7/htSG
         /t7azODd0NY9NXDxYQEuLD2d/TcMR/gUyUEh4lmy5SayPYS3womPbv9kHgVcUsA5zyaK
         t35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776684657; x=1777289457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rJK3tyKKPOULevLlFyeKOFJsOKc285YnQNkfp8+aIFA=;
        b=GJofNPeE6zpK4dusYRYbp/RA7bSGZ1oN7+7xss0Ak6ybM9+IejCrhyzmg3oRDx+1oJ
         Bqq42oHJjEedYH2zk2GLU6KKFzp0LmTleQq6uUVv9c52vKB5OpNI7dxeiRLq7/BvYsYH
         RpsSm5cWkCraFPuGdounca+1SyLxOWe86vtWzR19FIZMpji60HO/yv6usMivYaK17TZm
         u/l8FLoQaqNVg7xzLRcXnU1Fqy2UZq6zKOB1v9LI1QkrIgXmsznTS/gmymyGp8dcFz5l
         bAG88hHDON1tMbW7yGlAsqM1vV0159RrxKVjeJvgYCWbTd9N35Ti9A9TaAc6pmhU+h9r
         BGeg==
X-Forwarded-Encrypted: i=1; AFNElJ/m4NXHZY6aMROp+Qi+qC76ws+lfJMvR6PdVIn3kYBfihw/5GzTHFyampWIZo1XFcOrcH+kjQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YysYsd8IfML+qCV5kpO1+9vFilhTzaLqcM5FSgz0zbjLwMgatZs
	arVe8kKtJOp9UjRI3jXavWNwINRsfIfHfa6raa7wLzVKZEQLRvs7F/iLiKwgIKoeTndGDH87cHo
	CMvEFzzuzrEWVYGjD6lpE6bn641rhSN8ZjorbXv61tznDCU2O2JYZabjoMPo=
X-Gm-Gg: AeBDieuuBzDIsKaz5tcmIDPTBFKxP5PfVyMjttXwgx7D9cndF6sYf1Q1Cs6I3pQ69X9
	G3mW7l/gwdsN8ugtc9aRjl5BVvntfLULb3bnU3NZYeODqAbovxcP5cQ4AVT+s14CfsephlMTZbG
	ZH2OUBi8QJ5CWi0/BLx9nKBNTlN8G+itoBjDx4zAnq7cyqW51l9n/ZtIpQim/ylzOCYWCYhEjOE
	2n6I87UEGjTzAWBDb5ATHk9Bq2vZS4ZS9rdpgay9dmkFUfReu6yoWCUkq4VIdHt4iWjWcnBnLOX
	n7nXs5wGL6EtVcu48+GsOyo2FZcPOQbrKq7RD0yI+Ydphsxn1ZWPstBeeZWFK6qnR2gkKH2aHho
	uS4mXtmSUrLPjyZq9W+Z9RRqKxf2x4qBQgrfHJulSm7xWvCc=
X-Received: by 2002:a05:6123:2e3:b0:56c:fe16:f54b with SMTP id 71dfb90a1353d-56fa59b2e39mr6265124e0c.11.1776684656897;
        Mon, 20 Apr 2026 04:30:56 -0700 (PDT)
X-Received: by 2002:a05:6123:2e3:b0:56c:fe16:f54b with SMTP id 71dfb90a1353d-56fa59b2e39mr6265076e0c.11.1776684656236;
        Mon, 20 Apr 2026 04:30:56 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc100162sm302652885e9.5.2026.04.20.04.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 04:30:55 -0700 (PDT)
Date: Mon, 20 Apr 2026 14:30:53 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Nitin Rawat <nitin.rawat@oss.qualcomm.com>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org,
        konrad.dybcio@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        mani@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] phy: qcom-qmp-ufs: Fix kaanapali PHY PLL lock failure
 after SM8650 G4 fix
Message-ID: <iekd5fokqecsqzjtqtp7ai4ibyvs7vcuesxczndts7uvbdxt5g@g35hk4gwkypm>
References: <20260415104851.2763238-1-nitin.rawat@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415104851.2763238-1-nitin.rawat@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDExMiBTYWx0ZWRfXyTAEHihdUx25
 QJGbvUXkiM8BsCp2HH+4cU9ESH5ImzEJlE/KcKu0TQu6VIlMq9b4uA4YOnWU8gsVaTenz0sIzD6
 Q6m3nug+wnDt/U0O4BKrcI5AhpEu1Cu6Ug+XVtZkc/MbEJN0YeUnS81DU3wA7WTjqyIB1nifbpU
 QHtFZC9Jzg0mIECRDA28fzv6o4n9SF6EdnHU0LCp72SBh32riI5UfKleWiEQZGd6VpHo18viB5F
 QOBEQFgnuXpwsXVF66n/vljPhzUMIX8Zn0stxtFt8D2KKL9pG4M5ouoFRe8W6EzY3rLQPRP223R
 pkqBtzwe02Fw/3nb3V2+x+vRskxcNRZyqg+s2SzWu7I2OgkWALs0Pdf9qsLLj/xHMv+M24V7TPF
 kTUcN+UrbVKctxPPHJ4Chf6KTdn4+3JiH6rdQnCusPcaQH4BlBBhunVoArD86okit/ChfHB8tay
 FH21/FHnr1fIVmAAO5A==
X-Authority-Analysis: v=2.4 cv=BPmDalQG c=1 sm=1 tr=0 ts=69e60e72 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=EiYrS7xXfcF7w+nkr41hpQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IGLtpV1Bqx4y0bnjnHsA:9 a=CjuIK1q_8ugA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: XcPdkOhKFkXJAbjVdUeqxoHrC6nYOIie
X-Proofpoint-GUID: XcPdkOhKFkXJAbjVdUeqxoHrC6nYOIie
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200112
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238736-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abel.vesa@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2273C429F08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-04-15 16:18:51, Nitin Rawat wrote:
> Commit 81af9e40e2e4 ("phy: qcom: qmp-ufs: Fix SM8650 PCS table for Gear 4")
> moved QPHY_V6_PCS_UFS_PLL_CNTL register configuration from the shared
> sm8650_ufsphy_g5_pcs table to the SM8650-specific sm8650_ufsphy_pcs base
> table to fix Gear 4 operation on SM8650.
> 
> However, this change inadvertently broke kaanapali and SM8750 SoCs
> which also rely on the shared sm8650_ufsphy_g5_pcs table for Gear 5
> configuration but use their own sm8750_ufsphy_pcs base table. After the
> change, kaanapali PHYs are left without the required PLL_CNTL = 0x33
> setting, causing the PHY PLL to remain at its hardware reset default
> value, preventing PLL lock and resulting in DME_LINKSTARTUP timeouts.
> 
> Fix this by adding the missing QPHY_V6_PCS_UFS_PLL_CNTL = 0x33 entry
> to the sm8750_ufsphy_pcs table, mirroring what the original commit
> already did for sm8650_ufsphy_pcs.
> 
> Cc: stable@vger.kernel.org # v6.19.12
> Fixes: 81af9e40e2e4 ("phy: qcom: qmp-ufs: Fix SM8650 PCS table for Gear 4")
> Signed-off-by: Nitin Rawat <nitin.rawat@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

