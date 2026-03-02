Return-Path: <stable+bounces-222541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iO4qJ0FKpWn17wUAu9opvQ
	(envelope-from <stable+bounces-222541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 09:28:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A67A81D4A12
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 09:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CEB0F3006991
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 08:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D4C3803EF;
	Mon,  2 Mar 2026 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HE8oc1t0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g9dvTJHD"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4155377024
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772440122; cv=none; b=giubtWsQCkYvXwQqr9A4k92m6HPjkfmhff5l68L/yBySQI27AM199nB8oxwZxKtyDwYxz4FbolPFlhOXfRSNysy5pzBd3ASSGjaU/oFyNkGdUuEalfYVsXftQOXMMBWOd0ORuhHHUWcRDtA9uTkiGKlAOz+jZ6cGjP+46ye8qiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772440122; c=relaxed/simple;
	bh=Y5aDWPMKW2ZYmyIHMW0epLhTCjFZ5jh2nTzoMStbjRQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A6XlCy+BE7y6kmt28cw6eiLQvAlb1mWC82IXVkDc1mHhy1G5Soj1HdSxR23KOlYENzUsPGcqbZechDHZ0Q5eL34zC/LYnE2dhAnYbln8lrPt68LTG9YuZFTrdCXBCPXMxdoVsPvaH4EoyvrGOVtzo1PhaZq7f6QXCY98wpVqxwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HE8oc1t0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g9dvTJHD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6226s5xd1614827
	for <stable@vger.kernel.org>; Mon, 2 Mar 2026 08:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=V/IVakVW78BdWNeieKZ4TK
	ptAL76VoMJvEg376hXkcI=; b=HE8oc1t0BdZpj13HBTKph0+bsbEHTwVso93VoM
	Fdj91+dDjiunQaY8xrcm/30y1q2yMiibRCYs5+iNmEyeuN8lWxLehNnhiE4ySmhU
	5g3Aqkni897b4V/csiD4fPhOgHtzYCElpKizwIPifQ8404JEy4LFEGk78652Ypm9
	RpuSNaaQ34LplldiwkCyCFJdlbGIT8vxz4naQUevsQs8y1plmGN3CR2l4o9zi8O8
	Hyddg3LjV9C4q3eLT64ER8aTPN/869/iv2mErfbtaENUAQqXBCkjVnnT1Rsx+R4M
	h8W9cDkM9MZ8uA7aAhIV+FZdztmCtM/nRv3Pf+gHf4s3GU/A==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cksgrvs2h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Mar 2026 08:28:40 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-899c4a7c6c4so557867966d6.1
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 00:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772440119; x=1773044919; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V/IVakVW78BdWNeieKZ4TKptAL76VoMJvEg376hXkcI=;
        b=g9dvTJHDjDeiBb32XbL68iIcUw2ckXSHAzqio+b0lq1e8snKQf2BPahoY5BI77QiY0
         Vv6A+1MM4m5m3Fkwlgl/3A0M9/YoGd7dcki6RoTZo+nm/0y+PYtltI/frOmZmnEb6w3H
         kPuBqLRpyA161+LHTb9yUqGXGC2+OebLHzFdztMA1LgF18RAIHttz4iMElefnDC95tyv
         w2UoNEOGjpuy83oOdpvXnmzDZ6Q6PO4L/Nlv1H5jbCtTOgnPr6mcbE1JcQOSLRplLHsx
         x6wzalEBryGdoLyyfc+9peR0NQQfwY2STW+Bpo4diTGqwgomCQT7AEC+RkWYh4fMWROh
         UFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772440119; x=1773044919;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/IVakVW78BdWNeieKZ4TKptAL76VoMJvEg376hXkcI=;
        b=ShjNtqUGi/IjDH5vGpowdN+C7gPnA0mICQ93rfw2PeuY6XXpu4aRGOukSpR/3c8NCM
         XOnN8kcEpGnAXm2D1N4LHo5Bhkt3UMJ8ygzs+pboYhdOHfULS7fQp+zGVglSa4QTH5Qf
         1FpjUJRnweN+X2XCDpiwN5PdBeGh9c/twwtwvIUsScknVugHZ3jGuXRjRLQ+Ugmd92CB
         EAOumhuomPLy5R1Zf7uGfBo8D8ju47xvFh8HDwZzfAv+oF7s141Wug+LNkSw5da0j+Zs
         EYMSDuYdJx+aUDv2y0q7EujuoUSx3WplSEwb/v3E/GgCxd5T+c3FBAUqu41zPrEpiFtY
         Of/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmQwGcrN07kQBRb/ueNoDMd66fsgWkQG7mE4U2RM20gP9lEI5L9Axdlq8BAkkfU0S2sDQFJDk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy28C8T27GqaRisKNhAmRzNYkgw9lW09aMklurR+WrfFlYNQdyS
	vL+YsfMq2M7+VIBrh512TItvA0COR1lo5P0mu3SUcJV5CH25dcvjVEvW/Hof2q5K3oTJpJZbxKz
	YQXxoU+IUZ1ttREEp30ZJdj9qrqLO/21k+LVSTi3WN3X8FTk6hQuSJwS4MT0=
X-Gm-Gg: ATEYQzzDjXYmeBr0UccZLVxXSSdfbgADdsKXZjjq635ltUg5jynHnfE2a0nVkORdLEI
	T/7k9LEzc7PTN9DXc7qTnnqzrcWUrLs41iPab7Bk6Gx5FZ/0iEjuVYPqR3uP4pxBFDB8qPTKATk
	fv5CW4YCZqb6U2D1w4HXzVzc65Y++u0LpyYuNnW5NH07p1nfkS7zTOoOOC+0rc5Nnur9pDg59dx
	l31TDKHuRe3muDTUkm2hYLFKEpmMdBjbEevqIz3YCDfgFFsN4V5iYSSkzzld7Nbos0Ga1hNy3OF
	MdN5g/Q+tYJXx+5u8AnRSca4rsBdAfXd4le1LyJwezLpdv4x0LRX/K8nEumnQ7cDXA6UTbgC4dq
	HyHLcUTlhP0vc4fQ8TNLJ9tMVk0jW7Yb4cu0rDt3L0z2Tk6mSGucgXxrjrT5wZqY9n/4FE9dTJf
	WKdnUtjkM=
X-Received: by 2002:a05:6214:5013:b0:899:f39f:b884 with SMTP id 6a1803df08f44-899f39fbb42mr44298006d6.9.1772440118999;
        Mon, 02 Mar 2026 00:28:38 -0800 (PST)
X-Received: by 2002:a05:6214:5013:b0:899:f39f:b884 with SMTP id 6a1803df08f44-899f39fbb42mr44297846d6.9.1772440118576;
        Mon, 02 Mar 2026 00:28:38 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7193227sm101354696d6.21.2026.03.02.00.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 00:28:38 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v3 0/2] phy: qcom: edp: Add DP/eDP switch for phys
