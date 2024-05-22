Return-Path: <stable+bounces-45589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A838CC504
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 18:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3556B1F21A4E
	for <lists+stable@lfdr.de>; Wed, 22 May 2024 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CCD1411FE;
	Wed, 22 May 2024 16:42:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73BB6AD7;
	Wed, 22 May 2024 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396178; cv=none; b=Ieed418y3Zd7dupOc0l1kHHnggH5p360oG94mybxApqe5WCQXOZSRurfkLZK2vMxj4eziI8JZhTwk7+EL5uOXcq8qRJ4u4rdRREHqXLJRVLG6hSFIW6WDiN3btoLjL4XECYx9COkawbw6gZaI62g4TvnBnW7HhoNNDD/qgJ5cIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396178; c=relaxed/simple;
	bh=DI8L+AIpBidzHd6c+aaUVlBgMkdhlGd6pSZDv1f5dVs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=mZeVbFeZSFijLFdwLsw7ItPxSN7k7z0cxhE69rLz6V9Vv2PFnmR2/Ok71ETeEHlajXOzA0BSXCzYWan+GwcG8uU7IBjJEgvbOXYewmbAsBXeLfy6NlvejUYZakYsOoJiIEFBK5lC1EF0f3PEDmLf6DdIxIb2CHCOeac3AQx5e+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DAFC2BBFC;
	Wed, 22 May 2024 16:42:58 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s9p41-00000006HF9-1xmt;
	Wed, 22 May 2024 12:43:41 -0400
Message-ID: <20240522164341.327141410@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 22 May 2024 12:43:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [PATCH 1/2] eventfs: Keep the directories from having the same inode number as
 files
References: <20240522164320.469785149@goodmis.org>
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

Cc: stable@vger.kernel.org
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



