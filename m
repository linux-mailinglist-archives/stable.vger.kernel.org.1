Return-Path: <stable+bounces-230697-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wL0dN3a/xmmKOQUAu9opvQ
	(envelope-from <stable+bounces-230697-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 18:33:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDF63486C7
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 18:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A0B930D79C1
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 17:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89583C2798;
	Fri, 27 Mar 2026 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ebSdERS9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EfpnsUL9"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76451396B8B
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774631584; cv=none; b=YZId/6z07mI5hzQGEatrQRymBK97EpGPzLN5HhcXh7lXLosXK1Tgqwd15EX/7weGVAzfWrefhlLQrMjYZhPkcIsVcBcZRZEmOsV4Vjlg8VkdlBD+ujK+QB1ySyVcBl2ifqpjqehkaegpab2C9J/REvWOvyeKdJrRQxjXVr2qe0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774631584; c=relaxed/simple;
	bh=/88q1mBjtIUH3ikMUjzzgHW29LsNAOlut+Hvt3btdUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EO6cap+97NhEqCWBByeC3VqM0zHq+nbCafwDTP0h2E6klBwdBAniZuvKqTjLpthWX1ZapJWjCDrjoYolGxSIz3uV4zAhvCWbC+CJ6SMJUtmg3oQD3qk/qjbo8WMfPG9B68YhdMVuvAWQdUFU2XBUHHawVmir/Zt7Ka2pfC7ZgoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ebSdERS9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EfpnsUL9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62RDhT2D2615713
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 17:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=5zMoHjLJU3cM1Hpjqd/5HAsL+E4+G1/iC0T
	UDeYx3Yw=; b=ebSdERS9w8kS+m1wOE7PgtzgJ1NqC5xoC6JeufhDbRWIcoVzVWQ
	ZhY3xYMiXmZG4rI+ETnxPE3lmSVX2pk2V0Qet1CNzpqQTgw/g6HYdalyjRxWSSML
	Vm75MS9QGlPY1jBj6GTiPlMgOKxTBDR3c+XwYp7xVd+kMxNBSuo/jGnRYBSJZoGF
	GX6OA9WwJYyEpOi43jzI/QPVO5P/QYCyZE6NIp5sVrMZD0qt1MQ8QSYUkErEvYQO
	eJMwSd2+9jQ6s5tCYFob5zqwUUBOSWdmUUZ+WrjnBzEreFVpgXM/5JTY2OhOXx0h
	ViLmvjTBaPJj5oo+gKnidVAP6jvDdJr0BAg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5bxvkxhp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 17:12:59 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c7424d91b2dso1493045a12.1
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 10:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774631579; x=1775236379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5zMoHjLJU3cM1Hpjqd/5HAsL+E4+G1/iC0TUDeYx3Yw=;
        b=EfpnsUL9ETzeJ+yaD6bFVP1CegfbBqDQBBM57bMKXpqUj+MPo099xMjIXaxxDo9R9F
         sH7XXVKiwIR5thgAjqElDluo8aFMBfmmvqgT1KXL1MjfyucEsQmmiQgSWjyqysRVPbEk
         UZElRQv0EmLJRKqFtdjDpyHfxVrYitUm+t8J3BsKYR+qcmAyJaQINbBgwDBhbOuq/Ykz
         Fn/WCmS0/xRCexS72Au74+ARnw4Qpu7y+9a4vMljbWANjJlb70op8nblvPOau50XiPdU
         twYdJ2nt9m/jlQlW7rLiQ9o5GWrknV8F++KDC0ZBHqlAV10FM+Cy6EHQ0NhMe1jwGsok
         Bm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774631579; x=1775236379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zMoHjLJU3cM1Hpjqd/5HAsL+E4+G1/iC0TUDeYx3Yw=;
        b=VjNUmYc+T8PninQfWTvGgNIUk3B0UzxL/ukZW7kCiYvOnqWTjmU9PFCeZCMrnkC1OL
         NzYFpIxJtMWqTkpd24pwZa/zzo9IzLTA8cPXeKaKNHsqserZXaNHk2WIFyvXIaUiTbDM
         7NebvoHyILmm4AuNpZXzeWek2dWA4CsGif2zc9wplFpAIx9Rlstksvy12A8r1lk0uDNz
         JDi1C9wbQgq5VUOwJYqFsC0OPFJZz1L8c1RCFl/CL7ypPeKOL8ZQ+UGI+CooQYxX9zCj
         Tn9cGrW7eoalrAPugKTIT6oXwmaoai837N7l+Ked7xRtaLUhLmHhiVLgPxhRM9nd+86a
         oeMw==
X-Forwarded-Encrypted: i=1; AJvYcCV28qvJTr2aKjvXiX+QuZYAh9tS2sy0OY5B9WPtPMunI4SpJ7HNhasHh0BB6udCBEDLy9SEB/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWf/DkOdObPVqrKapjJ3AdIDsaABF9+ErWrgnxHzszOGZMqyCJ
	hrgzgunNem2ksnt8FyTpavUuNuWbFRUxeYnO4ufw2Yz+qi5fM8Dm5gTrZs6bP8feGyP9o4bhVsC
	6S9aw6qY9yN8941bXQoIqNCkyRZN7dNII+45cN5wINr/TMaANVtxD5r+AYhA=
X-Gm-Gg: ATEYQzxcP1BZBoTh9cFQyRXzM6sio+Gu1hpAG0dk2lCE/oHDd8Q5ZJfS8W6LHzoXJcs
	fSoOFtbTn3ikPHsoKJP4NZCM4PPeXZ8V1kuBxK6q0j989CpwxAa+1XFafw1fPclUCKQemr/oihX
	jgQT369ZvwelwLFc7tmVD/29gBisU/gqeptQmSzAgDTehiNvwA4fN4DpQvRw8g19YZu+GarBcDH
	a4fO7sl/+x8hH9Rt+xiwF9JfD/uGUtIdCwQcA8lfwvyrPnY3qz2dIYo5bvKpHRMn31JMaWXkLMw
	8LTa0T2N/ZdmmPpM1/y14cOA+gMs45dzaP3Kz6pjp28PaY4x2fiDuhyO5EDIAULYFtAPyWbBozo
	7CBKGMF/UHL10GgJhqsGLn6eKuCJKijPpSV5fqlRY8GFHfOkR
X-Received: by 2002:a05:6a00:438a:b0:82c:7f08:8826 with SMTP id d2e1a72fcca58-82c95e915fdmr3259549b3a.17.1774631578717;
        Fri, 27 Mar 2026 10:12:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:438a:b0:82c:7f08:8826 with SMTP id d2e1a72fcca58-82c95e915fdmr3259515b3a.17.1774631578130;
        Fri, 27 Mar 2026 10:12:58 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c964f9e9bsm2531517b3a.49.2026.03.27.10.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 10:12:57 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, stable@vger.kernel.org
Subject: [PATCH 1/2] pinctrl: qcom: eliza: Fix interrupt target bit
Date: Fri, 27 Mar 2026 22:42:39 +0530
Message-ID: <20260327171240.3222755-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zRpmxkR6tI65tVxOOFxU59N89w80b4Cd
X-Proofpoint-ORIG-GUID: zRpmxkR6tI65tVxOOFxU59N89w80b4Cd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDExOSBTYWx0ZWRfX1BHJSYSpMG6y
 jAaJ0LkiiFWMTw0pvjobpmCAn6LSXOaQvPiTW9IpAv+Obp4F66TADR2exhYjXsYn4OEu8DC9bPi
 0NPDntlyd23E8Yc+dGIkm84M74j7xiFZRGRq6uwxmdmuYKhHPQszdoseg1HG5/vO223vLiuG8yl
 HG/BFvPsyGuFWDzj0kGF7rA9RpDDZOg+8ojKQES4pmdHl30rG36mLuLr3k1q1vy3ulsIF4qhuR7
 4ORqb+8KUT33VTuKSr9GuLrGpFMOBaTbTXkss/OApcUeN+3CI5Nzc1bMXYf6k04slr/uBsXKIDH
 YklKZSHZ4VRQSXBfu104WV8Ieadgko3+CZ+o2Z0+wKPV4kcRZxBUo+ThJiBxjW36BOguHnr8olL
 UolcgsG1ay49uDpzzGV+Q16/+EsLgRrTaT+keZREb7O2feyEFIkgQqEGM1l8yyMS4tBQp0wZhmP
 8dk615aL06nW7PQSqag==
X-Authority-Analysis: v=2.4 cv=ToXrRTXh c=1 sm=1 tr=0 ts=69c6ba9b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=_UdXETfmjGnjTIlQpucA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_01,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270119
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230697-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.ojha@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2DDF63486C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The intr_target_bit for Eliza was incorrectly set to 5, which is the
value used by older Qualcomm SoCs (e.g. SM8250, MSM8996, X1E80100).
Newer SoCs such as SM8650, SM8750, Milos, and Kaanapali all use
bit 8 for the interrupt target field in the TLMM interrupt configuration
register.

Eliza belongs to the newer generation and should use bit 8 to correctly
route interrupts to the KPSS (Applications Processor). Using the wrong
bit position means the interrupt target routing is silently misconfigured,
which can result in GPIO interrupts not being delivered to the expected
processor.

Fix this by aligning Eliza with the correct value used by its peer SoCs.

Fixes: 6f26989e15fb ("pinctrl: qcom: Add Eliza pinctrl driver")
Cc: stable@vger.kernel.org
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/pinctrl-eliza.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-eliza.c b/drivers/pinctrl/qcom/pinctrl-eliza.c
index 1a2e6461a69b..19c706137f81 100644
--- a/drivers/pinctrl/qcom/pinctrl-eliza.c
+++ b/drivers/pinctrl/qcom/pinctrl-eliza.c
@@ -47,7 +47,7 @@
 		.intr_status_bit = 0,		\
 		.intr_wakeup_present_bit = 6,	\
 		.intr_wakeup_enable_bit = 7,	\
-		.intr_target_bit = 5,		\
+		.intr_target_bit = 8,		\
 		.intr_target_kpss_val = 3,	\
 		.intr_raw_status_bit = 4,	\
 		.intr_polarity_bit = 1,		\
-- 
2.53.0


