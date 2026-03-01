Return-Path: <stable+bounces-222386-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLHrMdiho2mRIwUAu9opvQ
	(envelope-from <stable+bounces-222386-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:18:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF6A1CD68E
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6DFB304B050
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601E8307AC7;
	Sun,  1 Mar 2026 02:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2Xhzpi1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246182EE262;
	Sun,  1 Mar 2026 02:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330749; cv=none; b=HMok06aVE0/bgi3hCMBNskjpMW5HrfJ+qswaibxapNLvG2469982FQ2X7xM1KA2Y4UnPNMRmBdQb4YqVuv2zKSgrRB+wG5w3AVjBEgIJNm6dwjQkF1RjWYOJPd06pUAYVDDwnuba5s8vcdCJ0r2oyucxVWx/s6iBeYvnPwahv/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330749; c=relaxed/simple;
	bh=KAoL1cx2EuRA7/IhGFw6mkGmsTeE2YWJNJJwGTPnKfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J756BEfEnSS/BysOCGtPaxSTNykJJ1koo0LyqIJV/va7E9NmmHQ/cl8AmmQ9acgsbZQuBP78Nhi1ah8ItepVyIm+RA4NR7SVLqZLQQOwcoRJ99Iv4u+QW5azcDmk/4rnLRJjv8QMUpn0V7GbdUADqr1/mABNK1bim6D7VTxvPhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2Xhzpi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D25C19421;
	Sun,  1 Mar 2026 02:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330749;
	bh=KAoL1cx2EuRA7/IhGFw6mkGmsTeE2YWJNJJwGTPnKfs=;
	h=From:To:Cc:Subject:Date:From;
	b=m2Xhzpi1CAJEZRtOXh0NyZ/UgSnI5ttuMyn0h1oFF9LE6bBC9k1RUO14rohleKBkH
	 ERa5mIxDYj5aF+EONvIVZm22EdDcK1cpZUrX+ZGqvNgyb+Z2TUJW6OJKNXRfOF7iqZ
	 ErJCrckA2OV6PuKE7wGz8+GkLFvaif/P8RNmv51KbIS9ZJj1/KWUVKrdVS0BjHvIX7
	 /8dsJvLlv89rS1BmMza4dFuFeGAWTRJRnvUkUhiEGWTlEGr+xyehV+P7MFr4rhhc+4
	 r0ejSe0bTuIYzvCozI/zFHWywkRz3XvQwTmY2M0zPjLW5uuLlnMI9CeqfEzKrzZJI5
	 bZcUNalITWzyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	fourier.thomas@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Subject: FAILED: Patch "net: ethernet: ec_bhf: Fix dma_free_coherent() dma handle" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:05:47 -0500
Message-ID: <20260301020547.1734617-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222386-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 0EF6A1CD68E
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
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





