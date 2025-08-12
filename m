Return-Path: <stable+bounces-169033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20562B237D2
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CD2958860B
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D47D20E023;
	Tue, 12 Aug 2025 19:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bZbi+r0Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFEC217F35;
	Tue, 12 Aug 2025 19:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026157; cv=none; b=r/Z9YMCQfyjv6ElwAGPgCQwGwhN9O4oNLTe2Yql8j7qn6ypfkJENnAqbolMZNaK9158fU6O0D5GN0NG+ZVtk1KldkgClikSvcqGDE/p9rz88jqL+ODgaem2rQKgduhzyk6nTowHRLtRrfUi4vdMFHMzAaUzxrMXfXd+DPxlOye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026157; c=relaxed/simple;
	bh=n508RB45lbupRVuVwKweOBrzpjEkopzcmonC8c3l9fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IkuI8waCIJXaOE8W/mq/p/NjgRfo6x6ImJPaqZB7X1meH6iwKmnWY/RdXqyy+kyNLAvjJND5lq24ftUbfyzMhb68+BZouVdQXd4hKMeesADyqMTtHt5DIuUXSMrt0sFkNIDa++F7GriQa+8GnzHfVAF399AYsa2R96KGnZ4ENhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bZbi+r0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6024C4CEF0;
	Tue, 12 Aug 2025 19:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755026157;
	bh=n508RB45lbupRVuVwKweOBrzpjEkopzcmonC8c3l9fE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bZbi+r0ZezcyQKX78H35/NkBptaV6rrwbx0X/7Y8dK4PSptZNj/JiN/RDOzIVgoVs
	 ujmMMOE0aY1lbnB7IHmabwxBR3Mt4u4XTeLrDBmDhNfIcGG40MOmdx4VunMBkSlIWm
	 5C79u6lOht6EkN1i/Dr06StyQvHBDRpQFqazv2is=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 252/480] fanotify: sanitize handle_type values when reporting fid
Date: Tue, 12 Aug 2025 19:47:40 +0200
Message-ID: <20250812174407.844199978@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 8631e01c2c5d1fe6705bcc0d733a0b7a17d3daac ]

Unlike file_handle, type and len of struct fanotify_fh are u8.
Traditionally, filesystem return handle_type < 0xff, but there
is no enforecement for that in vfs.

Add a sanity check in fanotify to avoid truncating handle_type
if its value is > 0xff.

Fixes: 7cdafe6cc4a6 ("exportfs: check for error return value from exportfs_encode_*()")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250627104835.184495-1-amir73il@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fanotify/fanotify.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 6d386080faf2..7834eadf40a7 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -454,7 +454,13 @@ static int fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
 	dwords = fh_len >> 2;
 	type = exportfs_encode_fid(inode, buf, &dwords);
 	err = -EINVAL;
-	if (type <= 0 || type == FILEID_INVALID || fh_len != dwords << 2)
+	/*
+	 * Unlike file_handle, type and len of struct fanotify_fh are u8.
+	 * Traditionally, filesystem return handle_type < 0xff, but there
+	 * is no enforecement for that in vfs.
+	 */
+	BUILD_BUG_ON(MAX_HANDLE_SZ > 0xff || FILEID_INVALID > 0xff);
+	if (type <= 0 || type >= FILEID_INVALID || fh_len != dwords << 2)
 		goto out_err;
 
 	fh->type = type;
-- 
2.39.5




