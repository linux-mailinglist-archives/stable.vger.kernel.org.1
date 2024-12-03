Return-Path: <stable+bounces-97262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCFA9E23A8
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1E91688D4
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5F4207A03;
	Tue,  3 Dec 2024 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Txs2eGGN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFAB205E35;
	Tue,  3 Dec 2024 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239980; cv=none; b=aQN3cFTz/NDuwDSoSIs7WtK1JisRsQOTxfTwV8SPej5jIBw55A03AZjsaxPgl6P25k/5hk6ujFAV2Ax+U5Cqsr2t4KE3/tUBoxB6jscVr1xdxEwqYDXyITxI6vp9ts3gY6Ny85wGQzTJ2PweF5qhwWYCUkHtFkyLhbGqlxCRYo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239980; c=relaxed/simple;
	bh=8IhWj7CyFEqx6EzKpbWfiICPY7TNJG88xXGK5vf0CIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ft1844it9TQO9nbvKPnXZWHuXMOfnQRunq1KWwp7j96xF4Mfbv0EH9vNXkpzUV6nTr/IcSVfAnYfYiepUEvQ7iy2g/ba/TZGnMgEva1EbsbsWFdMOsczGBqq/IdygnlwVKyLFmxK3MxGBcKAimScR/MsO4hYStCqTI8cyBz++Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Txs2eGGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53033C4CED8;
	Tue,  3 Dec 2024 15:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733239980;
	bh=8IhWj7CyFEqx6EzKpbWfiICPY7TNJG88xXGK5vf0CIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Txs2eGGN16yEY5wRT4qe8iPPvsBVFKUTiwuYHM7q6fQrSYianlV7NhyIYn92tCiDN
	 Zp3bAkDYKX29tmVIXVGSlNsYrJwcGJruKwtIKAKNWkTSRHoFo+OlYv23AZydTs5IZo
	 thqkJH2t6rl8JPEHXznEuksNvZXVfBKUsfE073j8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Aurich <paul@darkrain42.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 800/817] smb: Initialize cfid->tcon before performing network ops
Date: Tue,  3 Dec 2024 15:46:12 +0100
Message-ID: <20241203144027.253924837@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Aurich <paul@darkrain42.org>

[ Upstream commit c353ee4fb119a2582d0e011f66a76a38f5cf984d ]

Avoid leaking a tcon ref when a lease break races with opening the
cached directory. Processing the leak break might take a reference to
the tcon in cached_dir_lease_break() and then fail to release the ref in
cached_dir_offload_close, since cfid->tcon is still NULL.

Fixes: ebe98f1447bb ("cifs: enable caching of directories for which a lease is held")
Signed-off-by: Paul Aurich <paul@darkrain42.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cached_dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 004349a7ab69d..9c0ef4195b582 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -227,6 +227,7 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 		}
 	}
 	cfid->dentry = dentry;
+	cfid->tcon = tcon;
 
 	/*
 	 * We do not hold the lock for the open because in case
@@ -298,7 +299,6 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 		}
 		goto oshr_free;
 	}
-	cfid->tcon = tcon;
 	cfid->is_open = true;
 
 	spin_lock(&cfids->cfid_list_lock);
-- 
2.43.0




