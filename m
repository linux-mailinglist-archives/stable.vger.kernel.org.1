Return-Path: <stable+bounces-207880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD47D0B0B4
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 16:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F49A3092A86
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 15:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D935735BDDB;
	Fri,  9 Jan 2026 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RJ0nPA9L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pm2TViZH"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706B033C53A
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767973523; cv=none; b=Dt9qlPjp2PmCZKHjiDU2ddP7SjT0Na9+wjrYfxAgFILrJCC7gyNM/FjrBmk4CAifcelXvV9QXMFK7OL724o1ZjAjBVWhZCInlWxeD0krAoFpP2gAUmSyUfdcjo7NndYaDfIKCfJRuM+OuCG5d1d9P6SLt95AG+1PFDidaMb4Xio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767973523; c=relaxed/simple;
	bh=/kxt9hwuoRtRTjsG85IJrosVAPdkJurnFJfT4gD70UQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A1uhYvovYSLZILu2ybRbW/vHYe+xp/92+LsBCaXOLYwbfizeUFUL+MuHWxw52KSP3EbfuYVpPGDBH90vcLUpXKzHXEjXtdEqd8vEzh80Qcp8Cy0PmZNdQs5frFZGwDe+5EIXzk1CYtTNiL3Z76jwASfQnqStgP4JP84bnkIGPvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RJ0nPA9L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pm2TViZH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60982XgN2184008
	for <stable@vger.kernel.org>; Fri, 9 Jan 2026 15:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nHa/kWbVVsFh5MJgGzVqkCaAwCD43l/Fqd48BAH3J7Y=; b=RJ0nPA9LGlMRIOVg
	EmrvOIQzmtGHJJn/gjY4ekKt9LrISXnDZXMfMUCq0HT66grayhQ4lqgxIHESvO5z
	AFkR1fk+y50g92ALvixMZ+D6iXGph4q/oSvrHWuHNRJiyECopqR29YV3FMLLCA10
	rSPNxdzaj4EclGO9I9NsLjKNeX6eZIX72L2TnMDguACr/rmo0uEKL/hEqxXmIUhN
	GqvpvE3BLvHZ0TUqx66rUsY1zMm0Fki8WmYkIFgX+lhXNnnN7cu5e7GLolwlnT9M
	6c/9Ue/vhx9bBwqBnzFilZrDWpThta6qqZM8nKCh02iHwfkCzl7TNI/hnMNBmxFB
	l+mvlw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjwtn9c5d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 09 Jan 2026 15:45:21 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-11dd10b03d9so5210913c88.0
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 07:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767973521; x=1768578321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHa/kWbVVsFh5MJgGzVqkCaAwCD43l/Fqd48BAH3J7Y=;
        b=Pm2TViZH4zMBhuzh8bKUxxrcU1flHhjkMBoSuIKgWRx2AniaW1OD3Nboj1Yka+/BDb
         X+gaqUwZJDXC97bd7ZhvNXWhWIXK4C3D50siBZPd1eajp6q9mxwAN/oXxBnRgm5gIxIv
         h7jtFgcAS2H4jG0L/Zaf9b8sl+NosajjXAQ4XGcxjPIvxHDyF/DmPiwjDQk5+zzsRnId
         fnG4X389BhgryZerZ8ANHtfG1rJPJdjodZqhRFlDhJfBUICugI2Wzcr9+9c7pe332g0+
         sGUUSqNz2pvEj78sq2VtGBnTfHiihqTFjpVeAEBadCHvSYra7i1DfzojWfVNMw/teFc+
         P+SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767973521; x=1768578321;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nHa/kWbVVsFh5MJgGzVqkCaAwCD43l/Fqd48BAH3J7Y=;
        b=SG/2pQLlwzeEn83qr1GRElcVDVG71w4N11kdIL667Cs4UemaRi/EwctmejZ/zjcXkH
         7In0Y/Re+fhp1nlVPYBR9t16SexYbpblmy3HGN4WC0lwdji44qlKvpgUVHEdZvqiN2FK
         RK4ik0gBZMhV+BTliVnl/KNaR/WNptQ/0UI/t2NtEm1/y+Q4qWFcqrCYx1jUxMV9giVg
         VNgfkTzoADg8V4U0UV7qfXRQVnvpRLhT8bkhzEyoMRLd9nLx3+jEJdoE6W0ic2SOqFyG
         IKgyEWdPneRV9Qis9cC+n5rd7kS94ha7W+rZKYkF4HMxXobAUC7FWRvYnrpTUXs75E8c
         GWLw==
