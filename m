Return-Path: <stable+bounces-223187-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJuHN6JYqWkh5wAAu9opvQ
	(envelope-from <stable+bounces-223187-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 11:19:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C2920F95E
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 11:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E084830745ED
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 10:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1D537DEBD;
	Thu,  5 Mar 2026 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BRNFmW1p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E/j6XbOU"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F408372B55
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 10:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772705838; cv=none; b=lXFMZ2kkUN6YAprQO9qxfNbATyQKHQ1UZf2L3YLIL8kReiEi2iQoYU6gSuSGbKDjaGk4ZOKjIoZYcu+YuMNiIPOYVHbQigj11cNQWkU0IoEu1kV2nUaxqA3mz36P0C2UOrK5BKVQeVYS2DGu5G/dqZmiC/naxjbXuG/aKSS+MDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772705838; c=relaxed/simple;
	bh=pKtXrrBm5cADdMiIG05brIdEdoiEsw5uS/LfS5KfQBo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PFkJhgpoYDsyehuyILf8X/GM1mR4yzhMcqlqp5XAjqX+nyf8YUxKGEC/w3Oh3akStRU3vUyPuSxiDCspDcWbNgxDY0QVHpvYhaYafjclBt4zQ0N5oYhv4TcKa7q/EwsYZ1RQQWAF4oKBlJy/kDaUkECFDRZeDy3DIuM2Q1+SWGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BRNFmW1p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E/j6XbOU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AFvGa450552
	for <stable@vger.kernel.org>; Thu, 5 Mar 2026 10:17:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LIadV7BRF9LYFllJ7Yhh2a
	+90a+1bxS3+rs4FMEgwds=; b=BRNFmW1pIXDzhhRsEW/L6PpmEuBklvK+bnLtYL
	u7wLidyxEqCt2WmaW4OwYBh7lo7EUNVH0uzi/6WhviZX2gE8K70CoHW33Xn2TS/k
	umby5dqekVuKmFzWCWpZ6P+sGr1jtncT5AaXceKSvxXZwnM/9pK/k7w0ALqIHhit
	9eQI0F/IYOqdUr0RzWFyDqS/9vOCod4GEQtronFlarpPw6JFrszPFVQyMG4sAnVH
	G5FvvkzC17rW8ZhbF4lATXGTyt7K+Oq1gOeZ3E+YivYf3GMAyQsKFerB6njzFQNE
	daWZ0cVMKBbZyxDT3KqveZaqzxxRAHLbPFAiH6TAKUJOtEnA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpj1849sr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Mar 2026 10:17:15 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-506a936d7afso741173981cf.3
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 02:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772705835; x=1773310635; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LIadV7BRF9LYFllJ7Yhh2a+90a+1bxS3+rs4FMEgwds=;
        b=E/j6XbOUcrnzStzIaP0RGAPgr+0KKPfmLXEJDY+wkM1a7QZtWL2u4dcWEwVCqxzqvl
         YhtPETu3JNhQaiuAP9q3bYifluOBsYn0ZBNUTX0d7vGiww608Otx1HWIX24yK18bijfg
         Gqn7cjDmPZaUcq7A6gU0G6YkTcfI1nsgIp8QaT/7v6QSMqFzKZA9cH7wlurwxGR+C51x
         HtOpQ2Ec0T5KZiSzLGMaK7tqfazz0sk0mO+vRZsLOFmLTShEYbAwiM49kTjXcLi166WV
         JyrQjxwFBw9e2hwGnRvxanufvODnd+m3E9UGMADGoek4pK0TBdnaP0iPdyLweSsiuAMe
         dOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772705835; x=1773310635;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIadV7BRF9LYFllJ7Yhh2a+90a+1bxS3+rs4FMEgwds=;
        b=i1wBbyuNVzdeuFehLVUmwDaLSEBMZhJ8tCLapLQYFqGEG14cFxNgIDN8g4I57La5vh
         1WbpfRxR4i1ALairX65qu8IRa3rJ2MC/9iIDEYASKVRilRgLDjY0U1ywGxE+7MIR2RVj
         CBM8sJ7ek6kURQ5xdmPS14yY56//NP2ye09kZ64AMyqz7gdqOS4eDaeAFHwmo+lxsnwT
         IP04088yoePFz+gfMhlxQucND/b5po3OpIWDE7au1gYkLF51gAIaRc9GB4b9mJGLlqTz
         Gzm5LdNaApt2OlMVDKXvl7DbG9AQeYjjFuE9oySA1Rk/Fr0eH5EIU4mONXWFH9QJvzCq
         vhdg==
X-Forwarded-Encrypted: i=1; AJvYcCUA14tBkvFs4DJgyqx51cyRPRuIF1VeTezviZdTIzDbC1Kuomiwlb86wz5fKx17k4c4pfzysZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFu/OBIvxV63Mh7NbX/opiFAsmkLCeSjmXfTGc4O2g/zrarHH5
	t7dPKknDka82ha8eom+4j9Kyej5avEddFWmJ8JJueEq2fD9FcP9Jw1s/UbcyWxMjC3bEbNYA8zz
	oAEPJEYprfbpXIVPCv5p8w3AlRpOjkxqO9jTW3BheEFhqD7z2cqoUAgCiT4w=
X-Gm-Gg: ATEYQzw8/FWcCJdRx/CMsK556BEouXHGpd5Z/c3cHJ5bFC+l4sN5zYBwxAYLBX+gIUT
	+nzC7ZJwn9THnD4yzo46tQUC2GReDMTYrDjE/DD7kcaboIlJ7bkibTGYeMbFg3EzE7Tn89QJY39
	J6GIfSegPJBKohb3H3jX2VLovdy53fbZnNXPUs+qUXHvxqal94yBNr9HpbvU4if+YUnIaaNeoSm
	yHYAZqZU3KljI8qc2bSt9HHHp37P4ES9wNfz7QIElAD/kTEDJ8WpWSSmVvnC4bSGeDbRFruw0t7
	TXZeG9C9TC3YRZ2A5w4Du2UlJDNyxoxd8fjzAmWkLgekX7/7hnP1hgE0O0BS3qEiiM/ttsJdJCi
	rDwEbOlhIByzqcUtq6xfsps/3JNafYa+nQ1niTtyOM5GJidgO8dA0Kx3PChsoZSCUUHRu32IYDo
	LEAJXwl44=
X-Received: by 2002:a05:622a:11d4:b0:501:4858:a6d0 with SMTP id d75a77b69052e-508db3dd455mr69791731cf.56.1772705835150;
        Thu, 05 Mar 2026 02:17:15 -0800 (PST)
X-Received: by 2002:a05:622a:11d4:b0:501:4858:a6d0 with SMTP id d75a77b69052e-508db3dd455mr69791511cf.56.1772705834741;
        Thu, 05 Mar 2026 02:17:14 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507451cda0asm194096731cf.24.2026.03.05.02.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 02:17:14 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v5 0/2] drm/msm/dpu: Correct the dpu catalog config
