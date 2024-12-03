Return-Path: <stable+bounces-97125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5A59E2298
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F43283FF6
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798441F754A;
	Tue,  3 Dec 2024 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HEp8YKq+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365611F7550;
	Tue,  3 Dec 2024 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239591; cv=none; b=ZZGbw6wdR8vfoF8BPlhmY/o832LfaSx/yqEZur+lKMuUrWkkCdCJenOLnZ55MT+42TB/gvgKZXd6UBg6Bqq5YW6V9abTdd24hAt13nOWCncrWSAKYJK+urnn07H94Gh09+wdVyEzaJ4SG3VDSrcPydgotg297Gay+Wrt1dbNg3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239591; c=relaxed/simple;
	bh=9/v/4AdA0cguy491thvDgKmSucLO/NLfA9Rd54byxUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqTmHzxQrEBENIjk24DXYXo/ryDIZtCANt7WvTuHwVmBxQ4c7p/MDJ1D+gOR6khzvyXCe+MAqzet6XuIDEUpL15/MoU1R0t3ZTYfynHJlLVFvyu1/yCZlDaLNs+TTdsrdzVTiyPchrGE1t6p7nAsYfIjHU4jI2YqJ+BTA2BsmUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HEp8YKq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2961C4CECF;
	Tue,  3 Dec 2024 15:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733239591;
	bh=9/v/4AdA0cguy491thvDgKmSucLO/NLfA9Rd54byxUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HEp8YKq+rLuB9lDfKKr7bRwb0LR2ryufA2I95YA/1nzaHgFg01aSl3pYAGv5oW47m
	 KYs+ba10YRVSowWd8LSk0eexXSnNAuKsy3V+4p20s8jKONYdLyzk7N6rC312doAki2
	 ljFIBw9jJLgpGJo37BYgDs29NdK0cebROgvu+AxY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com,
	Ahmed Ehab <bottaawesome633@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 6.11 666/817] locking/lockdep: Avoid creating new name string literals in lockdep_set_subclass()
Date: Tue,  3 Dec 2024 15:43:58 +0100
Message-ID: <20241203144021.954206394@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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



