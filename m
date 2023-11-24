Return-Path: <stable+bounces-1424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 510C47F7F94
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81B741C214A3
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1E33306F;
	Fri, 24 Nov 2023 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gDbLZOAr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B95A2FC21;
	Fri, 24 Nov 2023 18:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DC6C433C8;
	Fri, 24 Nov 2023 18:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851364;
	bh=Ef8mRr4dJWUVOPjNbvQ5gHyTTSPJ8TvWSRyMOs+lWTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gDbLZOArMUkb9rF4e38cpH67BK+GmBo9/Tjf/A/6V4k3NnDbxjg3jY8ArMM//nKPK
	 x6OgKbH7YNPoPiz8aWo1L5NuXsJe6PyEilQmUYC3RJthG/07kFvzWytDeH3IiYrn+L
	 TPpR8HCqgpz/TG5rw6sLQ3FgnNuhH0R+eTt2i/yQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Su Hui <suhui@nfschina.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6.5 419/491] f2fs: avoid format-overflow warning
Date: Fri, 24 Nov 2023 17:50:55 +0000
Message-ID: <20231124172037.195086779@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Su Hui <suhui@nfschina.com>

commit e0d4e8acb3789c5a8651061fbab62ca24a45c063 upstream.

With gcc and W=1 option, there's a warning like this:

fs/f2fs/compress.c: In function ‘f2fs_init_page_array_cache’:
fs/f2fs/compress.c:1984:47: error: ‘%u’ directive writing between
1 and 7 bytes into a region of size between 5 and 8
[-Werror=format-overflow=]
 1984 |  sprintf(slab_name, "f2fs_page_array_entry-%u:%u", MAJOR(dev),
		MINOR(dev));
      |                                               ^~

String "f2fs_page_array_entry-%u:%u" can up to 35. The first "%u" can up
to 4 and the second "%u" can up to 7, so total size is "24 + 4 + 7 = 35".
slab_name's size should be 35 rather than 32.

Cc: stable@vger.kernel.org
Signed-off-by: Su Hui <suhui@nfschina.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/compress.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1988,7 +1988,7 @@ void f2fs_destroy_compress_inode(struct
 int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi)
 {
 	dev_t dev = sbi->sb->s_bdev->bd_dev;
-	char slab_name[32];
+	char slab_name[35];
 
 	if (!f2fs_sb_has_compression(sbi))
 		return 0;



