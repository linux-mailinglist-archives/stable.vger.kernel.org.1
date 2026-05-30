Return-Path: <stable+bounces-258508-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D6BO+0nG2rM/ggAu9opvQ
	(envelope-from <stable+bounces-258508-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:09:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BF7611200
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBCA5300144F
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382A0352027;
	Sat, 30 May 2026 18:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DbZI7CGS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0242531F98D;
	Sat, 30 May 2026 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164586; cv=none; b=ED6yJz9sVsuz5dqYccUSrXJcg8rzGZ7D3HYvP3mcHZfV5RHjIBFKL03hEuFdvpyFAdvGxLYcsphYrgAqNbvqXQfuvf14gz1QjKfBss7MhX6tu6JfXKN3k3gbHVI5PGHNQY1FRxy/CgwFKCeLDK0Jv7xVvILdKqACKwWR7RboCcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164586; c=relaxed/simple;
	bh=jGkSFU+PjOSesU16Z2n8wg1NGTfh8WxHRp7stX+qfDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2+B2Mu+/iRUGgeO0zPsqoiTagUSCGp46Uqyy3lPkefcqOB1Nx/e7TKMsxydSeJuBeLqE+iIl3jd+3XKGO0bexFcK5TxFGCmIHtwLrWqY0IITtPSFlGZ+ifNU45AEGVxlfQLtGksvf8TA3hUaqgjkun2rJq+uhc5/U9qQm2kMtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DbZI7CGS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED66F1F00893;
	Sat, 30 May 2026 18:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164584;
	bh=t/Agsxf2cMVZlFcPmvv0NiKuMnjQprv7gymQhW+tBuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DbZI7CGStlcSzuQEWXXwcDvRrLgtDTIw312eJ6hkhT3o7pXq8Kqyil/VmCA0TW7SH
	 IwnulXqIP0maWTws3uuQED4Ilqzt9ceLq7NLcXbg41MJErh9j1oG7ZEZG1W7Dgs2MN
	 capmPdha2q6NFobjy7EHZCoBKQzanfw/r+JgwmeE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 599/776] mailbox: add sanity check for channel array
Date: Sat, 30 May 2026 18:05:13 +0200
Message-ID: <20260530160255.516864397@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,sang-engineering.com,glider.be,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258508-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A3BF7611200
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit c1aad75595fb67edc7fda8af249d3b886efa1be9 ]

Fail gracefully if there is no channel array attached to the mailbox
controller. Otherwise the later dereference will cause an OOPS which
might not be seen because mailbox controllers might instantiate very
early. Remove the comment explaining the obvious while here.

Fixes: 2b6d83e2b8b7 ("mailbox: Introduce framework for mailbox")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/mailbox.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 090795c1b65db..363eaf3c962ec 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -484,8 +484,7 @@ int mbox_controller_register(struct mbox_controller *mbox)
 {
 	int i, txdone;
 
-	/* Sanity check */
-	if (!mbox || !mbox->dev || !mbox->ops || !mbox->num_chans)
+	if (!mbox || !mbox->dev || !mbox->ops || !mbox->chans || !mbox->num_chans)
 		return -EINVAL;
 
 	if (mbox->txdone_irq)
-- 
2.53.0




