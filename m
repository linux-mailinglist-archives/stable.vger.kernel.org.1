Return-Path: <stable+bounces-806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F054B7F7CA4
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9374AB2107E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA703A8C4;
	Fri, 24 Nov 2023 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X4mzUZgO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6C239FEA;
	Fri, 24 Nov 2023 18:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8DB5C433C7;
	Fri, 24 Nov 2023 18:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849823;
	bh=tG2BDSEMI35+9wvMnLtCLjdQCiN2g6ehuO3UkysNrZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X4mzUZgOIMRR2AUGxI0k01ew44oxDSQWhcqhKfTaTnSrhwhY3ZfB9he+BI/RbLwkm
	 v7cL71q0WjGYpggutODFksO0jnMbSBnHcJyMNj6fOCsv3/rjxfH9CaSGaPkaGkOC2r
	 g1a2989S5T4XZ2xDZzPmdAJRaabckwy8IEGK+i1E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Brian Geffon <bgeffon@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.6 335/530] PM: hibernate: Clean up sync_read handling in snapshot_write_next()
Date: Fri, 24 Nov 2023 17:48:21 +0000
Message-ID: <20231124172038.222864964@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

From: Brian Geffon <bgeffon@google.com>

commit d08970df1980476f27936e24d452550f3e9e92e1 upstream.

In snapshot_write_next(), sync_read is set and unset in three different
spots unnecessiarly. As a result there is a subtle bug where the first
page after the meta data has been loaded unconditionally sets sync_read
to 0. If this first PFN was actually a highmem page, then the returned
buffer will be the global "buffer," and the page needs to be loaded
synchronously.

That is, I'm not sure we can always assume the following to be safe:

	handle->buffer = get_buffer(&orig_bm, &ca);
	handle->sync_read = 0;

Because get_buffer() can call get_highmem_page_buffer() which can
return 'buffer'.

The easiest way to address this is just set sync_read before
snapshot_write_next() returns if handle->buffer == buffer.

Signed-off-by: Brian Geffon <bgeffon@google.com>
Fixes: 8357376d3df2 ("[PATCH] swsusp: Improve handling of highmem")
Cc: All applicable <stable@vger.kernel.org>
[ rjw: Subject and changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/power/snapshot.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -2785,8 +2785,6 @@ next:
 	if (handle->cur > 1 && handle->cur > nr_meta_pages + nr_copy_pages + nr_zero_pages)
 		return 0;
 
-	handle->sync_read = 1;
-
 	if (!handle->cur) {
 		if (!buffer)
 			/* This makes the buffer be freed by swsusp_free() */
@@ -2829,7 +2827,6 @@ next:
 			memory_bm_position_reset(&zero_bm);
 			restore_pblist = NULL;
 			handle->buffer = get_buffer(&orig_bm, &ca);
-			handle->sync_read = 0;
 			if (IS_ERR(handle->buffer))
 				return PTR_ERR(handle->buffer);
 		}
@@ -2839,9 +2836,8 @@ next:
 		handle->buffer = get_buffer(&orig_bm, &ca);
 		if (IS_ERR(handle->buffer))
 			return PTR_ERR(handle->buffer);
-		if (handle->buffer != buffer)
-			handle->sync_read = 0;
 	}
+	handle->sync_read = (handle->buffer == buffer);
 	handle->cur++;
 
 	/* Zero pages were not included in the image, memset it and move on. */



