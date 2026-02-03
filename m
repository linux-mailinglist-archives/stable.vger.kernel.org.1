Return-Path: <stable+bounces-213176-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNeXMwCugWn0IQMAu9opvQ
	(envelope-from <stable+bounces-213176-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 09:12:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34328D60DF
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 09:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 486E4305AC95
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 08:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C761E392C46;
	Tue,  3 Feb 2026 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cJdzSjKQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SqnBjJXk"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C63718C33
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 08:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770106046; cv=none; b=Io016TnYQGNZlYFneSiSBlZAOze4tRpT6NL5Zm3yM44dOHo+IEbk5yqS3Ds1fJLcGl9Fjs9RnGIuaJPc0pD74KedpB4+BuvWsn+4XF98S2xOYmdbt4HK5MPJieMdMNEpN2UUj94ku4y4cERK3wEgq7gScG0h+QWnMHgUcMfgmRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770106046; c=relaxed/simple;
	bh=Qq04aMyR2RaVOIZIp8efbqCAIMKGNTY8acMbrQE2EXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kkvh+YDV4bRLGhNjQdWPZIxwMGtD1w8MAiX5Cn3Kpng2HfAVjoAkSVnGZnIUCN5qsVgJ+tSl1QdcPP09MXThC2X8vIGFEbfsR22Eb2ZNcva/2mMzjWDP1IHYtQCLgSCfHHTNg/lUp5lqq+x7rBporobXDQ4EAO0VDpige+3o11g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cJdzSjKQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SqnBjJXk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6137WHQZ255010
	for <stable@vger.kernel.org>; Tue, 3 Feb 2026 08:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=aj8+pAYTZe6c5Ex+saB41vaGVimbskW7CCO
	dDiVYdno=; b=cJdzSjKQbg/hlj20+hQ9vWMNDsyCeU2PnKUtX3bzEzILLXRjyRT
	8k4bvQ5upj/IXvBIeMo6u+QHIq+D3nJIwyyWjcB4lsSeHlKatLL6Q6frtMUTqJgU
	/a56LD70rVBYuk5HvVXtuhmTWixgdGWzhMl6hcvNPt0rZlqfQA5jEvHxRJNvRy9j
	53vNx5pIgZCX8cTbCYsz4zQxtHPUS//t2P69jab6eJ8KB5XIivGYeKPddAcBDS4B
	9G3jb7Fk6ZOy5ApRiusBkyMQLgVO2d9y2xqfTYqlAKvKs9vTnOgvSAJmVplhyDbN
	UlljN+baqzk85ixRlr20pm+E+UzLjJhHHVA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2v0kk8xq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Feb 2026 08:07:24 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34cc88eca7eso5501395a91.2
        for <stable@vger.kernel.org>; Tue, 03 Feb 2026 00:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770106043; x=1770710843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aj8+pAYTZe6c5Ex+saB41vaGVimbskW7CCOdDiVYdno=;
        b=SqnBjJXkd8ACeYGevAyNdMpi+iAoehlOcx+DpIXnyjXE57THGKNU6h0UNpfYov13gX
         YstIxmbIooDy763rsoF1NtqERtK+hDRunQoJfKgc/wE776StfWbh69/VadweliGmiCVl
         7DRsAZinkRB5+AzIt9/ni2CR1fVdKZykRsa8r89BHtO36bGtdVEDHWTM/h9VMXJIKALY
         3od/1l6LyTD4dO00EVbflQSeZ8cY0Jl0SPqkM46rG09eZZckl/JdxRTn4cADr/2/cFbr
         Lyx1c1oJzYNYjACKokvdJaJmwxWhV6UimUkHJoXhxym8BQA5WFtNuwET7QBH0kEj+al1
         QaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770106043; x=1770710843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aj8+pAYTZe6c5Ex+saB41vaGVimbskW7CCOdDiVYdno=;
        b=AG+n2jBhzZ/laZdaY2c7186kNXSS0wBe/uf32V3iZGmrqoj0FZzQzx2TnpiuIkHz1U
         FdHRTVwczQMf0l86BcbL5DO6qFqdgkROfdrGdO4l8w77ZInW+dB4hIoR65n7vFkVghJ3
         JmxGyQypFQQhWZ4EcGwurloJYcVvaCLyf7chHaqYFaNEZANDvpdT8FRMlGTTctnGJM5e
         gU2EHxrlpKmKDV1a8bBu8WLR3D0+Qe+xT28Kng/REy1tqycKpGo5sg6/u/7eKu5tmLE8
         3xw57ZLNHnp6+PtthM3aOGg+HJTAZ4F22SnLwHVOzMHbtWVa7fdcKYAgVgRjz4CwYejc
         V3pg==
X-Forwarded-Encrypted: i=1; AJvYcCUPyCNoCZysvzjULrbJZ6vYmz0F4VxL9Ge/MCnAwgKh+QjllOypbAiuWI4/0/gQdWCgyK97O5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQmgG3FWbSk+uT92hHsv6gYOQDDaZ4eGuETns/pPzzPvQsLG2R
	VnjvXpXwuXQcbM0RNISm9CT1FCdxPj3ya6yr918i4opMHChaeWu/8yDj0DW4vT13bQcRPO7SkjL
	E3hSTw/FJrsHGxCcgywH99nOEeCJxJzfs9Ya2J4b9SJaHLLN8wixHop5S3kk=
X-Gm-Gg: AZuq6aItoQQg0RIPVzP9yOxJWD7dykuPCbXizkrzSe4JYvAUoMwQoI2qfhk0YEN5tT0
	HCpymFEV5Yj+C89/FR6d7XSmlCfCIvEcyDphruk1OWItFP0XYFEKnK+eqsjNp29s+vLusL7z2av
	NB4H/n8vgFLUa3isBHpH9NL/6rai7d4FOCr3Bne9lJmxoNpJo3dSJkRhUOFYUBLTvGQRMEhPFQy
	5+CdLFFwvsPgsnXbU4Ng6FWsVUrzsBtU0O8E8LOWIfRuL4Kut6XHIO8fLx0YAJ8V+0ng6SZmK4T
	eUy+sO+pttF4T6jleMbMXvMjuZm294a0yZQl+CeeY5cMkg4ZpAEq/ZQTtAzFXe3/Lp0t63zESJK
	BRmIgfG7m9RYGqUvDUVai2/SP
X-Received: by 2002:a17:90a:e710:b0:353:5c16:aa7 with SMTP id 98e67ed59e1d1-3543b4007c8mr13225247a91.25.1770106043138;
        Tue, 03 Feb 2026 00:07:23 -0800 (PST)
X-Received: by 2002:a17:90a:e710:b0:353:5c16:aa7 with SMTP id 98e67ed59e1d1-3543b4007c8mr13225210a91.25.1770106042541;
        Tue, 03 Feb 2026 00:07:22 -0800 (PST)
Received: from work ([120.60.74.100])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c22672sm17865275b3a.51.2026.02.03.00.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 00:07:22 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        stable@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
Subject: [PATCH] soc: qcom: ice: Remove platform_driver support and expose as a pure library
Date: Tue,  3 Feb 2026 13:37:12 +0530
Message-ID: <20260203080712.15480-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Reqdyltv c=1 sm=1 tr=0 ts=6981acbc cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=A3/yxVAzUcVmDczBgoabkA==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8UEKqKzBqzOYgcocWCkA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA2NCBTYWx0ZWRfX8Lp3jGx++pGW
 KmsMUc88/oc2rSvWXCxwhDu/buME9rXlqSa6unSV6o3/cquI4Xi8DwnWoibaz0uXl6DAtrtMjED
 YhNXTeTqbyQAc2zlFBU9vE8aR/4trXkLD/9Pm34JW1hifF4JoyXvc5XnnXd0VyldlFjQ2Ad8Wdg
 VK8cGIorJceHDbZditB3qtL/UL808NsKPJw3wuO82FTD+osqeK37oosxg7LiKcQx48jMA5SvlJc
 GGOpuDVIPbhWtTI3lRtq7KKKazsUp2zS/OrkwgQcbXYBaTooAVGT6ZN75c22RPsSMc0yFYvlnn8
 IS4137nxVD9B9EwcX6HZIl+MUsBVkElzlRXBsW3K15s1epknwpjpH4omd8DbMhA1gRmZoTWik/j
 I3hD24cel3bw/t9Zd2KHpgoSUQ5RmdPx9DTqOiiB0WsxuXUO5aEE3GlvRBLi+3z0iFvs6pw69W4
 zx+6dgDoXOOn44eWVyA==
X-Proofpoint-GUID: EihT8NhH_29cx8ARb9vonF4IWgpzxLK_
X-Proofpoint-ORIG-GUID: EihT8NhH_29cx8ARb9vonF4IWgpzxLK_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_02,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602030064
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213176-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 34328D60DF
X-Rspamd-Action: no action

The current platform driver design causes probe ordering races with clients
(UFS, eMMC) due to ICE's dependency on SCM firmware calls. If ICE probe
fails (missing ICE SCM or DT registers), devm_of_qcom_ice_get() loops with
-EPROBE_DEFER, leaving clients non-functional even when ICE should be
gracefully disabled. devm_of_qcom_ice_get() cannot know if the ICE driver
probe has failed due to above reasons or it is waiting for the SCM driver.

Moreover, there is no devlink dependency between ICE and client drivers
as 'qcom,ice' is not considered as a DT 'supplier'. So the client drivers
have no idea of when the ICE driver is going to probe.

To avoid all this hassle, remove the platform driver support altogether and
just expose the ICE driver as a pure library to client drivers. With this
design, when devm_of_qcom_ice_get() is called, it will check if the ICE
instance is available or not. If not, it will create one based on the ICE
DT node, increase the refcount and return the handle. When the next client
calls the API again, the ICE instance would be available. So this function
will just increment the refcount and return the instance.

Finally, when the client devices get destroyed, refcount will be
decremented and finally the cleanup will happen once all clients are
destroyed.

For the clients using the old DT binding of providing the separate 'ice'
register range in their node, this change has no impact.

Cc: stable@vger.kernel.org
Cc: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reported-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Fixes: 2afbf43a4aec ("soc: qcom: Make the Qualcomm UFS/SDCC ICE a dedicated driver")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/soc/qcom/ice.c | 100 ++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 61 deletions(-)

diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index b203bc685cad..b5a9cf8de6e4 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -107,12 +107,16 @@ struct qcom_ice {
 	struct device *dev;
 	void __iomem *base;
 
+	struct kref refcount;
 	struct clk *core_clk;
 	bool use_hwkm;
 	bool hwkm_init_complete;
 	u8 hwkm_version;
 };
 
+static DEFINE_MUTEX(ice_mutex);
+struct qcom_ice *ice_handle;
+
 static bool qcom_ice_check_supported(struct qcom_ice *ice)
 {
 	u32 regval = qcom_ice_readl(ice, QCOM_ICE_REG_VERSION);
@@ -599,8 +603,8 @@ static struct qcom_ice *qcom_ice_create(struct device *dev,
  * This function will provide an ICE instance either by creating one for the
  * consumer device if its DT node provides the 'ice' reg range and the 'ice'
  * clock (for legacy DT style). On the other hand, if consumer provides a
- * phandle via 'qcom,ice' property to an ICE DT, the ICE instance will already
- * be created and so this function will return that instead.
+ * phandle via 'qcom,ice' property to an ICE DT node, then the ICE instance will
+ * be created if not already done and will be returned.
  *
  * Return: ICE pointer on success, NULL if there is no ICE data provided by the
  * consumer or ERR_PTR() on error.
@@ -611,11 +615,12 @@ static struct qcom_ice *of_qcom_ice_get(struct device *dev)
 	struct qcom_ice *ice;
 	struct resource *res;
 	void __iomem *base;
-	struct device_link *link;
 
 	if (!dev || !dev->of_node)
 		return ERR_PTR(-ENODEV);
 
+	guard(mutex)(&ice_mutex);
+
 	/*
 	 * In order to support legacy style devicetree bindings, we need
 	 * to create the ICE instance using the consumer device and the reg
@@ -631,6 +636,16 @@ static struct qcom_ice *of_qcom_ice_get(struct device *dev)
 		return qcom_ice_create(&pdev->dev, base);
 	}
 
+	/*
+	 * If the ICE node has been initialized already, just increase the
+	 * refcount and return the handle.
+	 */
+	if (ice_handle) {
+		kref_get(&ice_handle->refcount);
+
+		return ice_handle;
+	}
+
 	/*
 	 * If the consumer node does not provider an 'ice' reg range
 	 * (legacy DT binding), then it must at least provide a phandle
@@ -643,41 +658,43 @@ static struct qcom_ice *of_qcom_ice_get(struct device *dev)
 
 	pdev = of_find_device_by_node(node);
 	if (!pdev) {
-		dev_err(dev, "Cannot find device node %s\n", node->name);
+		dev_err(dev, "Cannot find ICE platform device\n");
+		platform_device_put(pdev);
 		return ERR_PTR(-EPROBE_DEFER);
 	}
 
-	ice = platform_get_drvdata(pdev);
-	if (!ice) {
-		dev_err(dev, "Cannot get ice instance from %s\n",
-			dev_name(&pdev->dev));
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base)) {
+		dev_warn(&pdev->dev, "ICE registers not found\n");
 		platform_device_put(pdev);
-		return ERR_PTR(-EPROBE_DEFER);
+		return base;
 	}
 
-	link = device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_SUPPLIER);
-	if (!link) {
-		dev_err(&pdev->dev,
-			"Failed to create device link to consumer %s\n",
-			dev_name(dev));
+	ice = qcom_ice_create(&pdev->dev, base);
+	if (IS_ERR(ice)) {
 		platform_device_put(pdev);
-		ice = ERR_PTR(-EINVAL);
+		return ice_handle;
 	}
 
-	return ice;
+	ice_handle = ice;
+	kref_init(&ice_handle->refcount);
+
+	return ice_handle;
 }
 
-static void qcom_ice_put(const struct qcom_ice *ice)
+static void qcom_ice_put(struct kref *kref)
 {
-	struct platform_device *pdev = to_platform_device(ice->dev);
-
-	if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "ice"))
-		platform_device_put(pdev);
+	platform_device_put(to_platform_device(ice_handle->dev));
+	ice_handle = NULL;
 }
 
 static void devm_of_qcom_ice_put(struct device *dev, void *res)
 {
-	qcom_ice_put(*(struct qcom_ice **)res);
+	const struct qcom_ice *ice = *(struct qcom_ice **)res;
+	struct platform_device *pdev = to_platform_device(ice->dev);
+
+	if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "ice"))
+		kref_put(&ice_handle->refcount, qcom_ice_put);
 }
 
 /**
@@ -713,42 +730,3 @@ struct qcom_ice *devm_of_qcom_ice_get(struct device *dev)
 	return ice;
 }
 EXPORT_SYMBOL_GPL(devm_of_qcom_ice_get);
-
-static int qcom_ice_probe(struct platform_device *pdev)
-{
-	struct qcom_ice *engine;
-	void __iomem *base;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base)) {
-		dev_warn(&pdev->dev, "ICE registers not found\n");
-		return PTR_ERR(base);
-	}
-
-	engine = qcom_ice_create(&pdev->dev, base);
-	if (IS_ERR(engine))
-		return PTR_ERR(engine);
-
-	platform_set_drvdata(pdev, engine);
-
-	return 0;
-}
-
-static const struct of_device_id qcom_ice_of_match_table[] = {
-	{ .compatible = "qcom,inline-crypto-engine" },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, qcom_ice_of_match_table);
-
-static struct platform_driver qcom_ice_driver = {
-	.probe	= qcom_ice_probe,
-	.driver = {
-		.name = "qcom-ice",
-		.of_match_table = qcom_ice_of_match_table,
-	},
-};
-
-module_platform_driver(qcom_ice_driver);
-
-MODULE_DESCRIPTION("Qualcomm Inline Crypto Engine driver");
-MODULE_LICENSE("GPL");
-- 
2.51.0


