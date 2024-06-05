Return-Path: <stable+bounces-48173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 259128FCD57
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4B61C23280
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736D11A3BC3;
	Wed,  5 Jun 2024 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o01oxb+5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3220B195819;
	Wed,  5 Jun 2024 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589057; cv=none; b=fpgs+QStnlFA+PD6bVy1n5tBT9HRloqWcQJX/1QbXzhYIy95wsQcdhvGGv6CM50jOYMPdpQFiSVaKISyDe8nXk24a4ERP8qCEbBPeFWqqifyoun1n2dosQi8Np4JN/HOrtgPBROVR/kd9/I7wrtujif4nsduVV5GKWdzRu/yLfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589057; c=relaxed/simple;
	bh=bylK+30oXOjpzBIqsZm0C+/6jGI+3ytDovsfXtt3fpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QD9PZYIfwyttvH/Yf78dMk57lrERXODomyLvsvAAGad/Izbsbt56QTmAhEimgyRYcWWQFjptgdi+omg+nyct/qGsoE2zNZCPzk3gG2VL5Lcr0ywJnUpKGEREig5nHrWgohuTgREmHdj4qQuWUQOG8RaAzzG5Gs034+Z4SjNcEs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o01oxb+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036ACC32781;
	Wed,  5 Jun 2024 12:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589057;
	bh=bylK+30oXOjpzBIqsZm0C+/6jGI+3ytDovsfXtt3fpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o01oxb+5oxvtjKQqkofhjQNPLq2H080Vh5F5y9rDM2NcpCC37MyBAW6D7wOlTeEAM
	 g7lX4Gn87b4xVNDn+wgu0oXtE4R0oJBOJhbRrJ1VcOjywZywSiE6PQIfvyPAOJibM3
	 OtrEkP4A7HNasxDGa28dPINqjSekVoBPRDm92aVKDzB7PM19rPFaY12dOr90lH8GNx
	 faMpll2gnjZIGlBMAMM15Du1WERuiRUhwDw+65hkfGLFnEPByDL5IE/jdXcUAs1o3V
	 /fY1mzFop7hl+czqOVs+Y+NDtM5D+LkXgF0fJaWEftVrgU1IGvX3Ivpx7n1htqZWvC
	 Yc7C9xOKz+iFg==
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
Subject: [PATCH AUTOSEL 6.6 05/18] afs: Don't cross .backup mountpoint from backup volume
Date: Wed,  5 Jun 2024 08:03:44 -0400
Message-ID: <20240605120409.2967044-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120409.2967044-1-sashal@kernel.org>
References: <20240605120409.2967044-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
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


