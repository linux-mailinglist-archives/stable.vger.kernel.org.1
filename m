Return-Path: <stable+bounces-195231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E50C72A49
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 08:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6380D4E7BBE
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 07:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13D93081CE;
	Thu, 20 Nov 2025 07:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DuQ3m5I9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Weq89nje"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075E9307AF7
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 07:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763624684; cv=none; b=FyO8xAyvaVBZO1JV5ARRUhc+rdxzOdgolYHgxb6GP5dBoxNFkiyRx/ZgS8x6dA2KFWgvgE9haJoBCGi+F+m2T/8SJcbwThWLQ8aDjWUJmYSlsxfeqMLUrQ/6+QMknUOJTErbboKcnvj35oEno6apkwOODHTc6vaDV1iORnwCE+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763624684; c=relaxed/simple;
	bh=ha1erIMdzZdv5qvcs4mgGl9s5O9EkMelYJ+RUiGUGwk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tRskUYWIaKaghRUR1m9MNFP+1D4zdJM8mwqzXWZWpPRrNFSvSWWs85Z+XZFXiB5RgcoKB00wdU24Qchq4gW8CVU61s3ycWMkCaMfrSOntVWyxU5EkXRUDBVQE9XR2LqxyA71stICOB1bwCLlb2UgpRknLplR1Zafdcc+/k/ODd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DuQ3m5I9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Weq89nje; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AK4pYnv047757
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 07:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=R8oPQ2tIzfsyrcfU58tcXlwJCxNHgkaZsEO
	zWR4XC+k=; b=DuQ3m5I93fCJryCzzlJ29LN7IJWhLGTn6eOvjut8mlCHd8E3iQJ
	Voc6bPA5vTmoUhCKWJbs07POyEjhX1Yn1FrEpU5i+GntQwFctdF4GFLYNuA1M+Ja
	eQysV5gqpH+/YE8tB8WnyK93DFKctf2Q84bUHluQjRHWDba4fGwiRvu5B4A0nHCz
	QU2n1x4j6mEelEBLV6xkWaJAncG0LMDn8x6RVnkbm+oxfDfraOYb0DWLCNNh6AQ2
	L0nfsZ4FGnU2igudxt8hKCUPYDpgnmXA7uYTXU4K/AGmLhwOOzgG1vo0hN5y604u
	yjza5ju7x1rpXmEAe0M15CJ7VPqRs/uadpg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ahcqnk96r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 07:44:41 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34176460924so487887a91.3
        for <stable@vger.kernel.org>; Wed, 19 Nov 2025 23:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763624681; x=1764229481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R8oPQ2tIzfsyrcfU58tcXlwJCxNHgkaZsEOzWR4XC+k=;
        b=Weq89njes46T6WjrZgUN/f8KfO+7si0yX92uarU3Kdxwf2NCuTplUB1cOv7Hw0vqiS
         CblTfWrnMX1ULChmjb3tctmOdt0a/tgO/AGK/Q2hq/0oQB3uMYCVg30mRdde9dbLD9z+
         vGcu59eu4YZB3urPapBVKgq06ZgtVtAkLRUQUbYz2u1cv0adf5FIWURGsH4XSxKBHHsL
         tqKhtLYy9ywVnS+r484RxgyB+4OpP2E7/L4e2knqz32V6HTVktN97tKgQkLD7Jz6vqNA
         smKTEzWk7OMX7o3pPmwWlUmaRv7Yhknt2CCvwDYr6DYKQsR26eBDguK+CMs29CZqsv7n
         W/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763624681; x=1764229481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8oPQ2tIzfsyrcfU58tcXlwJCxNHgkaZsEOzWR4XC+k=;
        b=U8uNFuz5+0bT4lfWJkjQRuqs8hjG7SKHySQISbSDbwd+Ivm9GPF0d7SG/m5OGVrDFh
         PZJxZZI+Im+E2I59kVJfjpPAoq5Cu6tEkSJmIS3HN74cMkBOoGDGmM9m0G21ljQBbap3
         9Msil/VoD/lB7Rm2NPixDNKKsMnqOyKlNIfHoLwhtf41OM1C12pDYpQKcvYVUwBcxC1M
         fjmNVPGWQmmecSBpLJu0rc2BblzDlobzISkt5gAmOk6mYOHlysyvbqGplJq+O8xqSr/Q
         RWHYsw3gs5kOciZsj+eJH9bXLTp612We+VEe5ZzYymO6HUPztQNVD8/UIQ3V+f20RNx3
         tcfA==
