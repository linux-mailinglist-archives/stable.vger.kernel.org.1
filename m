Return-Path: <stable+bounces-45085-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E458C5980
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 18:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B9F281DD7
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 16:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85F91802C1;
	Tue, 14 May 2024 16:14:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7545F1802A3;
	Tue, 14 May 2024 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715703298; cv=none; b=uzy50ZoMRtZCfHrT5WEXbOONmwctVoObKTHBbqozudQr27YnQ0CDRF8NkNAQuJS1V25whKgnrSqfu/+dDl1abIdcoT+d3hy+1RhWipd79Rg3nW1p6fGmuUvaS6iMr7AyNTqzpxeeHhTb6rWUpHwkalubC+AaPnXcyE22Y5mHweY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715703298; c=relaxed/simple;
	bh=HLpV0xDXrcqabzliQjZbou/yjBDpiuzUfAJwKFPQUeU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=oSyvhZkWpW4p+yWfkp4PSF1opVdzJl7ckLLaLr996MS6dwvBOChkZfvjgeYpMPUiCPZKu2zEx6xZ+8DeYIR5wxEn7REuYiyY2WS4tX+g2FQ08ROg2n7oQcXVeSjzqj/XEuVh50WPRtoqjiFIdrBzCXRvwCXWZEJbN9Xn9VXptD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF46C4AF0E;
	Tue, 14 May 2024 16:14:58 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1s6uoF-00000003t5w-0Pmr;
	Tue, 14 May 2024 12:15:23 -0400
Message-ID: <20240514161522.959083509@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 14 May 2024 12:14:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Hao Ge <gehao@kylinos.cn>
Subject: [for-next][PATCH 7/7] eventfs: Fix a possible null pointer dereference in
 eventfs_find_events()
References: <20240514161438.134250861@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Hao Ge <gehao@kylinos.cn>

In function eventfs_find_events,there is a potential null pointer
that may be caused by calling update_events_attr which will perform
some operations on the members of the ei struct when ei is NULL.

Hence,When ei->is_freed is set,return NULL directly.

Link: https://lore.kernel.org/linux-trace-kernel/20240513053338.63017-1-hao.ge@linux.dev

Cc: stable@vger.kernel.org
Fixes: 8186fff7ab64 ("tracefs/eventfs: Use root and instance inodes as default ownership")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index a878cea70f4c..0256afdd4acf 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -345,10 +345,9 @@ static struct eventfs_inode *eventfs_find_events(struct dentry *dentry)
 		 * If the ei is being freed, the ownership of the children
 		 * doesn't matter.
 		 */
-		if (ei->is_freed) {
-			ei = NULL;
-			break;
-		}
+		if (ei->is_freed)
+			return NULL;
+
 		// Walk upwards until you find the events inode
 	} while (!ei->is_events);
 
-- 
2.43.0



