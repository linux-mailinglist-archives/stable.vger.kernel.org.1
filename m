Return-Path: <stable+bounces-252192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKJjK4P4DWqq5AUAu9opvQ
	(envelope-from <stable+bounces-252192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:08:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CC95955BF
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F39730857DD
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2468A34DCE4;
	Wed, 20 May 2026 18:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TcPfC9aN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B014F5E0;
	Wed, 20 May 2026 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300032; cv=none; b=hlPD66Y3OiL3F/+wFK8drvb1n8sFd7Ev0KToUi8kN6LMKhfhBTIXWQRPb1EBAeyf0zJSpU6cNt8NJj/5xs1add9bnLmAbs84gIyWcK3adcNM6Vo50A3h9Pg4awtD2NMF/nrHVwaf+9JJ8VA93pXWRO1bpWaw4Rkb6IBYzC2IOu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300032; c=relaxed/simple;
	bh=9+MQjh0laZe8pD/h0TKW9JOSfbnmyxLeQBxmTNUp0qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ygjk6ogAbSXS08u8Mx+ZBHTA+K9jPWzLf5JGdUyvDs6mZ2xqrPYp6jstUo+9ka3v9BPP/n+McP81gXvAe012QvhytIDcuqM4bAJBRsbjYVjG6XSirxqoierGqpVvRuUcOeBPh/KqPE5j8CuKScKV6YxnPKqjDtdT3b1N3kggpFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TcPfC9aN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E101F000E9;
	Wed, 20 May 2026 18:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300031;
	bh=4nj1tSrJlOHsmRqc7lGN7wCW9oS/iVezEmEoYKqA5nA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TcPfC9aNhwPLCqc5SkypCTvNzlhz5Iqfde85ynxNix0hkLLdwu6VkPVU8UrNl0cLx
	 yYMtrYIkgcnlzUMoMqljRNzGZFb7xUCv0Mhdj1e3W6AJHpSpQri/OGi9TvXa/707OE
	 O48ZjTjcudbdLfnydEOAbqMn/fNHRn8w4HBn8HWg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	yangshiguang <yangshiguang@xiaomi.com>,
	Gui-Dong Han <hanguidong02@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 021/666] soundwire: debugfs: initialize firmware_file to empty string
Date: Wed, 20 May 2026 18:13:52 +0200
Message-ID: <20260520162111.690467587@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252192-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,xiaomi.com,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,xiaomi.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 62CC95955BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gui-Dong Han <hanguidong02@gmail.com>

[ Upstream commit 7215e4552f31e53595eae56a834f7e286beecccc ]

Passing NULL to debugfs_create_str() causes a NULL pointer dereference,
and creating debugfs nodes with NULL string pointers is no longer
permitted.

Additionally, firmware_file is a global pointer. Previously, adding every
new slave blindly overwrote it with NULL.

Fix these issues by initializing firmware_file to an allocated empty
string once in the subsystem init path (sdw_debugfs_init), and freeing
it in the exit path. Existing driver code handles empty strings
correctly.

Fixes: fe46d2a4301d ("soundwire: debugfs: add interface to read/write commands")
Reported-by: yangshiguang <yangshiguang@xiaomi.com>
Closes: https://lore.kernel.org/lkml/17647e4c.d461.19b46144a4e.Coremail.yangshiguang1011@163.com/
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
Link: https://patch.msgid.link/20260323085930.88894-4-hanguidong02@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/debugfs.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
index c30f571934ee2..93c93a128fb23 100644
--- a/drivers/soundwire/debugfs.c
+++ b/drivers/soundwire/debugfs.c
@@ -295,8 +295,8 @@ void sdw_slave_debugfs_init(struct sdw_slave *slave)
 	debugfs_create_file("go", 0200, d, slave, &cmd_go_fops);
 
 	debugfs_create_file("read_buffer", 0400, d, slave, &read_buffer_fops);
-	firmware_file = NULL;
-	debugfs_create_str("firmware_file", 0200, d, &firmware_file);
+	if (firmware_file)
+		debugfs_create_str("firmware_file", 0200, d, &firmware_file);
 
 	slave->debugfs = d;
 }
@@ -308,10 +308,15 @@ void sdw_slave_debugfs_exit(struct sdw_slave *slave)
 
 void sdw_debugfs_init(void)
 {
+	if (!firmware_file)
+		firmware_file = kstrdup("", GFP_KERNEL);
+
 	sdw_debugfs_root = debugfs_create_dir("soundwire", NULL);
 }
 
 void sdw_debugfs_exit(void)
 {
 	debugfs_remove_recursive(sdw_debugfs_root);
+	kfree(firmware_file);
+	firmware_file = NULL;
 }
-- 
2.53.0




