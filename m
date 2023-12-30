Return-Path: <stable+bounces-8874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01ABC820540
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 13:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 339941C21012
	for <lists+stable@lfdr.de>; Sat, 30 Dec 2023 12:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613038483;
	Sat, 30 Dec 2023 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zGeavUk6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BC479E0;
	Sat, 30 Dec 2023 12:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A391CC433C7;
	Sat, 30 Dec 2023 12:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703937987;
	bh=QrPp/Lx388i2x0S8pqM/CFq1WMQTx6Htp+Tvy1iGDhc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zGeavUk6GQ5ymnNX8zAZEHAiShD2pelo8wEH/BJaDJuywTfX3PpcmaAJwDSEury5n
	 n/S7Re1dKOkOS9oD7vjQjLsHI8Xk7+qfP+JE46KsAFGm5KNEwGJ1HijksN0uKHjNSM
	 WSS00khgzzNdYCgSN5g8FqUOVjm/XgTF3NgYjveU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 132/156] ring-buffer: Fix 32-bit rb_time_read() race with rb_time_cmpxchg()
Date: Sat, 30 Dec 2023 11:59:46 +0000
Message-ID: <20231230115816.673062797@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230115812.333117904@linuxfoundation.org>
References: <20231230115812.333117904@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

[ Upstream commit dec890089bf79a4954b61482715ee2d084364856 ]

The following race can cause rb_time_read() to observe a corrupted time
stamp:

rb_time_cmpxchg()
[...]
        if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
                return false;
        if (!rb_time_read_cmpxchg(&t->top, top, top2))
                return false;
<interrupted before updating bottom>
__rb_time_read()
[...]
        do {
                c = local_read(&t->cnt);
                top = local_read(&t->top);
                bottom = local_read(&t->bottom);
                msb = local_read(&t->msb);
        } while (c != local_read(&t->cnt));

        *cnt = rb_time_cnt(top);

        /* If top and msb counts don't match, this interrupted a write */
        if (*cnt != rb_time_cnt(msb))
                return false;
          ^ this check fails to catch that "bottom" is still not updated.

So the old "bottom" value is returned, which is wrong.

Fix this by checking that all three of msb, top, and bottom 2-bit cnt
values match.

The reason to favor checking all three fields over requiring a specific
update order for both rb_time_set() and rb_time_cmpxchg() is because
checking all three fields is more robust to handle partial failures of
rb_time_cmpxchg() when interrupted by nested rb_time_set().

Link: https://lore.kernel.org/lkml/20231211201324.652870-1-mathieu.desnoyers@efficios.com/
Link: https://lore.kernel.org/linux-trace-kernel/20231212193049.680122-1-mathieu.desnoyers@efficios.com

Fixes: f458a1453424e ("ring-buffer: Test last update in 32bit version of __rb_time_read()")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index af08a1a411e3d..070566baa0ca4 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -644,8 +644,8 @@ static inline bool __rb_time_read(rb_time_t *t, u64 *ret, unsigned long *cnt)
 
 	*cnt = rb_time_cnt(top);
 
-	/* If top and msb counts don't match, this interrupted a write */
-	if (*cnt != rb_time_cnt(msb))
+	/* If top, msb or bottom counts don't match, this interrupted a write */
+	if (*cnt != rb_time_cnt(msb) || *cnt != rb_time_cnt(bottom))
 		return false;
 
 	/* The shift to msb will lose its cnt bits */
-- 
2.43.0




