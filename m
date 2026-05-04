Return-Path: <stable+bounces-243664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPkkIKar+GnHxgIAu9opvQ
	(envelope-from <stable+bounces-243664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:22:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D65094BF389
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64D85302291C
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6530229E116;
	Mon,  4 May 2026 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nJ4PwiF5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2920C1A6827;
	Mon,  4 May 2026 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904463; cv=none; b=DwJ82HSJN5e4QBxyeGvnLP7+DRZCOZ5UmJszb3BVtE+E35e66AG8lmjFu+bMgZT2hsoQ+7DDqHjxZ/Zroc0kseDZZBsPtWwpgtEnJtsvfdeXzTfcRU1VOh93FdhEGIEbkBW5zs0Xq1vPt3gXZwBDjDVRWriqxICj9ga/L46+qrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904463; c=relaxed/simple;
	bh=rWFgWgdBfoQr7h3LDDIDzJUFe7GCNC3U0LgdS9yPRh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVXVM28tgkvNB8XsrOjhnEb5jMbz5jy8EDhoxXCj0xi7QuWFa0OP1Qm0p73clXa7ZiMJaBVydDpZFfGNk4OkMpbOkc2hmh2mhfG9O/P/gLLDjTxQ0U9DThnelQnentYxhD5aeTqNmvr7Qcfu9X9yn/ENMGjeibJ83Gq0bI/Fc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nJ4PwiF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1634C2BCB8;
	Mon,  4 May 2026 14:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904463;
	bh=rWFgWgdBfoQr7h3LDDIDzJUFe7GCNC3U0LgdS9yPRh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJ4PwiF5lgjHRBBPkd8LWdnT0MdkOQBzowyd19aJYu9WhocjKSHhz97oRrsGRmKl+
	 0Gx477I5bJBphFAub8rqXBzMtFoHw/tfsVjQBtO8DBo9Dg8h9/fRj/F2GLlq07CeJK
	 EBm6TLtPb26ksVRBptnt4PijLuXtgVnq4PrVtPc8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Hodges <git@danielhodges.dev>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 6.12 048/215] PCI: epf-mhi: Return 0, not remaining timeout, when eDMA ops complete
Date: Mon,  4 May 2026 15:51:07 +0200
Message-ID: <20260504135131.934142157@linuxfoundation.org>
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
X-Rspamd-Queue-Id: D65094BF389
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243664-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,danielhodges.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Hodges <git@danielhodges.dev>

commit 36bfc3642b19a98f1302aed4437c331df9b481f0 upstream.

pci_epf_mhi_edma_read() and pci_epf_mhi_edma_write() start DMA
operations and wait for completion with a timeout.

On successful completion, they previously returned the remaining
timeout, which callers may treat as an error.  In particular,
mhi_ep_ring_add_element(), which calls pci_epf_mhi_edma_write() via
mhi_cntrl->write_sync(), interprets any non-zero return value as
failure.

Return 0 on success instead of the remaining timeout to prevent
mhi_ep_ring_add_element() from treating successful completion as an
error.

Fixes: 7b99aaaddabb ("PCI: epf-mhi: Add eDMA support")
Signed-off-by: Daniel Hodges <git@danielhodges.dev>
[mani: changed commit log as per https://lore.kernel.org/linux-pci/20260227191510.GA3904799@bhelgaas]
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260206200529.10784-1-git@danielhodges.dev
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -367,6 +367,8 @@ static int pci_epf_mhi_edma_read(struct
 		dev_err(dev, "DMA transfer timeout\n");
 		dmaengine_terminate_sync(chan);
 		ret = -ETIMEDOUT;
+	} else {
+		ret = 0;
 	}
 
 err_unmap:
@@ -438,6 +440,8 @@ static int pci_epf_mhi_edma_write(struct
 		dev_err(dev, "DMA transfer timeout\n");
 		dmaengine_terminate_sync(chan);
 		ret = -ETIMEDOUT;
+	} else {
+		ret = 0;
 	}
 
 err_unmap:



