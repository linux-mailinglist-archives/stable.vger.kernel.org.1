Return-Path: <stable+bounces-270665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q/AgM4CVRmqcZAsAu9opvQ
	(envelope-from <stable+bounces-270665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:44:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A806FA7AA
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 18:44:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="YOmcM6/6";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270665-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-270665-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B62CD30E808A
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F9B4BCABE;
	Thu,  2 Jul 2026 16:25:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10606345CA3;
	Thu,  2 Jul 2026 16:25:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009532; cv=none; b=ltvjDTmzAlbu8JqjhL5I2aRvsK1FpyAz2lfxYG2cSMaYApLQChaCX2kxTkgjTpNYKrPXpatgpfmMtHsgmW0lctrCxUUU80drSDTIubow2HGuSeFSRrCn0Csuyb2RsbDXl9lBl9502mHSeLmmIoYSxS1UMdLnAPuRKO2R/zO8QC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009532; c=relaxed/simple;
	bh=J1aTt68AO9Orl1LPST8LZ29rOv4GLZHu0Jt4rKR4KgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qri2cJYJPctQ3rzTBkZzqjGWQXLv0VdLOC0L4+j7edab/9muAUB0q7cVFbwoYysSl8aRjZ14D1+J0tXDUZrNBs0pi+E4+9QQgwkaaU4CB2n9alD02NxJB18ghTmE3QgQ8kwp7WJjen6GAtZyS9lcyj5VSjOH53gImMB80xeB4Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YOmcM6/6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD691F00A3A;
	Thu,  2 Jul 2026 16:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783009528;
	bh=99b2O+yMtQZA/7QblZJ32ibPj9brfVs25rey2zWlZVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YOmcM6/6fH0mpGb31MicD3m73XQa/66O9TCqETuvEi2q0AWhreE3XiyRcpaDY8ooN
	 VYmQJcdd7DoAp86QC1+h2zFscXSXj8Yc2cRKMNRnmCyNY4ZlGNc7t/UgrvHZvKJWqy
	 iUHwzSeXrdqckipeEepY9qDdU/0X3EaGmfhyFZl4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kyle Meyer <kyle.meyer@hpe.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 85/96] bnxt_en: Fix NULL pointer dereference
Date: Thu,  2 Jul 2026 18:20:17 +0200
Message-ID: <20260702155110.766199130@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155108.949633242@linuxfoundation.org>
References: <20260702155108.949633242@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270665-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:kyle.meyer@hpe.com,m:pavan.chebbi@broadcom.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11A806FA7AA

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kyle Meyer <kyle.meyer@hpe.com>

[ Upstream commit d930276f2cddd0b7294cac7a8fe7b877f6d9e08d ]

PCIe errors detected by a Root Port or Downstream Port cause error
recovery services to run on all subordinate devices regardless of
administrative state.

The .error_detected() callback, bnxt_io_error_detected(), disables
and synchronizes IRQs via bnxt_disable_int_sync(), which calls
bnxt_cp_num_to_irq_num() to map completion rings to IRQs using
bp->bnapi.

Since bp->bnapi is allocated on NIC open and freed on NIC close, PCIe
error recovery on a closed NIC can dereference a NULL pointer.

Check if bp->bnapi is NULL before disabling and synchronizing IRQs.

Fixes: e5811b8c09df ("bnxt_en: Add IRQ remapping logic.")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Link: https://patch.msgid.link/aiNM1CY2-StPilxW@hpe.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4382,7 +4382,7 @@ static void bnxt_disable_int_sync(struct
 {
 	int i;
 
-	if (!bp->irq_tbl)
+	if (!bp->irq_tbl || !bp->bnapi)
 		return;
 
 	atomic_inc(&bp->intr_sem);



