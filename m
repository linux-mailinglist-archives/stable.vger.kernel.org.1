Return-Path: <stable+bounces-243427-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEp7CdGp+GnHxgIAu9opvQ
	(envelope-from <stable+bounces-243427-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:14:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F0B4BEE25
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 601DF30229F7
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0C33D8129;
	Mon,  4 May 2026 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jt1QEosA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF8E3B19D1;
	Mon,  4 May 2026 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903856; cv=none; b=bYu7kRARAtnKOq0sOheXpmo4T478KPfC79QYsrH+junS7giLJtuJtTvu4gQiZLJGJy0d/UDuEYRiSosQqug2JojfENeQUzLvOIMWotjrRXg6YtWNqvzUHHSK1N1ax77+N2bC/1jmi1lDp9dhZTxYEDJpjr1j6QhtfbQv/siKz/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903856; c=relaxed/simple;
	bh=8H6nPpO5KXG3CA2TRdc4/JmZmyBoloZxmu+pqwgvqwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gL3ouvEPIaYoQrwole3plaJfRBZjq1qYiKNc2Sz9r7+/aJJK8PKdm38BpPbt7ktTbVQlklmbn8CgieE938tOFAbPkiXx6OUM9Srl0siN/qqeGoCA+T9/0+aaH/VftNuxirt2OZlPQbLqbwTEXY9Kiro/z2LP3TZmxtsINH2vqAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jt1QEosA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A22C2BCB8;
	Mon,  4 May 2026 14:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903856;
	bh=8H6nPpO5KXG3CA2TRdc4/JmZmyBoloZxmu+pqwgvqwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jt1QEosAcZ7QKOc0nRH62svSqTS3Z2E7pPNrfu8qiHcgzxRyvUTxtxjUc5UzcNMf5
	 eUStQcTCaJJKGiR4YY6a3xurc4+/uDUcXrcuO4V0kJtiYqWOkFKMYTXORqm5EkTRTl
	 YI7WFp+W5mcqQtvVH0I/xqDScmMGsJm8X3gd7DuA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Hodges <git@danielhodges.dev>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: [PATCH 6.18 055/275] PCI: epf-mhi: Return 0, not remaining timeout, when eDMA ops complete
Date: Mon,  4 May 2026 15:49:55 +0200
Message-ID: <20260504135144.980276760@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.929052779@linuxfoundation.org>
References: <20260504135142.929052779@linuxfoundation.org>
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
X-Rspamd-Queue-Id: C3F0B4BEE25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243427-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,danielhodges.dev:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,qualcomm.com:email]

6.18-stable review patch.  If anyone has any objections, please let me know.

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



