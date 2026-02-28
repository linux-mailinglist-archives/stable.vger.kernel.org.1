Return-Path: <stable+bounces-220742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DPsJilAo2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:21:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5F81C6E04
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39FCB30C455B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072764025A4;
	Sat, 28 Feb 2026 17:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKnq4Q+P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE631492195;
	Sat, 28 Feb 2026 17:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300622; cv=none; b=jor7D2ylwh27SKLzSDFNDZGxZe6zsbLiM6mOSC1CzMEL9t+wHYKKiWhLge71ZnInrcTTwqIbY2fu1RlOhi2d7dfkNwlbj124VKQaegGX52b6rdtmXnjuq/LP7iQ6iZF0m8mRQYb1/DFqA2mvtHpAJRd68d8ZoblhC8PYc+V6tqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300622; c=relaxed/simple;
	bh=Gyu1YR+zMuhecVW92199mZE4m5Eie57u1ZQCuNNabPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUrBYb/8xTG08vn/3cgh2N7Z9js4NjCX2JUEL/iV9NlRdPvZs8U0KFmS6hVOYlU8QNelIyRKfIYqWY6qJ1LONvk79OJzXkFBWYd+Y9eEu3aauXBnoyLGs9gEPU4z5uxccSTEnVjBOFdEEmQnEvOGywbLEi9/wfHo8Tt/MXizU2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKnq4Q+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEA3C2BC87;
	Sat, 28 Feb 2026 17:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300622;
	bh=Gyu1YR+zMuhecVW92199mZE4m5Eie57u1ZQCuNNabPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CKnq4Q+PWaIKAx02K8DiFn52SLmQtCB5B7QpZ+vJTOAn4iHoZY8xD0HI22Bjou+EW
	 +/JP0hoLUY/YsXYZgrAhr+PscL0kKTaw0PrcBA/iGtndTLFPHMoblgSfOt60wOgqa1
	 FiJIbKzzJstZQpgU+sihIheDo4OvbvWCsCzKOkGWFTGg88NBMNbGjZYVpMAdTwfXab
	 chAXQHQsut42C7HKtRJ0IN3IIHZHMb9aMMrmcX1ZGIDt5hhN8MBxghlxIBE+AVqTAF
	 cceP1rPFonNHHvRZ27yUHWIZ4XosrZtYvT/XhwLhbSavRz+8f+QPxsfXVLzEc6Vv5O
	 brVd/9ei+shyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Janne Grunau <j@jannau.net>,
	Sven Peter <sven@kernel.org>,
	Neal Gompa <neal@gompa.dev>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 663/844] mfd: macsmc: Initialize mutex
Date: Sat, 28 Feb 2026 12:29:36 -0500
Message-ID: <20260228173244.1509663-664-sashal@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220742-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jannau.net:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA5F81C6E04
X-Rspamd-Action: no action

From: Janne Grunau <j@jannau.net>

[ Upstream commit 414f65d6736342c77d4ec5e7373039f4a09250dd ]

Initialize struct apple_smc's mutex in apple_smc_probe(). Using the
mutex uninitialized surprisingly resulted only in occasional NULL
pointer dereferences in apple_smc_read() calls from the probe()
functions of sub devices.

Cc: stable@vger.kernel.org
Fixes: e038d985c9823 ("mfd: Add Apple Silicon System Management Controller")
Signed-off-by: Janne Grunau <j@jannau.net>
Reviewed-by: Sven Peter <sven@kernel.org>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Link: https://patch.msgid.link/20251231-macsmc-mutex_init-v2-1-5818c9dc9b29@jannau.net
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/macsmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/macsmc.c b/drivers/mfd/macsmc.c
index e3893e255ce5e..3015e8d36d6e5 100644
--- a/drivers/mfd/macsmc.c
+++ b/drivers/mfd/macsmc.c
@@ -413,6 +413,7 @@ static int apple_smc_probe(struct platform_device *pdev)
 	if (!smc)
 		return -ENOMEM;
 
+	mutex_init(&smc->mutex);
 	smc->dev = &pdev->dev;
 	smc->sram_base = devm_platform_get_and_ioremap_resource(pdev, 1, &smc->sram);
 	if (IS_ERR(smc->sram_base))
-- 
2.51.0


