Return-Path: <stable+bounces-183504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF76BC0294
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 06:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0F4C4E506C
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 04:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA1C1DE3B7;
	Tue,  7 Oct 2025 04:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JapZI97k"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FD8189BB6
	for <stable@vger.kernel.org>; Tue,  7 Oct 2025 04:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759811995; cv=none; b=q44VDu3Y3qO2xmPO6W1npmqnD8I+ydJt3LsobqMOMKKBVtQHk8SK9uhdJ67C2Wi+GlQelKzI0j74GXQ6K4hsNoJqntP+1zNb1hxyncGV5gGkdc9odOo0D7sURBjwXK5jSWab3lil9HCzIQuIXSkkO7jhs/lmgw/d2mVgtYzP+VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759811995; c=relaxed/simple;
	bh=7qHYef2etzrNlWeCketnmC2vVMwHcAK32dLefjCngTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KsOFgC/UYJ4LgufQseLVgx9xTJqb/ntsxp21J7eVw33DpVWgjk0bF59y+m/yvmSaq1/+Twz6t/LlTsFwhkOxcV7/C9dLhU4Ws8ZNi0UuhPW9eaKD53HdNZ4/1LVep6qADdEbwEs1uctarOVBYlzJvmnC/HxabchX48J9pPkxmsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JapZI97k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5971JKJK001367
	for <stable@vger.kernel.org>; Tue, 7 Oct 2025 04:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=RuzLlW0qdfn
	BKhNfkc5iIDUVeGx/PVQy/W7p4Uoj//M=; b=JapZI97kjqq2hwC3/4ZK2TufHb9
	Gwah14bbyfpv0/+67v76khaBXMZM+XtiEPRB0YsO5MW4uKO/7cokM5JmNTNn1mQM
	/tzl/hyMFBIf1Bzl/MbZGoROeOVwEZifKrG7IHv40nNhvbvMsdZdnADq0Lsola9K
	sLx5iopCrowx69oOk0iXRHsgVVNU/byUXBUy66AQZ69tsWcKBQ/UOKxOt1SCCILG
	nBcDPfnBqQ2QaKHfLHdNUIS68/2WcyjRy4aiSZYTf55sRfnJRbYNjXLCl8CX35/B
	ooo2hrJC6OwFHzKZAFsvg1mtF2Daj2ETsR+UFz3Z3fW4dvcrGl1qUxNJOYA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jvv7nwn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 07 Oct 2025 04:39:52 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4dfe8dafd18so237577131cf.0
        for <stable@vger.kernel.org>; Mon, 06 Oct 2025 21:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759811991; x=1760416791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RuzLlW0qdfnBKhNfkc5iIDUVeGx/PVQy/W7p4Uoj//M=;
        b=wAflsaiqBoRMdMlBRenvwkyHxPWY2VlQCeoip+JvEjhHJpdpB6NscgN8JgqIkOaJmg
         4TLEvMgVEyVcOCOTiW+a2HWwW4TDQvKZUmUuiCL/FZTBGZ8u7HvtiMZ2QucXpGf3DWGC
         9KpdApA6BrTUBI5QQAlvuKTHX80oM6lRNvrT1NL7pErsI2IZW3NDrRi7sQ72uxfuRvJx
         f8Pv2hFid623Knklz3ViXQn6LX8E4HVpCI5wabga2eg52JSrQ+XrAwAqv5gROOzv5HBG
         oG67sxRqaNI2xkhbRetyfGsKJ4db62veMD4H1K0evGT+5ivALNEK26Ots295SI4U4Jns
         bGdg==
X-Gm-Message-State: AOJu0Yy0hUTdVwAfNT6v2f6EbxD0qzRMqo+X2QQtcibXQy94aFImf5dB
	6TInAbYIIBX/0/r8KdAUek1xglqY4HjkNxVaLt7uD4lPO8Ni2sNndh9FFelTMWbLxbOT2PVaxWc
	yRrYGKDR1MYW5J7ivyUC3lXj1tC5Ee67P896DWPUpD8TJxwMdx3xnEuH1ktVSbVD1cmXqrQ==
X-Gm-Gg: ASbGncscY/uWnCfGYDlzbXFmOil2eQ736L93Y1+S4xk62d3QyeWIsVTGMdqjl0wWztw
	6IY2cErg2UYgXV+UB8pAwS04xlpyy8U4tv/rcpm/RfVq5Gfh467T5kvG86gi5Pr1bsTF2UOHjKM
	oOgMroFjcl67mv63WRbdNvapeE5HP1HwSS+vYHvX0nceescm5wpq9CfTrBr3b+LtPm6JvfsgwV+
	WeTokMiFhHvGgC4NaOHdnwGzCzotYQ/sYSRtcwA/w6/nxW53L/BGies8TZHuWfGQrNj/66ZyALZ
	kPEZVnYcvrRZGsGjmNOOVHHK0jhYva7W4vkxZ09VFleMfvr+7XY30j5DroD9wNJYHEjXjwCMXeU
	LqkuxpSt+jA==
X-Received: by 2002:a05:622a:5c0b:b0:4df:4174:8239 with SMTP id d75a77b69052e-4e576a973c0mr207793251cf.29.1759811990957;
        Mon, 06 Oct 2025 21:39:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsDZe6qeY0otJG8q8ShA7N7NVaGL6/67qKU0ydOFapB+NUXzlCt+6e7rBhkd+6YrIWEvnA8A==
