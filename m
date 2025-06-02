Return-Path: <stable+bounces-149612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C7EACB400
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6A0943B7A
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D017922DF85;
	Mon,  2 Jun 2025 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bqZIQXWy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D02F22DF84;
	Mon,  2 Jun 2025 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874486; cv=none; b=JRtt0nBosMTf6hz2C2/eDI6UPT9mxH3q+O8qhf2EUPn4fzybAHHtBB7+kWxQIecvotXIvhbB0g8EcIG3xJCvvzLg5t+br5EK+4sshS7ofCQnij9+4MSklLLdHjjDgdGayUn74v7YAG8C+eGtyrtmtJvMaiaIY8S3oSs6NYbFTVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874486; c=relaxed/simple;
	bh=q2LWGXIXg7e1TfKi/S+nmJTuQtuTz0kYC/7q6SIOSRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6/CeTlje3KLf84HcqXWd7jFjElSL+Lsvu3xZCB2KAbUNhkTp7GzciqGahBKm8k2Vh2XyznJf3wxvYnn6KDjDh5y4JZZim3umzEZXUCa4hDvEoxDe7NYz7U6Pve/oK7IXcR8kZqRJHn0TpmffrWKSaiAU9clifxslUaVwEU4ehA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bqZIQXWy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0E3C4CEEB;
	Mon,  2 Jun 2025 14:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748874486;
	bh=q2LWGXIXg7e1TfKi/S+nmJTuQtuTz0kYC/7q6SIOSRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bqZIQXWydXzANx/AnRkOy/r69hvdClK8oMY0ieVUcVHB8XFU33n6Tt0AEweVyZqml
	 qviPb2C/wMvAFuIdexDRcL7goh8kw8WXqumUuHTw7y7FJtWSmZxKufifqj4YEhxacp
	 w3NbCwVxnzULEveW8jsWfOl6rQKy1yYMARNqQoNE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 5.4 008/204] dm: always update the array size in realloc_argv on success
Date: Mon,  2 Jun 2025 15:45:41 +0200
Message-ID: <20250602134255.802604612@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134255.449974357@linuxfoundation.org>
References: <20250602134255.449974357@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Marzinski <bmarzins@redhat.com>

commit 5a2a6c428190f945c5cbf5791f72dbea83e97f66 upstream.

realloc_argv() was only updating the array size if it was called with
old_argv already allocated. The first time it was called to create an
argv array, it would allocate the array but return the array size as
zero. dm_split_args() would think that it couldn't store any arguments
in the array and would call realloc_argv() again, causing it to
reallocate the initial slots (this time using GPF_KERNEL) and finally
return a size. Aside from being wasteful, this could cause deadlocks on
targets that need to process messages without starting new IO. Instead,
realloc_argv should always update the allocated array size on success.

Fixes: a0651926553c ("dm table: don't copy from a NULL pointer in realloc_argv()")
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Marzinski <bmarzins@redhat.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-table.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -573,9 +573,10 @@ static char **realloc_argv(unsigned *siz
 		gfp = GFP_NOIO;
 	}
 	argv = kmalloc_array(new_size, sizeof(*argv), gfp);
-	if (argv && old_argv) {
-		memcpy(argv, old_argv, *size * sizeof(*argv));
+	if (argv) {
 		*size = new_size;
+		if (old_argv)
+			memcpy(argv, old_argv, *size * sizeof(*argv));
 	}
 
 	kfree(old_argv);



