Return-Path: <stable+bounces-40629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 778078AE4E9
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 13:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D37B2658A
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 11:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3EA145FEB;
	Tue, 23 Apr 2024 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUDTgF/6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452CE145B3A;
	Tue, 23 Apr 2024 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872495; cv=none; b=nTKYIjgrngmKORf948BRUaICHFIWZfCkp27IC/vveARyZN1oaDiixyHN2pdqFhP2nH7/dpY2uxYVGSX3VLgjAi5jh+VFHs4bnHvCICx6DdqkMFApVqOv1z92MMcO+MIo/fmW4WHfUfi/5NadV01byHYL0k8iKZrt+PmVJJQkrKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872495; c=relaxed/simple;
	bh=VE4wcJTbyxXeQUs7x/VihBeQ43jxTlnj1Q0QvS/i3P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QZvtrqS6i3IH4erX1HB1IB4JTnRbzHkpEl9I8xhL6WPPsJ67+Nwj9oPxMJIDuxjprg/KCsp77CVVc0/Up5gXXew9raeCN2Ei8Sm/NY6tiIwJsQzbKvX2wCuMsYXtCFRj3xDFSrrSJboInXcbyY1JABVfaQRSqlxe3p1TUduF7hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VUDTgF/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB83C32783;
	Tue, 23 Apr 2024 11:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872495;
	bh=VE4wcJTbyxXeQUs7x/VihBeQ43jxTlnj1Q0QvS/i3P0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VUDTgF/6Q3FO7qEK+4AZhOSP7b/pMhYtf7+bo/6XDwPSLF6Rg+1QF22UD7C/1wYbX
	 8CIT1EL8ymT5SOmdNMYULjkK/V47fjvRvFDF3Q0utWFZpO0hTiCtWkDwTWZPYC8XMs
	 Jz771Ae0x1U3rpxEL0VTkTXID3V2GmF6oZ4eVxKVbJ3rxKbg6UY/oZfUeIzKI3gi3H
	 tJCXi4He4Brl/oFtaFhlBnL/eQ6Jr9K/Rqnysp5KrjUAakRGX9e7bPjSbyo2T0BlZf
	 luGYHESX30926Xl2RnRUYR/EhpfPuNeOmlEHX5pN+mHzM6v8xE0EtWdZown6Mzku8Z
	 AkFNTt5l7yOHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 5.10 3/9] 9p: explicitly deny setlease attempts
Date: Tue, 23 Apr 2024 07:02:41 -0400
Message-ID: <20240423110249.1659263-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110249.1659263-1-sashal@kernel.org>
References: <20240423110249.1659263-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.215
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 7a84602297d36617dbdadeba55a2567031e5165b ]

9p is a remote network protocol, and it doesn't support asynchronous
notifications from the server. Ensure that we don't hand out any leases
since we can't guarantee they'll be broken when a file's contents
change.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/vfs_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index be5768949cb15..5d92eaeaebd91 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -685,6 +685,7 @@ const struct file_operations v9fs_file_operations = {
 	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync,
+	.setlease = simple_nosetlease,
 };
 
 const struct file_operations v9fs_file_operations_dotl = {
@@ -726,4 +727,5 @@ const struct file_operations v9fs_mmap_file_operations_dotl = {
 	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync_dotl,
+	.setlease = simple_nosetlease,
 };
-- 
2.43.0


