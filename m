Return-Path: <stable+bounces-211213-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHocFhzocWkONAAAu9opvQ
	(envelope-from <stable+bounces-211213-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 10:04:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2060642DE
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 10:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 55FFC5E6A68
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 08:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98C04657D5;
	Thu, 22 Jan 2026 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fxKj32V0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CCSIsfDq"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E902336AB4B
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 08:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769072038; cv=none; b=EoOfCQkUAUSrinHqOCGcvc6MuP73AufkiX2crONhytoDpBA89JppDzz1yMGjTKQ2GQHhLjfkwJ812oUDzK55TytArylhpBoKM3iB63DElijypar2NeJkjSUNMfmtHDYuw6v987AhG5GyR6u4k4Zcn26rFJZTJHpRL0CQ6DzwZcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769072038; c=relaxed/simple;
	bh=fEYCB1OmXJHFLfozOgMIdwRQktFqsVtb3nHoMKfmXLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LHfPZf10TZeJxnFi1Bcu2ZKdsgTNJ+LeP2EUU6/CGogA1H80ggyOmmbaJNSIDEDqTNMqQWbZ2Pg9K9H9VLqrT0WLhxqckTCm2MbAOSID89V5epBxbFdt2dKwjXebCSOxCmOuGuvWpsXhZJwLnaqbwtQHqVG7smnZ5NN/r7XdKTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fxKj32V0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CCSIsfDq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M6riOK725129
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 08:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=92J8WnSaQyl7D9plb8idv8
	AXwTqatCyT3Ld0iG7JRRo=; b=fxKj32V0jHc4S9sy+tFsyCXGiG9ssv56htCPpE
	GJTBTJROdDKx9lzXW3bDzagPxOq0yvhvkPuAqoOWzXwYW7FnjTCKB6bz/yacbqZ0
	9QLvNQi/+anmsBJg4B3kbupHCH9v2pWy7XWYWmlaCxmIAG0jpNweT4iWWid0hL4H
	0L8ytUNVu3xdVpDqIbcyU0QVpD6XwahG4k6HuTz5bTSZyu7H/sVmqYTJNRaSPaLg
	4uOsIb+xfj0mzlVKtGPxt1T5qeyeL+WFCG9eWM5PZI5A6qBG9TbZSkIqtBEzd15h
	fOUL/VYEIvFJSaM/h/hvhwy6Q2OA6QUpjptErSr0IarTDWtA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4buf1bgb4c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 08:53:55 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12338d13f2cso943151c88.1
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 00:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769072035; x=1769676835; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=92J8WnSaQyl7D9plb8idv8AXwTqatCyT3Ld0iG7JRRo=;
        b=CCSIsfDq+9P+Na0Rb72dNHWq6k82m3S3YLqDTGXLWi8XoknhfHzSxeIHyZbQ7dKExZ
         lTQiNrXKBqXQ0+i47YYJ3TYmlQgNI2fPcPX7Ara9+IbU+3MWfUilU9IecD1OrwNd9bpd
         8FNp3o0/O0gccQ7G5upwBmHOdNeEu/kkBDrVaHyZ6Kt5WFlh4k1J2m/2qMyrRMx7uq2o
         H7mEq0QnXHkU3jqhQdr8q+ibJKvVSXil5I3/4XCbUHAUP53U9IfZiEtEVuvvjvHvPALX
         r1mjZyJ35q2fstmnAAmC377n0fEre1EH0fw++65LxXaACSEOh4YaHp55A2yMLICWX1pX
         vCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769072035; x=1769676835;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92J8WnSaQyl7D9plb8idv8AXwTqatCyT3Ld0iG7JRRo=;
        b=e9j4n+AMJtDhGNQtCs8MVqWHXPYcsZ3ddWErIXJRH6LmBgYhNZTRwelA81MXTavynf
         PV6HkT/3vhEYV7sxN0IGOz6iv8VlXR/aqU2ILjGcwBb67fdZ4dXyEtCoL0RONwMVdnzv
         PuMOknSZGhRoxBi/w6X4LfmNZZfWBf+R6fhK6ZCuDDtg1YoafKtYzqk/yhDjJhBWUXkl
         iS6TTLT4DJxOwUCZaoB9tqqBZZSBLmqKDFBCObasieNtigKIL98Nyru8Wd+RAGO+sk7W
         OjlK78LPiP4slUBPGOQLMUpGM6C8HnowdDS74vDHd/OxkhvrNPU2geA4JN2W0n6I4l8n
         ZE0g==
X-Forwarded-Encrypted: i=1; AJvYcCVXCZZnT+LZs6SVH5Np9UuqxVPmYTZ8rQei9Gwx846A3H26WZHTI6F1dvjqwjJdrne/4YrKR3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjSyR56y3+G7xXHadlIeOceG5VEbYZc1UVp7lAl80H3HynybRx
	hXfmTlZFan6hLzX4ZHEWfe36HQp6C/TeiRlBWzmYWP3KJKdR8fXK3Huplu2kbFD08YqT3r3t3BB
	4JAf+YP3eIz6gLxJ2GDSVZBmkKK8PTAFojFc0vfSkKar+5xUYFNkP4qoOfhg=
X-Gm-Gg: AZuq6aLCPh0INOc++VFnbEEuIoBR/mbg6EWRb912/BGsE/vruzRNtt+4eL1/cqn7V1f
	Jbc4sdIQEAhW6gpgp2tfH3p15+KniA4rAyBwlZ8ZAQzEmrjRkdJ+T7HnJ4qWVfFTIvokWr/H5yP
	5RXx8znVcR/x0B5pVmcgyZUg8pEaDExj09GvqYuSY8SqH1st0my7g/6332i1mw7TrllW1Pjm0/y
	PCUMt+C6K/0xvc4XKRx6ymNathOC3h1MVgcTGlIArMryZCBNE2KLkNdKDoDp9xMI5QwHXaSRmoi
	+roVFbHHU/nVYHN7LH1sh4lHeWZnFuEbZp70EtDLBej7AGXCQU6ukESWz2K12LmsgMsnmVQa+s6
	odrQnLkYNfcT6qDg1fyOPQewlzlOo7PyNxlk5A0Jc8g2yVItxyUk0UW9f
X-Received: by 2002:a05:7022:4188:b0:11a:37a7:3d2f with SMTP id a92af1059eb24-1244b36d5a6mr15735724c88.37.1769072034884;
        Thu, 22 Jan 2026 00:53:54 -0800 (PST)
X-Received: by 2002:a05:7022:4188:b0:11a:37a7:3d2f with SMTP id a92af1059eb24-1244b36d5a6mr15735708c88.37.1769072034216;
        Thu, 22 Jan 2026 00:53:54 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b70d4324f5sm7179524eec.8.2026.01.22.00.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 00:53:53 -0800 (PST)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 00:53:48 -0800
Subject: [PATCH] bus: mhi: host: pci_generic: Switch to async power up to
 avoid boot delays
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-mhi_async_probe-v1-1-b5cb2a3629d0@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJvlcWkC/3WNwQrCMBBEf6Xs2ZRsxFY99T+klKSuZsE2NavBU
 vrvxt69DLyBebOAUGQSOBcLREosHMYMuCug93a8k+JrZjDaVBpxrwbPnZV57LspBkfK1k4fq9p
 VZAjyaop0489mvLSZPcsrxHk7SPhr/7sSKlQ1kdEHxJM12ASR8vm2jz4MQ5kD2nVdv14InUC1A
 AAA
X-Change-ID: 20260113-mhi_async_probe-a7b0867b6e2e
To: Manivannan Sadhasivam <mani@kernel.org>,
        Qiang Yu <quic_qianyu@quicinc.com>
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769072033; l=2282;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=fEYCB1OmXJHFLfozOgMIdwRQktFqsVtb3nHoMKfmXLU=;
 b=ENKcEED5vkiC3LwXWL73TKl+JtTGvCONhel7LnBjoD4Nq6W7Vi+QqT6nhLJPI3HdNwB16gX7R
 9RNxoMqtNTJAAJ91L37yZj3ONjydrqxY5n4HDuwjp6CuXsdILwrSSPI
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-ORIG-GUID: fAxRxF-6eOlzbCqDDgqsPe2728bl-yLS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA1OSBTYWx0ZWRfX4HJutcrr7vaO
 gvh7QkGyezryYTgxRY4HeNpqiJy6Sz4S2x4ujiyRAD57QnZv0XeNW69rS7jEv6SH46ZQXGaCk8m
 mMbeoXGxBZcd1Ey5U0NRJKJQVa6kNP3VUBWYonwJv36Si8vP8pg3RDacFJ/+B22/zQQQq+9OdFG
 HTWMOfhbnpo83lmFMuGJGHK2uqDSGTw/pIayDRGUGeQfqcGD68t+Oqu0Ig6X/XyVHl8BMlyEHI8
 zBIgJ8Ot/2CisKsABMD9gHXt03IVqUt/KkJxH+eAhDili54BKMGU+vXXqIVFqpP3hd4gS8aYXM1
 uzEUEem0zKVzl398xrQrkE4+7A6jqLcqRc8BpAfKR+8YvUi4WkK5+Vrcq7EGT0bSAiQkjx8ybZV
 u0xHNgBgHG9vG39u5KC65QIrwDgxtJ8kKk9xmifGcQ7Br+mOqUSYvhk5F+EpNjsoeFgOM51YLyV
 RPeKhX1v3jN76mm3auw==
X-Authority-Analysis: v=2.4 cv=G+0R0tk5 c=1 sm=1 tr=0 ts=6971e5a3 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yFp2A1wA7JFfkWW7:21 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=dy2jf5g7Jfd3xFo1z28A:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: fAxRxF-6eOlzbCqDDgqsPe2728bl-yLS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601220059
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211213-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qiang.yu@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: F2060642DE
X-Rspamd-Action: no action

Some modem devices can take significant time (up to 20 secs for sdx75) to
enter mission mode during initialization. Currently, mhi_sync_power_up()
waits for this entire process to complete, blocking other driver probes
and delaying system boot.

Switch to mhi_async_power_up() so probe can return immediately while MHI
initialization continues in the background. This eliminates lengthy boot
delays and allows other drivers to probe in parallel, improving overall
system boot performance.

Add pm_runtime_forbid() in remove path to prevent device suspend during
driver reinstallation. This issue is specific to async power up: with
sync power up, pm_runtime_put_noidle() is called after mission mode is
reached because mhi_sync_power_up() waits for mission mode event. With
async power up, pm_runtime_put_noidle() is called immediately while power
up process continues in background, which can cause the device to
suspend and mhi init fail if pm_runtime_allow() from a previous probe
is still active.

Fixes: 5571519009d0 ("bus: mhi: host: pci_generic: Add SDX75 based modem support")
Cc: stable@vger.kernel.org
Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
 drivers/bus/mhi/host/pci_generic.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 0884a384b77fc3f56fa62a12351933132ffc9293..fc0952e46ae5e4854c7165ed60b850729843d458 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -1393,7 +1393,7 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_unregister;
 	}
 
-	err = mhi_sync_power_up(mhi_cntrl);
+	err = mhi_async_power_up(mhi_cntrl);
 	if (err) {
 		dev_err(&pdev->dev, "failed to power up MHI controller\n");
 		goto err_unprepare;
@@ -1447,6 +1447,7 @@ static void mhi_pci_remove(struct pci_dev *pdev)
 		mhi_soc_reset(mhi_cntrl);
 
 	mhi_unregister_controller(mhi_cntrl);
+	pm_runtime_forbid(&pdev->dev);
 }
 
 static void mhi_pci_shutdown(struct pci_dev *pdev)

---
base-commit: 91a0b0dce350766675961892ba4431363c4e29f7
change-id: 20260113-mhi_async_probe-a7b0867b6e2e

Best regards,
-- 
Qiang Yu <qiang.yu@oss.qualcomm.com>


