Return-Path: <stable+bounces-101030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6A89EEA2B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA37E188CCE6
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C503216E28;
	Thu, 12 Dec 2024 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qdCD7X6L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A3B215F5A;
	Thu, 12 Dec 2024 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016014; cv=none; b=DDNyC8T2LNgHL64lK51VD6qXrzpG9QghJysPmTFa0bwy1MFlpXcB5U9vRza+4vAVtculbgXKEj67z9X4GHTFdV7dIP9I5p82OjNtIRIwL5weRITsTsjgz0Iza7vF3lO87tiSEoAztICu5lRHbj+XBDTPnm1xTGzQYCkXwBZRWE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016014; c=relaxed/simple;
	bh=I/141KjWyUzlpdRZHgNSWfMGeerL4ZE2udK2uRjW54U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZngVvvPOerz7FwlnXa6JwSbWsF3I659IvBHSLRe/qxO/5yry86grzKXyykRXxDeHOpvHqb/ymwtn3bkT/F/LiMxKMWfDVra65L1Frtdo5II6Cpipu8ajxlzSmmvwvMd0h1AE+86h0q59BYg4UCzg3IacBrWX24Otyyrg7dsFug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qdCD7X6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBF7C4CED0;
	Thu, 12 Dec 2024 15:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734016013;
	bh=I/141KjWyUzlpdRZHgNSWfMGeerL4ZE2udK2uRjW54U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qdCD7X6LfblNdZ436v5Xcx57n3dCjdADR+QLHYDpWfNSPDoBUZZFBn8dl4A/gxvwm
	 GOlqUBLdQPV3/YVVmreWvggx9KHuOdO7rxJVcDoIIV+lU4EFXTNBNFMByXEt85asio
	 ZFHkmy74nA1A2JsxSrdXgrfZ75nTE8ta7xsiBWto=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+7efb5850a17ba6ce098b@syzkaller.appspotmail.com,
	Suraj Sonawane <surajsonawane0215@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 108/466] scsi: sg: Fix slab-use-after-free read in sg_release()
Date: Thu, 12 Dec 2024 15:54:37 +0100
Message-ID: <20241212144311.086141528@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
References: <20241212144306.641051666@linuxfoundation.org>
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

From: Suraj Sonawane <surajsonawane0215@gmail.com>

[ Upstream commit f10593ad9bc36921f623361c9e3dd96bd52d85ee ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/sg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 84334ab39c810..94127868bedf8 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -386,7 +386,6 @@ sg_release(struct inode *inode, struct file *filp)
 	SCSI_LOG_TIMEOUT(3, sg_printk(KERN_INFO, sdp, "sg_release\n"));
 
 	mutex_lock(&sdp->open_rel_lock);
-	kref_put(&sfp->f_ref, sg_remove_sfp);
 	sdp->open_cnt--;
 
 	/* possibly many open()s waiting on exlude clearing, start many;
@@ -398,6 +397,7 @@ sg_release(struct inode *inode, struct file *filp)
 		wake_up_interruptible(&sdp->open_wait);
 	}
 	mutex_unlock(&sdp->open_rel_lock);
+	kref_put(&sfp->f_ref, sg_remove_sfp);
 	return 0;
 }
 
-- 
2.43.0




