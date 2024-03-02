Return-Path: <stable+bounces-25777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ED186F1B4
	for <lists+stable@lfdr.de>; Sat,  2 Mar 2024 18:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5272837F3
	for <lists+stable@lfdr.de>; Sat,  2 Mar 2024 17:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FEDB2BB08;
	Sat,  2 Mar 2024 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ds54LrPD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2353C1E489;
	Sat,  2 Mar 2024 17:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709401045; cv=none; b=Y7B7DffISHeORAprO2OPsYdkCHjv/OAy7+aXMvmLmMe3BceDLRjO8dfrAcjMED0XNgFBwieP8D+cnRxQBadzHBPd4rzzwfUObg1MAMNPG26NwZEwzOoObJWc56JJ/XH9o8mAAysZ5/8YA/xMbnBRA++RsepHn+JBnRVcY+6FsaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709401045; c=relaxed/simple;
	bh=5fjo3sW6ZItv7pEgLKPHc8QFAJBO26lF5AlePNl8bqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1L2lWMTs8Vj6qa1JLB1yHkkQMyUc2CXt4iFa3I+zz0nyWTcTdLrAQ+9ameSAef7nAGLng99wEXTzMVvI3piZQwMwcrBFAMdvP9Y5HQr+f91zukflnlhNgqfbT9FYJKzc/A6z564q7/8sqNdq6y4D9kv9GAi37IZafWCBCyDZc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ds54LrPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468BEC433C7;
	Sat,  2 Mar 2024 17:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709401044;
	bh=5fjo3sW6ZItv7pEgLKPHc8QFAJBO26lF5AlePNl8bqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ds54LrPDa+oVlj++Xnuj1EnO55m4D7uzun/o4zOqrxpfl3JUsFNoh049YpSRKtGBl
	 RlmCPfbRPo46Zh4UZ79BxNj01otZHW7WEn91dxjqcoKc76n8cujLePE36voZgAKo5O
	 4apmlXeCDHCu0OlIGeosf9X1bMuDDWACwqp/LIq8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.20
Date: Sat,  2 Mar 2024 18:37:20 +0100
Message-ID: <2024030256-left-drier-1724@gregkh>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024030256-unpledged-wrinkly-084d@gregkh>
References: <2024030256-unpledged-wrinkly-084d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 6130b6bd8d6c..a3bdd583afcc 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 19
+SUBLEVEL = 20
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 61c51650266e..22fe7f58ad63 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2457,7 +2457,6 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 	struct ATTR_LIST_ENTRY *le = NULL;
 	struct runs_tree *run = &ni->file.run;
 	u64 valid_size = ni->i_valid;
-	loff_t i_size = i_size_read(&ni->vfs_inode);
 	u64 vbo_disk;
 	size_t unc_size;
 	u32 frame_size, i, npages_disk, ondisk_size;
@@ -2509,6 +2508,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 		err = -EOPNOTSUPP;
 		goto out1;
 #else
+		loff_t i_size = i_size_read(&ni->vfs_inode);
 		u32 frame_bits = ni_ext_compress_bits(ni);
 		u64 frame64 = frame_vbo >> frame_bits;
 		u64 frames, vbo_data;

