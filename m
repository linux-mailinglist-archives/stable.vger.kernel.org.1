Return-Path: <stable+bounces-242061-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGhPBOAe82kvxQEAu9opvQ
	(envelope-from <stable+bounces-242061-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:20:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A61CB49FC72
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1F94300CBE9
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 09:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071973A0B38;
	Thu, 30 Apr 2026 09:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E+VnZ4oz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cAp1kCLd"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F23E39FCCD
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777540824; cv=none; b=Uu69KwoDfDw4gbDHi0JtdxB6WTlGpDB4tEoU5Ze9145pY2pgjgGPYpU7QSdThi/gDT7BD2BWLDDg3EwCrcSN15n8z0LqY6+bw9H/20jEOSxXI6mIcF9yy7KEzdJENbWnE/9PzK2p67B6BtUeBfkHaA6i5RztQrZVt4j4kdvzCqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777540824; c=relaxed/simple;
	bh=XwmKwV05/7a1r/S2gniOB8WhpFrj9SJSwlH+8tfTslA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MmFPpLj82Oe9nJwk7e4c5tparT+Xx6qIzL7qKalHi8JbpY1NhsTWRV/1bs6A38Vdx8aiN2Fv6JsDFTXBMdM72teYc6JKfVxn5/9LVEbLg7/f/gGYVIrnK8sL9ZFySLH87EpuT3WDL8LTi3PUBVqvZjLjuFrPOvySKybJEl+19BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E+VnZ4oz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cAp1kCLd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63U6H5Gx256087
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 09:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=mIi3R6o1NfGbkbBGdhQvAo
	g6QMEwWJyHFwmk2yv/pDs=; b=E+VnZ4oztc2BiECqLy7qsPIF0XZKSoCn8Ly3Xw
	o6aghIRy7pwwr5Dt8shcgogMGPFJrLefsB00wspxpjyFHSigqPeCErM9Yca4YM2t
	hSUAMTvecGrS6bcKbIb5TepcLCo27BGbRvTdE4Ju4+sWl5ANaKkUqDLM72PD2nBV
	Vl+YxVCPmbVJsbtNxEwnYqFO/knCW5LX08/7DiqioWW/G5rSmXHCPKSix9f1U9zi
	+wHTbEO7BuLDq0vMJ1MCSLqJjiyKbfy27oqu1UtsMkuFyiCyhZGnx5HmL19mtswv
	wsud1b/nLOSa8cY9OIigM0k8SFsdvWsIP0lgGa/EU/s8YOTg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dun71k9g0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 09:20:22 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c70f19f0f37so447192a12.0
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 02:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777540822; x=1778145622; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mIi3R6o1NfGbkbBGdhQvAog6QMEwWJyHFwmk2yv/pDs=;
        b=cAp1kCLdJVHHTEcvrr7dHYSuFcM0INhA1qQg8A2+9xlPozEjALJZ+5V1GCe3D85VXz
         PYNv+28wmnex0TIvGKrH3KxXOpZsIR0VIa7rIXxJAArSp/V/fHMQtt7F9TA75RaNdTu4
         nw8XpXoUFzhWkgl78aKXEulEiluGjxTth2D3frJ1lEwRk7ibuWfh/0FwZrAMLv2+KxwC
         lp4jPeX/xQcWEpA7onbZUMQFpt9p4Xs9iHjpTzKwzXFDpu96WCwpCdfNGeTqW3/7YSc6
         gqhu3+ZCGDE+WKOjtQ/Yq6AwvbGDcc8HsT8GBFSLMV+9tMU8eLCSV0PZg7QZC85zdjY8
         DQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777540822; x=1778145622;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIi3R6o1NfGbkbBGdhQvAog6QMEwWJyHFwmk2yv/pDs=;
        b=OIfK03WmbpjVy9p3CtecaqEwcOn798u8WqsJkCSTdFq6+WlzYroE/pvtMMjTLdmJb7
         QfqOb23VBIOcYPN0N651V5RacIKEXHytLConnJETHm2w4eIMIJ857KGwTpQCPLCLdiKK
         MZLg/ExvH7v4hFi2CaqFWV/c1/1uruwvBtVH3eutcmXiEY5BATSWrhKp1yZ2D1QCcZde
         GxRLX8Kdq9nN0yKNucaVbSPP6xuMLpPP5U5ioFSTjPG94fuH7aEbZiWFXNLwiS+SP0l9
         CzSwEuexEPMQObmhJrqp22B1JbKkFtERIMo3bErXsj6GbD9fmdLeEmLxPmD7fmQm4X0J
         2uUg==
X-Forwarded-Encrypted: i=1; AFNElJ/OZXa+V/47rF1dkh607WpcEBWK9hk7ayinLiYu0Ljx/izisSDgGIZMRWfYL+6qsZdlLdihFs4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoKNKPZMvwaIVRH0YXhHgNzOL5kCSUx95y6akEWkEEK61pv/oh
	x7rEtOJcbI8aq/uxgCaC193KWtxCw+3Yq6rI6mRvrm5LHNLLDks3U5sUlc1FjqTaBeMiFxmhefQ
	iqFLgll/m+Ekh26hda5AfkrZR5d6MSMifexj0kEQE/vOnRtS61O8KqKY3+xDxFIf2DeI=
X-Gm-Gg: AeBDietvGI/MZ270hEDmvekg70AsOQYos2qGeP9zKJwWPGLAdnsrD5X6nR5sH55f/Kc
	XYgyDAO7oasiGQ3/+hMxlApD0fEGPbS4h+sJIAZ/6puSST1mXAAKGEzcHsdESTC0bMsut3COJ8v
	Z5Pf1+TKrunR88EhxKzLFVbM9b/l0e+ryuvt2FHceDKnW54csxpK0crO+Ph+mB6mWr+CjAURJgJ
	MKAUkq407tJduDYZAu4FHWKpbzTyEAVP1E7jSPCaqdDzkvyN9GWc+npdHmlua7ovlOkJ5Wj2BpB
	Z0txsZW7QPIgpF7WABRXpoy5Wqct2ocyWrzYqzFjkskklRmmnv+2Rg8YdpbCuhafKBCIoXDzO9i
	lWmYP3AGvFn2FCwM98qZHFTdxp6YXA1AH3T6Egmq+91A6uniRyMXjN4nKQGEHgw==
X-Received: by 2002:a05:6300:218d:b0:3a0:babd:b959 with SMTP id adf61e73a8af0-3a3d1d55597mr1785709637.9.1777540821924;
        Thu, 30 Apr 2026 02:20:21 -0700 (PDT)
X-Received: by 2002:a05:6300:218d:b0:3a0:babd:b959 with SMTP id adf61e73a8af0-3a3d1d55597mr1785680637.9.1777540821432;
        Thu, 30 Apr 2026 02:20:21 -0700 (PDT)
Received: from hu-smankad-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd5e6cf20sm4614782a12.3.2026.04.30.02.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 02:20:21 -0700 (PDT)
From: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 14:50:07 +0530
Subject: [PATCH v2] pinctrl: qcom: Unconditionally mark gpio as wakeup
 enable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-enable_wakeup_capable_gpios-v2-1-8c26ac795318@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMYe82kC/43NQQ6CMBCF4auQri0pBcGy8h6GkFIGmAi0dgQ1h
 LtbOYGbSb5Z/G9jBB6BWBltzMOKhHYOkKeImUHPPXBsg5kUMhdZKjjMuhmhfuk7LK422h3sHVr
 iplFZqjRcikKyUHAeOnwf9VsVPCA9rf8cY2vy+/7XXROe8HMLqWo6kQuVXS1R/Fj0aOw0xeGwa
 t/3L937jynNAAAA
X-Change-ID: 20260430-enable_wakeup_capable_gpios-cb9439ae8772
To: Bjorn Andersson <andersson@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777540818; l=2594;
 i=sneh.mankad@oss.qualcomm.com; s=20250818; h=from:subject:message-id;
 bh=XwmKwV05/7a1r/S2gniOB8WhpFrj9SJSwlH+8tfTslA=;
 b=WVX7FhxPrdhNLQHigmRZMUFbQiF1TQw/jD3pKP3p01r/x9Ru+OtECwdzaF6TXT+Ty4WM6xUsy
 EKCmeBoEanoAAUW3MFheWslbkKB/PeXyt9YxiFl+04c8i28uwmCT0U4
X-Developer-Key: i=sneh.mankad@oss.qualcomm.com; a=ed25519;
 pk=sv57EGwdcfnp6xJmoBCIT1JFSqWI+gawRHkJWj/T2B0=
X-Proofpoint-GUID: M97Yyj8lOwWrSFiXmelKq9YGQfnB5byp
X-Proofpoint-ORIG-GUID: M97Yyj8lOwWrSFiXmelKq9YGQfnB5byp
X-Authority-Analysis: v=2.4 cv=TvHWQjXh c=1 sm=1 tr=0 ts=69f31ed6 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=03pxqqae4PZ9oJ3FxUgA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA5MiBTYWx0ZWRfX1dFT6SvIAv1J
 hhYxHOJXbACpfn10qLD7T3eVsAFa7DGYri2d4Qe31xPde8csdHz/F3hfnR1sK4Mp8T/Rw/zPnFx
 eIPq9EGSaofKnHn5hE29C88WddDFonJqlvvYSVi0dkIZEpBj9M6C0orU8UYdVLFMhffmkzSEOcq
 CmOmHpaHY8LJpq1+QD3tJ59+7RcoHbamLzJyT7VIdeBx2EyIXe1aDvHdQCMvOlda+wkpA8lQ+17
 tq4j1ccE0BwAL/XA6u+rueh906GqYc1p+PrkvK7z5QWCcfYILOTtF+OqR1tnwoPy2kf/ZFV1IgE
 pXdffDaOZ6xwPP7KelI9railFzAqtQBvKv8Lza214IbL5Y7AnTOk8zTa6S3gmCwbLyK+rVuEb7b
 lJkoA2wbEAzAt5cdEjFY32TTXIZwZ4OVnFcS11Z1GM6FShvRZg6/POd7JppshrRbO8tNJkP8XKQ
 H42S8JvozOJrKHY/q8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300092
X-Rspamd-Queue-Id: A61CB49FC72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242061-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[sneh.mankad@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]

The wakeup enable bit needs to be set irrespective of the SoC using PDC or
MPM as wakeup capable irqchip to allow the GPIO interrupts to be forwarded
to parent irqchip.

This is set only for PDC irqchip using additional check skip_wake_irqs
making it impossible for MPM irqchip to detect the GPIO interrupt during
SoC low power mode since for MPM irqchip the skip_wake_irqs is always
false.

Remove skip_wake_irqs condition when setting wakeup enable bit to allow
forwarding GPIO interrupts for SoCs using MPM irqchip too.

Fixes: 76b446f5b86e ("pinctrl: qcom: handle intr_target_reg wakeup_present/enable bits")
Signed-off-by: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
Reviewed-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
---
Changes in v2:
- Modified comment to specify MPM HW as well.
- Spelling correction.
- Link to v1: https://lore.kernel.org/r/20260430-enable_wakeup_capable_gpios-v1-1-5de39bf06094@oss.qualcomm.com
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 45b3a2763eb85405fecdd4770ba3d4ab684563f0..6a24f9b5e4a979528ba6b5b87fd297c2783ec765 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1242,12 +1242,12 @@ static int msm_gpio_irq_reqres(struct irq_data *d)
 	/*
 	 * If the wakeup_enable bit is present and marked as available for the
 	 * requested GPIO, it should be enabled when the GPIO is marked as
-	 * wake irq in order to allow the interrupt event to be transfered to
-	 * the PDC HW.
+	 * wake irq in order to allow the interrupt event to be transferred to
+	 * the PDC/MPM HW.
 	 * While the name implies only the wakeup event, it's also required for
 	 * the interrupt event.
 	 */
-	if (test_bit(d->hwirq, pctrl->skip_wake_irqs) && g->intr_wakeup_present_bit) {
+	if (g->intr_wakeup_present_bit) {
 		u32 intr_cfg;
 
 		raw_spin_lock_irqsave(&pctrl->lock, flags);
@@ -1275,7 +1275,7 @@ static void msm_gpio_irq_relres(struct irq_data *d)
 	unsigned long flags;
 
 	/* Disable the wakeup_enable bit if it has been set in msm_gpio_irq_reqres() */
-	if (test_bit(d->hwirq, pctrl->skip_wake_irqs) && g->intr_wakeup_present_bit) {
+	if (g->intr_wakeup_present_bit) {
 		u32 intr_cfg;
 
 		raw_spin_lock_irqsave(&pctrl->lock, flags);

---
base-commit: b4e07588e743c989499ca24d49e752c074924a9a
change-id: 20260430-enable_wakeup_capable_gpios-cb9439ae8772

Best regards,
-- 
Sneh Mankad <sneh.mankad@oss.qualcomm.com>


