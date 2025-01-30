Return-Path: <stable+bounces-111593-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38F3A22FE3
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD8D167B4D
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805411E98F3;
	Thu, 30 Jan 2025 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AoP9FMvV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBAA1E6DCF;
	Thu, 30 Jan 2025 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738247189; cv=none; b=n4eYxv08tHNgINLT9XuyCN5sX0vytfEWIR4HrvuGUZ9TyW/w5/FtG6T8EWj7dWdNQ9JbP8Tvmi8FNzLyTiVmnyU++OEqP5TsVkjXafmrTKws7upE/YtXBqddZKjhYweAO8CxioCSp9zAxjRQQtD90p879X6+XtVbk20EM2K9LJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738247189; c=relaxed/simple;
	bh=Jtq+P5jKQVDJKAQWUI9/SNXGvcFLFn5B668jWcaboxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBQs8ksKWLE295n0fkU6gc5aDZd/lwgcKk82KH2RfzYWvaQGM+xKG33hmezlXY1UiWOwlbX/NF8kzhab81Un+tnMQttmRxAJwM87Fh6oTVtIdE/D/Nn83D4z4aB5CxgZENB3/XJgnLGrO9oTjySuZMsu2ne39HahC0bOZ4ZQYMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AoP9FMvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD258C4CED2;
	Thu, 30 Jan 2025 14:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738247189;
	bh=Jtq+P5jKQVDJKAQWUI9/SNXGvcFLFn5B668jWcaboxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AoP9FMvVRL/I5DZWaxG/IIAYl1RYcR0x/GpfWZ10BlSpGTJ3B8A2Wmm/gi8McOL+M
	 4zOA0IK29HBFqWqhVbKtLUUnUT+KZjubWdfZEZ+Pysxjr5DGnVrDWiBeWjxhKHIR10
	 jVZz5zimylJUMVVEf2pRyyNs+iCzbAgAgVh6VdHU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+7efb5850a17ba6ce098b@syzkaller.appspotmail.com,
	Suraj Sonawane <surajsonawane0215@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	BRUNO VERNAY <bruno.vernay@se.com>,
	Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Subject: [PATCH 5.10 113/133] scsi: sg: Fix slab-use-after-free read in sg_release()
Date: Thu, 30 Jan 2025 15:01:42 +0100
Message-ID: <20250130140147.082961793@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130140142.491490528@linuxfoundation.org>
References: <20250130140142.491490528@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suraj Sonawane <surajsonawane0215@gmail.com>

commit f10593ad9bc36921f623361c9e3dd96bd52d85ee upstream.

Fix a use-after-free bug in sg_release(), detected by syzbot with KASAN:

BUG: KASAN: slab-use-after-free in lock_release+0x151/0xa30
kernel/locking/lockdep.c:5838
__mutex_unlock_slowpath+0xe2/0x750 kernel/locking/mutex.c:912
sg_release+0x1f4/0x2e0 drivers/scsi/sg.c:407

In sg_release(), the function kref_put(&sfp->f_ref, sg_remove_sfp) is
called before releasing the open_rel_lock mutex. The kref_put() call may
decrement the reference count of sfp to zero, triggering its cleanup
through sg_remove_sfp(). This cleanup includes scheduling deferred work
via sg_remove_sfp_usercontext(), which ultimately frees sfp.

After kref_put(), sg_release() continues to unlock open_rel_lock and may
reference sfp or sdp. If sfp has already been freed, this results in a
slab-use-after-free error.

Move the kref_put(&sfp->f_ref, sg_remove_sfp) call after unlocking the
open_rel_lock mutex. This ensures:

 - No references to sfp or sdp occur after the reference count is
   decremented.

 - Cleanup functions such as sg_remove_sfp() and
   sg_remove_sfp_usercontext() can safely execute without impacting the
   mutex handling in sg_release().

The fix has been tested and validated by syzbot. This patch closes the
bug reported at the following syzkaller link and ensures proper
sequencing of resource cleanup and mutex operations, eliminating the
risk of use-after-free errors in sg_release().

Reported-by: syzbot+7efb5850a17ba6ce098b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7efb5850a17ba6ce098b
Tested-by: syzbot+7efb5850a17ba6ce098b@syzkaller.appspotmail.com
Fixes: cc833acbee9d ("sg: O_EXCL and other lock handling")
Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
Link: https://lore.kernel.org/r/20241120125944.88095-1-surajsonawane0215@gmail.com
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: BRUNO VERNAY <bruno.vernay@se.com>
Signed-off-by: Hugo SIMELIERE <hsimeliere.opensource@witekio.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/sg.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -390,7 +390,6 @@ sg_release(struct inode *inode, struct f
 
 	mutex_lock(&sdp->open_rel_lock);
 	scsi_autopm_put_device(sdp->device);
-	kref_put(&sfp->f_ref, sg_remove_sfp);
 	sdp->open_cnt--;
 
 	/* possibly many open()s waiting on exlude clearing, start many;
@@ -402,6 +401,7 @@ sg_release(struct inode *inode, struct f
 		wake_up_interruptible(&sdp->open_wait);
 	}
 	mutex_unlock(&sdp->open_rel_lock);
+	kref_put(&sfp->f_ref, sg_remove_sfp);
 	return 0;
 }
 



