Return-Path: <stable+bounces-216902-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GT0ML/LlGluHwIAu9opvQ
	(envelope-from <stable+bounces-216902-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:12:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D95B14FE0B
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 21:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 335083050419
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 20:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CB93783CF;
	Tue, 17 Feb 2026 20:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ke6sBSXq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QFdVvGuW"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E00B29AB02
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771359094; cv=none; b=Aalhaj6//MMhcVkQCSoosuv12Sx8pkMdVoPECqwoZk1UPOcC53m73yXH4+3BSI3onBWjqueJFxA2izH85siE2moNyGex+Wb2NoeefSywoAXKpokMl4wTsxebigNxuViKU/3pN060kX6dVhhh6W31sSop+nQArEnZNilizP8ZvB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771359094; c=relaxed/simple;
	bh=cWegLftV7m7YffD98Ot4PCvsUEdERcIm2QMBl5ekQzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=t8RnPLzN0fqZUcSI8eIW/GCIMtiTqBlLcbDoV2/BxAK4SijzK5YJ/L3S9WYXNmrQYbSNtk7kx37kRs3s/XvB8C0LCwoNigwPqyHvAHLcDgSMbDbsvDniTvKgbgyY0/lkvhy5oUXsvwudKC+FIK3OpBmygJYDE0ejfqf4/70cE7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ke6sBSXq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QFdVvGuW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HEHgZ82743105
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 20:11:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=U4LWRwUn9sJIHa3iVPT1Ps
	amgzgdpUokfwkXUCeFWss=; b=Ke6sBSXqqtggbM8ASzIxNDJuDgvuGkB2x9O9s8
	9wqw7oz8ttfPUBIc6b/WU4J0TixYtte9jK9dLwPuYuFAlF0Cd1NDmYvrGlZrUjea
	jLroC4Elb7zXE+Vd0Q1fYY7Ax6ueqKC0ZgAsglpETV9H8ifVgbynP4jxRLkITsjl
	72HhA2y8lbUIzrRv1AZCxpLCW2cRi9rYo597b72z+TWKs8fBRWj9iyIKbQlXTWVN
	VGBOLp3Bum5+q5S7OwglHO3FRT28A5AHtrREk+s0UlypPuaksPy0SxLDjvNad1tO
	xosOx1dLYKw9aeR7d6XD8cpECDIPg6VfFJigvSeS916a1XsA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cca363a10-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 20:11:32 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-12711ec96fbso29547641c88.0
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 12:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771359092; x=1771963892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U4LWRwUn9sJIHa3iVPT1PsamgzgdpUokfwkXUCeFWss=;
        b=QFdVvGuWWrdVCTI8AoHPVI8kH6gBIkk/2jK+JKMigtqFkEqB53VkrWTiAnhfNl1w0i
         67chQwlXgeonbncCdEXBRT5QLE3BqHl/5tuHM2BZiMLBdzIDIuAHHMyRtBG9nzY7bJGc
         wKw7imjHeKdGiYUiczIk6qLMaTHJV8TqvNR7qB957z802HWleWkM0h5pCmNixonhZMwj
         tei3Vs+KvobUo/flPAWsAi3i09ZUA6VHcJZUZSRl84FQwCjAWe9HvUg6BX3p/7j/wPao
         nJugNkhxWjHxbW/3Xo7VENovpHotOQYvjl1cLw5m1xU7oFharGRDtsSZIOg/+fRnaFtr
         3wsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771359092; x=1771963892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4LWRwUn9sJIHa3iVPT1PsamgzgdpUokfwkXUCeFWss=;
        b=FYHkJT7uYxaB0UwzbV3K9bJ04TQPgaJrhy6GqDMyGSLqnH4b9KfBO1EKxkNq0yO4V+
         SJgLMo+vegapnTw5jxBaKPjsJ3XWfWNYSYhWPbLPqQ5+y62y0exByQOpMz4CXYvUNSNP
         vZ+GKBNJLgE86IyBP9AH+UYrLr2rpN7cgU0GXXNXVUm71wnlm382fK0LY7FcR9eq/Q3o
         PKm+WtIs+UA8j/mw+59Jffy1/2jphsl56GAb0up8KfK+YdvRwDc8srX5u9tBv3rAdeHP
         hyT6DVcqdK2cm+Q4pzGS424e8hv3EKBykvjsACk1HGV9aEVqExk3Co8k/pFR1FFDgYes
         4rYg==
X-Forwarded-Encrypted: i=1; AJvYcCVHAwUX9lUY46hIKU4BG4lfRixvYvgP3itq8XXeDAxDN2g8LINdmcOAGnHBET3WPYRGqZQ7G2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMKSJIlj7rXSlqoi5ou+3Jwbqeu/yTP62atfR2lw0ciFiW8iQB
	ZtZ49XG/ZW0OFFLvaw22/hlHjC6h4hMdxdgnoDabO+0DpYGWuftcmB85NaVod3pShcm9YDVS+Ik
	QsbQnuRFW4X1g3KDVo1XibF6uD817+p52D7l1dI4aSjSJhaC7BU9UK7BCpcw=
X-Gm-Gg: AZuq6aIl7Ye5O598FrvI5NexhJpPYEDSLTWeshbxyxEDQGxhjYMH0ce1RkLgZpMr3c6
	MNwZ/RCv01k6NIzIWvDsIfKN8vDIbuAD7UWS30NAIOrB4qZngHqeYGmYRTKj5VMjwqxXO5wCIC7
	7KRPyi9zCHPsbbu1x646Cl8QY7YmKYrwzC3flU7DwB9YHQXa9XVfIsDv5h5nPvoW5J4gNgb7Mpw
	9/ur3DQQuTV9upv2i6OUKKf7rD79/ORL1z49TkJ3yOQA5cEhpkl1L4nztoyk05sVYDov1S/SreT
	a0rbEmUA3UmXGnsFX9RwmRWRT+qjbZwNJPNVxLMuk/au8kUS6Sjta9MI2At/d3h1c+q9HVsbhF+
	GelbgaZUP2Y4dt4L2i/qo8Y2XjeFsaFsU0TAvxRg4co8pYmE7n2H9JBbyrngMhRNpny9Ild7TSs
	A=
X-Received: by 2002:a05:7301:1e4a:b0:2b7:f44a:a688 with SMTP id 5a478bee46e88-2bac97d96b7mr5221001eec.38.1771359092067;
        Tue, 17 Feb 2026 12:11:32 -0800 (PST)
X-Received: by 2002:a05:7301:1e4a:b0:2b7:f44a:a688 with SMTP id 5a478bee46e88-2bac97d96b7mr5220983eec.38.1771359091526;
        Tue, 17 Feb 2026 12:11:31 -0800 (PST)
Received: from hu-eserrao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb658531sm17319194eec.18.2026.02.17.12.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 12:11:31 -0800 (PST)
From: Elson Serrao <elson.serrao@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] phy: qcom: m31-eusb2: clear PLL_EN during init
Date: Tue, 17 Feb 2026 12:11:30 -0800
Message-Id: <20260217201130.2804550-1-elson.serrao@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE2NSBTYWx0ZWRfX+7vTDsuPQKVe
 TGqr+TDHg6nJTGixHUz2JW1KO9VQu+NUxdkf4kzJYVTCnhrGYE7E/xQH5VxbDUT8RvsQckRafse
 Der6Z1cNSybwG1LtSQY4JodYhFS6Ufw2q5n5Za0ohofn8bHTXnOfbCevEKHF/mkGGyjSQkta2fq
 4GSndIs9n/gkTrbGhvq51260/OLXWRhhX9ggrrE+auAxrYDUphbeXfgmAVWZw8G7rUhezmzgGzj
 MO+HCP491oLBf8Rep3SQGwgLpFvUYNDHPHBY/Hbeg11jFPml9MJX3JJtI2y2dsFmcQI05QtOrhi
 5hSqXDGXcFPCMwTdR0mAq4SxbbB5gu2QFTuO7QwvFuC36nkRXesfeg3vRpeoW0rUjtBqfKsdf6j
 aYf0Cna6zKh8YqZ64nIPukyZjObEkpyXsTfRmFjhR8XduIFEGpWza8NPt+EngYXo35ZTM5maWk4
 J6pnVimgiFaFx5CoHxQ==
