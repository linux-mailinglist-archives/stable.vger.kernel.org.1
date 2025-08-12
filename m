Return-Path: <stable+bounces-167148-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3BB4B2262C
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 13:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404D13BE4A6
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 11:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8314D1EF0A6;
	Tue, 12 Aug 2025 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gWdP3qpL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267772D3725
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 11:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754999613; cv=none; b=VDjvNhDHQqpkAtetQFhgVXjyHt9d7GL75ZKsfauW217/CXd6z5etL0qxx/6MiPukYp+td6m5zSiAZQbkFWOfSJMW8eRC0GPErvUOwFxPakYdMJNnuwleQqsoXFhjdkRWsh0qVzO4uBqstonFX0KI6UNT7l9krVx+xAGuHUeOc90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754999613; c=relaxed/simple;
	bh=huhgcdUOsidgl8pIO8pQZa09z07lht6OW5B1p+qX7xE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HqN0Mfkuxfu+E9tssarjiKl9nKHKhMO/VMPbhgpGm0A29/72686dZxjZiDBvFN9CRf5yzdg7aQLIi+5bI7KF3RC3WYxkOhNFPNjej9cbzFKHimpVesNzMHPIxuLPvUltXEa/RVDJO+A+eJSy72qHkhWtWuh3NpSgfTYXtxrlIQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gWdP3qpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57EADC4CEF0;
	Tue, 12 Aug 2025 11:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754999612;
	bh=huhgcdUOsidgl8pIO8pQZa09z07lht6OW5B1p+qX7xE=;
	h=Subject:To:Cc:From:Date:From;
	b=gWdP3qpLECUPMbOGtD5vv48mLM0JBrzcpgQrqKumxLC4E7Kd7QpYQkALOflS+ACji
	 YgsrClZsgJ3cx/iEo8jH+4EhaYhp7oHuuf9ddbJJT75lcecSuvFGiPhtsP+/gqkGQn
	 FnBkJJo37pkrKyRKwcJi5mRQtmKvl/+GiRO4Q+YM=
Subject: FAILED: patch "[PATCH] smb: client: default to nonativesocket under POSIX mounts" failed to apply to 6.6-stable tree
To: pc@manguebit.org,dhowells@redhat.com,m.richardson@ed.ac.uk,slow@samba.org,stable@vger.kernel.org,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 Aug 2025 13:53:29 +0200
Message-ID: <2025081229-unbraided-drinking-9839@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6b445309eec2bc0594f3e24c7777aeef891d386e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081229-unbraided-drinking-9839@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


