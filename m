Return-Path: <stable+bounces-241471-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFy4DQAw8GltPgEAu9opvQ
	(envelope-from <stable+bounces-241471-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 05:56:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D225D47D353
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 05:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD928302CD1D
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 03:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C9633A716;
	Tue, 28 Apr 2026 03:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mzxslg0g";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MdYjXuCB"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9584338906
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 03:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777348568; cv=none; b=Zdxcvk5lPthYFxdy32CcdzPgNChWJG9OSUZG+iWgpTyxie5P4/WUhA5ub7ayiLJEgX3osUgrtdL0mFcPancnjm0rHPhfAkKF5LA1QtOCsL7q/NuwEYG2Prx876i7Tit4H+Fm2QyFFzuaeVSnWo71zW21Lqf8QZx+CMitGbdN54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777348568; c=relaxed/simple;
	bh=9ojkIAdTpgdWLJL63T3L3LzXB40PPdXzhWOQLp7Cpgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ENOeto3w7WYH/aQ10H9xblbgptnTw95xIeh+xky01jwQmEX0w+ohJUbDofH/SkEIF1tTx1wSRc9VPKPW3eQo6ITCjTyK28ikNsBwYCxy6Kye7Nivhj2M1Y0m8aJ7Osk8SB0SBqeIcfBxRfxO9kCIDQ+UyQF9eLdSZYCPeiO/DlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mzxslg0g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MdYjXuCB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RJ3UZT2112521
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 03:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tdvgFuqYyOWNHAPEPDaWlWX5rBlDjzWDByFTGDon+SU=; b=mzxslg0gP7zoCWL8
	HK1m+jk/GCKz0EfmxyinXpZzoW0GwVrVBWb3dCbH7fX9eSQKEifMf0PES3zfNDn/
	5tuL1k1R6zmNzWMSO5Xc8ow40h5IIUCE0GI5HvhcKp8YURwnqK3Ib7iJpAxj54/s
	GycsCfsj1noxB3KlHZMbUFPErqmGt2RrQ2Q9JUZN7MKqnZWp5W+I5HQYL3F5uv88
	j/Z5YH5pHXd9X4S5LHwxNiAshXjO3isBmizvU3qpadfv5M4ijL+OBebeXyjDlZjy
	KkuU1o8DLzXLP9qVmI2sw/e5OWENrpwWdnx/c8sylXD+tFruEC1A4Lq0fdqZVAwP
	+eknaA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtdmbhnd6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 03:56:06 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36472c6a7d8so3479274a91.3
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 20:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777348566; x=1777953366; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdvgFuqYyOWNHAPEPDaWlWX5rBlDjzWDByFTGDon+SU=;
        b=MdYjXuCB94kpmnklm35JMI4U3DmCRMPR11qrCqDbVJ30uM1tPJnX8TKSUeoBnUYP9a
         vyx0mlId+IkfInZtliE17wqxaPeXlASxpJ+M0Oda5uAoMoJZEdyrEFs39V+KjQHFft2N
         3cDzgV2Z1/8kDb9B/pL11PohLbVoA1kjDGEF3CUH42YQJxbGixj43DxvQ+093EontQKv
         dfrR0pFrgCtTQwTSrTffk/Rb+C5ToaZKLmYN1WSYoZofuGrxq1pH4uSecZ76uTRMMQQM
         MbjbfK2X4aBeUtvV7T5uPIYPRX5+NoQBbnxvI5WhldAMtijISODdaypsGeh3Js/dg/RU
         H+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777348566; x=1777953366;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tdvgFuqYyOWNHAPEPDaWlWX5rBlDjzWDByFTGDon+SU=;
        b=lK8A5549nQoAj5ccuNfc2lSAcPECXL7JXuk/Hwcg50BzwOT2ZQ9ZIOJ8ypg7MmDa6A
         Oz7ZeJr0d5Kpfj0IyMDgX8ozPO7dBFAqgj39sf+aYgPf1fR9PVSCjZlALfpdPyNz9AqJ
         LYDEaE2h8pXZprdM8EOJxnMYto8iqWJ4Mj/7mH5bsO9MU5SSi83YEso/lvfIIuZc/Xq6
         Eydq8rP//g/meKMPKv0qyu3omwm0QDSNcvTARIZ3CIB2tOBBBzgxLKzPWybgy1q16db+
         ZKTmxadgVExutXK+yswGWqQhPGrwrmw4CC4qSizbhEcj01jpkrp8Xxs5VXJa93xK4Ssl
         PyFg==
X-Forwarded-Encrypted: i=1; AFNElJ+ej7SbnvyIGjPaQDxnz9B050sMwYIHxnrKD3maKXxbjRmFi6T18AkFj44JoXtWQl/YHsTjOSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXKX+fybgBzLquOG8HNJBLBKwiYXX2bRWxakcogEqYOpGyr/Q3
	RhYDDAvjjmMZ21O0zovS8pnPT7hpdjk83ubWCCDmHzd29GiA4J+xHHngdssnNzsiBS/7VwDRVjt
	tywu6KYipDWugrmpxRDmfP5od1vj0NcZWWKEPX/D/NZTCQFnTEbrHMyDga7U=
X-Gm-Gg: AeBDievyvVVTdGAJAYMJ/tqLrN9fEaTlJq5jwwk/rFO2DDn9w5nLRQWr1xRRVUDIcAi
	lSFizlIceq3xGK2tOzTkPXbCZVSwA2VDw1vIZPxaHIfgpkCnkB7h5mkDd4YhlxluYQcFOf8+iwL
	0HbELvt+f11XOaMn661qGt84c4z3E8sWLFK/p3mT+PJFeTv4BhdVvsD20Sl72p52HJjC6MtKvQg
	Wf7S/8lffYDePl99MzQYI3rq58g0RxIxcZ5HE2rXC5BFiNK9iv4Qe9tLIivM7RKWWU0Va1Ci+Pc
	OmYBKKNuNSPgrso3jdzS4+RPI2zTkt/MJqFBARJxEGi+2KWn2f6UZDvHOiNCGooMH0BOd6sdMHm
	f1SfLCAwMwxl9QgkknWHvUeusLfG3c4TeRzALIStnvGcPNUeZ+p8u/CW4DeGWa1nd6Q==
X-Received: by 2002:a17:90a:d646:b0:364:78a5:8d40 with SMTP id 98e67ed59e1d1-364921b0f18mr1617219a91.20.1777348565602;
        Mon, 27 Apr 2026 20:56:05 -0700 (PDT)
X-Received: by 2002:a17:90a:d646:b0:364:78a5:8d40 with SMTP id 98e67ed59e1d1-364921b0f18mr1617163a91.20.1777348565020;
        Mon, 27 Apr 2026 20:56:05 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490905648sm393888a91.4.2026.04.27.20.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 20:56:04 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 09:24:07 +0530
Subject: [PATCH v3 01/12] media: iris: Fix VM count passed to firmware
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-glymur-v3-1-8f28930f47d3@oss.qualcomm.com>
References: <20260428-glymur-v3-0-8f28930f47d3@oss.qualcomm.com>
In-Reply-To: <20260428-glymur-v3-0-8f28930f47d3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777348550; l=1361;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=9ojkIAdTpgdWLJL63T3L3LzXB40PPdXzhWOQLp7Cpgc=;
 b=ay0dYnshvA44WROZCAGWy4lKalYgcb7yDOo0fRviOiuhVcATuyWxdErrTpNeQbm6pWWNnv4X6
 u3mbWherdU6BTtXEW7QFWSFFg8yQ+9jQhUvkN+qqjo9clshZxPEAcC6
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: uEMQedARvsudp_h2QK0EzRaZBttcCrqe
X-Authority-Analysis: v=2.4 cv=PcrPQChd c=1 sm=1 tr=0 ts=69f02fd6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nrYi3PkkErC94SPB-twA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: uEMQedARvsudp_h2QK0EzRaZBttcCrqe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAzMyBTYWx0ZWRfXxnewFFET8XXD
 lqlF2TgwNAY8s6v21rTTiScZRT2x+udRV2+01si34kAkzRx4SPao+vmKu2YWY53jpDs9ikCUewX
 r7/Uu9wmPyXjm8twfbW37YMybuXtY8zNSWwRVWpSjXBP0puStFpb+vO8QL62DwX+SLwtGtbOn4k
 enB+30DC1aXtpYl70a4J0YUbdC1GHi4gh8gA1l0w4eQ+Z24jrIaJxgII6z800XHhbK+QRG48xJD
 maFxY9Nl7SrlwaUxw/PdzETMr9pXN6gW8kldc64nC29z9fkSckqXizsgg03HBYIbDgqtA76asrI
 hz5PU70jmTDjmJXLeUXv0Cp8YDhaviTS7kCJSIv7sshkfMBunIS7CqA4KmkePuA+Hy29gO6oBpD
 4dTIHkkJGjjFbMRrnlnWPO+ZhMf73CfrhtYTs/RKVo59HJNGupYB7BLkAtr2cSAurWJe5Lhk9JU
 pp6K/SUtFW1hbBoZBVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280033
X-Rspamd-Queue-Id: D225D47D353
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241471-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,linux.dev,kernel.org,linaro.org,gmail.com,8bytes.org,arm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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