X-Gm-Message-State: AOJu0YxvrSq3PPXw8K9Kk9iru7GdcuayTCrt3D8RTHN0TQ9SsyhqxcXx
	0+4HSXf+FHs4E++sdHdDZr1ZckuJevvLlh5ge54THkmRMxvI9/1riJ6kgrbwG3coiDShJ9e4mDS
	xSqi2HvuW0YoxALtjGZ3w3mW5Tv6AyVqqQiLDTRTdjOTduD6kZZ2Gs7WQoe4=
X-Gm-Gg: AY/fxX5Odh9EBgJcXn2TNOi57FXseA4K26Q1BDmNArzLmmlxQl3qz9Hu7xeSIjHUPda
	SsUDrpuRWy8cV/aJVDFMAY9xuQZ+3rODuiyeGPdk/YYBc4b7cGl564Xyy2LRteUFPPeJ7OyqTku
	TLgpBJkvadYD33jk3n13J3sNNyPJW10JaE+OI/w5JDl7Nz7EPe/xdnMNXXSj7Z2oS9O49Ir7Sj9
	E4ZMpsGL+neUjaWoxUbxE4fSz7xMcYv7pNk8sZXYerShww4FN3QAr75Qo2vlDV+ffAEqUGYvmk2
	pTZFiqvylQskLE6XgRw1bj7RwME6WWSB5eC6ataHrF8/Gq6XUmpaebkZ5xOmdrm1m3V5jmhGQUw
	jNd5dBq6PIKVUk4+zQhthfKvMk0tA+JrLJFTnSkM3ExOCmar3/2KHRO+qwq+ilLrr
X-Received: by 2002:a05:7022:d4d:b0:119:e56b:98a7 with SMTP id a92af1059eb24-121f8b0e570mr6528116c88.14.1767973520698;
        Fri, 09 Jan 2026 07:45:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyfybUnTYXdEVn7jn2X0VrvpXDZNh8Xo7RoiuvPAkiVw8+WZXLaMsesD2RtWgTmwgmYfJ9Cw==
X-Received: by 2002:a05:7022:d4d:b0:119:e56b:98a7 with SMTP id a92af1059eb24-121f8b0e570mr6528090c88.14.1767973520160;
        Fri, 09 Jan 2026 07:45:20 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078dd8fsm13212585eec.20.2026.01.09.07.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 07:45:19 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Govind Singh <govinds@qti.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260105210439.20131-2-fourier.thomas@gmail.com>
References: <20260105210439.20131-2-fourier.thomas@gmail.com>
Subject: Re: [PATCH net] wifi: ath10k: fix dma_free_coherent() pointer
Message-Id: <176797351961.2503774.11852026073709227675.b4-ty@oss.qualcomm.com>
Date: Fri, 09 Jan 2026 07:45:19 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: kAqJ9lukMf_MIod7_ACpd_D92Ax0-fxa
X-Proofpoint-ORIG-GUID: kAqJ9lukMf_MIod7_ACpd_D92Ax0-fxa
X-Authority-Analysis: v=2.4 cv=Uohu9uwB c=1 sm=1 tr=0 ts=69612291 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDExOCBTYWx0ZWRfX1dtvbHBt00Lq
 NhYppqGd97QT/MjwI3uRW8lquhSf4Mo9d60ZEdRfpQkq1ibx0vJW/wzOzCqlNOR6fyBDQea+lNF
 z66KIkB/KVtDXCMhP6U+IikE2XpNIlyS4L6KZDlTwQhAX7v4uHUAoc7D9JrFX2P1EAK8bC6wsoS
 glxos+Vmqvri919I+ouhXrH2tn6knccQfOzXFakUuHr7P0eh8p5LIK91D1eL8zrAZ/1Qi80TiKi
 cLQBeO3NjuACVaBkp3SscmQgfbeFsGiMSjIDSC9Pe2mr3AaP/wuJP/T66TCn119SSeXOHvaMuZm
 XoppKmOikjpQPFzQX/o28AybTGSR27Fsv3ED83xnIaM4+7mPnBnkfiu1obO159trjbceSiYtWOO
 vRrUnf7UsEo4onFRnM+A22mgOGKBkgyx6+53auidop78J5L+nlhE/Kfz44wtMeX43kLg3pKTE7N
 UlLS/plDiGhz4NCDW0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090118


On Mon, 05 Jan 2026 22:04:38 +0100, Thomas Fourier wrote:
> dma_alloc_coherent() allocates a DMA mapped buffer and stores the
> addresses in XXX_unaligned fields.  Those should be reused when freeing
> the buffer rather than the aligned addresses.
> 
> 

Applied, thanks!

[1/1] wifi: ath10k: fix dma_free_coherent() pointer
      commit: 9282a1e171ad8d2205067e8ec3bbe4e3cef4f29f

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


