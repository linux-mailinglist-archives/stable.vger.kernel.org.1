Return-Path: <stable+bounces-241992-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKGqDKju8mnhvgEAu9opvQ
	(envelope-from <stable+bounces-241992-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 07:54:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E491849DC38
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 07:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32154301C97E
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 05:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29203371895;
	Thu, 30 Apr 2026 05:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YsD07KxO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VMQb29MZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5D835295E
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 05:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777528480; cv=none; b=tCz4fEvsMv0XcYgWLUxsKZGZpObG6bNe59jstY1t39fKSlnQx+DFu5Y7mAK7I9eZ189jAVI7AeJwQPxQb5ngqv0jdoXIcZl1kM8alZ/7M/cFEksS1DPUHiKjYutXL7nbaMw+54DjFWT01+jhl08wM1btGcWYxzVMG1ZkOL2sUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777528480; c=relaxed/simple;
	bh=BpJgaliSBx+fohZC+GCBnwXiaNlDF3bUebjJWarb3lM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WXFinQ/17yyAGB71gC8s2CaZNR8hnQpbk9n6/Jxlrbc1tdjvI9Vy15hcoJG7KuUCy+ZLGY15yEIdj1lflzVZDnmFA5pt+ji+xiOrYh+3I5H5bW59FN22hdwO6VeDLTM1wAUTI+bbtibrlGZ/mEVqVFDuhnYQEA6G3i3GEkkgMmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YsD07KxO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VMQb29MZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TNvaq63734004
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 05:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LRDx2hiugsE5taRYICgVuQ
	HfUVZXUoQKUB8tQDrNhNo=; b=YsD07KxOosc0UkbwqQea2k1VHrUi4Wc5Zbuezf
	CAhFtinwlY9qupVQE+h58dfgFFT7K1EoZjAXNALsV3/T61cBbsx7EYss3gQtIHOI
	fQPrdKsDaT/2HSi5toaUq5IOoZOQtqlq4vbQjRjKvWMbVA9HsDOfgZuPW2lfxENf
	D7sluI8ZohlKM0/PATbz98hEzIDFk6zKYtLDnFQ8U3QCT9ymObXe0qkA0kqK3Z7U
	+KS18tdMN16cmLBJLvGsn3cgzYcdlIXIdgJL8KKCUgIC8/O+DuYCX/gqHvZhsVhf
	qywxyPEDXyU0r8ba7fmqnbwqSKXPQcxu7mEM6OCgEp18pzjQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duv3x9131-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 05:54:38 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c797efdaa9cso256497a12.3
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 22:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777528478; x=1778133278; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LRDx2hiugsE5taRYICgVuQHfUVZXUoQKUB8tQDrNhNo=;
        b=VMQb29MZIDiyICXwAFNMsnDF/x7cXkOxwn+cXELm6R/2nmNJxNgtO1rwUh+0ebCvVL
         7scIuR/1UQqMNLDY3AVnb++ccJp38qrnFmvbS5UqwDhcXGwFuIuglphpvzbbFG0ecnUk
         Znzf2h0fR2P3UhMp8cnz4UrQNQ4+KEOa1pO7SpgE3Xno9TCT4fVu56MN9FF3uue4KWyh
         KuqnykURAKDk/M7pwcY9jYDw7OiB/tttEsUAjzk+ZzrMA6tUnUpJiLZCdfqdRmx8A0vx
         Q5Xwj5Z2trW3KKBM/Iwsu/FTqDcS1mr2h1AyZMAk3k6mGiYDunIplv02D3X/sOQmfyoY
         L6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777528478; x=1778133278;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRDx2hiugsE5taRYICgVuQHfUVZXUoQKUB8tQDrNhNo=;
        b=F8uPiwpkgv5AMqgRg/Q/uxJ3ACiPuNLjYVglNl490JJtPXSpzkDo2GMpUOGtE+ni9D
         n+kac+JFCcgZCyTmDWf35uIEnZwcsfzaI83htyQzeNcFVvxqz3hmt/KDhPhXPw5KnbQn
         Mw9gusMPWKfdVHhZ+Eno3e/U5a58gFrQziep3rmqRox9rLiCPcBEWa46HHsjN5mj4umT
         Fw2z/u7wd+IpjkKwSe0w6KPGwQRTT6cqaiehkNebPqf/9YyIf/RSY2bxs83HO98Cw7A9
         2MGvogkJ96aJAs2yxjUgdntk313BzgW34C+yyXwAguXhQDVTIJoLvFx9TLrgToTAvYgv
         U9Dw==
X-Forwarded-Encrypted: i=1; AFNElJ+93b7EVMIgNAcTRQ31/E5pkJzdA7slVIm/VppacMpEq/QZqMDP5Qqdwm8b2mNiWZQ9+AWToHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4h9rVy8Zy9SmiHLoS2EN516/zg22eqAHGjI22ewN5uV3FAvEQ
	qDoS0xP5uU/8SCXq6tLXOu9eDYkjQboCFx1huQRVInfTm5YrWZjYxDOjWxLzYAJ0XdqjVyxju00
	8qg0NckuXHCbfkmvx9AGXo6Qivd11rWe2u5q1GHlbNmMBq2edFf2tePjFSL8=
X-Gm-Gg: AeBDieu5WI+sVkKaAxypyPOIvSXih6H4ANZHnR1RCI4Tgs7JxBsG0pSW9sHs0JQ8SGx
	SDLtb1UnSkfyVWwICgFiRHYgY0ofgPAf5CjMLRYsWK1H/t0D72jd/K6CT0UdN/pz9Z25lyRzwM2
	IwykpjkV/gBKguV6EKJ0znT27Cj5kLdWlZcXSkVwqSdR/+zVKWuCle8DpQwHeI8efL3gfEpcblT
	EyD4WT45hRJFTFqQlNm2wkrjNXaJWAmutCIwmNMlXWKCWgAR+hTVZZ/TRsLa9lzl1OzOiUKsbXq
	EwpeIiZOWrEGeztpIf8IQnabCWEvCCSmI4Cj/X/rfH3Bzo9h9vs3x5EJOtXVa6XBsqlv6L8HsRW
	xmdLZTLl+vmhUnMIEt1A8Q+wfyA2UDJcExOe2UVlWKJW3zzGGIXvOXQp8VB9+IQ==
X-Received: by 2002:a05:6a20:7291:b0:398:abe1:eaac with SMTP id adf61e73a8af0-3a3cf78d1f4mr1736540637.27.1777528477644;
        Wed, 29 Apr 2026 22:54:37 -0700 (PDT)
X-Received: by 2002:a05:6a20:7291:b0:398:abe1:eaac with SMTP id adf61e73a8af0-3a3cf78d1f4mr1736503637.27.1777528477176;
        Wed, 29 Apr 2026 22:54:37 -0700 (PDT)
Received: from hu-smankad-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd5e6c682sm3914516a12.1.2026.04.29.22.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 22:54:36 -0700 (PDT)
From: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
Date: Thu, 30 Apr 2026 11:24:20 +0530
Subject: [PATCH] pinctrl: qcom: Unconditionally mark gpio as wakeup enable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-enable_wakeup_capable_gpios-v1-1-5de39bf06094@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAIvu8mkC/x3MTQqDMBAG0KvIrBtIo/h3lSIyxk8dKjEkaAvi3
 Q0u3+adFBEEkdrspIBDomwu4f3KyC7sZigZk8loU+oi1wqOhxX9j7/YfW/ZP5y9bFHZoSnyhlF
 XlaE0+IBJ/s/+6a7rBquweuFtAAAA
X-Change-ID: 20260430-enable_wakeup_capable_gpios-cb9439ae8772
To: Bjorn Andersson <andersson@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777528473; l=1989;
 i=sneh.mankad@oss.qualcomm.com; s=20250818; h=from:subject:message-id;
 bh=BpJgaliSBx+fohZC+GCBnwXiaNlDF3bUebjJWarb3lM=;
 b=m26lDkjcrLAmhfPzGeQ80LMthG6PD/5pZWiZuoYoco4Ka556NNVcA8ZK6PJK0kiAB7nuM3Cyv
 znxLFoObgW0AyLGx8YtC4AMjv7nK3zFqKAU6slaui8vBLYZkH2Bu5XV
X-Developer-Key: i=sneh.mankad@oss.qualcomm.com; a=ed25519;
 pk=sv57EGwdcfnp6xJmoBCIT1JFSqWI+gawRHkJWj/T2B0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDA1NCBTYWx0ZWRfXxULf0cTq5F/Q
 XYAUSKv11aRX8juQfGN2gMjHsP8GLCupJwyqXLBIu9lXy4PlWj3nzkOqej0orOjDPvRBOCwBt8A
 qAoK7NQLiOntF8wsV6NbvwSs0/e2tyavbO0G0sSmTXk4x3Eh6cHGsaijvEbt9oib21PUjMz6/eA
 BYa2teEhE0VtwllP6pRdtEQ598disjMEnSkZsbpx/It6FQLEh51GipGFC5HR5dD17tQ3lT6PKoz
 /sy2YCr0KMsHkJ39XYo1DImvcbQZMhyhk7UIsdhB69L0Pz+s5Gu0OV5yVWXkUiEp+QVM7nM0+6T
 VksVErSQRZBP8EaO6vPb7i7YJJzJXcJFFn7PeJt4BVSM26tcOLwhOzmkqs7cRM1D+fPu0CobwNU
 ieIz5IV3RrCgY3wzrmTMu1CTFO8d4qYicn3oP77yXYVwkpILN3NyAzlE2Q3QoeaTNfGgqQMWCu+
 AJV1fVflzoY+FrR2sbg==
X-Authority-Analysis: v=2.4 cv=Oc2oyBTY c=1 sm=1 tr=0 ts=69f2ee9e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=9gMZ1K9C5k9pR_rhVsIA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: ejojx2bLLpPsVKrVzNvvOYufN96ocFkn
X-Proofpoint-ORIG-GUID: ejojx2bLLpPsVKrVzNvvOYufN96ocFkn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300054
X-Rspamd-Queue-Id: E491849DC38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241992-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[sneh.mankad@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
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
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 45b3a2763eb85405fecdd4770ba3d4ab684563f0..96df8eb8f5d3f3bcfe165ac02a07414e491f1178 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1247,7 +1247,7 @@ static int msm_gpio_irq_reqres(struct irq_data *d)
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


