Return-Path: <stable+bounces-93897-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4AC19D1F51
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 05:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED401F215A7
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD87153835;
	Tue, 19 Nov 2024 04:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofyN4vGk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFEC1537A8
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 04:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731990975; cv=none; b=ZKaKwRAsVhObw/QDx2J+OZmDvw02wkW3rqurKcb5n+x4tl6br2js+k69shkqYWM5RyHmr5TvSFhoz3Cy9WRSznxnQ2lRfsd42OgFUN7nxSjR9JIwceOPvScSILqILcHagK79i828QWVGgwmDce5aaxWzlQ3+gFav91v6eHTrj5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731990975; c=relaxed/simple;
	bh=+2LpP78WBFbN/9xqK+buHIt5fiKDPBGtj+QHjoc94f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SaYx+YUob0msXjG4W1OMPyAs1Vhbr9imxwx3zTZB25UUhVj9y64UqaJDzGd/dlOyEhKhIhRQ3AOgwLsllyxkSMiQBQiUdcgX6cjNwckdf7l6vN4OH0YWjvrA4rxLZ1NqxmrJOdCl9U8OsNRCtJMSiIYQEZN1jcefzB4D6jpfoKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofyN4vGk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610DFC4CED2;
	Tue, 19 Nov 2024 04:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731990974;
	bh=+2LpP78WBFbN/9xqK+buHIt5fiKDPBGtj+QHjoc94f0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ofyN4vGkQIyWa9ngtsUOAr1+IuRkxzq909NuyRj7Hvje3tf4nJyYPE0YmaBzrSkYq
	 JfnMwC2zTEko9PhoOe5knZDJMNdQAeqmHhSX88zcecIl0THlHqe05k/oAM/KXf6cgo
	 VvjV01unHRP9W3h8A5vXW7AIFFPAa8qAwx5CUsM+MylzBl4G3IwNmefosf3wlZjerI
	 eR1qOTINa5s7uKEXMGKI9wDeAr2TQbG6Rcj9Cmv+3YCGj91LJp/ZdQ7hj66GfHI16U
	 qK2bLS0F/UpTQLOhHgut2zAQeK6ewgABJdhU7rsLycjzKhYUnrJsJ5lS3F0oaSBE89
	 +0vBtRLCSbWhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bin Lan <bin.lan.cn@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1] fs/ntfs3: Add rough attr alloc_size check
Date: Mon, 18 Nov 2024 23:36:07 -0500
Message-ID: <20241118092006.1494435-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241118092006.1494435-1-bin.lan.cn@windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: c4a8ba334262e9a5c158d618a4820e1b9c12495c

WARNING: Author mismatch between patch and upstream commit:
Backport author: Bin Lan <bin.lan.cn@windriver.com>
Commit author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

Commit in newer trees:

|-----------------|----------------------------------------------|
| 6.11.y          |  Present (different SHA1: 2fcae4c2014a)      |
| 6.6.y           |  Present (different SHA1: e91fbb21f248)      |
| 6.1.y           |  Not found                                   |
|-----------------|----------------------------------------------|

Note: The patch differs from the upstream commit:
---
--- -	2024-11-18 16:25:39.098066139 -0500
+++ /tmp/tmp.DxOAMDGPlz	2024-11-18 16:25:39.090757957 -0500
@@ -1,14 +1,17 @@
+[ Upstream commit c4a8ba334262e9a5c158d618a4820e1b9c12495c ]
+
 Reported-by: syzbot+c6d94bedd910a8216d25@syzkaller.appspotmail.com
 Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
+Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
 ---
  fs/ntfs3/record.c | 3 +++
  1 file changed, 3 insertions(+)
 
 diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
-index 2a375247b3c09..427c71be0f087 100644
+index 7ab452710572..0cdff04d084b 100644
 --- a/fs/ntfs3/record.c
 +++ b/fs/ntfs3/record.c
-@@ -331,6 +331,9 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
+@@ -329,6 +329,9 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
  
  		if (attr->nres.c_unit)
  			return NULL;
@@ -18,3 +21,6 @@
  	}
  
  	return attr;
+-- 
+2.43.0
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

