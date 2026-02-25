Return-Path: <stable+bounces-219189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2J2NM7d3nmn/VQQAu9opvQ
	(envelope-from <stable+bounces-219189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 05:16:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3201E191891
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 05:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD88C3059A89
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85432C0268;
	Wed, 25 Feb 2026 04:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gWjn/pfy"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A929AAFA;
	Wed, 25 Feb 2026 04:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771993000; cv=none; b=R3dS4scgFIQ+UlZNVCPdpvKq5rX35j8AVi6mM1/L5hV/QaURI3Ce59fysZ0dbXxTktdYEPpkE3wtQDDq5/MTBHGGb4IRMHNZWjPv6UGFI0wmJAokQyOkriO8mXY2nyaN2b5QzIqSZdDIlMimY2pERpGD303pivb2aI9NV2rRREs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771993000; c=relaxed/simple;
	bh=ZZMd/kJaZY4ndIrpQoCh1nYqfeoIF7VWl42NDmrb8YY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iLgpNpsWSGMDfvayYKz1HLUsWPHrbHikWrrvAbuYFiKqXZcUBsycGHp9h3I2dSDbG4h4awblFL3mIPgOiM4sDQW2WELqSpG4kKas4yWNkPTZzBJwl7lj/tUPih1baZGuaCnNUNr3Y3hEH7aW2ouRStBHNd4QUkSvruf+stz0THw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gWjn/pfy; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=cH
	npC4NzEhgVPkjGq4NCPnMeblL1uBcLtuEN0puwgGQ=; b=gWjn/pfyk6EIOwIMPT
	iRcHmMkCst8RChcHrKlPXk4/wy/hunNAZc4Ag31GBeX0LwMbHvwJplhbtGF8iDam
	i/5knsI5mbs8R9pAxeaOdz1iPKN0EFFPKjQq6peSFg+8fIhUIHYYTCSFNB8y6Ny3
	0vWulT8f+I/SYyglqsnOs9UmM=
Received: from pek-lpg-core6.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDX_QiHd55pLy8aMw--.48963S3;
	Wed, 25 Feb 2026 12:16:09 +0800 (CST)
From: Rahul Sharma <black.hawk@163.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Wei Fang <wei.fang@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Rahul Sharma <black.hawk@163.com>
Subject: [PATCH 6.1.y 2/2] net: enetc: allocate vf_state during PF probes
Date: Wed, 25 Feb 2026 12:16:05 +0800
Message-Id: <20260225041605.1563705-2-black.hawk@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260225041605.1563705-1-black.hawk@163.com>
References: <20260225041605.1563705-1-black.hawk@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX_QiHd55pLy8aMw--.48963S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw13uFyfKF1rJw4xArykGrg_yoW5KF13pr
	WfJasIgr48Xa17AFWkW3W8ZF98Kay8ta4rGrW2kw4fuF4av3W5tr1vqryYgF1FvrWvqay3
	t34fCws5uF4ktwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE9mi7UUUUU=
X-CM-SenderInfo: 5eoduy4okd4yi6rwjhhfrp/xtbC+gsCm2med4sYhAAA3-
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219189-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,nxp.com,kernel.org,163.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[black.hawk@163.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,ls1028ardb:email]
X-Rspamd-Queue-Id: 3201E191891
X-Rspamd-Action: no action

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
---
 .../net/ethernet/freescale/enetc/enetc_pf.c    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index b6fd12c9ecc4..99422c0b4a26 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -683,19 +683,11 @@ static int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 
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
@@ -714,7 +706,6 @@ static int enetc_sriov_configure(struct pci_dev *pdev, int num_vfs)
 err_en_sriov:
 	enetc_msg_psi_free(pf);
 err_msg_psi:
-	kfree(pf->vf_state);
 	pf->num_vfs = 0;
 
 	return err;
@@ -1322,6 +1313,12 @@ static int enetc_pf_probe(struct pci_dev *pdev,
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
@@ -1398,6 +1395,8 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 err_alloc_netdev:
 err_device_disabled:
 err_setup_mac_addresses:
+	kfree(pf->vf_state);
+err_alloc_vf_state:
 	enetc_psi_destroy(pdev);
 err_psi_create:
 	return err;
@@ -1424,6 +1423,7 @@ static void enetc_pf_remove(struct pci_dev *pdev)
 	enetc_free_si_resources(priv);
 
 	free_netdev(si->ndev);
+	kfree(pf->vf_state);
 
 	enetc_psi_destroy(pdev);
 }
-- 
2.34.1


