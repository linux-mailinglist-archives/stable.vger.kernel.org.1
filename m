Return-Path: <stable+bounces-178047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AD0B47BEF
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 17:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4EF617D263
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 15:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541B927B325;
	Sun,  7 Sep 2025 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmYRjEhP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FAE15278E
	for <stable@vger.kernel.org>; Sun,  7 Sep 2025 15:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757257719; cv=none; b=cv4iSI/DuHi3O1FRfsOzosCFLqZLzPLAom6qwcheLrMZU1dCPIMI+gnx4qXiaDYFXoqeMIMghl3GGJ1eLBmhEzqe3t3PEJOA/bCLksV7HB7jUWbxFw0gBTTJw7UbH9YIBFq6eoQuZ8jIc3HsVKwUtIWtzJl0JQ1IXKdMbZnBZSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757257719; c=relaxed/simple;
	bh=acSQnJre62tbXMk7G9hvNwoVEPzXN8gEWtw6Y2aU3oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5raoixQPdBfj69P6ZTKJpRd2zWYOX58nlUfm+81GG7cYy7UjLqBr3fy0mnysWzJte8zqPd3PoNceXMrsdgPddI7sf99coceUqKAzW/EdAjdMKkmaeioDEsaY+Q/u2Pv3Pwk0Sn6jwNstEq9X589TTqKEljZA1OS02hf9ET1se8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmYRjEhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CCBC4CEF0;
	Sun,  7 Sep 2025 15:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757257718;
	bh=acSQnJre62tbXMk7G9hvNwoVEPzXN8gEWtw6Y2aU3oY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lmYRjEhPAgNbZ/EuwmVoVZJ1ttOPEUpvyGjeDqsUxepjY8LTHF5K6SZD3lGXNTKgj
	 aH0CsXASKjOVFcAt4KlREVLwExw5PTjGnCwHxxSp4z88uzyMet8gAzsRKuh8l4leCC
	 3YpQpCvQGCPo6ks9oGmkSIVY8fTub5O9JrlGdUdBbW5YCHVweIelsn0Il0oic8ls39
	 7MUXaeq0kxC5JmrRsVM3JKD6Dm7orTn18lHTCgpk3QQgKxS8UmiHLgoMaHk8rjXc1v
	 gnOVpUUWS+YH8NCUcNIouL5+O2CVk4W8X/h14vyDyq9ys3HdWgw0W6r50MIHGp9r66
	 Yu/T1kq7w+4/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Roman Smirnov <r.smirnov@omp.ru>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] cifs: fix integer overflow in match_server()
Date: Sun,  7 Sep 2025 11:08:36 -0400
Message-ID: <20250907150836.640197-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025041700-afar-darkness-e9b8@gregkh>
References: <2025041700-afar-darkness-e9b8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Roman Smirnov <r.smirnov@omp.ru>

[ Upstream commit 2510859475d7f46ed7940db0853f3342bf1b65ee ]

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
[ Adapted to older CIFS filesystem structure and mount option parsing ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index d8d9d90615440..93fc906f732bc 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2144,6 +2144,11 @@ cifs_parse_mount_options(const char *mountdata, const char *devname,
 					 __func__);
 				goto cifs_parse_mount_err;
 			}
+			if (option < SMB_ECHO_INTERVAL_MIN ||
+			    option > SMB_ECHO_INTERVAL_MAX) {
+				cifs_dbg(VFS, "echo interval is out of bounds\n");
+				goto cifs_parse_mount_err;
+			}
 			vol->echo_interval = option;
 			break;
 		case Opt_snapshot:
-- 
2.51.0


