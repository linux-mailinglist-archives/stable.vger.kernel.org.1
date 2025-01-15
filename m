Return-Path: <stable+bounces-108810-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C637EA12066
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 11:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42FF97A2D7D
	for <lists+stable@lfdr.de>; Wed, 15 Jan 2025 10:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0AB248BD9;
	Wed, 15 Jan 2025 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NICFRdL5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5E4248BAC;
	Wed, 15 Jan 2025 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937877; cv=none; b=l/+7bGoM300zt8QcFwhy3VZ7Xv/5BwUwsQA0tpXtdi9BNR9AEu8l/XwG9O7WPTMDSNKq7ybRBsdF89LkfWFgirMFsj//g1rt1zKqw/3M5ufpwSBp0Nx5YWpn4o5GSsz7J102OYebtMDeoDFyVbD/vm9hjYxbkBfUMyHy4vpvyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937877; c=relaxed/simple;
	bh=6gsTZcltl/PLKTu0vprzKJShI4TXlLNTsKp/htCLmsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukdiwXh53/vkb68hRUFe2zFKHR4irI120dhCCKhWJX/9FF0HnQoEBII4vy86K40vqja1ztbsOLSw22k/6HNWBcLQ8q1SitOWOIyhjuU74KHCF2cQg9dV0MROudQKznUXUJ0XzSNVImrxv+JbpKY1S/gM2ZfBd0fZLlDX1qRXdWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NICFRdL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0954EC4CEE2;
	Wed, 15 Jan 2025 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736937876;
	bh=6gsTZcltl/PLKTu0vprzKJShI4TXlLNTsKp/htCLmsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NICFRdL5oVcvo1ZzeSws7AEnzqtG42H4JeBKPU0h04AnVV+iP2M5xV94GNWrizubH
	 Pa7FL/qfvH0MeB3lfzOwBxOfMOfvGoB2dkqX8MD1n7t9naqd9pJnmXcP1OwrJYak36
	 4SaGb9KBwUmYNN7CGgVRajfgLeAYoDobB5v99+L8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Prince Kumar <princer@google.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 018/189] fuse: respect FOPEN_KEEP_CACHE on opendir
Date: Wed, 15 Jan 2025 11:35:14 +0100
Message-ID: <20250115103607.088808482@linuxfoundation.org>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250115103606.357764746@linuxfoundation.org>
References: <20250115103606.357764746@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 03f275adb8fbd7b4ebe96a1ad5044d8e602692dc ]

The re-factoring of fuse_dir_open() missed the need to invalidate
directory inode page cache with open flag FOPEN_KEEP_CACHE.

Fixes: 7de64d521bf92 ("fuse: break up fuse_open_common()")
Reported-by: Prince Kumar <princer@google.com>
Closes: https://lore.kernel.org/linux-fsdevel/CAEW=TRr7CYb4LtsvQPLj-zx5Y+EYBmGfM24SuzwyDoGVNoKm7w@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Link: https://lore.kernel.org/r/20250101130037.96680-1-amir73il@gmail.com
Reviewed-by: Bernd Schubert <bernd.schubert@fastmail.fm>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 54104dd48af7..2e62e62c07f8 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1680,6 +1680,8 @@ static int fuse_dir_open(struct inode *inode, struct file *file)
 		 */
 		if (ff->open_flags & (FOPEN_STREAM | FOPEN_NONSEEKABLE))
 			nonseekable_open(inode, file);
+		if (!(ff->open_flags & FOPEN_KEEP_CACHE))
+			invalidate_inode_pages2(inode->i_mapping);
 	}
 
 	return err;
-- 
2.39.5




