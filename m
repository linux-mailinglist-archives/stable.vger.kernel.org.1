Return-Path: <stable+bounces-18966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F18B084B4E0
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 13:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30DE41C23743
	for <lists+stable@lfdr.de>; Tue,  6 Feb 2024 12:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E5413A274;
	Tue,  6 Feb 2024 12:09:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B4513A249;
	Tue,  6 Feb 2024 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221363; cv=none; b=sgVaxBk79lvxaKYaYY+QDiqYoZsUn6l0MEkrKWxTYJFYF/1BTX0eLgBBdtth2d9DTxls4/zShrWnOzAzcgZoCOkwIb8Q+JYS16DLj3ljdoFRXnr+Ce5oMCOKIUjaYqIN++LrECm7J0V3SqiBy/BaVtg1lZssNpmJev7wiwrZ39U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221363; c=relaxed/simple;
	bh=A6km+89cOenaTUCTGM2bbrRlmoPT20kCCDzU5yT3Os4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=bRyJa1nWC4/f3gZBpwM9Z0updoZwxPefDP0FgmE6eYQaUGUKMJMsOqSXKLd0ZdXcNzwsDPvb03umtvyuR4OpTsvgRU18XjgxQlhXKVa5VWp6wQam+VK9Pt1V2GT2XzRjdExgfB+wxYqp3twwML6edACeN9SkCxVWqNFuxSB9KS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1FEC43399;
	Tue,  6 Feb 2024 12:09:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@rostedt.homelinux.com>)
	id 1rXKGu-00000006bIL-0CTn;
	Tue, 06 Feb 2024 07:09:52 -0500
Message-ID: <20240206120951.901001747@rostedt.homelinux.com>
User-Agent: quilt/0.67
Date: Tue, 06 Feb 2024 07:09:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [v6.6][PATCH 34/57] eventfs: Fix bitwise fields for "is_events"
References: <20240206120905.570408983@rostedt.homelinux.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

A flag was needed to denote which eventfs_inode was the "events"
directory, so a bit was taken from the "nr_entries" field, as there's not
that many entries, and 2^30 is plenty. But the bit number for nr_entries
was not updated to reflect the bit taken from it, which would add an
unnecessary integer to the structure.

Link: https://lore.kernel.org/linux-trace-kernel/20240102151832.7ca87275@gandalf.local.home

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: 7e8358edf503e ("eventfs: Fix file and directory uid and gid ownership")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
(cherry picked from commit fd56cd5f6d76e93356d9520cf9dabffe1e3d1aa0)
---
 fs/tracefs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index 899e447778ac..42bdeb471a07 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -63,7 +63,7 @@ struct eventfs_inode {
 	};
 	unsigned int			is_freed:1;
 	unsigned int			is_events:1;
-	unsigned int			nr_entries:31;
+	unsigned int			nr_entries:30;
 };
 
 static inline struct tracefs_inode *get_tracefs(const struct inode *inode)
-- 
2.43.0



