Return-Path: <stable+bounces-93359-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC5C9CD8CB
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 07:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1BB6B22920
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 06:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E152187848;
	Fri, 15 Nov 2024 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jw0coeDA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CCF2BB1B;
	Fri, 15 Nov 2024 06:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653658; cv=none; b=gLBxVyk7USU2bwtey3oM4Y6YNHCS+CA74HuD0/Gs/TPto15ckppoIVHCkQmioXYOK6i97IntII6SgN02735TwwLht9s5q2kp7rJp41aCEsaqwnYsPIKgog+GEZrt+3nTEH+EI7tqZl72/a33Lqip496b06cDp16koOyom+5c7+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653658; c=relaxed/simple;
	bh=Uxr+JFCWmfQJuP+9pIwQfQS/s+15YDdQnsWhRlUQXEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOy+aOFKGk0w2CfMSgRVDz6VJjv2Zsxf+IPxVISHA5V5Y+93tc4tjgNYsozQig7Id02SJfrsIlGpqIj7O2ameLfL4lZZIINnwhEKuhWj8CNE+ugpR+B0DbUufxSoHLulTb9v/XbrHHyN94mUmgAzDiYA7WbSe8V5XLKWjt4+07A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jw0coeDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489FAC4CECF;
	Fri, 15 Nov 2024 06:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731653657;
	bh=Uxr+JFCWmfQJuP+9pIwQfQS/s+15YDdQnsWhRlUQXEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jw0coeDAQ7uV/pCNaJABHluAfuwZHBOrkgAi0Fsx6LNxyPTybvzFNgU8GsAe3s9H5
	 todgK5VSkE+47lYOXVzYgvRxyMKgwhNWRH23gi+cWNhrkCPVnhcw/DMoyNHh5NFGR2
	 av0dCnmnmmimX+UX7wxZ+2Vw0RwF2cviYwla0HiE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Omar Sandoval <osandov@fb.com>
Subject: [PATCH 6.1 39/39] 9p: fix slab cache name creation for real
Date: Fri, 15 Nov 2024 07:38:49 +0100
Message-ID: <20241115063724.016298017@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115063722.599985562@linuxfoundation.org>
References: <20241115063722.599985562@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

commit a360f311f57a36e96d88fa8086b749159714dcd2 upstream.

This was attempted by using the dev_name in the slab cache name, but as
Omar Sandoval pointed out, that can be an arbitrary string, eg something
like "/dev/root".  Which in turn trips verify_dirent_name(), which fails
if a filename contains a slash.

So just make it use a sequence counter, and make it an atomic_t to avoid
any possible races or locking issues.

Reported-and-tested-by: Omar Sandoval <osandov@fb.com>
Link: https://lore.kernel.org/all/ZxafcO8KWMlXaeWE@telecaster.dhcp.thefacebook.com/
Fixes: 79efebae4afc ("9p: Avoid creating multiple slab caches with the same name")
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/9p/client.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -967,6 +967,7 @@ error:
 struct p9_client *p9_client_create(const char *dev_name, char *options)
 {
 	int err;
+	static atomic_t seqno = ATOMIC_INIT(0);
 	struct p9_client *clnt;
 	char *client_id;
 	char *cache_name;
@@ -1027,7 +1028,8 @@ struct p9_client *p9_client_create(const
 	if (err)
 		goto close_trans;
 
-	cache_name = kasprintf(GFP_KERNEL, "9p-fcall-cache-%s", dev_name);
+	cache_name = kasprintf(GFP_KERNEL,
+		"9p-fcall-cache-%u", atomic_inc_return(&seqno));
 	if (!cache_name) {
 		err = -ENOMEM;
 		goto close_trans;



