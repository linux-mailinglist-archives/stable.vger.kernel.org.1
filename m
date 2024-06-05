Return-Path: <stable+bounces-48134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3456F8FCCCD
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE691F25622
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12DE19D086;
	Wed,  5 Jun 2024 12:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JI5W7l3h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAB619D080;
	Wed,  5 Jun 2024 12:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588954; cv=none; b=WZSOExHN9/siPkvaOIWpL5kElNOmu3yRDzX8YwVgZHQxA3YSoVSMz3wS+K2FOqz+cdfEKYPHpxdQ+Hc2z9Rgk4JS2tsJPY5vHIwYTmEPMnFKeKDnpTKRcnmPmjoY6PlzO+3n5VBRi9UpCX6JqV7Cijj+BfSGKzf7lzhbJj5LfL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588954; c=relaxed/simple;
	bh=bylK+30oXOjpzBIqsZm0C+/6jGI+3ytDovsfXtt3fpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qf5y1H5pdI3lYN+qbGBagU75CiDjyrvxKnS7LAFlGc2AenmCk/JCXwj55yyDj1e2JCAKrGf3jhq2Gz/m0hs7S5YfLCUDijIZZWKuQeFFLWjyZ9b1aXs/1io3WKZTl3fc6L06QcO0CkIsCh2PXOpfTAWK0TmgZOPgouXzjidOEb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JI5W7l3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E3EC32781;
	Wed,  5 Jun 2024 12:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588954;
	bh=bylK+30oXOjpzBIqsZm0C+/6jGI+3ytDovsfXtt3fpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JI5W7l3hEIm1fnEY9Y3UEtOzYbWZKypnrb9O4FYy1HkfbpzcjKuFBqbii7FBMu3P0
	 tfKQ9ooCW4gFhUjkv/0fNEAcm3ao2xX5yIXLEoDh/268mLmKRotG3ccaRVuyilE9ut
	 KSNJ0ApEzwbuHEOUNfKoZphVS3dygYDYDG9g2wc6v/XXGOj3mXM+CQs+sbAJSEbvQ0
	 Ze+myHGOu5WviVo0aD/Et9C5hXlQ6fFouLQWb3GdtuskGfmxxwt2Iv5qH1LLO1+tlH
	 wAog/KKAyB3+LV0kKWB5il77NtmGAPvQ9CvWcycFAY5x4mLpo3+woWaqbRShfUMN0Z
	 OFNMt4n702RiA==
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
Subject: [PATCH AUTOSEL 6.9 07/23] afs: Don't cross .backup mountpoint from backup volume
Date: Wed,  5 Jun 2024 08:01:50 -0400
Message-ID: <20240605120220.2966127-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120220.2966127-1-sashal@kernel.org>
References: <20240605120220.2966127-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
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
index 97f50e9fd9eb0..297487ee83231 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -140,6 +140,11 @@ static int afs_mntpt_set_params(struct fs_context *fc, struct dentry *mntpt)
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


