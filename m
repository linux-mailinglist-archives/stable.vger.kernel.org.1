Return-Path: <stable+bounces-245160-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDXLMR+UAWrsegEAu9opvQ
	(envelope-from <stable+bounces-245160-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:32:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5551050A240
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38C80303FAA9
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837953B8BBF;
	Mon, 11 May 2026 08:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dPbIws78";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RfZ3EbSB"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53712DF137
	for <stable@vger.kernel.org>; Mon, 11 May 2026 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778487988; cv=none; b=VR9KuSQc6/LruOF4Ggfi66iKu2VMjiwpDCNWBtsNV1hJGr5eX8YbtgVYa5GRAAHG1iyKopA5go4eobvFSXt2+L8mVgzEIn2jjSkf4eRlwANyKN67xKokDx8eRUt5A5r3g28UU9c37RlnUNpVo/W2D1NpgmfTmoUBnxgYbg82U0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778487988; c=relaxed/simple;
	bh=PZd1rOdk1doX7S37IoF3Qx4tSAyYcCh1+fi+JfEvjUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s3WGwffY94abCjZcwZgkW1iuGenMqg/LKR3nyO73FEG4MIWKYJiwGNXXU2Yxew+04HmTNw/nVFTzMDWYITcQzb0a6++09d2wlchZ3d5AevA2Mq0fPDmoPLAOvsRNxjrR/pE22G5f6iWVnoJMkd0I3EO0qLQRkmnzcyHCz3vCE+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dPbIws78; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RfZ3EbSB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B6gMlJ774891
	for <stable@vger.kernel.org>; Mon, 11 May 2026 08:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=s50l1Fr0E/xgiAzqjNMO/C5poeW9+LNooqy
	NsR41WQI=; b=dPbIws789bBPh8fkjmlKbNpXe/uU9Xh9AGh6udKON2TaR7DuDeJ
	ERMuxYgZwviO/4z9CrxXQufuAtJF0h7pf8YlgNwSVBSLRsMYhBaaxYmoFKI+sSxy
	X5PDeMALsLw0IVxvTjop2ivC639Y9fRh/525ggogstLdrwDbcNImy5DvbUY3Uo2h
	k8kWY9MAzsk8NktHPJcw4d0JTUpfcfgQiw4jsnjE4/NlzIEUrI+8ObjyFZSo9GMG
	D9hkTVOzodXeiAGiAC2Ihe+0AW5jD9eZbm4cSKfnkE2VPyqVKJZVrre0o/PUOccX
	Pau3ax1KV3TnaAfNYtJQ/WimPryFsk01/Gw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3a32gbpa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 11 May 2026 08:26:17 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b220c72bbso66961141cf.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 01:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778487977; x=1779092777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s50l1Fr0E/xgiAzqjNMO/C5poeW9+LNooqyNsR41WQI=;
        b=RfZ3EbSBsK9WUcqa7DLZf0LI0XPKoHF7fKbaJzr08h+SIwxAnQtG3XeQTRQ/pYs8yz
         0nLrUkokAt7aBM6NMUxXKvxwEatB/Vxbq+ohJAylmfFoRoKgfZVoaBf5VkE9XmTw//cj
         3yKucsdCFCGJ3S3Sh01t2kSJxzIxhPowiPhYr9ooJ4L7ebChem0b3JLuDSYNS4FM5Vjo
         8G0rR3He/d7DeayXcbgiQbaHkz7+wnzOuXbo01tS1ZEPD3mcQnd1bHJJwCkGs7NpwIMP
         7eA7VDURK6CcBCQ9ogg2JFShNB+RUDDq583Y0wCd/tqQih90tRbomzjvwbShRhtFv+wi
         iKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778487977; x=1779092777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s50l1Fr0E/xgiAzqjNMO/C5poeW9+LNooqyNsR41WQI=;
        b=oFWe7i7QjW9cz5K6yf9gSSbHVD0fJA6jZ1W9BvLymSgg2qOvGqolubnsOz7swvJStD
         5OxkTdcE+KovVcPh4YOChmv75SiMBCbhDHzlaysnTcaVuaJqCmphkjcYJ6DLe0LPZfZV
         1POBn/ZAfZcoUo5T5QFmWmiRBqvextFEEbrd6bgfjbRt9wDP5c+h6N29JXD5Dw3hX07o
         rF8v3yKj82v7LC8tWcOCKA0GErzERIA5i+gHGBWTp79aK+05OSGXKipG5b7Khm3tBPba
         fVawzOvSkHGPjUA98ERX5Z27GIpBnOGrEhrjsT+YvnvP7Aje9MwkKyLJKJVOlumUmZWd
         l47Q==
X-Forwarded-Encrypted: i=1; AFNElJ/BtnkDQ0pOt9oZnHkAZXEM3rIDz076m2CmOcoJGE93n0sXd5PzDx9IFQL2Ibup/ic6QRs0LT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq+qNKgcKocn+9uK4ChlTdQYRSARZXjWJholVqm7Yebmt9c1nB
	jWwRy34S7jK4kFLGT2khBAGpyVXfMDtFRsgVR7y0u08kphx3Xt3kutSBb88JKDvYfBXnreXkofi
	6Xl38F9ONxaksNkkHMPrEve95k4lqVcnI/B7gamKgNy/dN89/OTkod6yRlD8=
X-Gm-Gg: Acq92OES0MO/ubIOjEmq+bRAjROi6Q0jz1HISW+Ujkvyosz6+CISyWJX3EUyRQDmL/l
	PwvQMyhCTV9F0KanRR4tgsFuRac509yiy7StPeXEmNLgF0Eu7Gtd8RCJiW4NARo1yzz0nuOwou9
	EWBykxoJd+cpoUhTQ8c0xghPIabtKuBnMgZyfAfn40wCw1yqY/mMCMvAENuNN3f/I0r1SBk2+0F
	odIgzMAIIC8XuYVO9vf75FxEOTfm9R5P5GYeR7F4APOEt4UgcFIWrNx+ITrfx6cvt8gl4zarrVx
	JBV5dEYd6Sg5X9F6Fjmk05OJFPs8OPr9TT75FMnDGm47yagh5UpAzFqjqlNlaJTAkuTwk0A8ATg
	UwTGquHCYn6B3tPaETYWKqr+C4kU787PE4fA/4H04Q84hXhTS4Q==
X-Received: by 2002:a05:622a:4a8e:b0:50f:dd9f:1223 with SMTP id d75a77b69052e-514621e0040mr348676261cf.44.1778487977005;
        Mon, 11 May 2026 01:26:17 -0700 (PDT)
X-Received: by 2002:a05:622a:4a8e:b0:50f:dd9f:1223 with SMTP id d75a77b69052e-514621e0040mr348675991cf.44.1778487976592;
        Mon, 11 May 2026 01:26:16 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:63bd:c2f9:cedb:aa32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e80ca2666sm88767225e9.10.2026.05.11.01.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:26:15 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: David Heidelberg <david+nfc@ixit.cz>, Jakub Kicinski <kuba@kernel.org>,
        Ian Ray <ian.ray@gehealthcare.com>, Carl Lee <carl.lee@amd.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Sasha Levin <sashal@kernel.org>, brgl@kernel.org
Cc: oe-linux-nfc@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] Revert "nfc: nxp-nci: remove interrupt trigger type"
Date: Mon, 11 May 2026 10:26:11 +0200
Message-ID: <20260511082611.12721-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FStUT_RFEIieHkEzeXRI9hxTQQwIx1t8
X-Proofpoint-GUID: FStUT_RFEIieHkEzeXRI9hxTQQwIx1t8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA5MiBTYWx0ZWRfX1dmVsAN9qKjm
 eiRZF4p7h2Y0hZbLi+S56kGntuynjdLRh9W/M7/9a55TU10c1CVm4t4RgE1jb1tTEMfUdYYGoQ9
 TP0WSpUgLzJCMpRyFxzVEJu3c3/CigjTro6oMYxuMDQr1tMmcyG8PPIxUGuuOOA0ROMINTdLSGM
 5RS0yWoG3jETrRdC3xAwuU6UXwzS1gYC3xkkmtB7J7XFlVWKw7WjMNll8xDeBsQ8rzI5e/0lKu8
 g9E72r0SBwHB6qsNO5bRBKc2PNkb/G8Ik4cCwo6uQEg8yn69eg6HQu94mePdn8AcrcI8GBncVVT
 OyPl8jb6kq4Tkg5jNgkAtiYyKvn6aViQ3NfeUg3JLreNai/zh3ZY400JLAKb5FEqMNAlBXFuBM1
 VISpXuVd2d4R0iM4rB1vBcookH70PW2KIUNpkZAMRDg1uy1yxPju4cBFqsMe1Xggr+4btPqmnZH
 7cfeEoQzj9IquqYOiQw==
