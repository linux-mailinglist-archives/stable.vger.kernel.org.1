Return-Path: <stable+bounces-232664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKVlAvGPzGnXTwYAu9opvQ
	(envelope-from <stable+bounces-232664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:24:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F5A3744CD
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FF5B30B61C6
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 03:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709AD3803FC;
	Wed,  1 Apr 2026 03:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R1oZZ4zc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TPvkHnWE"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6881E30DD2A
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 03:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775013775; cv=none; b=euoYa4MjiVXdrWsQ70/x9oqrU7qbQzea5JH4dm6j0vK6LNGmJfhOULPDrwNP1zhca0STkXQ78M8fa+ygf+w1L6Pe0sfsl8XpHNpyFUDTQGdksHEEQnjCdKNt4Xi75BBYGbZJd9A9T1JOEOhbJDxpa65lrNYhuInQQp9jqsoGYBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775013775; c=relaxed/simple;
	bh=eh1pflsFy4i4xWuCJ3debJEBSGewUbDoQf1aW0vXPiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c1YUCzxueNDz/Hfp//sK5JKA+Y52iaAPGOjWodKbmiNHdfEDP9ammRXwCuqX9g66zXP/pLKWg/uLaYGmqDjXOJa3XvYoc/V6fZeUu/u7HZp255yCmo2co97vXnPmSmm1+ZB452FNvEJrEepAlRqnZYd9v2SPQ5VS2SK7re8k5kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R1oZZ4zc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TPvkHnWE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VJlTtE1579389
	for <stable@vger.kernel.org>; Wed, 1 Apr 2026 03:22:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NeBiXiKM8mAXaG/h32EbZAyo0/+HNOhfKQaw4GQVIz0=; b=R1oZZ4zcgENv2srb
	SjTxEfcJMUYSe4XsmDipeJXQbykaifAQBQJO1parvpFtRtvSS2f2YEDdO32vgPIL
	uqROD+Afz5NIYn46/FNr0uSenVCjYYnL/atzLfJi2xHXTv8stJmkIZlxsDSxkqxX
	W29SbR0C6drJ+U5awUoCt/jeaucRqIkDjhqoDaLm+WF3TdmnHY2SXFil0MhO1eom
	bHv8ZGsJyxT2MCNMra/TujUARAK8phalNPLaAV6UUgK8t7Z9SqSt7HOYol87cXE0
	bHP7iK71Yg7g2mId5KXp1VyaJ2pivIFAxcLM2V47L5oWu7MFRHadAlTpcMJpFgnM
	F9Tpuw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8mr2senr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 01 Apr 2026 03:22:52 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d7cfbcb7c0so18135125a34.0
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 20:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775013772; x=1775618572; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NeBiXiKM8mAXaG/h32EbZAyo0/+HNOhfKQaw4GQVIz0=;
        b=TPvkHnWEEiH/SEARC5B4XRHQtrmTEU/FPDByprl5Zqf1FfWNUNKfT/MQK5Tx4ljkq9
         6y5s//dVJgqfma+pBgG0Hc5M1MUhENB4UfBWESNJOaAE3tnIradjIuJEnB/MVALW2nPw
         rTid0wKKWb96kHCxS9qDCN+n2+gUfOPF8fITKvyJEgCijPHIdliAUBqkDfNhO+lQebOk
         MY32qQ4zScDqTWkMm5mIL73AkGnDh9wh0kV+tSyYcb6e+SEixV1IEppcw8RlyBPLC+HA
         hxatf26XMcqPBJO39m5oNhY+d15Cnv05hPg6fBL3osZJiygEc8lTVxCNXa9zpmMw8izS
         rZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775013772; x=1775618572;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NeBiXiKM8mAXaG/h32EbZAyo0/+HNOhfKQaw4GQVIz0=;
        b=c7yM5t3yu/y5xLyxi5zFmkIy3mN/IcwPY5QIDeE7nQLt+5HeQmEuu9Vig9k0IaIBvD
         ild80DzmeN2pjuXdA5n9bTKaiDq6Hku86JzUOFi5ycJc1gOYk/xj8LEnj5ekTIwbS1BA
         QmY61vUj9BDYz9wlqLs4exjpiuHaSdMx2p2iJRtMHnKYeFI0Q3tt7eH/sQ1C+EJaCoz3
         +QuhfqEcMWLW3WgCH8DY+Wr6LCrQ48D8dl1SKR8Wx+kfuU1BsKrda1GylpmrErCnaU9C
         bdPyS2tlBjq0FMSRixKEZLLsA38JnRhVeX4PN9Mxz4k6Ar2CU6EBxUJAauyFXUkeZhZA
         hGig==
X-Forwarded-Encrypted: i=1; AJvYcCVDOj8zePBSEkr898WHqs0daeSD2L7HOtxcIcyLOGN+3kk01C4pbdTpD+mFuuT6/MQwXBx0pC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz4Acs0Tj0pyHt4OlBrNfTjcXK6LkEwhJsHEKWowalLbTb5cXh
	QYHM6agvU9NGDR5l+I0nCUHRjLnJvZ8vgJdnab4NnDOj4++AMNjd7B8D3WBcqwCx0DSai3fzmMg
	vDVPOPfm2wANSoysI8vtVQrq1jN932n2rfReyrbB6LyMAtjhyJk54fFGeSQQ=
X-Gm-Gg: ATEYQzyue0WAW3KN+UzJIGBngIHd7j/j2vAHw+bGYH5pedpIjZjVpyUxMC1Sb11vqNz
	gIkR/kH0knKWECNy1eowq6dBO2WVekP3Iyj9sJFzL+T+GbsaBde8eYGo8LR9CAt2hQqLBnkUEP6
	pgxDAX9VJ7A3u2fTdULrEEeSeVHbQAMda+igm7pMiXbyhaHziQyQSonl+E+cPABxiKJslooTWE6
	+VWXSTodNweVvaKi3i+IT7dpg7NxtjAlhB6dMV8b6+6nTYVpN33lXIfBB7q257lnou8J7iKW55K
	tzSOn7Q8cijBSUvytDgDrpAoZnz8QGrl59+xaIBwYfPzBDVIBrG7aFMs/ZzBhAO7pOq5u6zYoSh
	WW0oT+f0spXBHwoECK+nafhIk5tUYSyFetc1gD20FhRQ=
X-Received: by 2002:a05:6830:81ca:b0:7d7:d1f0:7493 with SMTP id 46e09a7af769-7db9934565amr1409209a34.18.1775013771772;
        Tue, 31 Mar 2026 20:22:51 -0700 (PDT)
X-Received: by 2002:a05:6830:81ca:b0:7d7:d1f0:7493 with SMTP id 46e09a7af769-7db9934565amr1409191a34.18.1775013771358;
        Tue, 31 Mar 2026 20:22:51 -0700 (PDT)
Received: from [192.168.86.59] ([104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a336d73sm9589357a34.5.2026.03.31.20.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 20:22:51 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 22:22:45 -0500
Subject: [PATCH v2 3/7] slimbus: qcom-ngd-ctrl: Correct PDR and SSR cleanup
 ownership
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-slim-ngd-dev-v2-3-9441e9c8420e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1608;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=eh1pflsFy4i4xWuCJ3debJEBSGewUbDoQf1aW0vXPiQ=;
 b=owEBgwJ8/ZANAwAKAQsfOT8Nma3FAcsmYgBpzI+HEE+6zNK/v2yvG3jpdJVZIL2zvWuS+H9Ov
 Hg0ELibHk2JAkkEAAEKADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCacyPhxUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcXF0A/+ORqUdaF7mRoNlZKgJfhlryleRnQNlHgahS/+/E8
 Zr1nuupkvYlUttbGyNne6kiNfcU0lXDEZkuFNz+VqvDc9FtVCTn1RpAdvTTHpa78rUEgXOp4vWV
 ZyDt/vyEYZu8J4brtB+Go72Ug2XJHDBuIi+htYSa5bBhLeUgV4VBq9NgFF/sGk+QIGyVkN4FH02
 bbeKxHlMDWCWVY1W77it8/LVjExl8neJ/265ZtHB74mer8ojfXOM1dE1RpH5IM1QndktMseeKSm
 eOtbtTwlV3LVTH9oFj1azptmEyLZaIdPOGn5Wj6qezuoDz1WhgBp6bnAeQB5yxVFcjQbZHx/ILh
 mtO9Dl1bkps5m/bJOpQB5+Jdxmrpzy3bGcPx12pKonYj8K6QUIZFWkaVEyYc+vlKY1loHPdaVvE
 IORld5eusPmPCA8AKYrgdQFZhDJJL5TtFq17yucRt7v5E43HAx8lmmPUvALhBqW6otXGsJ4dOee
 HIV3Muq+gD7Pnau+rTNNqoDU3iQYIjmX965ShihiFeG4GUeiFr8TIf9WYb6oCIAAv2foq4tNv7+
 QEdkPMSAWCAjpffwnoIt+76tRvG4X5RvCFLG91V4qQiqv1l2d0xH93d3nBgqERxIBrZcoIMEK5X
 ZNVJqnwY372Jdu99LcI5kCRku0qqNvDJa2kaH6KBmikw=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Authority-Analysis: v=2.4 cv=B+O0EetM c=1 sm=1 tr=0 ts=69cc8f8c cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gyDl647GgXGSOFt2m_oA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-ORIG-GUID: CAViH5UmZOjuwSVvlodwTQI2VZu1tS6v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDAyNCBTYWx0ZWRfX06hKdWqbzIxy
 hjlfSAw5ULEqOQyNQnOMMl7v/boYKjwiud8CrRhFkdvEOjNfkl1067YjqEoHVpy/aYJEdyROoM3
 uKqcOzsRFD3ltQkY88ZqS4XlroT+lAMZ/T2qa8XzL+Yuw8R/WPGcL+kPaZvnFJxxtxPJ7ApsqGU
 JBQ4R3ctIog+SB2EIMmDVoVsUfXcqIOALHA5LhbBmtswnPAzjxwqvrFb/0TEV0bJXaMgopGRKOe
 fRxg+UngFWqCWPVxsHjaQ28zFc4H26RXiXKPgkLmaON/+GZ5BmfBEHd1twShOLj44YpYBJl0CwM
 Na0tTsnjFaUyTCOFzfmHqXBN0GZMEr2rL15F0uit7yPxLyKnEYzqQp4Hra7MkECm/+ILQjb4fp8
 r+Q5kJYknmLLBvF7J8HEaqHfP7bsKAtQ1lEu+C2gGokGAJHdXPtPgJ+ho/zEZBr2nul2wJAVg+4
 6qLAd0WlQ6aB30sO4rg==
X-Proofpoint-GUID: CAViH5UmZOjuwSVvlodwTQI2VZu1tS6v
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232664-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: B2F5A3744CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PDR and SSR callbacks are registred from the controller probe function,
but currently released from the child device's remove function.

The remove() function should only be unwinding what was done in the
same device's probe() function.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index f26fe54b2ffb4bbfe6da6b717257313536abf60f..fd533d5bceb6d7352e8ac6fdce321d3acc285f1e 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1683,6 +1683,9 @@ static void qcom_slim_ngd_ctrl_remove(struct platform_device *pdev)
 {
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
+	pdr_handle_release(ctrl->pdr);
+	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
+
 	qcom_slim_ngd_unregister(ctrl);
 }
 
@@ -1691,8 +1694,6 @@ static void qcom_slim_ngd_remove(struct platform_device *pdev)
 	struct qcom_slim_ngd_ctrl *ctrl = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(&pdev->dev);
-	pdr_handle_release(ctrl->pdr);
-	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
 	qcom_slim_ngd_enable(ctrl, false);
 	qcom_slim_ngd_exit_dma(ctrl);
 	qcom_slim_ngd_qmi_svc_event_deinit(&ctrl->qmi);

-- 
2.51.0