Date: Thu, 05 Mar 2026 18:17:05 +0800
Message-Id: <20260305-mdss_catalog-v5-0-06678ac39ac7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACFYqWkC/22OQY7CMAxFr1J5PUEkTdKWFfdAaOQkDkSiBOJSD
 UK9O6FsZ2P5fcnP/wVMJRHDrnlBoTlxytcK5qcBf8briUQKlUFtlZFSGTEG5l+PE17ySbQY+66
 PzkbvoJ7cCsX0t+oOxy8Xuj+qdfqG4JBJ+DyOado10XdOYqe89cF458LQD3VvFVrdW2pJU2sGH
 eDjOieecnmuTWe9yv4vNWshRYjWyOhQdVu1z8yb+wMvn7+bOuC4LMsbcn1zL/sAAAA=
X-Change-ID: 20251125-mdss_catalog-3af878fb6fcb
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Mahadevan <quic_mahap@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772705829; l=1896;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=pKtXrrBm5cADdMiIG05brIdEdoiEsw5uS/LfS5KfQBo=;
 b=sazVMnVsTwYrtjRD3pS/v0hpCNtiD/J4kvbX49FrOn/ZZ2x1cf9GtFFmOhawB89i9M7kz9BgQ
 x6xXQ/e/w1LASlxRG+e6x9BGUXPUWsSkDeEvU+rHi+ktsvn1tYlvfiD
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: 30CZWuqDll5hVRdgTnqtPV03glL4Sheg
X-Proofpoint-ORIG-GUID: 30CZWuqDll5hVRdgTnqtPV03glL4Sheg
X-Authority-Analysis: v=2.4 cv=Ed7FgfmC c=1 sm=1 tr=0 ts=69a9582b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=lNr4chmq66KuSy7Lpp0A:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA4MiBTYWx0ZWRfX8xEvI5c4a/uA
 AZdcas+5Tv6MjDjxZKDIF4vVTDLZEaLKGrHJ0tJEj55ewo/GJjOoU63UCOPCqnl+Ilocli9B6cr
 XuSpdAM5E1qW5E+wxvwHPk9dquTh7XuKnhiuZDli+9LwGGfCpkjlfHEsuqXCVY92r5YCKfzr/wO
 e4fe/B7q7YIyUQEWEYh6BE+mh6JO3VhRGu2TDBm2am7WhSpcvygifHBbA96p4XequJd3dosBpLW
 UwGHggaiuC4MPdEHVShiCG2BBVdRZBRqHXPHLZHUSmhQzj9qJOLYwF8snLwigA9SnfmarwdQuLa
 YV9IQYJfcVGPGIGDJhsiRqwOesOUx+oDn93wJVCKnAgCbrT0c3Xm06u0nBQORyWs3i2KMHIa3E5
 PwK+5WTDodEwDId8YeSsfiV9HcuEc9LgTAsz0FGGtIByWxgjgLlkxZC/J9FpNfmhGnQbTdkAS9/
 +IcCWc9xIecxvlq0Qgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050082
