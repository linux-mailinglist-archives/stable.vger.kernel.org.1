Return-Path: <stable+bounces-21624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3754B85C9A9
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13471F22E27
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E824151CEE;
	Tue, 20 Feb 2024 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jC8d30bB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE4B151CCC;
	Tue, 20 Feb 2024 21:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708464998; cv=none; b=Avgd5kdB/xXfO5ttsdVHNThjIvZjk7U6wAWbVVhTWm7bkDZ7TuY1j1L/E4wBZwgHL0nzK0Zk64TFYIuZLqXxfmFQpcNK2rhv5ruZbcrHjXRsqzcwOD288P6i0rQzNdeAUnLTIp45n7a1mZ/c38zNOiDhZF6f9eBQTPwTyMoxBzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708464998; c=relaxed/simple;
	bh=v2ULkb6KivOVb5g25iP0HsD52/RkXMbk/UUwtDr+HP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJX7jobNd7aLGpu11g7bvqKsNX9pYesW/W64/su8F41tSOkBAVh9l03KCMxkif2VKoVT93XQFqxQGerVzko6cGx6NJzgnIqBONESny69sWRXMcNwSVtNUMOijPb2sUatnQ5DGq+/Pe8hBKTs17abnpJQoar2fy6/NqHYZ9xqnRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jC8d30bB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66D5C433F1;
	Tue, 20 Feb 2024 21:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708464998;
	bh=v2ULkb6KivOVb5g25iP0HsD52/RkXMbk/UUwtDr+HP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jC8d30bB7YkildicEmmsXM3jb3foWWZqibmb8C6aDjUIT9cWmUxPCwN/VcjREo20U
	 IQF+BRvpiICl7KNgPKTt7r/McBkSMnzt79JsafndUZpMDReUBHFb2bShdXiRML9Nmf
	 g91o92Wiv0zQMs1iEaApja3goUpueWSDuhXoIIG4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH 6.7 204/309] drm/buddy: Fix alloc_range() error handling code
Date: Tue, 20 Feb 2024 21:56:03 +0100
Message-ID: <20240220205639.572912427@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205633.096363225@linuxfoundation.org>
References: <20240220205633.096363225@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

commit 8746c6c9dfa31d269c65dd52ab42fde0720b7d91 upstream.

Few users have observed display corruption when they boot
the machine to KDE Plasma or playing games. We have root
caused the problem that whenever alloc_range() couldn't
find the required memory blocks the function was returning
SUCCESS in some of the corner cases.

The right approach would be if the total allocated size
is less than the required size, the function should
return -ENOSPC.

Cc: <stable@vger.kernel.org> # 6.7+
Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3097
Tested-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20240207174456.341121-1-Arunpravin.PaneerSelvam@amd.com/
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240214131853.5934-1-Arunpravin.PaneerSelvam@amd.com
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_buddy.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
index f57e6d74fb0e..c1a99bf4dffd 100644
--- a/drivers/gpu/drm/drm_buddy.c
+++ b/drivers/gpu/drm/drm_buddy.c
@@ -539,6 +539,12 @@ static int __alloc_range(struct drm_buddy *mm,
 	} while (1);
 
 	list_splice_tail(&allocated, blocks);
+
+	if (total_allocated < size) {
+		err = -ENOSPC;
+		goto err_free;
+	}
+
 	return 0;
 
 err_undo:
-- 
2.43.2




