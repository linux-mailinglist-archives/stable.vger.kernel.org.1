Return-Path: <stable+bounces-213575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JdkFUVeg2mJlQMAu9opvQ
	(envelope-from <stable+bounces-213575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:57:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC33EE7A2E
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 15:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4058530254F5
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 14:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072C541B345;
	Wed,  4 Feb 2026 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aFeLf7Hw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFAE27F749;
	Wed,  4 Feb 2026 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770216792; cv=none; b=APvriTrpT4fORo57uECl+rfitVYIkJsiqBI0UDodVRgnz2InPH7/4Drh4ZDxfwK/mJcbg9hxGKks6FSNBRgmskERLVSdACqSxHnXCdO0BoZCDzbhJRPcX9MWLXwvO8hGIBgw4d44U37UAYQdLmVo33bLUTwlMdAV6FYHKhL4uqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770216792; c=relaxed/simple;
	bh=QTGVHQRSQlcC6mLgrHZEorKxWQ9i0xix0QluKAbRff4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gq7Yx4OdzO65KyRXsEHF0iHxGTGkrWC9PE8ywi9TRNcvGn5c1f1N4PpJBzgWWCc8IQe66WSV+5VyDb0Am5f0eCbBco5j+pgXv2cNFMh3m3Rzpx6db7eBySCTYPCyjSqh3OrifSKbtFB4yqq1Yoo5DF6FeOiCPkWPAf/EGJN9RDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aFeLf7Hw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CF1C4CEF7;
	Wed,  4 Feb 2026 14:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770216792;
	bh=QTGVHQRSQlcC6mLgrHZEorKxWQ9i0xix0QluKAbRff4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aFeLf7Hw33nMDpiZXjOTzncfEZXXEpub7vvynHOPTr4u1U9zLs+fqNjD2n8Y6U4zu
	 HukNNpU9wPvxVTevy1Ef6bHuoqD0jhNUy0xQhngO1Yhk8Qt731A7nyDEh4MLhfWMSv
	 cOP9VJ2xiC9dEdK5m8+dR2vuGV283JPhA6Gj90zM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wu Haotian <rigoligo03@gmail.com>,
	Ilikara Zheng <ilikara@aosc.io>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 5.15 033/206] nvme-pci: disable secondary temp for Wodposit WPBSNM8
Date: Wed,  4 Feb 2026 15:37:44 +0100
Message-ID: <20260204143859.402239160@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143858.193781818@linuxfoundation.org>
References: <20260204143858.193781818@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213575-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,aosc.io,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: DC33EE7A2E
X-Rspamd-Action: no action

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilikara Zheng <ilikara@aosc.io>

commit 340f4fc5508c2905a1f30de229e2a4b299d55735 upstream.

Secondary temperature thresholds (temp2_{min,max}) were not reported
properly on this NVMe SSD. This resulted in an error while attempting to
read these values with sensors(1):

  ERROR: Can't get value of subfeature temp2_min: I/O error
  ERROR: Can't get value of subfeature temp2_max: I/O error

Add the device to the nvme_id_table with the
NVME_QUIRK_NO_SECONDARY_TEMP_THRESH flag to suppress access to all non-
composite temperature thresholds.

Cc: stable@vger.kernel.org
Tested-by: Wu Haotian <rigoligo03@gmail.com>
Signed-off-by: Ilikara Zheng <ilikara@aosc.io>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/pci.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3450,6 +3450,8 @@ static const struct pci_device_id nvme_i
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x1e49, 0x0041),   /* ZHITAI TiPro7000 NVMe SSD */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0x1fa0, 0x2283),   /* Wodposit WPBSNM8-256GTP */
+		.driver_data = NVME_QUIRK_NO_SECONDARY_TEMP_THRESH, },
 	{ PCI_DEVICE(0x025e, 0xf1ac),   /* SOLIDIGM  P44 pro SSDPFKKW020X7  */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */



