Return-Path: <stable+bounces-18938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 785ED84B4B1
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 13:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 154E11F29206
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 12:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4CD31353E4;
	Tue,  6 Feb 2024 12:09:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7DF1350EA;
	Tue,  6 Feb 2024 12:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221359; cv=none; b=SikFTvumgGNffjSlIHV3XUAKexIl1iJHpTr6yhtMRrywkSvL4dZvK/LZZKJ2B9/6AXxubDgvmCpY7VNLlZFV060zpT8AMcqLCSt0ZZgbkyFWkPg52m/KprpaqDmEG6TSyOZWJy6gvq/TcEDUBeZ8DQnS3AREoYtlQB8sKhGtJJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221359; c=relaxed/simple;
	bh=BCOdodT45sKdycskCPyprH7pqrVnY8qdzczttuGR9Dg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=QC7Cwr6jr4hm+2rbqI+KUP5nDFUDBwM9wQ/6NwoYeVJ/dmYXvjep+7OUZiG307HnewsvJSioV0n/B2c8zRO9MF7HlStM2eJY5sgRn/18CPsvtrl20HQGiZWznfDbPr1PjSwTU6NiWEHUJUPwQxVwY7NIpkF1vydkCbfa3fCVRio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154CCC4166C;
	Tue,  6 Feb 2024 12:09:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGp-00000006b4L-24ln;
	Tue, 06 Feb 2024 07:09:47 -0500
Message-ID: <20240206120947.351905829@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [v6.6][PATCH 06/57] Revert "eventfs: Remove "is_freed" union with rcu head"
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

This reverts commit fa18a8a0539b02cc621938091691f0b73f0b1288.

The eventfs was not designed properly and may have some hidden bugs in it.
Linus rewrote it properly and I trust his version more than this one. Revert
the backported patches for 6.6 and re-apply all the changes to make it
equivalent to Linus's version.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index a64d8fa39e54..8c8d64e76103 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -38,7 +38,6 @@ struct eventfs_inode {
  * @fop:	file_operations for file or directory
  * @iop:	inode_operations for file or directory
  * @data:	something that the caller will want to get to later on
- * @is_freed:	Flag set if the eventfs is on its way to be freed
  * @mode:	the permission that the file or directory should have
  */
 struct eventfs_file {
@@ -53,14 +52,15 @@ struct eventfs_file {
 	 * Union - used for deletion
 	 * @del_list:	list of eventfs_file to delete
 	 * @rcu:	eventfs_file to delete in RCU
+	 * @is_freed:	node is freed if one of the above is set
 	 */
 	union {
 		struct list_head	del_list;
 		struct rcu_head		rcu;
+		unsigned long		is_freed;
 	};
 	void				*data;
-	unsigned int			is_freed:1;
-	unsigned int			mode:31;
+	umode_t				mode;
 };
 
 static DEFINE_MUTEX(eventfs_mutex);
@@ -814,8 +814,6 @@ static void eventfs_remove_rec(struct eventfs_file *ef, struct list_head *head,
 		}
 	}
 
-	ef->is_freed = 1;
-
 	list_del_rcu(&ef->list);
 	list_add_tail(&ef->del_list, head);
 }
-- 
2.43.0



