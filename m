Return-Path: <stable+bounces-51591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 794CC90709D
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A277F1C21DAA
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9E51292FF;
	Thu, 13 Jun 2024 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hvyid6kO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEB713A406;
	Thu, 13 Jun 2024 12:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281745; cv=none; b=SjPAgZqFrxe4EVRz+NkSKA5aLVyIPhLHrrWySrWmKZcNLvEVuTfyz/Ctf4xhYn/tSIlHKV5whYnP/wadeW08Zo0GiA4ga5jgJrOOsm2DIrtF2F5vVFBnb3OvHgLDt77ihBEq6vku2usIYQC5kSEpvMgLiEGxFBJYpz2z0dpogOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281745; c=relaxed/simple;
	bh=cgAR5RQf6hHP1odp0QWLV7h6Z0mU1uI+t9sLN0N1of4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cK/xnpR+RyCuHWiNRuifofJNUQkzyk1YK3CYBTlOGHjZNHafdkvkX2TvSZzBtrSVJZ8VqOKOeYK21L9qSyVrrxJRo+g2X+YzyEbEXtUQa4twY+ESwCYtf3ByDGj5MzvoJW+OSDcRhI3afQGW5D7PU9YH047/NO2jQogptGMcu6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hvyid6kO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65D8C4AF1A;
	Thu, 13 Jun 2024 12:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718281745;
	bh=cgAR5RQf6hHP1odp0QWLV7h6Z0mU1uI+t9sLN0N1of4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hvyid6kOae8puWSztHDkxdT+UPITwR94KJiJ6SN9D7MmeSUAvpLPDvEDiWVad/eZM
	 SaOAaAu2IH7t5kadBkfLGW2b+GloBSkWxEcdXXnM7gn/josTz6W7y/DWIdb1K5Nh0x
	 0Z7oe8RlwYnBxtYfmKwTgq2fb1S2m+BIGcpXGxNA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 041/402] nilfs2: fix out-of-range warning
Date: Thu, 13 Jun 2024 13:29:58 +0200
Message-ID: <20240613113303.740519282@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113302.116811394@linuxfoundation.org>
References: <20240613113302.116811394@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit c473bcdd80d4ab2ae79a7a509a6712818366e32a ]

clang-14 points out that v_size is always smaller than a 64KB
page size if that is configured by the CPU architecture:

fs/nilfs2/ioctl.c:63:19: error: result of comparison of constant 65536 with expression of type '__u16' (aka 'unsigned short') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
        if (argv->v_size > PAGE_SIZE)
            ~~~~~~~~~~~~ ^ ~~~~~~~~~

This is ok, so just shut up that warning with a cast.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20240328143051.1069575-7-arnd@kernel.org
Fixes: 3358b4aaa84f ("nilfs2: fix problems of memory allocation in ioctl")
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nilfs2/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index a39206705dd12..6a2f779e0bad4 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -60,7 +60,7 @@ static int nilfs_ioctl_wrap_copy(struct the_nilfs *nilfs,
 	if (argv->v_nmembs == 0)
 		return 0;
 
-	if (argv->v_size > PAGE_SIZE)
+	if ((size_t)argv->v_size > PAGE_SIZE)
 		return -EINVAL;
 
 	/*
-- 
2.43.0




