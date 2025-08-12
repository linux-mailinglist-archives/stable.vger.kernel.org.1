Return-Path: <stable+bounces-167149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C31B2262E
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 13:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03FAF3B3038
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 11:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD942E62D8;
	Tue, 12 Aug 2025 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pEWgDGGk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D88F248F6A
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754999621; cv=none; b=XYUTP/U2zBRKra5UIfQbCleO1TbM6V6BUtxdp5Vy3L8yk0O+RYKVMOmtdTTLzM9zD6rU4tNN2ENcts2q3TI1GBUmLp6dh1gF6+MVLOtCKjp7zO7UoeGvGcXgiWsygKyQIqoOCpKRgqqRP+j+WBbolGFn3RkPlsPDgAYOuVQGYV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754999621; c=relaxed/simple;
	bh=GfTmQBKKGEDqvpf/xYuNwIKlREH9vUt9gCYqmZOfWQY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ujMdNQtjmkPaK6fuJ2HQnxWsjcMgtRX8jEJc+Ls8KKyteit91TKZSf+wdpyypLwndPVr5Ny+kKE/84jMbkuMj5wOLUYXc/rb6W2Jfq8oOlXhPbnGDf90hmxtO3/ylr0OjNkGvl4md6GVDY+k92TZDR2ws7nMkCQvqfWRIHBqN/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pEWgDGGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDB2C4CEF4;
	Tue, 12 Aug 2025 11:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754999621;
	bh=GfTmQBKKGEDqvpf/xYuNwIKlREH9vUt9gCYqmZOfWQY=;
	h=Subject:To:Cc:From:Date:From;
	b=pEWgDGGkx4DtbCvuk80NgXWqIAwDlMSE+L2cAmA4aLElFgeNTolLoxnA8qgIrO4Us
	 vuNYSmwoN8jPwi1fd/R5V6ZiZ+cUZqdmgydcn1o7E+k7wWUFJDnvLo9Mbof9CtKlrd
	 ZtQtrf1i+5a7mIxJ6tq/eL9TRsE31ulDQg4laRmk=
Subject: FAILED: patch "[PATCH] smb: client: default to nonativesocket under POSIX mounts" failed to apply to 6.12-stable tree
To: pc@manguebit.org,dhowells@redhat.com,m.richardson@ed.ac.uk,slow@samba.org,stable@vger.kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 13:53:29 +0200
Message-ID: <2025081229-blizzard-gout-ee04@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 6b445309eec2bc0594f3e24c7777aeef891d386e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081229-blizzard-gout-ee04@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6b445309eec2bc0594f3e24c7777aeef891d386e Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Thu, 31 Jul 2025 20:46:42 -0300
Subject: [PATCH] smb: client: default to nonativesocket under POSIX mounts

SMB3.1.1 POSIX mounts require sockets to be created with NFS reparse
points.

Cc: linux-cifs@vger.kernel.org
Cc: Ralph Boehme <slow@samba.org>
Cc: David Howells <dhowells@redhat.com>
Cc: <stable@vger.kernel.org>
Reported-by: Matthew Richardson <m.richardson@ed.ac.uk>
Closes: https://marc.info/?i=1124e7cd-6a46-40a6-9f44-b7664a66654b@ed.ac.uk
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index cc8bd79ebca9..072383899e81 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -1652,6 +1652,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 				pr_warn_once("conflicting posix mount options specified\n");
 			ctx->linux_ext = 1;
 			ctx->no_linux_ext = 0;
+			ctx->nonativesocket = 1; /* POSIX mounts use NFS style reparse points */
 		}
 		break;
 	case Opt_nocase:


