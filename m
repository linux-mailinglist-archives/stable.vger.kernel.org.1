Return-Path: <stable+bounces-223758-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDs/AISZr2lbawIAu9opvQ
	(envelope-from <stable+bounces-223758-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 05:09:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A04245293
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 05:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D30B9302CEA9
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 04:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F953D34A0;
	Tue, 10 Mar 2026 04:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gyn8NzuA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P5ZH9F7O"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1993D1CA1
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 04:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773115764; cv=none; b=jHfIydO4MLPg3ntPzys9hP8SDEPI0PpuILcn564Z7DR8iDjct7fbIsQNIGqT62tAIaowN01ls4JKnm7smpGOnSiHRvmbTiNaNrRZ8dmriZHGDxWDjDQ0jVqhwUZGhnelPnZhG9QWfPPleqQgAPlEO5U47hTH8PlT/yY2ToqOPMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773115764; c=relaxed/simple;
	bh=68+BXhTLgDWKkLMk+I9StqSF8+TK96OU30KM3ca9y2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+z9GIVufsMX2kCZlzxsxcCoE8ersmW1ftjJit6WmJizYoAIqJ6FChey8VBtburvuxKwkcy62ScEPXwyJG4dM1gXhiLL5n/xCuGJg8SaphY4L6M9gj3bBb1bE7tJEQ72+mNbHJdqWxo1ZOzlGBwip2hwu5/qrjH+Yb6JRYLCCWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gyn8NzuA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P5ZH9F7O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A2EDQK3754538
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 04:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MurHg1m2uAKvWtn7RAZi7VVz1qreouQXsuQDvN2q5aU=; b=gyn8NzuAZ+sPSgiU
	TPBkhBqbCh25Oo2DOiVBJSK/AbkylsNaMg/O6ZouCK+r8+bXvL4VVaKYkzVgLpS8
	Ujybxw1Ir9AYQgqRopXafM3ffOTBceaee6V3ipXT2uyfI0JUymbt8eEjvJYldRGj
	ksjT6Y8RTfaK0+dhdjTD0ZPQzs3c1tIlseCU6h8tpjJBNAT92C6n5oDpqSgE1axH
	/g6TK/iLkL7/sL8kUCXmnr/+eozgS+XxNvDtnEJ/6xCEQ63YOSpsN6SioPHXqzuC
	o4z/Nz76UmKZoFRKBkjC0tSE/SOwITekpBleQcv8EGzFwYq1kGQHBI7qSPnYHdTQ
	J4/WxQ==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct477hdcn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 04:09:21 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-409037c3f0bso36563741fac.1
        for <stable@vger.kernel.org>; Mon, 09 Mar 2026 21:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773115761; x=1773720561; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MurHg1m2uAKvWtn7RAZi7VVz1qreouQXsuQDvN2q5aU=;
        b=P5ZH9F7OEZYWMgjh6BTzRX6Rn/WZ3jEEFNG4DfEe17OyJnyDWrFUlFU5K1+MphD+kN
         DUUfzODU/hWDERWGFtp6NyzGzMbhv6KYYmZ6oQvoKctXlZmE+cDgIlud4XsnO0A/2WEw
         2mBWqHDahxpIW0nL18e62mc/LB1wKDKYY6kc5qA6pswBJXfVeqrPsY2ogUI+DwWD6izB
         MOIUBW9fBOblLmW37x2aaUvY4lDMGK2sOXrXdrpOorT0qwaDXAJvC1vDEA+WYnmAgVIq
         NIkAPf62yt5EKEdIYXuaV0pbm8jdltwjYukORpvqh7IPsu1RyUXu/Zc2FUwH82VRrang
         IRkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773115761; x=1773720561;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MurHg1m2uAKvWtn7RAZi7VVz1qreouQXsuQDvN2q5aU=;
        b=fbRiMr2G98RivvjKDC9Tj73mOTDXKrBhT/1MZHiOeuJqUMdhL6FSym/+nBDUYbIyGp
         QMHwpuyakkcBDH7LtHpvfczNHaf6CkO1qY7PEOCKWCfHFzYeBllR6dUnwAnZxsHvCmYd
         yIG5hq7c79rOc4RUHMGYVqnZS5D7Boo7E/3ZvVblT/mGQDrVPCgzVqO+402bVdoNidfY
         tZxyO68RmaxkSCAJYVPeXLhYcwPftKkmTaJSucs2zGRfld0kXZqu5dy2r8VZNMRA5ZAB
         W4aV56kESj3sZzBkKlGjG47eZ0uP2VmooEEbWjsT08U7ZD91XsT5QYst1HlEFLUa+YoD
         sptA==
X-Forwarded-Encrypted: i=1; AJvYcCU1EoVcxFmQB96qEw1t28kRlKj2I4LXqmVPDCfze3D/fxc2mh4rac9afLNv9l71XdfeyZzdb5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrAaj7iScPiK57rDXa4Lv+V9YWKvycIjlz6DiG/wQ0nI1Y9JLr
	HKhvvVrjN3Kcbl8x0MtZQ5w4P2FmI2ukbJmG8wHS8qLThoWrvOHPwdTsAgx1fWF6ebU+sQp/fVv
	vW/AQ1L4hudXkub6ObqHDrOUu3ULfhNtHQIlsdKrEmGkWQ1fgPsWpf2saGIQ=
X-Gm-Gg: ATEYQzzh/znhqkcsnhXSweIH2pnJJULgeBqvpNTxaAh+x8cFdHyrQnjlJbi6dnBHPbb
	R2c13Fv5x1IbLnrbuzV74y0PDf5gYFGtVfl5OHo0U1685hH25zfC0tUAB0bH4nrZ0pLM3kfO4cp
	pCP95l9KIrkujgxnXu6+iTYMHGnP6pylKR/qfeZiqcepmwOv1HDDb0mtezckM/10BscAk/Wbrkd
	IXtl7tTQVYSi2toO6+myjCTwj9ko25UhY0054aQwfv2ya4knM1g0vNn/SqIP+npbwrXFgsxboeu
	WlMOAiB8Q1IknrUthmKRgmBYkdE8bU6yyTOOicPpllhBDIMFVoPifm1RMoNVmJ5N4YQrSuYOfYQ
	q7XKxAsGW2+GmEJ5ZyX18qN4F6Rv96aXCs+zqM4CTqfQ=
X-Received: by 2002:a05:6870:720e:b0:417:5e91:626b with SMTP id 586e51a60fabf-4175e9163bbmr633015fac.53.1773115761049;
        Mon, 09 Mar 2026 21:09:21 -0700 (PDT)
X-Received: by 2002:a05:6870:720e:b0:417:5e91:626b with SMTP id 586e51a60fabf-4175e9163bbmr633001fac.53.1773115760624;
        Mon, 09 Mar 2026 21:09:20 -0700 (PDT)
Received: from [192.168.86.59] ([104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41756e24c39sm1595685fac.20.2026.03.09.21.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 21:09:20 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Mon, 09 Mar 2026 23:09:07 -0500
Subject: [PATCH 6/7] slimbus: qcom-ngd-ctrl: Balance pm_runtime enablement
 for NGD
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-slim-ngd-dev-v1-6-5843e3ed62a3@oss.qualcomm.com>
References: <20260309-slim-ngd-dev-v1-0-5843e3ed62a3@oss.qualcomm.com>
In-Reply-To: <20260309-slim-ngd-dev-v1-0-5843e3ed62a3@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=68+BXhTLgDWKkLMk+I9StqSF8+TK96OU30KM3ca9y2Y=;
 b=kA0DAAoBCx85Pw2ZrcUByyZiAGmvmWnIPoY9VkcBwUCZzjReB8mBuemmmsw56vlCoijsujPCg
 YkCSQQAAQoAMxYhBAXeA8xfNepPCWbVJQsfOT8Nma3FBQJpr5lpFRxhbmRlcnNzb25Aa2VybmVs
 Lm9yZwAKCRALHzk/DZmtxcWCEACUHy50tUY/zaO6ecq/5e6ic9BsYZ6G0EFiBQsaEKAHjTlCJ16
 nW6BDtleYHMfmzOs4fLXZjZ9f7TbT944RR+xgmiktbF8VkSFbweFpr4TwFE3DXCMIbLhk9Nrbtd
 /8eTBUrHTAcHXXo/K8Qou6TYJ0ILQcB5ER7IyqV/ov/TUNphiZaJhYAhB2KBPYGDqmCgND7+H0I
 yUPAwsKG8s4Rb00yt5EDOdmyIVeCn5m1yqdfm0MzzDfX4chzXwA+IQ+N+mfTWOrQar9CVcOrj9e
 MWiI4jb0Zc3ZlSaFFMqDUrL+e9hHkNDoeR58LVMDnvfA+LTCqmzoea6p9AESzZ7gKauhRY3/WO2
 OEDhERwQ73bV/PHl9ThAiQcZju+BJ6NLx/R8Og6qL5fn8rdyyZyUh55DAWdNzWuWHwDC+lEsczW
 lhwywtZ4r7fte0zScxqxzPz4SrH5DJWb/yoPMy7TpC0SDUR7a3Ph3KU7F6xjJzBVUC+pZ+Ve67o
 t2Tt8uE7IYncbLEN78v1wrIAbcWCLuwmvs+fkXQU4kX0Mfh3FfdQ96enw5IEWJLdOSH8osKtIbl
 GzaK21rE/09cN5acnSx2zLlF9ajKBLQXn39A+AbcI0ofKi0JP9M8Br21mUhBrbSogDVfB6mCwtb
 zFdc9gS8Nk37nXVaOfIaLA2HZpoAuW8ZcMQ==
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDAzMSBTYWx0ZWRfX4gCwzgeiuLMR
 jsqUyNcpxHRBTni5SkJrscY5wPM/JS490dJLolmQUe6wU13NBM8ZN+gxifRqM9oVUIU+o37/d/E
 2xHdjdDmbwscuy1prjITnmoNrvkjl8bK0xxfL/cxjeo8s7AHjiG8Fa/ZRvTKRZWP0Bt1KJRE68c
 NbGhZ+gzgDIrJ/9ULvQCehKNH9dSBAtSO6DCE4yRvdNTNhcrlE8SXBMwfycyrOqs2aARP6Wm7xE
 jy+0ZyyEho09LSe2uBl1SMXWDlwlymVc3N6KgAq+X8NdkfwkIXNjkmZUimLDhhY2dgvSngyW+Jm
 b67WGlh6CRHTmh1a0Y4MRV6fCgA5NI1qjnmbzGQa0KVbU6zdAxNZDi5OXilegOOspCUy24YhIHc
 cGUWq1AqMjisv9scl23/uPfR1BciRH2Yg8YoLH3Y/jQ+sxzGd/bC+GQj2XllQtb6Aul2A/X7/Ma
 ZoTVGFULpSXtlLWwYsg==
X-Proofpoint-GUID: 7pe4xvxK9zuSIatw0rxnD6idx-PfU1K4
X-Authority-Analysis: v=2.4 cv=KLxXzVFo c=1 sm=1 tr=0 ts=69af9971 cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=v7zRpcr-n2crOtZbBgkA:9 a=QEXdDO2ut3YA:10
 a=y8BKWJGFn5sdPF1Y92-H:22
X-Proofpoint-ORIG-GUID: 7pe4xvxK9zuSIatw0rxnD6idx-PfU1K4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100031
X-Rspamd-Queue-Id: A9A04245293
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223758-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[bjorn.andersson@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

The pm_runtime_enable() and pm_runtime_use_autosuspend() calls are
supposed to be balanced on exit, add these calls.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index d932f7fd6170773890f561e3af444ac2c5730338..54a4c6ee1e71fe55794f09575979826d9aa5be9f 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1584,8 +1584,11 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_noresume(dev);
 	ret = qcom_slim_ngd_qmi_svc_event_init(ctrl);
-	if (ret)
+	if (ret) {
 		dev_err(&pdev->dev, "QMI service registration failed:%d", ret);
+		pm_runtime_dont_use_autosuspend(dev);
+		pm_runtime_disable(dev);
+	}
 
 	return ret;
 }
@@ -1699,6 +1702,7 @@ static void qcom_slim_ngd_remove(struct platform_device *pdev)
 {
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	qcom_slim_ngd_enable(ctrl, false);
 	qcom_slim_ngd_exit_dma(ctrl);

-- 
2.51.0


