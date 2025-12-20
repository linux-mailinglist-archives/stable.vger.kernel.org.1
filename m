Return-Path: <stable+bounces-203139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA3BCD2F8B
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 14:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2E58300BB95
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 13:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48EC22B8BD;
	Sat, 20 Dec 2025 13:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ghrky/DU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E8v8kb9G"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A931B424F
	for <stable@vger.kernel.org>; Sat, 20 Dec 2025 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766236209; cv=none; b=NUiD2hK7MnPqdzvWz7KuVVFWAUFc/rvUJIwmS+XFezyDU8zokIUMSJ4/eQ/OwFzdvKh1ahfkiDwjm5ogPHgiFjQs4MB0tCzuOMG8M51bQolCpEroiK9x12hnjru8jrqnJIFBIueyn0ZV5TgzKK1XbgjL+2WZWqCzOV+IiVuH6EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766236209; c=relaxed/simple;
	bh=1mwpK5IoaqpfArbE15ldatCSfDAlxPiDFfK/NSwv2oA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YkxN9jDtngT0/F9gN8vtdlB7tudvCzoYhRSdFnTEjlmaf6ytSEYTZzrvkHPyVlrwJA87WElmkUweqFx1CiLE7QRYnXG2t12gS4FLxA/tLZPZpb7ejK+Aakrtjp1PDaog6gvYLoJUvCuiv/ZQ+9x9a4l1llAxSe/Ru+XeMT+TfbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ghrky/DU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E8v8kb9G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BKBP34k4136507
	for <stable@vger.kernel.org>; Sat, 20 Dec 2025 13:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3EKxyQHhEmIyekzRDVuKML
	coVZ4rKnm+ECfXSwJjS3w=; b=ghrky/DU3O9qmvx3L+LSTAHzfZuhAPoIt7klan
	U/XxmlAJXxJQVvB1kpRNMi2XaTouxl1muhoRwKAn4sWKeThTGpwsrIgMLsDcX6MX
	j/rbNDPLwXR/hhQbxuC9/xo/hpzEj2B0UPhKV+mg0A1Tup0/Eep0JgzBrXGnSNMI
	ACh4x+0tWph2PeeVEPbWpOc7X8mv07Rvf2445AecI2j+br4NRicd/oJafYE1Vfx+
	T2I/dQ4NjFgZw+waKO4S7d/lZa7NPWldmUf5os4iFt+beGTU04kiKF+vwJx+8jmD
	kxI8sI7eNV7+v39UbqiEBrSu2eBvW7GHWX72LuQY0t3boICw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mvfgnrc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 20 Dec 2025 13:10:06 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee3dfe072dso67727691cf.2
        for <stable@vger.kernel.org>; Sat, 20 Dec 2025 05:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766236206; x=1766841006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3EKxyQHhEmIyekzRDVuKMLcoVZ4rKnm+ECfXSwJjS3w=;
        b=E8v8kb9GoFF+g2yZLm3TNojuxaezQd3g0kE+Y5JMwkX2PFj1q2eDpB4SSKVMhqGPxG
         oYaMBjb2226XEOTD4mDQgTvCimC6piOZo4Ov4bC2zzq2+xNK+nVECkHTSPI+3P0weGi8
         uFSLRtIr7+bJghlkbmiTtoT695T0NL4aLaTDsd6TrPnzjeGYBhuVjt0uuz8Ob1YfWv8D
         qL6Fgop2yF8onOve8TQshsw/qcTAtB8FhzksWF6R0TOwDIUb6EzpFcMFa/yNmuLiWe/1
         ijnvIL4ziV69TmxR2FPA1CBSYXwOdb7tG1totJ+vrY7UZe07tqN04GlKe0XriakTAhUn
         /cSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766236206; x=1766841006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EKxyQHhEmIyekzRDVuKMLcoVZ4rKnm+ECfXSwJjS3w=;
        b=I8OFUFURwfyf7V8abxMKaolabg0inWpuUpcb2aHUxFiLbxfzWy4FDM9F6cBwBWGhKC
         F0kv32fT8dMsFVEF9wg3LQTmgBIOKd+JvDuSGri8b/nRQqYIoAyUklYKziLNA/gjg3bk
         mxmnGmEg9Vi/6idbpE3H5oG9QwVskw4RIDsWfHsOPP70ipbEKvMVTyYXNs/zsL+mMl50
         5kMNbdDndbz5ghgYe/RUXm8Ipf3h8qZFMZVA4jXcxNaPejtmddNTlQB0oewNsEY8tv8h
         9vzkgXHDATpkeD5pIWRNFxH7dv07+g70CPWVhQccoDpBk7/DSaVEN803loVWjBxmfTtn
         0Ctg==
X-Gm-Message-State: AOJu0Yxe8XaLbT9h37Cgr8DlGBa44dR09EbsZaBYlA3k6eW/hUjJcAA3
	NVKy2rvo/wnQkjjRFLSzbtcIUiNVWAVwHKnO/ZRSBVCLUubjCsJohBDIrLAEB374/Tm0JC/n7xZ
	3Bigxdjzj1rcu4x2oud0n2v1LP95Iu4osk0CZvHNC9ayKGx0fK0FIuVG5+0npLSz4mGk=
