Return-Path: <stable+bounces-22387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 734D985DBC8
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14FFCB22335
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C304D5B7;
	Wed, 21 Feb 2024 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qJdKIoEZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3155855E5E;
	Wed, 21 Feb 2024 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523114; cv=none; b=A8xYP9AudIa2WBTGDYlrP+OKcB1NMCSokgMcYu+0ZmRHxzP9dihIKIXyboc4z5UsFNNOcUCnoMjyCVP5E1f58Btc3EjRsaPrfwaG+S9/cP8xjJFAzqOtMaeHOPSg+dcSJIA8L8DRFEC8NWLXcNoeCWJ6QoNYVOURnpELevttH1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523114; c=relaxed/simple;
	bh=JNs3ruoHMwdXzyYCg3DwxGAorY6SeI6vq4wJNgV+ZXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVedrZcwNUVbT8T5vg2y3nRdVdMGnr1Fr6akjOCDLEPM1mL6ED8NBVc1LvoKflSIKzvy1Np3oHvIr0Ot52jz8dLiSUFeFHooJqK9LOkK0X3jmt3Kv5zZnuxb1fif6xtT1lFtYAUvAb/3y33WGpryHkUJAYQNAkkhAapwrHu9gv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qJdKIoEZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987E2C433F1;
	Wed, 21 Feb 2024 13:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708523114;
	bh=JNs3ruoHMwdXzyYCg3DwxGAorY6SeI6vq4wJNgV+ZXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qJdKIoEZD5huc15UsmyMxfrS36WMrvS/C11HMaWv1aXC9+kSN/I2ztNOAI8jblHiZ
	 c5M1nUDO77806EnbdB6zzAxs86tpQYfpYEfnR6rvUk8wsP9l+DZUOm7FXUUfzbJiQN
	 80yb6NB0JBeeIQDt+HdgswxKR6HICwHAWCD4Ckts=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 5.15 344/476] btrfs: forbid creating subvol qgroups
Date: Wed, 21 Feb 2024 14:06:35 +0100
Message-ID: <20240221130020.711873919@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221130007.738356493@linuxfoundation.org>
References: <20240221130007.738356493@linuxfoundation.org>
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

From: Boris Burkov <boris@bur.io>

commit 0c309d66dacddf8ce939b891d9ead4a8e21ad6f0 upstream.

Creating a qgroup 0/subvolid leads to various races and it isn't
helpful, because you can't specify a subvol id when creating a subvol,
so you can't be sure it will be the right one. Any requirements on the
automatic subvol can be gratified by using a higher level qgroup and the
inheritance parameters of subvol creation.

Fixes: cecbb533b5fc ("btrfs: record simple quota deltas in delayed refs")
CC: stable@vger.kernel.org # 4.14+
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ioctl.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4338,6 +4338,11 @@ static long btrfs_ioctl_qgroup_create(st
 		goto out;
 	}
 
+	if (sa->create && is_fstree(sa->qgroupid)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	trans = btrfs_join_transaction(root);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);



