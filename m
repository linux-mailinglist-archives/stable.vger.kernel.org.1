Return-Path: <stable+bounces-64239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F89941CFC
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3455B1F216B6
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D261A3DA1;
	Tue, 30 Jul 2024 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GuCNnvYN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BCA1A2C35;
	Tue, 30 Jul 2024 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359459; cv=none; b=mvi+P1UKOl02NAXPFH++5/U+65KwfpTJFqZaWQ1E+ne2B/fO2pYYmMAu0yTUe3iO1Htk7/4vkX/N1kOaTicZwFwvyw56N+hHlRIYfS/GGaOPpwhv4n+A5p9YJ0znKSwPSscAq/KseR8/exRhxTobDtx0mB86Kty/Ugw+qz6tAqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359459; c=relaxed/simple;
	bh=Ws4pQ1mcJTOwCI+6XO3eh2PrqnJF9WVXimU4rOPaLmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VP9AjI8jzv2j2M1GpFKdlVnAD7ETt2gndXgok6qE/9XgrJGwGCmi2wIGiOGEocwm71vhnIZRjekfrC+Nl9xaHODUOOhKrqOdrKy0n9LIv+N3GoS4VJiqLYVXOFc8l/ceg4+9ay12eeQ6OnP7rs94V44mDfI+qxvHA1CSMfG7VYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GuCNnvYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86406C32782;
	Tue, 30 Jul 2024 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722359458;
	bh=Ws4pQ1mcJTOwCI+6XO3eh2PrqnJF9WVXimU4rOPaLmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GuCNnvYNBitSMfGz2lvpqSWztyIjAbgdtJcJkGu3PYSv6mPA3tmkvK0VF40NSjfwI
	 /FVtAa5hUtn7cBI4IJlxe+r5FkzuBKtZlEfOupVFCzITEbBbs0l2Sil+1bEmDz4kHC
	 w/FQYLVwOiGcjm0TuRAQNyw0mH2FKIBjmBgswk9c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 486/809] fs/ntfs3: Deny getting attr data block in compressed frame
Date: Tue, 30 Jul 2024 17:46:02 +0200
Message-ID: <20240730151743.934767307@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 69943484b95267c94331cba41e9e64ba7b24f136 ]

Attempting to retrieve an attribute data block in a compressed frame
is ignored.

Fixes: be71b5cba2e64 ("fs/ntfs3: Add attrib operations")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrib.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 8638248d80d93..7918ab1a3f354 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -975,6 +975,19 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 	if (err)
 		goto out;
 
+	/* Check for compressed frame. */
+	err = attr_is_frame_compressed(ni, attr, vcn >> NTFS_LZNT_CUNIT, &hint);
+	if (err)
+		goto out;
+
+	if (hint) {
+		/* if frame is compressed - don't touch it. */
+		*lcn = COMPRESSED_LCN;
+		*len = hint;
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
 	if (!*len) {
 		if (run_lookup_entry(run, vcn, lcn, len, NULL)) {
 			if (*lcn != SPARSE_LCN || !new)
-- 
2.43.0




