Return-Path: <stable+bounces-113370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6B6A291E6
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 15:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97E723AC2D4
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BDC1DE4EC;
	Wed,  5 Feb 2025 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1CHG+2Fq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B91C6BE;
	Wed,  5 Feb 2025 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766730; cv=none; b=m/LeTnTUEj6vbmx7CQlPcXIvTLyWySFFPhPcNutWgsGX3Z/zntex9GAWxQnP5zZFd9V5En2aqsYC0S2tryC0Kad5ncj7irt2V8pdkxLE3xYy08zQvhAFUyiZ38n2F4qAv4hdcDWAA9a2fAarW4PnL+rStWctke0ILfIXC8IxTJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766730; c=relaxed/simple;
	bh=17UT+OddHlcRbaidDBrjqfWED6otH3vvBUDpGRz7n5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEIeFvhPYFQPvZ+hYX2yVgt1BTyKNvQe6sktk+GJ5ID5A8ALzTT2uGbHziT5Ps18LCTp0y5ojb707mur7101mhvAhwIzMX2tN7LxLQqkf3iKkxyz0ZOmPNwdhorPO/zndMQmqL3yzxnft/o8cC7BwP2lO2BoCG7EIPRPzeYo6K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1CHG+2Fq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97576C4CED1;
	Wed,  5 Feb 2025 14:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738766730;
	bh=17UT+OddHlcRbaidDBrjqfWED6otH3vvBUDpGRz7n5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1CHG+2FqX6jPIJ07JGiErkYfEAUzcCSWBSBCohAsiaoF6Oxut0cVcwym3w2jfGotG
	 XXujdnj1Q10HIJcN4Y8VMPWV9/8V9YQMTIDd+uwHIAwp4UlZLZKVpsXxrGfkKuxE2z
	 9zEHtJaKpWiZRkaye87yyNqwrFEk+pC8hbLFvBrY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christoph Anton Mitterer <calestyo@scientia.org>,
	Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.6 391/393] btrfs: output the reason for open_ctree() failure
Date: Wed,  5 Feb 2025 14:45:10 +0100
Message-ID: <20250205134435.255099051@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

commit d0f038104fa37380e2a725e669508e43d0c503e9 upstream.

There is a recent ML report that mounting a large fs backed by hardware
RAID56 controller (with one device missing) took too much time, and
systemd seems to kill the mount attempt.

In that case, the only error message is:

  BTRFS error (device sdj): open_ctree failed

There is no reason on why the failure happened, making it very hard to
understand the reason.

At least output the error number (in the particular case it should be
-EINTR) to provide some clue.

Link: https://lore.kernel.org/linux-btrfs/9b9c4d2810abcca2f9f76e32220ed9a90febb235.camel@scientia.org/
Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: stable@vger.kernel.org
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/super.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1162,7 +1162,7 @@ static int btrfs_fill_super(struct super
 
 	err = open_ctree(sb, fs_devices, (char *)data);
 	if (err) {
-		btrfs_err(fs_info, "open_ctree failed");
+		btrfs_err(fs_info, "open_ctree failed: %d", err);
 		return err;
 	}
 



