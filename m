Return-Path: <stable+bounces-243886-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKHXAozV+Gm41AIAu9opvQ
	(envelope-from <stable+bounces-243886-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 19:21:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 725944C1DDC
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 19:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B53C308500D
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 17:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92793E4C9F;
	Mon,  4 May 2026 17:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K4PzJiCq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PrsQ6nML"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CFD3E51C0
	for <stable@vger.kernel.org>; Mon,  4 May 2026 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777915038; cv=none; b=Rwg25eZ9D85+89wIlnyw0xpte/KmWDnCoJPMx1cu6R081CrlHD5UHJI1ErkER1YdJ4TwCDrNBQYsNKLXPLhplzObVrOc2Xt2q7e3HS7i5z66BAzWH1Tv4kyjEoHEq02sRGdKDUHjXQgYpaN5cjo+AqBCTNIjB0NqPyB+OTpS8gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777915038; c=relaxed/simple;
	bh=me7LlBI1nMxAAL3914xa0NNnyNBO6iqSTEZkR/ryMk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=atOCDSGae5x9rh4+qV/+zyMaK37xtXAH9bmz9Mh+aPDmDfPxu7a1FkTFu9L85Wo0EBKIrhIcA0F2Oe2SVcJYUU/fotu3B51JZj08/CuSvTkh5bq/ympd/U/dyFrnabIwH7NoKdfQtqzbM9f6Tx0uaDbvamYKCbuYo4cp89ERJgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K4PzJiCq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PrsQ6nML; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644E2hh51186937
	for <stable@vger.kernel.org>; Mon, 4 May 2026 17:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=UNH5pQ64r4nUU60TyQ3qC8KKJDFPHI4UC0Z
	WJhC9M4M=; b=K4PzJiCqUXOxQjn4FY8LftTo7Rvym/4Ac1ivVvd7+3M0ma0MQtI
	r4hYCNcVNv/rrypPSiCIf/XFooALCtVXLK9zLcclJemHzefVJc4OGvL/1A0+R3K0
	+tbH1qALjwMid22pPlbjkZykE6ZEXTTRcgIm5mCT1jGwsRMPRUp/IsypULnmhw1z
	2WgVB/lP/O3NLORw4RIT7GZDnKcDtO+pIlv2fpP6Enk+5Hr++qyHd/WClOFixBH9
	4Y/WqMa1l8Owc0vdyaOnI6huZpiQDoveiqF6FMhHjB5B1TO4Y7YpNcXdIXB0BrqB
	mN68C2ChS4d3ckzadCEX03wwZifSU3idykg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvvg8r5t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 04 May 2026 17:17:12 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c79943d2fbfso1253012a12.1
        for <stable@vger.kernel.org>; Mon, 04 May 2026 10:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777915031; x=1778519831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UNH5pQ64r4nUU60TyQ3qC8KKJDFPHI4UC0ZWJhC9M4M=;
        b=PrsQ6nMLRW6jfle7Y9LawIPisgBSCiTC5EuN7YUbyKqlMpxsHOurhTFDTwhowIk8r1
         D/B2lYy/MzGcJhwP5aIoDx0rnHfQtQ+yYDaVVFJ9csl45GAXfCGIFbNF/jdHYVNjmBqg
         M/9IjgaPg0Kq953fJSLIyQ4B4cV1yau1r29GZiHyIh9jIv1SXCuehzuv9IPYfLmOuKOl
         Aojg51C233ir7RMxFQRKA16HGHBv/9q3SYiAskBLmkWxXzhlE5Pq636DxMpBdpKoEG7t
         yX1gLgIs/FVSxsHZiMWFoyeNikBW8b/Mkx7D+8idI6axGZ1ebMoILxlmvX88tTHZyR3C
         lc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777915031; x=1778519831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNH5pQ64r4nUU60TyQ3qC8KKJDFPHI4UC0ZWJhC9M4M=;
        b=YeIlcsu3u6KEZ80CyiSnbbMSJz1rXGLbi297ukSKzuC/Z1IY5wNhhZWFYoPhemg8fg
         1OELuvNQNAaNY2G3eMWjINwrUb7vYAbBAjyToAqna6HY4ix/GJAoVvlVSl2X27szMDaw
         v9Mo8F19prmYH8YgJ/K1CValWU+ToqgY7cLT5miHH8PKs50lQOMAtKEp3Z77Lr/x8mfc
         S+FmfM/KiaC1UKfXj3g8QBlwtnanZtxg7UYcD/VkRv7AslsEC+6u/Y8sNyT0vNldWqRi
         tlURwEL5Hl4jhfdAJJc47xWqkdQJmLgW42WsHIDA6z2M6gLnrxrh6AMHaYEcUGrejSJx
         P8yw==
X-Forwarded-Encrypted: i=1; AFNElJ8lSqNHrb0+wWJGCRGL0l4r2GH3n0tIw/Bn0/5ct5uW7FiWo4P4mJZNnaXjQomkl6cR0if3EKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrEc1k7YsKRLzbigMZafzm7nX/ngQJ05dJZ20uAd5lXBYsXvxn
	YX3XTRGCTFbxqOXEK1eH1zewFy/rTRiE7fvn+Sg02S2Vy70HTmRwVx8seCfh6Q2NVMm0BOK+DhF
	4cK0E2V/LM9Hy37lm5BRjQKtrN82LV49/2IU7fVcaqkqSajMdRsixQWe4BFc=
X-Gm-Gg: AeBDietO2NcgCNZJYzNs0hiOnGOm/C7741OjGiabYKzrKrh7sF6ClTxcQNz/hi9zWAj
	qBGrZu7A7z0dQGJY1efCD9soJ98xW7/fnaGmfuc+v694vOhIzHdzrQ4hsyShGtxo0dkAzj2t7rt
	907pfq+INubaxCWiv/duMyj0YXb19ktcIxG5IDfShnuiLKQkckgktG4vIIRnWUud4cGVxz/LVjU
	Yd8+/45715kh3syeTalOEpQX/fPI8bSBa4Sg3WeWDYMQM1f9fJnS7hJuamguKzZ3KXP3MbPWf/b
	ZYFkGVvmVMr9sYPS7eVZiJYGC4TFWvLgVj4Kw+EdGOEcKk7fUR3J8lgMmtLpvkpwtH2jLMmsC/A
	uGa0wFD71GGQ4bpJXfYG/yMvOmPXxbIDCL21PkG2eFkPwI70BAqb1SSSY5ds=
X-Received: by 2002:a05:6a20:7d8a:b0:3a0:cd5:82a6 with SMTP id adf61e73a8af0-3a7f1c6759amr10124024637.46.1777915031190;
        Mon, 04 May 2026 10:17:11 -0700 (PDT)
X-Received: by 2002:a05:6a20:7d8a:b0:3a0:cd5:82a6 with SMTP id adf61e73a8af0-3a7f1c6759amr10123981637.46.1777915030474;
        Mon, 04 May 2026 10:17:10 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbc6f063sm10398240a12.20.2026.05.04.10.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:17:10 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Escande <thierry.escande@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>, stable@vger.kernel.org
Subject: [PATCH v2 1/2] misc: fastrpc: Fix NULL pointer dereference in rpmsg callback
Date: Mon,  4 May 2026 22:47:00 +0530
Message-ID: <20260504171701.18164-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FiZpzW72kkO2uq-9pSrvcq0k7wwBwnJq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1NyBTYWx0ZWRfXzerc0rvLeuwY
 /3z4Jry3tuDDZ3HfTFYoFBtt+KEHo2nPixPcBWeQNia/PV4o75yBFfCCT152Rty9rMroF9ijlGw
 z95oSiz/w7MJMaaWmFy5csoE8jfqb76Ir9gKGQuy+zYVA2JB7i7CKliWqcDse61U/tkbXEGVuqm
 uK/0MsTA4iaH2BSqvnmtKp/L07eI4i9z4uL3/MXiroF4QvQRmTIahmGUH11B2EeZzprFtkekSv+
 nrfhOGlxyq7Sy69U/EOSfRCrYC9bPY+H4YqT8ON8u2LZDwDprHCiXSpoOsKBe5A2n2py82smJ31
 quE6DFjOHt3Evb8AJCYRTxz7tlJNgDdnNWS8THIKaIc0TL+vDheBWe++MUt//wUyC5vJg9QJ/e5
 hJ36P4u665iLyWBBl4wKL573dQz1yJdQIRNfYge0kxyNF7+dBifVoI5fHC/YiYwtYvEjz1NGbKM
 zeFSEtd/sgNnr12o47w==
X-Authority-Analysis: v=2.4 cv=K+AS2SWI c=1 sm=1 tr=0 ts=69f8d498 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=MnYYGAq_QTRuFDU830wA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: FiZpzW72kkO2uq-9pSrvcq0k7wwBwnJq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040157
X-Rspamd-Queue-Id: 725944C1DDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.ojha@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243886-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

A NULL pointer dereference was observed on Hawi at boot when the DSP
sends a glink message before fastrpc_rpmsg_probe() has completed
initialization:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000178
  pc : _raw_spin_lock_irqsave+0x34/0x8c
  lr : fastrpc_rpmsg_callback+0x3c/0xcc [fastrpc]
  ...
  Call trace:
   _raw_spin_lock_irqsave+0x34/0x8c (P)
   fastrpc_rpmsg_callback+0x3c/0xcc [fastrpc]
   qcom_glink_native_rx+0x538/0x6a4
   qcom_glink_smem_intr+0x14/0x24 [qcom_glink_smem]

The faulting address 0x178 corresponds to the lock variable inside
struct fastrpc_channel_ctx, confirming that cctx is NULL when
fastrpc_rpmsg_callback() attempts to take the spinlock.

There are two issues here. First, dev_set_drvdata() is called before
spin_lock_init() and idr_init(), leaving a window where the callback
can retrieve a valid cctx pointer but operate on an uninitialized
spinlock. Second, the rpmsg channel becomes live as soon as the driver
is bound, so fastrpc_rpmsg_callback() can fire before dev_set_drvdata()
is called at all, resulting in dev_get_drvdata() returning NULL.

Fix both issues by moving all cctx initialization ahead of
dev_set_drvdata() so the structure is fully initialized before it
becomes visible to the callback, and add a NULL check in
fastrpc_rpmsg_callback() as a guard against any remaining window.

Fixes: f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic driver model")
Cc: stable@vger.kernel.org
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
Changes in v2: https://lore.kernel.org/lkml/20260417200146.184425-1-mukesh.ojha@oss.qualcomm.com/
 - Added stable mailing list and fixes tag.

 drivers/misc/fastrpc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 1080f9acf70a..a1a54453bb7e 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2431,7 +2431,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 
 	kref_init(&data->refcount);
 
-	dev_set_drvdata(&rpdev->dev, data);
 	rdev->dma_mask = &data->dma_mask;
 	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
 	INIT_LIST_HEAD(&data->users);
@@ -2440,6 +2439,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	idr_init(&data->ctx_idr);
 	data->domain_id = domain_id;
 	data->rpdev = rpdev;
+	dev_set_drvdata(&rpdev->dev, data);
 
 	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
 	if (err)
@@ -2513,6 +2513,9 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
 	if (len < sizeof(*rsp))
 		return -EINVAL;
 
+	if (!cctx)
+		return -ENODEV;
+
 	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
 
 	spin_lock_irqsave(&cctx->lock, flags);
-- 
2.53.0


