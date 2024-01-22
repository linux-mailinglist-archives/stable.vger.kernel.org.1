Return-Path: <stable+bounces-13030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3289837A41
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F5421F289CA
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AC512BE99;
	Tue, 23 Jan 2024 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DbLp3DGT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D0F12BE87;
	Tue, 23 Jan 2024 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968838; cv=none; b=FAdMYdFraTaSCluivnoiUQAI9eD59spLd+RVDBfpYBaYwGgNs3jXOn/QY7tlf4PGMKKM9ugMRrHMGQBf7jom8IrgeQ7pz7gtHsONEjlQxZvWq5auypQl8GzLjQ5qfaJtZzBbhNt4sppyK/jK52t/s9+md1C28iuNEdfDD25HCRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968838; c=relaxed/simple;
	bh=AbFGGkagpxz1CAdstdbcsmJ/iMbjzqM/fC7ZBIA3Qsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpC/BNs5NtxfB2JSFIb4fMynX2b3qeVG9quZ3ULB/as/NJrwtpKjuTM6PsxQ9rimrZEwDkGJ9lJDd/eEWgS+I3YVOYCsmtIvdLgW6dd3EGPrMMa2kIEjmEnJ6rz/nY4rPMcGHnOYbKdQtF9LteQii8tJgR04CmtD5jFRX7YZtBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DbLp3DGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3B4C433F1;
	Tue, 23 Jan 2024 00:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968837;
	bh=AbFGGkagpxz1CAdstdbcsmJ/iMbjzqM/fC7ZBIA3Qsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DbLp3DGTT1gCgrAb9nJ2+16nIWBCxnnv3mNbB6DcR2BmzDR07jSo/wwU0n58iVFsK
	 7z9iHmCy2VeN0ThTCC/k8Gn1z2ttFil1v+cbdpGBhuYSFcFCfyhgvYGcCC/won85JI
	 Jyi9zFZmkqeQZf7HzTdhrjcfOk8CvdAQPgdoUqMY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alice Ryhl <aliceryhl@google.com>,
	Carlos Llamas <cmllamas@google.com>
Subject: [PATCH 5.4 034/194] binder: fix trivial typo of binder_free_buf_locked()
Date: Mon, 22 Jan 2024 15:56:04 -0800
Message-ID: <20240122235720.675107245@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235719.206965081@linuxfoundation.org>
References: <20240122235719.206965081@linuxfoundation.org>
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

From: Carlos Llamas <cmllamas@google.com>

commit 122a3c1cb0ff304c2b8934584fcfea4edb2fe5e3 upstream.

Fix minor misspelling of the function in the comment section.

No functional changes in this patch.

Cc: stable@vger.kernel.org
Fixes: 0f966cba95c7 ("binder: add flag to clear buffer on txn complete")
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Link: https://lore.kernel.org/r/20231201172212.1813387-7-cmllamas@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/android/binder_alloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -662,7 +662,7 @@ void binder_alloc_free_buf(struct binder
 	/*
 	 * We could eliminate the call to binder_alloc_clear_buf()
 	 * from binder_alloc_deferred_release() by moving this to
-	 * binder_alloc_free_buf_locked(). However, that could
+	 * binder_free_buf_locked(). However, that could
 	 * increase contention for the alloc mutex if clear_on_free
 	 * is used frequently for large buffers. The mutex is not
 	 * needed for correctness here.



