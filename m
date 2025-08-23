Return-Path: <stable+bounces-172539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBA0B3267D
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 04:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 258215661E2
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 02:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159381EB5FD;
	Sat, 23 Aug 2025 02:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E5wG17sU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C644D19E97B
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 02:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755917413; cv=none; b=Y5qkNO/u5YG4LBK1mIXC3FG0rqCj+N5v4IiN3DzYXOAjKdCQDDxjontIlt4vfOKCIr8XC720fqhkrjfpb7+IRaMya7KM8fRrC2wN4C/0863TAUf8pdarCOT5jnq9BbTM221ZmE2+C577eF3kYw2/hGqvNgotvjrsQ26Wm64DVF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755917413; c=relaxed/simple;
	bh=ixHuOxVxIH9FyZ59W1i1pwU9RnlZp02g0d3e4pyEcNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REynOeVLvSlDFXicm/s3qqrieU9LdNDJ9weAqb+7NA4ChZX9YCQO/7jrnph5yYsRscnwEMsGAy4p349kgkU0mII/MxHcCERh6RwLRnhkZkUcOXeX74SaXME9bx6xeO0iwkIps+A5ACe7CjIgzSWy3mYyGtMuvRZxoA4pZQ3rXXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5wG17sU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D778FC4CEED;
	Sat, 23 Aug 2025 02:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755917413;
	bh=ixHuOxVxIH9FyZ59W1i1pwU9RnlZp02g0d3e4pyEcNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E5wG17sUMkxVkIBwZleEyTUfZOMFqstJU51HGXneXnkRTWtD7rHjuGv9akHrAM595
	 NokCLonIX0R7d1BLnwNfBCiPtnMKq1QZ3M9cnOWqwmQZxZ/NCmSbHpGKvph7BMNCmN
	 noZxa2KIEB3KS0FiWwE5oe3ImUPxVLt6RMsGNx7VCO+IRbIYLD2pglvnNDgL72tVug
	 mVjF1eKwCf2V7byTpcfTM929tN3580h4Q+CpxseBU9cxiMvEMPXFix4OjYKJTLIv9C
	 qNp/ERXgVZzJlHOKh9aGA6XNQp2CzsHwPBWSY02SpLMZhuAFxQuyVDpVBeRSoTYH1F
	 hef+HpKFJ3+fA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] f2fs: fix to call clear_page_private_reference in .{release,invalid}_folio
Date: Fri, 22 Aug 2025 22:50:08 -0400
Message-ID: <20250823025009.1694095-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082107-suitcase-motivator-6687@gregkh>
References: <2025082107-suitcase-motivator-6687@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 6779b5db90c5b925293f7ccc5ed5336c5b24ed50 ]

b763f3bedc2d ("f2fs: restructure f2fs page.private layout") missed
to call clear_page_private_reference() in .{release,invalid}_folio,
fix it, though it's not a big deal since folio_detach_private() was
called to clear all privae info and reference count in the page.

BTW, remove page_private_reference() definition as it never be used.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 77de19b6867f ("f2fs: fix to avoid out-of-boundary access in dnode page")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 2 ++
 fs/f2fs/f2fs.h | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index dc8f283f210c..2b018d365b91 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3729,6 +3729,7 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 		}
 	}
 
+	clear_page_private_reference(&folio->page);
 	clear_page_private_gcing(&folio->page);
 
 	if (test_opt(sbi, COMPRESS_CACHE) &&
@@ -3754,6 +3755,7 @@ bool f2fs_release_folio(struct folio *folio, gfp_t wait)
 			clear_page_private_data(&folio->page);
 	}
 
+	clear_page_private_reference(&folio->page);
 	clear_page_private_gcing(&folio->page);
 
 	folio_detach_private(folio);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 1ad9669666e8..ad7bc58ce0a4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1428,7 +1428,6 @@ static inline void clear_page_private_##name(struct page *page) \
 }
 
 PAGE_PRIVATE_GET_FUNC(nonpointer, NOT_POINTER);
-PAGE_PRIVATE_GET_FUNC(reference, REF_RESOURCE);
 PAGE_PRIVATE_GET_FUNC(inline, INLINE_INODE);
 PAGE_PRIVATE_GET_FUNC(gcing, ONGOING_MIGRATION);
 PAGE_PRIVATE_GET_FUNC(atomic, ATOMIC_WRITE);
-- 
2.50.1