Date: Mon, 02 Mar 2026 16:28:28 +0800
Message-Id: <20260302-edp_phy-v3-0-ca8888d793b0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACxKpWkC/2WOywqDMBBFf6XMupHJS6Wr/kcpJcZJDdRXYqUi/
 nujXXYzcIbLuXeFSMFThMtphUCzj77vEsjzCWxjuicxXycGgSJHgZpRPTyGZmGcrJFUY6EsQko
 PgZz/HKbb/ceBxncSTr8nVCYSs33b+ikVkMOyrNDqohAmd4XOpSKtjJHKaWfRCIuKW9hdjY9TH
 5Zj5MwP2d+emTNkQvKyFFXlpOPXPsZsfJvXXpmlA/dt277nI38L8QAAAA==
X-Change-ID: 20260205-edp_phy-1eca3ed074c0
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772440115; l=1579;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=Y5aDWPMKW2ZYmyIHMW0epLhTCjFZ5jh2nTzoMStbjRQ=;
 b=OZ8EKpW3QxKtd+ZR7RvubWubP4PytrhWZXyB5nSga4Da+OIr5xCShiLPwc0PjJIW8Q0QYTcG8
 TSW8oFDVxSMAPVcnFIYvGAIvu7j317wZS+BfL+zpqRrStJjMta9PGPA
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDA3MyBTYWx0ZWRfX8P3EcaLw7Jmy
 NdVVLeVEzVEZygH/dLR/vkkTQrEGQ9ZHVr6uH7ScnGpIXA7BXQC6dbQkNBWJum1Pf9h/PqyAjEc
 tnSvOdM1TrXKqT4VcsP4LYCzUC6b28/I+aTgQDKAkw6qYD9Zz4KZjFB4UTiqnda3CKWm8C4ZEhL
 v0G00ut0g5BBqE50ViWNPJm1VUFtWDJgbWX1ICEUDx2tlBRaTBk/mH/yYPUdDJgc/srflw47wMi
 pRYcUgmVIYpgSf7JmigfvccQNu7OjRzObuVqr81PdfT3TTx2W5+q+OLMx24I6O9wcw/IDMziSZe
 25MjgtgWgo6z3X5L6d9Qu+71JqnJElWOHn/i0qXlv5rTJEUKU0ZdR5+f9vl94ZjjDwHPnwJ2RqP
 aIA/WJA7IPMQus9W5Eb2msSX1PuazOm8ou1qttQsycZu1zkD4GJpnyMchP7+Vbz3BKZCSebqTbi
 n8Esvm5R15IySNtTaog==
