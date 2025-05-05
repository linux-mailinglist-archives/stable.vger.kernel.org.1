Return-Path: <stable+bounces-141117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB14BAAB640
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E763A60B9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCD8321AC5;
	Tue,  6 May 2025 00:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8ihMPEB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F252BDC24;
	Mon,  5 May 2025 22:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485058; cv=none; b=mGeeKRCB7Afkr4N14LWHyRc6IcTrNFAW9fx4bjulJHCtcYJJO1qIiKVvO9f/nSmgyKacMAkRJiKBN9bO9MVDtxCp3T1ZSKh7jOZUTg9ENUiWpV2o37hsLsiwTHG/AZ/+3k1RKJ3MS4xztcsjV+/CumlZgGpJXbNohqV2M31aH3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485058; c=relaxed/simple;
	bh=jL5I9luT96zXsu5gZSkxkJPM74NUyfrr+aez6MdkaRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aef+l9CiXj6m2lh0btVYYPYFDhfLfFDZp+KPl22PtELMGGLC8exckc1WvbNa8EcWoWlWB6LmbK+paNhzI/iGIqzKdAGLiH9u5SJAHPQfiZ6uZCOw3xjP0JrbhK4ZsieQPuGXE/aZeDDuLC5deVECkLj+KhJpGj3V68yeL/4tbkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8ihMPEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B4EC4CEE4;
	Mon,  5 May 2025 22:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485057;
	bh=jL5I9luT96zXsu5gZSkxkJPM74NUyfrr+aez6MdkaRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R8ihMPEB+RejuCsYFbKoSh0XXVLPak1Yuh83WXC6iM1ojbRRwuOKqeTjyLxnhqSgB
	 RDDlmVz+KIZI08OxFfajaM9efB5Wx0gg2mnXs9yEqxdJvFuLrh3ZU0hzsXKwQTp5Hu
	 QzE2FWSfn+MW+2YpWJaDt97EG+lPQDQsqcQWZJPFo+Br4uUUOgyZoe9D+sYQZXIs4I
	 Zjlpl12eqqzw6JlvKprzlKYunNaqGGsVvIns7Hhpt5HnlDAiCnZ2XZdR2o5yEOZXhD
	 RksXUrzCEY5LdahKw6yot8rsH3GhO9m7YkruO3ImzYXNrQEI8Y9ql08252kHAjQJrp
	 SlgojyMX1NPiw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>,
	Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.12 146/486] printk: Check CON_SUSPEND when unblanking a console
Date: Mon,  5 May 2025 18:33:42 -0400
Message-Id: <20250505223922.2682012-146-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 881a26e18c658..3a91b739e8f30 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3310,7 +3310,12 @@ void console_unblank(void)
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
@@ -3347,7 +3352,12 @@ void console_unblank(void)
 
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


