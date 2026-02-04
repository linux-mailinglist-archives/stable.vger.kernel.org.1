Return-Path: <stable+bounces-213351-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II4NA0bcgmnwdQMAu9opvQ
	(envelope-from <stable+bounces-213351-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 06:42:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAB5E20CC
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 06:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F4A0303AB6C
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 05:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C13834D4CA;
	Wed,  4 Feb 2026 05:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OyJAt/id";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rt3njatt"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEA1335BAF
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 05:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770183734; cv=none; b=MM/LPwctjs7jyGmLvJVpKZau+q0s9dOwikTJb6oMTZaW1yQFsQn2cvWeTU1tVZ+GN8E2OldTUYWNbKT6EyOXebpFLyJUOziQifH9vU76E2wyrYkQTZ0OoQdClunQb5m9CyjKFswEcz8/xl9xRBZuiC9m7XQeUiTkxy81g6GNSrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770183734; c=relaxed/simple;
	bh=oIUaF/QJNL9/z+fgmZ6beiw/h0T+YfEu54qjHDcbuCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OMTZCXGZEvmiHC3cFjZHkVhhOGKy/yeXjcdC5NRwbnsTaBaTA9mUp2QWOVhMbcn4+AUdSwCGAMmVL3aQYvywVZt8VVnt7LvFEMoqvV989cmD9wB25hVBv/oYxKmrdVYwO9WTbtPFahiszj/1LBuun6gxVevHM9NjlzqXPyAl0hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OyJAt/id; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rt3njatt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6144xMtn2829236
	for <stable@vger.kernel.org>; Wed, 4 Feb 2026 05:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Vjdjz/Dh5zHN725zkxEBwsn1d6NO6EMDk0s
	q/lRFUCQ=; b=OyJAt/idZpvw6x7BOFF0w+Ac0Y9QzuDNO1vU0XzsX67JkFjgZz0
	c90ftGdaPs9ofdv2e41U77jJ2nBFNH5RXDOeYsbGoSOJstcdiTWjoSMWt5lse/AX
	FCic1YxYJvReJ6zq01/0IqdtJm6xj3R9HsUAXNDl1TlM3F2zB0cQvkf58Sk1Kh1W
	jmf5xV5SEt+OeLyf1NZLQhFiGuexOs4TnyquW8OIq+meCaaLMyC/40XfPtF4tfz7
	eQyn4rWpXDQVFdfb4tHRKAgsCTisFrk4mOREX6poH2coPK2aE43Ci/UVSy+DflVF
	w37vupsRzh+yNwJxOjtURjoiwHRX0FFSLwA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3ndvj0w3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 04 Feb 2026 05:42:13 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-352c7924ebcso6714603a91.3
        for <stable@vger.kernel.org>; Tue, 03 Feb 2026 21:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770183732; x=1770788532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vjdjz/Dh5zHN725zkxEBwsn1d6NO6EMDk0sq/lRFUCQ=;
        b=Rt3njatt7IOfbOlDxXG4XrtGwG9qhjXCOycjiL4VoP+NoS167IXpOeFu0DOSD6KR19
         rVBLSns9K5rSl+HPbsLz80Q+0ze+0ZvWD+3cy+fwurrP9v+GiveVAZ1AUK17f8AdkioX
         HrZUtkQLlNTz/50eNAmIvN8nO9WPVI8tlP3OMaT6cxVhKxABkluLIWTyABnBNdAvyS2W
         fdPiWXHA9F5IP+M01kqnJYOGP/nIydO75pxzD2vlWO3ukeJZ3zi+imvMKOz5cmu64tot
         ezj2YRJptON/iFKtNySYe0ZVzgMobqVPaFe+BLDukLmqVvwLATjtYtosBYjLJfHl8x8K
         8TFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770183732; x=1770788532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vjdjz/Dh5zHN725zkxEBwsn1d6NO6EMDk0sq/lRFUCQ=;
        b=wDX3b4f52MUbSAsMDBZpVo23FVlb9mzKpkdiq/z4zqrsIRkNDibvF+egoqpQd1QwPT
         xseU6s4/Xw7khVfd8lnOAiAcRwqaK23K/kYyYVK6Y4poi6ZIRBJdaIpx0Pvf2FWkXAA4
         Y0t5BZV0sC5XBdMFbLl2OPEIySzOFcmuMVljz8iGoTpxpLLE2Pj68y6GDvdrSxnYhQZJ
         je4rpbhCegZLXE+E8hZwRFzd+Z7TvBDYbPacj3JkptNGC8plUWSJjqPInMnumvB22Jdo
         oWofWZaaqnnd85Tmujh46rFLJ1tcGxCgE0cUYdkJqe9ovEUaXsymPb5dLHMK3iyxnf0w
         eOBA==
X-Forwarded-Encrypted: i=1; AJvYcCXo8esAhpwo+4CkFjxaOveT5Hw+WnQbKAM7e4ERdGeHy7T6feFQZbyQXkzLRjCKjEWGDjsvUSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZSd0uiG2y23s67ggHaA8uAkyHDy53J88cFnEePPnVcI4ek8EA
	30fKKwar84poRTv5mfiojX0WIqzFlGKFGz+9MvpkxGRtehSNugztSlOXTdg/ydN85+YFx3uV/1e
	5pKZqc72GaR8dyRM/WsN10/vt6arm+SPBW7yMiwXvLa1KfDk1Grrsudo9wQY=
X-Gm-Gg: AZuq6aLUA4FyiaJR5EhOEry8jrm5hc94YjRff3WvL+gmmPDYvOC49q+/kKWKdiHlrk+
	YMn4zl4yDLYteklTS6TcoLg28u+Yw1WBMEFsISWNSVqxUduyuLZznZsMwNoRz3LFfaGpPycKubf
	kZgGqAcWylBoELahc0tNBSm3BeOaHozXq1c4VB9BpWILNgRyf0+LwYXuwM6NwSYJntjoU/L3p+P
	gGh3FjLSDImaVVYNkeatjNXEuG7Xnm5URzy3TZi7+/IxeYVbeyLha2QOdWK9c/HRgI/u0OlpTYy
	tI6VVm29d7cmgQy40QCe+qoKFkVckM864feuwipCtxfaMZ5SCsJyUK719+mqqt5nScYWhwvdDe9
	d4nolk0UxA5bqq7WSNAlQp4Hx3ErSLu5lVXXZbw==
X-Received: by 2002:a17:90b:558e:b0:34c:75d1:6f90 with SMTP id 98e67ed59e1d1-354871ae618mr1838013a91.17.1770183731624;
        Tue, 03 Feb 2026 21:42:11 -0800 (PST)
X-Received: by 2002:a17:90b:558e:b0:34c:75d1:6f90 with SMTP id 98e67ed59e1d1-354871ae618mr1837996a91.17.1770183731188;
        Tue, 03 Feb 2026 21:42:11 -0800 (PST)
Received: from hu-prashk-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354860fe962sm1208411a91.8.2026.02.03.21.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 21:42:10 -0800 (PST)
From: Prashanth K <prashanth.k@oss.qualcomm.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prashanth K <prashanth.k@oss.qualcomm.com>, stable@vger.kernel.org,
        Samuel Wu <wusamuel@google.com>
Subject: [PATCH v3] usb: dwc3: gadget: Move vbus draw to workqueue context
Date: Wed,  4 Feb 2026 11:11:55 +0530
Message-Id: <20260204054155.3063825-1-prashanth.k@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDAzOSBTYWx0ZWRfX0kA7Z1wuGXkO
 waww3q2yRfHlgKXwLYJeAmnLrHaBDWT6waO6kIlJQGjHE1VnqqzNmKNXw2pi08ZpMM63K5g1GBl
 CbX3Puk6Orgu3rCXjHup9j96WoW7GD7M2fBktcArExAoPU4Qb85uJpl3OyjQezRp9bIrOrHwOcs
 ydZB0W/CAP1qBzxo8m5Hzb9l651AAPvGihmvJWZVa63ly2DcgoAxV9MxMg22/o+VMMQEMQFd127
 px6w3KAOcg9j93P5tK9XExqfShTza00iaXvQPYykIEz4h3nDtxAoUUkproL5yJB52inK+HeS2lY
 7Nu5c/idSoHYcsOycsbGhys3l/ljHr1KzPV3Y70Fy0B1Ok+umaqHlfjv4RMJvNBXJBt77tGU0/s
 YEF0oWG3U/2LSv2tO2wuZuODwIPH2Ns4lGnlFB2yKkFfeaWXT3DUPexS+Yrh3/VYg9L20OoRjf5
 ivHHIksCijKYvYhsdzg==
X-Proofpoint-ORIG-GUID: oBFUDzIRaErk8I8MfjVy8vSlDfSBM45Z
X-Proofpoint-GUID: oBFUDzIRaErk8I8MfjVy8vSlDfSBM45Z
X-Authority-Analysis: v=2.4 cv=b+W/I9Gx c=1 sm=1 tr=0 ts=6982dc35 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1XWaLZrsAAAA:8 a=jIQo8A4GAAAA:8
 a=H-GNW7O56VsSoHbONaQA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_07,2026-02-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602040039
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213351-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prashanth.k@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6AAB5E20CC
X-Rspamd-Action: no action

Currently dwc3_gadget_vbus_draw() can be called from atomic
context, which in turn invokes power-supply-core APIs. And
some these PMIC APIs have operations that may sleep, leading
to kernel panic.

Fix this by moving the vbus_draw into a workqueue context.

Fixes: 99288de36020 ("usb: dwc3: add an alternate path in vbus_draw callback")
Cc: stable@vger.kernel.org
Tested-by: Samuel Wu <wusamuel@google.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
---
Changes in v3:
- Updated the documentation, and changed the fixed tag
- Link to v2: https://lore.kernel.org/all/20260203050430.2211487-1-prashanth.k@oss.qualcomm.com/

Changes in v2:
- Renamed vbus_draw_to_current limit, and rearranged the new variables.
- Link to v1: https://lore.kernel.org/all/20260129111403.3081730-1-prashanth.k@oss.qualcomm.com/

 drivers/usb/dwc3/core.c   | 19 ++++++++++++++++++-
 drivers/usb/dwc3/core.h   |  4 ++++
 drivers/usb/dwc3/gadget.c |  8 +++-----
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index f32b67bf73a4..cb5e829aaae8 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -2155,6 +2155,20 @@ static int dwc3_get_num_ports(struct dwc3 *dwc)
 	return 0;
 }
 
