Return-Path: <stable+bounces-139927-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 487FFAAA26E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341B15A57F6
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEADD2DA83C;
	Mon,  5 May 2025 22:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxzBt06E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D562DA834;
	Mon,  5 May 2025 22:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483686; cv=none; b=i1WtTIARK/n3emSnjHlTfu2Vc21Ue2SUZbkX8dR1rh/3cqddwvGUheUeTjLcqJNu+7skok2srVZIBJ6h2nkNCqbwUvfSTULHA9ZnDXFomE02Yo2GglZqIbUqBl1dT6SCsj6X934tiVC7+m9AsK7/lwrd7Rmtv2cRUm5lbcbtfWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483686; c=relaxed/simple;
	bh=2RL5rakife4xZnOE8I4zuwwaaWAVRXOp1e0Frg0Q/eU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XnNCfEtf3LnzRXjby8A9YcxDdgWw4lyXm2TMPcvVYlXp3Bdb2fER9zQAHYfpB/ebBU+xdp7Aa1zW17TKSV3jbKn3bXwyFS2PIJWWnzNjW7khnSKTKFQO2La0PT0G35MSIPRPX8MRwd3PsJOo29/v3BH/EhclptrtdBSwCAvvE6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxzBt06E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F14DC4CEE4;
	Mon,  5 May 2025 22:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483686;
	bh=2RL5rakife4xZnOE8I4zuwwaaWAVRXOp1e0Frg0Q/eU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OxzBt06EZ0AO476hx5Z1vQZI+G4r8l0SdQ2D2Vj45a4BUsSX4jbY5Ud+g2I/tKc10
	 SWqYvYWa4SAJ90cz7mj3Fp1E5ka4sp5EhYrKFCDOI57cm3r3UMe4qgLaKymXQ1vT81
	 gpwMsU49Z5FJEHdtP1g1hz4SLUHzucE9sufeaQ78exepmGha4nIeECuoqiXKqeNP5I
	 n4GYmkYccaQLLG25pRuzhmL4pwq7WlDGBBrgXubDIRntBE8CC/nfio8M/x/0yRLAsx
	 VJ95qLywXAUP3HW7e9LcBBWCB6tugLETpE+PcMmHUbhg5n/o6bYCwQHN1CM6dhCgAz
	 bxKp0p51Qh4nQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.14 180/642] printk: Check CON_SUSPEND when unblanking a console
Date: Mon,  5 May 2025 18:06:36 -0400
Message-Id: <20250505221419.2672473-180-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Marcos Paulo de Souza <mpdesouza@suse.com>

[ Upstream commit 72c96a2dacc0fb056d13a5f02b0845c4c910fe54 ]

The commit 9e70a5e109a4 ("printk: Add per-console suspended state")
introduced the CON_SUSPENDED flag for consoles. The suspended consoles
will stop receiving messages, so don't unblank suspended consoles
because it won't be showing anything either way.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Link: https://lore.kernel.org/r/20250226-printk-renaming-v1-5-0b878577f2e6@suse.com
Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 057db78876cd9..13d4210d8862f 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3340,7 +3340,12 @@ void console_unblank(void)
 	 */
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
-		if ((console_srcu_read_flags(c) & CON_ENABLED) && c->unblank) {
+		short flags = console_srcu_read_flags(c);
+
+		if (flags & CON_SUSPENDED)
+			continue;
+
+		if ((flags & CON_ENABLED) && c->unblank) {
 			found_unblank = true;
 			break;
 		}
@@ -3377,7 +3382,12 @@ void console_unblank(void)
 
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
-		if ((console_srcu_read_flags(c) & CON_ENABLED) && c->unblank)
+		short flags = console_srcu_read_flags(c);
+
+		if (flags & CON_SUSPENDED)
+			continue;
+
+		if ((flags & CON_ENABLED) && c->unblank)
 			c->unblank();
 	}
 	console_srcu_read_unlock(cookie);
-- 
2.39.5


