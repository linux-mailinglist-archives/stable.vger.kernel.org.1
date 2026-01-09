Return-Path: <stable+bounces-207881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C74D0B0BD
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 16:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C77FD309A9C9
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 15:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A7B36165A;
	Fri,  9 Jan 2026 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NAbJAxGv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DFCMO8Ji"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3925A35B132
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 15:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767973524; cv=none; b=f+0spnos8r6Yh9t6p9qfDAAHKndYO84NvmQ2aLlyrNQSMSC0o08NsvCpPLNiGBGc+mI6x3IrnIrt+N2Cv4tByP7xfKBCAXKRLd4okoilyAmViTCES3rq1JndgUbooetrHjThPmEX+UzGBBGnBqNL5BdrFWLVgRQ/bymS7WcV+sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767973524; c=relaxed/simple;
	bh=M00mJV5cMuXtrKsplXWVdp3Oup3FNSXlU8GS9iB/sY8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eC7oOPqH663dNeQPbtJp+2l2CYzGTKszdfMyifhiV3D/t8CjzUuqIkjbDiMRRLqfXXhuwkAeawrsCCouKMh8hoeeUK9jUp2RGoJggFJMd2vSz/U2035MQPkKAhSyPDDRZiVilQl2j8OrlicY5zAVghPjBf8xchxpVfuZEzFGfM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NAbJAxGv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DFCMO8Ji; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6099LYOi3324821
	for <stable@vger.kernel.org>; Fri, 9 Jan 2026 15:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ODQQxUBDpSSDgzBzbSVqkcIEt6G9NnCCFOxruI1fiGg=; b=NAbJAxGvQwDZ/q2P
	5JzMrRFta+br5cDLTu/9D8n5IxGxRQwYDIfhtkDuyft0UJpD8p9FwrpvGihax7Qs
	jGiSG5qz7Uft9VXtBcx+9cIYiI1zV7qcesr2D3QZ6Qf/ZbjDWa9AzhNt9CrP8eTV
	3FEXgGbNn6Lor9lzJfzoUjot9svR2N+mzNCqikymTRf45Z5g55pykAqVfhB/MUZ9
	gevF7Szmlz3V8b13NaUli7YppqIHp3Tsqb3AV884koR4GINrHjZiuwWOs8d/HrbS
	spGWSAiwdN7Mig9UmAYpIYWNxGpiIHPwBbmCTg9igfkJshg2RixalI/BGnKTTA1O
	eSLmJw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjrd6jav3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 09 Jan 2026 15:45:22 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ae56205588so5028702eec.1
        for <stable@vger.kernel.org>; Fri, 09 Jan 2026 07:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767973521; x=1768578321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODQQxUBDpSSDgzBzbSVqkcIEt6G9NnCCFOxruI1fiGg=;
        b=DFCMO8JiMQ8Iw0NqpIpjuf/Iyylp6nF4a4bGJ3H6+Eb2Fi/6NquW7icve0jShhPtqf
         +ZYupQlirmCicUsSuRdGuBhKFj0s/GJS+eWv+8ljsFh/3f3yF5Fq598bl3Pr4hjhR3rS
         rS3yTTsutF9yCFz2tp/G+W8KsszklsRuLSOmPdkC3qlqhhS5uegV99TvXIMlHH2ISzz1
         +ePdvH8set6A5PwO7/C/10ivm1pIofQ65fSJLvONKuAKevEBM8ponXoCKcuixUjwXVxi
         OtA0mt0/FhgopdslG6XhvGdmKIcOIFtgJzd7pDkpit4zU3u7E9+xv+r/TSa7UGB8yFrr
         yIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767973521; x=1768578321;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ODQQxUBDpSSDgzBzbSVqkcIEt6G9NnCCFOxruI1fiGg=;
        b=XiAGJJSmAOzEbcqlE+lJU7QiLOfAMJbaaVVziN3CToX59inf+Zp0Q3uJ66ErWl431a
         NY/h6n3hu0iNxaaUuOnTuw0mC8E45eT8t3eyf4cnugXjs2EAS+G0BC4mwgOJKxPKxfce
         Z29YdkAJgZ57kapMcnLUssiskhBKhK/KPgJxh8oIJL2JPV2Nq4d7TMhOtVrhvrHiIuR6
         oZyhchJK8HVFk8VTLqr2onEnxUBJqzI/RYK61g4uz5ac2VcwUAE7Xzsdv83TVXP/boQI
         rf5cDnoXmw/aSmdDKrkKroCUTm4ibPcWLWRBnkyHrgQrVxUd/oBtibGCzHgO3KbNcuwS
         WTXQ==
