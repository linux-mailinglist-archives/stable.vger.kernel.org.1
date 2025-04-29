Return-Path: <stable+bounces-138459-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5817AA1819
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 145A31BC58DE
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3539F24DFF3;
	Tue, 29 Apr 2025 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wWEhR/1m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A8C253F0C;
	Tue, 29 Apr 2025 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745949320; cv=none; b=eyYYIT/ITRp7hkavMDDZM8pqlythztYtvh5qhmGlWvg4KslajMuQDCfejIzfUbhuOeA8p680WnHih7L/Wn4ACeIbR2f1Y1Dx1nm7lEbcufuSeUi+SvuQ0nR4Amsuwrw9ZonD48e99PhJ8+l6H2hcPi0jLbzLr1douR3SGVjCYJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745949320; c=relaxed/simple;
	bh=urJ94jng/aUwoDd+uNH+dd63Q+howVAJPsiu04TavDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQs2Nmr9FNu3KXSpffObwew3jqKnE20na58bb4CIiiPgKoqhuALWSsQGCMGYIwu/riSxuSFOAr+RUENXoPfz8hNlLiliO57Us07ORGuHWeDADsgOJvmu2wTdvkKT2YajmVvlaaffYZz1ATrqu7eQwQJfqTPz7s+LMCg6EJCxqcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wWEhR/1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BDBC4CEE3;
	Tue, 29 Apr 2025 17:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745949320;
	bh=urJ94jng/aUwoDd+uNH+dd63Q+howVAJPsiu04TavDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wWEhR/1mm+8OAZs6FqDENDEAPPWYiZvobiGfA0t76x322x3RONwwlwsOU6wiuNMdc
	 JoIDjHtQd1PxHFK1pN+pE1I/izuBgceawsISpGJTDpyVI/YeD4bWVrxQXgy114l0CG
	 0E7vJ6mkcYZuhPD9He7U+WpQaIx4A6o7vS5dHJFU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nathan Chancellor <nathan@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5.15 252/373] f2fs: Add inline to f2fs_build_fault_attr() stub
Date: Tue, 29 Apr 2025 18:42:09 +0200
Message-ID: <20250429161133.491704661@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Nathan Chancellor <nathan@kernel.org>

commit 0d8968287a1cf7b03d07387dc871de3861b9f6b9 upstream.

When building without CONFIG_F2FS_FAULT_INJECTION, there is a warning
from each file that includes f2fs.h because the stub for
f2fs_build_fault_attr() is missing inline:

  In file included from fs/f2fs/segment.c:21:
  fs/f2fs/f2fs.h:4605:12: warning: 'f2fs_build_fault_attr' defined but not used [-Wunused-function]
   4605 | static int f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned long rate,
        |            ^~~~~~~~~~~~~~~~~~~~~

Add the missing inline to resolve all of the warnings for this
configuration.

Fixes: 4ed886b187f4 ("f2fs: check validation of fault attrs in f2fs_build_fault_attr()")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/f2fs/f2fs.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4376,8 +4376,8 @@ static inline bool f2fs_need_verity(cons
 extern int f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned long rate,
 							unsigned long type);
 #else
-static int f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned long rate,
-							unsigned long type)
+static inline int f2fs_build_fault_attr(struct f2fs_sb_info *sbi,
+					unsigned long rate, unsigned long type)
 {
 	return 0;
 }



