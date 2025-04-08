Return-Path: <stable+bounces-131497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FDCA80B2E
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA6A503259
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E454826FA5D;
	Tue,  8 Apr 2025 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pt7rnFnx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D9F26FA57;
	Tue,  8 Apr 2025 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116559; cv=none; b=dtcEWUGrokpbGJy/wVLp/1QQyw4Wyg2SOqdnOx41vES3uEzZfpJYI2Gqqosvs6TKvae3ixrL578BUBY2MvvKCUwdgribnc+FbRukk5YlX/bN2oNJgNq3t6TzrGNeqAZ2MeyB0WZSwLjlAeBlPDtDuWeOe4zshEmZx62nwjv87b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116559; c=relaxed/simple;
	bh=cyNARMMsY6Vk8UULX2LbPcP8MrOdnuulfl6rGThExHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBphRytcA8r04L9W1YHhLpliS2b6wpSMpQjQ1uX5whhVj/K67gu16wDu2rGAsyZrlBp6DwzRWpx7V57nzacdCzfxU6WpvQC/ULcHXnqYhW3qz97UrpifPVMRi5E1yeWlBvEbW/wafr7NGZWov8IwIOIUld12Z99SFf48kQ1pFj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pt7rnFnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C29C4CEE5;
	Tue,  8 Apr 2025 12:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116559;
	bh=cyNARMMsY6Vk8UULX2LbPcP8MrOdnuulfl6rGThExHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pt7rnFnxxJUVrbQ/BCad5v9jFJtgmtYJknG4aJbwKt1FHAloqGym/6OO47ANncd4W
	 ylbhS1lSKKoT8C2VJg6O6WQQQVuBMI5lGlpKsyqKvJNGe2k3SpnjqlUiOardgoEedi
	 UhB1/fAnTIfyuuhoWqz07TXmTgZWhLFU7DqZvUQ0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 185/423] fs/ntfs3: Prevent integer overflow in hdr_first_de()
Date: Tue,  8 Apr 2025 12:48:31 +0200
Message-ID: <20250408104850.051087715@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 6bb81b94f7a9cba6bde9a905cef52a65317a8b04 ]

The "de_off" and "used" variables come from the disk so they both need to
check.  The problem is that on 32bit systems if they're both greater than
UINT_MAX - 16 then the check does work as intended because of an integer
overflow.

Fixes: 60ce8dfde035 ("fs/ntfs3: Fix wrong if in hdr_first_de")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/ntfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 241f2ffdd9201..1ff13b6f96132 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -717,7 +717,7 @@ static inline struct NTFS_DE *hdr_first_de(const struct INDEX_HDR *hdr)
 	struct NTFS_DE *e;
 	u16 esize;
 
-	if (de_off >= used || de_off + sizeof(struct NTFS_DE) > used )
+	if (de_off >= used || size_add(de_off, sizeof(struct NTFS_DE)) > used)
 		return NULL;
 
 	e = Add2Ptr(hdr, de_off);
-- 
2.39.5




