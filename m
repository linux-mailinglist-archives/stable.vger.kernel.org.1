Return-Path: <stable+bounces-184125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C2EBD1587
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 05:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 723FC4E55B0
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 03:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40AB27FD7C;
	Mon, 13 Oct 2025 03:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OsiHS6h/"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC021274B2B
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 03:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760327972; cv=none; b=fz4RhhS17+waJEztTJtLEj1AdUBfuCU1tsr2Q7045M2xUCjyzLlEkRkR0HkOr2h/0keBFikwTwaBCjOB68DgN08tx1UlvOspnDe21j981YLAHzQVM+Yl1oLJoHfQe/9KjKVWqrY8HKlMAIvgTFCxhyXxUiTHamtqOMfH6MXMVcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760327972; c=relaxed/simple;
	bh=4s97OXsE4t41H2WY4gfLk660rhvi503He0pOltw2Gjw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sb8iA0CJnY3ml4L4i7bJ6Px4CaPVeFjmXSnJ2tPvC4ZrmTtX//AZ1ib/Xj8mjSQn/AEcepfLqBcS07VX00Ul3LIaYTtJw7QGGyuilBeYcoOAtZvtu0A7GBI17iwvHXVDwjGxhcw6xq4srC0cnXCy7dW/NHo9UVtE1zAJT6edhQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OsiHS6h/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2n8Jt016574
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 03:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=RMNDKKR886AjMuufIuUKdsSR0GOZWJ31sPM
	ac5ueuzg=; b=OsiHS6h/PXetzJ68Vfd9KrL4bPcXsezkfZvFDHjSke8nPXovoLs
	5NYN1nzjyGwUiXfHvaGbSBOPB6jswbuVxAnRGFpfa22wPFFX0htfrKNS4gZ4+XM9
	PmwyX1RGR/HwnfHD6jyhHe0g4tbs0SQARIC0VXaugmoQDOrcyUOPyrcar8tafBKY
	t2WuEJ+MzNXR7QCh+1BfMFQC8bLMWQ+odcrLPTSI7/f43HlgVBVMx+RR1IjzkbuI
	19lCun8l1FUssEUoHq9KeyLTiURdP6Bua6GMZM1x228w7+8nlfFVxRFc1hJoYfhM
	OcH5AFCCtU5cisdBb6KDljlDs85DTgqBvFw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfbhu6eq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 03:59:29 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-28d1747f23bso79232445ad.3
        for <stable@vger.kernel.org>; Sun, 12 Oct 2025 20:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760327968; x=1760932768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMNDKKR886AjMuufIuUKdsSR0GOZWJ31sPMac5ueuzg=;
        b=IqDh2aAgbZpnwaC3fHOr/yo61a97BG0Wrab34t57U/FyitqW1DrqK7Xtqa26qEZ0wa
         oxdvvzl1GVrp8fx7D4rkbGM4BgaCVjEgcgu7G90RNHUOzw/k0B2bxamHhNuJmW2Gbk3C
         6xUZMl1web+GmblhV+3om3XUDrsfHa/S+tfBCYh7+5T7ALJOBjIWVJWoMYM316y0ufC6
         u6tUsu738Gl6tUddI3uVVMhTb6ErovnDyLJ77H5ZfAm20JNKvIudRki3Nwr1c5jhjZKh
         7KZuBQdbbXuAyAKNL6FyNzCYHdau4Eh21UJAMkULAiiVyv6B0hRtF/6qnp2+jLc/Qetz
         nTtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9ewCZd9YJaSzfeu9W+9GZNmvSLwhftOJv53xM6KmQ+XONXXP4y8CQGZP913+8dI/7d20MZvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNNITeDqAB3vib7bktPzRsJL+ty1ZsQ7u7leYWhnhcDKmulIpq
	h5uQlOeWijs56bbpx1kjDTfMzKUtTBzUz33OVwpwedbVtFf3EG+bxO6UA0bpankJ4XzGWpmiI6p
	o6xtv30XhjTddtx+X99vGCsc0UW0fXG+SO28nk7j3xdKnyz723s46Nci+YfQ=
