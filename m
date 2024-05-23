Return-Path: <stable+bounces-45691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6938CD362
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 15:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BF48B22097
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BFF13D2BD;
	Thu, 23 May 2024 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="00KBZhHC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E668314A60C;
	Thu, 23 May 2024 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470088; cv=none; b=GM+ZRtgulYtdrMvTB1OD9v/rz4tP1P1efwUNGwpkxEtY+mZNQtfru6YdDJI9A533N9mkG+gtGFixuR1R85IX9I+ESvJSTgoPH/8UskQUB3L7nkX/TeXkJrMMJt84KNs28pEggl+kRbqPZbrNTeZpo3xoVHvuyk1dIgYMX2FtTvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470088; c=relaxed/simple;
	bh=IR/J6A3a89v22PtZ0pgcoGQm6GIYf7AXAs0uGcubVwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmHgjDkmdxTRWWJHFpn0+exGpmrBK/czEYRUmEwL6Q/amLU1WAshNGpweJQA4QcUflTOB4gSBG6dc2zdXB4iKy2jJ/0mKXmFKsRLva/rutV+/p5rt1yAVmx+FYqJpyfYofT8dbviDYRemA7W8CeBW0mXcDkEs6kDDm6ZV3RZnLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=00KBZhHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F756C3277B;
	Thu, 23 May 2024 13:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716470087;
	bh=IR/J6A3a89v22PtZ0pgcoGQm6GIYf7AXAs0uGcubVwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=00KBZhHCJa1s5wgMwXULAXAmJoLCzE4Qo9TRiWhxZUv7RIB8PodtedICpS+Bi8sBF
	 vF8xfFuO7ke5+T6MIb9mOsklLCsKmURv5vVYjVxow/xWLi4OGpSkddTB9w8S+17vFm
	 5mdmgQShmt8Wr/BZ+l8+wqSL1TAXd0THhmsx3JHw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pavel Machek <pavel@denx.de>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.19 03/18] btrfs: add missing mutex_unlock in btrfs_relocate_sys_chunks()
Date: Thu, 23 May 2024 15:12:26 +0200
Message-ID: <20240523130325.862612416@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523130325.727602650@linuxfoundation.org>
References: <20240523130325.727602650@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominique Martinet <dominique.martinet@atmark-techno.com>

commit 9af503d91298c3f2945e73703f0e00995be08c30 upstream.

The previous patch that replaced BUG_ON by error handling forgot to
unlock the mutex in the error path.

Link: https://lore.kernel.org/all/Zh%2fHpAGFqa7YAFuM@duo.ucw.cz
Reported-by: Pavel Machek <pavel@denx.de>
Fixes: 7411055db5ce ("btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()")
CC: stable@vger.kernel.org
Reviewed-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/volumes.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2957,6 +2957,7 @@ again:
 			 * alignment and size).
 			 */
 			ret = -EUCLEAN;
+			mutex_unlock(&fs_info->delete_unused_bgs_mutex);
 			goto error;
 		}
 



