Return-Path: <stable+bounces-222598-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBbiKpOTpWnXEAYAu9opvQ
	(envelope-from <stable+bounces-222598-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 14:41:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E3E1D9FC0
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 14:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A73D43003BE9
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 13:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F911379EEC;
	Mon,  2 Mar 2026 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kh7RFisp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L3jGm0hG"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E06430B96
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 13:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458894; cv=none; b=Olo/1kk7qi4BPy0emp9Ge9RVJ+4pcOzyprzadXrH2dBcsV0LIxXh9bp2+UYgXxRYpoHyMasfFpAVPfe+9+TgREH4VOexr0Dx4ppzmxn7AgqQ/lmBcBYfblJdjjfd+wzznWCOCpfcSACrDdUzeCTGFbhkgHqvetVbnNIjCOk23GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458894; c=relaxed/simple;
	bh=BeJmXbNjoTu7+hHdqxvNZAqQtEzTchLcnDzAK50yUcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E6E4U8SDUkAk79+b3YHr+XZkFzB4lXoVDVPvGGLIR+E0DMoht1vogZ02YSKTEg4FJyF4efmcmVQ82dNyvtsvP+TJgHj7ibr2uAknTUorlf435J+EmnQJy1uPqlhb9cghTVyeC+cLQGGXDfxg5MFbFkz6HDjNlscE0Xr4oBCViqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kh7RFisp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L3jGm0hG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6229Er7J3630818
	for <stable@vger.kernel.org>; Mon, 2 Mar 2026 13:41:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=3FvuMRTJ9t5Oa3prM87UIj2ZcMgQFfKYy0B
	Eopqkflc=; b=kh7RFispu0Iu1Fv1+SHRLwEdXJTooXZHWkzTJNjOC2F04tuAY50
	fjXDRPg+RwH+WdHTXUqSmgu3FqvewLehBkK2uQGvShNK9dLNm3kLXUqjSa6Q5kz6
	H3NsH6jPLAAvW5ENVxOCzBopCvpmN4QfV0D9PFRo464Zaqo8PvwQDYVqiAIi/bn5
	0Z786QymS6rQXB2Xh4GofXseLiSKgv3841q3cHXu6bVuTnpKOU38TqmOkW0jz5sw
	hfDc2mm/eiu1EuWGVvLbMNDxD987SvGoin2DZJf3ER6oUq0c/amlS1o8o4zQr5ow
	jmqMF4sxqn8FIEgIv9oJRaN9yw4cjNAaRbw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7rhru61-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Mar 2026 13:41:31 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c70ea91bfe1so2880020a12.1
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 05:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772458891; x=1773063691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3FvuMRTJ9t5Oa3prM87UIj2ZcMgQFfKYy0BEopqkflc=;
        b=L3jGm0hGw4v1rpCWigNk1UWRQGcNm8WQW2ayVNZWZawCW3FJiG/aub1L2Zs3rywYN7
         zD+AnR7vJpgvgEI+2NU8XEIqMtGlYyDcE2Q6vopqCFFT0qehIsGulNV4DFUW9vsi2BqI
         Z7GDXDVjor9bWQ41Pd1jHsvHKGPjNYljVVsuNoiDRN61OHhdkEv+bSCh1zA8Bnp8wUwV
         Cv11+H8hR90X5Oo94gIRvGix4xFhpf5SeoF+4dDcVYO4UqIYJKcQej/6uQE50Zn8rndW
         RjDH8ypzHoQxPkbwntyN8tWZHkWRlAytRUIr6UQ1jtC3d0QvPRZtZDY6kMIBgO89NUNY
         vi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772458891; x=1773063691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FvuMRTJ9t5Oa3prM87UIj2ZcMgQFfKYy0BEopqkflc=;
        b=AAEEgIFzT/MZbOzl092l9ckdhFdE/blUskRZ8Eg73g9VqPSRm3+1RhYqeJFP3QYocW
         kz93ZguFCPqAG92OJzodD48tCA3tQUMNNb+Fqytk7mmFb/HQCh9d8dIpDcNxU9p6PKRR
         BTK6iV6soub0oYfgmCvCFfnQbf68Pau4r89zDNU9E7Ph4xY5m82Z9103ziz2hP1d2TJM
         RY8yPaOy09b8393IT+pP5ibWlFgfYBXM0bSJdXYbPvhbEu3ylgn/kWKc0Ap2tvr6VB/l
         of0U8Dz0k8sWRDAhF4WRKYfz8Jx4GsszpalE9pJgGyyCafAvmGz+QF+SeDd/4i3//TTA
         Ogfw==
X-Forwarded-Encrypted: i=1; AJvYcCW0HXnFjOfSQ5JczZp/XP2hKJX98jm82g2M82F4AIgekvYnOxXT0iVksjMTPg35ds2mPGUCe8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7UTtb/Kzfyb68jklAF1ul1Ij7eMuyLj5/BWowuiWe/9xgsicj
	F6QadGmXv5UhhD7em1v9hE//wFU/AOBjcpB1+DkN3L4UxDcFuFyEdmMGS28ErAppBW2XeUdBLKU
	otuCP7Mqkcl80/zcvbq9OhUltxtolpNsIlWFqhaGZ4XRZTSlR9+kwzFuxN2U=
X-Gm-Gg: ATEYQzyCTTJfnTwc4t0XLOB0LDWWbrzossNMdvtAO72zFqEqRtC1ZG9eWij5X43MDsm
	WEOy6bv51DMHqIop2XznArmu0TG4n7+ubepvW17dDyfRIHYatNLp778sRrvS8pA4S0rElyQWOV0
	4iE/sgq3eCD4DCj+gtXdRTnQnhBEUlYk/WRSlEwkIM3qWzkSiuExHGf0Q4A6lbk6h+KMKTZoLXM
	F1UR1aD3PUnJi+Pc279t1uyuWbowPgVqkHm1aBcU//PMdM6FWVzYN9WVV+ubZvF9w/zFZwwzpVD
	LylyA4Syr4gL5rww7YeJLEUvr6V5eIwPIsvtZgngyMorCwHOEt+pna4CYEjBhI/H1pNZ4hgE33G
	NPnH7pAj8ChTmwet4rqFbSSyFLx71FgkKz4j2Xa2b2w==
X-Received: by 2002:a05:6a21:4982:b0:395:d4e4:2bde with SMTP id adf61e73a8af0-395d4e432bdmr6390682637.30.1772458890613;
        Mon, 02 Mar 2026 05:41:30 -0800 (PST)
X-Received: by 2002:a05:6a21:4982:b0:395:d4e4:2bde with SMTP id adf61e73a8af0-395d4e432bdmr6390658637.30.1772458889986;
        Mon, 02 Mar 2026 05:41:29 -0800 (PST)
Received: from work ([2401:4900:88da:227d:c631:5c3c:695f:8a61])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa632ddesm12292498a12.13.2026.03.02.05.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:41:29 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: mani@kernel.org
Cc: qiang.yu@oss.qualcomm.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        stable@vger.kernel.org, Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH] bus: mhi: host: pci_generic: Resume the device before executing mhi_pci_remove()
Date: Mon,  2 Mar 2026 19:11:16 +0530
Message-ID: <20260302134116.18960-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OyYEVVDz5xwCMlFIoX2NAnm5DwxVcVO2
X-Proofpoint-GUID: OyYEVVDz5xwCMlFIoX2NAnm5DwxVcVO2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDExNCBTYWx0ZWRfX5R0tVlAX31Kp
 EJAVitTgJemo6W35+jgtRIJYJGhVuKqT5JJG3GuPiLLmWb6cBWX5El+DWmMXA0gQc/EJsFwiNvb
 +KUAFiNsZE/+6O/k6nNQTrvWRYiA/bQJGC7y7Vb9aq+ib7sHwy9ve2Y+ybb+aqI/gG2r1sboN03
 Wxpiy9674aCN8tHmTT1GD5uFMElxBzSnWaRnLHRrhyb/+6qY8GS2VhFxeuV7eDHab5UwKb/BbFY
 W8xiUCUtJr6RWQfXhB+Z89LBisCGVilKzrrvx44fvn9NQrbFesr2ClmvsGjr22Z+gxZ2A/ZfHnr
 Jk+ov5TgY8fD4tkUVKrKQ4y/iF4HD930PM4DXVIbB5DrUYhcioNsKTM4EiS7nxqPDUNTFdJoxc1
 YefqHLSTIiAOe6A5m8UkCDVzCO43vHvQx90gw1LWKf7L9kqFgvJVl6JznNyd89O3aE2if8O3eEB
 B6OBQXAv6pAzhwztT0w==
