Return-Path: <stable+bounces-220190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFO3B7Yto2me+AQAu9opvQ
	(envelope-from <stable+bounces-220190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:02:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5451C55A3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A307A311DF72
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500FD4C77C5;
	Sat, 28 Feb 2026 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgYapZDR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1275A4C77BE;
	Sat, 28 Feb 2026 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300097; cv=none; b=X/JdPryEgJEFmsE9Tdps9HOoyScEswzHISBzuKL5v14i7FUuLcZHClhNoDor4xPMK50nPhTcwx1zgfyl3BJG1YhV9J8G/6wAbrh91l1nYoq6ZR8mJAC884wWfKhgQjcgRTyJv5AceAaaXK25/iOnZLbF1FqvM3H6H+74nalXKxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300097; c=relaxed/simple;
	bh=hqFVOjlF5+ZO2pilwS5gg2mQkEKBO5ayny0CHgbb+js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3divR2PaL7yrW5sc6i2PgAd9JO/LAjLvLOPBut8Z0WsiLRXlCyAYLm9GW5Hiow9iFN1KvJCjV6Qlug3A/5v5N3n+z64s5VuHWSkJ8jQel3tqpsYyFoyyDJIZ2/CHZzGqR00Z5z5joReV2I8ZKilb7zQd2Z9Tcpxjhjp9BAuBjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgYapZDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4383CC19423;
	Sat, 28 Feb 2026 17:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300096;
	bh=hqFVOjlF5+ZO2pilwS5gg2mQkEKBO5ayny0CHgbb+js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NgYapZDRUtiCOZt2p1TmMiGGviXg7kIQ1Qs6FsJ1PBJSgJBLLfgrX8JsNiYBd0lOW
	 bHo/+pLSssyVtGJGiVMZnAoeNsGIpMl6NNPfHDd4JFbD56Ov1JJ7xtJTHbjH6MradI
	 w+HjzvJS1U57fYBceEJoX4BerJn+1C1YFekc3quiCJf3b4Npo/+z6WlOumelnc4Oii
	 fdAQkJYDlR8l/xQZzPlE3iJgFYS14ljujqiL99NU7kqVwSaXhThjCOAbZFAKZNOyo+
	 1lqoJGenMBXiOaAqROkfG+A2lBaegTOHRpLB8IQGhxZ+JR4zLe4LorXidtG0m55OtN
	 ALs5ZQm46fWeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ruipeng Qi <ruipengqi3@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 112/844] pstore: ram_core: fix incorrect success return when vmap() fails
Date: Sat, 28 Feb 2026 12:20:25 -0500
Message-ID: <20260228173244.1509663-113-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220190-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: CE5451C55A3
X-Rspamd-Action: no action

From: Ruipeng Qi <ruipengqi3@gmail.com>

[ Upstream commit 05363abc7625cf18c96e67f50673cd07f11da5e9 ]

In persistent_ram_vmap(), vmap() may return NULL on failure.

If offset is non-zero, adding offset_in_page(start) causes the function
to return a non-NULL pointer even though the mapping failed.
persistent_ram_buffer_map() therefore incorrectly returns success.

Subsequent access to prz->buffer may dereference an invalid address
and cause crashes.

Add proper NULL checking for vmap() failures.

Signed-off-by: Ruipeng Qi <ruipengqi3@gmail.com>
Link: https://patch.msgid.link/20260203020358.3315299-1-ruipengqi3@gmail.com
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pstore/ram_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index c9eaacdec37e4..7b6d6378a3b87 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -457,6 +457,13 @@ static void *persistent_ram_vmap(phys_addr_t start, size_t size,
 	vaddr = vmap(pages, page_count, VM_MAP | VM_IOREMAP, prot);
 	kfree(pages);
 
+	/*
+	 * vmap() may fail and return NULL. Do not add the offset in this
+	 * case, otherwise a NULL mapping would appear successful.
+	 */
+	if (!vaddr)
+		return NULL;
+
 	/*
 	 * Since vmap() uses page granularity, we must add the offset
 	 * into the page here, to get the byte granularity address
-- 
2.51.0


