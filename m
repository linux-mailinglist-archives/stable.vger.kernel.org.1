Return-Path: <stable+bounces-40620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF2D8AE4D0
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 13:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4961C22C35
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 11:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8868E86AE6;
	Tue, 23 Apr 2024 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGLfq0W1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45831143899;
	Tue, 23 Apr 2024 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872479; cv=none; b=B9NoN3tNmSiS1GzS15WAoaYh5gNCIVNiMDu/lLyTBil2by7hkWtsNdaPZk4UMFlu0VyMEOLfrIxooErmZMpDuSajs1x7oi12mC//oiCUxAh8VoawrMPaQq3XOnIYlUgW7hqKln8Ps+hg/7LjfTqUA7nHnDAzX3/JjjeNFEcQ6Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872479; c=relaxed/simple;
	bh=5tcGtF0P0FpGyYVKGJvplGuD++j60F/LuMDBUcAB+OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBMZNvB1Ga1QOnJs+uf/PY1m9dneSCE1mVXsKLxOGxWIWgv73PSJi5vNbH3McN1R1coBr9kHPZhPcOzW+1t8IABPN30dVXFDzAce8vfC8D+NBCC1yiFdHTdb4StbCdpU3mgWedzNb+RNH9D279Jus4l5KMUsESE+Xk/Vj+kR6rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGLfq0W1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4348EC116B1;
	Tue, 23 Apr 2024 11:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872479;
	bh=5tcGtF0P0FpGyYVKGJvplGuD++j60F/LuMDBUcAB+OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JGLfq0W1IdQiYY0h3041rPD0WiEfpJI3LlMs4LFtaN+kyJJOT4eAb3qth4wTzKKZf
	 gVMqtJ0937kxXLn1o7ytSYhEbJnZpdKUI/JTvu9lB5gc+qXXRTYXPkEqm532AQJR64
	 7+7+8jiHqRgHzlzIaJBHmUmBCkVSd8aVhnmm2dy1sriL0p+IbBSnA+RGX8Cgn7+mlH
	 H1fuSLPwj6xXOfR1Rv5pbPw2nn3VpBzb0fPWARohBcsfMdfZ9NcQZ3xB9CvE5OhPmP
	 76Xc0o2C3VgARaPB2mTljaW+nME9kDB3SYgG7Zt4arKoBbh0BlOUvhO8pLmVQG7oxH
	 lVL5IA7vdCWhA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	v9fs@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 3/9] 9p: explicitly deny setlease attempts
Date: Tue, 23 Apr 2024 07:02:25 -0400
Message-ID: <20240423110233.1659071-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110233.1659071-1-sashal@kernel.org>
References: <20240423110233.1659071-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.156
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
index 7437b185fa8eb..0c84d414660ca 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -660,6 +660,7 @@ const struct file_operations v9fs_file_operations = {
 	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync,
+	.setlease = simple_nosetlease,
 };
 
 const struct file_operations v9fs_file_operations_dotl = {
@@ -701,4 +702,5 @@ const struct file_operations v9fs_mmap_file_operations_dotl = {
 	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.fsync = v9fs_file_fsync_dotl,
+	.setlease = simple_nosetlease,
 };
-- 
2.43.0


