Return-Path: <stable+bounces-83699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD4E99BEC6
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 06:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F86A1C2255B
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 04:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6551A4B76;
	Mon, 14 Oct 2024 03:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="np7dh8mA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61E11A3AA9;
	Mon, 14 Oct 2024 03:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878335; cv=none; b=JaiX1dhHNCejab49zlEpleCdXRo/bVDXEjN6bc6NfAxCIABd0+un7V/4h/e+zMmGGjMjc0I+QFH+lBOhw8hHbsI3CNoVo2qCYSdn7jnp7egSqHxicWlQOcYad09jrgH867S7cJOw8BlFJ37cmJ4+F3P5HCo4RRqrh/yZ9oo2A3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878335; c=relaxed/simple;
	bh=v4+xlGOj+TcoPX5RB/YjejqTD4s5UxCNPNGcJLzq/+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAG2TnF+keph/RcylJ2kLCIJ6Sk78PTXkKHnyVB9fJ/actpuO0pMhf+iYRMIcHfWQOsqPQ/q9qqc5RMERy5itWdJEMC3+6QSDWKRc5YZsYTb1E0dXta5iIWUpWATQrMzsR52R2F3AecfxqOmGPoHhQu8w76ewEX/WpAf0bxwmes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=np7dh8mA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A03C4CECF;
	Mon, 14 Oct 2024 03:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878334;
	bh=v4+xlGOj+TcoPX5RB/YjejqTD4s5UxCNPNGcJLzq/+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=np7dh8mAQ7gIgw1k6eTED04XJ/+uvd5gqwHKeW/E/LW1rq4pX6YsXKcufV5FzhoWZ
	 x7nY3aJSPSLT9QBuHb3pBO2X6CKBJLnWeJTPbFgXmdnw6MjikJ4pPOhjv60xyOFZAx
	 /+nmEAzMT891k69iW5Mxzb8k6vmYCatAaCFQiuorXpgbrDveLpMFqkG0sJEGoBoAN6
	 pHEK7ygtq7w+8EaHd3KV4C/HQpluETMcSlTNtSdOn23S/6928aFakhy+11KceH0x/W
	 bu4kkxLQ5WuiX1jsu7smD6lhL4A6YryfW7TKr4TEiGFM/y14VcZ03E3vbMrN4Aq60s
	 IKyP/eAHoClZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+bc7ca0ae4591cb2550f9@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 04/10] fs/ntfs3: Fix possible deadlock in mi_read
Date: Sun, 13 Oct 2024 23:58:39 -0400
Message-ID: <20241014035848.2247549-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035848.2247549-1-sashal@kernel.org>
References: <20241014035848.2247549-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 03b097099eef255fbf85ea6a786ae3c91b11f041 ]

Mutex lock with another subclass used in ni_lock_dir().

Reported-by: syzbot+bc7ca0ae4591cb2550f9@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index a9549e73081fb..7cad1bc2b314f 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -79,7 +79,7 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 		if (err < 0)
 			inode = ERR_PTR(err);
 		else {
-			ni_lock(ni);
+			ni_lock_dir(ni);
 			inode = dir_search_u(dir, uni, NULL);
 			ni_unlock(ni);
 		}
-- 
2.43.0


