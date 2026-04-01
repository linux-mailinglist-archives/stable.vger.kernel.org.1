Return-Path: <stable+bounces-232666-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YA65CiGQzGnXTwYAu9opvQ
	(envelope-from <stable+bounces-232666-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:25:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C8D374507
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0034530DE625
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 03:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C6C37FF77;
	Wed,  1 Apr 2026 03:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IMenfcoJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wb2sokfs"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3D337CD4E
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 03:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775013777; cv=none; b=M79fgEQYuYTicOJCR2r9P+LpmX7EK/rKvPdUZEG75j+NTelLynsGJIz6IB0Byb8B6GbC+jvXraK4bExOaaXsz5hdeRN43Y8FUF0atDRLd8CptGsf4h0gJvZ4pgJPtUoQ2tFmfm1Le3QqAcfLPfE+SGLJ6A6yX2WvidCqHxqrtQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775013777; c=relaxed/simple;
	bh=DOXwknPSO8kS4GpsjjcGsbygukGZn2mtQA+P9ZL0MF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gZss9lrPk2rpvKPDfhL7DjkdvBjgT23L6w0DEa0aec+i+4X0ebZNnWcvpxuzmsvaxXdA3BscVLZStfIg8amVkmdjg1MXEaWrV8ZrgDGpEroecrB6J/v6iYW2OTSxpVxCvzYD/Mb8YQkMAC2V0kvROx3758XeGHFsNojkWZ4cWiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IMenfcoJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wb2sokfs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6311WU2C3103964
	for <stable@vger.kernel.org>; Wed, 1 Apr 2026 03:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0LgrG8m60aHTZivb3eNUz5aOlnco6nMtQPs6zLRWeXY=; b=IMenfcoJIRapS2Qe
	n+yzj1cIsgVDqE5Y6C0Ul1kvm1Q4NSqZjsVHnwXFqc2uBuZIrz8/UsIurwxeBZ7J
	aunrBX09li/n/Ex9vTeY8bzvevNdhJ44EP2T3OLaub700i6DNEmOTXosVv49aKpY
	RkbMal4uM3osJN28zhxV2y/boFlIL3/DU732TzY46rbH2CvBzjnLW9Dk31ixd5Og
	7E2Zn5E7jQK91xb7stuyVOY4W9XdBbWVZWYRvzQbyyNNsmN+8vah+NtgRbnYr/nt
	A9yeJ4kXUmvjGBH11zPZgHzIROXZzlDuDoPLYGmMCoSC0awT0cIHVWZAkLpBcXbc
	b8Vihw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8js226p7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 01 Apr 2026 03:22:54 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d7cfbcb7c0so18135149a34.0
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 20:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775013773; x=1775618573; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0LgrG8m60aHTZivb3eNUz5aOlnco6nMtQPs6zLRWeXY=;
        b=Wb2sokfsV9AG/8ErP1/plrRvU9a7MeSKj+7g3ngSsU94JLdfCbG74deGD5gvbprOIb
         o7fJ5SeAYvLiZOnU+ihqzjtVNlpn9Upg2WYux8jxpxPCYcC7/OWHPio2jjMi1sxs4ZHr
         8PLN7UZLkcf+B39OaI/FzA5tnFC6OxmNdjuyrPc5bmm+WkhOb5WCCrDipgqayFHKPggE
         47dF/bi8lIGqAjGzZQN9URnIptYq35f27E5W65eTz60EMam48651IS4bDjoxO/k7zkjj
         bs0ZwQjg7V+/2f9vzqSS7ipb2quVNTw0TaJzxf26L8lsx9w6yzwIqnkUgoJo/sOgpcFY
         viZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775013773; x=1775618573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0LgrG8m60aHTZivb3eNUz5aOlnco6nMtQPs6zLRWeXY=;
        b=RhN6qyrHLCgzwwp8bGlgsS2RShf2F4OvC0jZ8KjbhJkCDgBXwDjJbrc6mj46jLFay8
         9Ui43Xy/y048vTFrJaSS8pTTx4+h5KpNSSlqSac78BqgIFSATwRGT7G/7YYv1FsBOkn+
         ZwmzAF/F95fu5CIgEzUpI8BypYgeKykWf8mDnSvVFVarRXN1DJ3P2EzZRcex52SO9KQ0
         BHuTJdIksF4FUJojFNsUfGaZC6gyE6xkP52U06xpeutjsWyXSNnV6gPMiEqDl8b8xNxP
         6zEhRcOsQX3iRR+H+OpfWoNZTrPxDuPVMLNVmI7OFcKcZ65hSD3n2rolxSOARsK1UZI3
         0W3w==
X-Forwarded-Encrypted: i=1; AJvYcCXDVQfyq3Ev8vD1gyk7PCO2E/ZBhku6A8fp1H+ffeQr+QQkeT9WHjch/xTpk56BuXxXc4u6M9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ0vzD21/flymR0wY+iYB1kgaOHOuhVtBnuPRQetC3Bci9Mpd6
	mAzjPWEOcmyakHkb5gQNMI2KXCpjnmchE92aTuFTt0d0RbOrb60fMvpMGHSmQs5KqQB2ItgVQm+
	jY0tJaRGvgZgYNEYWysClwq3/e1g9M9pSQS+iR4RFAvv83fJHj10SCzyYbp4=
X-Gm-Gg: ATEYQzxmvfxL3uWytVQRUwyplILtDL1wmabfnlVUXxRq0uB/hFvUte+PGb0E4gq1tPO
	Vll3H+cniI4cTTdiU1VJg2lm6hnKmyFD0s05EmYPUF4vrdnpul3tua+/um92WfQkl985D+miElM
	A+ADBZjSaQN7kOaCQ+p7vbZQZmNlhg9PKgvOwpeF/kqmD/jM9I1U5m0j+KnQah3Yr/Ot1MY1OB8
	GWIMEn6PnhKZDbaFczqpVU4eQvuq/zDLRyeVJcvYloj6KIignFbmWbR6CA7Hazd/I4UWTcATT22
	RHdfovIR0oyRgyU5mqkO6f6CB4x79Un15JEdnlYmYrs7z/BMiUhofhZhVr8swEwaUTfeDGv0jr8
	Go+YXdrN2IQ2SKXNHV84qN8vOwkTL+8NPZYHVhOzba+o=
X-Received: by 2002:a05:6830:368a:b0:7d7:cba0:8b75 with SMTP id 46e09a7af769-7db99400313mr1420046a34.32.1775013773366;
        Tue, 31 Mar 2026 20:22:53 -0700 (PDT)
X-Received: by 2002:a05:6830:368a:b0:7d7:cba0:8b75 with SMTP id 46e09a7af769-7db99400313mr1420032a34.32.1775013772968;
        Tue, 31 Mar 2026 20:22:52 -0700 (PDT)
Received: from [192.168.86.59] ([104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a336d73sm9589357a34.5.2026.03.31.20.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 20:22:52 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 22:22:47 -0500
Subject: [PATCH v2 5/7] slimbus: qcom-ngd-ctrl: Initialize controller
 resources in controller
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-slim-ngd-dev-v2-5-9441e9c8420e@oss.qualcomm.com>
References: <20260331-slim-ngd-dev-v2-0-9441e9c8420e@oss.qualcomm.com>
In-Reply-To: <20260331-slim-ngd-dev-v2-0-9441e9c8420e@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        stable@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3643;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=DOXwknPSO8kS4GpsjjcGsbygukGZn2mtQA+P9ZL0MF8=;
 b=owEBgwJ8/ZANAwAKAQsfOT8Nma3FAcsmYgBpzI+HrkJvA/cP/LbBw1cuKuXWfEzmCGPwukqpw
 tjyQDNLDVCJAkkEAAEKADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCacyPhxUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcXzhw/+Pj2aFY35QSvXe2eILSOyPrX3bhXmJo0jRoEqLG4
 KU3avOXDVvik1F//HpJklEYX7lcGpfhgyBMcEXrnBiCtHqXHXrd/4NchdaaLPWfnKrYx7qTTj2F
 BhjGBmK8OUSHbgVzh41v5QteWh4X8XUOBvhdw8jACcqtZRDLdooKzan52iYzEnSKFtJDtIi3JLu
 3h2VRNur9HRPt6SKOJ51nahfx/cQIy7JQNreHvny3Ee2aFQVvIXnzIoFfrCl1epwfdTdmA/eU3X
 G0XSmN8609KYyPFdh90ZwMiznaA2ZIHEECYZfLDngTuD+4tD35bYdhOXpJS1v5BjVwPkeTsjnNi
 enf4qSRnWn84iSzc4YEsd8SPqSi69jfgUo7CItciXzfXwUFqYyj8w81xEPnPJdevp3il7xatddP
 a14t3f7hC5+mzYw9ce4HrowQosVl5r7STF6JHiBA0Tkark9Y/2KLEjUaKhuLA9vkGZGOaf1tBpx
 aDduv/2Pr0EGJMd9AcZiEYIK5YzQmVFqP7oskAOA9l/Q0EpWRyLseejbwPJ5okwmFAhxrMZJrG5
 QQFBc3i4FM4Tr2M9L6eFcMB4nxZ5TJViE6DEhy0ba5hzjQ7mwGvy25Q2kx/oygWsnThfoKdw83+
 w4ElxsttFzlCp8db7MID7fYvsAVhnUfSHpVDBXdxKGwQ=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-ORIG-GUID: fo1jVrUGVflAsCXp0BWbrfY9sqgEBysh
X-Authority-Analysis: v=2.4 cv=XfqEDY55 c=1 sm=1 tr=0 ts=69cc8f8e cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ZDM3EJ2L_4yozt0j5AIA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDAyNCBTYWx0ZWRfXwcIwqVEjqHAw
 HzTm0EDrN4Thboa4kWrastiAFiVdE/YGx3BL7XXtFLRP9TcwH4ImuJJb4V4EF6gQ4bZWdtaLmP2
 MaiY9zSPEzhvvxmcQ1v/M6aruPRdmEC0yEgKJaHx2fFCHdLKuwNsWpQYOV9PASQ0XUboM0C3Fht
 4EC+LtbwBMJxYO58/I0VfJN0dQv+bgMDwkaD0QA4PIWzrvuXFp5VuoHX8OQiwg1THkRh6hfgw00
 NBir1Wkmw2elanIQBjMWh3PbvffEkkhAinVIKtykFVexHbZd1UdDkoKHQrrnR6YW6Sv4JNH4x9p
 twTUzI/tXyjnpQllbj+2clrtrAb201uDiJGVLOuAWg9QlWxVCfM+aTmp8wiOO3B3ZpNk2NH7kcm
 JFNEq0YzsvIIjrlUTOjidSJ7viv1vrPp7kRt7gaaJ7CsIdYmEwH/YxvOwLmYvUnjsZAzJgWlLwo
 g8djk5tQoYUuEEG697g==
X-Proofpoint-GUID: fo1jVrUGVflAsCXp0BWbrfY9sqgEBysh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_01,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010024
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232666-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[bjorn.andersson@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D3C8D374507
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The work structs and work queue are controller resources, create and
destroy them in the controller context. Creating them as part of the
child device's probe path seems to be okay now that the controller's
probe has been updated, but if for some reason the child does not probe
successfully a SSR or PDR notification will schedule_work() on an
uninitialized "ngd_up_work".

Move the initialization of these controller resources to the controller
probe function to avoid any issues, and to clarify the ownership.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 814ecb01b575984f0951919bba0b8ef4fc64a6dd..ca5c1c00fad163c69672db3b37bf225490e7fb96 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1582,25 +1582,8 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_noresume(dev);
 	ret = qcom_slim_ngd_qmi_svc_event_init(ctrl);
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev, "QMI service registration failed:%d", ret);
-		return ret;
-	}
-
-	INIT_WORK(&ctrl->m_work, qcom_slim_ngd_master_worker);
-	INIT_WORK(&ctrl->ngd_up_work, qcom_slim_ngd_up_worker);
-	ctrl->mwq = create_singlethread_workqueue("ngd_master");
-	if (!ctrl->mwq) {
-		dev_err(&pdev->dev, "Failed to start master worker\n");
-		ret = -ENOMEM;
-		goto wq_err;
-	}
-
-	return 0;
-wq_err:
-	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);
-	if (ctrl->mwq)
-		destroy_workqueue(ctrl->mwq);
 
 	return ret;
 }
