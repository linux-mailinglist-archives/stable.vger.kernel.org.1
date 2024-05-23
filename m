Return-Path: <stable+bounces-46001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B158CDBDD
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 23:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845671C22FC1
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 21:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E60127E27;
	Thu, 23 May 2024 21:23:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA370127E0F;
	Thu, 23 May 2024 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716499400; cv=none; b=i2Gu2nHgwo7zkwBVyLHVUg1VbmYQBPwHtvqxU+CjalUrIiaxYxRE12+wc7JxSYX3JrkA9Eb3WEI1MQaR1sf5UvYbkOk+qbyWzfDCDUqhVSQxU4JehZHsZUwcwIl72PCngFfyk8pIN03bY8VTPYkH4EU9fIHU6wWAODPOfcQPUpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716499400; c=relaxed/simple;
	bh=MgR7PcM1cd8fILj4Kljcp2I/+ntdD1HauSiyYWV8qas=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iIrwQGdWfn0Zf935yizFktQnfdl1ivDj7BjvXfl23wiM846af1fZ1omLhxQV50PbiMe5/xjk1q9Tk/Ait8+9vEsOvF/eqve6XhHtceUvM3kCslz4ObhIqM3qymrp4Sg509MIrblUTC2+Us2sz4/sMu3zvAsEOPkJiLkqYOPoNgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D5EC3277B;
	Thu, 23 May 2024 21:23:20 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sAFuw-00000006l8E-0yrZ;
	Thu, 23 May 2024 17:24:06 -0400
Message-ID: <20240523212406.097200804@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 23 May 2024 17:22:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 1/8] eventfs: Keep the directories from having the same inode number as
 files
References: <20240523212258.883756004@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The directories require unique inode numbers but all the eventfs files
have the same inode number. Prevent the directories from having the same
inode numbers as the files as that can confuse some tooling.

Link: https://lore.kernel.org/linux-trace-kernel/20240523051539.428826685@goodmis.org

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Fixes: 834bf76add3e6 ("eventfs: Save directory inodes in the eventfs_inode structure")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 0256afdd4acf..55a40a730b10 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -50,8 +50,12 @@ static struct eventfs_root_inode *get_root_inode(struct eventfs_inode *ei)
 /* Just try to make something consistent and unique */
 static int eventfs_dir_ino(struct eventfs_inode *ei)
 {
-	if (!ei->ino)
+	if (!ei->ino) {
 		ei->ino = get_next_ino();
+		/* Must not have the file inode number */
+		if (ei->ino == EVENTFS_FILE_INODE_INO)
+			ei->ino = get_next_ino();
+	}
 
 	return ei->ino;
 }
-- 
2.43.0



