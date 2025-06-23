Return-Path: <stable+bounces-158022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D5AAE56AC
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9744E0E59
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C1B225A3D;
	Mon, 23 Jun 2025 22:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zhZJe8th"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3219A225762;
	Mon, 23 Jun 2025 22:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717292; cv=none; b=YpWWGsxUkRNMPgT4ykTlR365TYkHG/CTypEzK83EuMFy+OoL/HsSle9vHZr+9rczKfDY0ekFg8NQuf1naMB4PRkhaQzNn0jy2vklvW+Yz5BMRiSGng7e2f3Bxj38WWg4qvsSWZVHTj4ackSB7PMYxbaTFFWGssyPDA9m19UBlzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717292; c=relaxed/simple;
	bh=9Hf/zlO//nREhkeVbct807iwJ+9G5mzCPTfKtYjZqVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FwGy+1ATb2mwWKpA2xt7KEfYBhwOE/KFL0ppqpOCxW16t5DbrI5S/Bg4HRPQWr8SSiO70joj4dMeZXOQG9XQ0Etyj0umpaTxeMpsbwYWAwcv8rJ9F6JRbkQ06gKSPydUd57Tss4mVZHl0WsuGFtEd/OlR7b8NpGwGaX7AylusYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zhZJe8th; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3219C4CEEA;
	Mon, 23 Jun 2025 22:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717292;
	bh=9Hf/zlO//nREhkeVbct807iwJ+9G5mzCPTfKtYjZqVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zhZJe8thKWc/GqRp3XEOMzl9fXBWqDBrp26PCGYEAjWhk3PPBqnSJ2O8mCAEMFPjI
	 tRIPPqlUWWELD4yKENhdC8Hjrvn1CizLhAvdV9C2sPS8VrQHtNzz5NZ5tmQAETAeZg
	 rAavVq8OlQ8dzJvoJv/REFd0axuK2CXRL93YT+DY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 590/592] cifs: Remove duplicate fattr->cf_dtype assignment from wsl_to_fattr() function
Date: Mon, 23 Jun 2025 15:09:08 +0200
Message-ID: <20250623130714.469080258@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130700.210182694@linuxfoundation.org>
References: <20250623130700.210182694@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pali Rohár <pali@kernel.org>

[ Upstream commit 840738eae94864993a735ab677b9795bb8f3b961 ]

Commit 8bd25b61c5a5 ("smb: client: set correct d_type for reparse DFS/DFSR
and mount point") deduplicated assignment of fattr->cf_dtype member from
all places to end of the function cifs_reparse_point_to_fattr(). The only
one missing place which was not deduplicated is wsl_to_fattr(). Fix it.

Fixes: 8bd25b61c5a5 ("smb: client: set correct d_type for reparse DFS/DFSR and mount point")
Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/reparse.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index bb25e77c5540c..511611206dab4 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -1172,7 +1172,6 @@ static bool wsl_to_fattr(struct cifs_open_info_data *data,
 	if (!have_xattr_dev && (tag == IO_REPARSE_TAG_LX_CHR || tag == IO_REPARSE_TAG_LX_BLK))
 		return false;
 
-	fattr->cf_dtype = S_DT(fattr->cf_mode);
 	return true;
 }
 
-- 
2.39.5




