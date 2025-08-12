Return-Path: <stable+bounces-167141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5783B22571
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 13:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C81F1B67AB3
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 11:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326522ECEB5;
	Tue, 12 Aug 2025 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kPah4tfd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFAC22B590
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996819; cv=none; b=I2sZc5aD9ihNieCMkMx2HywrH4LwqrRwo5v4/pXVVcJwqPORT9siGDkFCIAZzo5a6/uR6Gyj3zURq6XaTDgSGk1mVQLcgxXbgIapMMvlZ75WSTLZNm2iIrpVYKQYU9I4xzL6N8PZZNHMSOeLpm8MkIBRZJ5POcilm430E5OUhMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996819; c=relaxed/simple;
	bh=JCyzIskBRc46xYDoL4eMQnD1Hk7cO0TDOCOzHcG0puo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ff5RJk/Cnaisw9w/FMD6dn+T4geuEKQx9lXzyuoE+md9Dn3HlptlANpntWnx2mnyM1ECpHon5G6DA2q+ONuS7zx4LJTsvDje5ioH3zrzhpwrKI58hakbocRGwf80SQq72adn1XaGN6SvKWRA+z9Y0OyvWuDcdX64WM32NSUvg9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kPah4tfd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0747C4CEF0;
	Tue, 12 Aug 2025 11:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754996818;
	bh=JCyzIskBRc46xYDoL4eMQnD1Hk7cO0TDOCOzHcG0puo=;
	h=Subject:To:Cc:From:Date:From;
	b=kPah4tfdHo/puCCr+sRBCJGCED85UQIVSiP/lbm7UIO9gyo4NQ1tf/vi+YTd9S0gD
	 9aTAcsjjZsMyFvH1a8Zzo0jvl7r2/k2depIKD47/uT2eiEq4b6vJ6PgmCFQWI7BH/d
	 spxR91R3S5UCSinZQ8AXNoxJQNtpg0Y0LrxMdDEE=
Subject: FAILED: patch "[PATCH] smb: server: Fix extension string in" failed to apply to 6.1-stable tree
To: thorsten.blum@linux.dev,linkinjeon@kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 13:06:49 +0200
Message-ID: <2025081249-afar-gesture-7178@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8e7d178d06e8937454b6d2f2811fa6a15656a214
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081249-afar-gesture-7178@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


