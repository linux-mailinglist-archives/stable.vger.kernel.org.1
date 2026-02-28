Return-Path: <stable+bounces-220707-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LgcNkZUo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220707-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:47:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4589C1C885C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2467360EE35
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C613FB865;
	Sat, 28 Feb 2026 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5qFPGiX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FB148C8A5;
	Sat, 28 Feb 2026 17:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300586; cv=none; b=NKYGWObLTohWPWo9XdYESBJ75mW5HSDSpeRu8Fh46zuGrDzDIivkLIERnMmv222xTD8e84UrbkCG8/8ZjNJTOSaTwviCGu7FOWZzsZ1JGWM3ZoPJn0cUgmZvh8h75gae5IaUkcEZAK9AMia/UjvL5xhzcoREIE2ACOOKspVYjgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300586; c=relaxed/simple;
	bh=FFPWF6NdzOOfi06Yglh6lxiKLJrLZ7+L/ZBg1OojEiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThVP4Bix8dbx2ZW9Yc/JC17K9Gb9O+B1kkaGQ5LEj9J+FcDWSTh95wezVJDyBa0OjPdnkCjfKlk2lw8QXrRYIzyfUZ3Syng2FqqW1GlsrLaIr0UDQnq6JHx8onmfMFOPOpJ/b3NBD6NbLSLU6qyi+AKZXoBPAd2l0VNveJywn4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5qFPGiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E043C19423;
	Sat, 28 Feb 2026 17:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300586;
	bh=FFPWF6NdzOOfi06Yglh6lxiKLJrLZ7+L/ZBg1OojEiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5qFPGiX5pkZU5Ht3QI/j0VWHfC6uCvZjABR1mqdnCrpulyU7p6nXwO2T8xNi1QJr
	 j2gZUgZcNCl1KHTQBMrGC3qlgXpCIOGdH/uT17GP+FoyS5bAdfxVcUC6TfNrxZPAP9
	 Elk/OcmW5QVv2g+u6K1/9MvbrzsfT7oczhK8RAWstQy8F8Y44RIkRHuH/OS80GvwQX
	 N+o1zHeCwdLSfm5VVvsZdKPzU+dHLJwFON5OY7fF0HgFbeGLeI01Go3SC68Cv4SMtW
	 0eIykGjHiiC8lOmjKiOowiRsHnBQFqhyQIb37lmEDNmp9HPU2bs/4FpRAATCiItqpn
	 vY7znTevIVy8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dirk Behme <dirk.behme@de.bosch.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 628/844] drm/tyr: fix register name in error print
Date: Sat, 28 Feb 2026 12:29:01 -0500
Message-ID: <20260228173244.1509663-629-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-220707-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bosch.com:email]
X-Rspamd-Queue-Id: 4589C1C885C
X-Rspamd-Action: no action

From: Dirk Behme <dirk.behme@de.bosch.com>

[ Upstream commit 793e8f7d52814e096f63373eca643d2672366a5a ]

The `..IRQ..` register is printed here. Not the `..INT..` one.
Correct this.

Cc: stable@vger.kernel.org
Fixes: cf4fd52e3236 ("rust: drm: Introduce the Tyr driver for Arm Mali GPUs")
Link: https://lore.kernel.org/rust-for-linux/A04F0357-896E-4ACC-BC0E-DEE8608CE518@collabora.com/
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
Link: https://patch.msgid.link/20260119070838.3219739-1-dirk.behme@de.bosch.com
[aliceryhl: update commit message prefix]
[aliceryhl: add cc stable as per Miguel's suggestion]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tyr/driver.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 0389c558c0367..3047fd12fd849 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -76,7 +76,7 @@ fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
         dev_err!(dev, "GPU reset failed with errno\n");
         dev_err!(
             dev,
-            "GPU_INT_RAWSTAT is {}\n",
+            "GPU_IRQ_RAWSTAT is {}\n",
             regs::GPU_IRQ_RAWSTAT.read(dev, iomem)?
         );
 
-- 
2.51.0


