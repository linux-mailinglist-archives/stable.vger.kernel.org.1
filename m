Return-Path: <stable+bounces-63873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FF2941B0C
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2556C1C20E8E
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CAB18455B;
	Tue, 30 Jul 2024 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VK1hHN/K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291C9155CB3;
	Tue, 30 Jul 2024 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358227; cv=none; b=SJ1YuPsNuuHc/1os8boHjZaXbvv777Del3N1TjI6qLzyZQOcviMfxdPe50EKysDvUTnDpd+ICjvEf6j85l9OK5lkb3C8QXiQOzaF8vmwW9ytDj3k86xIQ5EqbdAr5btJT3UcE14W3GPV80Cp9Ro/Lzz7p1b/wLu2st0RdZO4Ut0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358227; c=relaxed/simple;
	bh=qokEBZjHQMH66yMTpMELwH13O0Od8+bgJkVW+z7hOCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKr/6hPwILFdI+sfuovGOjphD6KgdTo2ONdjf7J+FY1/I3tARV8PS/GntMW9RK+vMSdGjREypJBRDe/o9z04UsmpXbubH0TUb7UYIcINQJ8bYcoQqMOf9FWRCAG3Mujm5w1TSh6eUDtR5OFwSJbE8a41nv0zk+MSyJ4oKLjZSBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VK1hHN/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FB1C32782;
	Tue, 30 Jul 2024 16:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722358227;
	bh=qokEBZjHQMH66yMTpMELwH13O0Od8+bgJkVW+z7hOCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VK1hHN/KVIg0izdQ5XLaZzih7WYfNbPmYHt3G2fn2lJSs9x97QWAv8SD3YW9ork1A
	 pIteEh2eDd+NaNma4U2aLKj7NEtkCxP5THNNppprpkDDVb8RrzdWf5zBr070IzCnrl
	 dU9AZQIv+lJu6oXFjtLadgOYvcF8n3KuV7zJ7ICY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilya Dryomov <idryomov@gmail.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: [PATCH 6.1 368/440] rbd: dont assume rbd_is_lock_owner() for exclusive mappings
Date: Tue, 30 Jul 2024 17:50:01 +0200
Message-ID: <20240730151630.191402444@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
 



