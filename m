Return-Path: <stable+bounces-64553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36B8941E9F
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFA52B288B0
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB74189901;
	Tue, 30 Jul 2024 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ddDXt83+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487901A76BE;
	Tue, 30 Jul 2024 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360502; cv=none; b=sxP1p3xSVga9/8SRcGFOMVeOTDBZbhaCXuDoUdIZBv4itFQbyU0MFXBaE8OsDhkTfkTG9PnIWVhdXMagFH4uJZVMDK6ajcK5Vq0scSOsquISYDxM2STWW3ScBtv2zwSFEsBchLopfU4Atjgf+GhVnc46ISAkGn1g43KAbvMOfQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360502; c=relaxed/simple;
	bh=UHaRuAaf8bVVkmbtmY+Y2l+YpZSrVi/XcKT8cyBsUvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWRJb/lE1++cqRi14/eu7s97cItEymu254K5bPTBNQJnpxn2dBKUpTXR4+FV6X3E8NGi8mV7F7/cJzw85uzK8Z+hmKFtBlIiK7U6flxipicyv2B7QGDMX3Re+l+ZNuNruk6d11FPwlREVWAFANAJAE/tzI4Fmyj+XVbYyu9xGyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ddDXt83+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0D1C4AF10;
	Tue, 30 Jul 2024 17:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722360502;
	bh=UHaRuAaf8bVVkmbtmY+Y2l+YpZSrVi/XcKT8cyBsUvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ddDXt83+dxOwghadP8+5RkA9I3/I7cIVtdVGe8CyZKuPUhWTAiI11EBJh3G++0fHy
	 493TEZIxi7oVzh0+SDbqW5XZPxJCa5dP2G6UD7Dz9yjiRjk0T/1fHh5WANmjUknPuX
	 D3b4Q94AtkJMazCqSgJGuIKedlcNa5Xr0FlRUKWE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilya Dryomov <idryomov@gmail.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: [PATCH 6.10 718/809] rbd: dont assume rbd_is_lock_owner() for exclusive mappings
Date: Tue, 30 Jul 2024 17:49:54 +0200
Message-ID: <20240730151753.297965192@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6589,11 +6589,6 @@ static int rbd_add_acquire_lock(struct r
 	if (ret)
 		return ret;
 
-	/*
-	 * The lock may have been released by now, unless automatic lock
-	 * transitions are disabled.
-	 */
-	rbd_assert(!rbd_dev->opts->exclusive || rbd_is_lock_owner(rbd_dev));
 	return 0;
 }
 



