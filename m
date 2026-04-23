Return-Path: <stable+bounces-240491-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF+qJ0Qg6mntuQIAu9opvQ
	(envelope-from <stable+bounces-240491-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 15:36:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE29C453085
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 15:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7CD5D3031EFA
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69B636F438;
	Thu, 23 Apr 2026 13:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="inrUE1eF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aWk+YDEd"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E342FC00D
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 13:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951009; cv=none; b=P+CKasYlqIlZl3wlEH1FYUvbKIqCb89kYx1vrzbs/EFpRSxTp1xY7bo2jWUywLM1bSeAPaAI4d96ZELe28m5LxI1VOgxjILmcnB13pShzkez0FCy51uz/MtsWaAkdSKhNd3Xy7eh9C7DdqOovju11Gdlr4fnqSh0mklj1ZDhABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951009; c=relaxed/simple;
	bh=9ojkIAdTpgdWLJL63T3L3LzXB40PPdXzhWOQLp7Cpgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gYkNkl5CoNi/QH5hdUQNhAmKM1tMHNZwrjeuTGPqaECJBQ8NHZfu9wU7Ln31S00C1CxErzKH1MS3BgRuz/lBKfs6TF3bIzYHiLhhECp3/05TtSKnJww6ra1oUIp+iKNTzejI9zxgBMZ+3tu4H3knATqCb8r1KhdB3pIZK+Ra2O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=inrUE1eF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aWk+YDEd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8uJRo3413371
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 13:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tdvgFuqYyOWNHAPEPDaWlWX5rBlDjzWDByFTGDon+SU=; b=inrUE1eFryx5382j
	3x7rs59o2EAw0GE7yiTLTv6vxcNjIksca0eovJL55QwMmtmF0ghirHogM4Ku6YGY
	bLCa8odqqLPmBKzzeNDMepoaZaXk8ieuZYRiBHdEWeX5q4ApQBx+p8E7i2r3zqRN
	hm6AApefZAMvcbqH0VoQ4vLcsd+n6kdWs9UhsXDfN3FwN1KxcDl0qS0O74W2XAa0
	wBVmQX1BLh196ISWpAFrH6rYA+Y8xRxVksDSOcw+XLKIAICQYDCzAYACXF5l4vzG
	aI9/WqTstkkEgqEvQVfYA1ljH9cb8f7kjOCvWb/wxda5/10m+yYcBurx4gmsRovt
	zBJ8bA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1h6c5h0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 13:30:06 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b241be0126so130903255ad.3
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 06:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776951006; x=1777555806; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdvgFuqYyOWNHAPEPDaWlWX5rBlDjzWDByFTGDon+SU=;
        b=aWk+YDEdRHh/OCbh3ZU3IYGpYjJ2Kz5OsLcGf+FTTsJZXSz5lxL0VhxzPo2M1zrHsy
         pSZn6q34okLTRifSrDM1Vps0pgZkOwGgmHfnNj5G4a8GNGvUEK5QdAYvc/z5frkrafbK
         Z6BeE0ODwKjcxghQlLXoUnQiwR/SI8ZKJFXOX4Vnr/bmubL/7KvC6nxEuYRu1MTSmajT
         /Y555zJA3lIzdBbxVv5Ygao+ev3pEynMtt5HMuf+sd7hRb+2Qf/HdyhtvyaHQD/mRiwV
         OT+jW7KiIa7mjkLtMWYuUyBSFRvEkD/EbxTqd6UbFpyMa8scKT39OWito/mr8/KObZXP
         zBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776951006; x=1777555806;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tdvgFuqYyOWNHAPEPDaWlWX5rBlDjzWDByFTGDon+SU=;
        b=T00oeaSr1SAHanKrb/XUD3wtSGIJ1YU+ZzNo3u6MkIESmP9cx9seqcLjQhpDnKJxOy
         s2oTzLsgKSuaiHYaOx5pOSGlj/G4E08yrT2oLn580BIREAc9NMPBbwsIoy0sa3mKyv7N
         1qEifj5qCm/Ew7eNhQc+Cpi0uR5sdqW0i8/zjUWg5/m+snF4rtMZok9K0nKy7KieuLPx
         UKFEw0qvMUIoUg0GyXNsnKv1uuEVvqq2K1xzdv9AEzarHGO/+hZ44vDOGJG+411x6acC
         ObGomAUKfpvSMeMr8RRrplzUP3OQHrJA1Vuusj9xmvanM+OFvda1HF9CqQZ2fHMR2DPB
         v/Uw==
X-Forwarded-Encrypted: i=1; AFNElJ+zD/ibXIC0vMjjyB/LQJFQvBSDmmp5cXVx9ylXV5j0XBd12VZ5feStkQKKqa8MeHQEFmRH8eM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuGaAvJ6RcXEBDEnfwq1EOVmhcpy5+XDGb6rRdsa/5TdHQbeAn
	X83Y/UBoywRJJSxFZpq8lvwBi/iknD9FjSZb389F0IW+qDG16lBJcGVC+D3AyDB9cuH0r0+tsLc
	U2qriS2TavznHlKSkKPSCGCik5pyHSUUQs6280ZhzhZM9ibCOVC7v2g9bY0U=
X-Gm-Gg: AeBDieuNGF4l/BA8Y6/0QVwtlpvq5P49VCMeETdhrfIKDYczo20HTAB+3SjMfWTVQN5
	cTJBrxkKq0g/MI0TRYFYjpiiaBKf4GWsG8W70MBtEuEucGlfhDbr6axsCcgy5DX/2uChYJUWRBk
	ZwJ9zgyjxsp3HLhfs88MxYIvab0BPcty4gD8ttKU4RkxY4tM7R2w1c/ioUNUsMLHX2KGug90Ot2
	cCsd/DV85xrjfr5BMFwsGc3rs60Dj/OLyLjfRFRC4B2GuDEZR8zAwt1B+COCF11HcHpxgh3lawW
	hljPRqXhbx+svYHDQauYXqgok/5fvKRiVLUa0ma5P+gv/9AWBoFoz/sjmI7eXxFxhQKcxc5GGCQ
	6aXv12Kd1pY2OBBcml+lqH/LpZzEZ9TJCRvgtj7JlkghYg3YVs0XtzeV0eo8vdkxMqQ==
X-Received: by 2002:a17:902:f551:b0:2b7:9ed0:4f92 with SMTP id d9443c01a7336-2b79ed0505amr34984325ad.32.1776951005412;
        Thu, 23 Apr 2026 06:30:05 -0700 (PDT)
X-Received: by 2002:a17:902:f551:b0:2b7:9ed0:4f92 with SMTP id d9443c01a7336-2b79ed0505amr34983465ad.32.1776951004706;
        Thu, 23 Apr 2026 06:30:04 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0cbaasm198795635ad.54.2026.04.23.06.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 06:30:04 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 18:59:30 +0530
Subject: [PATCH v2 01/13] media: iris: Fix VM count passed to firmware
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-glymur-v2-1-0296bccb9f4e@oss.qualcomm.com>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
In-Reply-To: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Thierry Reding <thierry.reding@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, driver-core@lists.linux.dev,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776950985; l=1361;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=9ojkIAdTpgdWLJL63T3L3LzXB40PPdXzhWOQLp7Cpgc=;
 b=kLZ5VkIwiLF40laB5sma2d3q4alpT4zAEZptqRbq23De2A/jVlXuy2rCJ87n8t/knrGPt5QnQ
 BQ50ze3n+5yDir6GHjn/LjLJmJfxx/KjeK3oF0PhnKyu8vo9IOmZtqI
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Authority-Analysis: v=2.4 cv=f4Z4wuyM c=1 sm=1 tr=0 ts=69ea1ede cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nrYi3PkkErC94SPB-twA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEzNCBTYWx0ZWRfX6KDZ5q+5xDxX
 vzO1D3+Hm8JzXHV+drBe+iI1wUBzwKMCv57yFLq08NfqH/gon2gooSPuy4pf7ZwwuUL7AazXAsW
 Q2L7UWhdT4XOqbK7wOH/NBdol9P5WbCSCtpWLLqbIFwvLuH4BTY3Z+NJscOzW8GNgDMidskp/aW
 6Xk9PcfhfHfUal92ejKxeG1qJb4pNzEShEnnC09UVNpBiEbjuEn+i4dEFWFZc2fn8a7dNRjuwmX
 u3l27u89/W0CYn9A/hP/lAXHlfZx8C+sHTC/yV6PJZPYZweLswYO7TxICFfcU4qxX145/9+BhsA
 TYB0Jo9R3ntHIAbNILMR9Mq/gaE+zkcI5MucwneUB318evqUcWvZ7Pb2u9ZdOobjI7a7f9+yvcd
 FWdy57t5q14pCJfm6qn6DdslNiwQkISatonJtihwm6Q4/RjTWLRg3E6zmx7iNQD4Zyt3LEGORZB
 ByGNj+t9Y4IHk2U0dFw==
X-Proofpoint-GUID: D9XOqsqZjj-6AYd-cOIcP_tz13hGoSx6
X-Proofpoint-ORIG-GUID: D9XOqsqZjj-6AYd-cOIcP_tz13hGoSx6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230134
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240491-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,oss.qualcomm.com,linux.dev,8bytes.org,arm.com,linaro.org,linuxfoundation.org,nvidia.com,gmail.com,ffwll.ch];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[busanna.reddy@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MAILSPIKE_FAIL(0.00)[2600:3c15:e001:75::12fc:5321:server fail];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AE29C453085
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Glymur, firmware interprets the value written to CPU_CS_SCIACMDARG3 as
the number of virtual machines (VMs) and internally adds 1 to it. Writing
1 causes firmware to treat it as 2 VMs. Since only one VM is required,
remove this write to leave the register at its reset value of 0. This does
not affect other platforms as only Glymur firmware uses this register,
earlier platform firmwares ignore it.

Fixes: abf5bac63f68a ("media: iris: implement the boot sequence of the firmware")
Cc: stable@vger.kernel.org
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index 548e5f1727fd..bfd1e762c38e 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -78,7 +78,6 @@ int iris_vpu_boot_firmware(struct iris_core *core)
 	iris_vpu_setup_ucregion_memory_map(core);
 
 	writel(ctrl_init, core->reg_base + CTRL_INIT);
-	writel(0x1, core->reg_base + CPU_CS_SCIACMDARG3);
 
 	while (!ctrl_status && count < max_tries) {
 		ctrl_status = readl(core->reg_base + CTRL_STATUS);

-- 
2.34.1


