Return-Path: <stable+bounces-167143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3939B2257D
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 13:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E2F623851
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 11:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298252ED175;
	Tue, 12 Aug 2025 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FE7xx+4P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB92422B590
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996825; cv=none; b=tihFJKmdSKoyl5auBNjWaBwIynYaVX0mdgjixFVZ/eNpSvuhw2DMu363BQHxhcqWCvqaVY3ziV8CFDzuMeTO7ynd+hrZ/CUnOri/zc28SxuQmEV1aRdrt0vqZO2j74OtN5JpoWgIONqu979KoYaF6aaKds+Qn2e7Cjp40mqS+3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996825; c=relaxed/simple;
	bh=l+NTt1ltwCa0QFoXsV4Vw/1f6GPcU6Pqj/Zuw/COb/A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pylpuV2rfbquQyjFHEJqoWNGnEbYAopwculL4R0rmX/IKKkHuLYbqnzMyZBHZTWU7AktOgMLot5iyhE0jtRElNXjxJzErrQPZf3TyvPu8gp8Kpi3Y5zeBagkzbeSLg2reLoIAOcZ1pHlnIJfXsjq6xnlMYxRzV8oel6syg8Csrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FE7xx+4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE70C4CEF0;
	Tue, 12 Aug 2025 11:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754996825;
	bh=l+NTt1ltwCa0QFoXsV4Vw/1f6GPcU6Pqj/Zuw/COb/A=;
	h=Subject:To:Cc:From:Date:From;
	b=FE7xx+4Pw+Xw7mEedyZ1yCmq0juKUG8YBnDzE/2FBrU13h0Zd8WvU+StiXmAAlCgS
	 ZkiHoNSCseIURns4U2YN8d7to6wHSyS25wzKNmtPPsXPMPjIuwsKfRrJxuxV6oTnzB
	 G581Jr/aZ9jP7Aafdj7qCvsjcPppvmUrPW6NYJKs=
Subject: FAILED: patch "[PATCH] smb: server: Fix extension string in" failed to apply to 5.10-stable tree
To: thorsten.blum@linux.dev,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 13:06:54 +0200
Message-ID: <2025081253-lapping-empathic-d0ae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8e7d178d06e8937454b6d2f2811fa6a15656a214
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081253-lapping-empathic-d0ae@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8e7d178d06e8937454b6d2f2811fa6a15656a214 Mon Sep 17 00:00:00 2001
From: Thorsten Blum <thorsten.blum@linux.dev>
Date: Wed, 6 Aug 2025 03:03:49 +0200
Subject: [PATCH] smb: server: Fix extension string in
 ksmbd_extract_shortname()

In ksmbd_extract_shortname(), strscpy() is incorrectly called with the
length of the source string (excluding the NUL terminator) rather than
the size of the destination buffer. This results in "__" being copied
to 'extension' rather than "___" (two underscores instead of three).

Use the destination buffer size instead to ensure that the string "___"
(three underscores) is copied correctly.

Cc: stable@vger.kernel.org
Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index 425c756bcfb8..b23203a1c286 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -515,7 +515,7 @@ int ksmbd_extract_shortname(struct ksmbd_conn *conn, const char *longname,
 
 	p = strrchr(longname, '.');
 	if (p == longname) { /*name starts with a dot*/
-		strscpy(extension, "___", strlen("___"));
+		strscpy(extension, "___", sizeof(extension));
 	} else {
 		if (p) {
 			p++;


