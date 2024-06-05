Return-Path: <stable+bounces-48155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2838FCD2A
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C73DB2A869
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E411A2A57;
	Wed,  5 Jun 2024 12:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5HDAnj3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3891A2A4F;
	Wed,  5 Jun 2024 12:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589008; cv=none; b=EsbHMtmXP03TYsh+uPXX8QyqW5BvwyCFAVs/vqC2X0YaXswx2w8iTrehPWDg8kGWJnfFqWdlcZgfBJqJ1xsA8CLk65rcRnLoVsrEFX0qJ86PJK8qR94x4nAu/MoZddnQTd80OAslPDfyxMP6qmIYY8e2E7W+EwDaCEwSSs0/Slo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589008; c=relaxed/simple;
	bh=bylK+30oXOjpzBIqsZm0C+/6jGI+3ytDovsfXtt3fpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IeTGXPLB55ExwoSRWhGiKDq+phLmEeFFLCEGI5TzBgeWNipzTAPSTe10S3fNPrmlAoW04tG8xqz/827JOLFagQif/9VoHfQeDi9BbeSR8qYSKBrSuMgYmfWfG6xb1Ojn/2DQiKmwGgObQWOZrd/emboyU8+r2hOCOlzzB09NiA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5HDAnj3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6951C32786;
	Wed,  5 Jun 2024 12:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589007;
	bh=bylK+30oXOjpzBIqsZm0C+/6jGI+3ytDovsfXtt3fpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f5HDAnj3mwdKSchMWoUhFO6HMJJM0dHoWfSmXf++ceALkC1+uaEIIXfOpo4ynYffA
	 S41u1ebUO3eMS+rY0JTRWG28Fm3ZEGGdSE0G1mNYQ+F6gw9zwhZy3xfyOiI59TcfVh
	 m2Ok6SqNOTHaJ6SyT9oIpD8ZO/4ssM4IZDDmTnFTFu0F4BkDxMc9uTw2C3TtGQ0MVz
	 /XdFnu8yaSrbReFnbHtEU3hg4nf6HraRBddKgAQpchXfLkRQMgz+oxn/uBPpzB3QUy
	 qO2CmoyXpVhYk9NYw9IwLrHNQExu7Cowrfq9sSq1cz67lqHMdb7YnmL8iWEDqtdik9
	 0+2yPg/K6MsKQ==
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
Subject: [PATCH AUTOSEL 6.8 05/18] afs: Don't cross .backup mountpoint from backup volume
Date: Wed,  5 Jun 2024 08:02:55 -0400
Message-ID: <20240605120319.2966627-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120319.2966627-1-sashal@kernel.org>
References: <20240605120319.2966627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
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


