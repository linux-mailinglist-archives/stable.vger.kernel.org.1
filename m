Return-Path: <stable+bounces-221557-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLsaLxGXo2neHgUAu9opvQ
	(envelope-from <stable+bounces-221557-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:32:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DF11CAE1E
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57231302A9C6
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F017E2BE033;
	Sun,  1 Mar 2026 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/HJ5NhG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B3B18E02A;
	Sun,  1 Mar 2026 01:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328572; cv=none; b=Y1hk0S+PM0mr0oq24B2BL2hvaRjRgQnGU0y0QT3ekr4l/raBybl3MxyIehEOV5LP8eeCUmRfQNWH8WsHONRgSXq0FG1p+7gm18WrfuzN3fXP2/b6psUtMxoi7Pp5q90tg9FD6m6eb44zrhbuq1lPgCg2RHdS0+bJI0KNvE+1CCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328572; c=relaxed/simple;
	bh=M+zI4eYL7YLs3m4YazUH2ZwRBQXskG7rZsEymWKFGeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cviucObxooDnTAqgk6wPX+wTMSdmKmM0UeFXvsEKLjW5ED36+a2UIwlpxKhNKCryW2Y0XpgA2dMLURgHyiZWkIqJNbpfQATWp/GPVrM7qY5LBAqX+QO+2iTNbq5jfO7sAHeYRKyvTtBYBTiLIg5mAVEsCTMte2cBECNiKN22MGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/HJ5NhG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B342C19421;
	Sun,  1 Mar 2026 01:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328572;
	bh=M+zI4eYL7YLs3m4YazUH2ZwRBQXskG7rZsEymWKFGeA=;
	h=From:To:Cc:Subject:Date:From;
	b=r/HJ5NhGfeb2lV3uiIhUi490OueYp2yGlI7QnPdNG5OjAIqQRx3TDDVdGhTbcZBFQ
	 qJb4xRllYioCmwDqFE8a6H/B3rmdYd8ESUPJX50i1AwhH0gmu95QrHeVCs1q/fQYVw
	 9gmonsMLaH93MoROAB/n5fdsqkMxVghGzA16t/yWBITcA6nnsFGn6N35+YypeZmsWo
	 tYrjLxWPgRkP5vZPoaf3YRAAO4M8H12+vbtiKGSfVuywfCtdMRit5G8rKqLM0SG0qA
	 yqL2JZYcKeGtJkVZXiSVuTwPg08Y/eHeGsaih6PBJwqNHrLfiLfAp6wVZfl1qgsQNg
	 uUWEt9wYqNvGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	fourier.thomas@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Subject: FAILED: Patch "net: ethernet: ec_bhf: Fix dma_free_coherent() dma handle" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:29:30 -0500
Message-ID: <20260301012930.1687295-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221557-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 66DF11CAE1E
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ffe68c3766997d82e9ccaf1cdbd47eba269c4aa2 Mon Sep 17 00:00:00 2001
From: Thomas Fourier <fourier.thomas@gmail.com>
Date: Fri, 13 Feb 2026 17:43:39 +0100
Subject: [PATCH] net: ethernet: ec_bhf: Fix dma_free_coherent() dma handle

dma_free_coherent() in error path takes priv->rx_buf.alloc_len as
the dma handle. This would lead to improper unmapping of the buffer.

Change the dma handle to priv->rx_buf.alloc_phys.

Fixes: 6af55ff52b02 ("Driver for Beckhoff CX5020 EtherCAT master module.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Link: https://patch.msgid.link/20260213164340.77272-2-fourier.thomas@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/ec_bhf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ec_bhf.c b/drivers/net/ethernet/ec_bhf.c
index 67275aa4f65b2..0c86cbb0313c3 100644
--- a/drivers/net/ethernet/ec_bhf.c
+++ b/drivers/net/ethernet/ec_bhf.c
@@ -423,7 +423,7 @@ static int ec_bhf_open(struct net_device *net_dev)
 
 error_rx_free:
 	dma_free_coherent(dev, priv->rx_buf.alloc_len, priv->rx_buf.alloc,
-			  priv->rx_buf.alloc_len);
+			  priv->rx_buf.alloc_phys);
 out:
 	return err;
 }
-- 
2.51.0





