Return-Path: <stable+bounces-212415-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFNVHOgyeml+4gEAu9opvQ
	(envelope-from <stable+bounces-212415-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:01:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13434A4F0E
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E644131888B7
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335E03054D8;
	Wed, 28 Jan 2026 15:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BLxzJLX4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB368288C22;
	Wed, 28 Jan 2026 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615442; cv=none; b=Gr5TNNj4LhYNVL2XcpG4UuCpJJbeFgH5I8i1L0Gv15gL+e9m318UbRi9DpC11pPDCgYM4Z72g2LYpzOJJMK4CTiPODdIoS9jUAKPJXG5vkmCs3qljCRqZqw+Y/Y1i1DBg2bsrE5XyzNRm67f6Vz9U5Dk5bHRMQrFNmhn6riLgHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615442; c=relaxed/simple;
	bh=iYMNjW2AA2q1tjP+YQFCbLW9e9w9qrN1WtKLWsNuQao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LD+Wog/LvGvQ/V5vxqE8lkQeuqlB9RaYD1hXQkR681pbv2yyrRVh8x3/bM6dfNX1bI1YPfLLhMQsFgXoIf8cOID5YsVg0JqjzN/iNm/JoiiatGE8dbisiUDauXFLRbpQHleMXMO59uDLicdYXBSRN+cy76xReJIEfs93C0p8Xns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BLxzJLX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3552DC4CEF1;
	Wed, 28 Jan 2026 15:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615441;
	bh=iYMNjW2AA2q1tjP+YQFCbLW9e9w9qrN1WtKLWsNuQao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BLxzJLX45DHYSGD6ckj77S0SB4HQNwRS6ZPhAg7DXiDBZDPe/kZ9axIvsc1yJXRrz
	 IbcjK9fmiZEFaDtcjwU9OYc16WEH3bQI7ZsFMkogIAhB32S0Qb0/e5mGm/K2v6wxXb
	 Bqq5jedN/AFr/9F/XclYU9QXGX6hodquM4PGxXww=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>,
	Wolf <wolf@yoxt.cc>,
	Damien Le Moal <dlemoal@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 011/227] ata: ahci: Do not read the per port area for unimplemented ports
Date: Wed, 28 Jan 2026 16:20:56 +0100
Message-ID: <20260128145344.746796781@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[linuxfoundation.org:query timed out,cap.np:query timed out,yoxt.cc:query timed out];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_FROM(0.00)[bounces-212415-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RSPAMD_EMAILBL_FAIL(0.00)[sashal.kernel.org:server fail,wolf.yoxt.cc:query timed out,cassel.kernel.org:query timed out,dlemoal.kernel.org:query timed out];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 13434A4F0E
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Niklas Cassel <cassel@kernel.org>

[ Upstream commit ea4d4ea6d10a561043922d285f1765c7e4bfd32a ]

An AHCI HBA specifies the number of ports it supports using CAP.NP.
The HBA is free to only make a subset of the number of ports available
using the PI (Ports Implemented) register.

libata currently creates dummy ports for HBA ports that are provided by
the HBA, but which are marked as "unavailable" using the PI register.

Each port will have a per port area of registers in the HBA, regardless
if the port is marked as "unavailable" or not.

ahci_mark_external_port() currently reads this per port area of registers
using readl() to see if the port is marked as external/hotplug-capable.

However, AHCI 1.3.1, section "3.1.4 Offset 0Ch: PI – Ports Implemented"
states: "Software must not read or write to registers within unavailable
ports."

Thus, make sure that we only call ahci_mark_external_port() and
ahci_update_initial_lpm_policy() for ports that are implemented.

>From a libata perspective, this should not change anything related to LPM,
as dummy ports do not provide any ap->ops (they do not have a .set_lpm()
callback), so even if EH were to call .set_lpm() on a dummy port, it was
already a no-op.

Fixes: f7131935238d ("ata: ahci: move marking of external port earlier")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Tested-by: Wolf <wolf@yoxt.cc>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/ahci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 7a7f88b3fa2b1..931d0081169b9 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -2094,13 +2094,13 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		if (ap->flags & ATA_FLAG_EM)
 			ap->em_message_type = hpriv->em_msg_type;
 
-		ahci_mark_external_port(ap);
-
-		ahci_update_initial_lpm_policy(ap);
-
 		/* disabled/not-implemented port */
-		if (!(hpriv->port_map & (1 << i)))
+		if (!(hpriv->port_map & (1 << i))) {
 			ap->ops = &ata_dummy_port_ops;
+		} else {
+			ahci_mark_external_port(ap);
+			ahci_update_initial_lpm_policy(ap);
+		}
 	}
 
 	/* apply workaround for ASUS P5W DH Deluxe mainboard */
-- 
2.51.0




