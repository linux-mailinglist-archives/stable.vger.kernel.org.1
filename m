Return-Path: <stable+bounces-140691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CE8AAAEB5
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F131BA159D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF19D239E6A;
	Mon,  5 May 2025 23:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlZ4/8G9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709593754EF;
	Mon,  5 May 2025 22:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485966; cv=none; b=NZjYaYo8XmEfAL6Nb1UHClrcmo/ZS2u2twADwl0WLx99aGJs+pEyvNih3Xld+O0JgWbY5LjgbQ7xAA0UAwUAL/Q3k9nP3FNbBjCmqnA1eSNMTuB40qE8i9DNh4Q7pvI3+AdZg8Qr6jZfVw8PIN24Qke17k0TApJYUH0BTaBoH00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485966; c=relaxed/simple;
	bh=sv9Ivp5NCO8P840O2ijo26JyQ//K1Vx1bxouP6jJBBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kK/VL7bsJEOfF6uljEXlvbvQfSiC472n2bAMMwjeztnra8bSAPl7DYNRoecltiy4V3hthaJkYsEPajrNrhlomk/n6vRcp/f8hO9XQzdC79NJTC2FTsLKmnCPAoDBR/7trKR0ASPq6zerIbjMvHnzywqlZjumf26gB4jw8E7u0ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlZ4/8G9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99896C4CEEF;
	Mon,  5 May 2025 22:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485965;
	bh=sv9Ivp5NCO8P840O2ijo26JyQ//K1Vx1bxouP6jJBBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XlZ4/8G9iiP2PLF3ayRLTplB8yQtpuo7UpcNfP9HhsjlzylsBwF4jls372bXAD4yo
	 XLlBD13bflJ2QT9HANQGICSM3E8gitQiSrXu3+wCsUpptH3QJEmFGzABRCGJT2EH+A
	 ucwr6NGFFSmWSFxxzPK1HbPTCFZb8TGlC8nJVdy4W42YPaKxCZ1pIRX/CC0kYE5CDp
	 5gJRjMj+8lEymR6SlCi77hUsUHtiYMpnia0rLgH78h6NRBP5ebcrBgL71eDe3fsEVT
	 uCpdo6/BxlRb+6SFTZjUDiipqDL0X8mYV93rmSsQ45khGQ19Tlmj7ALJTJE0uBUPMy
	 T1PlJLg0Pe7fQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.6 090/294] printk: Check CON_SUSPEND when unblanking a console
Date: Mon,  5 May 2025 18:53:10 -0400
Message-Id: <20250505225634.2688578-90-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index dcdf449615bda..51c43e0f9b29b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3119,7 +3119,12 @@ void console_unblank(void)
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
@@ -3156,7 +3161,12 @@ void console_unblank(void)
 
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


