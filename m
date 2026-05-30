Return-Path: <stable+bounces-258299-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBZzFbcnG2qf/ggAu9opvQ
	(envelope-from <stable+bounces-258299-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:08:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8050611123
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C57B303267D
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E32341AC7;
	Sat, 30 May 2026 17:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oRsLzh3k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583B0352027;
	Sat, 30 May 2026 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780163885; cv=none; b=F30WKEXGnBFPw+DHVsFEH7ycnc/GIpe0NRWPuQmLdXYfdgMRqNFW7Ri8qP2j2piXZFwV/wbxe+DvxbmGOwvD5RVtMwugtfh17VUowRh+3kFNfYkof6DoXW2zc56VZupn7sj0PeRgD72UerIB91U6iQj1Q/NxhvxK0fZkGqoeUg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780163885; c=relaxed/simple;
	bh=DCDrH4FO7BnQf3tmKhi7rGqA2Viej1/8OXq3am4jrbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsv0Jm+Hmv8GgW/2tCTOjFmcnhrAvjqZ+8mxWNf4U0cMspGSEaa8oiacRd+pHzJHO37IG3Jt5EhQG2yMi3z90EVulfCX9Qw7HFqWCBbbBYNg5Wii6yonx1oN+oJr7iF1WBFSMcp2AH07B0oFiUzwaMo0eLsYXex+ApeO9UxovEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oRsLzh3k; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108621F00893;
	Sat, 30 May 2026 17:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780163881;
	bh=auDS5JC4vZEULDurI6Paz6xgGNYxJ6p7sURHMttEkiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oRsLzh3kM/Ar73igDu1oaF8Da3yWoybplJvGcnVnE/fFApXeofsO3QSdlxKgEzThM
	 To0m66CiATX8Vg1ucpeOHIzRoeiXqjLz/Uczz2OVg8zTwyPEIwxaQ94oKSWmPUmpmw
	 CKjtQVD8dmX2DhiufB/NeZwpbs9mM/f+ndxYGJDs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 389/776] devres: fix missing node debug info in devm_krealloc()
Date: Sat, 30 May 2026 18:01:43 +0200
Message-ID: <20260530160250.552630667@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-258299-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C8050611123
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Danilo Krummrich <dakr@kernel.org>

[ Upstream commit f813ec9e84b4d0ca81ec1da94ab07bfb4a29266c ]

Fix missing call to set_node_dbginfo() for new devres nodes created by
devm_krealloc().

Fixes: f82485722e5d ("devres: provide devm_krealloc()")
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/20260202235210.55176-2-dakr@kernel.org
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/devres.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 58e8e2be26ac7..6e4b43c5c3075 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -907,6 +907,8 @@ void *devm_krealloc(struct device *dev, void *ptr, size_t new_size, gfp_t gfp)
 	if (!new_dr)
 		return NULL;
 
+	set_node_dbginfo(&new_dr->node, "devm_krealloc_release", new_size);
+
 	/*
 	 * The spinlock protects the linked list against concurrent
 	 * modifications but not the resource itself.
-- 
2.53.0




