Return-Path: <stable+bounces-231423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDqlNoTIy2mnLgYAu9opvQ
	(envelope-from <stable+bounces-231423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:13:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CC236A02D
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CAADF302B44A
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 13:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53393E3DB6;
	Tue, 31 Mar 2026 13:13:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991FB3DDDBE;
	Tue, 31 Mar 2026 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774962815; cv=none; b=Hxpu9LVOWOT7k2orT568dKE2R8BWwcSp7IFEhsTo0xpg5e0cgGncxPE3pgFrichUQDN+Y1Gs2WQnvkYUq5p7Wp3XOxZmJt3QYGaQfpeF+2yi/q4/ZNwoI89c4WPrZ8yOr/TSQSZ+Q84jzRnlIR221FoiTxegZIkRBfSiog4Pb24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774962815; c=relaxed/simple;
	bh=SHj3DDseZiH/4dxjYYniOZauM69UOEzOw0j1poq4wno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NECIdePd1q46RbrbbShI3/KA9d0VYcv3V8r/QL/iXF+6kC4/yMgoQhumxZD4sV8GQ9hqS7xPB3mIjNgRa7p1WRBTMXnnC7gXkpL9yiAhWOmeRYseO9AKofDdWaPr35HJQ86upgfXPtL7cLpCU2pKohFncDcdmZthCmz8geESeh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id CD51910616;
	Tue, 31 Mar 2026 15:13:32 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id B77456015F77; Tue, 31 Mar 2026 15:13:32 +0200 (CEST)
Date: Tue, 31 Mar 2026 15:13:32 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bernd Schumacher <bernd@bschu.de>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	1131025@bugs.debian.org, regressions@lists.linux.dev,
	stable@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [6.12.y regression] Regression with 58130e7ce6cb ("PCI/ERR:
 Ensure error recoverability at all times"): echo vfio-pci >driver_override
 does not work for DVB Adapter
Message-ID: <acvIfI3naoGsOpFE@wunner.de>
References: <177373189751.7987.7156982489427825197.reportbug@obelix-trixie.bs.de>
 <acfZrlP0Ua_5D3U4@eldamar.lan>
 <acfhf-odtr0yw_py@wunner.de>
 <74bcd84500e5efcca035624f325e400dd8a21f44.camel@bschu.de>
 <acgohjvBpVcR7HcK@wunner.de>
 <5f9386146f426e2847550681cb7188471205607f.camel@bschu.de>
 <aclRwznwq6KpA2qA@wunner.de>
 <ecf9b2dd96ff97cc035ba297266b8dd05eea88da.camel@bschu.de>
 <acvHjo8PKdyHshSE@wunner.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acvHjo8PKdyHshSE@wunner.de>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231423-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,wunner.de:mid]
X-Rspamd-Queue-Id: 82CC236A02D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 03:09:34PM +0200, Lukas Wunner wrote:
> Below is a small debug patch.  Could you apply that on top of v6.12.73
> (or newer) and provide me with the resulting full dmesg output?

Sorry, here's the patch:

-- >8 --

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 963436edea1c..53c5f23b4290 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1827,6 +1827,8 @@ int pci_save_state(struct pci_dev *dev)
 {
 	int i;
 	/* XXX: 100% dword access ok here? */
+	if (dev->bus->number == 0x07)
+		dump_stack();
 	for (i = 0; i < 16; i++) {
 		pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
 		pci_dbg(dev, "save config %#04x: %#010x\n",
@@ -1887,6 +1889,9 @@ static void pci_restore_config_space_range(struct pci_dev *pdev,
 
 static void pci_restore_config_space(struct pci_dev *pdev)
 {
+	if (pdev->bus->number == 0x07)
+		dump_stack();
+
 	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL) {
 		pci_restore_config_space_range(pdev, 10, 15, 0, false);
 		/* Restore BARs before the command register. */
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index c6d933ddfd46..cbcf185578ac 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -363,6 +363,7 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
 	res->flags &= ~IORESOURCE_UNSET;
 	res->flags &= ~IORESOURCE_STARTALIGN;
 	pci_info(dev, "%s %pR: assigned\n", res_name, res);
+	dump_stack();
 	if (resno < PCI_BRIDGE_RESOURCES)
 		pci_update_resource(dev, resno);
 

