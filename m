Return-Path: <stable+bounces-45615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD488CCBAD
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 07:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA1B1C21680
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 05:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED25B13A878;
	Thu, 23 May 2024 05:14:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A5A4436B;
	Thu, 23 May 2024 05:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716441295; cv=none; b=kPIyTb96AEc9I6G6hywk7ojalFi6I2cVUE6ItwcRQIun8GS/eUa3YMLbssbgWU/CeWJysckKUOSzKJ4SmqN/YZeAVZvYnRwkQS3sM+AyuvnQAvpIc3aJAg8UEUEM9rRBFWzu2XBttBvGJg/53o3XI/ucNH1dbbRM7KW7za7gsfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716441295; c=relaxed/simple;
	bh=DI8L+AIpBidzHd6c+aaUVlBgMkdhlGd6pSZDv1f5dVs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Xnq+4/JuSg7zdVfgNWUUwM8cgyaYlJO/GpQABN8DzVlySrz2WZyyZnKOeKs667FtIQ5jxeZL2ko+SuLxro5Pd83OHIAEC9FebZszunzjoKEBrk0nlQegMOt0syoLTFnidtgXtx16nQzpmLoYW/CIVOI4gJM+qUpUPUyeRmR2Z8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598E3C32789;
	Thu, 23 May 2024 05:14:55 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sA0nj-00000006W5h-2OQc;
	Thu, 23 May 2024 01:15:39 -0400
Message-ID: <20240523051539.428826685@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 23 May 2024 01:14:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 stable@vger.kernel.org
Subject: [PATCH v2 1/4] eventfs: Keep the directories from having the same inode number as
 files
References: <20240523051425.335105631@goodmis.org>
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



