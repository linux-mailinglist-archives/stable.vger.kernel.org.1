Return-Path: <stable+bounces-200961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A949FCBB91C
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 10:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0699300760D
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 09:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9A54086A;
	Sun, 14 Dec 2025 09:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GCw3f4kI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ezi9pN+z"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF203B8D7D
	for <stable@vger.kernel.org>; Sun, 14 Dec 2025 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765706022; cv=none; b=Pl5Wqq7h+jvMhPfGS4dp6Pz+csyeyIOUM15Jxk37NzLX/6iyejlL4HiEmgMxXG2OgKa6OFZU0sb3YD1TNr4xi/2REmnO9Xx7c/KaB0mx+bWiKpVwb3++kg+dLGX5knc6QuF/nuLiJTQpf0PzLKmP98/mvs3dUV2XmRUZC2SAD+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765706022; c=relaxed/simple;
	bh=yRix4HBV4lwRUVbomVKWdONuc43UaJjNv8M2rHlo9a8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PqDutzyo3cW4X0y726iZUR1hvRk8LLVyx1Kq2PWXXi4sV9sKP9gaglsNbe9Evlb8fG6rDtVeu8lrr6g7dcYkHa11i8MM6RmFcO/j0SzI3wIpkFYz67hxbJaqq/yEFVJU5vcIaL6ZOy4kUbMFAiopB2lUQb8DvpmHNfBGsN2pWQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GCw3f4kI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ezi9pN+z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BE9FNVM1693682
	for <stable@vger.kernel.org>; Sun, 14 Dec 2025 09:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5235ls+xPB72WCWspoyqSm
	Quf3lV5z5gLhJd0B1fNxM=; b=GCw3f4kI/lxljdjDEqrYwU4SfQo8VjDSQsFj3B
	sFnjBGSr0mMfU5GdYMIDHVhkPg/brdWEYTA+NcjtAAxCHVlemauHabiK7x67QKXT
	G7Q5yvH5nlj02DcADIa4to7fqEutHCCsagj0xQ201p/McJmTLRbIrHsXDn4PNS2i
	ioPIuzjzorY/hs0Ng5roWOaUvpAB4AKLcOoy5lkH1LN2oAJqMsGNkxIypMzs55F7
	rTK8Qng5beOLdkn0FujgYy/j2D3dD/AyuQ7zCcAtZQ+RytebwxFvIRp6UMil/LRj
	QoxNClJrd9ErjF6qohBRzcV9HqjSmjAlxD9t6oMc++8UZKlQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b11ds9ss4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 14 Dec 2025 09:53:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b22ab98226so807321385a.2
        for <stable@vger.kernel.org>; Sun, 14 Dec 2025 01:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765706018; x=1766310818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5235ls+xPB72WCWspoyqSmQuf3lV5z5gLhJd0B1fNxM=;
        b=Ezi9pN+zsNYUHumzy+rwVTZ9f6KT6HJFHfFimmDa7ZIKl8lXmSgBGhHS6QPXcE+hGQ
         j/MXACPxtD6uSpScMIg4wL0dkg7UYJCqGXMzF6LrutJH/aUnu0FLVOKEOAmKPTCnvhaH
         PNLPUiUE1vDes8QBjY9VOMeRI3Oemaz4oNip3dnNYh96JnsAyFeIC7UOk+92AF5yGV+o
         /d+PvWTF9QdF82drPeLqaeVYbfbKh0eNo8MJxG3UCfDajhNdBLrnhMBrAiteCVlIubHZ
         MWCdm9y+hDBbvorfShAkay0iP+wxeCfiPyOWNK3JS2Pq0nZ4V0rLXpQerxAKRrSIcymA
         3u5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765706018; x=1766310818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5235ls+xPB72WCWspoyqSmQuf3lV5z5gLhJd0B1fNxM=;
        b=gtgVJZKmt5Vb1NAIgyUp/hXXclLAG7uPYIiSr1pcvxUw/LXI97TqzKEbp2OvbiaYEX
         l5lAxspDJyoeLXy/MgxxxHeVBTIoXRrLsLFMroSERoI+K2ptn1X0DwxStgQ/ocDaN0Zn
         G0muop9siLERAJ8CY2oY4qWZChZwCkQRcBbOsJ2pq3se5HI3v6c6mLYr5438em0sKONM
         QmyBBmyfTfXaOYZSGhQ8byQ2iyA1M39ss7oIlhEHCbxKLF4pxX6ovwwgxA/HI8zGkoTI
         GoPrii+v2BLJtRBQQoGRF9Kmto89K0kpWTvISvsTS0rMpL4M2c0GjxfLAtHSae24256F
         /ocw==
