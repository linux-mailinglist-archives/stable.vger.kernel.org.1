Return-Path: <stable+bounces-229398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECUvFNBiwWmaSgQAu9opvQ
	(envelope-from <stable+bounces-229398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:57:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 687092F7298
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3657D307DCB2
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9947F3B6349;
	Mon, 23 Mar 2026 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VAufwY9G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E72820C6;
	Mon, 23 Mar 2026 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278989; cv=none; b=UkDHiJn+bd3AZ9J2JV2uWUwBbrp39F5lKUG6lzQk7v9YlX1dkNCDZ3Ui1snaqtn/K1N+d8pR8xabCZN3rMipRd1dtIXNb7mtOyONK/hKcqEHOtETwrTM+RoNtIOu495StCY0zaEjHGgQML1Eu0uUOqifE7FwJN6Fw9z94b9WZCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278989; c=relaxed/simple;
	bh=UdQagBp0TuQDkd3R6sLFIJBFbNyr06Sp07htsn9qgnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfkzdMhj9cJpDLbRvhlXA90hQpm9v6EPwVTBbjqoUV4+qYNQxxALijq8cKLrpEngXegAao6CbQxsgzgGBgXCotSZ5eWAZtXKjJDf6od0ezjCMZMYeyrEo9zt2PZ74mbQCe3lb55SqTRlHA5Bkg4xnUdQh4dn36uv1J1jWXoTl6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VAufwY9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5679C2BC9E;
	Mon, 23 Mar 2026 15:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278989;
	bh=UdQagBp0TuQDkd3R6sLFIJBFbNyr06Sp07htsn9qgnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VAufwY9GQ1vWPm5NTwiB6kyhVDpx6QaNtqHETJ1+gCvOi0qtFJDRvVigEA1WFKxHa
	 ZkPchnVHne46Rwip5gEfoWMnkS7TaE5jDoflD8Bu/1cZclv2sZLAFJ81Yy43w1bu75
	 o3eoOGXStJXtwK/zi1KBnV3frkjd8YOLi5COFr98=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Martin=20Roukala=20 ?= <martin.roukala@mupuf.org>,
	stable <stable@kernel.org>
Subject: [PATCH 6.6 483/567] serial: 8250_pci: add support for the AX99100
Date: Mon, 23 Mar 2026 14:46:43 +0100
Message-ID: <20260323134545.930463442@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.96 / 15.00];
	CC_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229398-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,mupuf.org:email]
X-Rspamd-Queue-Id: 687092F7298
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Roukala (né Peres) <martin.roukala@mupuf.org>

commit 9c0072bc33d349c83d223e64be30794e11938a6b upstream.

This is found in popular brands such as StarTech.com or Delock, and has
been a source of frustration to quite a few people, if I can trust
Amazon comments complaining about Linux support via the official
out-of-the-tree driver.

Signed-off-by: Martin Roukala (né Peres) <martin.roukala@mupuf.org>
Cc: stable <stable@kernel.org>
Link: https://patch.msgid.link/20260309-8250_pci_ax99100-v1-1-3328bdfd8e94@mupuf.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_pci.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -59,6 +59,8 @@ struct serial_private {
 };
 
 #define PCI_DEVICE_ID_HPE_PCI_SERIAL	0x37e
+#define PCIE_VENDOR_ID_ASIX		0x125B
+#define PCIE_DEVICE_ID_AX99100		0x9100
 
 static const struct pci_device_id pci_use_msi[] = {
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9900,
@@ -71,6 +73,8 @@ static const struct pci_device_id pci_us
 			 0xA000, 0x1000) },
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP_3PAR, PCI_DEVICE_ID_HPE_PCI_SERIAL,
 			 PCI_ANY_ID, PCI_ANY_ID) },
+	{ PCI_DEVICE_SUB(PCIE_VENDOR_ID_ASIX, PCIE_DEVICE_ID_AX99100,
+			 0xA000, 0x1000) },
 	{ }
 };
 
@@ -834,6 +838,7 @@ static int pci_netmos_init(struct pci_de
 	case PCI_DEVICE_ID_NETMOS_9912:
 	case PCI_DEVICE_ID_NETMOS_9922:
 	case PCI_DEVICE_ID_NETMOS_9900:
+	case PCIE_DEVICE_ID_AX99100:
 		num_serial = pci_netmos_9900_numports(dev);
 		break;
 
@@ -2396,6 +2401,14 @@ static struct pci_serial_quirk pci_seria
 		.init		= pci_netmos_init,
 		.setup		= pci_netmos_9900_setup,
 	},
+	{
+		.vendor		= PCIE_VENDOR_ID_ASIX,
+		.device		= PCI_ANY_ID,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_netmos_init,
+		.setup		= pci_netmos_9900_setup,
+	},
 	/*
 	 * EndRun Technologies
 	*/
@@ -5940,6 +5953,10 @@ static const struct pci_device_id serial
 		0xA000, 0x3002,
 		0, 0, pbn_NETMOS9900_2s_115200 },
 
+	{	PCIE_VENDOR_ID_ASIX, PCIE_DEVICE_ID_AX99100,
+		0xA000, 0x1000,
+		0, 0, pbn_b0_1_115200 },
+
 	/*
 	 * Best Connectivity and Rosewill PCI Multi I/O cards
 	 */



