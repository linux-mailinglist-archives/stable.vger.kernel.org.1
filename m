Return-Path: <stable+bounces-253371-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEL8EmcJDmrY5gUAu9opvQ
	(envelope-from <stable+bounces-253371-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:20:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E002F598248
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3FB21302A64D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE71A340281;
	Wed, 20 May 2026 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fb9j2PHy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SA0gqKsU"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9D6233929
	for <stable@vger.kernel.org>; Wed, 20 May 2026 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304802; cv=none; b=Tu6cwneJLH0kKB8PuLfM8ugDBItFXuFb6Wv2rUly+meRjbU6QLpp4xbhdNjjYjCXwfcYllpnbytqrDv3FAgk4Y7rsTJGBAFRIujhJFpEjjUga/iwonslgPagRPhIuTt+W2kSlcczhyUgsvIqL4mWfZJKGfxr2XsVLpw247t+KKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304802; c=relaxed/simple;
	bh=4FHLC0bnTekkNLgy7lcHxQjfjLT0Wq3vJixLptjPBrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EpiTtb7JdeZcZiObisSEx/iMxEOMZFd/T1Ve4SismfWk+wSUwHFSKaWvU0NByRl6wYXhIEvIVPzhrYyftAzt5h2lnT71d0Ubc9ooGQMHHyS9ydKDn3EweNF3vPu2PkCM0XB3UUsNDumk4zu93ar1y4oOtexTcU/f+lNyKLDCgPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fb9j2PHy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SA0gqKsU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KEFeE1963945
	for <stable@vger.kernel.org>; Wed, 20 May 2026 19:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=r6YMtjaiaTXIMz4lJ/l5IAROT3th/iPkVaB
	nZpAvcRQ=; b=Fb9j2PHyxuz+kO1pmc0J+OPZFbjx3x1Cdr/aoSGyENZdfgfeAc/
	dZ9LP4cowWVdjrWO5fqawN7uEaHib+Mg8VdrxfZqDNZnrT3pplt4UTenOAPoVy80
	bIIy3z+GnDtwEM60KpzpUAq5fZK9KQkHucWe6KTOjpq6AwKa5/jNDaSkbAlvENGx
	mevRuwtKAB89cbv3hPIyAO10BkIUwHtUO4bud9Tg3cAV4R11ENsoGKKpo+fC3Zle
	1McViLAx8jvtCA21e3bIpmnLSfXRjVY8XCN5QnE07/ymctIPdN2kv3e4hjKo/9Lt
	nwWt3OwsSIxtnQO/hLDrMpDK+uT0fmJC3yA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ejh1aw7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 20 May 2026 19:19:59 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-6322654bb6eso9182533137.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 12:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779304799; x=1779909599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r6YMtjaiaTXIMz4lJ/l5IAROT3th/iPkVaBnZpAvcRQ=;
        b=SA0gqKsU1Lg3NFJHdJc/0u1xpm0mAlAZgcYHDy3HIXOJXS0oZcrjH9AnYMR3WnRNbR
         lmli/hkvCVKSwDaFHCSwlibuSAhuujsN9aOZ5sYdxHdUkrJ3TucUVE+K7C+6Tcqw3/RZ
         rCJL7oLkKq4F7/5bnsh2v62V0WPyF6L08VpyPKTOZb2SJ8vn46JPC0HQAzrmWUGaF/8c
         DxvrzEQxSa7xg1+xk5TMehni0BGXHlrfz06g5QKtcFoIOynuxPS45jxMd+e0Yi1Trmqn
         sBii5yTYe6hYoR1SNyGUiIOVmPRPkZQCx+Vm2snIuqzu9Wpto6it6rVxMMlnM/BfZkWX
         5iug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779304799; x=1779909599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6YMtjaiaTXIMz4lJ/l5IAROT3th/iPkVaBnZpAvcRQ=;
        b=oHvZ99pYS5JNHwTpEEfQNbk3lgTey2qzLp93KjWfd4zgpm46B4EG8DEUU5jSVMk/i0
         cGpUB4u7wQUh5WfEr3JoO7JSzNXwILhPh6Z5h0zRx8AEYKaEVqR0vlCjDcpNdHyC5v1D
         Zb/UmMa458c0HBlhMYsP2gyY+jOzM8tC2CDfyku9lvtUY7PCK0BEP7gHeyZ8ODS8i5D9
         wQ0ihohBn7qxQoI5Njayrx1DwkjelnqHawbv+/JH9ZCGy4Y4GiJzz6MOVp8+AdXbggov
         90LA7TjxMZ/uaorxWFbXvstGguQ8TRTeiwHI5EqIF1cIDs5IGjl1XaXqMC82e5AJPH6U
         rG+w==
X-Forwarded-Encrypted: i=1; AFNElJ8cFLjOrFvMXNara2iqHyGgzOrjO0OfVCkrpsaeIJvFr8ZnQaLdlbxcJ8uWurVkORxN/JYmTZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YycqWCElzFUjWUq025KIhB5Xv3G0sA9urQLDPOt2BwF7fRsyIEU
	SKdhNxJeDeUHToMg1xYpEI03RKPr4y3yetCyMlJzbXTE9kgbjOhiB93ra04FkJ0iLarFJCpYwyK
	BOoJXuSuYDR21NMQQs42INL9rctrkEC/Mh34tAlPZS80WpviKoTUZQvz1QjA=
X-Gm-Gg: Acq92OEOkcNlyoNWGvAB+YuneNZTjm0Lv4mwcacD3XpbqWnKf2UvJmAX6eovhERKzwB
	QggMgWaek9py6OludKfAioR4XHki1mkRyA7XL8mvhVFMqGnduqV5sJfucmBVxkte9Pci1jJzmtg
	sYHvP9P4s1iptFB6DRKuMkV8oF2xvQUuQPb/pIJQO9mOm04Y2VPSpL8rPHI699VsH0k+GNknmFq
	SqFtCjj/lq9IiC8jJPBAqi+vwf5h/v5rssFXXsbsEK79/81Fodcwmar5+EeZfyxp6n4YwApYUmb
	bJHK7KHJ36TMyU9joB0liS+xMIKtSt6bt0Y1gEOPUErhcMSVi6mTXxa//WEZE6za6XferPSKiVD
	uzeMxYNEABk2D66/It0yVtMLtens6Tv+IAyyU
X-Received: by 2002:a05:6102:854d:10b0:650:94b2:b209 with SMTP id ada2fe7eead31-65094c2070fmr7545567137.4.1779304799297;
        Wed, 20 May 2026 12:19:59 -0700 (PDT)
X-Received: by 2002:a05:6102:854d:10b0:650:94b2:b209 with SMTP id ada2fe7eead31-65094c2070fmr7545549137.4.1779304798919;
        Wed, 20 May 2026 12:19:58 -0700 (PDT)
Received: from quoll ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2f738sm54567601f8f.16.2026.05.20.12.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 12:19:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>,
        Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org, sashiko-bot@kernel.org
Subject: [PATCH] interconnect: qcom: icc-rpmh: Fix resource leak in case of missing QoS clocks
Date: Wed, 20 May 2026 21:19:54 +0200
Message-ID: <20260520191953.190564-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1487; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=4FHLC0bnTekkNLgy7lcHxQjfjLT0Wq3vJixLptjPBrs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqDglZH+ClU22WgzuRSsjPrkjZHN/yZFiwN1QGr
 5+DofLulIiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCag4JWQAKCRDBN2bmhouD
 1zN4D/9079hBkeNaOJXFm/yX0bDWLgwYhAydjlIymxjEFffVfWSoyzP2SJdEskNsO1t1bM4OTOq
 87+CVtXnVi8Jyqm1h1wP0HyK9CSI4DobGoduG8PI3I+fBt56Svo0Vnq3jFS60VAnE/ElJ0Q5eLt
 ae2BNNGAzaMaA3siuFd2ST1RcGb6r+hvAddJzUPR2/EIhAJOrHH1J4BPwT5JvtpWuvHbisDCIsr
 U1DPZ81gukmBAy/Isp341v3WclToV9nxLOd3ZutOcRgjwsPLyFu1xRwYRbicBdRQNWnfZy4HXNh
 dC2+YSKr4KNUmnhKvQ+ufZE/wLpKuGY+3AktkPajOeM6AKt0MMjZQh3qubBQZISf001uF+dPveh
 wqEIST6DUnK2wXMWrsH0BV6APG6aAF7IEJvCspU4AAGEX7yoBlBFwYTAxxwoDQDjAGsXJ7l7iTU
 vu0qPvc0quFUStmKbkXGk3KYZS/JfWFIVAC+T8FSsPekn32gDYdnqMp7BRNB4YAaG2ySsPmVo8J
 ahLqb7Y2bfm44z7deD/YNbtLmTXlBK39/M776WB0ksCCFa7d2sehiH1wwzyYcHP0J93Apqsq5dg
 qW++udrAaPzOaJqGJOAPCgHJiUPAnv0YaW2vr1obwDBbH+hfw0XumkinNdOlnkcHiGxdu3lf3YY F2LUb3n5fVQPY7g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QptuG1yd c=1 sm=1 tr=0 ts=6a0e0960 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=IQQy_Q3euI4hPQ5xFQ0A:9 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE4OSBTYWx0ZWRfX4sL4VtOcA4Vc
 BmnKyUY7XhBSWQiW0qiJMiAFlPza4WH5CG+m6yxnb9z/ciEc7sGPtv8y2Vsiw56FpJmr12EBZ3W
 3+EgHd26oUt0my9mTy15/1FTCu98uUpTWfTus+0f/DTwxLEhPhRgWytfDP5TL4PHtXTTJ2NDXeT
 SkI0CUKSbrDijEASzg2zc33HcPsNgIzuWzd2DqKSdseg7a0GHKK8ewQfak2QklATXxSpBDCYGcd
 SjpVCM0Tp5cpRTzhB5AhvhZms9a3uTYzW21fnD/8K8e3SxDl2ETCLvUuoQQSrglJyQqsbuytNio
 neGYFhrT53WBmFoD2tknU1E+GFCcD593yHj1vd3pGJvJbEuSIaFtXxJxRhr4+nIUN41hNK0mT53
 8Vpw8V+K6MJfxQSEdVwHrGrtzo9He4PrbeFf6rAGNzw2KQ6xpR1M58CWJBzLzEAOW9qQxka3lNm
 f84zXqT35PjAtDCS88g==
X-Proofpoint-GUID: 8wmfmVnFSyIA7DPoZlI4Z5ZJHOuDMYUk
X-Proofpoint-ORIG-GUID: 8wmfmVnFSyIA7DPoZlI4Z5ZJHOuDMYUk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200189
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253371-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E002F598248
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Driver defers probe if getting clocks for interconnect providers with
QoS returns -EPROBE_DEFER, but it fails to cleanup in such case leading
to both resource leak and potential use-after-free, since the ICC nodes
are stored in static driver data.

Cc: <stable@vger.kernel.org>
Fixes: 05123e3299dd ("interconnect: qcom: icc-rpmh: probe defer incase of missing QoS clock dependency")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/r/20260520190807.509871F000E9@smtp.kernel.org/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/interconnect/qcom/icc-rpmh.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
index 3b445acefece..56512989d1af 100644
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -324,8 +324,10 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
 		}
 
 		qp->num_clks = devm_clk_bulk_get_all(qp->dev, &qp->clks);
-		if (qp->num_clks == -EPROBE_DEFER)
-			return dev_err_probe(dev, qp->num_clks, "Failed to get QoS clocks\n");
+		if (qp->num_clks == -EPROBE_DEFER) {
+			ret = dev_err_probe(dev, qp->num_clks, "Failed to get QoS clocks\n");
+			goto err_remove_nodes;
+		}
 
 		if (qp->num_clks < 0 || (!qp->num_clks && desc->qos_requires_clocks)) {
 			dev_info(dev, "Skipping QoS, failed to get clk: %d\n", qp->num_clks);
-- 
2.53.0