X-Forwarded-Encrypted: i=1; AJvYcCW4f5mfO5pcKxgsZ69e7cCz1F08ZVszjZhSESFRNkX6zaSZKMLWJQeG6K0L0YLm4K2febdkY1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj+8lfdX6BaIrDnUcYAynGEchc/stvCz2qc3mum2FW4gjmJaT0
	tL88QCF7k7z5M/wabvvHRreDDfqtbXV1SW8w9ZWdaYKj0BGbei8hbcYkEyWNirzvwDGDN8UK0MG
	iR3KxytqlgCkVJbQ65May7AnhL0pQkOlxK9zvrTyKkcUigCpJLIg1+GBTju8=
X-Gm-Gg: ASbGncuad6+AMUYRp99+dPaB+5nyuuo0V1tP01arRPSEe3WhD2ui4nhe9FxQsEkY/If
	VcgkXxZPmS0N5Z9K+xjNEPgVf3SGrZL+Q9LVv8VQH0KiY4CdgwIFSay9yAS9uowEIV46b5XdgUJ
	X0qD32+3UhoTCbdgOPXVfequRmjJsAN+Uxifu0pnDUg907TU1fJZKLTIqcqh6Fdjg/LVp09aIU+
	cOyLiRDu2XK62CdrZtwCSx3pXDpcv6n5Tvd5LDnCuA8MdAKw7YqyZv+SZK28hJYj9kMrN9q5a/+
	PhTMtvOlOmE/il66Ks4clxfcYcaBM/ZISxUT605xdqu2jso2sscKY8eNqZWDMJJpbEdZ+rj8g0g
	BumpthZtd7xbAamMGWmgVaPOOe/9S1LKjovxtzt0pRDj2escrxZlhxh8Le+XsRz5mVEJ2kcM=
X-Received: by 2002:a17:90b:4a47:b0:340:d578:f2a2 with SMTP id 98e67ed59e1d1-34727bca163mr2514967a91.6.1763624680761;
        Wed, 19 Nov 2025 23:44:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElExYVG2exYQ0DILRMUl6ASzBzwHJ3cf6tAOs+E2g7W3itb6uI8bJAZEOi8X3h87htoUbTFA==
X-Received: by 2002:a17:90b:4a47:b0:340:d578:f2a2 with SMTP id 98e67ed59e1d1-34727bca163mr2514949a91.6.1763624680240;
        Wed, 19 Nov 2025 23:44:40 -0800 (PST)
Received: from hu-mnagar-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34727c4b663sm1475067a91.9.2025.11.19.23.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 23:44:39 -0800 (PST)
From: Manish Nagar <manish.nagar@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v3] usb: dwc3: Fix race condition between concurrent dwc3_remove_requests() call paths
Date: Thu, 20 Nov 2025 13:14:35 +0530
Message-Id: <20251120074435.1983091-1-manish.nagar@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDA0NCBTYWx0ZWRfX+xDv7qnbMpZI
 HtxqsrYytr6yJl0wueFEW6AKNcaDa6WGqXhO/8XZkSO2rS5zL2NRWhk2AzQbFtblgrOJthfpFiq
 muy7TLu/4hL+WcMeTYrLsgMbTWgflYIhEO0s8p1Z1rI7PpPrbD/JoORxUIQRoh4nZGfcigK9k6T
 SyOp3Rox6uj/SACOnaMVJpv4dMFOaHB1ZzrIcgemfXpb5oKPvTDG0vENPmaWGYzqSL4vrR56F+A
 d5xdVA07fP/1yP4VrtxmDAoLvOUrEnU7UON6IXVvqhDIs8ztH82LMm0IByT9y2KQP2G/lGRDivD
 QSPEDKb62sYbSxRf+Ofb6ZfNmnFHlAsDr5F/N35L6MPsEoJq7xFFlExtsoimrlgZEllgU1NUeZQ
 CtMNitfTGZa43MzegePXNersgZb/Ug==
