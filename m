Return-Path: <stable+bounces-39163-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60958A122F
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228C21C21C25
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BE613DDD6;
	Thu, 11 Apr 2024 10:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sw5JLMh7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F9B1E48E;
	Thu, 11 Apr 2024 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832703; cv=none; b=l5AARnkp1wXkg9cWUhbAyMVpR8hzMBTEacqminu5Ehd5yf8qnkd8fts2xQMK4oPenbye8l/xmeJYjIZ1UcQAd9XXh0xmYZD6GN3GSN8HAqEk1LogS2z/k4KLN75aNJIN550XQpPlsKLoWyjj27CapJ+TNJ6MB/4NIDoSKAUpAsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832703; c=relaxed/simple;
	bh=kCEHIVie5rxiePPeoOONuvJClzCR7pIhBSMIYlL8P44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLvCeSWwU0MDxFzLdsyg/mvlC1t/T5Kt/UvQyaygR5LxiXIT649XVMPsDD6zSLTpkth9Bm/AZjx+ar4jvpz0qHPXxhhwF8S+eFWtsHIOxW2fDE0bSSgsDxF1qjdycjUCLyTE6f42KKxp7/B3y1NTAjdTupdZB8MUIUMbhj0tk9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sw5JLMh7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A635C433C7;
	Thu, 11 Apr 2024 10:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712832702;
	bh=kCEHIVie5rxiePPeoOONuvJClzCR7pIhBSMIYlL8P44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sw5JLMh7o6ElOTyZ32dtoYz1SR5DilxNYXSRCdgRjBT2sUhhS8fmH4TZ0LNoFPgpY
	 ndmtxOPgdyArQov8oVrjesUfdq6u/Rk+FbeLxjvw3yQzjWofyt8coKeWzwl2TDn2Wl
	 Ij++LkhQ/9Mk8HE3HqB0MEd72LAmkIUpyt9Vwevw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 17/57] btrfs: send: handle path ref underflow in header iterate_inode_ref()
Date: Thu, 11 Apr 2024 11:57:25 +0200
Message-ID: <20240411095408.515375938@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095407.982258070@linuxfoundation.org>
References: <20240411095407.982258070@linuxfoundation.org>
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

From: David Sterba <dsterba@suse.com>

[ Upstream commit 3c6ee34c6f9cd12802326da26631232a61743501 ]

Change BUG_ON to proper error handling if building the path buffer
fails. The pointers are not printed so we don't accidentally leak kernel
addresses.

Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/send.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 9900f879fa346..f1ef176a64242 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -976,7 +976,15 @@ static int iterate_inode_ref(struct btrfs_root *root, struct btrfs_path *path,
 					ret = PTR_ERR(start);
 					goto out;
 				}
-				BUG_ON(start < p->buf);
+				if (unlikely(start < p->buf)) {
+					btrfs_err(root->fs_info,
+			"send: path ref buffer underflow for key (%llu %u %llu)",
+						  found_key->objectid,
+						  found_key->type,
+						  found_key->offset);
+					ret = -EINVAL;
+					goto out;
+				}
 			}
 			p->start = start;
 		} else {
-- 
2.43.0