@@ -1653,9 +1636,18 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	init_completion(&ctrl->qmi.qmi_comp);
 	init_completion(&ctrl->qmi_up);
 
+	INIT_WORK(&ctrl->m_work, qcom_slim_ngd_master_worker);
+	INIT_WORK(&ctrl->ngd_up_work, qcom_slim_ngd_up_worker);
+
+	ctrl->mwq = create_singlethread_workqueue("ngd_master");
+	if (!ctrl->mwq)
+		return dev_err_probe(dev, -ENOMEM, "Failed to start master worker\n");
+
 	ctrl->pdr = pdr_handle_alloc(slim_pd_status, ctrl);
-	if (IS_ERR(ctrl->pdr))
-		return dev_err_probe(dev, PTR_ERR(ctrl->pdr), "Failed to init PDR handle\n");
+	if (IS_ERR(ctrl->pdr)) {
+		ret = dev_err_probe(dev, PTR_ERR(ctrl->pdr), "Failed to init PDR handle\n");
+		goto err_destroy_mwq;
+	}
 
 	ret = of_qcom_slim_ngd_register(dev, ctrl);
 	if (ret)
@@ -1682,6 +1674,8 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	qcom_slim_ngd_unregister(ctrl);
 err_pdr_release:
 	pdr_handle_release(ctrl->pdr);
+err_destroy_mwq:
+	destroy_workqueue(ctrl->mwq);
 
 	return ret;
 }
@@ -1694,6 +1688,8 @@ static void qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
 	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
 
 	qcom_slim_ngd_unregister(ctrl);
+
+	destroy_workqueue(ctrl->mwq);
 }
 
 static void qcom_slim_ngd_remove(struct platform_device *pdev)
@@ -1704,8 +1700,6 @@ static void qcom_slim_ngd_remove(struct platform_device *pdev)
 	qcom_slim_ngd_enable(ctrl, false);
 	qcom_slim_ngd_exit_dma(ctrl);
 	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);
-	if (ctrl->mwq)
-		destroy_workqueue(ctrl->mwq);
 
 	kfree(ctrl->ngd);
 	ctrl->ngd = NULL;

-- 
2.51.0


