Return-Path: <stable+bounces-198836-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6054CA057A
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 18:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 195883276326
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 17:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBA634251C;
	Wed,  3 Dec 2025 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BPzAji+K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEF734250B;
	Wed,  3 Dec 2025 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777834; cv=none; b=JBWpfps0ibHeLLIiHTwJzspiN3GD86dhd0tnuFOlIBAClfWs2e65Tg+vP16PdZIC08qXVOgTBs+TzKUcHfm5Syzi7xGpqmUjNyojGz+uIq7swIAE4fcp1xEqmyRXnyx09lejiVNERPjriBs/5YdNrjDqeqMxfljTlZvtIG55FjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777834; c=relaxed/simple;
	bh=BszxpdBd89WtAOl1L3Ds5lszGOxr7bYoJJu+FLk3RIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prHJLiMFwrm4hemFXKCBL3SfN0ldjOAfVsdO27pWpwpIhabIFMo8LxmL8Jl5+RWxOrRwB2JkSFGAGf80fGIT52Gc8vaWMIYIY89BKRpu/CgRXy16qYQVhWaFmvdn9uY67chO7vbjUiID8xj1jfE+PwipCEL1O6DIfXeX+AvQcH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BPzAji+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0F4C4CEF5;
	Wed,  3 Dec 2025 16:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764777834;
	bh=BszxpdBd89WtAOl1L3Ds5lszGOxr7bYoJJu+FLk3RIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BPzAji+KCBovmF4GHGl8a2HYBK5AmZEWC4jK41iea/jIRKt+U/OoVNWR8Yl65fzLx
	 xpANSpu1atgMKrZSHC9k8xaoTTe+PWQ5ig7VjJkoKGeukv4R1qyGbXsWCbbjfCpSNz
	 N+NNPOQilqwyEa4nnaj0/mzxtEbIIIewxHcE6o9k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	NeilBrown <neil@brown.name>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 160/392] allow finish_no_open(file, ERR_PTR(-E...))
Date: Wed,  3 Dec 2025 16:25:10 +0100
Message-ID: <20251203152419.967040967@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152414.082328008@linuxfoundation.org>
References: <20251203152414.082328008@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit fe91e078b60d1beabf5cef4a37c848457a6d2dfb ]

... allowing any ->lookup() return value to be passed to it.

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/open.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 84e5dcc31c0e4..bdfe88fab1f1c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -921,18 +921,20 @@ EXPORT_SYMBOL(finish_open);
  * finish_no_open - finish ->atomic_open() without opening the file
  *
  * @file: file pointer
- * @dentry: dentry or NULL (as returned from ->lookup())
+ * @dentry: dentry, ERR_PTR(-E...) or NULL (as returned from ->lookup())
  *
- * This can be used to set the result of a successful lookup in ->atomic_open().
+ * This can be used to set the result of a lookup in ->atomic_open().
  *
  * NB: unlike finish_open() this function does consume the dentry reference and
  * the caller need not dput() it.
  *
- * Returns "0" which must be the return value of ->atomic_open() after having
- * called this function.
+ * Returns 0 or -E..., which must be the return value of ->atomic_open() after
+ * having called this function.
  */
 int finish_no_open(struct file *file, struct dentry *dentry)
 {
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
 	file->f_path.dentry = dentry;
 	return 0;
 }
-- 
2.51.0




