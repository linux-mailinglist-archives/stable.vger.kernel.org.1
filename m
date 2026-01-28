Return-Path: <stable+bounces-211984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LWQNMkqemmi3gEAu9opvQ
	(envelope-from <stable+bounces-211984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:27:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF88A3C1F
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B3AD3027B77
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A996336BCCC;
	Wed, 28 Jan 2026 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QPhAu/33"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617C7280CF6;
	Wed, 28 Jan 2026 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769613897; cv=none; b=E7aAcl3clkNinQWHfP7YDhqIoyH4iiyL/DsbK02lrN1Fy1eYUxg9MK+9dKogKsK6vYkJN0oOxej/PW+gybCB2EsbW+aP1s+txoNOaYjI9NimWavw8IaM0xESLPGUYmhlRcoBvoeVSq4fG0UO3uXHKAkhpAiDezBfMfKNAbKOoaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769613897; c=relaxed/simple;
	bh=TNKoJuf/9AgJxtfSDWa1k8dxmH0R8oWcXPIiK1WihHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pl4+uG0sVlY5hWjDTN2ktf6WgL/p63x0MYiyiwGsuKk/EiSLKZy2xI6o/nH2L2vZJBQXEHOVI/CoeT14VBiRnUWir2CeM+jXk3q/6OBIKHYIqml/611w6XlrR+blMg3wNr5DL6h+zhNHujiIMVcWbxNOWNzu37PkQJKkhgmF35M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QPhAu/33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FB3C116C6;
	Wed, 28 Jan 2026 15:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769613897;
	bh=TNKoJuf/9AgJxtfSDWa1k8dxmH0R8oWcXPIiK1WihHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QPhAu/33SQeENGyRqKFod420syI2mhuXfFV7CsnfR5vEFQn3CIGUT2OZPDWk7jHyj
	 xuHm88TXhhfPMDnxee2+Xseb5XTZx/wOcGrzGVsTKYRQFkz7wBhF5uksZ7GR+JwUsy
	 MnPuqMQVVBXQOvCCF0JWZ3HzT/9yj2cH97766pYI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>,
	Peng Fan <peng.fan@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 6.6 001/254] firmware: imx: scu-irq: Set mu_resource_id before get handle
Date: Wed, 28 Jan 2026 16:19:37 +0100
Message-ID: <20260128145344.755705316@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211984-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN_FAIL(0.00)[10.253.234.172.asn.rspamd.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RSPAMD_EMAILBL_FAIL(0.00)[frank.li.nxp.com:server fail,ben.decadent.org.uk:server fail,peng.fan.nxp.com:server fail];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,spec.np:url]
X-Rspamd-Queue-Id: 9FF88A3C1F
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Fan <peng.fan@nxp.com>

commit ff3f9913bc0749364fbfd86ea62ba2d31c6136c8 upstream.

mu_resource_id is referenced in imx_scu_irq_get_status() and
imx_scu_irq_group_enable() which could be used by other modules, so
need to set correct value before using imx_sc_irq_ipc_handle in
SCU API call.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Fixes: 81fb53feb66a ("firmware: imx: scu-irq: Init workqueue before request mbox channel")
Cc: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/imx/imx-scu-irq.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -203,6 +203,18 @@ int imx_scu_enable_general_irq_channel(s
 	struct mbox_chan *ch;
 	int ret = 0, i = 0;
 
+	if (!of_parse_phandle_with_args(dev->of_node, "mboxes",
+				       "#mbox-cells", 0, &spec)) {
+		i = of_alias_get_id(spec.np, "mu");
+		of_node_put(spec.np);
+	}
+
+	/* use mu1 as general mu irq channel if failed */
+	if (i < 0)
+		i = 1;
+
+	mu_resource_id = IMX_SC_R_MU_0A + i;
+
 	ret = imx_scu_get_handle(&imx_sc_irq_ipc_handle);
 	if (ret)
 		return ret;
@@ -225,18 +237,6 @@ int imx_scu_enable_general_irq_channel(s
 		return ret;
 	}
 
-	if (!of_parse_phandle_with_args(dev->of_node, "mboxes",
-				       "#mbox-cells", 0, &spec)) {
-		i = of_alias_get_id(spec.np, "mu");
-		of_node_put(spec.np);
-	}
-
-	/* use mu1 as general mu irq channel if failed */
-	if (i < 0)
-		i = 1;
-
-	mu_resource_id = IMX_SC_R_MU_0A + i;
-
 	/* Create directory under /sysfs/firmware */
 	wakeup_obj = kobject_create_and_add("scu_wakeup_source", firmware_kobj);
 	if (!wakeup_obj) {



