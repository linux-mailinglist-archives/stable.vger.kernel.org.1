Return-Path: <stable+bounces-185516-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DE6BD63E8
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 22:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D34314F7671
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 20:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E1030BB91;
	Mon, 13 Oct 2025 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpsH+v89"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40103309DB1
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 20:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388091; cv=none; b=Yy9E9B8db7IiNHyBGfGVIPcfyX14QaFr0NEQfItmjMtjrkxtZQw+bQItBaxOiUtjTMkqB6oSyh3IuY4UvS+8uO4MkjbF6osduTfrf5hCcaqljTAcpbxep7Qc2wCWlUGxHsl8cXjVqYPTXgIuRC+LokqmVn0qqJUCrVM8IjH4PNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388091; c=relaxed/simple;
	bh=auI4kF96Ov5mjIOIHXwuNHhvI0RkFNraAXup3IXlDZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvHWBvQYXCMsa+9rOEKHWr+g+5yrcIkvTrG2q1P1O34m6vllQqTJtcSIByAneaz8PoETp5v+IXlYtX5cb3nvNywVVUCo5qMosEg7mPB/1TuisKNjnqXrLL+ylyPpdCnKlMEgQgGXeTFZ7aHx8/9cA6vfswPNPONiyXm+D+Ctinw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpsH+v89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18776C19423;
	Mon, 13 Oct 2025 20:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760388090;
	bh=auI4kF96Ov5mjIOIHXwuNHhvI0RkFNraAXup3IXlDZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cpsH+v89dLt9z+8aBsMCfJfpNQ/0bZWqULIQDdoujudzggtbnLcGpVYHSkdMLA6qI
	 e8iDuEzPrR99wsTtwrOLqCLy1WCg35qVcIXY5XsqXNThoN4oCNLqpf2QndEF1Rs7j3
	 Kgzi07JarMrB+T0/AiO3kTp9s3CCGa8RyO3TREx2G1d4KQuH0PYf1N/KSXBCKa/CaV
	 dYtLAKdiFb0pOlTdr5NRcwjWz2BE7Gs+IV4nkalzmL484TFc68mZ8vh/iL5FVcUlyQ
	 B+CWnw8TV32dYS+mHNid+8hEA9bdPL3qNbOIx3KiiPY4XnMvIPDL6ZwtejP0TEM3Xl
	 xsz8bvuhMBAjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
	syzbot+f754e01116421e9754b9@syzkaller.appspotmail.com,
	Amir Goldstein <amir73il@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] Squashfs: reject negative file sizes in squashfs_read_inode()
Date: Mon, 13 Oct 2025 16:41:27 -0400
Message-ID: <20251013204127.3599792-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013204127.3599792-1-sashal@kernel.org>
References: <2025101320-padding-swagger-0208@gregkh>
 <20251013204127.3599792-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Lougher <phillip@squashfs.org.uk>

[ Upstream commit 9f1c14c1de1bdde395f6cc893efa4f80a2ae3b2b ]

Syskaller reports a "WARNING in ovl_copy_up_file" in overlayfs.

This warning is ultimately caused because the underlying Squashfs file
system returns a file with a negative file size.

This commit checks for a negative file size and returns EINVAL.

[phillip@squashfs.org.uk: only need to check 64 bit quantity]
  Link: https://lkml.kernel.org/r/20250926222305.110103-1-phillip@squashfs.org.uk
Link: https://lkml.kernel.org/r/20250926215935.107233-1-phillip@squashfs.org.uk
Fixes: 6545b246a2c8 ("Squashfs: inode operations")
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
Reported-by: syzbot+f754e01116421e9754b9@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68d580e5.a00a0220.303701.0019.GAE@google.com/
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/squashfs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index eb6f577154d59..f32db16dc18ba 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -192,6 +192,10 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 			goto failed_read;
 
 		inode->i_size = le64_to_cpu(sqsh_ino->file_size);
+		if (inode->i_size < 0) {
+			err = -EINVAL;
+			goto failed_read;
+		}
 		frag = le32_to_cpu(sqsh_ino->fragment);
 		if (frag != SQUASHFS_INVALID_FRAG) {
 			/*
-- 
2.51.0


