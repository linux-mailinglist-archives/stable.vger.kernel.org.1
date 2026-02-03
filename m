Return-Path: <stable+bounces-213168-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMo8E/qBgWlNGwMAu9opvQ
	(envelope-from <stable+bounces-213168-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 06:04:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4B6D488E
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 06:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFBEF3016802
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 05:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715AE231A41;
	Tue,  3 Feb 2026 05:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YprlHWMR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EAsfIFJf"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E654A35
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 05:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770095091; cv=none; b=V6wwCLE9Y9vXajsrmjikl/uWGq5cPYtSbqjzs8xtk+207iD64J5SvIZSfB+fk9F5WFu7N0Tm4MHj38VCPBHho9i9UNSkYFsejnt235H1UeLBwx1wEZ0dVr6d4TP+uqxIw+s4p6RfJW6IBdH6RoIRbhBXieGzTGw+37CCQp/fHp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770095091; c=relaxed/simple;
	bh=83ugOZc3NG5Y5JWJr4sNCIXpIKfA86Iy/3wrXzPzWCI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DospY3qS+60enKVcG/dazj+siY+qBCVlCvYsgYP3QfizZ97ND+SSRJEVwqsMJieQgBXrrtrYm/xKbqzkSDTY0QlqzIYHJUiwZKBDlTmz2Y2DfhPf0Mf7Fx+76WcSb9tWChfyPGEawJUxRiQiG/h5o3XV0boVi5LLePgQMsN6J8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YprlHWMR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EAsfIFJf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612J46c42899946
	for <stable@vger.kernel.org>; Tue, 3 Feb 2026 05:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1uXrS+fqCpvsKh34rTFsdql8DjvfOnGN234
	mAL9FJiQ=; b=YprlHWMRFoXqSf2R1YAzkV8LPjTBKSrStCcsXNK1WOtzrFAdWzw
	bsJNs2+W61FuekCmCeoIU+ZC/nY1xVZc51QkTXQ5yFziABFWCsF6pXrAI0Meu6Q0
	Q13LA2fJIB215ZuM9N0DusAAw/1ZQBQJKifZ65r5UPzPevGWpq0EMVbmHbhKAFYQ
	9bki2ZQGDdx8zGG3MkyzMwiN4WhLIqFECAi4SRFQYaolJ6NdiBfx6B6cRebSSeR1
	zUaXnL/9wjy0w4Jn7xBrt6TnegR81nkLt79+WfAkqq0dLwAP478xbXB0W1BOWu88
	yBZzYfklcxEKUTs4cpGmXVKkLy3rnWaWEEg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2tp0twk9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Feb 2026 05:04:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0a8c465c1so3594195ad.1
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 21:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770095087; x=1770699887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1uXrS+fqCpvsKh34rTFsdql8DjvfOnGN234mAL9FJiQ=;
        b=EAsfIFJfGuoUm6HvZ1oKuyAodDtmTK8hvzNve+Tf4xMDsfP/TO1MG+VoMAsK/z6pMo
         ZgHY5Sg8DNogpTRvBqfLTMCGAL5RQp5eTEyRjCfV1WDp1gqJjXzt71T9n3iMT2sZ4Y1S
         DBy5X7LxOQsoODDsZrUp8Zvq6XvO+D61JLMZg3NAb+9H8lSovBAkqm+B4wSVPYjUyMiJ
         wfdeIlkubB+nMkU9ltrDPcYZsxcbW/tE6OYXqoEiQmaI86b7lYemLe9E59by+aVQAYmS
         1JR7zzvuwlOrrgw0DD2BbAfKbEGe8y07jo30SN8CQCQWNtC0wT+rDE8b3MZsNp4GHiiD
         elOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770095087; x=1770699887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uXrS+fqCpvsKh34rTFsdql8DjvfOnGN234mAL9FJiQ=;
        b=lHjBy1jRNDoTfSQOIevxeTeCvKkoMFl/w/w+TXY5mXZMTMbc22Qdrz16Kwj4YkVfH4
         dSNJt3qPQASlADUKiQIY2xn+e3kt1xa/IGc2lRC5A1wYSWxMLfM3l0sRTvOrdI0vgfNs
         3if2d+gGBm/Y87JnX0u5ZmgNbclsCvovpLNXTtW8mS5OL3XYl2PTtPVX9bHSd3NVL+7K
         TVkVMnhaeZ0Pi2xXQbmjtq+QzMoZDA7QTdbOE7rSCADX63X57lksYBBx2fuOAx9WnCAd
         pwpURblYUK1tGqlbOEIEhKxn7ygEDDAPqiWpO+Gj8QR7os+sjwX8gI3V5343T8xtH8Sw
         cakQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX8XB5Si64IwF/mWDFeA136QNH6Ap2k1nR2fpn45/62R4aDLZKJaBLxAGs0KzksoEG9p3PXIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNjUDIw/5q0qPv1e8PjmjX4loGIyoctt0ReBfEn8V7jpmjL6Tp
	fj6BQtSVJ29WGVKhZ/aizR4cK6Fkq43+JMDiUfzFzfawWgBj8zix4WR1QLopy0m35i3hDkajuEx
	0aAsE+L2W9U+U7aGeOqyxIFVJ5oli7A81q+TZi7+87umXnXpRqbHvA+LTxWMLD7LHFow=
X-Gm-Gg: AZuq6aITcPsaInUth4cnAdKTrEhWGCOC+ZUscm55p1+RtAbrRaKJPX3E/Ov7CWkdc2F
	ceZl0i5k00MRvqswsOHRpKeD1urdwXPOVxtybBxXoUdrlUikzdgt7MUb2gl4KNBUn5OQ1tJ7NhV
	qBlE9K7QjUK4uvjvFBoz0KWRi+X7nl4CJCDRl72p/EbrP0bncoDpiuzo6dw9wVsMEylaBUNHyix
	39kMgCnRaeJqYUk/1q8tbpShyPK9mnvnYwM7tEm0+8Ppo6JuB6ixlnDbhhiEmpeHQwyW4o3oVTc
	lXbjMeTo2zlVJlpN1mWKGJUxLfVgxfsLa9EafJEGYqLRyqfIMEEg45G+by9MzFrMlBEGvdk2Nx3
	22vFnOeajD/VdlsYDhzv2Ww/yT8JX3APDlBrqEw==
X-Received: by 2002:a17:902:e851:b0:298:639b:a64f with SMTP id d9443c01a7336-2a924595003mr18937945ad.6.1770095087519;
        Mon, 02 Feb 2026 21:04:47 -0800 (PST)
X-Received: by 2002:a17:902:e851:b0:298:639b:a64f with SMTP id d9443c01a7336-2a924595003mr18937705ad.6.1770095087041;
        Mon, 02 Feb 2026 21:04:47 -0800 (PST)
Received: from hu-prashk-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b6e55efsm160911265ad.89.2026.02.02.21.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 21:04:46 -0800 (PST)
From: Prashanth K <prashanth.k@oss.qualcomm.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prashanth K <prashanth.k@oss.qualcomm.com>, stable@vger.kernel.org,
        Samuel Wu <wusamuel@google.com>
Subject: [PATCH v2] usb: dwc3: gadget: Move vbus draw to workqueue context
Date: Tue,  3 Feb 2026 10:34:30 +0530
Message-Id: <20260203050430.2211487-1-prashanth.k@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: m-thmiN1T-tmmNjfRFSCyiZwONjSN5wM
X-Authority-Analysis: v=2.4 cv=VJ/QXtPX c=1 sm=1 tr=0 ts=698181f0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1XWaLZrsAAAA:8 a=sCfbRl51OHjYAUcMWzoA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDAzOCBTYWx0ZWRfXzJKihE+PZGOM
 cAEP7zQhq1zmm1TxdlfRcck3MAmHFeArAF/SwGJbFVm1bXmNM2+QpXWBx3tVObtUXdqxy1ixAP2
 qyN3P1ohks7WugcuJq50NSNv/m3Ugxrx028di6xIISLaHUmegLG7Jax6G9xZ9C13r3H+Q8uN5DX
 H+vpIFe1ofqdOj4yH6xri42Bv5F6KpxnvfqqR9XmOzeCrKe9Mx3BMvaJ+vm7mRFNDqTKvKMBTOF
 YUKvbprmNGC1vQnoKyTzr0Pd6yACWlhQCvJD909cjAxyGxaS3LTkSBXOgdlVM90f5C7eaFlwB9i
 yQFO91hIQTTV9XA7+LUh7xDf8KJut+qvmiFlNV2YgnJcYa+YKAins9V7HFB6A1yPq5mgf3zJQPA
 eKVwbaueIxF7V5DsUqAL/lyoJmZTS6hTyOXB90PPl1wumgyD886mM0eo3gBLaA7ctolAoq/EOdu
 BLvt1TYybd0wlM5D2dQ==
X-Proofpoint-GUID: m-thmiN1T-tmmNjfRFSCyiZwONjSN5wM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_01,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602030038
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[prashanth.k@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213168-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9F4B6D488E
X-Rspamd-Action: no action

Currently dwc3_gadget_vbus_draw() can be called from atomic
context, which in turn invokes power-supply-core APIs. And
some these PMIC APIs have operations that may sleep, leading
to kernel panic.

Fix this by moving the vbus_draw into a workqueue context.

Fixes: 66e0ea341a2a ("usb: dwc3: core: Defer the probe until USB power supply ready")
Cc: stable@vger.kernel.org
Tested-by: Samuel Wu <wusamuel@google.com>
Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
---
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
index 08cc6f2b5c23..42cd1667a91b 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1058,6 +1058,8 @@ struct dwc3_glue_ops {
  * @role_switch_default_mode: default operation mode of controller while
  *			usb role is USB_ROLE_NONE.
  * @usb_psy: pointer to power supply interface.
+ * @vbus_draw_work: Work used for scheduling vbus_draw_work
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


