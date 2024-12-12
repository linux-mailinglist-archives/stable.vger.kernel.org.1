Return-Path: <stable+bounces-102888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1979EF4DE
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB760340605
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D046322A7F9;
	Thu, 12 Dec 2024 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qrKZz0Dg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83393229677;
	Thu, 12 Dec 2024 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022869; cv=none; b=F/JwFHpyx8mjnYXJsBiBYyA3qZ4epAU1xA7LgIhXI1b45xdWNibtJAbcYHPDn5TbHELbw3QofNEN+WLmXYQmpCxh9u84ygBTsLhNm/mXZCqqmOp9CrlrfGL84DVfMmnrSo+NcBt9Qp3Mb/qWrFsYvzODh/J8/CKTcdm21Wqtx2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022869; c=relaxed/simple;
	bh=UF+iLgOhEhSCxM/xlsWRAE33hcdX9c0uoik3Ie1oKYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aalk0Ez1nHWO0xRn2mZtqVll5AjJSrCgJ1oG194FWtBkWR4m/K4w5/txm4noV9G5xqjaa6al/BISsaYTypkmV3tozV271G++vzdjVGk89xbKNxyr6ygt/CigTLi/5u3zmVrLSnIeE5Lps815+lsAT73qZ0Ue6YM9ZNDRnXpP7r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qrKZz0Dg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FFBC4CECE;
	Thu, 12 Dec 2024 17:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022869;
	bh=UF+iLgOhEhSCxM/xlsWRAE33hcdX9c0uoik3Ie1oKYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qrKZz0Dgl9S2knOZq0Opow/5RSWe/rT3KTsHokI0sNHJD/ce/yt2NGo664nJ8I7jE
	 4Q8+z6iAIRlG97fultL2gPo+3qEfRDvV5S4pNNEr2y3MTxmNmwgrQOrS0WNpHOXGF2
	 oDSBZ4NsCKlhZrvFAZKcGniUfuJYT3ueMqd99vmg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com,
	Ahmed Ehab <bottaawesome633@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 5.15 317/565] locking/lockdep: Avoid creating new name string literals in lockdep_set_subclass()
Date: Thu, 12 Dec 2024 15:58:32 +0100
Message-ID: <20241212144324.133907395@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
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

From: Ahmed Ehab <bottaawesome633@gmail.com>

commit d7fe143cb115076fed0126ad8cf5ba6c3e575e43 upstream.

Syzbot reports a problem that a warning will be triggered while
searching a lock class in look_up_lock_class().

The cause of the issue is that a new name is created and used by
lockdep_set_subclass() instead of using the existing one. This results
in a lock instance has a different name pointer than previous registered
one stored in lock class, and WARN_ONCE() is triggered because of that
in look_up_lock_class().

To fix this, change lockdep_set_subclass() to use the existing name
instead of a new one. Hence, no new name will be created by
lockdep_set_subclass(). Hence, the warning is avoided.

[boqun: Reword the commit log to state the correct issue]

Reported-by: <syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com>
Fixes: de8f5e4f2dc1f ("lockdep: Introduce wait-type checks")
Cc: stable@vger.kernel.org
Signed-off-by: Ahmed Ehab <bottaawesome633@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/lkml/20240824221031.7751-1-bottaawesome633@gmail.com/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/lockdep.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -233,7 +233,7 @@ static inline void lockdep_init_map(stru
 			      (lock)->dep_map.lock_type)
 
 #define lockdep_set_subclass(lock, sub)					\
-	lockdep_init_map_type(&(lock)->dep_map, #lock, (lock)->dep_map.key, sub,\
+	lockdep_init_map_type(&(lock)->dep_map, (lock)->dep_map.name, (lock)->dep_map.key, sub,\
 			      (lock)->dep_map.wait_type_inner,		\
 			      (lock)->dep_map.wait_type_outer,		\
 			      (lock)->dep_map.lock_type)



