Return-Path: <stable+bounces-220746-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAYpJ1tAo2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220746-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:22:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0D81C6E3F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 439EA30C63EA
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116C3402D8D;
	Sat, 28 Feb 2026 17:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyK8mvpY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C655C402D85;
	Sat, 28 Feb 2026 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300626; cv=none; b=nlyhE5X8rUrnR7cFqzWUFlzWmj33stnqbsKN89MZe9+zwHzRHdZ0edPd8XD9a+p3B3IklzuZM3CnGLQUlKnFXgsJJUJXBaE1wwAZnEcVJZZnLZXSTNmJOPjjGWQDGe3WlPM2RFyZ9aKgi939Qdx8GY4b7SGWHvGXHMGQwTGemYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300626; c=relaxed/simple;
	bh=pC5QG1l/bE6I4C1vnl30URd/Rzo8ssJRGcMFuJ7TZNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/zrs62ExA4gxZQQr0c+0YY8Bt4Xb1ZRnnIx41kaPQgYFEHKJ8705ruhJNnDyNdAuHvkbCtZOpdTGDWjlz3yRyo/kZzfa/gggUMA0kF0VSkQZretxZh7oQDIxthfWeZ0OBhmVfOlpBvwimfEU1EO5BxctQJhgXrf0BWWnzz2zgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyK8mvpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7683C116D0;
	Sat, 28 Feb 2026 17:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300626;
	bh=pC5QG1l/bE6I4C1vnl30URd/Rzo8ssJRGcMFuJ7TZNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UyK8mvpYRpx1HBRy5haWQuvJo6u3T44ERkIzBKIgwehFAWe5u8ik1ZiFqmwpfFjSB
	 vd2+XeDUgMhz/6tqazuSsOJ3xzUzZ8p5DaHKh4QlZWskqc4ZAbJS2Ag4wtiWzZU/kn
	 Y1QGh8gn2RNmPRUEpW/GZoxJwmOOBC+20AXiCXmsfumbyezX3RO211TCfNb4K+gQtE
	 zGNAIEsWSNDMsjTOqk1JIWNw2ididcvyxiZyUnUxyAjGKy2zI1KTEN1U6YyoDgqt2Y
	 ej/mbDytEW0qp055WQiiBN6yJlxYPBRK7GMazExrOsRnfeFCr7/L9L57WTnY+jDjyL
	 YVmkwtgeerhjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	stable@kernel.org,
	Hongbo Li <lihongbo22@huawei.com>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 667/844] erofs: fix incorrect early exits in volume label handling
Date: Sat, 28 Feb 2026 12:29:40 -0500
Message-ID: <20260228173244.1509663-668-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220746-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: 2E0D81C6E3F
X-Rspamd-Action: no action

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit 3afa4da38802a4cba1c23848a32284e7e57b831b ]

Crafted EROFS images containing valid volume labels can trigger
incorrect early returns, leading to folio reference leaks.

However, this does not cause system crashes or other severe issues.

Fixes: 1cf12c717741 ("erofs: Add support for FS_IOC_GETFSLABEL")
Cc: stable@kernel.org
Reviewed-by: Hongbo Li <lihongbo22@huawei.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/super.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index b54083128e0f4..ee37628ec99fb 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -347,8 +347,10 @@ static int erofs_read_superblock(struct super_block *sb)
 	if (dsb->volume_name[0]) {
 		sbi->volume_name = kstrndup(dsb->volume_name,
 					    sizeof(dsb->volume_name), GFP_KERNEL);
-		if (!sbi->volume_name)
-			return -ENOMEM;
+		if (!sbi->volume_name) {
+			ret = -ENOMEM;
+			goto out;
+		}
 	}
 
 	/* parse on-disk compression configurations */
-- 
2.51.0


