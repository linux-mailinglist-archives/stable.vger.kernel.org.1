Return-Path: <stable+bounces-232662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ISGL9OPzGnXTwYAu9opvQ
	(envelope-from <stable+bounces-232662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:24:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E69237447D
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C5F7309D72C
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 03:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67A337F8A0;
	Wed,  1 Apr 2026 03:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hQ2cckUM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bgyY3VZG"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F983630A3
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 03:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775013773; cv=none; b=AGwv3yFS04a5M4NoXA/yC3gvn7kgVsYjxH7eFip1Awt671yYY8MaP75m4w5u4IX5pH0bHsknkrQJK83hso0s94nTafW2TeXZvDaoXog41oMemkahKRWr8zDnwZoyn/i7SHtecwY93yeXJCeJOicH8j5Ds+Ju3iH8wh077LnVawo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775013773; c=relaxed/simple;
	bh=lY2lCZgEYqxClbWM9V0f53j3uqFUVFNr9SxWISwJo00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W9rF6G9/5N939lCWXwt8FcinuV9JBM2BB7fpQgczdzGgmBIrJs1yW9qiRUQerJjfIGZJ/teccEEHfpftZMdseBhhkGzndUMY9qCy3TObGd+lzxfdwUnftIbWI4o8uJMzEFKrOulL1PX7LrIWoapvfvZX0KyCdz5UgiNk3U6SW+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hQ2cckUM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bgyY3VZG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VJlStD1579382
	for <stable@vger.kernel.org>; Wed, 1 Apr 2026 03:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U/S/7SAnJtVprqSH8/36zGYJ0LJVG/tIKEIEQ4Y7FyI=; b=hQ2cckUM5NHFeqJl
	2Z+vszKWr1N42NOTw7Du3bmWJnF/tM0VvVkY1gjrII0Xba8B88HfQIYQyr0fNNow
	SymbHm0AlLWgh1itzI8iI6SJxBURszWQrWEDZbC5bGPj6sYhXu3lBtYnyKx22/H3
	tgCOwOpTZLVxmLOJD5cStKtL6T5Wm/YEVzFf6pvZfZGzdavMwVzigxLDlKWe/yZg
	U2InjeTX4XoPfzdTZ5OV3Jm88glnnlJmwUEOBif56G3CXFW7SLzDM5oUQ7Wg1xzK
	gOiaaXBZfVdZwn/J73PgChxpOjhxXLqSrY5I6zG+OISRuOyvFxvkVbIPXnFSob7f
	tflbPw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8mr2senm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 01 Apr 2026 03:22:50 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d73c71f9faso20613000a34.3
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 20:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775013770; x=1775618570; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/S/7SAnJtVprqSH8/36zGYJ0LJVG/tIKEIEQ4Y7FyI=;
        b=bgyY3VZGe0Lp+uC4NiwPhjbq389nhll4g5l3b+kl4ERxegrHnH2PFW6UNftd+zhA8k
         3Vb7hMAGgflmnopihPgrggEF0zCVEGL8zRBJangFqh5jQYUxqT13S97BGjKrpMIFSPhM
         nQRjC1ztrwuqNK7ECcvqLA9yqKBT7bv2WcXyG4unxElqOpB8RVfBV55UYYn+F+JDNtq1
         CcoW+/cSn1SYdWa4g0EZm7kULKRj1snFV5K2S/3j65MB5fsl/4Z2w87AxJsPyPrWEgsW
         JddP4z5rm7Vwu9SAmFPOYL+Z+OuTtQElAgH43Roqapo2nE98ruj8M3sX2KJUJR3/8tfI
         uqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775013770; x=1775618570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U/S/7SAnJtVprqSH8/36zGYJ0LJVG/tIKEIEQ4Y7FyI=;
        b=jLaort15bVYDEozcJAQqGjy41zPBbbp5OXDa+SoOhhSIBOqWzLG5UII+EciGIxb74g
         qeQorP8wr+o12oFMG1v1k7P/PtrSgaqdtHmsImFFblnLG46fg5wAgPIrnXwSMR9RyrN3
         Bt6WB5xHzX72AuRT7TZMDtOoE/s+opfJ7h+kFmdtTjs5fUM11imMko4qFVcS68bghRQc
         N5Sa8t/sdFCeUVpe4tAE0P0XV8L7xc9VpqOzpIBzTxlTn5K6c5/EjoQLe4QnKytSFH9C
         PCl+Mf5m/ZSZ4PI0R2xV1f/WhHFbVvdXkV4TiOhVU/7xCq877wy1r18QG+qAUN/7JT++
         EcUA==
X-Forwarded-Encrypted: i=1; AJvYcCXPHjgOlUnkBCHTqiQcHZws9gX6bZeJEwBngF5kOjPBpZomg1F1aGDUQwbKJbgYPQQHc+R2tY4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvh6vPTDm7tFz4TkGVMer4vu5Y4+rcmIM9XbGeDj0RkkxC6F7j
	ihAebDDvbJjauFOJcV0CQnWIU0H/SVM3Q4hFqyPEmSmfQn9RKMPbcA49XPg7Wd1gR84WrkQuypo
	PTA7TEPFnpJXPwDJ9tA4TFAqKNnKaoEWCLshT/PeIyunx1/qEJba1HvVnjj43p3XPCsA=
X-Gm-Gg: ATEYQzy7q35/iAP/sWk4vn/OCf8M5QtlSQZ3cTq53I0kCdfgv0dUIaG9A/oV4Y1AKN9
	rR5myAYwE4dEhTdkP32fzhYbr8O7cHygRHBhOMW4EJnr0SJtE1OrxqeGwTLShpewOeQ0kpONkBt
	cJ42evLXWkst7vAlPYIa7aRQH7RuscFYP1UmmqQ4BPOK43ed31eRXVsSRNtJ53LEqZyl9EO0H/S
	E7X1QZdLRknt0EbidUo4a6baegBVHU9y1wJx0SCy/amb5LKQFqcPgFNWMFrZSGltBX11rtslvuR
	7HBfbzlX+n/zSmkQXycf2+QHNMJyEzNmLf6w+b2emQspWK7sN1FEPuNepD/eiPd07GYIMQvkzOS
	3SxSD+/kOmZtGcKH3NBFrJ1brnORdfmpDT+Ge4Fzi6+o=
X-Received: by 2002:a05:6830:4388:b0:7d7:f8ec:2144 with SMTP id 46e09a7af769-7db993bd8c4mr1361028a34.25.1775013770305;
        Tue, 31 Mar 2026 20:22:50 -0700 (PDT)
X-Received: by 2002:a05:6830:4388:b0:7d7:f8ec:2144 with SMTP id 46e09a7af769-7db993bd8c4mr1361012a34.25.1775013769856;
        Tue, 31 Mar 2026 20:22:49 -0700 (PDT)
Received: from [192.168.86.59] ([104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a336d73sm9589357a34.5.2026.03.31.20.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 20:22:49 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 22:22:43 -0500
Subject: [PATCH v2 1/7] slimbus: qcom-ngd-ctrl: Fix up platform_driver
 registration
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-slim-ngd-dev-v2-1-9441e9c8420e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2828;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=lY2lCZgEYqxClbWM9V0f53j3uqFUVFNr9SxWISwJo00=;
 b=owEBgwJ8/ZANAwAKAQsfOT8Nma3FAcsmYgBpzI+HI5braeNn+8ivP5KxT3frvN/12UXOwqtNh
 qOin3ixctuJAkkEAAEKADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCacyPhxUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcXHFQ//Ugc6fCvbILC0dWxHHM0huyMaPvZR5xCCVR7EpPD
 HQqlXVODRh3u9NCImfuqHhL8uBg2298+oeU8IrQ5QzhChIQJ0Lc0HFeVriAgSSUYkst6zGyffN0
 xTNnhhry2YrE3rvk2PmpsT92ItVItbAuF5utffREsV78iGkClLWKHBs0Lx/k2/7bv4h0mvKEvp6
 d4ZwwBFLgfThhvrRR6P0UW22iVZyoLcEYmZACKwpVyrjFPX1VBQioGIb2X9utQ5BYHPO8N5BidA
 2oEkzuq9/OGx9WkyyikCI4qgWg4J6yHCgDIcsjugZ/vJ64dEu4wUaMc73ivckEXoGRjufxe+mQq
 XHvWFk9Aau64FxeVWtYhMBeDjUcXCcyML9vq2rbt2vWe+dCaNKVRwgeeVM9/6SzETqUM6hDytrJ
 sZ2vBozwdg+dbbHR204xbNndraQRa9jDsUq3uyTi++sktlceWck3iy0OVh+ApKdj5HPjIsdoKLX
 W6syp55gQHVN4+5Rbr1fW6GHHLgcKgJD1pAbbOnd4Qaeqtt2eMdYS8Suf4i91ipusrCOIcw+8cs
 Pa1f5qGplDF5pfzCnQagVWoENG/8Rahu1xrC+tQff9TNi7FnZgWCxkZ6vmTAD/vhlDN6j9YFsnJ
 UQd88PwlRQkJwBlGLUa/lfMTo1MQSMo0VOQ6oF+BzQJI=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Authority-Analysis: v=2.4 cv=B+O0EetM c=1 sm=1 tr=0 ts=69cc8f8b cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=EWo_CA4GmUQ_SZ-sejQA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-ORIG-GUID: E_o7GtmzOY4DUeOHd-4unK4iI1dgZkUo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDAyNCBTYWx0ZWRfXxw5ko2de5Tuw
 MFoPeqVnr4hx4hropCETELV1CktA910Nv/YMvunVzqYfh2aE0hIDZOmgNhn8/0UcFYpRtiDxzhG
 N1oLdQ2JRcwxsKpEOnUl64CBjFKudjq336tRmUQftCQxCw3ioDKIRxBSZHvEWptfOGYbNqAQ5uZ
 4h/ROyuL9T3zdnWe4yyzDsqkmDyd5MYF704Vebb/pzpu3gn2jgcEqTZlg3RyT0AU4ItfC9iZ/X4
 kHNsM9ZD0WVwoTNgHrpV3i4At43/7rM8khmE63zTcMIWtB10hWmHRSZKm867/OrUok5TcPPgcCY
 zSXQkreq5EyMUR18WnD0x6qvGL30rdQpA3JfkU8cqmW4c7+dJB5/IRWfkldtKEP0qOXaL2pgFpq
 OSzeNWpxBjE3jKQwNc2ywr1HgTN8g0ytBcBFVaNbI7TQCRE5DF1Az7Riuz7nunXotS4xzaWHbM3
 nlXxpaft1jY/hqhwuOw==
X-Proofpoint-GUID: E_o7GtmzOY4DUeOHd-4unK4iI1dgZkUo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_01,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010024
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232662-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 6E69237447D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Device drivers should not invoke platform_driver_register()/unregister()
in their probe and remove paths. They should further not rely on
platform_driver_unregister() as their only means of "deleting" their
child devices.

Introduce a helper to unregister the child device and move the
platform_driver_register()/unregister() to module_init()/exit().

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 1ed6be6e85d2cfc0a2b65a5ae24f666de922c89d..b603b9337905438b6c9f5dbe800e560c864d946d 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1560,6 +1560,13 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 	return -ENODEV;
 }
 
+static void qcom_slim_ngd_unregister(struct qcom_slim_ngd_ctrl *ctrl)
+{
+	struct qcom_slim_ngd *ngd = ctrl->ngd;
+
+	platform_device_del(ngd->pdev);
+}
+
 static int qcom_slim_ngd_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1662,7 +1669,6 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 		goto err_pdr_lookup;
 	}
 
-	platform_driver_register(&qcom_slim_ngd_driver);
 	return of_qcom_slim_ngd_register(dev, ctrl);
 
 err_pdr_alloc:
@@ -1676,7 +1682,9 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 
 static void qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
 {
-	platform_driver_unregister(&qcom_slim_ngd_driver);
+	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
+
+	qcom_slim_ngd_unregister(ctrl);
 }
 
 static void qcom_slim_ngd_remove(struct platform_device *pdev)
@@ -1752,6 +1760,28 @@ static struct platform_driver qcom_slim_ngd_driver = {
 	},
 };
 
-module_platform_driver(qcom_slim_ngd_ctrl_driver);
+static int qcom_slim_ngd_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&qcom_slim_ngd_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&qcom_slim_ngd_ctrl_driver);
+	if (ret)
+		platform_driver_unregister(&qcom_slim_ngd_driver);
+
+	return ret;
+}
+
+static void qcom_slim_ngd_exit(void)
+{
+	platform_driver_unregister(&qcom_slim_ngd_ctrl_driver);
+	platform_driver_unregister(&qcom_slim_ngd_driver);
+}
+
+module_init(qcom_slim_ngd_init);
+module_exit(qcom_slim_ngd_exit);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Qualcomm SLIMBus NGD controller");

-- 
2.51.0


