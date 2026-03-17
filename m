Return-Path: <stable+bounces-226655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iMGaIIONuWnkJwIAu9opvQ
	(envelope-from <stable+bounces-226655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:21:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BEE2AF5C8
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58264321A828
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D1826FD9B;
	Tue, 17 Mar 2026 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tb2r6s6C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C99A1ACEDE;
	Tue, 17 Mar 2026 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767663; cv=none; b=YnXB882s7WsbtSva7CaESTcsql0iy5kG0MNH7MuZhvnfEFX4EdonK2V7ofZCKJ8ezIfqGuGlu6IPqTnAEfVVnoQDcWONXKtJpLsPSKxA76bLAsneamT/OyqvI8ftXmChzs4V2CpKDh2mX8tQJbdc2LcfRARnqlZ7HFE9T0q5PPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767663; c=relaxed/simple;
	bh=shxf5IX1hdSQ7d3WnDlqQVDfJn5b4kFDghiegsj8GpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iaCNUaw/lb7q5a141rHT6lBzkTFQ9rqNmtjv2y2kDqAGNExhk6v2VB9fWXwemC/SM99VctRGlLfGS9hLp5rvb76BgdFrIDsHy7+1ao69qmjuOlx2Yt1i/KfDw2BQQPXk2x5+qfwTLx05tEy4qyvlS43I59+BNN3tMItX2cFvcKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tb2r6s6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F74BC4CEF7;
	Tue, 17 Mar 2026 17:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767663;
	bh=shxf5IX1hdSQ7d3WnDlqQVDfJn5b4kFDghiegsj8GpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tb2r6s6CDTcowBcJXYceBzRrs7FA5/VGKGBPPCruOsW/ewbvReAHKmTwjBTjbI1NC
	 AYTHMWp3YXd6SNXiefEuusg8Y/abfaB+XATVh49ZdAQsPsVka2zJByKNFWiE9anbyx
	 KFohktULqa8EY8v/B2FZOO/6Cg+P+3B1Ix07V9w8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 6.18 132/333] usb: dwc3: pci: add support for the Intel Nova Lake -H
Date: Tue, 17 Mar 2026 17:32:41 +0100
Message-ID: <20260317163004.257656335@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226655-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,synopsys.com:email]
X-Rspamd-Queue-Id: E5BEE2AF5C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit 17ab4d4078e22be7fd8fd6fc710c15c085a4cb1b upstream.

This patch adds the necessary PCI ID for Intel Nova Lake -H
devices.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: stable <stable@kernel.org>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/20260309130204.208661-1-heikki.krogerus@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/dwc3-pci.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -56,6 +56,7 @@
 #define PCI_DEVICE_ID_INTEL_CNPH		0xa36e
 #define PCI_DEVICE_ID_INTEL_CNPV		0xa3b0
 #define PCI_DEVICE_ID_INTEL_RPL			0xa70e
+#define PCI_DEVICE_ID_INTEL_NVLH		0xd37f
 #define PCI_DEVICE_ID_INTEL_PTLH		0xe332
 #define PCI_DEVICE_ID_INTEL_PTLH_PCH		0xe37e
 #define PCI_DEVICE_ID_INTEL_PTLU		0xe432
@@ -448,6 +449,7 @@ static const struct pci_device_id dwc3_p
 	{ PCI_DEVICE_DATA(INTEL, CNPH, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, CNPV, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, RPL, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, NVLH, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, PTLH, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, PTLH_PCH, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, PTLU, &dwc3_pci_intel_swnode) },



