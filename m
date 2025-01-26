Return-Path: <stable+bounces-110706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E38A1CBDA
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDFE13AEA76
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DA31A9B23;
	Sun, 26 Jan 2025 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qy1ykPP+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AE62288C3;
	Sun, 26 Jan 2025 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903881; cv=none; b=kxeOViP0F9pg1uovAaUVQAhz+9N7gBd9QcszkioZx0pdBKQ5T9v/ZN0S5Q7maWMNAJxOmF535mItz+rZewVgNwFposTkIUs5Ix6CfZ61KFBjQAUWFjedbYHs19KWVFEWHlpzpaMAE4WR4HiCplBoRYOKWthPsHMWz/emB+1C/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903881; c=relaxed/simple;
	bh=1Lbtt6VBFE6nK4zuaqQuXNvfdDJ55paNS65U3AvG+H0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QobGOt8AsqxCPLBb2kk1ZHWnj5tQwsmloNjLqHiM/SEMzunN82ZE+D3YyR9IONpw0j5wzh43667eL10GN29s2mVw7IlEkYLWd6iogeVSgZ3/E8XYRXSQ0i8eNS32w84E9/u7NAqoVG4vWsuX2/4bPwi/r1jgtN+lOTGX+1mC8J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qy1ykPP+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C828C4CEE8;
	Sun, 26 Jan 2025 15:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903879;
	bh=1Lbtt6VBFE6nK4zuaqQuXNvfdDJ55paNS65U3AvG+H0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qy1ykPP+/TIFNmbK6GwQWTEBcGEC5WHWovbXhAHqzDKsDmNjkRAyjDCb4WFtnFXlf
	 b7iYNVWLowQC37I9i41FryAApc3RyArccbqC2/gb2TWSLKcTZrzYMNojYuDClelWpr
	 P9lMiQk62SGkw9sgofAyg6gNwMkqayXMfJzFIStT/aa5e8VUlvUNYpeiH9l8rmYb4e
	 MxJNe+a1FFG2zRCGBGw/NErxucX6GApw4CTtwKjxGVDFDE/U7JJv92zonHzSPB+G8/
	 kbmTR//u4lKx4hJo3ZCUFhgZE84nW+BLEoAUxrTnbgoarVZKH5w6dcegceE9WUq3Ud
	 QldDTzN4RPg2Q==
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
Subject: [PATCH AUTOSEL 5.15 04/14] tomoyo: don't emit warning in tomoyo_write_control()
Date: Sun, 26 Jan 2025 10:04:20 -0500
Message-Id: <20250126150430.958708-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150430.958708-1-sashal@kernel.org>
References: <20250126150430.958708-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.177
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
index 9a66e5826f25a..cb8184122b920 100644
--- a/security/tomoyo/common.c
+++ b/security/tomoyo/common.c
@@ -2673,7 +2673,7 @@ ssize_t tomoyo_write_control(struct tomoyo_io_buffer *head,
 
 		if (head->w.avail >= head->writebuf_size - 1) {
 			const int len = head->writebuf_size * 2;
-			char *cp = kzalloc(len, GFP_NOFS);
+			char *cp = kzalloc(len, GFP_NOFS | __GFP_NOWARN);
 
 			if (!cp) {
 				error = -ENOMEM;
-- 
2.39.5


