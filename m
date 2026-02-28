Return-Path: <stable+bounces-220643-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC+XDsNRo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220643-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:36:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 775EE1C86FB
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C553D36AF24A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44693EE720;
	Sat, 28 Feb 2026 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKHvm9b6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851693EC6DC;
	Sat, 28 Feb 2026 17:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300525; cv=none; b=t8VxExZCkB/k6+TCbuMvLzgtIZVmhXxUYTSSQbpC/spi5e7PMcgXtcqOHlOVO1/uBO15oZ0CdZb/Ldk2TGXnu3CLnqPrp+ajbe0fLZaOf2jBnG0EAATXcdAG7Yp0PgWd6/HNq0hdAPzh4kfZeNarXkcK/gsuWBNoGnxFU6KIgG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300525; c=relaxed/simple;
	bh=exy+B1iLimCn8ZjMhAukkTykOgpYGNDzY5W+gbyRLS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZT3Jt9D2HZNDvjLiZ+Z4X5dJYHDeuTFTMaE5DuyDOJR0x4299+QrEY3pxtumjyogE8a39b8BUniIb0H6R2mY3eU10v4ZjBeLyq4draX7vdWR0HUz7uq2VLkNbd/J3WDDHF4xWH0PZ4FJ5Sfgsell9ulxTWXyD7zBViU104uPjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKHvm9b6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBF2C2BCAF;
	Sat, 28 Feb 2026 17:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300525;
	bh=exy+B1iLimCn8ZjMhAukkTykOgpYGNDzY5W+gbyRLS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EKHvm9b6fc5siXwjYs/XuGyG1Y166O/e3De6tcbK91/MKWqBrAfx4cysBIW1upcPA
	 ATnvqPByya0pnfS0pWkh8Pn82lbBoIG7yV0XWIhXz0Xevh0BGIuTgvd/rhlALafxT6
	 PBdXtN++eWoSmx/maN1LjsCMq4KTwk3sPrMh2bMKEYQxzXx/DzjAhOrFfS7oe2m9gg
	 qQ5bmhQwOkvI64rl6O5TpZhuV8wiK12juVb2xwk/Iywnffl6yXz2fOEmLYRc7EupV4
	 CISqnhcsYCJxffwCN46rY5g70APdjG2aljpKu4CQDmGdTGYH1p+C5nZIr2UWSuqDx2
	 q4RU5Gr65lPkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 564/844] fs: ensure that internal tmpfs mount gets mount id zero
Date: Sat, 28 Feb 2026 12:27:57 -0500
Message-ID: <20260228173244.1509663-565-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220643-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 775EE1C86FB
X-Rspamd-Action: no action

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit a2062463e894039a6fdc2334b96afd91d44b64a8 ]

and the rootfs get mount id one as it always has. Before we actually
mount the rootfs we create an internal tmpfs mount which has mount id
zero but is never exposed anywhere. Continue that "tradition".

Link: https://patch.msgid.link/20260112-work-immutable-rootfs-v2-1-88dd1c34a204@kernel.org
Fixes: 7f9bfafc5f49 ("fs: use xarray for old mount id")
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index f6879f282daec..ecf0e72ce6cfd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -221,7 +221,7 @@ static int mnt_alloc_id(struct mount *mnt)
 	int res;
 
 	xa_lock(&mnt_id_xa);
-	res = __xa_alloc(&mnt_id_xa, &mnt->mnt_id, mnt, XA_LIMIT(1, INT_MAX), GFP_KERNEL);
+	res = __xa_alloc(&mnt_id_xa, &mnt->mnt_id, mnt, xa_limit_31b, GFP_KERNEL);
 	if (!res)
 		mnt->mnt_id_unique = ++mnt_id_ctr;
 	xa_unlock(&mnt_id_xa);
-- 
2.51.0