+static void dwc3_vbus_draw_work(struct work_struct *work)
+{
+	struct dwc3 *dwc = container_of(work, struct dwc3, vbus_draw_work);
+	union power_supply_propval val = {0};
+	int ret;
+
+	val.intval = 1000 * (dwc->current_limit);
+	ret = power_supply_set_property(dwc->usb_psy, POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, &val);
+
+	if (ret < 0)
+		dev_dbg(dwc->dev, "Error (%d) setting vbus draw (%d mA)\n",
+			ret, dwc->current_limit);
+}
+
 static struct power_supply *dwc3_get_usb_power_supply(struct dwc3 *dwc)
 {
 	struct power_supply *usb_psy;
@@ -2169,6 +2183,7 @@ static struct power_supply *dwc3_get_usb_power_supply(struct dwc3 *dwc)
 	if (!usb_psy)
 		return ERR_PTR(-EPROBE_DEFER);
 
+	INIT_WORK(&dwc->vbus_draw_work, dwc3_vbus_draw_work);
 	return usb_psy;
 }
 
@@ -2395,8 +2410,10 @@ void dwc3_core_remove(struct dwc3 *dwc)
 
 	dwc3_free_event_buffers(dwc);
 
-	if (dwc->usb_psy)
+	if (dwc->usb_psy) {
+		cancel_work_sync(&dwc->vbus_draw_work);
 		power_supply_put(dwc->usb_psy);
+	}
 }
 EXPORT_SYMBOL_GPL(dwc3_core_remove);
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 08cc6f2b5c23..a35b3db1f9f3 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1058,6 +1058,8 @@ struct dwc3_glue_ops {
  * @role_switch_default_mode: default operation mode of controller while
  *			usb role is USB_ROLE_NONE.
  * @usb_psy: pointer to power supply interface.
+ * @vbus_draw_work: Work to set the vbus drawing limit
+ * @current_limit: How much current to draw from vbus, in milliAmperes.
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to array of USB2 PHYs
@@ -1244,6 +1246,8 @@ struct dwc3 {
 	enum usb_dr_mode	role_switch_default_mode;
 
 	struct power_supply	*usb_psy;
+	struct work_struct	vbus_draw_work;
+	unsigned int		current_limit;
 
 	u32			fladj;
 	u32			ref_clk_per;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 9355c952c140..8562cc358694 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3124,8 +3124,6 @@ static void dwc3_gadget_set_ssp_rate(struct usb_gadget *g,
 static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
-	union power_supply_propval	val = {0};
-	int				ret;
 
 	if (dwc->usb2_phy)
 		return usb_phy_set_power(dwc->usb2_phy, mA);
@@ -3133,10 +3131,10 @@ static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
 	if (!dwc->usb_psy)
 		return -EOPNOTSUPP;
 
-	val.intval = 1000 * mA;
-	ret = power_supply_set_property(dwc->usb_psy, POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, &val);
+	dwc->current_limit = mA;
+	schedule_work(&dwc->vbus_draw_work);
 
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.34.1


