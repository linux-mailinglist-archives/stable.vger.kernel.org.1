Return-Path: <stable+bounces-83665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A7699BE6C
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 05:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A51F1C218FE
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 03:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF83145A17;
	Mon, 14 Oct 2024 03:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8TxpOik"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6586E145324;
	Mon, 14 Oct 2024 03:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878262; cv=none; b=PBWhR3xb1cZ+2zFsmAyesdjA09/MkTkam52YJSao828oXJl/NIW5dWLjPfn1pkkkX+AawiOySJHAsIXUfOZIfK/quhNb2e2dWj1ChM5LhRIG3Ahel7M2DE8FMhpXyBAqzYQIZnI6dO2OuQzmzTofUBlFCZhOmeMlUBK1rMRcHPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878262; c=relaxed/simple;
	bh=UM1MY0ZNs6/tcDikP+R0ev64fnUpQaUGL6+ev6amSnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M2NnD5ihyz1HzXmn16wDaDlWfeGaczopDKP5RJB+ZVgTMpeqpkqHpKFXOcwcXjc8w0h5kaekIWIrBu0vvJ7LntlD8VjKIk0RIg4bHj2t/64NuxBVbuI5aROLe47PvaOwNfUQfY2/HOXxuEhfytdVT93uGNiIoTLf2IalWxrBP6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8TxpOik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300EEC4CEC3;
	Mon, 14 Oct 2024 03:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878262;
	bh=UM1MY0ZNs6/tcDikP+R0ev64fnUpQaUGL6+ev6amSnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a8TxpOiku3mxoMS7HT2KohT1ar/ZaU+sTc65o98Wiw+OZ4g8TYSMC7FCFot1lMJO0
	 YlUS1OcyXImrNTaP8DouJaAmwPKXJKGktp1hHC9n0MkERQznfz9Mp4Z2etpw5IOf+x
	 quI1FVUTgXDOUy98e9V1dmdhQ5aYcCIpWFCedSyFETAf0HYzXQ2eC/WOKimzt+B1gi
	 /xVb4QVKJNqCCmaEyTf8Pj11g0Q8TgM7t4xQhF+6DzFdiFRlwLrTiXRxeSH2PL1jpS
	 ow3DONzlJhLT28bp84taS8IykT+dV9/oXyvhEkAZ8Q6psxkhAbKveNun/zMuTZiwfj
	 QK/zpzjiea0Kw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+3bfd2cc059ab93efcdb4@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 07/20] fs/ntfs3: Additional check in ni_clear()
Date: Sun, 13 Oct 2024 23:57:09 -0400
Message-ID: <20241014035731.2246632-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035731.2246632-1-sashal@kernel.org>
References: <20241014035731.2246632-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit d178944db36b3369b78a08ba520de109b89bf2a9 ]

Checking of NTFS_FLAGS_LOG_REPLAYING added to prevent access to
uninitialized bitmap during replay process.

Reported-by: syzbot+3bfd2cc059ab93efcdb4@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/frecord.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index a469c608a3948..6d9f260634564 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -102,7 +102,9 @@ void ni_clear(struct ntfs_inode *ni)
 {
 	struct rb_node *node;
 
-	if (!ni->vfs_inode.i_nlink && ni->mi.mrec && is_rec_inuse(ni->mi.mrec))
+	if (!ni->vfs_inode.i_nlink && ni->mi.mrec &&
+	    is_rec_inuse(ni->mi.mrec) &&
+	    !(ni->mi.sbi->flags & NTFS_FLAGS_LOG_REPLAYING))
 		ni_delete_all(ni);
 
 	al_destroy(ni);
-- 
2.43.0


