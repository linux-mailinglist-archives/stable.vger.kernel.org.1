Return-Path: <stable+bounces-145451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C014FABDBBF
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 16:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E5B1889B55
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 14:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CC724C061;
	Tue, 20 May 2025 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VqB+1lgB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45332472A6;
	Tue, 20 May 2025 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747750218; cv=none; b=EbjhAltbc5kl98iJ++s/1GDEyhIR9r1YqQ1Lx6zb4MXX9EyvidHAio4a8W2anI5+LW0ZOjsWWf9B28UcEnAPFJUytxXonggantY6kXAq6Hchg71/5dOOaCjPlxQZTxEfKIBiZqnXu1hXYDpwlqxpbLh0gt1/zzwHcXn1hJT7z8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747750218; c=relaxed/simple;
	bh=pNHLh8DS2lL+yQMHYaqCLZV+Iz0JxOlP+r7UCvmYTIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upZLVA3x6hfNReCIwEJxofSH7ahDeWSOsPGfjTKNfDQ+GGfcZny0vAbZJx7OiOOw9x66o3+eXnK5puCXH6/7kDeoJD7OzIso34YZj8fOiljEot7oprOqTwV1YVQME91pysMLOWpTzSDrJSOG7Vo3zP1IAuJQpoJ/Q+fey7gFFoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VqB+1lgB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531EAC4CEE9;
	Tue, 20 May 2025 14:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747750218;
	bh=pNHLh8DS2lL+yQMHYaqCLZV+Iz0JxOlP+r7UCvmYTIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VqB+1lgBekrMozQ9+ftpAlXdRXNKMEerRvPdXCTntJjT72XTsn5dUczcfU+7BiQEV
	 zglXclNqjc/CCxELiWdb+fJpYMOGbvL2t7GQ8o405GCoQHlf8Hw5rED/q0AhknJtO5
	 G8xdxVXJo5ZuUGnjqfJjeJqgNzr1tD730qKSrzwo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Anand Jain <anand.jain@oracle.com>,
	Kyoji Ogasawara <sawara04.o@gmail.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.12 081/143] btrfs: add back warning for mount option commit values exceeding 300
Date: Tue, 20 May 2025 15:50:36 +0200
Message-ID: <20250520125813.254731727@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125810.036375422@linuxfoundation.org>
References: <20250520125810.036375422@linuxfoundation.org>
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

From: Kyoji Ogasawara <sawara04.o@gmail.com>

commit 4ce2affc6ef9f84b4aebbf18bd5c57397b6024eb upstream.

The Btrfs documentation states that if the commit value is greater than
300 a warning should be issued. The warning was accidentally lost in the
new mount API update.

Fixes: 6941823cc878 ("btrfs: remove old mount API code")
CC: stable@vger.kernel.org # 6.12+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/fs.h    |    1 +
 fs/btrfs/super.c |    4 ++++
 2 files changed, 5 insertions(+)

--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -285,6 +285,7 @@ enum {
 #define BTRFS_FEATURE_INCOMPAT_SAFE_CLEAR		0ULL
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
+#define BTRFS_WARNING_COMMIT_INTERVAL	(300)
 #define BTRFS_DEFAULT_MAX_INLINE	(2048)
 
 struct btrfs_dev_replace {
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -570,6 +570,10 @@ static int btrfs_parse_param(struct fs_c
 		break;
 	case Opt_commit_interval:
 		ctx->commit_interval = result.uint_32;
+		if (ctx->commit_interval > BTRFS_WARNING_COMMIT_INTERVAL) {
+			btrfs_warn(NULL, "excessive commit interval %u, use with care",
+				   ctx->commit_interval);
+		}
 		if (ctx->commit_interval == 0)
 			ctx->commit_interval = BTRFS_DEFAULT_COMMIT_INTERVAL;
 		break;



