Return-Path: <stable+bounces-225003-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH8zE/wes2l/SQAAu9opvQ
	(envelope-from <stable+bounces-225003-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:15:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF1F278ACA
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5804B3017DD5
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A60F26F288;
	Thu, 12 Mar 2026 20:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GjGDdfc6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F185E1F4181;
	Thu, 12 Mar 2026 20:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346552; cv=none; b=XPsVEtSCSpboEmPp4t5BWvxoMiki3y55NlY01Fe83MHmVz+Sz/XnFWtrS7SEzRTeKvJtwCbLPuuG9+/ekz6DjmVCSKVRtZbDxbAS/jESyfRW/kBxLMr6P3oJxg3in4PP4WI4M+xD27NJPLzIyuPN1lVYr1wNDSHPAMXO04HL2KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346552; c=relaxed/simple;
	bh=QUCUlg1RkMi08nkftcglRENb9XBfqhACxMPskaJ6Ucc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7kyyB83BQUFgTBGYlH/G2p5PwG8lnpeZA4xp1sYWVEWkbMItTm5uZfhkaJZNW6KjmO8CtSWZlQHqI+tMGt4CzkmcxZztOLauC/yt8DNMgCn0hnu7XsN/Y8law45QZnsvB6xzV6HHXSH4e6FNKBtBTARhtjiNdX6clzrlu3+tfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GjGDdfc6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F7EC4CEF7;
	Thu, 12 Mar 2026 20:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346551;
	bh=QUCUlg1RkMi08nkftcglRENb9XBfqhACxMPskaJ6Ucc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GjGDdfc6ODHX2i/NnXf5UcfX9zuJIJ3K0lA9hkmcZW4q6fUtJQ+uBzDwk/QoRjYNX
	 QJFusei4grWRQAHIQEf//IxLjb2GL+UAzO3CLh6kA5oEKysJYM1xj+buN9+JkI60vC
	 NXlZuZ83AQWLCCrV1eYmAcXAbHxxx8iQGdDjpqv4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peng Fan <peng.fan@nxp.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 069/265] mailbox: Use dev_err when there is error
Date: Thu, 12 Mar 2026 21:07:36 +0100
Message-ID: <20260312201020.706642804@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225003-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,nxp.com,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EAF1F278ACA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit 8da4988b6e645f3eaa590ea16f433583364fd09c ]

Use dev_err to show the error log instead of using dev_dbg.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Stable-dep-of: fcd7f96c7836 ("mailbox: Prevent out-of-bounds access in fw_mbox_index_xlate()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/mailbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 693975a87e19e..4c27de9514e55 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -322,7 +322,7 @@ static int __mbox_bind_client(struct mbox_chan *chan, struct mbox_client *cl)
 	int ret;
 
 	if (chan->cl || !try_module_get(chan->mbox->dev->driver->owner)) {
-		dev_dbg(dev, "%s: mailbox not free\n", __func__);
+		dev_err(dev, "%s: mailbox not free\n", __func__);
 		return -EBUSY;
 	}
 
@@ -413,7 +413,7 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index)
 	ret = of_parse_phandle_with_args(dev->of_node, "mboxes", "#mbox-cells",
 					 index, &spec);
 	if (ret) {
-		dev_dbg(dev, "%s: can't parse \"mboxes\" property\n", __func__);
+		dev_err(dev, "%s: can't parse \"mboxes\" property\n", __func__);
 		return ERR_PTR(ret);
 	}
 
-- 
2.51.0