X-Received: by 2002:a05:622a:5c0b:b0:4df:4174:8239 with SMTP id d75a77b69052e-4e576a973c0mr207792891cf.29.1759811990297;
        Mon, 06 Oct 2025 21:39:50 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970a60dsm1279470366b.63.2025.10.06.21.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 21:39:49 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: stable@vger.kernel.org
Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Subject: [PATCH] bus: mhi: host: Detect events pointing to unexpected TREs
Date: Tue,  7 Oct 2025 06:39:49 +0200
Message-ID: <20251007043949.129133-1-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025082100-snowiness-profanity-df3a@gregkh>
References: <2025082100-snowiness-profanity-df3a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAzNyBTYWx0ZWRfX/86WDLjP0euu
 8Xc7uZzcCWu9vbvJ77i0zic+SM40npiCqMpUDPhbTGjLrVATAwySr7J1w2LEHJJh13zIZnMEei1
 4NQwVpRG9Bg9Cvg8KcdmAJvPpb+R8T+6n8qjbdooNZc+empFuo0XHhSlJO4+sNWJN6wYh1J5WBW
 4e2NjFSg/oKqKfB476GS9h8geaTH+vuX9DIujDm724ikw8nho+ZLALdG7ItKciHCeJNdng0G9Sv
 0ilf3QVnlG27jJyPY0rYAsQaLDmu7NOwqkiL17J2Gnj7bFJkx661NA9MH29FejZvP717EOGYSWr
 D1FJHmsI1ajGnaDzrAJhk3pkAHoG8MhsUctewxWb+3CHHoY3Rvlx1B2g0nZ8p1EM2StgVQplu8J
 LY1eyVcFs4JMe+FlrDWqlDhBP/O4Qw==
X-Proofpoint-ORIG-GUID: QjmW72F6qqT2qw1rsYjHzctZmCNlc34H
X-Authority-Analysis: v=2.4 cv=WIdyn3sR c=1 sm=1 tr=0 ts=68e49998 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=x6icFKpwvdMA:10 a=bC-a23v3AAAA:8 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=EKJTJD2SnuQ5WFkfcowA:9 a=dawVfQjAaf238kedN5IG:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22 a=poXaRoVlC6wW9_mwW8W4:22
 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-Proofpoint-GUID: QjmW72F6qqT2qw1rsYjHzctZmCNlc34H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040037

From: Youssef Samir <quic_yabdulra@quicinc.com>

When a remote device sends a completion event to the host, it contains a
pointer to the consumed TRE. The host uses this pointer to process all of
the TREs between it and the host's local copy of the ring's read pointer.
This works when processing completion for chained transactions, but can
lead to nasty results if the device sends an event for a single-element
transaction with a read pointer that is multiple elements ahead of the
host's read pointer.

For instance, if the host accesses an event ring while the device is
updating it, the pointer inside of the event might still point to an old
TRE. If the host uses the channel's xfer_cb() to directly free the buffer
pointed to by the TRE, the buffer will be double-freed.

This behavior was observed on an ep that used upstream EP stack without
'commit 6f18d174b73d ("bus: mhi: ep: Update read pointer only after buffer
is written")'. Where the device updated the events ring pointer before
updating the event contents, so it left a window where the host was able to
access the stale data the event pointed to, before the device had the
chance to update them. The usual pattern was that the host received an
event pointing to a TRE that is not immediately after the last processed
one, so it got treated as if it was a chained transaction, processing all
of the TREs in between the two read pointers.

This commit aims to harden the host by ensuring transactions where the
event points to a TRE that isn't local_rp + 1 are chained.

Fixes: 1d3173a3bae7 ("bus: mhi: core: Add support for processing events from client device")
Signed-off-by: Youssef Samir <quic_yabdulra@quicinc.com>
[mani: added stable tag and reworded commit message]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250714163039.3438985-1-quic_yabdulra@quicinc.com
(cherry picked from commit 5bd398e20f0833ae8a1267d4f343591a2dd20185)
[ Check for bit 0 in dword[1] instead of MHI_TRE_DATA_GET_CHAIN macro ]
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>

---
 drivers/bus/mhi/host/main.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index 49c0f5ad0b73..720936c4c9dc 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -529,7 +529,7 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 	{
 		dma_addr_t ptr = MHI_TRE_GET_EV_PTR(event);
 		struct mhi_tre *local_rp, *ev_tre;
-		void *dev_rp;
+		void *dev_rp, *next_rp;
 		struct mhi_buf_info *buf_info;
 		u16 xfer_len;
 
@@ -548,6 +548,20 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 		result.dir = mhi_chan->dir;
 
 		local_rp = tre_ring->rp;
+
+		next_rp = local_rp + 1;
+		if (next_rp >= tre_ring->base + tre_ring->len)
+			next_rp = tre_ring->base;
+		/*
+		 * Break if multiple TREs are received yet the chain flag
+		 * is not set on the first TRE
+		 */
+		if (dev_rp != next_rp && !(local_rp->dword[1] & BIT(0))) {
+			dev_err(&mhi_cntrl->mhi_dev->dev,
+				"Event element points to an unexpected TRE\n");
+			break;
+		}
+
 		while (local_rp != dev_rp) {
 			buf_info = buf_ring->rp;
 			/* If it's the last TRE, get length from the event */
-- 
2.43.0


