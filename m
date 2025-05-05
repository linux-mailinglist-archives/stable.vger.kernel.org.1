Return-Path: <stable+bounces-140171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AA0AAA5BC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A0F2461D2A
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011893184B2;
	Mon,  5 May 2025 22:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9ALf/9H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D0E3184AC;
	Mon,  5 May 2025 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484269; cv=none; b=p94/w/KwHppHPAC37aTev1fhStpfThniHr7gZQdIyLCGOuNuYbKIoFiSEyhnAah+cR2oRB2OhMf9bpN4YXTSfWIxpzGWTKCfRAUprMqY/Dn5vFSnQeTMHxVPlHMq8ISphUVwNWztpgleGx3uN5Nv91msO5+H4KdYTHjOb3ONzps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484269; c=relaxed/simple;
	bh=Mp/a/fuk8PfKuUaFhgsAQ/LlXGBDU8ywW1FmyppxbdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jyPD4wJUJl2VJsoS+E1i1qzMpTwY3FLkKeLMZScwbrEXOHy0Y6se8nL1wDNEwkRAKqwojo6Gx3X2cPAotLUmNi9ohP653ywM2zHX679SBN8jgscD+FNw9v0XzChJL+D5j9aEbS861tpXRj86QM+BDfxcod9zRzkM3BfHhoQjy5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9ALf/9H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53891C4CEEF;
	Mon,  5 May 2025 22:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484269;
	bh=Mp/a/fuk8PfKuUaFhgsAQ/LlXGBDU8ywW1FmyppxbdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d9ALf/9HvpJ5E6W6qD+cSVPFiIkfE0KdjPPzCPMi1CcRXyhiRuAPPTeiDDKHDY2WV
	 kjyhfYeeiglqVA7c6F6ESmy9KUs6y9bpLjdBHSesIcjeMIl+67HmORmnXwWMZz+qtC
	 ++u3yPhU+RApG1/FrCmkFhf4GL4Gi5OKlDtz6SZWwsSz6pONCHombUeupj+asY66HX
	 hSFnPbqYZHCS2fHBQRz6APtrsGcJLvj5xOAW7UZmxKCeAVAPmYdn9ByYwmuj3MCuLn
	 dVhyn/4k70wjbF97jTAqZSzItl3LuqBuGgbEcHziHrnlr/06jpr/C58/oDpHsbKWmI
	 4f1bqzp8UxgFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.14 424/642] kernfs: Don't re-lock kernfs_root::kernfs_rwsem in kernfs_fop_readdir().
Date: Mon,  5 May 2025 18:10:40 -0400
Message-Id: <20250505221419.2672473-424-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 9aab10a0249eab4ec77c6a5e4f66442610c12a09 ]

The readdir operation iterates over all entries and invokes dir_emit()
for every entry passing kernfs_node::name as argument.
Since the name argument can change, and become invalid, the
kernfs_root::kernfs_rwsem lock should not be dropped to prevent renames
during the operation.

The lock drop around dir_emit() has been initially introduced in commit
   1e5289c97bba2 ("sysfs: Cache the last sysfs_dirent to improve readdir scalability v2")

to avoid holding a global lock during a page fault. The lock drop is
wrong since the support of renames and not a big burden since the lock
is no longer global.

Don't re-acquire kernfs_root::kernfs_rwsem while copying the name to the
userpace buffer.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20250213145023.2820193-5-bigeasy@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/kernfs/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 5f0f8b95f44c0..43fbada678381 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1869,10 +1869,10 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)
 		file->private_data = pos;
 		kernfs_get(pos);
 
-		up_read(&root->kernfs_rwsem);
-		if (!dir_emit(ctx, name, len, ino, type))
+		if (!dir_emit(ctx, name, len, ino, type)) {
+			up_read(&root->kernfs_rwsem);
 			return 0;
-		down_read(&root->kernfs_rwsem);
+		}
 	}
 	up_read(&root->kernfs_rwsem);
 	file->private_data = NULL;
-- 
2.39.5


