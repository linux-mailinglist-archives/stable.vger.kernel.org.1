Return-Path: <stable+bounces-118105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9800DA3B99C
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 10:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF7157A57E4
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 09:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DC21DF75B;
	Wed, 19 Feb 2025 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="doAFeyKN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66AF1DF747;
	Wed, 19 Feb 2025 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957249; cv=none; b=K6EO9a90CuW4H5lMOJXXDHT7GTtjgcg/TzY4SjOkZH+kra5CRKPCKQuOk/uiJPdLXTfHXVQpPTLAJRVH1r0RRlzn9Fl2eMY2voBdCiVYAVdFs2T7HVfenXg3ujtj4iDQhr6QNpOWx+FaLuAo9U7MrW4Ffv3rLDZLIEPPGMQSQ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957249; c=relaxed/simple;
	bh=mcSqpvdZRYGo87BAUsaUa7cnRnopykRCFalkfI8Aerg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvXbhf7yVa2Gyzn+WXZnAHa5HWN7vTiCB3nennlqNFPJHnOUU131IhPZOIpHkHyqHAI++P4XIEiD6TM+aw6/JvRZvVKzeUI/5Z9w8zPT2E4ilSE194/QkSF1coGa7XKFIKdlQya8qmGaxgwqc8D5qbnDhqWkNiPh7VIyVUcBkPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=doAFeyKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530C4C4CED1;
	Wed, 19 Feb 2025 09:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739957249;
	bh=mcSqpvdZRYGo87BAUsaUa7cnRnopykRCFalkfI8Aerg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=doAFeyKNc/+LcorD9WhiRv/g8fecPPdvLu22EtWNTo0zVWeGvisC59iHHDiH9CorA
	 abGYrRA6gOm2fejmdiggXoiN6573OFB/4imjZhw6mAdNy3iiWI0wU95z/ruAkLGDNI
	 FNUu/+pkjpU7Zkla61+TJ70NfX8h1X1oKysCu+G4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Koichiro Den <koichiro.den@canonical.com>
Subject: [PATCH 6.1 461/578] btrfs: avoid monopolizing a core when activating a swap file
Date: Wed, 19 Feb 2025 09:27:45 +0100
Message-ID: <20250219082711.142307065@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219082652.891560343@linuxfoundation.org>
References: <20250219082652.891560343@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

commit 2c8507c63f5498d4ee4af404a8e44ceae4345056 upstream.

This commit re-attempts the backport of the change to the linux-6.1.y
branch. Commit bb8e287f596b ("btrfs: avoid monopolizing a core when
activating a swap file") on this branch was reverted.

During swap activation we iterate over the extents of a file and we can
have many thousands of them, so we can end up in a busy loop monopolizing
a core. Avoid this by doing a voluntary reschedule after processing each
extent.

CC: stable@vger.kernel.org # 5.4+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/inode.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -11368,6 +11368,8 @@ static int btrfs_swap_activate(struct sw
 		}
 
 		start += len;
+
+		cond_resched();
 	}
 
 	if (bsi.block_len)