X-Gm-Message-State: AOJu0Yz3gHrB/XmN5eHfeWdojYT9enGmWwjin9mw038yIWlx4+1cGNaN
	FL4ql/cU51nx4UxL5h7o4bI54n0S+hydGTz0V2fT5gx2R4UeJBX9uNrwpqPx4hH3iP4osOZKv7l
	Nk8FIP7KjVnbLErtPvtTJ13KyvSLzHGwGroUMmxFA8ipm3q7MQTrKkVAo/4+HW5zTa80=
X-Gm-Gg: AY/fxX7+8/0luG702tgb10I/N9L9+shpwZ4suGooshpM8LbSkRFkNK4veAV/2V1ZfSX
	pMGFknZB9hQBql/i5BGlsF3g/+CwUTHp9s+etA2jPmfHWh//EGBrObWM+auvrX13JXJKr5f3FUD
	1zJte+2YYc5smEpv/jF/+p1nxv8bIxEhiilGWBuUjFe5bSR/dFozPoqQSE2nP3dHuqX42fJHQGu
	RiziCwNF6NJBmwhKqO+88fTNdq/wsfIGw7hLaSxLgNVdfHZszgZdNWFLp8esxzLBo4/NBWjsBIL
	tQaXCvA9lcYEQ6/Xbl0YTexZxkKAZ0AlkZv1eK3Y568U0YubjW3LhntmUoPLP+lUHvbkFIUY7mU
	G5wJ/DnIdPW5228/D+9wsrc7mtaiI6VsvNunW6DXy9XM6Gxa5p5V+z8xvkGtuj0PSW3QAuPXoxj
	elXVeMENnmkWepJ80qCOXRY5lI
X-Received: by 2002:a05:620a:1a08:b0:8b2:f269:f899 with SMTP id af79cd13be357-8bb3a253e9bmr1005324885a.56.1765706018475;
        Sun, 14 Dec 2025 01:53:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHntpjsmUmdvd0VAKVaqxUxrBE4on+pTAkpoLZoJlaY3Z9yA9Ff6/mGJeBY0RfU2ieHlg5tSA==
X-Received: by 2002:a05:620a:1a08:b0:8b2:f269:f899 with SMTP id af79cd13be357-8bb3a253e9bmr1005323885a.56.1765706018113;
        Sun, 14 Dec 2025 01:53:38 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7d0dec2a8dsm920625866b.29.2025.12.14.01.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 01:53:37 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: stable@vger.kernel.org
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH] drm/amdgpu: don't attach the tlb fence for SI
Date: Sun, 14 Dec 2025 10:53:36 +0100
Message-ID: <20251214095336.224610-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Joqm88dn3bhgLhnsM7JE54lRgrUNfKR-
X-Proofpoint-ORIG-GUID: Joqm88dn3bhgLhnsM7JE54lRgrUNfKR-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE0MDA4OSBTYWx0ZWRfX7YrbXZCbPxML
 Xxz9bff84wg8WV0of2fMaznSeScCduZOpPeuPJ6CiIZJ05I9mlxoT8r4cFda7ZWlvRn/S8Is7fs
 iYTaqy6EQyMK5ULUjcSetmY7L+MK21jVY9sqg5xzKr0bfOMkGmMRxKZyvZR5kQ4RpDB9niSFw0j
 +Nk13sNwkVTsZWh0CC5DCUeeWkZZfMdw3ubPBPqL12kiVy8Segfe+5QKh+jP/JlQIjmOSRlrZ1S
 7Ve5rQ1Mtc8tGIod25ibazBvJ0Aey8jeJLkA5jQYt476NeizO6rpvlzQn1y1UaomtdUKqVAZSAD
 1BtAEWBUxFxZTuWpibqz6TOu+l9UCEveBDynwj2rYsSqSTYOxIaIqidS/1c4WZCqx7tuQLNENhp
 tRBYCWxOcpPMJ+WLlKN0sPVSWHTLuQ==
X-Authority-Analysis: v=2.4 cv=cfLfb3DM c=1 sm=1 tr=0 ts=693e8923 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e5mUnYsNAAAA:8 a=zd2uoN0lAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=gMHgr3dq0RqCgoZVo1kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-14_02,2025-12-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512140089

From: Alex Deucher <alexander.deucher@amd.com>

commit eb296c09805ee37dd4ea520a7fb3ec157c31090f upstream.

SI hardware doesn't support pasids, user mode queues, or
KIQ/MES so there is no need for this.  Doing so results in
a segfault as these callbacks are non-existent for SI.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4744
Fixes: f3854e04b708 ("drm/amdgpu: attach tlb fence to the PTs update")
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 676e24fb8864..cdcafde3c71a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1066,7 +1066,9 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 	}
 
 	/* Prepare a TLB flush fence to be attached to PTs */
-	if (!params->unlocked) {
+	if (!params->unlocked &&
+	    /* SI doesn't support pasid or KIQ/MES */
+	    params->adev->family > AMDGPU_FAMILY_SI) {
 		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
 
 		/* Makes sure no PD/PT is freed before the flush */
-- 
2.52.0


