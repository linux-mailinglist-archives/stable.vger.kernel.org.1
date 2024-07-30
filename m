Return-Path: <stable+bounces-64281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DED941D21
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747011C23B8C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9E018454A;
	Tue, 30 Jul 2024 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tYCUw60y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC9118A6B1;
	Tue, 30 Jul 2024 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359601; cv=none; b=mER4Mt14ZNs1M6enkWIC1LrjxHGajwSOrniBv9mFIjkWc/Dw3WZy1Vsr/lFkSMvABJ9x8YywHomJspaDHZ52LOW/HvEio8ACWYw6kj2fv87ZigjpoTpU4KH/IRHMkEK/I10QwPXiiwfINXNTQSmmLw+W0EvcqE12qWbuHaz4Nb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359601; c=relaxed/simple;
	bh=08xjFqdOz5x1rZ4Rh+J4ghJp16DekUWFCduZP5oNb/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRbowwLEKELWIPuC+Y9VrmatMW2eJvtVryy89g5Qw/a8Qy++dTk9H65s2bwyX35Ini5zk5e72llb2VqnR93l1OoMiWJC7yGGMNcK12r2Dgxnl6+NpFLhUf8nOxG/su+ThXJllwtiuXVTg4bA8kzZvvwZv2ppW/t7EvLPI0M7d4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tYCUw60y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD00C4AF0E;
	Tue, 30 Jul 2024 17:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722359600;
	bh=08xjFqdOz5x1rZ4Rh+J4ghJp16DekUWFCduZP5oNb/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tYCUw60ykGPDqEAdj0PVdhUnIWCiS5uscUtUkcrnPm4Itr6CgalC1/TeX0BRKoKhR
	 HhgVtp+mBL0MCWQokkGEMP4Xfzq0sX4NWhcmJDEy8kt/M7748KsM7Yd3qwNEUWDjTD
	 exlLj1XUJq6DUpjGerW0C8XIKbEUUEc6AoZPc7YE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilya Dryomov <idryomov@gmail.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: [PATCH 6.6 489/568] rbd: dont assume rbd_is_lock_owner() for exclusive mappings
Date: Tue, 30 Jul 2024 17:49:56 +0200
Message-ID: <20240730151659.144254747@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Dryomov <idryomov@gmail.com>

commit 3ceccb14f5576e02b81cc8b105ab81f224bd87f6 upstream.

Expanding on the previous commit, assuming that rbd_is_lock_owner()
always returns true (i.e. that we are either in RBD_LOCK_STATE_LOCKED
or RBD_LOCK_STATE_QUIESCING) if the mapping is exclusive is wrong too.
In case ceph_cls_set_cookie() fails, the lock would be temporarily
released even if the mapping is exclusive, meaning that we can end up
even in RBD_LOCK_STATE_UNLOCKED.

IOW, exclusive mappings are really "just" about disabling automatic
lock transitions (as documented in the man page), not about grabbing
the lock and holding on to it whatever it takes.

Cc: stable@vger.kernel.org
Fixes: 637cd060537d ("rbd: new exclusive lock wait/wake code")
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Dongsheng Yang <dongsheng.yang@easystack.cn>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/rbd.c |    5 -----
 1 file changed, 5 deletions(-)

--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -6588,11 +6588,6 @@ static int rbd_add_acquire_lock(struct r
 	if (ret)
 		return ret;
 
-	/*
-	 * The lock may have been released by now, unless automatic lock
-	 * transitions are disabled.
-	 */
-	rbd_assert(!rbd_dev->opts->exclusive || rbd_is_lock_owner(rbd_dev));
 	return 0;
 }
 



