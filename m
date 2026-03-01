Return-Path: <stable+bounces-221720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBQdASaoo2mWJAUAu9opvQ
	(envelope-from <stable+bounces-221720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:44:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BF41CDDE8
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4CAB43257FBE
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880602DC350;
	Sun,  1 Mar 2026 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWyD63Z9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF3B13B58A;
	Sun,  1 Mar 2026 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328976; cv=none; b=ezLoxdaRSxvMAxDNYWYyQwUBipth9plrMEkFON5v1/xctWYrbSwzc37c+qx0f38hKSc+mFWG6MoIBXlTuYMkvcdH+Ylj2C29wMhFsQo+hTVb9OCGs3/K1PoXngvsGwy8JRhq5qSubthnnuOO09LmZyJcaCTDjhVzwytiIBYWE+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328976; c=relaxed/simple;
	bh=QtjNuD//9YELcVnrZEJeLGQvrXeQIUP9U0k2jUI711Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vs0oVY4xZS9jOokYYTZQMCIMZgAGmTtslqklccaKVQGwZf4UBwhibCS9An7EqcpJkfRdwQYxphKAMXta2b9ITGV6UhpW6jJkgGOjvNDYNbpi2ov/fnS/Pa9ll3ECVGvm6RkbEODaem6RY4JcAW2FWUf36K++oj8FeQ8QYLDgzlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWyD63Z9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46B7C19421;
	Sun,  1 Mar 2026 01:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328976;
	bh=QtjNuD//9YELcVnrZEJeLGQvrXeQIUP9U0k2jUI711Y=;
	h=From:To:Cc:Subject:Date:From;
	b=WWyD63Z9rgt9ejx7u8kYA8fXQscVvwuSrn/5H2cFqYl4JrbljHPbYRrETu+hjYGfI
	 QIvXj/ZywMDlMR3dE+BnhNGDXXXpa6hqhad5L6bV9N/POzuMCLbECRSyuc1KeXhBGK
	 HkqtXsOtLRuHDGwWduFLnNZ1YxbMlgw9L+Sjj3mRg96u1Wg+9YUVqJlAcChYUCLZK0
	 A5CBgaYijiX1wkzr87WETFcYhvpu6FjIoMgsdKUQJUkV2SupB+mCCG9DujEFlLBHBi
	 mMMPMFJ4cceojUFU26aGh385ZfBJpaC255MvpEP1zR3Znsv0/klOZFYACae6ZjYPZt
	 QAay989b1bqDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	linusw@kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Subject: FAILED: Patch "ata: pata_ftide010: Fix some DMA timings" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:36:14 -0500
Message-ID: <20260301013614.1696150-1-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221720-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59BF41CDDE8
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ff4a46c278ac6a4b3f39be1492a4568b6dcc6105 Mon Sep 17 00:00:00 2001
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 3 Feb 2026 11:23:01 +0100
Subject: [PATCH] ata: pata_ftide010: Fix some DMA timings

The FTIDE010 has been missing some timing settings since its
inception, since the upstream OpenWrt patch was missing these.

The community has since come up with the appropriate timings.

Fixes: be4e456ed3a5 ("ata: Add driver for Faraday Technology FTIDE010")
Cc: stable@vger.kernel.org
Signed-off-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/pata_ftide010.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/pata_ftide010.c b/drivers/ata/pata_ftide010.c
index c3a8384c3e04d..c41da296eb389 100644
--- a/drivers/ata/pata_ftide010.c
+++ b/drivers/ata/pata_ftide010.c
@@ -122,10 +122,10 @@ static const u8 mwdma_50_active_time[3] = {6, 2, 2};
 static const u8 mwdma_50_recovery_time[3] = {6, 2, 1};
 static const u8 mwdma_66_active_time[3] = {8, 3, 3};
 static const u8 mwdma_66_recovery_time[3] = {8, 2, 1};
-static const u8 udma_50_setup_time[6] = {3, 3, 2, 2, 1, 1};
+static const u8 udma_50_setup_time[6] = {3, 3, 2, 2, 1, 9};
 static const u8 udma_50_hold_time[6] = {3, 1, 1, 1, 1, 1};
-static const u8 udma_66_setup_time[7] = {4, 4, 3, 2, };
-static const u8 udma_66_hold_time[7] = {};
+static const u8 udma_66_setup_time[7] = {4, 4, 3, 2, 1, 9, 9};
+static const u8 udma_66_hold_time[7] = {4, 2, 1, 1, 1, 1, 1};
 
 /*
  * We set 66 MHz for all MWDMA modes
-- 
2.51.0





