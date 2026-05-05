Return-Path: <stable+bounces-243993-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDBQO32W+Wlk+AIAu9opvQ
	(envelope-from <stable+bounces-243993-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 09:04:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCEC4C76F7
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 09:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77AC8300E480
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 07:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855033D75C7;
	Tue,  5 May 2026 07:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XIYAc0wF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dQkNoDTp"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7C23D649B
	for <stable@vger.kernel.org>; Tue,  5 May 2026 07:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777964438; cv=none; b=kg9Z9mAaw/tIcqcYegEoNXzfpnUvzG4vOWiYGG9i8uuCyZZVjMlD7JNX8w4MX3wIon7fYnh6LAOtOQs2vY1se3GNJlgpGNpPApDEcp1+fE8CUaMsaQ9vYOXdBkAaEQC10/iYSvPlsgOcHcachP1Z8/6C1vCq5wTqrBJON+u5Nv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777964438; c=relaxed/simple;
	bh=XCLAciwoGLa2sJvy/DDGRqny4ifzNwzjaeJeVzt0PYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d0gA1hAhI0RsACQ0b+Q+hqLhFiwNPknDlo3FDwuMyBd/rpsvU6zjryN755I2IlSN27PNXMHzBRcmeKtP9qxFDZducWr5OV73S16KbLyEkYR8W4vsJeqDAj6Po3B4RB1Bw4W54KraOH51fMyRzbSt2d2Y1kFx98047vqBqwsKqWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XIYAc0wF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dQkNoDTp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6455nB2L299216
	for <stable@vger.kernel.org>; Tue, 5 May 2026 07:00:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mCM0+/uGCzj/hM4vy1/xEsxuxsqzm+PtmpUe54/lVkk=; b=XIYAc0wFJxzEGvc/
	aUOolG4rOkBmutVXUNU8SM1/TVb6OL9iXDBL+kom2dgZnmX9RYWvTs4JOoOd2wvC
	D34o3YbCKlu+k/Oxen181/BNCJSusv0IsA/XC05XKLQb+6CBJQjARnClpb+GLt3Y
	im6Q8ddCxXFEF1vA3rO8rNa55ygB8vNsYQt34QxjrwVxjvAKSh9YNOvRAwc5vjk4
	B7wuy8MOacnb9VRXE1vIyXYDDQomFu8BmtVjoMcLoXnFrSpsqCHFf95bSFgEY73A
	8hfeTRsHWcGWCij8E2bBZc0+KKcHV4aVy3hA9aiWoSdUkO1bdACZK9YNPzeKiBj0
	/XrNyQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvndb8u8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 05 May 2026 07:00:35 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36555cee295so1534651a91.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 00:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777964435; x=1778569235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCM0+/uGCzj/hM4vy1/xEsxuxsqzm+PtmpUe54/lVkk=;
        b=dQkNoDTpjJDr4odTDeSOaUPLzyhLxVqS9bTTSkOSRUZQhG8ojTiIV+eGGFMrgLWFuN
         UEU23dngDwGQn8AxEapk03aj3wKABL1KcXjETdk8nPOk97Ol8SrFqYNEHV7sIZ+klmJX
         wPki27lo2cApXr6tDiZZzFP8MtyfD8q6BuMxnIm4Wvm8RciYZMaibzg/zU9ORVLgtXry
         j1U4NF8/YMMcSfzfpoWn7ntm/GBoh4eBR8aIrbRMqS8xUdRztgCexVRrSSxlmUQsXIJ6
         /svh2ET9LRjTBrKLzuK6TqlMBeurkG9pTFdJA6f7O5psvY26UvwOka8dwedv3xVAOLk+
         J3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777964435; x=1778569235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mCM0+/uGCzj/hM4vy1/xEsxuxsqzm+PtmpUe54/lVkk=;
        b=kQ4s/ZWlQtcQx2gK4TlGQBHiVOsroOVR5AS+4kqP/UKTvir8+Vb7aqiEldvx+WQkIZ
         RBlEp4k8f5ufPkMVVj45siCiQwcUU6T6nOMQ+qDrQcozLz4QOHFXwnKI/EL7yLyhPakN
         NGJxbvHPPyrubSl1gNbtvjP2217VJSo77kumkUR6zr3aBwe38UZbnluNMT2GKF+TlAvu
         0PSt+WMD1T/s6M3Nfs0QqwZFU8zP+ezfSX7D9SDwRSyQZsFrrb5WM9CY735YGfBErvRs
         iMDVtBpvO3LUG5uKkig4zPo4SHb1S27WLkzGtn7AkAFzcqINNXOd91IGBShmrXTqKPrO
         YKWw==
X-Forwarded-Encrypted: i=1; AFNElJ9YBxaM/KwEePLZbdU1z4YQlADrkUIEb78aGLmPGWF3HqzvA2gkxl5DQeIMVM98jOI26jkeOik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx29Iwsuc2/mofSOaRXCFPnt0ZCvmAyua4pa7/QVjx9z8LuQyh1
	Si2hTfwdK5NUBq+RZbDocLQq7k1uSMiDYAN/eQaYEDn7ES+QwNh6q5G3FVNAg7K/fpo5pT/aiag
	NpdZddsjLnkoFpQK7py+pli4bOguc1GneiNkXXg3lrqnPSofGPGgBp3ZhvjQ=
X-Gm-Gg: AeBDietU81ynUoiFbaDVKsQhhdx68W96dIGA/ushKxCzzODzr/gqvGH266FE44cPBWZ
	sQa5+aDX1F4uiNu5S/eWZr+LBFnHcItOkA2wPxsqZ5MEmD5dfihzrkJSfAxOutkLUadgzVahBVo
	mbBIVN0w6F8zbrfZnubLimAcf66ajesH+6kZ9hHq+3Nf8/wAaC9pj7grt9AsOXxVIVRaa+rKaYw
	VGuOwVS9BCHTfcVkmafVk+hlIh/FHHPBfx2/akZRGNHSreHwl3cfBCmMF7iygJcTiDY7nkwHkHw
	KVodjbJd1JgqMiT61UCMg+LXE4lwEnFNJTUStqsftKPPaQUWw/pM7+EhIG1axDw0qR46XGZnjdQ
	hfv969NVIlD/G4YQEIwvArJEfAwgzw6R0LM+VRc4ZBb76+8dBGxW2cbga2jytxs5gVw==
X-Received: by 2002:a17:90b:3c85:b0:361:45df:103 with SMTP id 98e67ed59e1d1-365773ba9b6mr1998780a91.12.1777964435339;
        Tue, 05 May 2026 00:00:35 -0700 (PDT)
X-Received: by 2002:a17:90b:3c85:b0:361:45df:103 with SMTP id 98e67ed59e1d1-365773ba9b6mr1998752a91.12.1777964434865;
        Tue, 05 May 2026 00:00:34 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebec73aasm13840146a91.2.2026.05.05.00.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:00:34 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 05 May 2026 12:29:22 +0530
Subject: [PATCH v4 01/13] media: iris: Fix VM count passed to firmware
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-glymur-v4-1-17571dbd1caa@oss.qualcomm.com>
References: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
In-Reply-To: <20260505-glymur-v4-0-17571dbd1caa@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        iommu@lists.linux.dev, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777964421; l=1361;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=XCLAciwoGLa2sJvy/DDGRqny4ifzNwzjaeJeVzt0PYg=;
 b=ktXf49S5sgx6u8kMejEzA6UiVMOHVQS4joL+4BEKP49XKZ4vQFp65+/vb+24gDkEP4GS3Qp+Z
 Jr0woULZO/2CoeWozlpPFfxeMfe4S8Akw5yLupWJ66leYOiL915/QLW
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: 4iYz0GAc2LuxR9VtwZ4nDEmS48Ig5jAz
X-Authority-Analysis: v=2.4 cv=d9jFDxjE c=1 sm=1 tr=0 ts=69f99594 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nrYi3PkkErC94SPB-twA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 4iYz0GAc2LuxR9VtwZ4nDEmS48Ig5jAz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA2MiBTYWx0ZWRfX6aYpD/nDHUBW
 Fx9kF0b69n8H9SC/s5mel1B5J6FlJ3k38AvbNDKv6v3wKzypIcwMYk6Tp/DO6/+14haDr4upyVp
 O3W4mMlU+3H+vwLgh5IJA6CDsDtX0SYj3Xu6eO1Q7gbxJlFptyf5AV5GTnCy81i8p1EHcuNU3iI
 dW4qCzPoPdG/MO5lM49+4MaSqq5ohzW8nGgube1q5CfN08mgBvFBx10dNTMBNRXtCRj5yVFK8Tm
 bXTFCOanIPeXzcPqLOMKVvZWTKFD7IG9h494C+6aZH9k7ZeqOhcp0Rw9rGkGh08TiSQIPF233Jz
 oFy1/N8UiU07JwgSzdVnaJtvLMAT2d93PU64YzXMRhg04iWtcTOUoxuLgS/1TX5BkgCznHrO2OF
 8IHfxZt4E99qKF/YgR8+b+B2TaAW36HM6Wtniv62VQRTcs9cHDzwfKLGKYK+zRZuxMaeHqkAyc6
 aGa2mS6YIcfM3tG9j2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050062
X-Rspamd-Queue-Id: EDCEC4C76F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243993-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,linux.dev,kernel.org,linaro.org,gmail.com,8bytes.org,arm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[busanna.reddy@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

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
index 69e6126dc4d9..f1f9e04b7c31 100644
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


