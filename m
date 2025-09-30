Return-Path: <stable+bounces-182403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A244BAD90B
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B17CD3A6996
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5400302CD6;
	Tue, 30 Sep 2025 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fx1U1h4W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A138C266B65;
	Tue, 30 Sep 2025 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244832; cv=none; b=ttTsuUJIIYDpKTJdhIwaL1+zixEN04vN811+/zeJoOQL6gSLbwQqX12jF6b8VWAZMvEDLH8O7zEmY7550bwu4fPhB085cCfv9VGTc7QEv7fTWpI08H0YJmDzY85zfVocVzpBdEU54QjMU/2rMRjZGj5x3JQ+kfc2r7TATaYMHcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244832; c=relaxed/simple;
	bh=Hy+5Ia2L29R/I1bicQ8HlHNDReawFVR15YRSRb0Dfkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzedlJfMulEZPm1Pt+7FPlrmUjlCbUuYFwa/hJEBdagPzVs8YW0WSxfsAgp1l6I41QCTp7qpoZK+kcRYx8Uq6wu7KE3zDQznuVHmYFpVpvgxxFN11nEuM5TUHWnofZvldBVTrOuaZ/E30D/PNtNePO4MSyzxEfmlgbh7mkdHzMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fx1U1h4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255B5C4CEF0;
	Tue, 30 Sep 2025 15:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759244832;
	bh=Hy+5Ia2L29R/I1bicQ8HlHNDReawFVR15YRSRb0Dfkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fx1U1h4W9f9a0nSxXBxD1HRe8WK5TEWSwO7Q6msdm0Dm3ntHSM4KXZEaOkGK6L3tJ
	 LYA4Bc/wgd5SdB02qK/kam7fIWWa+frQ8Es/75JYTD7olt0VbE69jeW+VpwjcuwRzI
	 xhWi82CNtkhAcgmGzO1/8kPAYmO/HkXH6w8IKVAU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 096/143] smb: client: fix wrong index reference in smb2_compound_op()
Date: Tue, 30 Sep 2025 16:47:00 +0200
Message-ID: <20250930143835.053595874@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143831.236060637@linuxfoundation.org>
References: <20250930143831.236060637@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sang-Heon Jeon <ekffu200098@gmail.com>

[ Upstream commit fbe2dc6a9c7318f7263f5e4d50f6272b931c5756 ]

In smb2_compound_op(), the loop that processes each command's response
uses wrong indices when accessing response bufferes.

This incorrect indexing leads to improper handling of command results.
Also, if incorrectly computed index is greather than or equal to
MAX_COMPOUND, it can cause out-of-bounds accesses.

Fixes: 3681c74d342d ("smb: client: handle lack of EA support in smb2_query_path_info()") # 6.14
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 86cad8ee8e6f3..ac3ce183bd59a 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -687,7 +687,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 	}
 
 	for (i = 0; i < num_cmds; i++) {
-		char *buf = rsp_iov[i + i].iov_base;
+		char *buf = rsp_iov[i + 1].iov_base;
 
 		if (buf && resp_buftype[i + 1] != CIFS_NO_BUFFER)
 			rc = server->ops->map_error(buf, false);
-- 
2.51.0




