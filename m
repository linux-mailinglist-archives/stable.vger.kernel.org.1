Return-Path: <stable+bounces-106356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8C29FE7FE
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 16:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94540160ACE
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388031531C4;
	Mon, 30 Dec 2024 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ObFwLA14"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC00C15E8B;
	Mon, 30 Dec 2024 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735573694; cv=none; b=rkFZRQ48dLw3HhXK+qMIaFBScyAYQbSsqlSiZCyzmJJMR0r8QRKTKOLfkBtfEon4AQ+7/SnNi56YDANUPxHTpHoS2bBwB16AcmTtP2xkAdOpCOijUxa4FqX5s1uCtSrYLm1AcIF1qEZJy/jb76GltfyuqlRNrqJxRVf3bUoPO3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735573694; c=relaxed/simple;
	bh=jKctIXoSMnF39BX1o6/Y2e5K28b/w2fnRN+mKAk/NMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N20IndkJuZlSmxx0raLQIoJu2qsPs4qrHfZp6ZAAOutt2oAgfAvhazenjTRKz+Y4Kaxx1zG+Fnaof5SBE3fAVSYR0vP0f/PNNQEofizDXR2SCl3AOkzrsogL26DH91SnyFAkpsBf3Gwmct/tJuEhL7LaE9es/CdyiYb5z9ZDRX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ObFwLA14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B832C4CED0;
	Mon, 30 Dec 2024 15:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735573693;
	bh=jKctIXoSMnF39BX1o6/Y2e5K28b/w2fnRN+mKAk/NMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ObFwLA14dMd7LtK5yPCNw+5Lo+j7wPvFs8AkW5C9zWqUtGLMzuPs1aOyOUArp/ULf
	 AcZVZHgErmmIi/MxxH8JjQeyU3YMFyDNh0iFo2v24eqCHEkbGZsJmNlPMCCe2a37V8
	 4OMloHCeMN+YEel3UdHxRPootoY3CNHSsXg4XgCE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com,
	Lizhi Xu <lizhi.xu@windriver.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 6.1 50/60] tracing: Prevent bad count for tracing_cpumask_write
Date: Mon, 30 Dec 2024 16:43:00 +0100
Message-ID: <20241230154209.173597930@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230154207.276570972@linuxfoundation.org>
References: <20241230154207.276570972@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lizhi Xu <lizhi.xu@windriver.com>

commit 98feccbf32cfdde8c722bc4587aaa60ee5ac33f0 upstream.

If a large count is provided, it will trigger a warning in bitmap_parse_user.
Also check zero for it.

Cc: stable@vger.kernel.org
Fixes: 9e01c1b74c953 ("cpumask: convert kernel trace functions")
Link: https://lore.kernel.org/20241216073238.2573704-1-lizhi.xu@windriver.com
Reported-by: syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0aecfd34fb878546f3fd
Tested-by: syzbot+0aecfd34fb878546f3fd@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5262,6 +5262,9 @@ tracing_cpumask_write(struct file *filp,
 	cpumask_var_t tracing_cpumask_new;
 	int err;
 
+	if (count == 0 || count > KMALLOC_MAX_SIZE)
+		return -EINVAL;
+
 	if (!zalloc_cpumask_var(&tracing_cpumask_new, GFP_KERNEL))
 		return -ENOMEM;
 



