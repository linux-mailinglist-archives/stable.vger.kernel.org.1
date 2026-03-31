Return-Path: <stable+bounces-231961-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DGpNgH8y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-231961-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:53:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4E336D554
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 02E4E30E7E69
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3031D423A93;
	Tue, 31 Mar 2026 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kBTHrPAe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A0E3E9299;
	Tue, 31 Mar 2026 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975514; cv=none; b=qpq94wIrWEL4wO1flQ/hS8EE804iIAQj4fZcGg+CCKPWltlK+ne0B3qhyurVzYZG0rTbvBy2z0hvDyPjX1BmezGGk0NbI97ycrIf1a+AZasewoTaUosqYlk+b1OMy6K24KtRTw7b/SgkwENlA3PYTpKFoeqvPQKD7RUsKLbySDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975514; c=relaxed/simple;
	bh=R5s/6r/yTdmlX+TVkxnTFZufWEe/AVXDjabfCnGBkJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpnKVyyYZldo8xO2XLpi1J2Y9+Ved3UMyXn+N860zwDkVtKfoA4G43DsNDKJUzMkK0BpMynVKw42D75jNF1U1jtdrXoBV4CECjXvAkt15eQ2J7HWBhj/6CdlbvByrSXHgEi1OyB9WdoJFIDmqvr9Qmy2ethuNvmElVJmsgpYiig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kBTHrPAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EF5C19423;
	Tue, 31 Mar 2026 16:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975513;
	bh=R5s/6r/yTdmlX+TVkxnTFZufWEe/AVXDjabfCnGBkJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kBTHrPAe4Z3LImnztpTTCMEF1lrGNOkTOuoynGfBqCSnugtshlegAiVHhHYnzcxYF
	 VYXi9mVL7hgB6dV4PK8EycDU4cDWvCTjZ1YkdBqI4bUhZ+14U50lp/YKT7NEbCJVRi
	 2cBpxAgLXuc+zsrhVZ2AKIJ1YYdPIFUm86qtESaI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tuo Li <islituo@gmail.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 324/342] dmaengine: idxd: fix possible wrong descriptor completion in llist_abort_desc()
Date: Tue, 31 Mar 2026 18:22:37 +0200
Message-ID: <20260331161810.834897812@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-231961-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 7E4E336D554
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tuo Li <islituo@gmail.com>

[ Upstream commit e1c9866173c5f8521f2d0768547a01508cb9ff27 ]

At the end of this function, d is the traversal cursor of flist, but the
code completes found instead. This can lead to issues such as NULL pointer
dereferences, double completion, or descriptor leaks.

Fix this by completing d instead of found in the final
list_for_each_entry_safe() loop.

Fixes: aa8d18becc0c ("dmaengine: idxd: add callback support for iaa crypto")
Signed-off-by: Tuo Li <islituo@gmail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Link: https://patch.msgid.link/20260106032428.162445-1-islituo@gmail.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/idxd/submit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index 6db1c5fcedc58..03217041b8b3e 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -138,7 +138,7 @@ static void llist_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
 	 */
 	list_for_each_entry_safe(d, t, &flist, list) {
 		list_del_init(&d->list);
-		idxd_dma_complete_txd(found, IDXD_COMPLETE_ABORT, true,
+		idxd_dma_complete_txd(d, IDXD_COMPLETE_ABORT, true,
 				      NULL, NULL);
 	}
 }
-- 
2.53.0




