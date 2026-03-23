Return-Path: <stable+bounces-229897-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLVMEjF9wWknTgQAu9opvQ
	(envelope-from <stable+bounces-229897-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:49:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4392FA793
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D2A8312B11A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4CE3AE19E;
	Mon, 23 Mar 2026 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="krE3FfyW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EBC246778;
	Mon, 23 Mar 2026 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283157; cv=none; b=Di2zWO17yMcACj8VOhyeHn7qIFy18XrKMsKl9ljwlSen+0iAk8WPCrnTFxjHUgh7/rPgJly5GG79OxhOR2E1qFhUl0EffL4G9ETlQvT/p4IbXyxNQuUIHAiuzrpdcyD/SRRt/EwG2JoL6vXx9PU89dkvw4BEwgpTA1sHVfngHvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283157; c=relaxed/simple;
	bh=uiT27NERLVXfJvj6CL3NSzAdx5zve1TgheJBRy9al88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJbSLiemLxCplUTAKiRhahLdTqowhGis8LASrsc1j2vL/LVWVImcZ/ZlaPOo+BsSy6u9nAZdmtwJkh4ISxJcy5zmBW1SLf3Ooy9rvL/9JlwNF+ko26x6Zf8BqU7vp7YSHqADAU2hK8iqZvPQ11ltrikS27cNCxVABFMGlzJKpos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=krE3FfyW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7610C2BC9E;
	Mon, 23 Mar 2026 16:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774283157;
	bh=uiT27NERLVXfJvj6CL3NSzAdx5zve1TgheJBRy9al88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=krE3FfyWkPZNlFX28hnKscSuC1nfoFJ2Z79M4ubFjcraBEvLrPGDE2zsII6D1TEoH
	 ElohOkXMdZF/44xSLlDHG5+lED8ofuQUnzBdL/dDrMF6UxNW+dQwAWbxsMCLxF7UnF
	 W7r2c6IkgPMiOyS1/VXfWNFuj9JBNjH/LoBfYQVo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wei Fang <wei.fang@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 6.1 379/481] net: enetc: allocate vf_state during PF probes
Date: Mon, 23 Mar 2026 14:46:01 +0100
Message-ID: <20260323134534.371230946@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,nxp.com,kernel.org,163.com];
	TAGGED_FROM(0.00)[bounces-229897-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: AF4392FA793
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Fang <wei.fang@nxp.com>

[ Upstream commit e15c5506dd39885cd047f811a64240e2e8ab401b ]

In the previous implementation, vf_state is allocated memory only when VF
is enabled. However, net_device_ops::ndo_set_vf_mac() may be called before
VF is enabled to configure the MAC address of VF. If this is the case,
enetc_pf_set_vf_mac() will access vf_state, resulting in access to a null
pointer. The simplified error log is as follows.

root@ls1028ardb:~# ip link set eno0 vf 1 mac 00:0c:e7:66:77:89
[  173.543315] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
[  173.637254] pc : enetc_pf_set_vf_mac+0x3c/0x80 Message from sy
[  173.641973] lr : do_setlink+0x4a8/0xec8
[  173.732292] Call trace:
[  173.734740]  enetc_pf_set_vf_mac+0x3c/0x80
[  173.738847]  __rtnl_newlink+0x530/0x89c
[  173.742692]  rtnl_newlink+0x50/0x7c
[  173.746189]  rtnetlink_rcv_msg+0x128/0x390
[  173.750298]  netlink_rcv_skb+0x60/0x130
[  173.754145]  rtnetlink_rcv+0x18/0x24
[  173.757731]  netlink_unicast+0x318/0x380
[  173.761665]  netlink_sendmsg+0x17c/0x3c8

Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet drivers")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://patch.msgid.link/20241031060247.1290941-2-wei.fang@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Rahul Sharma <black.hawk@163.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/freescale/enetc/enetc_pf.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -683,19 +683,11 @@ static int enetc_sriov_configure(struct
 
 	if (!num_vfs) {
 		enetc_msg_psi_free(pf);
-		kfree(pf->vf_state);
 		pf->num_vfs = 0;
 		pci_disable_sriov(pdev);
 	} else {
 		pf->num_vfs = num_vfs;
 
-		pf->vf_state = kcalloc(num_vfs, sizeof(struct enetc_vf_state),
-				       GFP_KERNEL);
-		if (!pf->vf_state) {
-			pf->num_vfs = 0;
-			return -ENOMEM;
-		}
-
 		err = enetc_msg_psi_init(pf);
 		if (err) {
 			dev_err(&pdev->dev, "enetc_msg_psi_init (%d)\n", err);
@@ -714,7 +706,6 @@ static int enetc_sriov_configure(struct
 err_en_sriov:
 	enetc_msg_psi_free(pf);
 err_msg_psi:
-	kfree(pf->vf_state);
 	pf->num_vfs = 0;
 
 	return err;
@@ -1322,6 +1313,12 @@ static int enetc_pf_probe(struct pci_dev
 	pf = enetc_si_priv(si);
 	pf->si = si;
 	pf->total_vfs = pci_sriov_get_totalvfs(pdev);
+	if (pf->total_vfs) {
+		pf->vf_state = kcalloc(pf->total_vfs, sizeof(struct enetc_vf_state),
+				       GFP_KERNEL);
+		if (!pf->vf_state)
+			goto err_alloc_vf_state;
+	}
 
 	err = enetc_setup_mac_addresses(node, pf);
 	if (err)
@@ -1398,6 +1395,8 @@ err_alloc_si_res:
 err_alloc_netdev:
 err_device_disabled:
 err_setup_mac_addresses:
+	kfree(pf->vf_state);
+err_alloc_vf_state:
 	enetc_psi_destroy(pdev);
 err_psi_create:
 	return err;
@@ -1424,6 +1423,7 @@ static void enetc_pf_remove(struct pci_d
 	enetc_free_si_resources(priv);
 
 	free_netdev(si->ndev);
+	kfree(pf->vf_state);
 
 	enetc_psi_destroy(pdev);
 }



