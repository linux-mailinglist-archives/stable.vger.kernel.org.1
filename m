Return-Path: <stable+bounces-114441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19623A2DDEA
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 14:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CA116553F
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 13:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F291DF26A;
	Sun,  9 Feb 2025 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="lC6sddJN"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438241DEFFC
	for <stable@vger.kernel.org>; Sun,  9 Feb 2025 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739106005; cv=none; b=hn1Sls4oNXMyKO3YCgteWZsHFHT+yry0PQIQhN2Y6BrxKuj5WTaZWMwb2MvAAtj6n753Ob5CC0ceSRMYFNo0ZjnPVdDxhzVFxd9pfs1WZtaknAhrPZ6/8p28RKAfS7S21/doDRyKxBZbP462fpLLnmUdmiQCTSPK9XbABA45nq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739106005; c=relaxed/simple;
	bh=Q5zYpA6MMblmxx1N4pC32MnpIHX9rVeXAYy1yHACddw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ukz2gOJ/orwplGlk44QrOSWZl47SNUCw2mM32ZrRysmTbI6sJ+gz0S8MHKevNHJpVYtQwI7CJkjqGMAP7vIQa1Q/shuVaFvtwRpKWDQ8TYUY+wBBV9lgbQtJyohOqWGKGeDa0ItSmYqgqIi9kNxyywNwx4Z/6j17C8OcuKSMK0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=lC6sddJN; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=0MsUKzM4+9jzZuP5RCheexLjc9MTlK8C67KDQoaDPGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=lC6sddJNsLWLLTHMCxRknU4DNmJG/IZl1+12CuY+Tg3kHeiAPIoHT/B/ouluuY8hP
	 Ist5PUGxxCSKCzZMpjCOtAANDRb2CcCvuni1nc3co9qETEMoKen6jZVoTuKAqY1SBq
	 XOh7xG/KCeLV7AJTR8x4W8Ggz0jJ4g3zuXaePfIgEwGUD1QsQqkEP14DGdgVJnRo+u
	 9c68eappdqC5TZex+qiR6zLynp+2HMkGHcoDhFJsQcsHdMY2NYLNuXNFBafS+zpcoV
	 H6yhglZzci1btrUeaL9UADlRWi5ufaImhfOLsblX2brWobTH8KJQ9vLlDTuixUpofJ
	 8f9It7D3ZVmVg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id E4A1AD00283;
	Sun,  9 Feb 2025 12:59:57 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 09 Feb 2025 20:58:57 +0800
Subject: [PATCH v2 4/9] of/irq: Fix device node refcount leakage in API
 of_irq_parse_raw()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250209-of_irq_fix-v2-4-93e3a2659aa7@quicinc.com>
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
X-Proofpoint-GUID: DRDRBEPa6Ogb6JQzQwWYpA9GOMLbYtEF
X-Proofpoint-ORIG-GUID: DRDRBEPa6Ogb6JQzQwWYpA9GOMLbYtEF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-09_05,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=967 phishscore=0 mlxscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502090115
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

if the node @out_irq->np got by of_irq_parse_raw() is a combo node which
consists of both controller and nexus, namely, of_irq_parse_raw() returns
due to condition (@ipar == @newpar), then the node's refcount was increased
twice, hence causes refcount leakage.

Fix by putting @out_irq->np refcount before returning due to the condition.
Also add comments about refcount of node @out_irq->np got by the API.

Fixes: 041284181226 ("of/irq: Allow matching of an interrupt-map local to an interrupt controller")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/irq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index d88719c316a3931502c34a65b2db8921f7528d99..c41b2533d86d8eceabe8f2e43842af33f22febff 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -165,6 +165,8 @@ const __be32 *of_irq_parse_imap_parent(const __be32 *imap, int len, struct of_ph
  * the specifier for each map, and then returns the translated map.
  *
  * Return: 0 on success and a negative number on error
+ *
+ * Note: refcount of node @out_irq->np is increased by 1 on success.
  */
 int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 {
@@ -310,6 +312,12 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 		addrsize = (imap - match_array) - intsize;
 
 		if (ipar == newpar) {
+			/*
+			 * Has got @ipar's refcount, but the refcount was
+			 * got again by of_irq_parse_imap_parent() via its
+			 * alias @newpair.
+			 */
+			of_node_put(ipar);
 			pr_debug("%pOF interrupt-map entry to self\n", ipar);
 			return 0;
 		}

-- 
2.34.1


