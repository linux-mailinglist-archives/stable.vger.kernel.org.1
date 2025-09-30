Return-Path: <stable+bounces-182430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC704BAD8AE
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 921D416450F
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98270302CD6;
	Tue, 30 Sep 2025 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iV6jai+9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545EF2236EB;
	Tue, 30 Sep 2025 15:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244922; cv=none; b=EoXxEgorqD8UkEFO+ryWrXRA2ZAKQDvui4l/VH+HVXjQWwX+2R2KbE/dYuxvuzWSq/0OhiBJ9XBmbTJLAlY9OC9bSKvz9bZNDhaNFvvawMO+NV4N29sGpqxqBBnnCDuepU30ImZBO3nyo/H9UeHJl/jBc5SGIItSv/O8ksM+s1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244922; c=relaxed/simple;
	bh=qacLa7A2iCugfKKJ0GF9GRBNhlBhn7PJN34fY3+UDqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjJK9yOOvs6HeupfLrW+7SF4WTgot+dH31kPwVcDYFfIpozGfQC7kEzIbOtU4EDKCLGOcqvJX+korr2xfFwKOAjzlxg5qTVXPhkm08bAU4oXfZMmQpF4c7KmdgocwlbauMkYy5yMhFUwt+2aPedV4etViaF6+XI7XVC3v5OhI6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iV6jai+9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5686C4CEF0;
	Tue, 30 Sep 2025 15:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759244922;
	bh=qacLa7A2iCugfKKJ0GF9GRBNhlBhn7PJN34fY3+UDqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iV6jai+9CdV1fvrUpgl8hzuqiFwBvMVPHwApQOw2D7/Ri/Qx9/EzUa/BPzqSA41oP
	 /2cHmSV6846eQleP8UcSGrtZNL/9BcF3XxqRGLkItN8OgdPjEAKoRgfGRW7mJ0/CyJ
	 prH9kNAsoKPSfYwq2yXdy5Kl6n9bulrBOYmJ7DHc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Scott Haiden <scott.b.haiden@gmail.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 011/151] NFSv4: Dont clear capabilities that wont be reset
Date: Tue, 30 Sep 2025 16:45:41 +0200
Message-ID: <20250930143828.052864745@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143827.587035735@linuxfoundation.org>
References: <20250930143827.587035735@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 31f1a960ad1a14def94fa0b8c25d62b4c032813f ]

Don't clear the capabilities that are not going to get reset by the call
to _nfs4_server_capabilities().

Reported-by: Scott Haiden <scott.b.haiden@gmail.com>
Fixes: b01f21cacde9 ("NFS: Fix the setting of capabilities when automounting a new filesystem")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4proc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 5976a31b09b02..65dae25d6856a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3969,7 +3969,6 @@ int nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 	};
 	int err;
 
-	nfs_server_set_init_caps(server);
 	do {
 		err = nfs4_handle_exception(server,
 				_nfs4_server_capabilities(server, fhandle),
-- 
2.51.0




