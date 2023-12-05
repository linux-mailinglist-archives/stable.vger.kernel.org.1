Return-Path: <stable+bounces-4569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E75804809
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D169A1F21F3A
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307958C05;
	Tue,  5 Dec 2023 03:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nSgG0/xt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54986FB0;
	Tue,  5 Dec 2023 03:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F8BC433C7;
	Tue,  5 Dec 2023 03:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747908;
	bh=q+tGmGCMMJgw9NhItmZIjJWmEAH/fp5qtgFdjvRqJsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nSgG0/xtybfjFhOXz/h/O5iV9noOBxia31mcMtk63zAFXzgyhinInkPJoRFC0e/E1
	 5DLIv8Ix8qzA9FrpHSGnWTH+rH/jm3vYGkgdkOrJOUjkxeowCeEt5tbux3iU2LOxXy
	 XeUNU+cqCfabZN5VPKOGiQCWUYAevPIt/vB8ilrw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 19/94] afs: Fix file locking on R/O volumes to operate in local mode
Date: Tue,  5 Dec 2023 12:16:47 +0900
Message-ID: <20231205031523.973840052@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031522.815119918@linuxfoundation.org>
References: <20231205031522.815119918@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit b590eb41be766c5a63acc7e8896a042f7a4e8293 ]

AFS doesn't really do locking on R/O volumes as fileservers don't maintain
state with each other and thus a lock on a R/O volume file on one
fileserver will not be be visible to someone looking at the same file on
another fileserver.

Further, the server may return an error if you try it.

Fix this by doing what other AFS clients do and handle filelocking on R/O
volume files entirely within the client and don't touch the server.

Fixes: 6c6c1d63c243 ("afs: Provide mount-time configurable byte-range file locking emulation")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/afs/super.c b/fs/afs/super.c
index eb04dcc543289..554119068ea44 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -391,6 +391,8 @@ static int afs_validate_fc(struct fs_context *fc)
 			return PTR_ERR(volume);
 
 		ctx->volume = volume;
+		if (volume->type != AFSVL_RWVOL)
+			ctx->flock_mode = afs_flock_mode_local;
 	}
 
 	return 0;
-- 
2.42.0




