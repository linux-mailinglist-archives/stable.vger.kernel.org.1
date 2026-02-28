Return-Path: <stable+bounces-221192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLhqN8pIo2l//AQAu9opvQ
	(envelope-from <stable+bounces-221192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:58:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C561C7A5B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9538134FD6E2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BB334251B;
	Sat, 28 Feb 2026 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4sGntOB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858F3375222;
	Sat, 28 Feb 2026 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301549; cv=none; b=AsNkLMHI5dyxzhYgQ9qAGvouijodkoFgqz214ZMUArGUfAvv2NOjNxjELP0QS4UrCeI/xpD81db6Wa2qCLI7u182VR3b2Q3IHri3Ytwec12JWX/sAi58mvWSy3Z+ES17k0v7g65pg3uM30GfhVLtc8peigJRhbSGglQdgURczKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301549; c=relaxed/simple;
	bh=QHca3r2l3zROSicefrNcatC2gyxEbz5tmBfbzmPLDEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEHX/JxFlHH7GJv+DyM1+t4zxFrNnDUKq7KsmwUZohtvJpEzAbKT7eTRmZr0gjD1XK6aXhRYdGDhLbyXcFURCEuVT7uqyuOg3jPt6kVVA+H31aMEkXPeDEowT44B34U827iijI6nn2PLadBiXngbrDIv904CUBO4UIUoNOdAzLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4sGntOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8EBC19425;
	Sat, 28 Feb 2026 17:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301549;
	bh=QHca3r2l3zROSicefrNcatC2gyxEbz5tmBfbzmPLDEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z4sGntOBnlzZIAJ9BQ3tk/qlQvgyImc2qWPY6RTcMgyBfAI+XJkxFneAsZt1gDG8p
	 AEr0Olgiy3h9d50sXDZGC0G3FbzyX4gJ8o/0Tvpz5fpHa8ZW2DqZPxx2V95zSwOUAZ
	 yuYPiMhExVRHg6qvpH2PWmjle4DEoYkJ3V8NVTO4CV0MBbW/TAFo213674Is85pFd0
	 6AuxdEQiagR+Gy7iZJgDE7+DXTE005W2IamERE3clr2FPhfrGLRJrr0W9syAEqtfa4
	 QvX4Du5CcPs+NSbioLkS3TkbMxRh/PjvqvQwzTPzqPvRE7bgn1J1qwL1dKlF6j1PqM
	 EdyeBGlnf3ZMQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 732/752] net: ethernet: ec_bhf: Fix dma_free_coherent() dma handle
Date: Sat, 28 Feb 2026 12:47:23 -0500
Message-ID: <20260228174750.1542406-732-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-221192-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49C561C7A5B
X-Rspamd-Action: no action

From: Thomas Fourier <fourier.thomas@gmail.com>

[ Upstream commit ffe68c3766997d82e9ccaf1cdbd47eba269c4aa2 ]

dma_free_coherent() in error path takes priv->rx_buf.alloc_len as
the dma handle. This would lead to improper unmapping of the buffer.

Change the dma handle to priv->rx_buf.alloc_phys.

Fixes: 6af55ff52b02 ("Driver for Beckhoff CX5020 EtherCAT master module.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Link: https://patch.msgid.link/20260213164340.77272-2-fourier.thomas@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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


