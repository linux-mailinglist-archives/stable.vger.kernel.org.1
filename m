Return-Path: <stable+bounces-66049-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FC494BF8C
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 16:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10D8EB286C0
	for <lists+stable@lfdr.de>; Thu,  8 Aug 2024 14:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D823518EFD7;
	Thu,  8 Aug 2024 14:21:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D4C18E773;
	Thu,  8 Aug 2024 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723126883; cv=none; b=tl9H60jkb64/k0iMKVZNa5qiSw8hNxvq8RgQAhYSewDXtn9HuHdxivQ9H90yfScc+WMlZcuJ9BlIq8j6/+/RBdBqDs5CEUjy1q3R/GJow62qNz/KNrKUDZmJ7dfpeDbvqIu+XgYrc1CF/0+LN9t2wAmKx1E8sZbYNJ5Wvo+a2FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723126883; c=relaxed/simple;
	bh=9JaoHosOsDbMbFRwJiBeE/EHAXdlMeXCp55nrBr57E4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=H82sWc3VyiL1uCTzQRGkpVh9Lfsn3U57UZRETC/r+xXlkSVYyn5mlJkjKuXzgv0jO8B3Kzw4/dyJXwsBRKEcs8YPD7OMWK7KwC2BPfWaAIfVllymzcebvhwP2k5hmH0KAtjUTMdT6Q8jR/ASo5viYSlSQpWw7GLKVRRgiaEGJts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC32C4AF0F;
	Thu,  8 Aug 2024 14:21:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sc416-00000000BRW-0ryC;
	Thu, 08 Aug 2024 10:21:24 -0400
Message-ID: <20240808142124.066927349@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 08 Aug 2024 10:20:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Ajay Kaher <ajay.kaher@broadcom.com>,
 Mathias Krause <minipli@grsecurity.net>
Subject: [for-linus][PATCH 4/9] eventfs: Dont return NULL in eventfs_create_dir()
References: <20240808142037.495820579@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Mathias Krause <minipli@grsecurity.net>

Commit 77a06c33a22d ("eventfs: Test for ei->is_freed when accessing
ei->dentry") added another check, testing if the parent was freed after
we released the mutex. If so, the function returns NULL. However, all
callers expect it to either return a valid pointer or an error pointer,
at least since commit 5264a2f4bb3b ("tracing: Fix a NULL vs IS_ERR() bug
in event_subsystem_dir()"). Returning NULL will therefore fail the error
condition check in the caller.

Fix this by substituting the NULL return value with a fitting error
pointer.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org
Fixes: 77a06c33a22d ("eventfs: Test for ei->is_freed when accessing ei->dentry")
Link: https://lore.kernel.org/20240723122522.2724-1-minipli@grsecurity.net
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Ajay Kaher <ajay.kaher@broadcom.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 5d88c184f0fc..a9c28a1d5dc8 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -736,7 +736,7 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
 	/* Was the parent freed? */
 	if (list_empty(&ei->list)) {
 		cleanup_ei(ei);
-		ei = NULL;
+		ei = ERR_PTR(-EBUSY);
 	}
 	return ei;
 }
-- 
2.43.0



