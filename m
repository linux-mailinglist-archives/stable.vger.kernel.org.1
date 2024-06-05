Return-Path: <stable+bounces-48204-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7FB8FCDA6
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669E01C226E8
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D979C1ABE3C;
	Wed,  5 Jun 2024 12:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpNG6NiI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990051ABE32;
	Wed,  5 Jun 2024 12:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589135; cv=none; b=JN+EU9Zj+vVaAtOW3DLchxpqZFXtks28OULFXJny7dYx+VZTs+DLMUQU92mTZwUX8oMRcaEjLaRb3KxhWMcYU/EekRT2hUzhj2+MTHAsPO7c71nn4CO9P5UO+o2R5VljgkUtSwpbKb9TSySI/kLtL8MnzKa7XofF2VjHrr2afSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589135; c=relaxed/simple;
	bh=6ghHQ4oFDM/MuZh0bso4VZhlvZ9ZWfi1y9gl6T3Gy0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nz6Bzoby87mTkdxbRaQnvlPNkZBX6Bxvh53wAbBZ8tVjV8CVipWuxgzB0SkwX9tRvkFFI6M75Lm7kcEDXF+WnrAaPlLUSztyTLX3EujCRdPKPpWZQe14K76XiRQr7saiBK97igGsko8pZqKQm9b1RDp8GrBcWUKR9xj68GlvTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpNG6NiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2989AC3277B;
	Wed,  5 Jun 2024 12:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589135;
	bh=6ghHQ4oFDM/MuZh0bso4VZhlvZ9ZWfi1y9gl6T3Gy0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JpNG6NiIamTTsdzX7MwFOxMsyxzfsO9xxBJwfRVcJsGf5+/nsdxcfWGKnv+Qc6JNb
	 Ou1U19gk7Vt6jpNUqdbqfRM4TbUkMil8JvKbOmhgNJkJz8pjH7XC7FqHxOBdK9nTd/
	 nRMS5oAU8iIFB4vyizoEKejLaW1q4hMcP4yKeb9aj5oTK04WuM1/q4ZFzn0NbGGgpE
	 IOLrPwX2gJWyO+6S3ynEJpjV62UeRRF3+r3UN6OSkYZCqKDibqd1cFqnKHeBcnkIAf
	 ItBIfh7EAuNsfDG5/+9Haob77AkVHp2IbD5VhRc1PCDRnWYO9W/Ircluifkg5ASOZU
	 cE0oSf6PFt2+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Marc Dionne <marc.dionne@auristor.com>,
	Jan Henrik Sylvester <jan.henrik.sylvester@uni-hamburg.de>,
	Markus Suvanto <markus.suvanto@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	linux-afs@lists.infradead.org,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 04/12] afs: Don't cross .backup mountpoint from backup volume
Date: Wed,  5 Jun 2024 08:05:14 -0400
Message-ID: <20240605120528.2967750-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120528.2967750-1-sashal@kernel.org>
References: <20240605120528.2967750-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
Content-Transfer-Encoding: 8bit

From: Marc Dionne <marc.dionne@auristor.com>

[ Upstream commit 29be9100aca2915fab54b5693309bc42956542e5 ]

Don't cross a mountpoint that explicitly specifies a backup volume
(target is <vol>.backup) when starting from a backup volume.

It it not uncommon to mount a volume's backup directly in the volume
itself.  This can cause tools that are not paying attention to get
into a loop mounting the volume onto itself as they attempt to
traverse the tree, leading to a variety of problems.

This doesn't prevent the general case of loops in a sequence of
mountpoints, but addresses a common special case in the same way
as other afs clients.

Reported-by: Jan Henrik Sylvester <jan.henrik.sylvester@uni-hamburg.de>
Link: http://lists.infradead.org/pipermail/linux-afs/2024-May/008454.html
Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Link: http://lists.infradead.org/pipermail/linux-afs/2024-February/008074.html
Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Link: https://lore.kernel.org/r/768760.1716567475@warthog.procyon.org.uk
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: linux-afs@lists.infradead.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/mntpt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index bbb2c210d139d..fa8a6543142d5 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -146,6 +146,11 @@ static int afs_mntpt_set_params(struct fs_context *fc, struct dentry *mntpt)
 		put_page(page);
 		if (ret < 0)
 			return ret;
+
+		/* Don't cross a backup volume mountpoint from a backup volume */
+		if (src_as->volume && src_as->volume->type == AFSVL_BACKVOL &&
+		    ctx->type == AFSVL_BACKVOL)
+			return -ENODEV;
 	}
 
 	return 0;
-- 
2.43.0


