Return-Path: <stable+bounces-133109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D90CA91DFB
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2173AD8C2
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2EA35972;
	Thu, 17 Apr 2025 13:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aPbe/D+r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0782376E6
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896442; cv=none; b=ld7ZZSDkpzsTyAD9VrZkytdBSNJfsPT+bThW/L4FdAOmAIyWhFYMvRE7ZZYpd6Q4+BqkSAxguBT+eDBulYpzRSFp883YP4mp2zY9p1rsRWCiMHCW5UUlHDm/igiv+g3H0CkJIGjisJlQCWdLLKT62hMa4ko96ndtpBbH1+5xWb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896442; c=relaxed/simple;
	bh=AdDI14G423Nd3osv63ZE7b06MpPqga9ff4+0DGMolGo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XQfDQJEfyxS9kQVjjIw4Nc/zEyVj9734EnLAuigyxaMFn4xAT3QmrlersYaAz9DVEPi306aJvNTj+HcHbbTiJJ0Sd4PJP8n2lNOyyjr4pI+i+WfI1JBvjOCoA1k8bxOEbS14+VpDZ/on8wz+K602WWJmbAAQM94FDNzone1b1Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aPbe/D+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462E3C4CEE4;
	Thu, 17 Apr 2025 13:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744896442;
	bh=AdDI14G423Nd3osv63ZE7b06MpPqga9ff4+0DGMolGo=;
	h=Subject:To:Cc:From:Date:From;
	b=aPbe/D+rYqhh7l/2BOqzpxhLKAzh+HqUAt54R2jhPFNzBZj05RQ8c96GEuQspx7zk
	 +sY0wWCWqCDNiqXdFW4zp9sURHpsanEKfjL68t/BTMflQj5BaOVKA7fHvPmjPLjVfR
	 c1L2vezgcctdgUqKMEKFRW16jqRe7lMfQw4hGFfY=
Subject: FAILED: patch "[PATCH] cifs: fix integer overflow in match_server()" failed to apply to 5.4-stable tree
To: r.smirnov@omp.ru,stfrench@microsoft.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 15:21:00 +0200
Message-ID: <2025041700-afar-darkness-e9b8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 2510859475d7f46ed7940db0853f3342bf1b65ee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041700-afar-darkness-e9b8@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2510859475d7f46ed7940db0853f3342bf1b65ee Mon Sep 17 00:00:00 2001
From: Roman Smirnov <r.smirnov@omp.ru>
Date: Mon, 31 Mar 2025 11:22:49 +0300
Subject: [PATCH] cifs: fix integer overflow in match_server()

The echo_interval is not limited in any way during mounting,
which makes it possible to write a large number to it. This can
cause an overflow when multiplying ctx->echo_interval by HZ in
match_server().

Add constraints for echo_interval to smb3_fs_context_parse_param().

Found by Linux Verification Center (linuxtesting.org) with Svace.

Fixes: adfeb3e00e8e1 ("cifs: Make echo interval tunable")
Cc: stable@vger.kernel.org
Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index bdb762d398af..9c3ded0cf006 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -1383,6 +1383,11 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		ctx->closetimeo = HZ * result.uint_32;
 		break;
 	case Opt_echo_interval:
+		if (result.uint_32 < SMB_ECHO_INTERVAL_MIN ||
+		    result.uint_32 > SMB_ECHO_INTERVAL_MAX) {
+			cifs_errorf(fc, "echo interval is out of bounds\n");
+			goto cifs_parse_mount_err;
+		}
 		ctx->echo_interval = result.uint_32;
 		break;
 	case Opt_snapshot:


