Return-Path: <stable+bounces-92746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 584CD9C56E7
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D7A9B43CFC
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687BE21B441;
	Tue, 12 Nov 2024 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eK0efkpA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23131215C43;
	Tue, 12 Nov 2024 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408455; cv=none; b=aA/RFDpVEJ1aDvGFmGQAkJ/WUqOhx0L1ugs/YmGkQeL4qg68rmrKu9VaKQt6AHu7Ik7LXchuwgUYYV+0q61rTaH9lrfO6C0Kx6UCNdQT1em0NJqFZp+Z7s9UHskaeFiwMvCIyF3k2uH52Romw0OxUv7DsmLHSzJAoVMBLWvDgO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408455; c=relaxed/simple;
	bh=InBU+cURALZgUANhUsW2WaVLdUhA45udin2lNQrvtg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZH59JQpiklzInEkAqaDBHrAs6znJZ+4McKhx4iawt2FUhqUyOWq9TA6rcInU8q7fbGgBVjI+jRAKIna+dWmlxza9MY56tBpqAbltijrhgyHnGwqUGStepTt/o79yBtpc3ymVtzuGl1ADaxuF5MOGmPoRY3BJW6JOolGwMDkfDIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eK0efkpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F606C4CECD;
	Tue, 12 Nov 2024 10:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731408454;
	bh=InBU+cURALZgUANhUsW2WaVLdUhA45udin2lNQrvtg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eK0efkpA9O/oO8vlTNYWOzyIS/psMzFlsaxeWfolwBRtccNIPhOEuAhM2HqC/TVEE
	 UhX39+2YLYyTZwGgw7VI6JCF/3K5paVFVMHirVADzuqimFdHiR2klMwvmlIuT0uGQs
	 fyqHgSKqD9g8orECmc9iSoEKs4J/PHg388NWU6Qg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	Haisu Wang <haisuwang@tencent.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.11 136/184] btrfs: fix the length of reserved qgroup to free
Date: Tue, 12 Nov 2024 11:21:34 +0100
Message-ID: <20241112101906.089867361@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>
References: <20241112101900.865487674@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haisu Wang <haisuwang@tencent.com>

commit 2b084d8205949dd804e279df8e68531da78be1e8 upstream.

The dealloc flag may be cleared and the extent won't reach the disk in
cow_file_range when errors path. The reserved qgroup space is freed in
commit 30479f31d44d ("btrfs: fix qgroup reserve leaks in
cow_file_range"). However, the length of untouched region to free needs
to be adjusted with the correct remaining region size.

Fixes: 30479f31d44d ("btrfs: fix qgroup reserve leaks in cow_file_range")
CC: stable@vger.kernel.org # 6.11+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Haisu Wang <haisuwang@tencent.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1599,7 +1599,7 @@ out_unlock:
 		clear_bits |= EXTENT_CLEAR_DATA_RESV;
 		extent_clear_unlock_delalloc(inode, start, end, locked_page,
 					     &cached, clear_bits, page_ops);
-		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
+		btrfs_qgroup_free_data(inode, NULL, start, end - start + 1, NULL);
 	}
 	return ret;
 }



