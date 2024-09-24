Return-Path: <stable+bounces-76973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A8C98422F
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 11:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141261F24089
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 09:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C47215624C;
	Tue, 24 Sep 2024 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aQIwsBlZ"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A05D81ACA;
	Tue, 24 Sep 2024 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727170370; cv=none; b=KJol7uFMA60yP31y9y2m5QtdJ5qYBhbfBxojj6gBwqJdPuO5e7WYgm882zocIaqnAaT8YxgFQrOhTKPw5SnJvqwmhARBWwzEu7weVb4gsB7VeJa2WAkqv+jX58GpKGC4N7plg3/AjOQ04jal+FuhAoq9JfgK2cC58c/ts0tk6nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727170370; c=relaxed/simple;
	bh=NknyyEcD4zYCQM+wBz/3gDpHoU3Gt3Dge+AMcxyEpU8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oj3mLxJ0vV7d3buyIUk9v7tcyF/JAX/nodysldZuM0vcSwZAMMI3ZG+Q6B0UH2dWRzLwcLy+3OkplZLdy9Q1u6KoznCKnc3JyTp/7nTjSOFwYBXF6RxH8XmBPwS5zZGzCvmU519buTtei59IqCWOq4woBmYTemrw22JbwhPe64I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aQIwsBlZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48O9SJnb020806;
	Tue, 24 Sep 2024 09:32:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ykUc0Rwfs9s25vwqcnQosU
	FSCt1Q8mz3cSAY5lkpR0w=; b=aQIwsBlZhhgyZtmuBP9gKdeSp8n4yDiX4+rzmB
	RMbiSb3nOe5v4x8DL3OxxJAoc/jsiXxx2nxp0mJWIeGMLYOQehI1NvUYru82KuLC
	f6iw11vqCX/zcp2T9LhbAZWy8DCtD9BIB4d3QK+36OSsV6Ev+VuAlNGjjDcNq9xo
	uymZMg5Dg2ZESmLmzcxc1Io8Nj8IdiCvxgct9snKcAZ85uqNovEp8TTu93H01fIK
	p9xp7ziZWDGJucvmiR+6i0YWdrZs8O3K1gP5pGR9D/Nbf2l5R+PAYVagIZeyHQPg
	nWyRiVIMMAfE35Wetwb5NIJDDDJw5sdb079w4JNebEfk/5hA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41snqyg1ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 09:32:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48O9WiXp031122
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Sep 2024 09:32:44 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 24 Sep 2024 02:32:42 -0700
From: Prashanth K <quic_prashk@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>
CC: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Prashanth K
	<quic_prashk@quicinc.com>, <stable@vger.kernel.org>
Subject: [PATCH] usb: dwc3: Wait for EndXfer completion before restoring GUSB2PHYCFG
Date: Tue, 24 Sep 2024 15:02:08 +0530
Message-ID: <20240924093208.2524531-1-quic_prashk@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ZuWAwHPSgWTVvIWQkzjrpNSUqk_JNE_8
X-Proofpoint-ORIG-GUID: ZuWAwHPSgWTVvIWQkzjrpNSUqk_JNE_8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0 mlxlogscore=621
 spamscore=0 lowpriorityscore=0 clxscore=1011 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409240066

DWC3 programming guide mentions that when operating in USB2.0 speeds,
if GUSB2PHYCFG[6] or GUSB2PHYCFG[8] is set, it must be cleared prior
to issuing commands and may be set again  after the command completes.
But currently while issuing EndXfer command without CmdIOC set, we
wait for 1ms after GUSB2PHYCFG is restored. This results in cases
where EndXfer command doesn't get completed and causes SMMU faults
since requests are unmapped afterwards. Hence restore GUSB2PHYCFG
after waiting for EndXfer command completion.

Cc: stable@vger.kernel.org
Fixes: 1d26ba0944d3 ("usb: dwc3: Wait unconditionally after issuing EndXfer command")
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 291bc549935b..50772d611582 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -438,6 +438,10 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 			dwc3_gadget_ep_get_transfer_index(dep);
 	}
 
+	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_ENDTRANSFER &&
+	    !(cmd & DWC3_DEPCMD_CMDIOC))
+		mdelay(1);
+
 	if (saved_config) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 		reg |= saved_config;
@@ -1715,12 +1719,10 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 
-	if (!interrupt) {
-		mdelay(1);
+	if (!interrupt)
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
-	} else if (!ret) {
+	else if (!ret)
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
-	}
 
 	dep->flags &= ~DWC3_EP_DELAY_STOP;
 	return ret;
-- 
2.25.1


