Return-Path: <stable+bounces-220556-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IGgFxNOo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220556-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:20:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5A61C83F1
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9BA6E310F536
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0403D6CA6;
	Sat, 28 Feb 2026 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENj86LYz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1673D751D;
	Sat, 28 Feb 2026 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300437; cv=none; b=YYKcrrWDUfn8Gyolr1hmyjyq5s2hoY5F0KoX3V0Zab4YQjzZr45w0w2WjAj6tAFohe8cdbSEbGLygYEHqoiumOmBUhE10JutX+BmXbn6T+5TMFFws5JfkRuXTfq0fyvba3SArLPWsG3tHvZIwLr2pOd649Valx7urMZHXKOBFMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300437; c=relaxed/simple;
	bh=9Blwvyplt0VKUoH7HlX+1l3YnzTFHwZ8qOvdIEe2KfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSbyYyjS3Qd9g4hbMdA9sDCuYtVKcwaXpsZakoUMdo+ClaIZDA8Of55B4H1yWW9PKN4KZY1jK+8rAN2Vd1XIKr51gdwUZwMFGYM/nnWsLgNm60iQRLT6ae3b9hRG+J1Rt6WihdJBFtPKawvOjDBdFRemeiBceAwkuco8MT9XMCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENj86LYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D82C116D0;
	Sat, 28 Feb 2026 17:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300437;
	bh=9Blwvyplt0VKUoH7HlX+1l3YnzTFHwZ8qOvdIEe2KfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ENj86LYzy2URA2Te6SFkV+R+NW9AFRM64vSGJbKubeNLKpOGv+Ve3pY2DqqQpS8s9
	 QPTFTkNj5a8TBXR/+s+JzHXABPqSRCswtsr80+3d1PQWobGXVvy/e63a4e22PG9/r2
	 GXK1SE+IppOH6SdTcAP2blLy8P4msrptlnrxrGo7EcUmIrGy41tXHSQzbGi0RZmEx6
	 DdxsB4Wm8usUIXgJcv0vrP61uDEu35T4h2w7uob5h8x9ujrNX0HK/e54eebbRQ7cu+
	 mxJ88E7SWnyurD5iwUqolj6h8IroUXoKF02H+VDd2fRnJ+w2a3GnXYdguko0u8Yzco
	 FKPxUSkrmSXJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 477/844] tls: Fix race condition in tls_sw_cancel_work_tx()
Date: Sat, 28 Feb 2026 12:26:30 -0500
Message-ID: <20260228173244.1509663-478-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,queasysnail.net];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220556-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,queasysnail.net:email,msgid.link:url]
X-Rspamd-Queue-Id: 8C5A61C83F1
X-Rspamd-Action: no action

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit 7bb09315f93dce6acc54bf59e5a95ba7365c2be4 ]

This issue was discovered during a code audit.

After cancel_delayed_work_sync() is called from tls_sk_proto_close(),
tx_work_handler() can still be scheduled from paths such as the
Delayed ACK handler or ksoftirqd.
As a result, the tx_work_handler() worker may dereference a freed
TLS object.

The following is a simple race scenario:

          cpu0                         cpu1

tls_sk_proto_close()
  tls_sw_cancel_work_tx()
                                 tls_write_space()
                                   tls_sw_write_space()
                                     if (!test_and_set_bit(BIT_TX_SCHEDULED, &tx_ctx->tx_bitmask))
    set_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask);
    cancel_delayed_work_sync(&ctx->tx_work.work);
                                     schedule_delayed_work(&tx_ctx->tx_work.work, 0);

To prevent this race condition, cancel_delayed_work_sync() is
replaced with disable_delayed_work_sync().

Fixes: f87e62d45e51 ("net/tls: remove close callback sock unlock/lock around TX work flush")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://patch.msgid.link/aZgsFO6nfylfvLE7@v4bel
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/tls/tls_sw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9937d4c810f2b..b1fa62de9dab5 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2533,7 +2533,7 @@ void tls_sw_cancel_work_tx(struct tls_context *tls_ctx)
 
 	set_bit(BIT_TX_CLOSING, &ctx->tx_bitmask);
 	set_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask);
-	cancel_delayed_work_sync(&ctx->tx_work.work);
+	disable_delayed_work_sync(&ctx->tx_work.work);
 }
 
 void tls_sw_release_resources_tx(struct sock *sk)
-- 
2.51.0


