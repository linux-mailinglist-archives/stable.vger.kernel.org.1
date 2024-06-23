Return-Path: <stable+bounces-54904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9A7913B03
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5FB1C20CBF
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 13:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A90184130;
	Sun, 23 Jun 2024 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7Qu4NdQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E959184126;
	Sun, 23 Jun 2024 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150265; cv=none; b=gRgQ83UM//S3xOU1MLurDqJ0GZjD2VUFTnXu/m+GhTmE2cn+0V2+bmoJ+8Ddow4tVDqOzf6JuV4RISobU42oBe84YNrjGegKaSd0201PwwBYqQUVzTgQ86piB+GSi9OsHxf4SvKKpzcjFBYHvZjGLYpvi6WZXZyLXh16UHzbA+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150265; c=relaxed/simple;
	bh=DMf5LYPgxYmBVvwbewTVRmb1sIc0P4BsnHw+GRJU4ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7/VkZFQZ2m86cJZyclW7VGktKfPlmsKlbKHy3Cuib72l8sOQQeYXm8AFZGlWB3jjJ8bR8mZ5dm4Ji2uR6q4+7A2RyZ1SS+Vvcg/8nDHIvutmlP+gzpIdKCHcAsLNGOBCXWOWk2tYVI5K8xy0V4blY3eMsgCo9ZeNmkvYfwB2ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7Qu4NdQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382FFC2BD10;
	Sun, 23 Jun 2024 13:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150264;
	bh=DMf5LYPgxYmBVvwbewTVRmb1sIc0P4BsnHw+GRJU4ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i7Qu4NdQlDtLjPKYIZuGK3UZE9QzJMGl8GiDe3enw9HE/YtF697Ue514h0PGIcDuE
	 9B6CqjRbhL9qukJdMipRl5p+d9VOfnLgaJZtU+UFYLx9ZlsyIhTSJVaTJd9GAtzgT4
	 fNGBPYnadZh7PrJqjgLwZGVycw5MwHeEUYJ8avxQDGa3MLG7wgDFTaaBuaa5j2HXOA
	 +VCTBqV3NcbxTdKY80oy3oYKhvUEx9V9nVDyy9v6BJF+EdLzAN1SgODaF7LJcsZrUL
	 IxUhMogk9BuFknVH3rlUOHoowBfTnWcU1MMzoA+QvrwyOOlkkQa2fHP4HE4DPk3euY
	 aTpKec2SOCUrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.9 11/21] mei: demote client disconnect warning on suspend to debug
Date: Sun, 23 Jun 2024 09:43:44 -0400
Message-ID: <20240623134405.809025-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134405.809025-1-sashal@kernel.org>
References: <20240623134405.809025-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.6
Content-Transfer-Encoding: 8bit

From: Alexander Usyskin <alexander.usyskin@intel.com>

[ Upstream commit 1db5322b7e6b58e1b304ce69a50e9dca798ca95b ]

Change level for the "not connected" client message in the write
callback from error to debug.

The MEI driver currently disconnects all clients upon system suspend.
This behavior is by design and user-space applications with
open connections before the suspend are expected to handle errors upon
resume, by reopening their handles, reconnecting,
and retrying their operations.

However, the current driver implementation logs an error message every
time a write operation is attempted on a disconnected client.
Since this is a normal and expected flow after system resume
logging this as an error can be misleading.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Link: https://lore.kernel.org/r/20240530091415.725247-1-tomas.winkler@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/mei/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 79e6f3c1341fe..40c3fe26f76df 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -329,7 +329,7 @@ static ssize_t mei_write(struct file *file, const char __user *ubuf,
 	}
 
 	if (!mei_cl_is_connected(cl)) {
-		cl_err(dev, cl, "is not connected");
+		cl_dbg(dev, cl, "is not connected");
 		rets = -ENODEV;
 		goto out;
 	}
-- 
2.43.0


