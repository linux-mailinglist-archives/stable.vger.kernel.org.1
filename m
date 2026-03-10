Return-Path: <stable+bounces-224072-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mNeDDKD+r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224072-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:21:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AFD24A753
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02F663209205
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42572387583;
	Tue, 10 Mar 2026 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+6sZniA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066902BF3E2;
	Tue, 10 Mar 2026 11:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141207; cv=none; b=a8dwyuNR3vTTIH1hRkivdDhOmVdRFdQJWI8EkzQWrQvpVFnrSIQ7ux2/MUSXvzS2ZjDBfSwLllHTUp7c2JkqPktAFqNABxTx2u3z3iB+J0B6zkz9FsmVas9jpRtZEcu4+p5sMN5rdtDruE+wP8ZowmVumUto3dHZxgB18GkJhR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141207; c=relaxed/simple;
	bh=GV6ZUhs+bT82GMQ5cPlMm9yXf+0y9AI6JYxLmgXdr7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOxblpDajMiVRl65DOgtSvGUdLlgu2fS8akYIAm9Ui2mVe+f1eaRfv3sLfwhvlGaob/J8H3zby9drFRIi2YtAp3LUx21QlLPDkZPyNMjzpBgmKFFB0D9IQMgMB4opCddT6VzJeBZZoiDjU0TyrNLev7X1IJE81BmExB1VJJ21PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+6sZniA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D037C2BCB0;
	Tue, 10 Mar 2026 11:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141206;
	bh=GV6ZUhs+bT82GMQ5cPlMm9yXf+0y9AI6JYxLmgXdr7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U+6sZniA9yWPIa45nAapHyNzVnU5xnrECPm57inD1WRFZxNNa/20d67bgrpcQZc4f
	 w1K1jABDfLQO9xiV5rN8E2HT2S6tp5WtfvqRL3N9SBspw147L0lCOgRryy9P6L077e
	 UI+rLZQd0fA/fO3M6U0OsDbqOnrq+LDAlmpLUioM9LgdN4bIqK4XakyxtF1x/t3T3f
	 OrPF3a3IId69HZX7BijQZnYhuJR6ER19j1G2Of3isr4dgwbXRmncmYJsnWiLdQAbEX
	 3X55erdHaXRKUHj69EbLjGFj2JvEG3bURqo79XhiJMP3uHevaq7J2Wt6dVex0owngo
	 WtqgpY+aQyK2g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Alper Ak <alperyasinak1@gmail.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 207/311] crypto: ccp - Fix use-after-free on error path
Date: Tue, 10 Mar 2026 07:04:14 -0400
Message-ID: <0f8187b30400ca0948c33092fe9d374a18571b37.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 89AFD24A753
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,amd.com,gondor.apana.org.au,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-224072-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Action: no action

From: Alper Ak <alperyasinak1@gmail.com>

[ Upstream commit 889b0e2721e793eb46cf7d17b965aa3252af3ec8 ]

In the error path of sev_tsm_init_locked(), the code dereferences 't'
after it has been freed with kfree(). The pr_err() statement attempts
to access t->tio_en and t->tio_init_done after the memory has been
released.

Move the pr_err() call before kfree(t) to access the fields while the
memory is still valid.

This issue reported by Smatch static analyser

Fixes:4be423572da1 ("crypto/ccp: Implement SEV-TIO PCIe IDE (phase1)")
Signed-off-by: Alper Ak <alperyasinak1@gmail.com>
Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/ccp/sev-dev-tsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev-tsm.c b/drivers/crypto/ccp/sev-dev-tsm.c
index 40d02adaf3f6d..7ad7e7a413c0f 100644
--- a/drivers/crypto/ccp/sev-dev-tsm.c
+++ b/drivers/crypto/ccp/sev-dev-tsm.c
@@ -378,9 +378,9 @@ void sev_tsm_init_locked(struct sev_device *sev, void *tio_status_page)
 	return;
 
 error_exit:
-	kfree(t);
 	pr_err("Failed to enable SEV-TIO: ret=%d en=%d initdone=%d SEV=%d\n",
 	       ret, t->tio_en, t->tio_init_done, boot_cpu_has(X86_FEATURE_SEV));
+	kfree(t);
 }
 
 void sev_tsm_uninit(struct sev_device *sev)
-- 
2.51.0


