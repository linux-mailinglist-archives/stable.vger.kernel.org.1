Return-Path: <stable+bounces-243679-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJGvKies+GnHxgIAu9opvQ
	(envelope-from <stable+bounces-243679-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:24:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEC04BF4F6
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B697B307425F
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A783DE452;
	Mon,  4 May 2026 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DIL/KGYA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFA4315785;
	Mon,  4 May 2026 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904499; cv=none; b=bYjhT/UqaIoF1NVlOmDMuWgf/seoOptgsQWHMMWGuCY0G/JO7bTN418YgSNO+jcujcUXk2WySAjnMalgh4Jv+xLdXmb70nDIGTQTmAYJZ95vcf6OHuK1QD7TfJYER8CfwKSy9QoNGmrTyf4QAkPb9YvmLWRzcPnYERXvayGfp9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904499; c=relaxed/simple;
	bh=qOsWCpEkM6++30S52srjAbiT72yu9arDEIoMDhWLq8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BxtaZ/Ye4ogJTIJnBKMmEaKyn1Qj7AbOv3+uvfUnDvUBykI9jSgL9mkxm32jcqEuIDd7PsiTDIy8gwRMPljCKnAyp+pAhvA0oUOAlSPbL/1jtX52rSZOJ2lqBY4rEQ/1Neu55Es80FDBANNxH1KoCSGBGAX8sufSyiMETPstCXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DIL/KGYA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48FFC2BCB8;
	Mon,  4 May 2026 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904499;
	bh=qOsWCpEkM6++30S52srjAbiT72yu9arDEIoMDhWLq8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DIL/KGYAKvut8GA5aQEx6AGkAX1eyjOShPu7hjVdWhhn+ymD1njkH3jUTLijjkxUE
	 nZUEBRYipvSJ+wTTRdI5aCOeq6aDAiIIKmfXVqMvIoE6riC05tmBAEePUPR8rPT1+N
	 31vPhZHjqwBUX1HGK35G9fCM38laAPjDQxrbn8wI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Robert Beckett <bob.beckett@collabora.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 6.12 061/215] nvme-pci: add NVME_QUIRK_DISABLE_WRITE_ZEROES for Kingston OM3SGP4
Date: Mon,  4 May 2026 15:51:20 +0200
Message-ID: <20260504135132.402722742@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 4CEC04BF4F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243679-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,collabora.com:email]

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robert Beckett <bob.beckett@collabora.com>

commit a8eebf9699d69987cc49cec4e4fdb4111ab32423 upstream.

The Kingston OM3SGP42048K2-A00 (PCI ID 2646:502f) firmware has a race
condition when processing concurrent write zeroes and DSM (discard)
commands, causing spurious "LBA Out of Range" errors and IOMMU page
faults at address 0x0.

The issue is reliably triggered by running two concurrent mkfs commands
on different partitions of the same drive, which generates interleaved
write zeroes and discard operations.

Disable write zeroes for this device, matching the pattern used for
other Kingston OM* drives that have similar firmware issues.

Cc: stable@vger.kernel.org
Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Assisted-by: claude-opus-4-6-v1
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/pci.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3716,6 +3716,8 @@ static const struct pci_device_id nvme_i
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x2646, 0x501E),   /* KINGSTON OM3PGP4xxxxQ OS21011 NVMe SSD */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x2646, 0x502F),   /* KINGSTON OM3SGP4xxxxK NVMe SSD */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1f40, 0x1202),   /* Netac Technologies Co. NV3000 NVMe SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1f40, 0x5236),   /* Netac Technologies Co. NV7000 NVMe SSD */



