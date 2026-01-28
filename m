Return-Path: <stable+bounces-211961-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HjoLaX/eWm71QEAu9opvQ
	(envelope-from <stable+bounces-211961-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 13:23:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 191A5A127A
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 13:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D72D3002917
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 12:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A78340293;
	Wed, 28 Jan 2026 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pgszGs9V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JqKaNgmy"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4D92C11FD
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769602973; cv=none; b=sOVnUc3dQQtLwDgjvbEIERk+BC6WWW+JDupxio44YVTEB4umuj9HKbclAYvYYHnH2IKwEw7istoM0ajwg+JgExEpnULgMr5+nNQyD7f3G/JoJXaHcu3LGnxF8WLnb5ihPNuPwXdlefJoSxeACPgWBPfLds1QQl/hvQnFmrxdxic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769602973; c=relaxed/simple;
	bh=4JMdE9NJQVFXpuxNLlszdXNC+CgVssf4XKGlXAmp3zo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dFPgcNPpZfolF+3PKQ8qzt2AvykkxglcGBoYt6HiiHpn0E15lHDvfWqN1mCr/Z1yOOt/ZGUEoyyMzUi0zk9rrB3cLebrFHo76CNypWL7Kex9mVxzxvuJOYh8cuMOTvqIWGzJx+AOTv5ZCUmPfz3Y5T9gzXsB3mXo3tj/YcYpwa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pgszGs9V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JqKaNgmy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S92VtF254542
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 12:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/o5W0AU+AT5/7iehDdb36k
	TbaGoQ5vrsHDFBVhX5e7g=; b=pgszGs9Vzxsa66dMmFUb1fv2phHV56HYtNAg2y
	ZZ/u/vEWMZpM3UTFAhLrKRB17y7mudFJ4e2B/rQI2J7ScUpvMBrZb9m7kLkR+mgc
	CS04+U8l0/iyr7AHPyRCJ33nEpUgQU6M0tEaCji9K7mM1lOzSSi34cXnhmUgcOIS
	FFD+ndBgfIC916sfheDmAttLFMl+frZXvN2RV5evK1HRvI9dDRad9tvpZ45EitkA
	gDw0lNtXozS5JGoS8bhhOKMOL5qvIuz/2aLsxm9RAecOWJTK+jXBVjmzBeD9SzbZ
	Csgo3pZBk0A+fK3lA9dAfAkNDEcfdCRz3mx/bypTIskrL6rg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by20y3ad7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 12:22:51 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f2b45ecffso106734805ad.2
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 04:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769602971; x=1770207771; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/o5W0AU+AT5/7iehDdb36kTbaGoQ5vrsHDFBVhX5e7g=;
        b=JqKaNgmy/jwWPh/BwzqFDV1+bmCIOqcqQJkAFDNH9i9NRAkU+b7resvAaUgxjpZW+2
         4sb+aWTI2JhKKrXbESstmNF/Dpb8ss5Nfy+FjVr2X9CObjezdaNYqpMqiash4avi8Hww
         QQlI4IBkup4oKmeVL0XNdvTWma7s5GayfBe5OV+sp1zld2UYwZPqXkRaMzTzGgbgLCxz
         87QSqOHo7qz66kWGih1kmxvsdWpkn7TuKFyeCRfVbCq95nFniTqmsG6GCH+4l5ym9XnK
         b6q1UnaQQpvlbBMdqWgnJBcTOzCxNAKnxyus81Eze83PU34yX8CflX3g2S+yR/wiI/G9
         QeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769602971; x=1770207771;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/o5W0AU+AT5/7iehDdb36kTbaGoQ5vrsHDFBVhX5e7g=;
        b=pAvraZ8n9rkJ2dNiFE0xxz0dvc/gTWSSgETWVB8+6TQrFDBWCUHcFW0ZFpHE+eht0j
         07XvUpJKut2gmEXsZAvtFxM5KYlX1U027qRwPa9Gk/b2HduS4k5zYleWFVn+zT0v1dl2
         Vm/bEqlkLcqIOSOT6OR8Lvy7ghkWl4WcfG0aILHrshx6YkxYWDDfZvxirmM0r0BLbmFC
         i09ob4omzs8t4ZRv7AjkPLzX3mu6UwMm95GFJoj2UB7xkpTyQg4P5HGFlS45hRS0PidU
         rLmn3aTo9LhhdrTnSKxN/mMbiW/I9J9k9aNX6MiUAewvDEkIqdTxf0hLGdyDOHAou2ep
         DPKA==
X-Forwarded-Encrypted: i=1; AJvYcCVKjzcdmzm+eHBJWeupg/NXEaKo6BhNqpIQ2S/Bv7wNU7IbxuoelmZeVl7mWqCzzrFepqaMLV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkeku2qaeJf880FcYyFYYpcnhzeHo9c//jog9J7osO2FQ++HRp
	KSKHnoGescuIFuZKmWJekYGIuBdKFTimNhjx/2qm79OBE53VdNs8m8tq0HI4TGTdNFUVBaiVqHE
	JjhQjXs9ywP2A5E9003TJgKG9i8EmyvIFcZwNnX00Eg/5Z5XBZh5q94AbgA4=
X-Gm-Gg: AZuq6aIvawVBGjz3UEoxbmA3CklDaj47wZyONfTRRuum4jgrZDkK2yvma4uQS4dvZ/u
	fv9gZfV20A79U0ymjffHJodPCz59PXKWEzZzBV9FJoG0LiLpG271TfQQMNB+XQpXlSqA9j2d0TN
	pDvInluBnXICSXhxEBVLjrPM/ZUiF4XMXacYW/z+hCxwk+PQSZi/nzzrmfFouax7ePTPtSRWNLo
	+UE9I3fA/dQlsfEOv6QR3K1vCu6ZKoi805qeQgV5YZ40XHEOV6QcKcARcBtKeEXMyGZB6LTnVjX
	eAl1y9mNWdrrAU4KEKNFumWR5sWYTCKozA1V3aiZTiap6H5dUf2e8ub1GZMjHBZa6u9C8ZGNo5j
	DAql6EATvfx52bfem0AhheD3aBA8XtZpZ2asLyFmZiylS
X-Received: by 2002:a17:902:da8b:b0:2a7:d7dd:8812 with SMTP id d9443c01a7336-2a870dbe96dmr50894245ad.38.1769602970955;
        Wed, 28 Jan 2026 04:22:50 -0800 (PST)
X-Received: by 2002:a17:902:da8b:b0:2a7:d7dd:8812 with SMTP id d9443c01a7336-2a870dbe96dmr50893915ad.38.1769602970368;
        Wed, 28 Jan 2026 04:22:50 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6ed92dsm23358975ad.93.2026.01.28.04.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 04:22:49 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 17:52:42 +0530
Subject: [PATCH] PCI: qcom: Prevent GDSC power down on suspend
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-genpd_fix-v1-1-cd45a249d12f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJH/eWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQyML3fTUvIKU+LTMCl3jxEQTQ+MUy0RjC2MloPqColSgMNis6NjaWgB
 e7N5fWwAAAA==
X-Change-ID: 20260128-genpd_fix-3aa413d9a383
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769602966; l=1865;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=4JMdE9NJQVFXpuxNLlszdXNC+CgVssf4XKGlXAmp3zo=;
 b=iT65jbwLJOP5XGBDzhM2tkLuvQr9kJYCj+Jh9tQqitACgbFyv9ZReugFb2tePaYavuGxnDtqQ
 /SwDtuigjTOAqN2RvKZqeyG+Pr4CObKjntChHdFG2E5KQ3XjJ7lRkBn
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: -QTEm2B50veha_8F76fhwxlForCpXLvI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEwMiBTYWx0ZWRfX0qnn3V4brZhy
 8VjvR8J9xm9VVtwiAryusKM0rWOTh3O8F+HaRKGQf0Q5F9ligLeGvdivhrUtHg0m1m5sDgSIzCi
 p/Zwh4935lbLTHycbxM2DoET0QcBcRl+DSJLehepM7JxFf3SWl0Lld7PJ64o/gy5/xoJARQxGjx
 6CWcPwYzFwJsh441AZ6op17JCUmEcv8vpmLkUedY+UPaJMUHiiR+ox9JucXQKrNKXy4llMdDhHI
 0cGGJghLrmJ68ISODjERn7yhdowZi+NIbELo1RmlOSTu0vtPCBrEecl6KM8I5+0NpTFcZLH/mZo
 xDNKvRLpcNu6bCYy0h+BU9907FZg7ftiuA8HnNWSA6kGdwFeIF0e1hbqYfSvZqnoIOeAlmMClg2
 92d1VKulrOkanAEi7G/9z30JwT0xnZQDp3WHRp4HZ+sZPuCLHtfY2CDchKBvZj/qe+G2lV+4e9/
 n+QqbC3rCbxefphkstQ==
X-Proofpoint-GUID: -QTEm2B50veha_8F76fhwxlForCpXLvI
X-Authority-Analysis: v=2.4 cv=IKgPywvG c=1 sm=1 tr=0 ts=6979ff9b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Py5lcOcq67Lbq8UMOfUA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601280102
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211961-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishna.chundru@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 191A5A127A
X-Rspamd-Action: no action

Currently, the driver expects the devices to remain in D0 across system
suspend, but the genpd framework may still power down the associated
GDSC during suspend. When that happens, the PCIe link goes down and
cannot be recovered on resume.

Prevent genpd from turning off the PCIe GDSC by using
dev_pm_genpd_rpm_always_on() so that the power domain stays on while
the controller is suspended. This preserves the link state across
suspend/resume and avoids unrecoverable link failures.

Fixes: 82a823833f4e ("PCI: qcom: Add Qualcomm PCIe controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 5a318487b2b3f6c61d8f5b1fd5cdf2738a1f1dcd..314cf334a313dff35efaf0c023597e6eef483925 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -25,6 +25,7 @@
 #include <linux/pci.h>
 #include <linux/pci-ecam.h>
 #include <linux/pm_opp.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
 #include <linux/phy/pcie.h>
@@ -2052,6 +2053,11 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 		pcie->suspended = true;
 	}
 
+	if (pcie->suspended)
+		dev_pm_genpd_rpm_always_on(dev, false);
+	else
+		dev_pm_genpd_rpm_always_on(dev, true);
+
 	/*
 	 * Only disable CPU-PCIe interconnect path if the suspend is non-S2RAM.
 	 * Because on some platforms, DBI access can happen very late during the

---
base-commit: 1f97d9dcf53649c41c33227b345a36902cbb08ad
change-id: 20260128-genpd_fix-3aa413d9a383

Best regards,
-- 
Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>