X-Proofpoint-GUID: JhlMkHByYisNmM8-UdU40-FWMEcCet4h
X-Proofpoint-ORIG-GUID: JhlMkHByYisNmM8-UdU40-FWMEcCet4h
X-Authority-Analysis: v=2.4 cv=Zqzg6t7G c=1 sm=1 tr=0 ts=69a54a38 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=M-2OMZX0rM6BGFiE4MwA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_02,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020073
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222541-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[yongxing.mou@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A67A81D4A12
X-Rspamd-Action: no action

Currently the PHY selects the DP/eDP configuration tables in a fixed way,
choosing the table when enable. This driver has known issues:
1. The selected table does not match the actual platform mode.
2. It cannot support both modes at the same time.

As discussed here[1], this series:
1. Cleans up duplicated and incorrect tables based on the HPG.
2. Fixes the LDO programming error in eDP mode.
3. Adds DP/eDP mode switching support.

Note: x1e80100/sa8775p/sc7280 have been tested, while glymur/sc8280xp
have not been tested.

[1] https://lore.kernel.org/all/20260119-klm_dpphy-v2-1-52252190940b@oss.qualcomm.com/

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
Changes in v3:
- Rebase to next-20260224.[Dmitry]
- Only enable TX1 LDO when lane counts > 2.[Konrad]
- Link to v2: https://lore.kernel.org/all/20260213-edp_phy-v2-0-43c40976435e@oss.qualcomm.com/

Changes in v2:
- Combine the third patch with the first one.[Dmitry]
- Fix code formatting issues.[Konrad][Dmitry]
- Update the commit message description.[Dmitry][Konrad]
- Fix kodiak swing/pre_emp table values.[Konrad]

---
Yongxing Mou (2):
      phy: qcom: edp: Add eDP/DP mode switch support
      phy: qcom: edp: Add per-version LDO configuration callback

 drivers/phy/qualcomm/phy-qcom-edp.c | 176 ++++++++++++++++++++++++++----------
 1 file changed, 129 insertions(+), 47 deletions(-)
---
base-commit: 3ef088b0c5772a6f75634e54aa34f5fc0a2c041c
change-id: 20260205-edp_phy-1eca3ed074c0

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>