X-Authority-Analysis: v=2.4 cv=SLVykuvH c=1 sm=1 tr=0 ts=6a0192aa cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=EUspDBNiAAAA:8
 a=hc3HNdYz4iiQibQtTDAA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110092
X-Rspamd-Queue-Id: 5551050A240
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245160-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.994];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[stable,nfc];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

This commit causes an infinite interrupt storm on Lenovo T14s (at least
the AMD Ryzen 7 variant) which requires blacklisting of this driver.
Neither firmware updates nor the proposed solution[1] seem to help. This
reverts the change due to an unfixed regression. The problem is present
since v6.19.6 stable kernel.

[1] https://lore.kernel.org/all/20260311-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v1-1-9e20714411d7@amd.com/

Cc: stable@vger.kernel.org # v6.19, v7.0
Fixes: 941270962861 ("nfc: nxp-nci: remove interrupt trigger type")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/nfc/nxp-nci/i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index b3d34433bd14..e99e1f381028 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -305,7 +305,7 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
 
 	r = request_threaded_irq(client->irq, NULL,
 				 nxp_nci_i2c_irq_thread_fn,
-				 IRQF_ONESHOT,
+				 IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 				 NXP_NCI_I2C_DRIVER_NAME, phy);
 	if (r < 0)
 		nfc_err(&client->dev, "Unable to register IRQ handler\n");
-- 
2.47.3


