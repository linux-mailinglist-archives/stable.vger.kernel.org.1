Return-Path: <stable+bounces-167174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6996B22CBE
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18B8F7BA2E7
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 16:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097082F90F3;
	Tue, 12 Aug 2025 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a4KJ88+4"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC0B2E7BB6
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755014337; cv=none; b=RPqAFX1mgo0QfQydWyD6r8/hsPNxaWNhlr9H56D9ViWkouwNupXVOOK1CgRnSlG9AoUVUhGscb4ON6MwVDy6m5QqFwC0ugjWm8SdxW6sD0kom3RP5t3+fC0A5EDlRjBrH2igVneXXlj7gT0dHh6LBRQqd09CU1C8AktRVhqLMmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755014337; c=relaxed/simple;
	bh=Bwoe2afa48ujS5/V/Htdz14/LSDLiFIiSlrAiWittNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kpRRZ0KJ9AFIWdaDBz0v1TejALqg2T6qwtz5XhxwpdUfMCO9nWpynEQtVCS/fSa+ZGEk2geHm2h7Ibnq2NqUL0Cq85qpbuQASxxAlw2YC2oKFDjUrIC6Hc2NoQCvmj8lIr/3vABGfQqERfVavc2iyZUs2EOhK0XB9l7dKyTTB88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a4KJ88+4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CAvhpL021051
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 15:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Bwoe2afa48ujS5/V/Htdz14/LSDLiFIiSlrAiWittNg=; b=a4KJ88+4gzUNJG6o
	oVPZB7Mv8DydBsggqv1HnHpLVZwq4/ImiQALVaVDqhmZV/c8du/lvC6OkCiR2LJF
	X2QM7Pq5x9J2IESwh6oa/vuA+g2x3zrHNLMxvJkNnDwJ/vpRgIoZHH8+rMSeNWWV
	5enbPcX1umKliXnfHDKUUXijpOAm0SLWy3iKn29zQjPuRBMgpk6g667gg4kFs9yF
	igG0+AUtVBmdwzPAWf6aIJF9rJRl471nu04QcSHxCGaszkf2k3g7TM5+tZa/cEwP
	DKEz4CsGfSsUuaUFA8cNKYWdIClI68A+/5RIQFvOfGyrCePRYyu2rVZpcrW3t6Ts
	tQmSzw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ffq6mk44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 15:58:55 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b26e33ae9d5so9688210a12.1
        for <stable@vger.kernel.org>; Tue, 12 Aug 2025 08:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755014335; x=1755619135;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bwoe2afa48ujS5/V/Htdz14/LSDLiFIiSlrAiWittNg=;
        b=E7zWtnlvcgQKC12L/MM/tMqt3WffRQ+RSPk8P1AOr3VRKRJc2Giqo3c9CXdZEmFi34
         aPCWb65Ze4HQGW8mhF5qgeYMCLtQIOscI8AwVmJnKkfABgyeNpbUljtuMV33zFibcCa0
         6zSfPDsLk/rD1NTR4zJy2qma6KujjeuoATdFahKIGXOlgus64C1L9qTdJU4y5ZWKln86
         T+wmkC5yn0xFIftEdhsqGLAqC52oB8K3K2QdEnFsaYeeon+w1qlzG9XkOQQkUtjBHR9O
         XZuUypXHR24aIMOiWMweCu2kynXqXrNcjiNvuqUsbrtzBbxKYaI2FQInIA+/qJTlHnht
         YPBg==
X-Gm-Message-State: AOJu0Yyea1UbmKliSKwVRVXbqA2QmA9H9MzR5jlfNlx1L+gzipQEOuju
	IpOPVfDvqOhiO5vMblXyJxizbB7naC4FcsXJwdUFOnWJPJNXVuBndHYxzzqEVRitaAf2Ytu+ttZ
	WBR1kHpO2cUT/FjjfmeeE93jp/l5GgW5JtYmCfWEANGeV4DBH3YQgZ6v4qMjMqj4hb/Y=
