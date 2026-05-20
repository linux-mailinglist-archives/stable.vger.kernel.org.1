Return-Path: <stable+bounces-250054-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMOfG0sMDmpZ5wUAu9opvQ
	(envelope-from <stable+bounces-250054-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:32:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5CF598696
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33E6834C7D1F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7CE3546D9;
	Wed, 20 May 2026 16:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mJTOFE0T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52110369D75;
	Wed, 20 May 2026 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294422; cv=none; b=gibOoFBoZXk8F334Tph6D+eX2J4e2LzLj2id1m1jlSj4J9mmEbqCqdhENQ/sy1m+y1bJpAfcC1QzDN9iOlxBZ+KKODZV1vIDVqZRY+8wQMcSFgOqWfqoj8ycHTDnc9pNgWDrcRiFT+P6OtHJqTEDVaq01z0BUMeu1sagbn/r7CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294422; c=relaxed/simple;
	bh=BKBCZsOHNxR+B8BkKqbMnj55X2ImuU3Sc0GOK47Oq0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jj1pdk2hwogmZEgucxl5G1JRT/VGJB8D/Qjv2ZrbsoCx/lFUGriIPtdo0QtJJxJ83dSRt+OBHAJoCiHsGhjycgXmpaHzwPP2oT2eekiJmw4HxPawEBRq3/kCxKBx8E+SutnNJwNj0sRGd8At01f87esQ62qkxmmtbVrrWkR+sSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mJTOFE0T; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B680C1F00894;
	Wed, 20 May 2026 16:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779294421;
	bh=0JMO16OEXZQ1jf43aOMZ9G1n2eSgDgGykfdkpEuvFBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mJTOFE0Tje+5mktiane/hXVkVjk7XNd8+7mzc7/7i5kBrvla7kJw0CQCfhwWIvEO6
	 IRCVBalI2AXfgjF+Z4mXHQpJP9v5jR48XUxfmDWCu8gxyR5BVFC/nJhnT5w7dXeHgg
	 Rpb6d3aIVdAOGUEW2FKKW5v1ywNiEjXOKZ5hgeos=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gui-Dong Han <hanguidong02@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0032/1146] debugfs: fix placement of EXPORT_SYMBOL_GPL for debugfs_create_str()
Date: Wed, 20 May 2026 18:04:42 +0200
Message-ID: <20260520162149.110812427@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-250054-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: DD5CF598696
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gui-Dong Han <hanguidong02@gmail.com>

[ Upstream commit 4afc929c0f74c4f22b055a82b371d50586da58ca ]

The EXPORT_SYMBOL_GPL() for debugfs_create_str was placed incorrectly
away from the function definition. Move it immediately below the
debugfs_create_str() function where it belongs.

Fixes: d60b59b96795 ("debugfs: Export debugfs_create_str symbol")
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
Link: https://patch.msgid.link/20260323085930.88894-3-hanguidong02@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/debugfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index a941d73251b06..edd6aafbfbaaf 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1047,7 +1047,6 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(debugfs_create_str);
 
 static ssize_t debugfs_write_file_str(struct file *file, const char __user *user_buf,
 				      size_t count, loff_t *ppos)
@@ -1142,6 +1141,7 @@ void debugfs_create_str(const char *name, umode_t mode,
 	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_str,
 				   &fops_str_ro, &fops_str_wo);
 }
+EXPORT_SYMBOL_GPL(debugfs_create_str);
 
 static ssize_t read_file_blob(struct file *file, char __user *user_buf,
 			      size_t count, loff_t *ppos)
-- 
2.53.0




