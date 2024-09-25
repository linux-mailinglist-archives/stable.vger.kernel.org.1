Return-Path: <stable+bounces-77261-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE4D985B37
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0D81C23FD7
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906BF1BA88A;
	Wed, 25 Sep 2024 11:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iww1t1gm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8C41BA885;
	Wed, 25 Sep 2024 11:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264863; cv=none; b=sifXy5GIIs40o4FseFt88ejwK/0nfZM3Drp3cDCSt7MzfDYgMTwNq7ip8D99Dn06D4RRXya/4hWM7EnT/VuxHZXpEo38Pgyl6AuUu/8vrT1zvwqeiaDZ9hpY8OOYKqBX79YUGVMz//8kYDWUTsHIgcgZ6wYac8vL+PCNTnl2i50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264863; c=relaxed/simple;
	bh=WLwmC3Hm2bLkBxNh72GWwvU1jxkOWIZutATITZQts04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZFRRvj2kj6DyEOjrcSJw2T9ikD6QxvNHdqMyUUqbjy5E5gyfaeFQH2Mg1Bb36VYLZLYqbFlcN1d7dtSqznE+8GjjwVDYQzEv+34ICiEqrPVwR3JmJsj9CCo97037HxLJnJ52vnDPte/PFyM+Nldp4sM0+Pwhb0O5eGQvCZXJOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iww1t1gm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4E5C4CEC3;
	Wed, 25 Sep 2024 11:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264862;
	bh=WLwmC3Hm2bLkBxNh72GWwvU1jxkOWIZutATITZQts04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iww1t1gmCPKiWon2mXrakuUgEZPF8Fojufpq59Qdf+EJrgOUSSdY+rGi3gvKiaICp
	 cLRMEWdiZJoCqL4SqGxRsy5YdIJUElnK0m5hm/A419r0ff7FJsmuMNzA9T5Gr9kRC5
	 P2yhxfFvJxWr/DLndI6Abq1ijYrUwJQILOsDHYFozx4G/GRgrjcSDL34dILygOVWpp
	 Htz/hSf1sUBZE76+xW3Ei4g4XaXM5gvxcS2W4994fA4XXDlELMzcvfoBk0YtUyLVIH
	 liSd74ZeCfRf/QbpEaONnZrBvNA7RgoIRnWDLD0w9rLnj4iU/CgCjlKxGoQAvbI+It
	 /4+Gjdlc+frRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Remington Brasga <rbrasga@uci.edu>,
	syzbot+e38d703eeb410b17b473@syzkaller.appspotmail.com,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	shaggy@kernel.org,
	ghandatmanas@gmail.com,
	juntong.deng@outlook.com,
	eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.11 163/244] jfs: UBSAN: shift-out-of-bounds in dbFindBits
Date: Wed, 25 Sep 2024 07:26:24 -0400
Message-ID: <20240925113641.1297102-163-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Remington Brasga <rbrasga@uci.edu>

[ Upstream commit b0b2fc815e514221f01384f39fbfbff65d897e1c ]

Fix issue with UBSAN throwing shift-out-of-bounds warning.

Reported-by: syzbot+e38d703eeb410b17b473@syzkaller.appspotmail.com
Signed-off-by: Remington Brasga <rbrasga@uci.edu>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/jfs_dmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index 5713994328cbc..ccdfa38d7a682 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -3022,7 +3022,7 @@ static int dbFindBits(u32 word, int l2nb)
 
 	/* scan the word for nb free bits at nb alignments.
 	 */
-	for (bitno = 0; mask != 0; bitno += nb, mask >>= nb) {
+	for (bitno = 0; mask != 0; bitno += nb, mask = (mask >> nb)) {
 		if ((mask & word) == mask)
 			break;
 	}
-- 
2.43.0


