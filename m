Return-Path: <stable+bounces-110689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F34EBA1CB74
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A982A16124B
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79718224892;
	Sun, 26 Jan 2025 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFGBxADB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263941F0E34;
	Sun, 26 Jan 2025 15:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903845; cv=none; b=Dapn6vTEkfxaRPrqNQFS8tdq5vGwqcfurz5TKUQJZNIomSppNQkxNZtojLUo/oF6jfbZJ6p7gKDL36wAZzhbxmbrXJdNFzJRH0Szg4Y0qQSwLZRwd6L370R3lHZHfU6AD3XnK/1dZJYvkNk5HAZJ79guBKOj+Yn1Zz2sQe9SW8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903845; c=relaxed/simple;
	bh=IkGoTTiRdnPoF9wVFpahtJe9erV3z8jlR8dEmiSN/OA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fEiUu6AHH2EbQZ1sCDpuIWKbICdDDAeHRV1baacSe8CioihXcpyRdi17QuYeXO7YYNfpcPYX8wRoZhe9GwojiOuI4NeCwHtT6k1i9KW6hC98tozFUbygjOuu/A+Q39OskEjPmbdKdBhw3MoCmgGhvDc2QEWegijzw9TcTmHrgMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFGBxADB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A83CC4CEE5;
	Sun, 26 Jan 2025 15:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903844;
	bh=IkGoTTiRdnPoF9wVFpahtJe9erV3z8jlR8dEmiSN/OA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AFGBxADBZsl7rmwMJu3tOcaOJA0yAaoICFizFEC2j5Bv/4JCGvGBpyTf3Iqjz24rt
	 tNtVU6qrkyGfVQMjXXfMgRA6qPBo3YgYQSxd/f5/tjNGtqfG5owaL4ioD9owImR6a0
	 gfdAmbvfsNRxfH+oT8sLYxaxh1OKFgrgbUfhuxhMnOZT3U0SXoXu9Jn8E0qPc3rW7c
	 TQ8UsX/JZMcvSl8VSU7W8KUvMDgHhh1fEvnqbpDDBItS1+maCU6n9lyp8g/o7Dvcsf
	 rxtQ33azE1+fU7P7BFl4ga9snpAXw2CQhgeQ7fyyc07JOnYvPc2PdLx86YKJtVrwdZ
	 a1GXYOwfHmhBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com,
	Leo Stone <leocstone@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	takedakn@nttdata.co.jp,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/17] tomoyo: don't emit warning in tomoyo_write_control()
Date: Sun, 26 Jan 2025 10:03:41 -0500
Message-Id: <20250126150353.957794-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150353.957794-1-sashal@kernel.org>
References: <20250126150353.957794-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.127
Content-Transfer-Encoding: 8bit

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 3df7546fc03b8f004eee0b9e3256369f7d096685 ]

syzbot is reporting too large allocation warning at tomoyo_write_control(),
for one can write a very very long line without new line character. To fix
this warning, I use __GFP_NOWARN rather than checking for KMALLOC_MAX_SIZE,
for practically a valid line should be always shorter than 32KB where the
"too small to fail" memory-allocation rule applies.

One might try to write a valid line that is longer than 32KB, but such
request will likely fail with -ENOMEM. Therefore, I feel that separately
returning -EINVAL when a line is longer than KMALLOC_MAX_SIZE is redundant.
There is no need to distinguish over-32KB and over-KMALLOC_MAX_SIZE.

Reported-by: syzbot+7536f77535e5210a5c76@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7536f77535e5210a5c76
Reported-by: Leo Stone <leocstone@gmail.com>
Closes: https://lkml.kernel.org/r/20241216021459.178759-2-leocstone@gmail.com
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/tomoyo/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/tomoyo/common.c b/security/tomoyo/common.c
index a7af085550b2d..5f1cdd0af115d 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2664,7 +2664,7 @@ ssize_t tomoyo_write_control(struct tomoyo_io_buffer *head,
 
 		if (head->w.avail >= head->writebuf_size - 1) {
 			const int len = head->writebuf_size * 2;
-			char *cp = kzalloc(len, GFP_NOFS);
+			char *cp = kzalloc(len, GFP_NOFS | __GFP_NOWARN);
 
 			if (!cp) {
 				error = -ENOMEM;
-- 
2.39.5