X-Gm-Gg: ASbGncs6Cp/pm+ojOBNffvdQc7VfhlD7z+VNUxujOAA56JTWRqJlGYCoPeA5p564NkG
	Bwbk0OIJrfLlHHJcxAF+6sFRNK4Ulg20VVGTR10Cj7hVC2B+AUoalweSVV7W5ypDprIlEwhb8Ty
	GJEFwrI+qereYB1bxlTfTIuWVOpiJFi2kypLyGIygXxVNCjds7Opxiu/MzeF29DSWDv7S9+sIVO
	1KyvCFffvN15OvsxJ3ERYoe2akuZYnLUC9RG4NtSeCVhorXA8SzB/FJTg7Av1MCwYyJQpDzn0jT
	/vM+PwAUXxNczM1jZj/Y4OU2ipwbIl1BJvRprqCcpZFeeeZBVwLZZ49SmXMeLab/XGqVr9pvyE8
	MVt86YyKEe6yg9BGQaDlcpJ39hCmvbjxW
X-Received: by 2002:a17:902:e889:b0:243:47:f61b with SMTP id d9443c01a7336-2430c11e1fcmr2768155ad.45.1755014334719;
        Tue, 12 Aug 2025 08:58:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiaUWFnVGiPrNJ582E5fBjuSnhYrZtVZiz62WpdkRWMNIBQq9NnLaAArmOWl8WWLjz946MSw==
X-Received: by 2002:a17:902:e889:b0:243:47:f61b with SMTP id d9443c01a7336-2430c11e1fcmr2767685ad.45.1755014334227;
        Tue, 12 Aug 2025 08:58:54 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b423d2f4fcesm23976159a12.33.2025.08.12.08.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 08:58:53 -0700 (PDT)
Message-ID: <053a7887-c08d-4272-8ada-cf4a008894f9@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 08:58:52 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Stable Request: wifi: ath12k: install pairwise key first
To: stable@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gregoire <gregoire.s93@live.fr>, Sebastian Reichel <sre@kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>,
        Johan Hovold <johan@kernel.org>
References: <20250523-ath12k-unicast-key-first-v1-0-f53c3880e6d8@quicinc.com>
 <aFvGnJwMTqDbYsHF@hovoldconsulting.com>
 <2d688040-e547-4e18-905e-ea31ea9d627b@quicinc.com>
 <e23d7674-31cd-4499-9711-6e5695b149c6@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e23d7674-31cd-4499-9711-6e5695b149c6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3NSBTYWx0ZWRfX1hGKvRRyKzQB
 REMcZ3DAKwvaQ+Dcpovh51wKGkhpauP6o25OXxqk3ndApjmGfWsPc5Ie7WkdatFTr7LfOYe/hL9
 mt8NpFvReRIyDLe1R7rFd6gv5b1NNieSZGrZFBdckgrhJg4pyEC/KYRoK8vUxISk/miI631x20U
 EHRJnm/WkGYxE2yNG+BZ7TBPOYlC8KWUEAh1hRhVsdZ9sQ7oLobttbHb8poX9PoFc5w+kfmyI0p
 n/rEzSsV7kp8YySBu5nJ8rToB9rZFCF01+kdmPmMfRO9Tx1yZUkSb7f/15RIuYe1qOnbulOk3IL
 DfQPMHVKvHcYtbfAuReGkG+rjuNmqHTkf0eoDoXJxgoAP4E7pVoDB+zjGY2YnGMxOvXFg1SB5Rq
 l7I0uxje
X-Authority-Analysis: v=2.4 cv=TLZFS0la c=1 sm=1 tr=0 ts=689b64bf cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=mWBu8RyEdIvK9AmNwbcA:9
 a=QEXdDO2ut3YA:10 a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 7-4J319Fw26kgITDV5SsITt_STi11TTg
X-Proofpoint-ORIG-GUID: 7-4J319Fw26kgITDV5SsITt_STi11TTg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110075

Stable team,

Per https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
Option 2 (since the patch was merged before being identified for -stable)
Please consider the following for -stable

subject of the patch:
wifi: ath12k: install pairwise key first

commit ID:
66e865f9dc78d00e6d1c8c6624cb0c9004e5aafb

why you think it should be applied:
This issue impacts all products that use iwd (instead of wpa_supplicant) for
WLAN driver management

what kernel versions you wish it to be applied to:
All LTS kernels from 6.6+

Thanks!
/jeff