X-Rspamd-Queue-Id: 58C2920F95E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223187-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,linux.dev,gmail.com,poorly.run,somainline.org,ffwll.ch,quicinc.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yongxing.mou@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Previously, the pair interfaces for MST had their type set to INTF_NONE,
since they were not used. We are now preparing to enable MST on the
platform, so the type needs to be set to the correct value (INTF_DP).

The second patch fixes an incorrect interrupt number on SA8775P, which
causes DPU errors.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
This patch was split out from the MST V3 patch series:
https://lore.kernel.org/all/20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com/
---
Changes in v5:
- Rebase to latest linux-next and modify glymur catalog.
- Split out the patch that fixes the interrupt number.[Dmitry]
- Link to v4: https://lore.kernel.org/r/20251125-mdss_catalog-v4-1-df651fba2702@oss.qualcomm.com

Changes in v4:
- Splite chagne out from the MST V3 series.
- Link to v3: https://lore.kernel.org/all/20250825-msm-dp-mst-v3-37-01faacfcdedd@oss.qualcomm.com/

Changes in v3:
- Fix through the whole catalog
- Link to v2: https://lore.kernel.org/all/20250609-msm-dp-mst-v2-37-a54d8902a23d@quicinc.com/

Changes in v2:
- Change the patch order in the series.
- Link to v1: https://lore.kernel.org/all/20241205-dp_mst-v1-3-f8618d42a99a@quicinc.com/

---
Abhinav Kumar (2):
      drm/msm/dpu: Update the intf_type of MST interfaces
      drm/msm/dpu: Correct the SA8775P intr_underrun/intr_underrun index

 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_2_glymur.h  |  6 +++---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h |  6 +++---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h  | 12 ++++++------
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h |  6 +++---
 4 files changed, 15 insertions(+), 15 deletions(-)
---
base-commit: fc7b1a72c6cd5cbbd989c6c32a6486e3e4e3594d
change-id: 20251125-mdss_catalog-3af878fb6fcb

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>