X-Gm-Gg: ASbGnctKNpaMoaPA5jc7hf5GCWCNALmPBYORxf+TDB16a5qciZMqiw0hO6wx+x8dU3r
	a1jH9a26bJKBhAcAwFGcrzKR6JZ1IeLegluJ7b38u4ZdWVdjr68awYPRR58OWPHaWo49vEQutbc
	hGenHJTne67jV2dHT4edMOzjIlULjTQKbNHC+We3bo3w0nVgnnmhvX3hNvQK3YA0Em9N4Tfv4VF
	ErbVg25W5wJ6V18JLuh9nGNYrvo7aYMRNq9JRg+WLVvlJdlEDvdy4ZSDQu6eiKoCr4ASJ0NTOCm
	l3uNI2FV2VUB5/irDXZC99L7NYPgr0E1EjfGUl2Ing+kZe87RkXMFVnycVtEEtfa1lsU/S7e18m
	ViA==
X-Received: by 2002:a17:903:40cc:b0:26e:d0aa:7690 with SMTP id d9443c01a7336-29027402c79mr221611355ad.41.1760327968213;
        Sun, 12 Oct 2025 20:59:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHVGLZBxpNB4H/Xm0MJmTnYuQju81RnfMPIBs8IrHHp9PZ9c6HxbnrwU84W6QcEl3NEorCEA==
X-Received: by 2002:a17:903:40cc:b0:26e:d0aa:7690 with SMTP id d9443c01a7336-29027402c79mr221611125ad.41.1760327967714;
        Sun, 12 Oct 2025 20:59:27 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de54c7sm120732305ad.10.2025.10.12.20.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 20:59:27 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] dt-bindings: usb: qcom,snps-dwc3: Fix bindings for X1E80100
Date: Mon, 13 Oct 2025 09:29:20 +0530
Message-Id: <20251013035920.806485-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX8FOTEcMzRDwH
 Pq0ya+IHkus81LJE8zgmBiSX3x4s7Jm+IeC+NF8G1M6z0mc6E0OesOVGeoVcxhWb2yCnO+CgdBr
 RzF1wMPQvz1sstji5r76mCi+gGDLvdQrhpYSF7UaZVt1F9s7PckbqpE+7QIJrmKIz9ucNH4p8rT
 upAhr+JCW7OuEMMeYTjS07RhHxS51PIE9mS7ZK8fGUJfNZtIoh/s0gvGu8KNaoxy2SDWLmckok+
 OJAQY+xG07heL7wmsv+w9iksa5fqjnoBHwrAINe1ByWMkamhB5wVUTIaf9AXFplyl6h7r7glwCJ
 zqNE/zhHsmHP20hAAoz5bp8XtZMQ3LJROvZT7Mgr6VAmOxBNl0oi6dEwOL2rl5ANn4LJRK9dwWm
 z7TZ5LzRWVqSLVWCcSBfQI2AeFLniQ==
X-Proofpoint-ORIG-GUID: aNCqPVN6VLE2CbIPC3ThPs5e7z7DJrq0
X-Authority-Analysis: v=2.4 cv=bodBxUai c=1 sm=1 tr=0 ts=68ec7921 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ojRqNddluEt3zInEAqUA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: aNCqPVN6VLE2CbIPC3ThPs5e7z7DJrq0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110018

Add the missing multiport controller binding to target list.

Fix minItems for interrupt-names to avoid the following error on High
Speed controller:

usb@a200000: interrupt-names: ['dwc_usb3', 'pwr_event', 'dp_hs_phy_irq', 'dm_hs_phy_irq'] is too short

Fixes: 6e762f7b8edc ("dt-bindings: usb: Introduce qcom,snps-dwc3")
Cc: stable@vger.kernel.org
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
Changes in v2:
Added fixes tag and put error log in one line.

Link to v1:
https://lore.kernel.org/all/20251013011357.732151-1-krishna.kurapati@oss.qualcomm.com/

 Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
index dfd084ed9024..d49a58d5478f 100644
--- a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
@@ -68,6 +68,7 @@ properties:
           - qcom,sm8550-dwc3
           - qcom,sm8650-dwc3
           - qcom,x1e80100-dwc3
+          - qcom,x1e80100-dwc3-mp
       - const: qcom,snps-dwc3
 
   reg:
@@ -460,8 +461,10 @@ allOf:
     then:
       properties:
         interrupts:
+          minItems: 4
           maxItems: 5
         interrupt-names:
+          minItems: 4
           items:
             - const: dwc_usb3
             - const: pwr_event
-- 
2.34.1


