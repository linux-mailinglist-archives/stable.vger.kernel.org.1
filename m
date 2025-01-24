Return-Path: <stable+bounces-110391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDB1A1BC37
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 19:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6D31636D3
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 18:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A9A20E004;
	Fri, 24 Jan 2025 18:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oHodCmzg"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939FB158DC6
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 18:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737743760; cv=none; b=HmW6ucOFfw4r9jPVNMQahiCMl9QC2ZT7pTKXw17uj+UkX0DtHfy7fs8+djIvhLsG9JK91OKN4yCWJTxeLQcjLFx9BJJtBxzCfTdglkhzDyhC6xqgy6WSskOHzDeXs7KVxShDgc/WBFoukJ810LEBh2Ix3GSMk0+U6mpEeponXOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737743760; c=relaxed/simple;
	bh=hUe5OoMnb67u5YUI4h/HSv3LyQlvHgG+tgbXO5/l9Lw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HIEvTaG0NVGNbGwEpZWR37Uc6F+5dk6D+UsPYulhYeMV/qyvtMqRIlJu5y6QJw4kyjDRbULIbbicH0DWyZ3/9TCF7ixRdV/p9GILNNhPzVfPoOTIFUtH2tMhuqM003oy80oKK2o0j38UrpbigooPvnI3S01jgUvGKhbxRds+0UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oHodCmzg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OAknak008001
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 18:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wHmAIxqURVXWtdtTWYEcXbv3gCxvkUyRVlPDzDmVyjk=; b=oHodCmzgTliH4ghh
	1mhL0NjWEj9oV+k58d7KvuhIkaqs0wkgSveQHTB9ybWiGc4hw2vmAjfc4U8kQ70d
	U4G8dW/DVk/JKLM0bXB8i5pY3raGzXTCtdF1tm6FK8IdZI4CkioVgm9S8uCm2FVK
	9B36dxtXRb2UvGhVSA4CFP6VzBn9tpjXEAAsQFgBKOUVPgjWEQKJyKX4IpdTd/VZ
	jGp4f5ghMDjFB7o2h3oo9Esdy4z7Vq/vnCpSKl86XaF90RaTDBZ5ZZMIjGfrwYcl
	8Xx/zvoDE8Tn2paER7KpR1ZqcFD7BsHtH7C2zkLSxX18KopphnnP6Cyr4Yrm2lkY
	RPzwcg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c9djh5j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 18:35:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ee3206466aso6535254a91.1
        for <stable@vger.kernel.org>; Fri, 24 Jan 2025 10:35:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737743756; x=1738348556;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHmAIxqURVXWtdtTWYEcXbv3gCxvkUyRVlPDzDmVyjk=;
        b=M01RRiOFNXeeHJRr98I/GH/XSEKK50vBwgTZ31AJo9MwonOlEkpz5dbNwFnZfV2DNR
         1MaNOMjnxG1LGW2LobHEVXs5AWRyjeLVuMDJEudOgVdCxj+yh5WY0jjKdY1ELDCami3+
         LwqM0aUf4LWzGPH5/GCGTUtH63YTwbZ6WJbQYQ+WSexUuEm3JGJY4tdYwyGalqSH4N+j
         pB/LF4O5EGO5iYkEbasarVPmksKMq1tM2o4l1mtgnSP7ehsKCQRdj9O++cS2eQpT7yqL
         aUAdQBwUBzz2VAExpdAg8Cl8rDZQnw04F5OkmxtITgGJEKUFhVdHFIW0wnl59Fexl8/n
         2RlA==
X-Forwarded-Encrypted: i=1; AJvYcCUTdujvUS1D4LbvZUxZiKuOgq7pbpo56qqT86BUDbW3axK/DfG59dU+a7sl6vtFDuTJ5hiFQsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM13OnT4upM20aLNobDj23Hy/a6NBiMndTh889ng9O52zvdotf
	i/hWgq2QDzaTwh4AoITSYufo7elhIcJHxqZy777o7XIlEWCISLn6sr5KyltXuiDV3WffbtwEWdF
	8/+DB7zY24rzVskxK8lvvMFKQ0NxKzM6UZwlCvhXmXZ/DGl8UxpTsPU4=
X-Gm-Gg: ASbGncvg+kM1waempj3j36IasRaOGqRDHeWcrF9pHRTdlW1KZCrKQrlOMAyfVU36god
	quBd0etTpMZ/Bp+2TZdRdSVmjuoDisQrBLsQo8ukTfWMfRmEnmDTWlJdESq7HJ3Up5awNGHisVk
	H6m+CKD6JqztRPI4vEomYWhIGmtb1xvPrqPpNYSB18Hhha8sy/dd9TU6qTpEccSF8V1+odZKKd9
	vqYK8/wu+IXE9TeKGyEvaod8n3iASBfNnOLCTVqBmHvCIJN49iqC1TIYEkwmkAXl54W50YviZ8Q
	0jOMBnyAOM1g5ieglsI5jNf7UGBE6FY=
X-Received: by 2002:a17:90a:e185:b0:2ee:cbd0:4910 with SMTP id 98e67ed59e1d1-2f7f172999dmr14059616a91.1.1737743755972;
        Fri, 24 Jan 2025 10:35:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2A5sqwh+G2JHyQhuyZNUQRQ8vdz2Rq12cJrIzFyu4bBH6D0M7Vb1nVgglQOkkMw1p2+8+Sw==
X-Received: by 2002:a17:90a:e185:b0:2ee:cbd0:4910 with SMTP id 98e67ed59e1d1-2f7f172999dmr14059586a91.1.1737743755629;
        Fri, 24 Jan 2025 10:35:55 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa83f8fsm2049632a91.49.2025.01.24.10.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 10:35:55 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Wen Gong <quic_wgong@quicinc.com>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: Balamurugan Selvarajan <quic_bselvara@quicinc.com>,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Bhagavathi Perumal S <quic_bperumal@quicinc.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250123-fix_6ghz_rules_handling-v1-1-d734bfa58ff4@oss.qualcomm.com>
References: <20250123-fix_6ghz_rules_handling-v1-1-d734bfa58ff4@oss.qualcomm.com>
Subject: Re: [PATCH for-current] wifi: ath12k: fix handling of 6 GHz rules
Message-Id: <173774375451.3015659.10376753884780529993.b4-ty@oss.qualcomm.com>
Date: Fri, 24 Jan 2025 10:35:54 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: lDHCLrGoDl04M4rNy7713GWDERXFrTss
X-Proofpoint-ORIG-GUID: lDHCLrGoDl04M4rNy7713GWDERXFrTss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=774 mlxscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240127


On Thu, 23 Jan 2025 21:51:38 +0530, Aditya Kumar Singh wrote:
> In the US country code, to avoid including 6 GHz rules in the 5 GHz rules
> list, the number of 5 GHz rules is set to a default constant value of 4
> (REG_US_5G_NUM_REG_RULES). However, if there are more than 4 valid 5 GHz
> rules, the current logic will bypass the legitimate 6 GHz rules.
> 
> For example, if there are 5 valid 5 GHz rules and 1 valid 6 GHz rule, the
> current logic will only consider 4 of the 5 GHz rules, treating the last
> valid rule as a 6 GHz rule. Consequently, the actual 6 GHz rule is never
> processed, leading to the eventual disabling of 6 GHz channels.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix handling of 6 GHz rules
      commit: 64a1ba4072b34af1b76bf15fca5c2075b8cc4d64

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


