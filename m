Return-Path: <stable+bounces-232668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALo0B2aQzGnXTwYAu9opvQ
	(envelope-from <stable+bounces-232668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:26:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E5C37457B
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 05:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C79C93052FF0
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 03:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A1B382F0E;
	Wed,  1 Apr 2026 03:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mFStLK6Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i16h6giu"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BD33815ED
	for <stable@vger.kernel.org>; Wed,  1 Apr 2026 03:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775013778; cv=none; b=V2276gSmPTjmCJDWTSet/ng3ZfSL2CFbt6VSeRLApd6JoZ8rHAkOO5aNEUolqYySp5SUwGbiBeb0yMaP8hwN8KHqAeZQ2gBbv97DW3ZCRKmI/KxIKFkUKTK+dxVogb15PJRu6EEDS26NJ2zGh2rOEj49Zud39qXIvxTl3FBsRO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775013778; c=relaxed/simple;
	bh=AVfZaoV52Zemlz44iCWPkbWHnMtfye+5gx/LtrB8bIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uWs7jXUnX2z29pXm6RIxmP5OG37zPe1O1brhx9LqmmgfmfPPBbYIz2QtIlj3jr0JVWOpa6i72AjD5oK/LAtU+Mb3AH1P108SngorjhNlgH4DphE/p0HBlxjFDhGqfluPg96ueFJfknZ/qZWFIYtp6VsMiShuhRuwpEr5xZU4Rio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mFStLK6Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=i16h6giu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VKXPhJ3364339
	for <stable@vger.kernel.org>; Wed, 1 Apr 2026 03:22:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QUSpTEXIiQ76gomCYL360Rs09wMX852FIY4mdJ31vaA=; b=mFStLK6YZpAkBcxl
	vZAKaCHVDDDUo2KqBnrpZL7h7Qh5p2eaGVu8L9nIH0ydZJCDNfcbAPBPzTjPJ/fI
	wp7CfsKuDbdiTqBQ8XUsx8jgDWospq+IN5IAZzpVSUwLaJROZu42qSsAUnnQWwK6
	p0UhjbezQtagxBUwDzPwgg8Xs2jtX9BAmiIAnwf65ODEIwfipBOtLyx1DvLJvWWS
	iBXGNwkfo1rKCvf4HvpO3ec06G7BX61/qU+3BDDYqG6mSYb68vrDhuee4Rfl41yX
	4m2rM81D6w3lGGKwcKu4ccasDAF7KzJ40s8tLpJvVwB9I8f2x0uHIE2GgOMumHoe
	WRoD9w==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8nddh9vq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 01 Apr 2026 03:22:55 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d4d4db1523so11150270a34.1
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 20:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775013775; x=1775618575; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QUSpTEXIiQ76gomCYL360Rs09wMX852FIY4mdJ31vaA=;
        b=i16h6giufxKlSsgvYNJ0vcrgMElenDZVZy2/j0QgU+82aMhI26XBI2//9opnPNinB/
         o90EKVRy3VNeWD2P6YSNwPDy5PiPMG9LdpZxYE/pTZJSnAZgjih4xeMeBLHEMvW0uXYH
         gs31VGeCg9uSCOc3rrkN7peSwqkJOszjDyrJATgsXjZOAB7LH2xebh6epuXkla3nuNVB
         0eGzljD4dtRoijDZX9WCHI3MzIqwiTuYT+y6ktZXl7Gd9QFDlplGJ2GavC224sTLnYj7
         n4s4nGRH11UTFApM526M5j7Xaukx0/psCNvig0cAc23wmNkZ/lBX0zRo0sdXuRog9nJc
         U4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775013775; x=1775618575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QUSpTEXIiQ76gomCYL360Rs09wMX852FIY4mdJ31vaA=;
        b=LOD0eykndL11fos/BeFMBo8ZBK+Iw+l7J4zBeaMFAtmKBarFT4nVb9Cd97wyPvf2k1
         /oshnPJdmmYJrG6Tc4c6XnBI/sAK1T02JiRUHQOG706xY85XTuP+bQ++GyhCv/Eeuoq4
         N5G5l3LS8u0bW2vE0vgNgXK0V1fFzDee+4wYsmM/b/2dZjXsx5m5P/HZZoczinr7BoCW
         weeAmFb833AbUFTpXA3d2eXKDzlRZVKldyRNCCe24PMQCozSdyxOe31uktJk0QDmKxf/
         ypulrX/TJYrdWpDzElG7j0FtPUVJ64TYXM4yOu4cI8oEAzlez02Dv9fJe2BkDDbYhfiK
         lUXA==
X-Forwarded-Encrypted: i=1; AJvYcCUEH2vzjb297sbdEG0lXxsf43Tkdv5fvBLU0CzTo1GtBeRfycrglrqzx1p7XjL64W+vJxznotU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzvzx4do97akkevQX9EqgTSxGmyp7tIooHn9wlAe4NjhBdHorg
	rcrwsa29XonZH59RFqQd7OLZyhK3Xilo4y2IWsUnG9+JRPzdf8s0MVxl4b05283hbqe6WrfZOML
	/Gv6DowgpGr59VJXIvh2ooyerU+OHU4J+XwPdN06iHNyX+qob4kS3How3vE8=
X-Gm-Gg: ATEYQzzT+N1vh/3DkuCb26gEEs2IGZBuVamhdVcmvwG4yCDN4yStJBZ5osliKcXjv5t
	aFEyFjekL+kKzugtHIqjy/rMx71v3pwKfH+cfke8bBpdv01G23cEf6Pm+aDeEG0V97s2yI2zxSz
	M66S5FnMhAXoQpR7RpjuZUG4kEyH3yiesGMj8p2cZcKMVfe2WFxfGVnXCM8NpZHlDOecWHqRY2D
	AIYtJ+dk6He8mCssFUQvgk3WT3R/MckmD8M9vFj5IfwR68NnqGKhl9bharnba9F+oh5CkNENppD
	H9GF7aRVHFuMEqx3ABLfKbfD/K4u/Tp5lYGrEIfeUuuAFXBCRN1QHF90vEFUEjIYdgaUq0nuLSa
	I50mrQ5U1WCPz++vI2KdtSCo3+ZR5llqF8/751U/SQBE=
X-Received: by 2002:a05:6830:67ff:b0:7d9:71e7:abe5 with SMTP id 46e09a7af769-7db992c3b82mr1331213a34.10.1775013774937;
        Tue, 31 Mar 2026 20:22:54 -0700 (PDT)
X-Received: by 2002:a05:6830:67ff:b0:7d9:71e7:abe5 with SMTP id 46e09a7af769-7db992c3b82mr1331203a34.10.1775013774544;
        Tue, 31 Mar 2026 20:22:54 -0700 (PDT)
Received: from [192.168.86.59] ([104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a336d73sm9589357a34.5.2026.03.31.20.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 20:22:54 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 22:22:49 -0500
Subject: [PATCH v2 7/7] slimbus: qcom-ngd-ctrl: Avoid ABBA on
 tx_lock/ctrl->lock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-slim-ngd-dev-v2-7-9441e9c8420e@oss.qualcomm.com>
References: <20260331-slim-ngd-dev-v2-0-9441e9c8420e@oss.qualcomm.com>
In-Reply-To: <20260331-slim-ngd-dev-v2-0-9441e9c8420e@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2713;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=AVfZaoV52Zemlz44iCWPkbWHnMtfye+5gx/LtrB8bIo=;
 b=owEBgwJ8/ZANAwAKAQsfOT8Nma3FAcsmYgBpzI+H/Bws0KM+n+XbFSKLsYTnO6VswLWPzloPV
 gLvZo49eTSJAkkEAAEKADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCacyPhxUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcVRNw//fmBfRu70pAiuVZ50G5AIWNnCReWKbDWtfEGEZBZ
 QYC0FO449IE/SXGtkHQvt9FhvE8G35oyQEDamRF/SvdBfAEFvwUP0qzFfapue5S/NysSxIfWP3H
 FZnCUJxFJACrQ1fCOG809frFkdIQ99YkbE+cwKq4OjXdQBLMqz7AXkMxxIScUThi0MU5L4d2s/h
 zW8dpauQtGb7BiNuXrxDiIv4NCe3RRrY28NbGBipXSS+yMJFr5bjBWv4zKp47ij1xsSWeqacqHc
 npdPEveCZS+ziEEVcJabBGUrbtdr7v0rLslC7ggjTbu+CQzmxlQd6PtKga5+zQzzFWcoy1NS6tm
 lj5UR7SuC4IDlc7ZSOR1dW55H7BJJ1ViKjzkch5xc6AJOMs02pgRev8a4Zrsacv6Tu1VhQ4Z1HP
 QjCsX4KdOV2FGxblkaWeVv96oWdLZlVoCuv/mCvT/52FV7owru0XOZRax5LUdozIBv5R5px28El
 t1/A998UB5i7TtvhIcH9MTUbVoOeDhywlVtGsYto5zYwuR+mwWAMfV2yXAwnuWwEB9lTuNkmNUw
 EB4l7AQfCDFgv7uPPkVZuo1GLk63eRsC5IFC53SvITmdhEl+vqfDjga47ZrTeuSeZ70qcgM6pfr
 mMqZXrOu5BKN+xB0fZ2fTP+N1TaOw4mmXRm9fxO92qlU=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Authority-Analysis: v=2.4 cv=ZfUQ98VA c=1 sm=1 tr=0 ts=69cc8f8f cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=YEP7kvCIQ0LacLc3HpEA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-GUID: X0sldSlJ7Cx215UdAp9B7yBe4AK-6x6P
X-Proofpoint-ORIG-GUID: X0sldSlJ7Cx215UdAp9B7yBe4AK-6x6P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDAyNCBTYWx0ZWRfX8dKP0kNoPFCx
 hTiZgwpDb8SeUpFdZtTdNAPK2PoEifKbg/aBILek+7RGUezrz4wqMRVC7prCXEQj0FvHVE8HNvm
 mcQW8r6h8V/IWfyFlTkFoe+qTU5aeowo6r0sKb6zywKK75Uri/yAZPJtxIT0zTw/OwwDL03Lhhq
 nTbOWJhEkewvUmxnKRRtjHxtohrsCIXVqULt+bPIMBXjbAo7XsgIRLMynd715bPWHVrn+fLY4p9
 0JkmbYLRIm+UNchnO7DHBcNsx9pgGoFRmxdfeIwuR941ku31jnoIxvhIlwvmkkVN2FN/hr8uDvv
 UxfGDgVq6RdHbsgStkRWQV27HC4db4bP5/fRRkGuOMsDvX2xMFo3hNo7h3ZyqTLF+V0b1LYG6Vo
 uyQOgJ/l7rsLQmcxqzhrm2rEiNMbqa36AEs80KakwiQOnysGbXK9giV4ZTQ9o5TVPdHdb2Epo7H
 CDzG0HDxpo2hcfy3TFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_01,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010024
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232668-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[bjorn.andersson@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 42E5C37457B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During the SSR/PDR down notification the tx_lock is taken with the
intent to provide synchronization with active DMA transfers.

But during this period qcom_slim_ngd_down() is invoked, which ends up in
slim_report_absent(), which takes the slim_controller lock. In multiple
other codepaths these two locks are taken in the opposite order (i.e.
slim_controller then tx_lock).

The result is a lockdep splat, and a possible deadlock:

  rprocctl/449 is trying to acquire lock:
  ffff00009793e620 (&ctrl->lock){+.+.}-{4:4}, at: slim_report_absent (drivers/slimbus/core.c:322) slimbus

  but task is already holding lock:
  ffff00009793fb50 (&ctrl->tx_lock){+.+.}-{4:4}, at: qcom_slim_ngd_ssr_pdr_notify (drivers/slimbus/qcom-ngd-ctrl.c:1475) slim_qcom_ngd_ctrl

  which lock already depends on the new lock.

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&ctrl->tx_lock);
                                lock(&ctrl->lock);
                                lock(&ctrl->tx_lock);
   lock(&ctrl->lock);

The assumption is that the comment refers to the desire to not call
qcom_slim_ngd_exit_dma() while we have an ongoing DMA TX transaction.
But any such transaction is initiated and completed within a single
qcom_slim_ngd_xfer_msg().

Prior to calling qcom_slim_ngd_exit_dma() the slim_controller is torn
down, all child devices are notified that the slimbus is gone and the
child devices are removed.

Stop taking the tx_lock in qcom_slim_ngd_ssr_pdr_notify() to avoid the
deadlock.

Fixes: a899d324863a ("slimbus: qcom-ngd-ctrl: add Sub System Restart support")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index afd2171d3be2c4c19994e9ebedc63dedfba899e0..2ff4374a1e0ce5d3d8f9b074f19fe77daeb79dae 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1471,15 +1471,12 @@ static int qcom_slim_ngd_ssr_pdr_notify(struct qcom_slim_ngd_ctrl *ctrl,
 	switch (action) {
 	case QCOM_SSR_BEFORE_SHUTDOWN:
 	case SERVREG_SERVICE_STATE_DOWN:
-		/* Make sure the last dma xfer is finished */
-		mutex_lock(&ctrl->tx_lock);
 		if (ctrl->state != QCOM_SLIM_NGD_CTRL_DOWN) {
 			pm_runtime_get_noresume(ctrl->ctrl.dev);
 			ctrl->state = QCOM_SLIM_NGD_CTRL_DOWN;
 			qcom_slim_ngd_down(ctrl);
 			qcom_slim_ngd_exit_dma(ctrl);
 		}
-		mutex_unlock(&ctrl->tx_lock);
 		break;
 	case QCOM_SSR_AFTER_POWERUP:
 	case SERVREG_SERVICE_STATE_UP:

-- 
2.51.0