X-Gm-Message-State: AOJu0YxdGJPxQztDkwWDnEORIcazbpUEau6FFHuTL/61SRBfk1ZUe38N
	imXQ/mlEBvPKiVM02W/1Wznoov5o4M8Z92ytL/gdesPRKXqVeiSdSAyjONmDRWSkoAMmQ0GXxki
	rTe/+PsT7AlxEaswTunhIuId5LhbM8vRpo3dCynN6ZeMzBH5BkhAEl6L3BhAgCmNX9lE=
X-Gm-Gg: AY/fxX4vO3Yxk91fVqeMOlSPg8XECIglTpt/EzjUBMjTSs+CgfzaQHUStjBD1YGleZm
	B35gQPHImuYnDVlOqNeIh/jnUqLCP0E4MGT7dVaGfkUYqtbyVYhtSJgZ3ODWVEkaCa8XqJZXeZr
	iM7yXsR7iZiMVoSSdCP5bF8iHrnwsaVgDBesy0jVIbv1rdn64qGviUcmyif5m69BTPqeAxryZHA
	VFBt6myiq7KTY+VCQV+FNM7ys6pldIOEavNdYlO+9+ky7jxO8jDO89BEhDb7w4mwMCxrrM626aB
	LTw7VF5bjfYwtBdZrLmTQClDjttHYOzDwZ59fC60YPMSE4u2MWvKkCLtd7KLGAukcONoqFnI4tw
	0D32SSlyLif2oXzVBPkNE1j2mhjr9S5nD92ECJEgJRsxRNIcRsRb7xkqRjW2ym/Gy
X-Received: by 2002:a05:7300:8290:b0:2ae:598e:abe5 with SMTP id 5a478bee46e88-2b17d321a6dmr5550957eec.35.1767973521395;
        Fri, 09 Jan 2026 07:45:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzeEmToM+pLvDD8pk/75vshZI3WatO3trU2XnbBkHWqxZ/l7rfFBwfToAGPYoY73ncIV7pYw==
X-Received: by 2002:a05:7300:8290:b0:2ae:598e:abe5 with SMTP id 5a478bee46e88-2b17d321a6dmr5550940eec.35.1767973520863;
        Fri, 09 Jan 2026 07:45:20 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078dd8fsm13212585eec.20.2026.01.09.07.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 07:45:20 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Jeff Johnson <jjohnson@kernel.org>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        Sriram R <quic_srirrama@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
        Wen Gong <quic_wgong@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260106084905.18622-2-fourier.thomas@gmail.com>
References: <20260106084905.18622-2-fourier.thomas@gmail.com>
Subject: Re: [PATCH net] wifi: ath12k: fix dma_free_coherent() pointer
Message-Id: <176797352034.2503774.14369689269983981548.b4-ty@oss.qualcomm.com>
Date: Fri, 09 Jan 2026 07:45:20 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDExOCBTYWx0ZWRfX7z27yGGn0OIX
 G09gofcrTX7leIlXycSL2e/WktUYgV8o4Dz0oogzZNIj0n71ZWIQsAqEEdbJ9f/eavkSMs13bkW
 JhmvHu4qRbrvZ2YGV8zeHVvWZ53xP/1ujMjCqhJLLduocejMY3ree1yQHBIf6/Fo55vh9kmVyBy
 +IRehn1b87Yg0pKSSGfHTHVLqQVNSjOqPJsIDyBvnGXN1T2qkfRjX2GQZxiuufXgnRjkd75hFm+
 YkCdpUTbTW2vntiUpCbZvHYkMZBzsGGdhTEiqYR6Zpzu3U5gqbmtCyqk6xm3tKDabdl+OE0rR+X
 X4G/Cxb3ypsXzHXqxHAvufT0TC1Se0cH7tgtmz2Fz5MgWCOTfYrIhuqmGnI2sSdI+i4AwCYlakx
 b9hFyPp6P2c+Mm893NYGeQNYyOGbCc4c1f1xoYuQ3J7DFpWiHvgzOSE0elB2VW+ArIDVo0m9UYQ
 lY3any3azD1nbJdbqBQ==
X-Proofpoint-GUID: OLE4hpVT5x_lqk93mrHspqKXySw9i_tl
X-Proofpoint-ORIG-GUID: OLE4hpVT5x_lqk93mrHspqKXySw9i_tl
X-Authority-Analysis: v=2.4 cv=Xtf3+FF9 c=1 sm=1 tr=0 ts=69612292 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=WD2RVSGR4ZOmZR8fVjQA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090118


On Tue, 06 Jan 2026 09:49:04 +0100, Thomas Fourier wrote:
> dma_alloc_coherent() allocates a DMA mapped buffer and stores the
> addresses in XXX_unaligned fields.  Those should be reused when freeing
> the buffer rather than the aligned addresses.
> 
> 

Applied, thanks!

[1/1] wifi: ath12k: fix dma_free_coherent() pointer
      commit: bb97131fbf9b708dd9616ac2bdc793ad102b5c48

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


