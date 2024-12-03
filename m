Return-Path: <stable+bounces-97952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 612699E264C
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270742883CE
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B492F1F8912;
	Tue,  3 Dec 2024 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D6Pt94oP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7429C81ADA;
	Tue,  3 Dec 2024 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242292; cv=none; b=i1lk+hxdtfvQ4oUFsXmvoX8Qo5JA4kwn6JKzV31uF2U0++MuoB5Bf7mWs+pkwYUBr57qqkXS9e6FjhHTy/EJ99gAH+i457WK+G30FrY+fiz80cky871uEq2uqwvSuUovwO9VeJWkpikUJ+KU2VRACfvdTMvjOTB4E0mfJIQcB1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242292; c=relaxed/simple;
	bh=EOrlcYc8zIwaCeDEagkD4/6ZQXJR3qxxPQlxhrXMiqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvyI7LCnEtNJmV+Z32Mh10tN37oUxD81GZfMFdNN1hkmNy+FPqHUkHczgIuNYxk5czfsvziXQWnReozSBMGYNM1ouvYyWSu/36seh+O7bTVLp2zDiOxHaka0GdPHXCy3JXB05XWjgykPA1gPjMeuglPO7Bmg1t9joqoLopCx8nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D6Pt94oP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7829DC4CECF;
	Tue,  3 Dec 2024 16:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733242292;
	bh=EOrlcYc8zIwaCeDEagkD4/6ZQXJR3qxxPQlxhrXMiqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D6Pt94oP1kKopP70qRUGkP0r5IVasDbHSdv9scVaFT/sXfqrpeeRXhqAwe32ZbOIH
	 6TnJ4JsIHuv4qT1aLly4xjGWezWNCp3JHs3Nc88Kqvg6LXUoLWrAeEpYpnsqQ2YLtW
	 yDAuSeqoy2itPWWjbEQfkhqkUtKceSmaqWxYftOY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com,
	Ahmed Ehab <bottaawesome633@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 6.12 664/826] locking/lockdep: Avoid creating new name string literals in lockdep_set_subclass()
Date: Tue,  3 Dec 2024 15:46:31 +0100
Message-ID: <20241203144809.657031360@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
@@ -173,7 +173,7 @@ static inline void lockdep_init_map(stru
 			      (lock)->dep_map.lock_type)
 
 #define lockdep_set_subclass(lock, sub)					\
-	lockdep_init_map_type(&(lock)->dep_map, #lock, (lock)->dep_map.key, sub,\
+	lockdep_init_map_type(&(lock)->dep_map, (lock)->dep_map.name, (lock)->dep_map.key, sub,\
 			      (lock)->dep_map.wait_type_inner,		\
 			      (lock)->dep_map.wait_type_outer,		\
 			      (lock)->dep_map.lock_type)



