Return-Path: <stable+bounces-98090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8EE9E26F6
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9467828952D
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4F01F890F;
	Tue,  3 Dec 2024 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GSl/YQ7J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6021F7567;
	Tue,  3 Dec 2024 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242756; cv=none; b=HOBKlXrP1r/AJFij6DDGSrUWlTqGx8tbvg3YWG4gcmHzhfhVhyGRZzWeXUTQFPD10fKtZRaHeehWPXVU+lUPfhugT2A+LR5V+vBgJs+a5KfM1L/v/L4eJDUT+hsKEV4FKjgLw3HG4Dnt4rb0NAJtIXoTLPSmneGYExKpAchuPjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242756; c=relaxed/simple;
	bh=6QQBVPgRZtJaClNzS1YzmWuAOocWDlUAu25dBWUTWo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGZKofv56J1S4lVu2Gcu9IT8iSS8Db67Vt05YN7qZwpLbEppHVmaIA3FLs8M/425wlQF6R8LHM6DRKoedW/K7k9gkl8lNLn4JZSyrK+40FMRpeD84v4gOr5uVDKhPYhvyEid/s9FtSEqbSfpTmyA4cMuiEjXgL0IlnE8i2z8R08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GSl/YQ7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF2AC4CECF;
	Tue,  3 Dec 2024 16:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733242756;
	bh=6QQBVPgRZtJaClNzS1YzmWuAOocWDlUAu25dBWUTWo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GSl/YQ7JODUt/3q+yy2dHhKJ5NOHc6Z02tXitzmUfdRtylKTEoNwJobNW36zCuo57
	 +2zRfhj1HkQcB+wv6HDLU+8PGVWbh+rRKo2y8W5f8Ifr3IrNfMscr8yps2LN/zqXMU
	 WVCTMBST7XBL9/Ju9oJ5uG4/5RRdHrkeBX8cSepo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Enzo Matsumiya <ematsumiya@suse.de>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 801/826] smb: client: disable directory caching when dir_cache_timeout is zero
Date: Tue,  3 Dec 2024 15:48:48 +0100
Message-ID: <20241203144815.004313356@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Henrique Carvalho <henrique.carvalho@suse.com>

[ Upstream commit ceaf1451990e3ea7fb50aebb5a149f57945f6e9f ]

Setting dir_cache_timeout to zero should disable the caching of
directory contents. Currently, even when dir_cache_timeout is zero,
some caching related functions are still invoked, which is unintended
behavior.

Fix the issue by setting tcon->nohandlecache to true when
dir_cache_timeout is zero, ensuring that directory handle caching
is properly disabled.

Fixes: 238b351d0935 ("smb3: allow controlling length of time directory entries are cached with dir leases")
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
Reviewed-by: Enzo Matsumiya <ematsumiya@suse.de>
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index fa07708f2e320..a94c538ff8636 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2594,7 +2594,7 @@ cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 
 	if (ses->server->dialect >= SMB20_PROT_ID &&
 	    (ses->server->capabilities & SMB2_GLOBAL_CAP_DIRECTORY_LEASING))
-		nohandlecache = ctx->nohandlecache;
+		nohandlecache = ctx->nohandlecache || !dir_cache_timeout;
 	else
 		nohandlecache = true;
 	tcon = tcon_info_alloc(!nohandlecache, netfs_trace_tcon_ref_new);
-- 
2.43.0




