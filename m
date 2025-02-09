Return-Path: <stable+bounces-114444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B56A2DDF3
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 14:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11806165552
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 13:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA89D1DF977;
	Sun,  9 Feb 2025 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="lHGzDr5U"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391F81DE8B7
	for <stable@vger.kernel.org>; Sun,  9 Feb 2025 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739106024; cv=none; b=WQRYzEgAQXQ0CabutcSPVT0xfuD0mnlr9uHge5n1ikXwlqgLym2QbjWQw+r+s0o7D9v8u6LoKxInc7VNLe9cwhAXBtwhpggMwvofRA8nxmRLoCL87hkCAha7YgIh7An1O9NiBTFlKcCLo20NUl8VajqO34XjbdW2MsYQMWwZxJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739106024; c=relaxed/simple;
	bh=C3QWRS/oyMBoQil6zUy6RcS/RNrduorE/fP1oykD4WY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NBCYzWXiVonQbVVBETaPyxb2yYW0FsEojUfIBRKkR23V9ZBxL2nF9b7iiaHcpsfCAwcqDMiNtSfPqaevvE9H8XaHfvtb5NmCELclUtTe8eluKNipXJXHrfz7K40HXX1UNz4Ij6D0pyfKOJ91cI32U66Jg+iO4VjAfJk/poEK38g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=lHGzDr5U; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=HXqjFxnuLWVmTW2aVge3NLkwdNyGpwzPpwgyO1GtToQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=lHGzDr5U94q+lOZD9JbG75DS8TMvvgK3SIGdsOoWCrvPd/pTgy01jsOQgSHDOMRWr
	 TVvAD1yB/ZDEsAaxwAow0ojrJvsZhgNQ/SLJgUM4xEJBjfcCP9IlsAOFMMltqyXzLt
	 Yu/wyj5wXYjocRNs0G3Q0kuk/ZEKPVLuEkb5kxU51fI5XLmjxKnJlhEyepRhRrXLDw
	 8Uku+oltlSwWo45O1VEa/776JzIeTr9F15kzCKLEe+C/z3t/V+3WaVRBV5nJah3yxl
	 f3KVdR5IB1gtOu1xIwcabfw+sz3BDmBFECvWG6pXsl69DuwIs8FN85F46gZzj00O+e
	 FqroA+EKaayiA==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id 29BBFD001C8;
	Sun,  9 Feb 2025 13:00:16 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 09 Feb 2025 20:59:00 +0800
Subject: [PATCH v2 7/9] of/irq: Fix device node refcount leakages in
 of_irq_init()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250209-of_irq_fix-v2-7-93e3a2659aa7@quicinc.com>
References: <20250209-of_irq_fix-v2-0-93e3a2659aa7@quicinc.com>
In-Reply-To: <20250209-of_irq_fix-v2-0-93e3a2659aa7@quicinc.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>, 
 Stefan Wiehler <stefan.wiehler@nokia.com>, Tony Lindgren <tony@atomide.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, 
 Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Zijun Hu <zijun_hu@icloud.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: LCp5ur5Xe8UoFB2O6wp0y7kzuK7eBYmF
X-Proofpoint-ORIG-GUID: LCp5ur5Xe8UoFB2O6wp0y7kzuK7eBYmF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-09_05,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502090115
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

of_irq_init() will leak interrupt controller device node refcounts
in two places as explained below:

1) Leak refcounts of both @desc->dev and @desc->interrupt_parent when
   suffers @desc->irq_init_cb() failure.
2) Leak refcount of @desc->interrupt_parent when cleans up list
   @intc_desc_list in the end.

Refcounts of both @desc->dev and @desc->interrupt_parent were got in
the first loop, but of_irq_init() does not put them before kfree(@desc)
in places mentioned above, so causes refcount leakages.

Fix by putting refcounts involved before kfree(@desc).

Fixes: 8363ccb917c6 ("of/irq: add missing of_node_put")
Fixes: c71a54b08201 ("of/irq: introduce of_irq_init")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/irq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 064db004eea5129efb7d267abf7c1133c9a76e26..ded2a18776671bb30b3c75367e0857494a5c8570 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -642,6 +642,8 @@ void __init of_irq_init(const struct of_device_id *matches)
 				       __func__, desc->dev, desc->dev,
 				       desc->interrupt_parent);
 				of_node_clear_flag(desc->dev, OF_POPULATED);
+				of_node_put(desc->interrupt_parent);
+				of_node_put(desc->dev);
 				kfree(desc);
 				continue;
 			}
@@ -672,6 +674,7 @@ void __init of_irq_init(const struct of_device_id *matches)
 err:
 	list_for_each_entry_safe(desc, temp_desc, &intc_desc_list, list) {
 		list_del(&desc->list);
+		of_node_put(desc->interrupt_parent);
 		of_node_put(desc->dev);
 		kfree(desc);
 	}

-- 
2.34.1


