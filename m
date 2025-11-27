Return-Path: <stable+bounces-197475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D87AFC8F337
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 16:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F26503B8AD1
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93F2334C31;
	Thu, 27 Nov 2025 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HVVMyxG8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63430334C19;
	Thu, 27 Nov 2025 15:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255923; cv=none; b=ggxkkpExkx9qgZG/hMup/YtgUebMJo+WVoAmK0R94rHbx/a3lRv4QutMIqcRpedYceGHF89GJ/AWOCuTZR8eo+dm3rgacJ5hqu2XbEDQa3XyQJ9+K6HLMGVFMBbcsmHs2U8ttTQT4jLeIYrtxtrDvCX6LpB6og3qlROKUP2W9/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255923; c=relaxed/simple;
	bh=cWlDp1xmTl7bvskxalOM+wS75AzpskVGeiqU03/MQiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cuBP+Q4iW4RQrKg7syNdJEsIhLK+jJGXDhEXLkOuDGCwQj4XcwLbQT4tzJLw+4YlEy9+zHHmGhXEIGprfAqnxC4B5qx0EPWvnHVxuDxNvp/h5NxAEeBYvBDZ7v+aWa0UMNn/eWWSoqcR2L/H+8ktMrFyFoFtB+Ed4/2YTNrkGac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HVVMyxG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46BFC116D0;
	Thu, 27 Nov 2025 15:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764255923;
	bh=cWlDp1xmTl7bvskxalOM+wS75AzpskVGeiqU03/MQiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HVVMyxG8HxjVSa7Zkmt8NFjre7GQDq2oF/+okSjpD9ODROatOkoRLY5AAvzA745Hf
	 agXbWmI0K4E02v1yUaCqczVnQQZsqYuL9iLAcTD8mCJp20zG7J+FmrYCkI1YdxbaxO
	 XhH8jmQ3l50ISHtH9afVN2OiGilk4aKTxdb7JYIo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Henrique Carvalho <henrique.carvalho@suse.com>
Subject: [PATCH 6.17 161/175] smb: client: fix incomplete backport in cfids_invalidation_worker()
Date: Thu, 27 Nov 2025 15:46:54 +0100
Message-ID: <20251127144048.831710601@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127144042.945669935@linuxfoundation.org>
References: <20251127144042.945669935@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Henrique Carvalho <henrique.carvalho@suse.com>

The previous commit bdb596ceb4b7 ("smb: client: fix potential UAF in
smb2_close_cached_fid()") was an incomplete backport and missed one
kref_put() call in cfids_invalidation_worker() that should have been
converted to close_cached_dir().

Fixes: bdb596ceb4b7 ("smb: client: fix potential UAF in smb2_close_cached_fid()")"
Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cached_dir.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -755,7 +755,7 @@ static void cfids_invalidation_worker(st
 	list_for_each_entry_safe(cfid, q, &entry, entry) {
 		list_del(&cfid->entry);
 		/* Drop the ref-count acquired in invalidate_all_cached_dirs */
-		kref_put(&cfid->refcount, smb2_close_cached_fid);
+		close_cached_dir(cfid);
 	}
 }
 