X-Authority-Analysis: v=2.4 cv=cLntc1eN c=1 sm=1 tr=0 ts=69a5938b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=8Mze1DJ7461ulW_4NyAA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020114
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222598-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A9E3E1D9FC0
X-Rspamd-Action: no action

mhi_pci_remove() carries out device specific operations that requires the
device to be active. But pm_runtime_get_noresume() called at the end of the
remove() will not guarantee that.

So use pm_runtime_get_sync() and call it at the start of remove().

Cc: <stable@vger.kernel.org> # 5.13
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>
Fixes: d3800c1dce24 ("bus: mhi: pci_generic: Add support for runtime PM")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/bus/mhi/host/pci_generic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 425362037830..fe3aefa15966 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -1440,6 +1440,10 @@ static void mhi_pci_remove(struct pci_dev *pdev)
 	struct mhi_pci_device *mhi_pdev = pci_get_drvdata(pdev);
 	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
 
+	/* balancing probe put_noidle */
+	if (pci_pme_capable(pdev, PCI_D3hot))
+		pm_runtime_get_sync(&pdev->dev);
+
 	pci_disable_sriov(pdev);
 
 	if (pdev->is_physfn)
@@ -1451,10 +1455,6 @@ static void mhi_pci_remove(struct pci_dev *pdev)
 		mhi_unprepare_after_power_down(mhi_cntrl);
 	}
 
-	/* balancing probe put_noidle */
-	if (pci_pme_capable(pdev, PCI_D3hot))
-		pm_runtime_get_noresume(&pdev->dev);
-
 	if (mhi_pdev->reset_on_remove)
 		mhi_soc_reset(mhi_cntrl);
 
-- 
2.51.0