X-Authority-Analysis: v=2.4 cv=b+G/I9Gx c=1 sm=1 tr=0 ts=6994cb74 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=49oE3CkF4HoBucdVWpUA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: BRH4-vIJ736nA8DT87DinvuLqqGmWJ7P
X-Proofpoint-ORIG-GUID: BRH4-vIJ736nA8DT87DinvuLqqGmWJ7P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170165
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216902-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elson.serrao@oss.qualcomm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,linaro];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4D95B14FE0B
X-Rspamd-Action: no action

The driver currently sets bit 0 of USB_PHY_CFG1 (PLL_EN) during PHY
initialization. According to the M31 EUSB2 PHY hardware documentation,
this bit is intended only for test/debug scenarios and does not control
mission mode operation. Keeping PLL_EN asserted causes the PHY to draw
additional current during USB bus suspend. Clearing this bit results in
lower suspend power consumption without affecting normal operation.

Update the driver to leave PLL_EN cleared as recommended by the hardware
documentation.

Fixes: 9c8504861cc4 ("phy: qcom: Add M31 based eUSB2 PHY driver")
Cc: stable@vger.kernel.org
Signed-off-by: Elson Serrao <elson.serrao@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-m31-eusb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c b/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
index 95cd3175926d..68f1ba8fec4a 100644
--- a/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
@@ -83,7 +83,7 @@ static const struct m31_phy_tbl_entry m31_eusb2_setup_tbl[] = {
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_CFG0, UTMI_PHY_CMN_CTRL_OVERRIDE_EN, 1),
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_UTMI_CTRL5, POR, 1),
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_HS_PHY_CTRL_COMMON0, PHY_ENABLE, 1),
-	M31_EUSB_PHY_INIT_CFG(USB_PHY_CFG1, PLL_EN, 1),
+	M31_EUSB_PHY_INIT_CFG(USB_PHY_CFG1, PLL_EN, 0),
 	M31_EUSB_PHY_INIT_CFG(USB_PHY_FSEL_SEL, FSEL_SEL, 1),
 };
 
-- 
2.34.1


