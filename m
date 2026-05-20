Return-Path: <stable+bounces-251790-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEX3IP0dDmro6AUAu9opvQ
	(envelope-from <stable+bounces-251790-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:47:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7BC59A1E5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 439B435013AB
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C4C3EF0DA;
	Wed, 20 May 2026 17:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NW1gZZAT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E5A3D7D66;
	Wed, 20 May 2026 17:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298897; cv=none; b=TJk1+Ra4VKvComqkwdcYQoBJveqL7ZlhFpGhcKU9gYe0n41XFdzw6MYBm67rVladrVn466FTPcgJs/trqyNszw4uqe63YgviQcB56DYl7LfG71ZzztStIo22cR/SdFsW2kDwMhjRh8cv4Kt3llMrUOMRPRAOEbtyh5/fXEl+KkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298897; c=relaxed/simple;
	bh=BXQm9VYNsVH7ZOEbEKfsgIo4leVJF6M9cwp2iEgMHcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGxC7xe4jq0JjlLYzJge1hFx7GuKXjmhgA63h/XRWUIdjEs5kZDM+ApbZ2ziwQzOx1KPn92lqyw+jGu33kcytLEdp19csaAXmc1+CEbDXFYCGSnsQGQiUkFXqigZSsazkJYF+cYdoSrVf/YmCWUZgzhx1SNB71Jj7jijbxS4Wh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NW1gZZAT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801101F000E9;
	Wed, 20 May 2026 17:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298896;
	bh=n2rqVQazb6eyMrfdUL0PVayZsDOc1HrYUPi0uZ5kv9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NW1gZZATnLTU4888HgvmrwbI1uY8xPNuTLNu1MhoKqLZiEWMirTjk/UVUl/Lohsgx
	 T9neLNmUQfeFMY1s4vrlb2TPy4RRJNBKQvRJEYFF5ULIGGPGQGsPTTgx9cUXXJnJKv
	 MxPRhpAi2hKg7s2RojSUPGFo2BkmAf54UJsSUlp0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 586/957] f2fs: fix to preserve previous reserve_{blocks,node} value when remount
Date: Wed, 20 May 2026 18:17:49 +0200
Message-ID: <20260520162147.240230355@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251790-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,unisoc.com:email]
X-Rspamd-Queue-Id: DC7BC59A1E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhiguo Niu <zhiguo.niu@unisoc.com>

[ Upstream commit 01968164d94762db2f703647c5acfa28613844f1 ]

The following steps will change previous value of reserve_{blocks,node},
this dones not match the original intention.

1.mount -t f2fs -o reserve_root=8192 imgfile test_mount/
F2FS-fs (loop56): Mounted with checkpoint version = 1b69f8c7
mount info:
/dev/block/loop56 on /data/test_mount type f2fs (xxx,reserve_root=8192,reserve_node=0,resuid=0,resgid=0,xxx)

2.mount -t f2fs -o remount,reserve_root=4096 /data/test_mount
F2FS-fs (loop56): Preserve previous reserve_root=8192
check mount info: reserve_root change to 4096
/dev/block/loop56 on /data/test_mount type f2fs (xxx,reserve_root=4096,reserve_node=0,resuid=0,resgid=0,xxx)

Prior to commit d18535132523 ("f2fs: separate the options parsing and options checking"),
the value of reserve_{blocks,node} was only set during the first mount, along with
the corresponding mount option F2FS_MOUNT_RESERVE_{ROOT,NODE} . If the mount option
F2FS_MOUNT_RESERVE_{ROOT,NODE} was found to have been set during the mount/remount,
the previously value of reserve_{blocks,node} would also be preserved, as shown in
the code below.
             if (test_opt(sbi, RESERVE_ROOT)) {
                   f2fs_info(sbi, "Preserve previous reserve_root=%u",
                          F2FS_OPTION(sbi).root_reserved_blocks);
             } else {
                   F2FS_OPTION(sbi).root_reserved_blocks = arg;
                   set_opt(sbi, RESERVE_ROOT);
             }
But commit d18535132523 ("f2fs: separate the options parsing and options checking")
only preserved the previous mount option; it did not preserve the previous value of
reserve_{blocks,node}. Since value of reserve_{blocks,node} value is assigned
or not depends on ctx->spec_mask, ctx->spec_mask should be alos handled in
f2fs_check_opt_consistency.

This patch will clear the corresponding ctx->spec_mask bits in f2fs_check_opt_consistency
to preserve the previously values of reserve_{blocks,node} if it already have a value.

Fixes: d18535132523 ("f2fs: separate the options parsing and options checking")
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8790d9d4348a1..7e04ae8f32f0e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1467,6 +1467,7 @@ static int f2fs_check_opt_consistency(struct fs_context *fc,
 			F2FS_OPTION(sbi).root_reserved_blocks);
 		ctx_clear_opt(ctx, F2FS_MOUNT_RESERVE_ROOT);
 		ctx->opt_mask &= ~BIT(F2FS_MOUNT_RESERVE_ROOT);
+		ctx->spec_mask &= ~F2FS_SPEC_reserve_root;
 	}
 	if (test_opt(sbi, RESERVE_NODE) &&
 			(ctx->opt_mask & BIT(F2FS_MOUNT_RESERVE_NODE)) &&
@@ -1475,6 +1476,7 @@ static int f2fs_check_opt_consistency(struct fs_context *fc,
 			F2FS_OPTION(sbi).root_reserved_nodes);
 		ctx_clear_opt(ctx, F2FS_MOUNT_RESERVE_NODE);
 		ctx->opt_mask &= ~BIT(F2FS_MOUNT_RESERVE_NODE);
+		ctx->spec_mask &= ~F2FS_SPEC_reserve_node;
 	}
 
 	err = f2fs_check_test_dummy_encryption(fc, sb);
-- 
2.53.0




