Return-Path: <stable+bounces-222140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBGXEcqdo2k3IQUAu9opvQ
	(envelope-from <stable+bounces-222140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:00:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF2F1CC93E
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8080B30F8159
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0240B30EF92;
	Sun,  1 Mar 2026 01:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OV1ynq+7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AEF2C08AD;
	Sun,  1 Mar 2026 01:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330000; cv=none; b=Qd8POn9YnLjfIUi59t0K1557sqHx1qWYyOsYpza9B6oML2jipQNfbEmOdV7ao/vc8/9mEpVa/E/hXOdINJZ0fSg98jgb+KJENLrSkcqWt6JmwIdoySKTNdCipBn+8Az0VAUiC4BrRuuF7YBhTqgBgGcfYpIF6rq29DLWVS2KK9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330000; c=relaxed/simple;
	bh=R5tQpyvkOahvTrujdWQ05xw2oehMgcO2zg2LLFExlho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RhjjGau5pX21OiYdaraw6nUvtWuLEtYx3ViU4Jwb/mSeklsJhP7OH9Ao4hmKSfPy/vAVtzgitaHi6MiQOvVMju9+CDQAZbQncJu1TFBjCYDASGXA0knr4H3f+fBcvuRudARdr2JRRq2HV4ZsYcnhMMGjxATnMgYJFD9m0DYZAPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OV1ynq+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28072C19421;
	Sun,  1 Mar 2026 01:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330000;
	bh=R5tQpyvkOahvTrujdWQ05xw2oehMgcO2zg2LLFExlho=;
	h=From:To:Cc:Subject:Date:From;
	b=OV1ynq+7X5JiYcYcZOh1VnTJIO7QSBvxkgGlpBcGmGUcpUUqxc/4RKLj5BTqYxVzn
	 Z4pMkPsUAFip3RZcIMa0paeicMbS89nSyZUwQPO2oVkb/vEGP7upJQJhLNx5oUkunP
	 Sqx4fZ44PjeqePZ00bIMVgVdXku3pRXA5mbNrLx/bbZpItgy4jVKUefwB2XLK5pYyy
	 dGaYk7W2e2B8s16tswlVPWNo55Zv1LmW2TKHlYiTkGYtoL/R/e1hcCXmAz/AItxiBu
	 4ZWve41Vm9zNs08222i4CSd4bDe5qdEoYo1XtSldHyv3g0PGuK74obX5yMHF+QV6Up
	 8922NCfwyYMNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	linusw@kernel.org
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-ide@vger.kernel.org
Subject: FAILED: Patch "ata: pata_ftide010: Fix some DMA timings" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:53:18 -0500
Message-ID: <20260301015319.1720038-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222140-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ABF2F1CC93E
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
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





