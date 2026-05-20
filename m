Return-Path: <stable+bounces-251410-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAgBNM/0DWoF5AUAu9opvQ
	(envelope-from <stable+bounces-251410-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:52:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ACA594C76
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4EBE2317D6A0
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433573ED3A4;
	Wed, 20 May 2026 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dfIY94/4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE193F0A83;
	Wed, 20 May 2026 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297908; cv=none; b=O7a19VSS14lQOpoVRWejBZ2C79yvYBPcmLw7FlYnZMYb6MSIKNTFROb7Vjf18YCT+qI2Dezmbp/2NRHln4+0z69tKVY8JikyIPK3+kQNCzLmPwuo604KhcsMz2bBxla2n/3CJtHhOAUyXMTevuorKhyLxP4v8oKmpsZaQE0pcLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297908; c=relaxed/simple;
	bh=j18ZJkPTGGXaEAL9Z+UzW9LZGFBmj6IbALy+L51Qqtw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emx8Vxu2WwYGDoqO3GAG3SF8c3KT44737W9LEcLlEscoWLvQr4nYgYVDdxdAvhuumuaG+iguTC/gUbGQFn+d1mU3QUegfaqPLPyW8p8jTCwV4XghNvQL7tlRbkgTPSD5JRbKUtO6Q4+vkBvIDHPCg0nFjr8MyV28X5i+g3kRD2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dfIY94/4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FEA91F000E9;
	Wed, 20 May 2026 17:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297906;
	bh=K8SLiBo9JjrK43PPlO7w/n0YZ7hW9lsBefK+r+nY+Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dfIY94/4t2iTkQ93Ll9z86yZ4ckMqaE8F6aospAfZIxDn2qHpikmtWFkkVftHx5fF
	 nlt5wN+iLsTCoZtp0NensCVThc/zRxIWl8dsPoEFZ8zuQVTvtvy0mMS7EyrAr/kowg
	 8SzwIl9I4ebLJKqZts41pPE/PEkN/ZksCpBPNWCE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Senchuan Zhang <zhangsenchuan@eswincomputing.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 208/957] PCI: dwc: Perform cleanup in the error path of dw_pcie_resume_noirq()
Date: Wed, 20 May 2026 18:11:31 +0200
Message-ID: <20260520162139.052013281@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251410-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 93ACA594C76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

[ Upstream commit edb5ca3262e2255cf938a5948709d3472d4871ad ]

If the dw_pcie_resume_noirq() API fails, it just returns the errno without
doing cleanup in the error path, leading to resource leak.

So perform cleanup in the error path.

Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
Reported-by: Senchuan Zhang <zhangsenchuan@eswincomputing.com>
Closes: https://lore.kernel.org/linux-pci/78296255.3869.19c8eb694d6.Coremail.zhangsenchuan@eswincomputing.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20260226133951.296743-1-mani@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3fbece96faaad..48e4a887bb1bb 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1230,15 +1230,24 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
 
 	ret = dw_pcie_start_link(pci);
 	if (ret)
-		return ret;
+		goto err_deinit;
 
 	ret = dw_pcie_wait_for_link(pci);
-	if (ret)
-		return ret;
+	if (ret == -ETIMEDOUT)
+		goto err_stop_link;
 
 	if (pci->pp.ops->post_init)
 		pci->pp.ops->post_init(&pci->pp);
 
+	return 0;
+
+err_stop_link:
+	dw_pcie_stop_link(pci);
+
+err_deinit:
+	if (pci->pp.ops->deinit)
+		pci->pp.ops->deinit(&pci->pp);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
-- 
2.53.0




