Return-Path: <stable+bounces-108423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64375A0B693
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 13:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398BB3A75E0
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 12:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B33423314D;
	Mon, 13 Jan 2025 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="eN0ku48x"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60B221ADB4
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736770624; cv=none; b=cyxYTLJ+je+02V0PI8nr3aU9wl8ifdUnbbNs4tKa4adAXy8I6NozR7abB5CfEhn6bPacm7nLVx/QHYd1y5QDvoPbXND1Myu1gJudJbm4ea3jHpbdWg1fs2A86yliJbvMU1+mSPp3mL5RqPC4rztCUIAFv5P8Xg0pvTD3hKJZ8YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736770624; c=relaxed/simple;
	bh=JTqnf/e80CIXPIp33x5xBQIDh1jPv6mKX2WB9oAnB7c=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Z6c5AOCA4/UeJYn0EVNnTu0xQOLAgocRBYcNKZUXKzuFrJgIU1wNoX78nOG6x6Z6XhIu3wxUIOg8cs79n2Yf1f4zYqTr2jAn4Uud6hFkH4cs4hxuVdAtljoFp/3KZSY/ONTwcQboXVaBDRFKFpgf5AxT2Z8N2IITaZXvMxAe+9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=eN0ku48x; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1736770309;
	bh=sBrb7Z70T4hqpTC1aFvoE+Ln99Egs7ZX72G2QLojOFs=;
	h=From:To:Cc:Subject:Date;
	b=eN0ku48xJIZ6C+/nL1UZ1IdfuDOmh8XtrWHvrfep1wO6kvnc1GnNK0yvPL2NVwkCG
	 4MRs9t2Y3S3Nqz/JiDpODRLcMztAhDi8jWZ8Qys3O5/QwVym/X4WIzgvNRTT7hGpfp
	 t/8nhV2fseBy0tfZQ0oL6+medH7MdckZZMurtvPM=
Received: from pek-blan-cn-l1.corp.ad.wrs.com ([120.244.194.130])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 2E40AE1D; Mon, 13 Jan 2025 20:11:36 +0800
X-QQ-mid: xmsmtpt1736770296tluelhfr2
Message-ID: <tencent_F25BABE1B0C2A434C8D316D5147CD849FE0A@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XqI/ev8aXN9PHJYuhUnEFIVBgn8YA9p83Bne3xG7p01D5ON8rqd
	 TSvNgY7eC/XEl4RSeNMMhYFHZWxqsE4gR9hX//0lD9uQi0XSc2VdlCGsmFBjxrdFGwr17gifAmxD
	 PM2F/cWom9yGgI3dQNCFRwCp+02o7uU2qMrttB13FHoZ1eYRoDbZ+AK4oOCxrBi6amjZwSdDKuaY
	 Bw8PrFBe53IHJVuhfHGrow0J6Z9XUXBMWRZfbzpBbyaqYEEyvW2cHqar1dinMw7k1vi+M/+V7LXM
	 sN7PL6R1preOEZzePS/3gX2NaYRCHiGEu4dSqdqF26cowr4lWgC2xRR7ISr56uaQ82s8Q17IPGZP
	 N6bZ01W89dA6pWqsE9vJWWcA5x054pN6RIqNdaxydSHlQFpdlqjtrb+eFIloXRp41ZVnJRBX2iFp
	 JzBHAw83C/EiRGFylW1UavB3mvkqNVTOlCifRIoCvtpslckk+541q+VdclDD99O/+nq0AwuPYAFR
	 Jo1GL2jE0LVmdmmfQWrWOKX5ClVuDSkjXF+ZV14W/0ZtGEXj4T8fOt1W/nFuNEHc+xu9hRc0HBPS
	 rM3f2ply2YqWhSThxe/56te3UkcajDOYFew4FAqFtXrvIVfm5WqNgc88JXkzq3WdI2bqOaigQItn
	 eH9O0FOgf3EywM4SQQ/JkFZKzH6VBDAB286mdGmnvVrWIGXseqKL6x57ZfnXBeHPbrbDfuzS61b/
	 8HGZpyDg91e+idCaeQWZCIz9NjqTDHNyZ6Ka0LEPxKEP609X24Rpx9g/r461HObFcCZchPidPs0Q
	 jOFgokTo2hictsKGVHzAbtfUu0FBovxP+SUSG+YjvxtFsczRJf2jQs29+aGl/HAfM8YLVG4wvB7K
	 YEz1Xtc0E9RpKw1/wvUEvYz9WEGTc4Yl6Vqq3BNwSZZfZigdREs97cjGGs8U9DcsUlAfupfNF8pD
	 d5JqATI/QKTrkDd/3hBpsc5ZfsgayOcf3THAWTA+Z+H15+593A7oezJ9uTCCCKXIzJguJ35jO2+L
	 wn4Fc0JFbp/mNeB4jBrCauCQbiQHtkw4Cknw/iRQevINe0TvMu
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: alvalan9@foxmail.com
To: stable@vger.kernel.org,
	surajsonawane0215@gmail.com
Cc: alvalan9@foxmail.com,
	bvanassche@acm.org,
	martin.petersen@oracle.com
Subject: [PATCH 6.1.y] scsi: sg: Fix slab-use-after-free read in sg_release()
Date: Mon, 13 Jan 2025 20:11:37 +0800
X-OQ-MSGID: <20250113121137.3482-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 drivers/scsi/sg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 12344be14232..1946cc96c172 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -390,7 +390,6 @@ sg_release(struct inode *inode, struct file *filp)
 
 	mutex_lock(&sdp->open_rel_lock);
 	scsi_autopm_put_device(sdp->device);
-	kref_put(&sfp->f_ref, sg_remove_sfp);
 	sdp->open_cnt--;
 
 	/* possibly many open()s waiting on exlude clearing, start many;
@@ -402,6 +401,7 @@ sg_release(struct inode *inode, struct file *filp)
 		wake_up_interruptible(&sdp->open_wait);
 	}
 	mutex_unlock(&sdp->open_rel_lock);
+	kref_put(&sfp->f_ref, sg_remove_sfp);
 	return 0;
 }
 
-- 
2.43.0


