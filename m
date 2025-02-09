Return-Path: <stable+bounces-114445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6575FA2DDF8
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 14:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1783A02A7
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 13:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504011DDC3F;
	Sun,  9 Feb 2025 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="ni2PId0k"
X-Original-To: stable@vger.kernel.org
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E831DDA0E
	for <stable@vger.kernel.org>; Sun,  9 Feb 2025 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739106056; cv=none; b=Srgraj7RKj7MjaOKXQ7XEhqIeZlh4Qjbaj5TlEt6kG9X2TKEC/NBTuZt7xJoacn+tbMBt1GY1D6iYgJXJPE1sNyo3bkBq//dySexSoackrcdnXo0ZVS7Wl2oMt96PUu5CiNlm6PSEtTaUJcC4HQLh2MLyq9+L5OVUqWBOn7alVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739106056; c=relaxed/simple;
	bh=Xyffhkw9qVjtiT+ifySYWkBDJuug+7f9ej1i8+nxm94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u0FGkoyAFmUDWF0ycfy/puXzq8deKydiajEYBK4N1SsZt7BPwnQDYEsLFNiyAji3VhtT2K2mlGhDUlUyIErA6BkS4wNIANTsjcEEKGNsM70C9UAiSYcK9cWFghv7HfQG2nK4+iqM26xWjEqB+YjnK4fvi/6Ohqdxcz7Vyc45IKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=ni2PId0k; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=ofZsMAmyfjKnHJmM1L8pFW96kyh2iTU8Cuekoza3vnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=ni2PId0kD2I+JGoKi+GflL6oUUGbcUK4hRZo1utpqhbELS5X4D9/+3/h4yiQPKfUB
	 9QoAB675ZX7cfzbbVYhDp0Uus51WOBX6zb9JUG4dod/xvP2MI9dNuDNlvD6quRSifY
	 +HKuSvOp56N4ndRJ35InLV/DHxJ5HgjGIc3o+CAcr7LIUHkKjxorKEYgESWWpD/KLl
	 0y7O7RsEAH6Jro1mGM6JM0wsSnA8yPUY9jX0fZUG10E8I4dgNQrRYlm9Z4FGRmc4lC
	 Q5/N3sNS7leXC9W9e371mYTjfViGF3K2epKJV93IfsnFskWAFjl3RaK3baj0DjatdU
	 Cvsc06thtFing==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id 12580D002C3;
	Sun,  9 Feb 2025 13:00:29 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Sun, 09 Feb 2025 20:59:02 +0800
Subject: [PATCH v2 9/9] of: resolver: Fix device node refcount leakage in
 of_resolve_phandles()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250209-of_irq_fix-v2-9-93e3a2659aa7@quicinc.com>
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
X-Proofpoint-GUID: 44BrMHfmuQSbv_XCfJBl-CKTW9nR2hTC
X-Proofpoint-ORIG-GUID: 44BrMHfmuQSbv_XCfJBl-CKTW9nR2hTC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-09_05,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=809 phishscore=0 mlxscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2502090116
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

In of_resolve_phandles(), refcount of device node @local_fixups will be
increased if the for_each_child_of_node() exits early, but nowhere to
decrease the refcount, so cause refcount leakage for the node.

Fix by adding of_node_put(@local_fixups) before return.

Fixes: da56d04c806a ("of/resolver: Switch to new local fixups format.")
Cc: stable@vger.kernel.org
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/of/resolver.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/resolver.c b/drivers/of/resolver.c
index 779db058c42f5b8198ee3417dfaab80c81b43e4c..b589e59667fd3ea2c2bd5240414803cb17707ec9 100644
--- a/drivers/of/resolver.c
+++ b/drivers/of/resolver.c
@@ -256,6 +256,7 @@ int of_resolve_phandles(struct device_node *overlay)
 	phandle phandle, phandle_delta;
 	int err;
 
+	local_fixups = NULL;
 	tree_symbols = NULL;
 
 	if (!overlay) {
@@ -332,6 +333,7 @@ int of_resolve_phandles(struct device_node *overlay)
 	if (err)
 		pr_err("overlay phandle fixup failed: %d\n", err);
 	of_node_put(tree_symbols);
+	of_node_put(local_fixups);
 
 	return err;
 }

-- 
2.34.1