X-Authority-Analysis: v=2.4 cv=ApfjHe9P c=1 sm=1 tr=0 ts=691ec6e9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jIQo8A4GAAAA:8 a=ohm9b1kf839YKAti0RMA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: nXMacmx5ZTT3lMKF3Xy8LiH4X57E72Kk
X-Proofpoint-ORIG-GUID: nXMacmx5ZTT3lMKF3Xy8LiH4X57E72Kk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511200044

This patch addresses a race condition caused by unsynchronized
execution of multiple call paths invoking `dwc3_remove_requests()`,
leading to premature freeing of USB requests and subsequent crashes.

Three distinct execution paths interact with `dwc3_remove_requests()`:
Path 1:
Triggered via `dwc3_gadget_reset_interrupt()` during USB reset
handling. The call stack includes:
- `dwc3_ep0_reset_state()`
- `dwc3_ep0_stall_and_restart()`
- `dwc3_ep0_out_start()`
- `dwc3_remove_requests()`
- `dwc3_gadget_del_and_unmap_request()`

Path 2:
Also initiated from `dwc3_gadget_reset_interrupt()`, but through
`dwc3_stop_active_transfers()`. The call stack includes:
- `dwc3_stop_active_transfers()`
- `dwc3_remove_requests()`
- `dwc3_gadget_del_and_unmap_request()`

Path 3:
Occurs independently during `adb root` execution, which triggers
USB function unbind and bind operations. The sequence includes:
- `gserial_disconnect()`
- `usb_ep_disable()`
- `dwc3_gadget_ep_disable()`
- `dwc3_remove_requests()` with `-ESHUTDOWN` status

Path 3 operates asynchronously and lacks synchronization with Paths
1 and 2. When Path 3 completes, it disables endpoints and frees 'out'
requests. If Paths 1 or 2 are still processing these requests,
accessing freed memory leads to a crash due to use-after-free conditions.

To fix this added check for request completion and skip processing
if already completed and added the request status for ep0 while queue.

Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
Cc: stable@vger.kernel.org
Suggested-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Manish Nagar <manish.nagar@oss.qualcomm.com>
---
Changes in v3:
- Add the fixes tag , cc stable and acked-by tag.

Changes in v2: 
- Add a check for request completion, in v1 I am avoiding this
  by wait for completion for ep0 then process the other eps.

Link to v2:
Link: https://lore.kernel.org/all/20251119171926.1622603-1-manish.nagar@oss.qualcomm.com/

Link to v1:
Link: https://lore.kernel.org/all/20251028080553.618304-1-manish.nagar@oss.qualcomm.com/

 drivers/usb/dwc3/ep0.c    | 1 +
 drivers/usb/dwc3/gadget.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index b4229aa13f37..e0bad5708664 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -94,6 +94,7 @@ static int __dwc3_gadget_ep0_queue(struct dwc3_ep *dep,
 	req->request.actual	= 0;
 	req->request.status	= -EINPROGRESS;
 	req->epnum		= dep->number;
+	req->status		= DWC3_REQUEST_STATUS_QUEUED;
 
 	list_add_tail(&req->list, &dep->pending_list);
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 6f18b4840a25..5e4997f974dd 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -228,6 +228,13 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 {
 	struct dwc3			*dwc = dep->dwc;
 
+	/*
+	 * The request might have been processed and completed while the
+	 * spinlock was released. Skip processing if already completed.
+	 */
+	if (req->status == DWC3_REQUEST_STATUS_COMPLETED)
+		return;
+
 	dwc3_gadget_del_and_unmap_request(dep, req, status);
 	req->status = DWC3_REQUEST_STATUS_COMPLETED;
 
-- 
2.25.1