X-Gm-Gg: AY/fxX7vs+TTdSHQPeXR9l3A0SLN0fgeAuro+iIm2qJ59lKhx7vesMXnIyQn70DsdVQ
	MUoRww8IgOmgaOqNAIut0HUKIjAXjSPkIpFHXaw3yQloX/+IoZEN7/LyGZ6/qppqquPgkbzirtl
	ZwxCk4G59dmUeJPHpNyX+b6C9dB+Kw9ofYv6O1ycw9qKE/idj04WXkoThUhzS20dO3PswmRa4OW
	dqD5LShdfjpLakqTdGApV/ArNDzVhXtbgQLzmciVgN33A1QqMomN5tv5cEshnj3T+zFIBDaVDe2
	A5CAvOAg2Xf3tLorLEel4VEQvbPrf/kyrtvtCpCpx63FmWJI9Q4LWveFP5FZgo5yq7XupLK2z7Q
	sZOKlYVlQFn2bMSsfd1MYIfsLRxeVJEqRruFKdygjspHcaXynzjWVIuotEdUXZqywMcXYbATb7F
	HjK9RXBUf1AUY2P9UNYpyAcacb
X-Received: by 2002:a05:622a:230d:b0:4f1:e8f1:cbda with SMTP id d75a77b69052e-4f4abd839edmr84274081cf.54.1766236205817;
        Sat, 20 Dec 2025 05:10:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMc00ncJWb0KabCZcLVfYIj57YGRTERvvVntL3jkAE8zAHY8IRTE52tFtdugU2xCkTW7vVDA==
X-Received: by 2002:a05:622a:230d:b0:4f1:e8f1:cbda with SMTP id d75a77b69052e-4f4abd839edmr84273571cf.54.1766236205298;
        Sat, 20 Dec 2025 05:10:05 -0800 (PST)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f3ffbasm505386566b.61.2025.12.20.05.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 05:10:04 -0800 (PST)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: stable@vger.kernel.org
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
        =?UTF-8?q?Viktor=20J=C3=A4gersk=C3=BCpper?= <viktor_jaegerskuepper@freenet.de>,
        Sasha Levin <sashal@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH v2] drm/amdgpu: don't attach the tlb fence for SI
Date: Sat, 20 Dec 2025 14:10:03 +0100
Message-ID: <20251220131003.283999-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=H8rWAuYi c=1 sm=1 tr=0 ts=6946a02e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=e5mUnYsNAAAA:8 a=zd2uoN0lAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=gMHgr3dq0RqCgoZVo1kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: 7pGlzxxJqVcuD01XoyAHC-FkrKBVSKki
X-Proofpoint-GUID: 7pGlzxxJqVcuD01XoyAHC-FkrKBVSKki
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIwMDExMSBTYWx0ZWRfX0fuEVW5FPpDZ
 ImsJ9JS0cYHh09dMFg9aN6PxZV/Zc9jEDBuSf9qzylRaEcmNWn9y9f6gQ3JS3PUOwD6zVk1I9Hs
 4ClZHy4H4E84CURxJjEpReeIqiJXeX0KtuAtGx4Sjf1xGB5P6A/8Xkzpx4N6XdM2qLZFBRAgvHS
 sHv8wXs0sQrxfY7RB6a1zpHgrVciNiTVyTiZ0jz3Dex0w0OhxGNn3yJAiAeT4LoRUGy8JQBljz4
 /5rExkanraYf0H2De5T9HzO/Dl9v5pt6ZQUH55Gep/GyYze+KabMV7q5fIk6DSs4VlWEVld/r0V
 Ae3fHr6q0rtlgoGJ7boH4odg7Qpyatszr2c2VtDRx7e4rLIsHN+uPJvLyc94fkFrlQUJa47q9dy
 HTsY0hk4LJgBp78K6jN7fd6fjC07Ejg5GKFO+0DJQWJ9aFsfpjypRkOwSQJ0U/piFRsFY3DKaly
 BLYR8g64cAkiPU1aGqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-20_03,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512200111

From: Alex Deucher <alexander.deucher@amd.com>

commit eb296c09805ee37dd4ea520a7fb3ec157c31090f upstream.

SI hardware doesn't support pasids, user mode queues, or
KIQ/MES so there is no need for this.  Doing so results in
a segfault as these callbacks are non-existent for SI.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4744
Fixes: b4a7f4e7ad2b ("drm/amdgpu: attach tlb fence to the PTs update")
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 820b3d376e8a102c6aeab737ec6edebbbb710e04)
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
Changes in v2 stable submission:
- Correct the Fixes: tag hash which is wrong in the original upstream
  commit eb296c09805e ("drm/amdgpu: don't attach the tlb fence for SI")
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


